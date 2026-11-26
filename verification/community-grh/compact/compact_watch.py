#!/usr/bin/env python3
"""Read a single compact EC2 attempt using SSM while online and its console on stop."""
import argparse
import json
import os
import zlib
import hashlib
from pathlib import Path
import re
import subprocess
import sys
import time

from compact_collect import aws, console_text, read_summary, console_full, save_full, REFERENCE_MARKER, SUMMARY_MARKER

NAME = re.compile(r"[0-9a-f]+")
REMOTE = """set -eu
attempt=/work/compact-joint-runs/@COMMIT@-@ATTEMPT@
if ! test -d "$attempt"; then printf '%s\\n' 'waiting for attempt directory'; exit; fi
if ! test -r "$attempt/run/evidence/receipt.json"; then
  tail -n 1 "$attempt/driver.log" 2>/dev/null | cut -c1-240 || :
  exit
fi
python3 - "$attempt/run/evidence" <<'TG_STATUS'
import json, sys
from pathlib import Path
p=Path(sys.argv[1]); r=json.loads((p/'receipt.json').read_text())
d={'status':r.get('status'),'steps':len(r.get('steps',[]))}
if r.get('steps'):
    s=r['steps'][-1]; d.update(stage=s.get('name'),stage_exit=s.get('exit'))
    log=p/(s['name']+'.log')
    if log.is_file():
        with log.open('rb') as f:
            f.seek(0,2); f.seek(max(0,f.tell()-8192)); lines=f.read().decode(errors='replace').splitlines()
        if lines: d['last_log_line']=lines[-1][:240]
print(json.dumps(d,ensure_ascii=True))
TG_STATUS
"""

def matching_references(raw, commit, attempt):
    prefix = f"/work/compact-joint-runs/{commit}-{attempt}/"
    allowed={prefix+"run/evidence/receipt.json",prefix+"startup-receipt.json"}
    return [m for m in REFERENCE_MARKER.finditer(console_text(raw)) if m.group(1) in allowed]

def exact_reference(raw, commit, attempt):
    refs=matching_references(raw,commit,attempt)
    if len({m.groups() for m in refs})>1:
        raise ValueError("Conflicting full receipt references for this attempt")
    return refs[-1].groups() if refs else None

def exact_receipt(raw, commit, tree, attempt):
    expected=exact_reference(raw,commit,attempt)
    if not expected:return None
    text=console_text(raw)
    refs=list(REFERENCE_MARKER.finditer(text))
    for i in range(len(refs)-1,-1,-1):
        ref=refs[i]
        if ref.groups()!=expected:continue
        piece=text[ref.start():refs[i+1].start() if i+1<len(refs) else None]
        try: summary,payload=read_summary(piece,commit,tree)
        except (ValueError,OSError,EOFError,zlib.error):continue
        if (summary.get("receipt_path"),summary.get("receipt_sha256"))==expected:
            return summary,payload
    return None

def preserve_console(text,attempt):
    raw=text.encode("utf-8")
    name=Path("compact-console-"+attempt+"-"+hashlib.sha256(raw).hexdigest()[:16]+".txt")
    try:
        fd=os.open(name,os.O_WRONLY|os.O_CREAT|os.O_EXCL,0o600)
    except FileExistsError:
        if name.is_symlink() or name.read_bytes()!=raw:raise ValueError("Local transcript path conflict")
    else:
        with os.fdopen(fd,"wb") as f:f.write(raw)
    return name

def reference_diagnostic(raw,commit,attempt):
    text=console_text(raw)
    matched=matching_references(raw,commit,attempt)
    if not matched:return []
    selected=matched[-1]
    start=max(0,selected.start()-10000)
    previous=[m.end() for m in REFERENCE_MARKER.finditer(text,0,selected.start())]
    if previous:start=max(start,previous[-1])
    before=text[start:selected.start()]
    hints=[]
    path=f"/work/compact-joint-runs/{commit}-{attempt}/"
    stage=re.compile(r"\b\d{4}-\d\d-\d\dT\d\d:\d\d:\d\dZ ([A-Za-z0-9_-]{1,80})\s*$")
    for line in before.splitlines():
        m=stage.search(line)
        if m:
            hints.append("stage "+m.group(1))
        elif path in line and re.search(r"\bfailed with -?\d+\b",line):
            # Return only the stage and numeric exit, never arbitrary surrounding console text.
            match=re.search(r"\b([A-Za-z0-9_-]{1,80}) failed with (-?\d+)\b",line)
            if match:hints.append("error "+match.group(1)+" exit "+match.group(2))
    return hints[-3:]

def live(instance, commit, attempt):
    managed = aws("ssm", "describe-instance-information", "--filters", "Key=InstanceIds,Values="+instance)["InstanceInformationList"]
    if not any(row.get("InstanceId")==instance and row.get("PingStatus")=="Online" for row in managed):
        return "SSM is not online"
    words = REMOTE.replace("@COMMIT@", commit).replace("@ATTEMPT@", attempt)
    request = aws("ssm", "send-command", "--instance-ids", instance, "--document-name", "AWS-RunShellScript",
                  "--timeout-seconds", "30", "--parameters", json.dumps({"commands":[words],"executionTimeout":["20"]}))
    command = request["Command"]["CommandId"]
    for _ in range(5):
        time.sleep(4)
        rows = aws("ssm","list-command-invocations","--command-id",command,"--details")["CommandInvocations"]
        if not rows or rows[0]["Status"] in {"Pending","InProgress","Delayed"}:
            continue
        row = rows[0]
        return ((row.get("CommandPlugins") or [{}])[0].get("Output","").strip() or row["Status"])[:500]
    return "SSM status request still pending"

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--instance",required=True);p.add_argument("--commit",required=True)
    p.add_argument("--tree",required=True);p.add_argument("--attempt",required=True)
    p.add_argument("--watch",action="store_true")
    a=p.parse_args()
    if not re.fullmatch("i-[0-9a-f]{17}",a.instance) or not all(NAME.fullmatch(x) and len(x)==n for x,n in [(a.commit,40),(a.tree,40),(a.attempt,32)]):
        p.error("Supply the full instance, commit, tree and attempt IDs")
    stack = aws("cloudformation","describe-stack-resource","--stack-name","tg-grh-source-replay","--logical-resource-id","Host")
    if stack["StackResourceDetail"]["PhysicalResourceId"]!=a.instance:
        p.error("The instance differs from the retained stack host")
    stopped_at=None; previous=None
    while True:
        state = aws("ec2","describe-instances","--instance-ids",a.instance)["Reservations"][0]["Instances"][0]["State"]["Name"]
        serial=aws("ec2","get-console-output","--instance-id",a.instance,"--latest").get("Output") or ""
        try:
            reference=exact_reference(serial,a.commit,a.attempt)
            result=exact_receipt(serial,a.commit,a.tree,a.attempt)
        except ValueError as exc:
            saved=preserve_console(serial,a.attempt)
            sys.exit(f"EC2 {state} | unverified: {exc} | raw console: {saved}")
        full=None
        if reference:
            try:full=console_full(serial,a.commit,a.tree,a.attempt,reference,result[0] if result else None)
            except ValueError as exc:
                saved=preserve_console(serial,a.attempt)
                print("Full receipt unverified:",str(exc),"| raw console:",saved,flush=True)
            if full:
                print("Saved verified full receipt:",save_full(full,a.attempt),flush=True)
                if not result:
                    record,_=full
                    print("Terminal status from verified full receipt:",record["status"])
                    print("Full receipt SHA-256:",reference[1])
                    return
        if result:
            s,raw=result
            out=Path("compact-receipt-"+a.attempt+".json")
            if out.exists() and out.read_bytes()!=raw:
                sys.exit("A different receipt already exists at "+str(out))
            if not out.exists(): out.write_bytes(raw)
            for k in ["status","error","failure_details","baseline_elapsed_seconds","within_330_minutes","profile_outcome","receipt_sha256"]:
                if k in s: print(k, json.dumps(s[k],ensure_ascii=True))
            print("Saved",out)
            return
        if reference:
            saved=preserve_console(serial,a.attempt)
            status="EC2 "+state+" | terminal mathematical status unverified | raw console "+str(saved)
            if status!=previous:
                print(status,flush=True)
                print("TG435_REF_ONLY",*reference,flush=True)
                for hint in reference_diagnostic(serial,a.commit,a.attempt):print("Nearby log (unverified):",hint,flush=True)
            if state in {"stopped","terminated"} or not a.watch:return 2
            previous=status
            time.sleep(60)
            continue
        status = state
        if state=="running":
            try: status += " | "+live(a.instance,a.commit,a.attempt)
            except subprocess.CalledProcessError as e: status += " | SSM query failed "+str(e.returncode)
        if status!=previous:
            print(time.strftime("%Y-%m-%d %H:%M:%S UTC",time.gmtime()),status,flush=True);previous=status
        if state in {"stopped","terminated","shutting-down"}:
            stopped_at=stopped_at or time.monotonic()
            if not a.watch or time.monotonic()-stopped_at>=300:sys.exit("No matching console receipt yet; retry the same command later.")
        if not a.watch:return
        time.sleep(60)

if __name__=="__main__":
    sys.exit(main())
