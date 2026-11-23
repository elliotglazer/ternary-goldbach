"""Run an expiring one-instance Goldbach pilot from AWS CloudShell in us-east-1."""
import argparse
import base64
from datetime import datetime, timedelta, timezone
from decimal import Decimal
import gzip
import hashlib
import io
import json
from pathlib import Path
import secrets
import tarfile
import time

ROOT = Path(__file__).resolve().parent
STATE = ROOT/"pilot-state.json"
REGION = "us-east-1"
TYPE = "c7a.4xlarge"
HOURS = 6
GIB = 96
PIN = "ed5651a7520443ed5425345020f3382ce8b657e04d1fa95775b33ab7f711d626"
ARCHIVE = "goldbach-4e15-wide-linux.tar.gz"
EXPECTED = "'WideGoldbach.endpoint_range' depends on axioms: [propext, Classical.choice, Quot.sound]"
FIXTURES = {
    "small": ("bba6d63679433e8c6047a54b8ce9726ee7fd5452373235fb7f7d436d5c81c026",3999999999967234),
    "large": ("f109bab26cc07a7f88b6ec5c43ddc6c1a08a3d3df40222b06684392df44cf070",3999999998951426),
}


def utc():
    return datetime.now(timezone.utc)


def z(t):
    return t.strftime("%Y-%m-%dT%H:%M:%SZ")


def package():
    raw = (ROOT/ARCHIVE).read_bytes()
    if hashlib.sha256(raw).hexdigest() != PIN:
        raise ValueError("wide package hash mismatch")
    stream = io.BytesIO()
    with tarfile.open(fileobj=stream, mode="w") as tar:
        for name, data in [(ARCHIVE, raw)]+[(n, (ROOT/n).read_bytes()) for n in ("worker.sh", "report.py")]:
            meta = tarfile.TarInfo(name)
            meta.size = len(data)
            tar.addfile(meta, io.BytesIO(data))
    return gzip.compress(stream.getvalue(), mtime=0)


def bootstrap(digest, get, post, deadline):
    transfer = json.dumps({"post":post}, separators=(",", ":"))
    script = """#!/bin/bash
set -eu
umask 077
install -d -m 700 /var/lib/goldbach
cd /var/lib/goldbach
shutdown -P +$(( (DEADLINE - $(date +%s))/60 > 1 ? (DEADLINE - $(date +%s))/60 - 1 : 1 ))
trap 'systemctl poweroff' EXIT
cat >transfer.json <<'TRANSFER'
POST
TRANSFER
curl -fsS --retry 3 --max-time 120 'GETURL' -o payload.tgz
echo 'DIGEST  payload.tgz' | sha256sum -c -
tar xzf payload.tgz
bash worker.sh
""".replace("DEADLINE", str(int(deadline.timestamp()))).replace("POST\n", transfer+"\n").replace("GETURL", get).replace("DIGEST", digest)
    encoded = gzip.compress(script.encode(), mtime=0)
    if len(encoded) > 16384:
        raise ValueError("user data too large")
    return base64.b64encode(encoded).decode()


def template(net, name, deadline, userdata):
    tags = [{"Key":"GoldbachPilot","Value":name}]
    subnet, vpc, ami, device = net
    group = {"Type":"AWS::EC2::SecurityGroup","Properties":{"GroupDescription":name,
             "VpcId":vpc, "Tags":tags, "SecurityGroupIngress":[],
             "SecurityGroupEgress":[{"IpProtocol":"tcp","FromPort":p,"ToPort":p,"CidrIp":"0.0.0.0/0"} for p in (80,443)]}}
    launch = {"Type":"AWS::EC2::LaunchTemplate","Properties":{"LaunchTemplateData":{
        "ImageId":ami, "InstanceType":TYPE, "InstanceInitiatedShutdownBehavior":"terminate", "UserData":userdata,
        "MetadataOptions":{"HttpTokens":"required","HttpPutResponseHopLimit":1},
        "NetworkInterfaces":[{"AssociatePublicIpAddress":True,"DeviceIndex":0,"SubnetId":subnet,"Groups":[{"Ref":"Group"}]}],
        "BlockDeviceMappings":[{"DeviceName":device,"Ebs":{"VolumeType":"gp3","VolumeSize":GIB,
                               "Encrypted":True,"DeleteOnTermination":True}}],
        "TagSpecifications":[{"ResourceType":r,"Tags":tags} for r in ("instance","volume")]}}}
    fleet = {"Type":"AWS::EC2::EC2Fleet","Properties":{"Type":"request","ValidUntil":z(deadline),
             "TerminateInstancesWithExpiration":True, "TagSpecifications":[{"ResourceType":"fleet","Tags":tags}],
             "TargetCapacitySpecification":{"TotalTargetCapacity":1,"OnDemandTargetCapacity":1,
                                             "SpotTargetCapacity":0,"DefaultTargetCapacityType":"on-demand"},
             "LaunchTemplateConfigs":[{"LaunchTemplateSpecification":{"LaunchTemplateId":{"Ref":"Launch"},"Version":"1"},
                                       "Overrides":[{"SubnetId":subnet,"InstanceType":TYPE}]}]}}
    return {"AWSTemplateFormatVersion":"2010-09-09", "Resources":{"Group":group,"Launch":launch,"Fleet":fleet}}


def quote(pricing):
    filters = {"instanceType":TYPE,"regionCode":REGION,"operatingSystem":"Linux","tenancy":"Shared",
               "preInstalledSw":"NA","capacitystatus":"Used","operation":"RunInstances"}
    products = pricing.get_paginator("get_products").paginate(ServiceCode="AmazonEC2",
        Filters=[{"Type":"TERM_MATCH","Field":k,"Value":v} for k,v in filters.items()])
    rates = set()
    for page in products:
        for product in page["PriceList"]:
            for term in json.loads(product)["terms"].get("OnDemand", {}).values():
                for item in term["priceDimensions"].values():
                    if item["unit"] == "Hrs":
                        rates.add(Decimal(item["pricePerUnit"]["USD"]))
    if len(rates) != 1 or not 0 < next(iter(rates)) <= Decimal("1.00"):
        raise ValueError(f"expected one EC2 rate of at most $1/hour, found {rates}")
    return rates.pop()


def network(s):
    ec2=s.client("ec2")
    vpcs=ec2.describe_vpcs(Filters=[{"Name":"is-default","Values":["true"]}])["Vpcs"]
    if len(vpcs)!=1:
        raise ValueError("pilot needs an existing default VPC in us-east-1")
    vpc=vpcs[0]["VpcId"]
    filt=[{"Name":"vpc-id","Values":[vpc]}]
    tables=ec2.describe_route_tables(Filters=filt)["RouteTables"]
    offerings=ec2.describe_instance_type_offerings(LocationType="availability-zone",
        Filters=[{"Name":"instance-type","Values":[TYPE]}])["InstanceTypeOfferings"]
    zones={o["Location"] for o in offerings}
    def public_route(sub):
        explicit=[t for t in tables if any(a.get("SubnetId")==sub for a in t["Associations"])]
        selected=explicit or [t for t in tables if any(a.get("Main") for a in t["Associations"])]
        return any(r.get("GatewayId","").startswith("igw-") and r.get("DestinationCidrBlock")=="0.0.0.0/0"
                   and r.get("State")=="active" for t in selected for r in t["Routes"])
    subs=[x for x in ec2.describe_subnets(Filters=filt)["Subnets"] if x["DefaultForAz"] and
          x["AvailabilityZone"] in zones and x["AvailableIpAddressCount"]>1 and public_route(x["SubnetId"])]
    if not subs:
        raise ValueError("no available default subnet with a direct internet gateway and c7a.4xlarge offering")
    key="/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
    ami=s.client("ssm").get_parameter(Name=key)["Parameter"]["Value"]
    image=ec2.describe_images(ImageIds=[ami],Owners=["099720109477"])["Images"][0]
    if image["State"]!="available" or image["Architecture"]!="x86_64":
        raise ValueError("expected an available Canonical x86_64 Ubuntu AMI")
    return sorted(x["SubnetId"] for x in subs)[0],vpc,ami,image["RootDeviceName"]


def deadline_for(s):
    now=utc()
    creds=s.get_credentials()
    creds.get_frozen_credentials()
    expiry=getattr(creds,"_expiry_time",None)
    if not expiry:
        raise ValueError("cannot verify when this CloudShell session expires; no resources created")
    deadline=min(now+timedelta(hours=HOURS),expiry-timedelta(minutes=10))
    if deadline-now < timedelta(minutes=30):
        raise ValueError("less than 30 minutes of usable session lifetime; open a fresh CloudShell session")
    return deadline


def preflight(s):
    account=s.client("sts").get_caller_identity()["Account"]
    s.client("iam").get_role(RoleName="AWSServiceRoleForEC2Fleet")
    quota=s.client("service-quotas").get_service_quota(ServiceCode="ec2",QuotaCode="L-1216C47A")["Quota"]["Value"]
    if quota<16:
        raise ValueError(f"us-east-1 Standard On-Demand quota is {quota} vCPUs; 16 are needed")
    # The stated quota is 16. Abort if another standard on-demand instance consumes any of it.
    ec2=s.client("ec2")
    pages=ec2.get_paginator("describe_instances").paginate(Filters=[{"Name":"instance-state-name","Values":["pending","running"]}])
    used=0
    for page in pages:
        for reservation in page["Reservations"]:
            for instance in reservation["Instances"]:
                family=instance["InstanceType"].split(".")[0]
                if family[0] in "acdhimrtz" and not family.startswith(("hpc","inf","trn","mac")) and not instance.get("InstanceLifecycle"):
                    cpu=instance["CpuOptions"]
                    baseline=ec2.describe_instance_types(InstanceTypes=[instance["InstanceType"]])["InstanceTypes"][0]["VCpuInfo"]["DefaultVCpus"]
                    used+=max(baseline,cpu["CoreCount"]*cpu["ThreadsPerCore"])
    if quota-used<16:
        raise ValueError(f"standard quota {quota}, at least {used} vCPUs already in use; 16 free needed")
    rate=quote(s.client("pricing"))
    net=network(s)
    deadline=deadline_for(s)
    preview=template(net,"goldbach-preflight",deadline,"IyEvYmluL3NoCg==")
    s.client("cloudformation").validate_template(TemplateBody=json.dumps(preview))
    estimate=Decimal(HOURS)*(rate+Decimal("0.005")+GIB*Decimal("0.08")/(30*24))
    print(f"us-east-1, one {TYPE}, {net[2]}, 96 GiB gp3, EC2 ${rate}/h; six-hour estimate ${estimate:.2f} before tax and S3 requests.")
    print("Fleet expiry",z(deadline),"; latest worker receipt expires from S3 after three days.")
    return account,net,deadline


def save(state):
    pending=STATE.with_suffix(".tmp")
    pending.write_text(json.dumps(state,indent=2)+"\n")
    pending.replace(STATE)


def launch(s):
    if STATE.exists():
        raise SystemExit("This directory already has a pilot. Use status, collect or cleanup.")
    account,net,deadline=preflight(s)
    name="goldbach-"+secrets.token_hex(8)
    bucket=name+"-"+account
    state={"account":account,"name":name,"bucket":bucket,"deadline":z(deadline),"region":REGION}
    save(state)
    s3=s.client("s3")
    s3.create_bucket(Bucket=bucket)
    state["bucket_created"]=True
    save(state)
    s3.put_public_access_block(Bucket=bucket,PublicAccessBlockConfiguration=dict(
        BlockPublicAcls=True,IgnorePublicAcls=True,BlockPublicPolicy=True,RestrictPublicBuckets=True))
    s3.put_bucket_lifecycle_configuration(Bucket=bucket,LifecycleConfiguration={"Rules":[{
        "ID":"expire-pilot-inputs-and-results","Filter":{"Prefix":""},"Status":"Enabled","Expiration":{"Days":3}}]})
    payload=package()
    s3.put_object(Bucket=bucket,Key="payload.tgz",Body=payload,ServerSideEncryption="AES256")
    ttl=int((deadline-utc()).total_seconds())+300
    get=s3.generate_presigned_url("get_object",Params={"Bucket":bucket,"Key":"payload.tgz"},ExpiresIn=ttl)
    post={kind:s3.generate_presigned_post(Bucket=bucket,Key=kind+".json.gz",
          Conditions=[["content-length-range",1,1048576]],ExpiresIn=ttl) for kind in ("progress","final")}
    data=bootstrap(hashlib.sha256(payload).hexdigest(),get,post,deadline)
    cf=s.client("cloudformation")
    result=cf.create_stack(StackName=name,TemplateBody=json.dumps(template(net,name,deadline,data)),
                           ClientRequestToken=name,TimeoutInMinutes=20,OnFailure="ROLLBACK",
                           Tags=[{"Key":"GoldbachPilot","Value":name}])
    state["stack"]=result["StackId"]
    save(state)
    print("Launch submitted.",name,". Run python3 pilot.py status or python3 pilot.py collect.")


def get_state(s):
    state=json.loads(STATE.read_text())
    if state["account"]!=s.client("sts").get_caller_identity()["Account"] or state["region"]!=REGION:
        raise ValueError("AWS identity differs from the owner of this run")
    return state


def latest(s, state):
    from botocore.exceptions import ClientError
    for kind in ("final","progress"):
        try:
            obj=s.client("s3").get_object(Bucket=state["bucket"],Key=kind+".json.gz",ExpectedBucketOwner=state["account"])
            break
        except ClientError as e:
            if e.response["Error"]["Code"] not in ("NoSuchBucket","NoSuchKey","404"):
                raise
    else:
        return None
    raw=obj["Body"].read(1048577)
    if len(raw)>1048576:
        raise ValueError("unexpected receipt size")
    data=json.loads(gzip.decompress(raw))
    pending=ROOT/"pilot-receipt.tmp"
    pending.write_text(json.dumps(data,indent=2)+"\n")
    pending.replace(ROOT/"pilot-receipt.json")
    print("Receipt:",data["kind"],data["phase"],data["utc"],"exit",data["exit_code"])
    return data


def status(s, state, stop_on_rollback=False):
    cf=s.client("cloudformation")
    if "stack" in state:
        stack=cf.describe_stacks(StackName=state["stack"])["Stacks"][0]
        print("Stack",stack["StackStatus"],"expires",state["deadline"])
        if "ROLLBACK" in stack["StackStatus"] or "FAILED" in stack["StackStatus"]:
            for e in cf.describe_stack_events(StackName=state["stack"])["StackEvents"]:
                if "FAILED" in e["ResourceStatus"]:
                    print(e["LogicalResourceId"],e.get("ResourceStatusReason",""))
            if stop_on_rollback:
                latest(s,state)
                raise SystemExit("CloudFormation failed. Check the error above.")
    return latest(s,state)


def collect(s,state):
    from datetime import datetime
    until=datetime.fromisoformat(state["deadline"].replace("Z","+00:00"))+timedelta(minutes=2)
    while True:
        data=status(s,state,stop_on_rollback=True)
        if data and data["kind"]=="final":
            if not both_audits(data):
                raise SystemExit("Worker returned incomplete proof; partial evidence is in pilot-receipt.json. Run cleanup.")
            print("Both endpoint audits passed. Receipt saved in pilot-receipt.json. Run cleanup.")
            return
        if utc()>=until:
            raise SystemExit("Pilot expired. Latest available evidence saved. Run cleanup.")
        time.sleep(30)


def both_audits(data):
    if data.get("kind")!="final" or data.get("exit_code")!=0:
        return False
    for name,(digest,lower) in FIXTURES.items():
        result=data.get("fixtures",{}).get(name,{})
        receipt=result.get("receipt",{})
        audit=result.get("audit","")
        stages={row["module"] for row in receipt.get("stages",[]) if row["exit_code"]==0}
        if not (receipt.get("passed") is True and receipt.get("fixture_sha256")==digest and
                EXPECTED in audit.splitlines() and f"{lower} ≤ n → n ≤ 4000000000000000" in audit and
                {"Shared","ReadTable","Shard0","Shard1","WideAudit"}<=stages):
            return False
    return True


def cleanup(s,state):
    from botocore.exceptions import ClientError
    cf=s.client("cloudformation")
    # A process may have died between create_stack and recording its returned ARN.
    try:
        stack=cf.describe_stacks(StackName=state.get("stack",state["name"]))["Stacks"][0]
    except ClientError as e:
        if e.response["Error"]["Code"]!="ValidationError" or "does not exist" not in str(e):
            raise
        stack=None
    if stack and stack["StackStatus"]!="DELETE_COMPLETE":
        if {"Key":"GoldbachPilot","Value":state["name"]} not in stack["Tags"]:
            raise ValueError("stack ownership tag mismatch")
        cf.delete_stack(StackName=stack["StackId"])
        cf.get_waiter("stack_delete_complete").wait(StackName=stack["StackId"])
    ec2=s.client("ec2")
    scoped=[{"Name":"tag:GoldbachPilot","Values":[state["name"]]}]
    instances=[i for r in ec2.describe_instances(Filters=scoped)["Reservations"] for i in r["Instances"] if i["State"]["Name"]!="terminated"]
    if instances:
        ids=[i["InstanceId"] for i in instances]
        ec2.terminate_instances(InstanceIds=ids)
        ec2.get_waiter("instance_terminated").wait(InstanceIds=ids)
    for attempt in range(12):
        disks=ec2.describe_volumes(Filters=scoped)["Volumes"]
        if not disks:
            break
        time.sleep(5)
    if disks:
        raise SystemExit("Tagged EBS volume still exists: "+", ".join(v["VolumeId"] for v in disks)+". Retry cleanup.")
    s3=s.client("s3")
    try:
        latest(s,state)
        for key in ("payload.tgz","progress.json.gz","final.json.gz"):
            s3.delete_object(Bucket=state["bucket"],Key=key,ExpectedBucketOwner=state["account"])
        s3.delete_bucket(Bucket=state["bucket"],ExpectedBucketOwner=state["account"])
    except ClientError as e:
        if e.response["Error"]["Code"] not in ("NoSuchBucket","404"):
            raise
    state["cleaned"]=z(utc())
    save(state)
    print("Cleanup verified. No tagged instances or EBS volumes remain. Pilot bucket removed.")


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("action",choices=["check","run","launch","status","collect","cleanup"])
    a=p.parse_args()
    package()
    import boto3
    import botocore.config
    session=boto3.Session(region_name=REGION)
    # Use an explicit regional SigV4 endpoint for both private object transfers.
    original=session.client
    def client(service):
        if service=="s3":
            return original(service,config=botocore.config.Config(signature_version="s3v4",s3={"us_east_1_regional_endpoint":"regional"}))
        return original(service)
    session.client=client
    if a.action=="check":
        preflight(session)
    elif a.action=="launch":
        launch(session)
    elif a.action=="run":
        if not STATE.exists():
            launch(session)
        state=get_state(session)
        if state.get("cleaned"):
            raise SystemExit("This run was already cleaned up. Its evidence is in pilot-receipt.json if a receipt arrived.")
        if "stack" not in state:
            raise SystemExit("Previous launch stopped before stack ID was recorded. Run cleanup to reconcile it.")
        try:
            collect(session,state)
        except SystemExit:
            cleanup(session,state)
            raise
        cleanup(session,state)
    else:
        state=get_state(session)
        {"status":status,"collect":collect,"cleanup":cleanup}[a.action](session,state)


if __name__=="__main__":
    main()
