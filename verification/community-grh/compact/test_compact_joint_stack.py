"""Exercise the stopped-host dispatcher against a local AWS response double."""
import importlib.util
import json
import sys
import tempfile
import datetime as dt
from pathlib import Path
from unittest.mock import patch
import subprocess

def exercise(mod, **override):
    calls=[]
    commands=[]
    def fake(service,action,*args):
        calls.append(action)
        if action=='describe-stacks':return {'Stacks':[{'Outputs':[{'OutputKey':'Instance','OutputValue':'i-test'},{'OutputKey':'Evidence','OutputValue':'vol-test'}]}]}
        if action=='describe-instances':return {'Reservations':[{'Instances':[{'State':{'Name':override.get('state','stopped')},'InstanceType':'r7i.8xlarge','BlockDeviceMappings':[{'Ebs':{'VolumeId':'vol-test'}}]}]}]}
        if action=='describe-volumes':return {'Volumes':[{'Size':override.get('size',600),'Attachments':[{'InstanceId':'i-test','State':'attached'}]}]}
        if action=='describe-stack-resource':return {'StackResourceDetail':{'PhysicalResourceId':'group/schedule'}}
        if action=='get-schedule':return {'State':override.get('schedule','ENABLED'),'Target':{'Arn':'arn:aws:scheduler:::aws-sdk:ec2:stopInstances','Input':json.dumps({'InstanceIds':['i-test']})},'ScheduleExpression':'at('+(dt.datetime.now(dt.timezone.utc)+dt.timedelta(hours=override.get('window_hours',10))).strftime('%Y-%m-%dT%H:%M:%S')+')'}
        if action=='start-instances':return {}
        if action=='describe-instance-information':return {'InstanceInformationList':[{'PingStatus':'Online'}]}
        if action=='send-command':
            cmd=json.loads(args[args.index('--parameters')+1])['commands'][0]
            subprocess.run(['sh','-n'],input=cmd.encode(),check=True)
            commands.append(cmd)
            return {'Command':{'CommandId':str(len(commands))}}
        if action=='list-command-invocations':return {'CommandInvocations':[{'Status':'Success','CommandPlugins':[{}]}]}
        if action=='get-command-invocation':return {'StandardOutputContent':'online'}
        raise AssertionError(action)
    with patch.object(mod,'aws',fake),patch.object(mod,'public_pin',lambda commit,tree: None),patch.object(sys,'argv',['compact_joint_stack.py','--commit','1'*40,'--tree','2'*40]):
        try: mod.main()
        except SystemExit:
            assert override and 'start-instances' not in calls
            return
    assert not override
    assert calls.count('start-instances')==1
    assert sum('systemd-run --collect --unit=tg-source-replay' in c for c in commands)==1
    assert '/work/compact-joint' in mod.DRIVER
    assert any('MemoryMax=67345087201' in c and 'MemoryHigh=65283502899' in c for c in commands)
    assert '/work/compact-joint-mathlib-cache-56a00585' in mod.DRIVER
    assert 'setpriv --reuid=grhreplay' in mod.DRIVER
    assert 'test ! -e /work/compact-joint' not in mod.DRIVER
    subprocess.run(['bash','-n'],input=mod.DRIVER.replace('@GUARD@',mod.GUARDS).encode(),check=True)
if __name__=='__main__':
    import compact_joint_stack as compact_stack
    for case in [{},{'state':'running'},{'size':601},{'schedule':'DISABLED'},{'window_hours':200}]:
        exercise(compact_stack,**case)
    print('Mock compact dispatch passed, including three pre-start refusals.')

