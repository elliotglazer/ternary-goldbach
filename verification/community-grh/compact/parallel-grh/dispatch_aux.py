#!/usr/bin/env python3
"""Dispatch or inspect one low-priority GRH diagnostic alongside the existing finite runner."""
import argparse
import base64
import hashlib
import importlib
import json
from pathlib import Path
import re
import shlex
import sys
import tempfile
import urllib.request

BOOTSTRAP="0b4f8c36092d95240e4ee5f0c2e68d1ec8b25c39"
BASE="https://raw.githubusercontent.com/elliotglazer/ternary-goldbach"
SUBDIR="verification/community-grh/compact"
ARCHIVE="7fbff13828b3b603791db491b6e5d81ff82d00c54bb3b05af90e8868cb058743"
HELPERS={"warm_dispatch.py":"3b332604b176e351566374c12f11851c0f3fcd5f62bd6d0a7309b2f1e7d2ffb3",
         "warm_supervisor.py":"37a6b50079fdf31ffc2a075c3dc5b448f83307f1cc3e0e6a2f121a2e0b918c0c"}
BASE_RECEIPT="5eca91028a75f56c21abfe6c9d189e5f2d02d2b6fc08997172dd2187eced650c"
OLD="33006912706042b49c1ddbc13515a4fb"
DEADLINE=1795688244
LINEAGE=["0c296855616fd2f1d288aae9c2f27f55","c5b595a6ca6bc4f7ef9ada59593b9a26","cc2ba2e764eca88b6ed1ad9d08d1cad7"]

def payload(mode,release,commit,tree,nonce,volume,previous=None):
    if not (all(re.fullmatch("[0-9a-f]{40}",i) for i in [release,commit,tree]) and re.fullmatch("[a-zA-Z0-9_-]{1,40}",nonce) and re.fullmatch("vol-[0-9a-f]{17}",volume)):
        raise ValueError("Expected immutable IDs and a safe retry label")
    lineage=LINEAGE if previous is None else previous
    if len(lineage)>8 or len(set(lineage))!=len(lineage) or not all(re.fullmatch("[0-9a-f]{32}",i) for i in lineage):
        raise ValueError("Expected at most eight distinct, explicitly listed previous +Main tokens")
    job={"commit":commit,"tree":tree,"checks":[],"main":True,"root":"Main","receipt_sha":BASE_RECEIPT,"previous_jobs":lineage}
    job["token"]=hashlib.sha256(json.dumps(["parallel-grh",job,nonce],sort_keys=True).encode()).hexdigest()[:32]
    token=job["token"]
    state="/var/lib/tg-grh-aux-"+ARCHIVE[:12]
    result="/var/lib/tg-warm-main/session-"+OLD+"/jobs/"+token
    unit="tg-warm-grh-aux"
    head=f"""set -euo pipefail
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022
mountpoint -q /work
dev=$(findmnt -n -o SOURCE --target /work)
[[ $(lsblk -dnro SERIAL "$dev" | tr -d '[:space:]-') == '{volume.replace("-","")}' ]]
state={state}
record={result}
unit={unit}
"""
    if mode=="status":
        body=head+f"""systemctl show "$unit.service" -p ActiveState -p Result || :
printf '%s\n' 'token {token}'
if [[ -f $record/status.json ]]; then cat "$record/status.json"; fi
log=/work/tg-warm-diagnostics/{commit}-{token}/warm-main.log
if [[ -f $log ]]; then tail -c 2000 "$log"; fi
if [[ -f $state/{token}.console ]]; then tail -c 1200 "$state/{token}.console"; fi
"""
        return token,"/bin/bash -c "+shlex.quote(body)
    if mode!="start":
        raise ValueError("Unknown operation")
    encoded=base64.b64encode(json.dumps(job,sort_keys=True).encode()).decode()
    body=head+f"""left=$(({DEADLINE}-$(date -u +%s)-45))
((left>390))
((left<=2100)) || left=2100
exec 8>/run/lock/tg-grh-aux-install.lock
flock -xn 8
if [[ -d $record ]]; then echo 'Existing immutable job {token}'; exit 0; fi
if ! systemctl is-active --quiet tg-warm-main.service && ! systemctl is-active --quiet tg-binary-7ef89daf.service; then echo "No prospective finite worker"; exit 75; fi
if systemctl is-active --quiet "$unit.service"; then echo 'An auxiliary job is already active'; exit 75; fi
for s in tg-source-replay tg-joint-replay tg-warm-patch-probe; do
  if systemctl is-active --quiet "$s.service"; then echo "Conflicting cold or probe job $s"; exit 75; fi
done
[[ $(df -B1 --output=avail /work | tail -1) -ge 25769803776 ]]
iptables -C OUTPUT -m owner --uid-owner grhreplay -d 169.254.169.254 -j REJECT
[[ -f /run/lock/tg-joint-dispatch.lock ]]
if [[ ! -e $state && ! -L $state ]]; then mkdir -m 0755 "$state"; fi
[[ -d $state && ! -L $state && $(stat -c %u:%a "$state") == 0:755 ]]
archive=$(mktemp "$state/bundle-XXXXXXXX")
curl -fsSL --proto '=https' --tlsv1.2 --max-time 50 --retry 2 '{BASE}/{release}/{SUBDIR}/parallel-grh/tg-parallel-grh.tgz' -o "$archive"
printf '%s  %s\n' '{ARCHIVE}' "$archive" | sha256sum -c --quiet -
helper=$(mktemp -d "$state/helpers-XXXXXXXX")
chmod 0755 "$helper"
tar --no-same-owner -xzf "$archive" -C "$helper" run_aux.py warm_main.py warm_supervisor.py WarmArtifactHashes.lean
printf '%s' '{encoded}' | base64 -d > "$helper/job.json"
chmod 0444 "$helper/job.json"
/usr/bin/python3 -B "$helper/run_aux.py" --preflight "$helper/job.json"
systemd-run --quiet --collect --unit="$unit" --property=CPUQuota=800% --property=CPUWeight=20 --property=IOWeight=20 \
 --property=Nice=10 --property=MemoryHigh=32G --property=MemoryMax=40G --property=MemorySwapMax=0 --property=TasksMax=1024 \
 --property=LimitSTACK=infinity --property=LimitNOFILE=1048576 --property=KillMode=control-group \
 --property="RuntimeMaxSec=$left" --property=TimeoutStopSec=15 --property="StandardOutput=append:$state/{token}.console" \
 --property="StandardError=append:$state/{token}.console" -- /usr/bin/python3 -B "$helper/run_aux.py" "$helper/job.json"
printf 'Auxiliary GRH diagnostic admitted for service-level checks, token %s.\n' '{token}'
"""
    return token,"/bin/bash -c "+shlex.quote(body)

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("mode",choices=("start","status"))
    for field in ("release","commit","tree"): p.add_argument("--"+field,required=True)
    p.add_argument("--nonce",default="one")
    p.add_argument("--previous-job",action="append",default=None,help="Approved complete +Main token, oldest first. Repeat at most eight times. Providing this option replaces the three original defaults.")
    args=p.parse_args();sys.dont_write_bytecode=True
    with tempfile.TemporaryDirectory(prefix="tg-grh-parallel-") as tmp:
        for name,sha in HELPERS.items():
            with urllib.request.urlopen(f"{BASE}/{BOOTSTRAP}/{SUBDIR}/warm-main/incremental/{name}",timeout=30) as r:
                data=r.read(240000)
            if hashlib.sha256(data).hexdigest()!=sha:raise ValueError("Wrong operator helper digest")
            (Path(tmp)/name).write_bytes(data)
        sys.path.insert(0,tmp);warm=importlib.import_module("warm_dispatch")
        if warm.SCHEDULE!="at(2026-11-26T10:17:24)" or warm.worker.DEADLINE!=DEADLINE:raise ValueError("Wrong original stop")
        state,vol=warm.validate_cloud()
        if state!="running":raise ValueError("Retained instance must already be running")
        token,cmd=payload(args.mode,args.release,args.commit,args.tree,args.nonce,vol,args.previous_job)
        if args.mode=="start":
            warm.public_candidate(args.commit,args.tree)
        print("token",token,flush=True)
        print(warm.ssm(cmd))
if __name__=="__main__":
    main()
