#!/usr/bin/env python3
"""Capture a failed GRH challenge from an EXISTING stopped stack, then stop that instance again."""
import argparse
import base64
import datetime as dt
import hashlib
import json
from pathlib import Path
import subprocess
import time

REGION='us-east-1'
FILES=['receipt.json','challenge-build.log','challenge-build.time']
REMOTE='/work/replay/evidence/'
def aws(service,action,*args):
    cmd=['aws','--region',REGION,'--no-cli-pager','--output','json','--cli-connect-timeout','8','--cli-read-timeout','20',service,action,*args]
    return json.loads(subprocess.check_output(cmd,timeout=32) or b'{}')

def main():
    a=argparse.ArgumentParser(description=__doc__);a.add_argument('--stack',default='tg-grh-source-replay')
    a.add_argument('--out',type=Path,default=Path('tg-challenge-failure'))
    args=a.parse_args()
    stack=aws('cloudformation','describe-stacks','--stack-name',args.stack)['Stacks'][0]
    info={v['OutputKey']:v['OutputValue'] for v in stack['Outputs']};i=info['Instance'];volume=info['Evidence']
    host=aws('ec2','describe-instances','--instance-ids',i)['Reservations'][0]['Instances'][0]
    if host['State']['Name']!='stopped' or volume not in [x['Ebs']['VolumeId'] for x in host['BlockDeviceMappings']]:
        raise SystemExit('Requires the stopped stack instance and its original attached evidence volume.')
    sched=aws('cloudformation','describe-stack-resource','--stack-name',args.stack,'--logical-resource-id','Deadline')['StackResourceDetail']['PhysicalResourceId'].split('/')[-1]
    sd=aws('scheduler','get-schedule','--name',sched)
    cutoff=dt.datetime.fromisoformat(sd['ScheduleExpression'][3:-1]).replace(tzinfo=dt.timezone.utc)
    target=json.loads(sd['Target']['Input'])
    if sd['State']!='ENABLED' or target.get('InstanceIds')!=[i] or cutoff<dt.datetime.now(dt.timezone.utc)+dt.timedelta(minutes=12):
        raise SystemExit('Original account-side stop is absent, expired or too close. No restart attempted.')
    end=time.monotonic()+540
    def timeleft():
        if time.monotonic()>end:raise TimeoutError('diagnostic window expired')
    def read(command):
        timeleft()
        cid=aws('ssm','send-command','--instance-ids',i,'--document-name','AWS-RunShellScript','--timeout-seconds','60','--parameters',json.dumps({'commands':['set -eu\n'+command],'executionTimeout':['30']}))['Command']['CommandId']
        for _ in range(22):
            timeleft()
            inv=aws('ssm','list-command-invocations','--command-id',cid,'--details')['CommandInvocations']
            if inv and inv[0]['Status'] not in ('Pending','InProgress','Delayed'):
                plugin=inv[0]['CommandPlugins'][0]
                if inv[0]['Status']!='Success':raise RuntimeError('SSM diagnostic failed: '+plugin.get('Output','')[:600])
                return aws('ssm','get-command-invocation','--command-id',cid,'--instance-id',i)['StandardOutputContent'].strip()
            time.sleep(2)
        raise TimeoutError('SSM diagnostic command timeout')
    args.out.mkdir(parents=True,exist_ok=True)
    # Record ownership before calling StartInstances so a network timeout after submission
    # still triggers the stop request below. Preflight established this exact host was stopped.
    try:
        aws('ec2','start-instances','--instance-ids',i)
        while True:
            timeleft()
            managed=aws('ssm','describe-instance-information','--filters','Key=InstanceIds,Values='+i)['InstanceInformationList']
            if managed and managed[0]['PingStatus']=='Online':
                try:
                    answer=read('printf tg-diagnostic-ready')
                    if answer=='tg-diagnostic-ready':break
                except subprocess.CalledProcessError:pass
            time.sleep(5)
        facts=read("test -f /work/replay/evidence/challenge-build.log; test ! -f /var/lib/cloud/instance/sem/config_scripts_user || printf 'scripts-user=completed\\n'; findmnt -no SOURCE,FSTYPE /work; systemctl show tg-source-replay.service tg-joint-replay.service -p Id -p ActiveState || true")
        (args.out/'boot-state.txt').write_text(facts+'\n')
        if 'ActiveState=active' in facts or 'ActiveState=activating' in facts:raise RuntimeError('Unexpected active verifier after diagnostic-only start; see boot-state.txt')
        for name in FILES:
            remote=REMOTE+name
            manifest=read(f"stat -c '%s' {remote}; sha256sum {remote}").split()
            size=int(manifest[0]);expected=manifest[1]
            if size>2_000_000:raise RuntimeError(f'{name}: exceeds diagnostic transfer limit; use retained EBS recovery')
            buf=bytearray()
            for chunk in range((size+11999)//12000):
                token=read(f'dd if={remote} bs=12000 skip={chunk} count=1 status=none | base64 -w0')
                buf.extend(base64.b64decode(token,validate=True))
            if len(buf)!=size or hashlib.sha256(buf).hexdigest()!=expected:raise RuntimeError('Invalid transfer '+name)
            destination=args.out/name
            if destination.exists() and destination.read_bytes()!=buf:raise RuntimeError('Refusing to overwrite '+str(destination))
            destination.write_bytes(buf);print(destination,expected,flush=True)
    finally:
        result=aws('ec2','stop-instances','--instance-ids',i)
        print('Diagnostic stop requested',result['StoppingInstances'][0]['CurrentState']['Name'],flush=True)
    print((args.out/'challenge-build.log').read_text(errors='replace')[-5000:])

if __name__=='__main__':main()
