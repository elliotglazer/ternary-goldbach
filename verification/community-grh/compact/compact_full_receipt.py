#!/usr/bin/env python3
"""Fetch one retained compact receipt to CloudShell using read-only SSM commands."""
import argparse
import base64
import gzip
import hashlib
import io
import json
from pathlib import Path
import re
import time
import sys

from compact_collect import aws
from compact_watch import exact_receipt, exact_reference

BLOCK = 12000
LIMIT = 8 * 1024 * 1024
REMOTE = """set -eu
mountpoint -q /work
dev=$(findmnt -n -o SOURCE --target /work)
test "$(lsblk -dnro SERIAL "$dev" | tr -d '[:space:]-')" = '@VOLUME@'
python3 - '@PATH@' '@SHA@' '@OFFSET@' <<'TG_READ'
import base64,gzip,hashlib,json,sys
from pathlib import Path
p=Path(sys.argv[1])
if p.resolve(strict=True)!=p or not p.is_file() or p.stat().st_size>8388608:
    raise SystemExit("unexpected receipt file")
data=p.read_bytes()
if len(data)>8388608 or hashlib.sha256(data).hexdigest()!=sys.argv[2]:
    raise SystemExit("retained receipt differs from the authenticated console reference")
packed=gzip.compress(data,mtime=0);offset=int(sys.argv[3])
print(json.dumps({"sha256":sys.argv[2],"bytes":len(data),"packed":len(packed),"offset":offset,
                  "data":base64.b64encode(packed[offset:offset+12000]).decode()}))
TG_READ
"""

def ssm_output(instance, command):
    request=aws("ssm","send-command","--instance-ids",instance,"--document-name","AWS-RunShellScript",
                "--timeout-seconds","30","--parameters",json.dumps({"commands":[command],"executionTimeout":["20"]}))
    cid=request["Command"]["CommandId"]
    for _ in range(28):
        time.sleep(2)
        inv=aws("ssm","list-command-invocations","--command-id",cid)["CommandInvocations"]
        if not inv or inv[0]["Status"] in ("Pending","InProgress","Delayed"):continue
        details=aws("ssm","get-command-invocation","--command-id",cid,"--instance-id",instance)
        if details["Status"]!="Success" or details["ResponseCode"]!=0:
            raise ValueError("Read-only SSM receipt request failed: "+details.get("StandardErrorContent","")[:500])
        return json.loads(details["StandardOutputContent"])
    raise TimeoutError("Receipt request is still pending in SSM: "+cid)

def recover(read, summary):
    packed=bytearray(); compressed_size=None
    while compressed_size is None or len(packed)<compressed_size:
        chunk=read(len(packed))
        if (chunk["sha256"]!=summary["receipt_sha256"] or chunk["offset"]!=len(packed)
            or not 0<chunk["packed"]<=LIMIT+65536 or not 0<chunk["bytes"]<=LIMIT
            or compressed_size is not None and compressed_size!=chunk["packed"]):
            raise ValueError("Inconsistent receipt chunk")
        compressed_size=chunk["packed"]
        piece=base64.b64decode(chunk["data"],validate=True)
        if len(piece)!=min(BLOCK,compressed_size-len(packed)): raise ValueError("Wrong receipt chunk length")
        packed.extend(piece)
    with gzip.GzipFile(fileobj=io.BytesIO(packed)) as fp: raw=fp.read(LIMIT+1)
    if len(raw)!=chunk["bytes"] or hashlib.sha256(raw).hexdigest()!=summary["receipt_sha256"]:
        raise ValueError("Full receipt checksum or size mismatch")
    r=json.loads(raw)
    if r.get("status") not in {"verified","failed"}:raise ValueError("Full receipt is not terminal")
    if summary.get("status") is not None and r["status"]!=summary["status"]:raise ValueError("Terminal statuses differ")
    if summary.get("status") is None and (r.get("pin")!=summary["commit"] or r.get("git_tree")!=summary["tree"]):
        raise ValueError("The reference-only receipt cannot establish the internal proof pins")
    if not summary["receipt_path"].endswith("/startup-receipt.json"):
        if r.get("pin")!=summary["commit"] or r.get("git_tree")!=summary["tree"]:
            raise ValueError("Full receipt proof pins differ")
    return raw

def main():
    p=argparse.ArgumentParser(description=__doc__)
    for param in ["instance","commit","tree","attempt"]:p.add_argument("--"+param,required=True)
    p.add_argument("--console-file",type=Path,help="previously saved raw or base64 EC2 serial output")
    a=p.parse_args()
    if not re.fullmatch("i-[0-9a-f]{17}",a.instance) or not all(re.fullmatch("[0-9a-f]{"+str(n)+"}",v) for v,n in [(a.commit,40),(a.tree,40),(a.attempt,32)]):
        p.error("Use the exact instance, commit, tree and attempt IDs")
    info=aws("cloudformation","describe-stacks","--stack-name","tg-grh-source-replay")["Stacks"][0]
    outputs={o["OutputKey"]:o["OutputValue"] for o in info["Outputs"]}
    if outputs.get("Instance")!=a.instance or not re.fullmatch(r"vol-[0-9a-f]{17}",outputs.get("Evidence","")):
        p.error("Unexpected retained stack instance or volume")
    text=a.console_file.read_text() if a.console_file else (aws("ec2","get-console-output","--instance-id",a.instance,"--latest").get("Output") or "")
    res=exact_receipt(text,a.commit,a.tree,a.attempt)
    ref=exact_reference(text,a.commit,a.attempt)
    if not ref:p.error("The exact attempt's full receipt reference is unavailable")
    summary=res[0] if res else {"commit":a.commit,"tree":a.tree,"receipt_path":ref[0],"receipt_sha256":ref[1]}
    digest=summary["receipt_sha256"]
    if not re.fullmatch("[0-9a-f]{64}",digest): p.error("Invalid expected full SHA-256")
    out=Path("compact-full-receipt-"+a.attempt+".json")
    if out.exists():
        if hashlib.sha256(out.read_bytes()).hexdigest()!=digest:sys.exit("Different local file already exists")
        print("Already verified",out,digest);return
    file=summary["receipt_path"];vol=outputs["Evidence"]
    host=aws("ec2","describe-instances","--instance-ids",a.instance)["Reservations"][0]["Instances"][0]
    if host["State"]["Name"]!="running":p.error("Instance must already be running; this program does not start it")
    if vol not in [b.get("Ebs",{}).get("VolumeId") for b in host["BlockDeviceMappings"]]:p.error("Evidence volume attachment differs")
    online=aws("ssm","describe-instance-information","--filters","Key=InstanceIds,Values="+a.instance)["InstanceInformationList"]
    if not any(x.get("InstanceId")==a.instance and x.get("PingStatus")=="Online" for x in online):p.error("SSM is offline")
    command=REMOTE.replace("@VOLUME@",vol.replace("-","")).replace("@PATH@",file).replace("@SHA@",digest)
    raw=recover(lambda offset:ssm_output(a.instance,command.replace("@OFFSET@",str(offset))),summary)
    with out.open("xb") as f:f.write(raw)
    print("Full receipt verified",out,len(raw),"bytes",digest,"status",json.loads(raw)["status"])

if __name__=="__main__":main()
