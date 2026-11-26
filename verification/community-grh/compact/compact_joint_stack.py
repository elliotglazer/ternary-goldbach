#!/usr/bin/env python3
"""Start the compact 4.35 GRH source build on the existing retained-volume stack."""
import argparse
import base64
import datetime as dt
import gzip
import hashlib
import json
from pathlib import Path
import re
import shlex
import subprocess
import time
import uuid
import urllib.request

REGION='us-east-1'
ORIGINAL='8d5d2316fd2b2865037aa8d5b820c17217e1b6771cf34d7373886c6a74090592'
RECOVERY='d9b3b1a3b1b4a97e7766349c0c6dfcc5e0eab6071935321482d2d91bdbaccf67'

def aws(service,action,*args):
    cmd=['aws','--region',REGION,'--no-cli-pager','--output','json','--cli-connect-timeout','8','--cli-read-timeout','20',service,action,*args]
    return json.loads(subprocess.check_output(cmd,timeout=32) or b'{}')


GUARDS="""unit_busy() {
  if systemctl -q is-active "$1"; then return 0; fi
  state=$(systemctl show -p ActiveState --value "$1" 2>/dev/null) || :
  case "$state" in inactive|failed) return 1;; *) return 0;; esac
}
no_workers() {
  if unit_busy tg-source-replay.service || unit_busy tg-joint-replay.service; then
    printf '%s\\n' 'Refusing active or transitioning source/joint service' >&2
    return 75
  fi
  return 0
}
"""

def public_pin(commit, tree, modules=()):
    url='https://api.github.com/repos/elliotglazer/ternary-goldbach/git/commits/'+commit
    with urllib.request.urlopen(urllib.request.Request(url,headers={'User-Agent':'Goldbach-source-replay'}),timeout=25) as resp:
        record=json.load(resp)
    if record['sha']!=commit or record['tree']['sha']!=tree:
        raise SystemExit('Published candidate commit and tree differ; no account changes')
    if not modules:
        return
    tree_url = f'https://api.github.com/repos/elliotglazer/ternary-goldbach/git/trees/{tree}?recursive=1'
    request = urllib.request.Request(tree_url, headers={'User-Agent': 'Goldbach-source-replay'})
    with urllib.request.urlopen(request, timeout=25) as response:
        contents = json.load(response)
    if contents.get('sha') != tree or contents.get('truncated') is not False:
        raise SystemExit('Published source tree incomplete; no account changes')
    files = {entry['path'] for entry in contents['tree']
             if entry['type'] == 'blob' and entry['mode'] in ('100644', '100755')}
    for module in modules:
        path = module.replace('.', '/') + '.lean'
        if sum(candidate in files for candidate in (path, 'CompactGRH/src/' + path)) != 1:
            raise SystemExit(f'Published early target missing or ambiguous: {module}; no account changes')

def main():
    a=argparse.ArgumentParser(description=__doc__)
    a.add_argument('--stack',default='tg-grh-source-replay')
    a.add_argument('--commit',required=True,help='reviewed compact joint package Git commit')
    a.add_argument('--tree',required=True,help='reviewed full Git tree of that commit')
    a.add_argument('--shard-main',action='store_true')
    a.add_argument('--lake-threads', type=int, choices=range(1, 33), metavar='N',
                   help='set LEAN_NUM_THREADS only for candidate source compilation (1..32)')
    a.add_argument('--profile',choices=('palomar-32x64','full'),default='palomar-32x64')
    a.add_argument('--extra-paranoid',action='store_true')
    a.add_argument('--preflight-module', action='append', default=[], metavar='MODULE',
                        help='early ordinary source-build target; may be repeated')
    args=a.parse_args()
    if (len(args.preflight_module) > 32 or len(set(args.preflight_module)) != len(args.preflight_module)
            or sum(map(len, args.preflight_module)) > 1800
            or any(len(module) > 160 or not re.fullmatch(r'[A-Za-z_][A-Za-z_0-9]*(?:\.[A-Za-z_][A-Za-z_0-9]*)*', module)
                   for module in args.preflight_module)):
        a.error('expected up to 32 distinct, dotted Lean module names (maximum 1800 characters total)')
    if not all(re.fullmatch('[0-9a-f]{40}',v) for v in (args.commit,args.tree)):a.error('both package pins must be full Git IDs')
    helper=Path(__file__).resolve().with_name('compact_joint.py')
    payload=helper.read_bytes()
    if (
        hashlib.sha256(payload).hexdigest()!=RECOVERY
        or b'72fead102f663d5c7a407964a13dc0cf9d977207' not in payload
        or b'b834f80c6399db99d54ce171ba541c4a95a4f90f' not in payload
        or b'56a005855ea17e0b0958f73ec801ae140b0a1679' not in payload
    ):raise SystemExit('Recovery helper digest mismatch before account access')
    public_pin(args.commit, args.tree, args.preflight_module)
    stack=aws('cloudformation','describe-stacks','--stack-name',args.stack)['Stacks'][0]
    info={v['OutputKey']:v['OutputValue'] for v in stack['Outputs']};i=info['Instance'];volume=info['Evidence']
    host=aws('ec2','describe-instances','--instance-ids',i)['Reservations'][0]['Instances'][0]
    state=host['State']['Name']
    if state!='stopped' or host['InstanceType']!='r7i.8xlarge' or volume not in [b['Ebs']['VolumeId'] for b in host['BlockDeviceMappings']]:
        raise SystemExit('Wrong state, host type or data volume; no account changes')
    disk=aws('ec2','describe-volumes','--volume-ids',volume)['Volumes'][0]
    if disk['Size']!=600 or not any(t['InstanceId']==i and t['State']=='attached' for t in disk['Attachments']):raise SystemExit('Unexpected evidence disk')
    sched=aws('cloudformation','describe-stack-resource','--stack-name',args.stack,'--logical-resource-id','Deadline')['StackResourceDetail']['PhysicalResourceId'].split('/')[-1]
    sd=aws('scheduler','get-schedule','--name',sched)
    cutoff=dt.datetime.fromisoformat(sd['ScheduleExpression'][3:-1]).replace(tzinfo=dt.timezone.utc)
    if cutoff > dt.datetime.now(dt.timezone.utc)+dt.timedelta(hours=12,minutes=1):raise SystemExit('Unexpected extended deadline; no restart')
    if not sd['Target']['Arn'].endswith('aws-sdk:ec2:stopInstances') or sd.get('ScheduleExpressionTimezone','UTC')!='UTC' or not sd['ScheduleExpression'].startswith('at(') or sd['State']!='ENABLED' or json.loads(sd['Target']['Input']).get('InstanceIds')!=[i] or cutoff<dt.datetime.now(dt.timezone.utc)+dt.timedelta(minutes=12):
        raise SystemExit('Original same-instance stop is disabled/expired/too close; no restart')
    print('Existing instance',i,'volume',volume,'original UTC stop',cutoff.isoformat(),flush=True)
    end=time.monotonic()+660
    def timeleft():
        if time.monotonic()>end:raise TimeoutError('diagnostic window expired')
    def read(command,timeout=30):
        timeleft()
        cid=aws('ssm','send-command','--instance-ids',i,'--document-name','AWS-RunShellScript','--timeout-seconds','60','--parameters',json.dumps({'commands':['set -eu\n'+command],'executionTimeout':[str(timeout)]}))['Command']['CommandId']
        for _ in range(timeout//2+15):
            timeleft()
            inv=aws('ssm','list-command-invocations','--command-id',cid,'--details')['CommandInvocations']
            if inv and inv[0]['Status'] not in ('Pending','InProgress','Delayed'):
                plugin=inv[0]['CommandPlugins'][0]
                if inv[0]['Status']!='Success':raise RuntimeError('SSM diagnostic failed: '+plugin.get('Output','')[:600])
                return aws('ssm','get-command-invocation','--command-id',cid,'--instance-id',i)['StandardOutputContent'].strip()
            time.sleep(2)
        raise TimeoutError('SSM diagnostic command timeout')

    started=False; handed=False
    try:
        if state=='stopped':
            started=True;aws('ec2','start-instances','--instance-ids',i)
        while True:
            timeleft()
            managed=aws('ssm','describe-instance-information','--filters','Key=InstanceIds,Values='+i)['InstanceInformationList']
            if managed and managed[0]['PingStatus']=='Online':
                try:
                    if read('printf online')=='online':break
                except subprocess.CalledProcessError:pass
            time.sleep(5)
        serial=volume.replace('-','')
        pre=GUARDS+"\nno_workers || exit 75\n"+f"""
test -f /var/lib/cloud/instance/sem/config_scripts_user
mountpoint -q /work
dev=$(findmnt -n -o SOURCE --target /work)
test "$(lsblk -dnro SERIAL "$dev" | tr -d '[:space:]-')" = '{serial}'
echo '{ORIGINAL}  /work/runner/grh_source.py' | sha256sum -c -
test "$(df -B1 --output=avail /work | tail -1)" -ge 112742891520
test -f /work/replay/evidence/receipt.json
"""
        print(read(pre),flush=True)
        token=uuid.uuid4().hex; stage='/root/tg-upload/recovery-'+token
        read('install -d -m 0700 '+stage)
        data=base64.b64encode(gzip.compress(payload,mtime=0)).decode()
        for k in range(0,len(data),9000):read(f'printf %s {data[k:k+9000]} > {stage}/{k:08d}.b64')
        installed='/work/runner/compact-joint-'+RECOVERY[:16]+'.py'
        driver=DRIVER.replace('@GUARD@',GUARDS).replace('@HELPER@',installed).replace('@COMMIT@',args.commit).replace('@TREE@',args.tree).replace('@SHARD@','--shard-main' if args.shard_main else '').replace('@ATTEMPT@',token).replace('@PROFILE@',args.profile).replace('@PARANOID@','--advisory-paranoid' if args.extra_paranoid else '').replace('@THREADS@','32' if args.profile=='palomar-32x64' else '12')
        project_threads = '' if args.lake_threads is None else f'--lake-threads {args.lake_threads}'
        driver = driver.replace('@PROJECT_THREADS@', project_threads)
        early_targets = ' '.join('--preflight-module ' + module for module in args.preflight_module)
        driver = driver.replace('@EARLY_TARGETS@', early_targets)
        code=base64.b64encode(driver.encode()).decode()
        properties=f"--property=MemoryHigh={64*2**30*95//100} --property=MemoryMax={64*2**30*98//100} --property=MemorySwapMax=0 --property=CPUQuota=3200% --property=TasksMax=32768 --property=LimitNOFILE=1048576 --property=LimitFSIZE=1099511627776 --property=OOMPolicy=continue" if args.profile=='palomar-32x64' else ""
        dispatch=pre+f"""
cat {stage}/*.b64 | base64 -d | gzip -d >{stage}/runner
echo '{RECOVERY}  {stage}/runner' | sha256sum -c -
install -m 0555 {stage}/runner {installed}
echo '{code}' | base64 -d > {stage}/launch
chmod 0555 {stage}/launch
no_workers || exit 75
if [ "$(systemctl show --property=ActiveState --value tg-source-replay.service 2>/dev/null || :)" = failed ]; then systemctl reset-failed tg-source-replay.service; fi
no_workers || exit 75
systemd-run --collect --unit=tg-source-replay {properties} {stage}/launch
"""
        print(read('flock -n /run/lock/tg-joint-dispatch.lock sh -ec '+shlex.quote(dispatch)),flush=True)
        handed=True
        print('Submitted compact joint verification, attempt',token,'profile',args.profile,flush=True)
    finally:
        # Failure to hand off must not stop some other operator's newly running job.
        if started and not handed:
            try: idle=read(GUARDS+"\nif no_workers; then printf idle; fi")=='idle'
            except Exception: idle=False
            if idle:
                guarded=GUARDS+'\nno_workers || exit 75\nsystemctl --no-block poweroff'
                try:read('flock -n /run/lock/tg-joint-dispatch.lock sh -ec '+shlex.quote(guarded))
                except Exception:print('Guarded idle stop unconfirmed; original hard deadline remains',flush=True)
            else:print('No stop issued without positive idle confirmation; original scheduled stop remains',flush=True)

DRIVER="""#!/bin/bash
set -Eeuo pipefail
@GUARD@
exec 8>/run/lock/tg-joint-worker.lock
if ! flock -n 8; then exit 75; fi
if unit_busy tg-joint-replay.service; then exit 75; fi
attempt=/work/compact-joint-runs/@COMMIT@-@ATTEMPT@
install -d -m 0755 /work/compact-joint-runs
mkdir "$attempt"
chown grhreplay:grhreplay "$attempt"
exec > >(tee -a "$attempt/driver.log" /dev/console) 2>&1
test -f /work/replay/evidence/receipt.json
sysctl -w vm.max_map_count=1048576
iptables -C OUTPUT -m owner --uid-owner grhreplay -d 169.254.169.254 -j REJECT || iptables -I OUTPUT -m owner --uid-owner grhreplay -d 169.254.169.254 -j REJECT
ulimit -n 1048576
ulimit -s unlimited
if unit_busy tg-joint-replay.service; then exit 75; fi
export TG_DISPATCH_START=$(date +%s)
rc=0
# Root owns the tools and shares verified release objects between attempts.
tools=/work/compact-joint-435-verified-tools
install -d -m 0755 "$tools"
test ! -L "$tools" && test "$(stat -c %u "$tools")" = 0
setup_tools() (
  set -eu
  cd "$tools"
  if ! test -f .ready; then
    curl -fsSL --retry 3 -o lean.tar.zst https://github.com/leanprover/lean4/releases/download/v4.35.0/lean-4.35.0-linux.tar.zst
    echo "7289597a44543246c9227b8cae501767e095ce17f6d448b95fc4a8dc97268f6d  lean.tar.zst" | sha256sum -c -
    test "$(stat -c %s lean.tar.zst)" = 594481375
    tar --zstd --no-same-owner -xf lean.tar.zst
    curl -fsSL --retry 3 -o override.tar.zst https://github.com/leanprover/lean4/releases/download/v4.36.0-rc1/lean-4.36.0-rc1-linux.tar.zst
    echo "26b3cea1a006ad419215520b8668dcd3f6a9eeba1a123756563a739f9c6274b2  override.tar.zst" | sha256sum -c -
    tar --zstd --no-same-owner -xf override.tar.zst lean-4.36.0-rc1-linux/bin/con-ron
    echo "4e5616d94374cae37324dad2594f6230c2bb2297240249fc78ff508f3bc5acef  lean-4.36.0-rc1-linux/bin/con-ron" | sha256sum -c -
    touch .ready
  fi
)
set +e
setup_tools
rc=$?
set -e
if [ "$rc" = 0 ]; then
  install -d -m 0750 -o grhreplay -g grhreplay /work/compact-joint-mathlib-cache-56a00585
  setpriv --reuid=grhreplay --regid=grhreplay --init-groups env HOME=/work/home TMPDIR=/work/tmp PATH="$tools/lean-4.35.0-linux/bin:/usr/local/bin:/usr/bin:/bin" python3 @HELPER@ --run-dir "$attempt/run" --threads @THREADS@ @PROJECT_THREADS@ @EARLY_TARGETS@ --commit @COMMIT@ --tree @TREE@ --profile @PROFILE@ --toolchain-dir "$tools/lean-4.35.0-linux" --mathlib-cache-dir /work/compact-joint-mathlib-cache-56a00585 --con-ron "$tools/lean-4.36.0-rc1-linux/bin/con-ron" @SHARD@ @PARANOID@ || rc=$?
fi
echo "$rc" > "$attempt/driver.exit"
python3 - "$attempt" @COMMIT@ @TREE@ "$rc" <<'TG_SUMMARY'
import base64, gzip, hashlib, json, sys
from pathlib import Path
attempt=Path(sys.argv[1]); p=attempt/'run/evidence/receipt.json'
if p.is_file():
    raw=p.read_bytes();r=json.loads(raw)
else:
    r={'status':'failed','error':'tool setup or worker startup failed','steps':[],'pin':sys.argv[2],'git_tree':sys.argv[3],'root':str(attempt/'run')}
    p=attempt/'startup-receipt.json';raw=(json.dumps(r)+chr(10)).encode();p.write_bytes(raw)
sha=lambda b:hashlib.sha256(b).hexdigest()
summary={k:r[k] for k in ('status','error','failure_details','failed_stage_tail','cached_module_counts','prepared_module_counts','mathlib_umbrella','axioms','compact','challenge_export','solution_export','comparator_accepts','con_ron','within_330_minutes','profile_outcome','baseline_elapsed_seconds','resource_profile','project_lake_threads','preflight_modules') if k in r}
summary.update(commit=sys.argv[2],tree=sys.argv[3],driver_exit=int(sys.argv[4]),receipt_path=str(p),receipt_sha256=sha(raw))
summary['steps']=[{k:s[k] for k in ('name','exit','wall_seconds','cpu_seconds','cgroup_sampled_peak_bytes','cgroup_lifetime_peak_bytes') if k in s} for s in r['steps'] if s.get('name','') in {'mathlib-cache','trusted-widget-replay','trusted-mathlib-replay','trusted-downstream-replay','challenge-build','challenge-export','source-preflight','compact-main-shard','joint-source-build','axioms','solution-export','comparator','con-ron','extra-paranoid'} or s.get('exit',0)]
msg=json.dumps(summary,sort_keys=True,separators=(',',':')).encode()
ref_line=' '.join(('TG435_RECEIPT_REF',str(p),sha(raw)))
summary_line=' '.join(('TG435_RECEIPT_V1',sha(msg),base64.b64encode(gzip.compress(msg,mtime=0)).decode()))
# Stay below 24 KiB for the full terminal bundle, with short serial records.
token=attempt.name.rsplit('-',1)[-1]
if len(raw)<=2*1024*1024 and len(token)==32 and all(c in '0123456789abcdef' for c in token):
    encoded=base64.b64encode(gzip.compress(raw,mtime=0)).decode()
    blocks=[encoded[i:i+560] for i in range(0,len(encoded),560)]
    lines=[f'TG435_FULL_V1 {token} {sha(raw)} {i+1}/{len(blocks)} {block}' for i,block in enumerate(blocks)]
    if len(lines)<=32 and sum(len(line)+1 for line in [*lines,ref_line,summary_line])<=24*1024:
        for line in lines:print(line)
print(ref_line);print(summary_line)
TG_SUMMARY
sync
if unit_busy tg-joint-replay.service; then echo 'Active joint worker; no poweroff' >&2; exit "$rc"; fi
echo "Community 4.35 verification completed with exit $rc; stopping this instance"
systemctl --no-block poweroff
exit "$rc"
"""
if __name__=='__main__':main()

