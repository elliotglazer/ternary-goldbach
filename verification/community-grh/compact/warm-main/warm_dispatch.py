#!/usr/bin/env python3
"""Queue one immutable diagnostic on the retained AWS stack, optionally starting the existing host."""
import argparse
import base64
import datetime
import hashlib
import io
import json
import os
from pathlib import Path
import re
import shlex
import subprocess
import sys
import tarfile
import time
import urllib.request

import warm_supervisor as worker

HOST="i-0e7d3f1a40dbca69c"
STACK="tg-grh-source-replay"
LOCAL=Path(__file__).resolve().parent
FILES=("warm_supervisor.py","warm_main.py","WarmArtifactHashes.lean","warm_probe.py")
ROOT="/var/lib/tg-warm-main"
QUEUE=str(worker.QUEUE)
SCHEDULE="at(2026-11-26T10:17:24)"
PROPERTIES="--property=CPUQuota=1600% --property=MemoryHigh=48G --property=MemoryMax=64G --property=MemorySwapMax=0 --property=TasksMax=4096 --property=LimitSTACK=infinity --property=LimitNOFILE=1048576 --property=OOMPolicy=continue --property=TimeoutStopSec=15"
GUARDS=r"""
set -eu
active() { s=$(systemctl show -p ActiveState --value "$1" 2>/dev/null || :); case "$s" in inactive|failed) return 1;; *) return 0;; esac; }
cold_idle() { ! active tg-source-replay.service && ! active tg-joint-replay.service && ! active tg-warm-patch-probe.service; }
warm_idle() { ! active tg-warm-main.service; }
"""


def need(ok,text):
    if not ok:raise ValueError(text)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def aws(*args):
    return json.loads(subprocess.check_output(["aws","--region","us-east-1","--no-cli-pager","--output","json",
                    "--cli-connect-timeout","8","--cli-read-timeout","22",*args],timeout=34) or b"{}")


def ssm(command,seconds=75):
    req=aws("ssm","send-command","--instance-ids",HOST,"--document-name","AWS-RunShellScript","--timeout-seconds","60",
            "--parameters",json.dumps({"commands":[command],"executionTimeout":[str(seconds)]}))
    cid=req["Command"]["CommandId"]
    for _ in range(seconds//2+15):
        rows=aws("ssm","list-command-invocations","--command-id",cid)["CommandInvocations"]
        if rows and rows[0]["Status"] not in {"Pending","InProgress","Delayed","Cancelling"}:
            r=aws("ssm","get-command-invocation","--command-id",cid,"--instance-id",HOST)
            need(r["Status"]=="Success" and r["ResponseCode"]==0,
                 cid+" "+r["Status"]+" "+r.get("StandardErrorContent","")[-800:]+" "+r.get("StandardOutputContent","")[-400:])
            return r["StandardOutputContent"].strip()
        time.sleep(2)
    raise ValueError("Existing SSM command still pending "+cid)


def validate_cloud():
    outputs=aws("cloudformation","describe-stacks","--stack-name",STACK)["Stacks"][0]["Outputs"]
    info={row["OutputKey"]:row["OutputValue"] for row in outputs}
    need(info["Instance"]==HOST and re.fullmatch(r"vol-[0-9a-f]{17}",info["Evidence"]),"Wrong stack instance or volume")
    volume=info["Evidence"]
    host=aws("ec2","describe-instances","--instance-ids",HOST)["Reservations"][0]["Instances"][0]
    need(host["InstanceId"]==HOST and host["InstanceType"]=="r7i.8xlarge" and
         volume in [b["Ebs"]["VolumeId"] for b in host["BlockDeviceMappings"]],"Wrong EC2 host or attached volume")
    disk=aws("ec2","describe-volumes","--volume-ids",volume)["Volumes"][0]
    need(disk["VolumeId"]==volume and disk["Size"]==600 and any(
         v["InstanceId"]==HOST and v["State"]=="attached" for v in disk["Attachments"]),"Wrong retained 600-GiB disk")
    schedule=aws("cloudformation","describe-stack-resource","--stack-name",STACK,"--logical-resource-id","Deadline")["StackResourceDetail"]
    entry=aws("scheduler","get-schedule","--name",schedule["PhysicalResourceId"].split("/")[-1])
    need(entry["State"]=="ENABLED" and entry["ScheduleExpression"]==SCHEDULE and
         entry.get("ScheduleExpressionTimezone","UTC")=="UTC" and entry["Target"]["Arn"].endswith("aws-sdk:ec2:stopInstances") and
         json.loads(entry["Target"]["Input"])["InstanceIds"]==[HOST],"Original fixed same-instance stop changed")
    need(time.time()+360<worker.DEADLINE,"Fewer than six minutes before original forced shutdown")
    return host["State"]["Name"],volume


def public_candidate(commit,tree):
    url="https://api.github.com/repos/elliotglazer/ternary-goldbach/git/commits/"+commit
    with urllib.request.urlopen(urllib.request.Request(url,headers={"User-Agent":"TG-warm-diagnostic"}),timeout=20) as r:
        data=json.load(r)
    need(data["sha"]==commit and data["tree"]["sha"]==tree,"Published source and tree differ")


def archive():
    manifest=json.loads((LOCAL/"warm-host-hashes.json").read_bytes())
    need(set(manifest)==set(FILES),"Local helper manifest file set mismatch")
    buf=io.BytesIO()
    with tarfile.open(fileobj=buf,mode="w",format=tarfile.GNU_FORMAT) as out:
        for name in FILES:
            data=(LOCAL/name).read_bytes()
            need(sha(data)==manifest[name],"Incorrect local host helper "+name)
            member=tarfile.TarInfo(name)
            member.mode=0o444
            member.size=len(data)
            out.addfile(member,io.BytesIO(data))
    import gzip
    return gzip.compress(buf.getvalue(),mtime=0)


def enqueue_shell(job,volume,bundle,token):
    encoded=base64.b64encode(json.dumps(job,sort_keys=True).encode()).decode()
    serial=volume.replace("-","")
    need(re.fullmatch("vol[0-9a-f]{17}",serial) and worker.DIGEST.fullmatch(bundle),"Unsafe resource IDs")
    install=ROOT+"/bundles/"+bundle
    script=GUARDS+f'''
cold_idle || {{ echo 'Cold or separate patch replay already active' >&2; exit 75; }}
test -f /var/lib/cloud/instance/sem/config_scripts_user
mountpoint -q /work
dev=$(findmnt -n -o SOURCE --target /work)
test "$(lsblk -dnro SERIAL "$dev" | tr -d '[:space:]-')" = {serial}
test "$(date +%s)" -lt {worker.DEADLINE-180}
test -d {install}
test -f {install}/warm_supervisor.py
test "$(df -B1 --output=avail /work | tail -1)" -ge 21474836480
if ! iptables -C OUTPUT -m owner --uid-owner grhreplay -d 169.254.169.254 -j REJECT 2>/dev/null; then
  iptables -I OUTPUT -m owner --uid-owner grhreplay -d 169.254.169.254 -j REJECT
fi
test "$(cat /proc/sys/vm/max_map_count)" -ge 1048576 || sysctl -w vm.max_map_count=1048576
touch /run/lock/tg-joint-worker.lock
chmod 0644 /run/lock/tg-joint-worker.lock
test ! -L {QUEUE}
install -d -m 0755 {QUEUE} {QUEUE}/pending {QUEUE}/claimed {QUEUE}/jobs
test ! -L /work/tg-warm-diagnostics
install -d -m 0755 -o grhreplay -g grhreplay /work/tg-warm-diagnostics
setpriv --reuid=grhreplay --regid=grhreplay --init-groups -- test -r {install}/warm_main.py
boot=$(cat /proc/sys/kernel/random/boot_id)
exec 7>/run/lock/tg-warm-main-queue.lock
flock -x 7
if test -f {QUEUE}/closed && test "$(cat {QUEUE}/closed)" = "$boot"; then echo 'Warm host is already closing' >&2; exit 75; fi
if test -f {QUEUE}/active-bundle && test "$(cat {QUEUE}/active-bundle)" != {bundle} && ! warm_idle; then echo 'Other warm supervisor version active' >&2; exit 75; fi
if test -f {QUEUE}/claimed/{token}.json || test -f {QUEUE}/pending/{token}.json; then echo 'Existing immutable job {token}'; else
  printf '%s' '{encoded}' | base64 -d >{QUEUE}/pending/{token}.tmp
  mv {QUEUE}/pending/{token}.tmp {QUEUE}/pending/{token}.json
fi
if warm_idle; then
  printf '%s' '{bundle}' > {QUEUE}/active-bundle
  runtime=$(({worker.DEADLINE}-$(date +%s)-45))
  test "$runtime" -gt 100
  systemd-run --collect --unit=tg-warm-main {PROPERTIES} --property="RuntimeMaxSec=$runtime" -- /usr/bin/python3 -B {install}/warm_supervisor.py
fi
printf 'Queued %s result %s\\n' {token} {QUEUE}/jobs/{token}/status.json
'''
    return "flock -x /run/lock/tg-joint-dispatch.lock sh -ec "+shlex.quote(script)


def ensure_online():
    for _ in range(72):
        rows=aws("ssm","describe-instance-information","--filters","Key=InstanceIds,Values="+HOST)["InstanceInformationList"]
        if any(row["InstanceId"]==HOST and row["PingStatus"]=="Online" for row in rows):
            return
        if time.time()+180>=worker.DEADLINE:break
        time.sleep(5)
    raise ValueError("No online SSM agent on original instance")


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--commit",required=True)
    p.add_argument("--tree",required=True)
    p.add_argument("--check",nargs=2,action="append",default=[],metavar=("MODULE","SHA256"))
    p.add_argument("--probes-only",action="store_true")
    p.add_argument("--start-existing",action="store_true",help="permit starting the one original stopped instance")
    p.add_argument("--nonce",default="",help="optional alphanumeric retry label; identical submissions are deduplicated")
    a=p.parse_args()
    need(re.fullmatch("[A-Za-z0-9_-]{0,40}",a.nonce),"invalid retry label")
    job={"commit":a.commit,"tree":a.tree,"receipt_sha":worker.PARENT_SHA,"checks":a.check,"main":not a.probes_only}
    job["token"]=sha(json.dumps([job,a.nonce],sort_keys=True).encode())[:32]
    worker.validate_request(job)
    public_candidate(a.commit,a.tree)
    payload=archive()
    identity=sha(payload)
    state,volume=validate_cloud()
    need(state=="running" or state=="stopped" and a.start_existing,"Already-running original host or --start-existing required")
    started=False
    try:
        if state=="stopped":
            aws("ec2","start-instances","--instance-ids",HOST)
            started=True
        ensure_online()
        stage="/run/tg-warm-upload-"+os.urandom(16).hex()
        target=ROOT+"/bundles/"+identity
        exists=ssm("test -f "+target+"/warm_supervisor.py && echo yes || echo no")
        if exists!="yes":
            ssm("install -d -m 0700 "+stage)
            encoded=base64.b64encode(payload).decode()
            for i in range(0,len(encoded),9000):
                ssm("printf %s "+encoded[i:i+9000]+" > "+stage+f"/{i:08d}.b64")
            # Each upload directory is private and root-owned. Shared bundle installation is atomic.
            unpack=f'''
set -eu
cat {stage}/*.b64 | base64 -d >{stage}/bundle.tgz
echo '{identity}  {stage}/bundle.tgz' | sha256sum -c -
install -d -m 0755 {ROOT} {ROOT}/bundles
if ! test -d {target}; then
 d=$(mktemp -d {ROOT}/bundles/.install.XXXXXXXX); chmod 0755 "$d"
 tar -xzf {stage}/bundle.tgz -C "$d" --no-same-owner
 mv -T "$d" {target}
fi
'''
            ssm("flock -x /run/lock/tg-warm-install.lock sh -ec "+shlex.quote(unpack))
        checks=json.loads((LOCAL/"warm-host-hashes.json").read_bytes())
        verify="cd "+target+" && "+ " && ".join("echo '"+digest+"  "+name+"' | sha256sum -c -" for name,digest in sorted(checks.items()))
        ssm(verify)
        print(ssm(enqueue_shell(job,volume,identity,job["token"])),flush=True)
        print("Existing instance",HOST,"hard stop",SCHEDULE,"idle grace seconds",worker.IDLE)
    except BaseException:
        if started:
            try:
                idle=GUARDS+"if cold_idle && warm_idle; then systemctl --no-block poweroff; fi"
                ssm("flock -x /run/lock/tg-joint-dispatch.lock sh -ec "+shlex.quote(idle),20)
            except Exception:
                print("No confirmed idle cleanup. Original external stop is still armed.",file=sys.stderr)
        raise


if __name__=="__main__":
    try:
        main()
    except (ValueError,KeyError,OSError,subprocess.CalledProcessError) as error:
        sys.exit("Warm dispatch failed: "+str(error))
