#!/usr/bin/env bash
set -eu
cd "$HOME/tg-community-run"
python3 - <<'PY'
import base64, gzip, hashlib, json, shlex, time
import cloudshell as c
host = c.host_and_volume("tg-grh-source-replay")["Instance"]
if host != "i-0e7d3f1a40dbca69c":
    raise SystemExit("Unexpected EC2 instance")
state = c.aws("ec2","describe-instances","--instance-ids",host)["Reservations"][0]["Instances"][0]["State"]["Name"]
if state != "running":
    raise SystemExit("Instance is " + state + ". No restart was requested. A copied source log is needed for module timings.")
online = c.aws("ssm","describe-instance-information","--filters","Key=InstanceIds,Values="+host)["InstanceInformationList"]
if not any(r["InstanceId"] == host and r["PingStatus"] == "Online" for r in online):
    raise SystemExit("Instance has no online SSM agent. No restart was requested.")
source = "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"
program = "import base64,gzip,hashlib; p=gzip.decompress(base64.b64decode('"+source+"')); assert hashlib.sha256(p).hexdigest()=='8625723a6264aa9f418459d8e7c036e64935279dd8e8a75c5344dc852ea39e8c'; exec(compile(p,'retained_lake_timings.py','exec'))"
command = shlex.join(["timeout","45","nice","-n","19","python3","-B","-c",program])
req = c.aws("ssm","send-command","--instance-ids",host,"--document-name","AWS-RunShellScript","--parameters",json.dumps({"commands":[command],"executionTimeout":["55"]}))
cid = req["Command"]["CommandId"]
for _ in range(28):
    states = c.aws("ssm","list-command-invocations","--command-id",cid,"--details")["CommandInvocations"]
    if states and states[0]["Status"] not in ("Pending","InProgress","Delayed","Cancelling"):
        response = c.aws("ssm","get-command-invocation","--command-id",cid,"--instance-id",host)
        if response["Status"] != "Success":
            raise SystemExit("Read-only timing retrieval " + response["Status"] + ": " + response.get("StandardErrorContent","")[-700:] + " command " + cid)
        label,digest,chunk = response["StandardOutputContent"].strip().split()
        if label != "TG_LAKE_TIMINGS_V1":
            raise SystemExit("Missing timing marker")
        data = gzip.decompress(base64.b64decode(chunk,validate=True))
        if hashlib.sha256(data).hexdigest() != digest:
            raise SystemExit("Timing summary digest mismatch")
        obj = json.loads(data)
        if (obj["attempt"],obj["commit"],obj["tree"]) != ("d69a0b0ad9464dbc84198f6c547221c7","0b68b493791e5f7569021f0cd13454151af47584","6d8764b58d1a41584cd5d43fd3e400f6ee55d18e"):
            raise SystemExit("Mismatched attempt")
        print(data.decode())
        break
    time.sleep(3)
else:
    raise SystemExit("Poll the existing SSM command "+cid+"; no duplicate was sent.")
PY
