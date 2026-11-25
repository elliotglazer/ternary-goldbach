#!/usr/bin/env python3
"""Generate a private EC2 stack, upload a replay runner with SSM, and inspect it."""
import argparse
import base64
import datetime as dt
import gzip
import hashlib
import json
import os
from pathlib import Path
import re
import shlex
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent
REGION = 'us-east-1'
PIN = '756a70250dcba9162b99d4ea35c186558434c17e'
TYPE = 'r7i.8xlarge'
RUNNER_SHA256 = '8d5d2316fd2b2865037aa8d5b820c17217e1b6771cf34d7373886c6a74090592'

def aws(service, operation, *args):
    cmd = ['aws', '--region', REGION, '--no-cli-pager', '--output', 'json', service, operation, *args]
    raw = subprocess.check_output(cmd)
    return json.loads(raw) if raw.strip() else {}

def ref(name):
    return {'Ref': name}

def get(name, field):
    return {'Fn::GetAtt': [name, field]}

def role(service, policies):
    return {'Type':'AWS::IAM::Role','Properties':{
        'AssumeRolePolicyDocument':{'Version':'2012-10-17','Statement':[{'Effect':'Allow','Principal':{'Service':service},'Action':'sts:AssumeRole'}]},
        **policies}}

def template(vpc,subnet,zone,deadline,autorun=False):
    boot = (ROOT/'boot.sh').read_text().replace('__DATA_VOLUME__', "${VolSerial}")
    run = (ROOT/'run.sh').read_text()
    # A literal heredoc avoids interpreting runner or driver contents in cloud-init.
    boot += "\ncat > /usr/local/sbin/tg-replay <<'TG_DRIVER'\n"+run+"\nTG_DRIVER\nchmod 0755 /usr/local/sbin/tg-replay\n"
    if autorun:
        runner = (ROOT / 'grh_source.py').read_bytes()
        digest = hashlib.sha256(runner).hexdigest()
        if digest != RUNNER_SHA256:
            raise SystemExit('Runner SHA-256 mismatch')
        encoded = base64.b64encode(gzip.compress(runner, mtime=0)).decode('ascii')
        boot += (
            "printf %s " + shlex.quote(encoded) + " | base64 -d | gzip -d > /work/runner/grh_source.py\n"
            + "echo '" + digest + "  /work/runner/grh_source.py' | sha256sum -c -\n"
            + "chmod 0555 /work/runner/grh_source.py\n"
            + "systemd-run --unit=tg-source-replay /usr/local/sbin/tg-replay\n"
        )
    if len(boot.encode()) > 16384:
        raise ValueError('EC2 user data exceeds 16 KiB')
    res={}
    res['Data']={'Type':'AWS::EC2::Volume','DeletionPolicy':'Retain','UpdateReplacePolicy':'Retain','Properties':{
        'AvailabilityZone':zone,'VolumeType':'gp3','Size':600,'Encrypted':True,
        'Tags':[{'Key':'Name','Value':{'Fn::Sub':'${AWS::StackName}-evidence'}}]}}
    res['Security']={'Type':'AWS::EC2::SecurityGroup','Properties':{'GroupDescription':'TG replay, outbound only','VpcId':vpc,
        'SecurityGroupEgress':[{'IpProtocol':'-1','CidrIp':'0.0.0.0/0'}]}}
    res['WorkerRole']=role('ec2.amazonaws.com',{'ManagedPolicyArns':['arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore']})
    res['Profile']={'Type':'AWS::IAM::InstanceProfile','Properties':{'Roles':[ref('WorkerRole')]}}
    res['Host']={'Type':'AWS::EC2::Instance','Properties':{
        'ImageId':'{{resolve:ssm:/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id}}',
        'InstanceType':TYPE,'IamInstanceProfile':ref('Profile'),'InstanceInitiatedShutdownBehavior':'stop',
        'MetadataOptions':{'HttpTokens':'required','HttpPutResponseHopLimit':1},
        'NetworkInterfaces':[{'DeviceIndex':'0','AssociatePublicIpAddress':True,'GroupSet':[ref('Security')],'SubnetId':subnet}],
        'BlockDeviceMappings':[{'DeviceName':'/dev/sda1','Ebs':{'VolumeType':'gp3','VolumeSize':30,'Encrypted':True,'DeleteOnTermination':True}}],
        'Tags':[{'Key':'Name','Value':ref('AWS::StackName')}],
        'UserData':{'Fn::Base64':{'Fn::Sub':[boot,{'VolSerial':{'Fn::Join':['',{'Fn::Split':['-',ref('Data')]}]}}]}}}}
    res['Attach']={'Type':'AWS::EC2::VolumeAttachment','Properties':{'Device':'/dev/sdf','InstanceId':ref('Host'),'VolumeId':ref('Data')}}
    res['StopRole']=role('scheduler.amazonaws.com',{'Policies':[{'PolicyName':'StopThisReplay','PolicyDocument':{'Version':'2012-10-17','Statement':[{
        'Effect':'Allow','Action':'ec2:StopInstances','Resource':{'Fn::Sub':'arn:aws:ec2:${AWS::Region}:${AWS::AccountId}:instance/${Host}'}}]}}]})
    res['Deadline']={'Type':'AWS::Scheduler::Schedule','Properties':{'FlexibleTimeWindow':{'Mode':'OFF'},'ScheduleExpression':f'at({deadline})',
        'ScheduleExpressionTimezone':'UTC','Target':{'Arn':'arn:aws:scheduler:::aws-sdk:ec2:stopInstances','RoleArn':get('StopRole','Arn'),
        'Input':{'Fn::Sub':'{"InstanceIds":["${Host}"]}'},'RetryPolicy':{'MaximumEventAgeInSeconds':3600,'MaximumRetryAttempts':10}}}}
    return {'AWSTemplateFormatVersion':'2010-09-09','Resources':res,'Outputs':{'Instance':{'Value':ref('Host')},'Evidence':{'Value':ref('Data')}}}

def destination():
    vpcs=aws('ec2','describe-vpcs','--filters','Name=isDefault,Values=true')['Vpcs']
    if len(vpcs)!=1: raise SystemExit('Expected one default VPC in us-east-1')
    vpc=vpcs[0]['VpcId']
    subnets=aws('ec2','describe-subnets','--filters',f'Name=vpc-id,Values={vpc}','Name=default-for-az,Values=true')['Subnets']
    tables=aws('ec2','describe-route-tables','--filters',f'Name=vpc-id,Values={vpc}')['RouteTables']
    zones={x['Location'] for x in aws('ec2','describe-instance-type-offerings','--location-type','availability-zone','--filters',f'Name=instance-type,Values={TYPE}')['InstanceTypeOfferings']}
    for sub in sorted(subnets,key=lambda x:x['AvailabilityZone']):
        direct=[t for t in tables if any(a.get('SubnetId')==sub['SubnetId'] for a in t['Associations'])]
        main=[t for t in tables if any(a.get('Main') for a in t['Associations'])]
        if sub['AvailableIpAddressCount'] and sub['AvailabilityZone'] in zones and any(r.get('DestinationCidrBlock')=='0.0.0.0/0' and r.get('State')=='active' and r.get('GatewayId','').startswith('igw-') for t in (direct or main) for r in t['Routes']):
            return vpc,sub['SubnetId'],sub['AvailabilityZone']
    raise SystemExit('Default VPC has no eligible internet-routed default subnet')

def host_and_volume(stack):
    d=aws('cloudformation','describe-stacks','--stack-name',stack)['Stacks'][0]
    return {r['OutputKey']:r['OutputValue'] for r in d['Outputs']}

def health(instance):
    result = aws('ec2', 'describe-instances', '--instance-ids', instance)
    worker = result['Reservations'][0]['Instances'][0]
    reason = worker.get('StateTransitionReason') or (worker.get('StateReason') or {}).get('Message')
    print('EC2:', worker['State']['Name'], '| reason:', reason or '-')
    result = aws('ec2', 'describe-instance-status', '--include-all-instances', '--instance-ids', instance)
    checks = result['InstanceStatuses']
    if checks:
        print('System check:', checks[0]['SystemStatus']['Status'], '| instance check:', checks[0]['InstanceStatus']['Status'])
    else:
        print('EC2 status checks unavailable')
    result = aws('ssm', 'describe-instance-information', '--filters', 'Key=InstanceIds,Values='+instance)
    records = result['InstanceInformationList']
    print('SSM:', records[0]['PingStatus'] if records else 'unregistered')

def ssm(instance, cmd, timeout=150):
    res=aws('ssm','send-command','--instance-ids',instance,'--document-name','AWS-RunShellScript','--parameters',json.dumps({'commands':[cmd],'executionTimeout':[str(timeout)]}))
    cid=res['Command']['CommandId']
    for _ in range(timeout//3+10):
        inv=aws('ssm','list-command-invocations','--command-id',cid,'--details')['CommandInvocations']
        if inv and inv[0]['Status'] not in ('Pending','InProgress','Delayed'):
            p=inv[0]['CommandPlugins'][0]
            if p['Output']: print(p['Output'])
            if inv[0]['Status']!='Success': raise SystemExit(f'SSM {cid}: {inv[0]["Status"]}')
            return
        time.sleep(3)
    raise SystemExit(f'Inspect SSM command {cid} before retrying')

def main():
    a=argparse.ArgumentParser()
    a.add_argument('action',choices=['render','launch','start','status','health','console','tail'])
    a.add_argument('--stack',default='tg-grh-source-replay')
    a.add_argument('--runner',type=Path)
    a.add_argument('--autorun',action='store_true',help='Start the pinned source replay when the new host is ready')
    args=a.parse_args()
    deadline=(dt.datetime.now(dt.timezone.utc)+dt.timedelta(hours=12)).strftime('%Y-%m-%dT%H:%M:%S')
    if args.action=='render':
        print(json.dumps(template('vpc-example','subnet-example','us-east-1a',deadline, args.autorun),indent=2));return
    if args.action=='launch':
        spec=template(*destination(),deadline, args.autorun)
        print(aws('cloudformation','create-stack','--stack-name',args.stack,'--capabilities','CAPABILITY_IAM','--template-body',json.dumps(spec)))
        print('The source replay will start on boot.' if args.autorun else 'Wait for stack CREATE_COMPLETE before start.');return
    info=host_and_volume(args.stack); instance=info['Instance']
    if args.action=='health':
        health(instance);return
    print(info)
    if args.action=='status':
        s=aws('ec2','describe-instances','--instance-ids',instance)['Reservations'][0]['Instances'][0]
        print(s['State']['Name'],s['InstanceType'],s['ImageId'],s['Placement']['AvailabilityZone']);return
    if args.action=='console':
        data=aws('ec2','get-console-output','--instance-id',instance,'--latest').get('Output','')
        print(data[-12000:]);return
    if args.action=='tail':
        ssm(instance,'tail -n 20 /work/bootstrap.log /work/driver.log; find /work/replay/evidence -maxdepth 1 -type f -printf "%f %s bytes\\n" 2>/dev/null || true');return
    if not args.runner: a.error('start requires --runner')
    data=args.runner.read_bytes()
    if PIN.encode() not in data: raise SystemExit('Runner does not contain the required source pin')
    sha=hashlib.sha256(data).hexdigest()
    if sha != RUNNER_SHA256: raise SystemExit('Runner SHA-256 mismatch')
    payload=base64.b64encode(gzip.compress(data,mtime=0)).decode()
    dest='/root/tg-upload/'+sha
    ssm(instance,f'test -x /usr/local/sbin/tg-replay && test -f /work/bootstrap-ready && test ! -e /work/replay && mkdir -p {dest}')
    for i in range(0,len(payload),9000):
        ssm(instance,f"printf %s {shlex.quote(payload[i:i+9000])} > {dest}/{i:08d}.b64")
    ssm(instance,f"set -eu; cat {dest}/*.b64 | base64 -d | gzip -d > {dest}/runner; echo '{sha}  {dest}/runner' | sha256sum -c -; install -m 0555 {dest}/runner /work/runner/grh_source.py; systemd-run --unit=tg-source-replay /usr/local/sbin/tg-replay")
    print('Submitted',sha)

if __name__=='__main__': main()

