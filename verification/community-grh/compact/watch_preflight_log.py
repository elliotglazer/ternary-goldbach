#!/usr/bin/env python3
"""Collect one source preflight incrementally from its already-running AWS worker."""
import argparse
import base64
import gzip
import hashlib
import io
import json
import os
from pathlib import Path
import re
import shlex
import subprocess
import sys
import tempfile
import time

HOST = "i-0e7d3f1a40dbca69c"
LIMIT = 64 * 1024**2
WINDOW = 192 * 1024

REMOTE = r"""
import base64,gzip,hashlib,json,os,sys
from pathlib import Path
pin,attempt,tree,off,prefix=sys.argv[1:]; off=int(off)
base=Path('/work/compact-joint-runs')/(pin+'-'+attempt)/'run'
receipt=base/'evidence/receipt.json'
log=base/'evidence/source-preflight.log'
def emit(value):
    print(json.dumps(value,separators=(',',':')))
def regular(p):
    if p.resolve(strict=True)!=p or not p.is_file(): raise ValueError('unexpected evidence path')
def run():
    if not receipt.exists():
        emit({'waiting':'attempt receipt not yet present'});return
    regular(receipt)
    if receipt.stat().st_size>2*1024**2: raise ValueError('receipt size limit')
    r=json.loads(receipt.read_bytes())
    if (r.get('root'),r.get('pin'),r.get('git_tree'))!=(str(base),pin,tree):
        raise ValueError('receipt identities differ')
    stages=[s for s in r['steps'] if s['name']=='source-preflight']
    if len(stages)>1: raise ValueError('ambiguous source-preflight stage')
    if not stages or not log.exists():
        if r.get('status') in ('failed','verified'):
            raise ValueError('terminal attempt has no source-preflight log')
        emit({'waiting':'source preflight has not opened its log'});return
    regular(log)
    s=stages[0]
    digest=hashlib.sha256()
    with log.open('rb') as fp:
        length=os.fstat(fp.fileno()).st_size
        if not 0<=off<=length<=64*1024**2: raise ValueError('source log shrank or exceeds limit')
        remaining=off
        while remaining:
            buf=fp.read(min(65536,remaining))
            if not buf: raise ValueError('short prefix read')
            digest.update(buf);remaining-=len(buf)
        if digest.hexdigest()!=prefix: raise ValueError('source log prefix differs')
        chunk=fp.read(min(length-off,192*1024))
    if len(chunk)!=min(length-off,192*1024):raise ValueError('short source log read')
    packed=gzip.compress(chunk,mtime=0)
    while len(packed)>12000:
        chunk=chunk[:len(chunk)//2];packed=gzip.compress(chunk,mtime=0)
    digest.update(chunk)
    whole=s.get('log_sha256')
    if s.get('exit') is not None and not whole:raise ValueError('closed source stage lacks checksum')
    if whole and off+len(chunk)==length and digest.hexdigest()!=whole:
        raise ValueError('terminal receipt differs from source log')
    emit({'attempt':attempt,'pin':pin,'tree':tree,'status':r.get('status'),'stage_exit':s.get('exit'),
          'terminal_log_sha256':whole,'available_bytes':length,'offset':off,'chunk_bytes':len(chunk),
          'prefix_sha256':prefix,'next_prefix_sha256':digest.hexdigest(),
          'chunk_sha256':hashlib.sha256(chunk).hexdigest(),'gzip':base64.b64encode(packed).decode()})
run()
"""

ANSI = re.compile(r"\x1b\[[0-?]*[ -/]*[@-~]")
HEADER = re.compile(r"^\S+\s+\[\d+/\d+\]\s+(?:Built|Building|Replayed|Replaying|Ran|Running|Compiled|Compiling)\s+(\S+)")
ERROR = re.compile(r"^(?:error:\s+.+?\.lean:\d+:\d+:\s*|.+?\.lean:\d+:\d+:\s*error:)")
OTHER = re.compile(r"^(?:error:|warning:|info:|trace:|note:|.+?\.lean:\d+:\d+:\s*(?:warning|info|trace):)")
FOOTER = "Some required targets logged failures:"


def require(test, message):
    if not test:
        raise ValueError(message)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def findings(data, terminal=False):
    # Classify a block only after observing its successor or the hashed final file.
    records = {}
    active = None
    block = []
    footer = False

    def finish():
        if active is not None and block:
            raw = "".join(block)
            entry = records[active]
            if entry.get("first_error") is None:
                entry["first_error"] = raw
            if entry.get("first_goal") is None and ("⊢" in raw or "unsolved goals" in raw):
                entry["first_goal"] = raw
        block.clear()

    for original in data.decode("utf-8", errors="replace").splitlines(keepends=True):
        if not terminal and not original.endswith(("\n", "\r")):
            break
        line = ANSI.sub("", original).rstrip("\r\n")
        match = HEADER.match(line)
        if match:
            finish()
            footer = False
            active = match.group(1) if line.startswith(("✖", "×", "✗")) else None
            if active is not None:
                records.setdefault(active, {})
        elif line.strip() == FOOTER:
            finish()
            active = None
            footer = True
        elif footer and re.match(r"^\s*-\s+\S+",line):
            records.setdefault(line.split("-",1)[1].strip(), {})
        elif ERROR.match(line):
            finish()
            if active is not None:
                block.append(original)
        elif OTHER.match(line):
            finish()
        elif block:
            block.append(original)
    if terminal:
        finish()
    return records


def decode_page(page, pin, tree, attempt, offset, prefix):
    require((page["pin"],page["tree"],page["attempt"],page["offset"],page["prefix_sha256"])==
            (pin,tree,attempt,offset,prefix.hexdigest()), "Changed source, attempt, or prefix")
    size = page["available_bytes"]
    require(offset <= size <= LIMIT, "Unexpected source log size")
    packed = base64.b64decode(page["gzip"],validate=True)
    require(len(packed) <= 12000, "Unexpected transfer size")
    with gzip.GzipFile(fileobj=io.BytesIO(packed)) as stream:
        raw = stream.read(WINDOW+1)
    require(len(raw)==page["chunk_bytes"]<=min(size-offset,WINDOW) and sha(raw)==page["chunk_sha256"],
            "Incomplete or corrupt log chunk")
    require(raw or offset == size, "Read made no progress")
    next_prefix = prefix.copy()
    next_prefix.update(raw)
    require(next_prefix.hexdigest()==page["next_prefix_sha256"], "Accumulated log digest mismatch")
    terminal = page["stage_exit"] is not None and offset+len(raw)==size
    if terminal:
        require(next_prefix.hexdigest()==page["terminal_log_sha256"], "Terminal log SHA-256 mismatch")
    return raw, next_prefix, terminal


def aws(*args):
    payload = subprocess.check_output(["aws","--region","us-east-1","--no-cli-pager","--output","json",*args])
    return json.loads(payload)


def read_page(pin, tree, attempt, size, digest):
    req = shlex.join(["timeout","35","nice","-n","19","python3","-B","-c",REMOTE,
                      pin,attempt,tree,str(size),digest])
    request = aws("ssm","send-command","--instance-ids",HOST,"--document-name","AWS-RunShellScript",
                  "--timeout-seconds","35","--parameters",json.dumps({"commands":[req],"executionTimeout":["40"]}))
    cid = request["Command"]["CommandId"]
    for _ in range(32):
        rows = aws("ssm","list-command-invocations","--command-id",cid)["CommandInvocations"]
        if rows and rows[0]["Status"] not in {"Pending","InProgress","Delayed","Cancelling"}:
            detail = aws("ssm","get-command-invocation","--command-id",cid,"--instance-id",HOST)
            require(detail["Status"]=="Success" and detail["ResponseCode"]==0,
                    "SSM read " + cid + " failed: " + detail.get("StandardErrorContent","")[-800:])
            return json.loads(detail["StandardOutputContent"])
        time.sleep(2)
    raise ValueError("SSM read still pending: " + cid)


def report(now, seen):
    for target, record in now.items():
        previous = seen.get(target)
        if previous is None:
            print("Failed target", target,flush=True)
        for field in ("first_error","first_goal"):
            value=record.get(field)
            if value is not None and (previous or {}).get(field)!=value:
                if field=="first_goal" and value==record.get("first_error"):
                    continue
                print(value, end="" if value.endswith("\n") else "\n",flush=True)


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--commit",required=True)
    parser.add_argument("--tree",required=True)
    parser.add_argument("--attempt",required=True)
    parser.add_argument("--once",action="store_true",help="collect through the current readable end")
    args=parser.parse_args()
    for text,size in [(args.commit,40),(args.tree,40),(args.attempt,32)]:
        require(re.fullmatch("[0-9a-f]{"+str(size)+"}",text),"Use full lowercase source and attempt IDs")
    os.umask(0o077)
    output=Path(tempfile.mkdtemp(prefix="tg-preflight-"+args.attempt[:8]+"-",dir=Path.home()))
    print("Capturing this attempt in",output,flush=True)
    logfile=output/"source-preflight.log"
    index=output/"failures.json"
    digest=hashlib.sha256()
    offset=0
    seen={}
    previous_state=None
    with logfile.open("xb") as log:
        while True:
            state=aws("ec2","describe-instances","--instance-ids",HOST)["Reservations"][0]["Instances"][0]["State"]["Name"]
            require(state=="running", "EC2 "+state+"; retained fetched bytes in "+str(output))
            page=read_page(args.commit,args.tree,args.attempt,offset,digest.hexdigest())
            if "waiting" in page:
                if previous_state!=page["waiting"]:print(page["waiting"],flush=True)
                previous_state=page["waiting"]
                if args.once:return
                time.sleep(45)
                continue
            raw,digest,terminal=decode_page(page,args.commit,args.tree,args.attempt,offset,digest)
            if raw:
                with (output/f"{offset:012d}-{offset+len(raw):012d}.chunk").open("xb") as chunk:
                    chunk.write(raw)
                log.write(raw)
                log.flush()
                offset+=len(raw)
            if raw or terminal or not index.exists():
                current=findings(logfile.read_bytes(),terminal)
                report(current,seen)
                seen=current
                result={"commit":args.commit,"tree":args.tree,"attempt":args.attempt,"stage":"source-preflight",
                        "verified_bytes":offset,"prefix_sha256":digest.hexdigest(),"source_stage_exit":page["stage_exit"],
                        "complete":terminal,"terminal_log_sha256":page["terminal_log_sha256"],"failed_targets":seen}
                tmp=output/"failures.tmp"
                tmp.write_text(json.dumps(result,ensure_ascii=False,indent=2)+"\n")
                tmp.replace(index)
            if terminal or args.once and offset==page["available_bytes"]:
                print("Captured",offset,"bytes; source stage exit",page["stage_exit"],"SHA-256",digest.hexdigest(),flush=True)
                print("Download",index,"or",logfile,flush=True)
                return
            if offset==page["available_bytes"]:
                time.sleep(45)


if __name__=="__main__":
    try:
        main()
    except (KeyError,OSError,ValueError,subprocess.CalledProcessError) as error:
        sys.exit("Preflight collection stopped: "+str(error))
