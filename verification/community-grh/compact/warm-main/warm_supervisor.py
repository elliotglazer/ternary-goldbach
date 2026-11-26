#!/usr/bin/env python3
"""Run serial, bounded diagnostics on the existing warm EC2 host. Root-owned service code."""
import argparse
import fcntl
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time

BASE = "d6b1bfd523e2c54b6e4bb72844deeddf8341879a"
OLD = "33006912706042b49c1ddbc13515a4fb"
OLD_TREE = "ddc22b3144b7147ce91c5c767690d9d56aac50ee"
WORKER = "d9b3b1a3b1b4a97e7766349c0c6dfcc5e0eab6071935321482d2d91bdbaccf67"
PARENT_SHA = "5eca91028a75f56c21abfe6c9d189e5f2d02d2b6fc08997172dd2187eced650c"
DEADLINE = 1795688244
IDLE = 480
OLD_ROOT = Path("/work/compact-joint-runs") / (BASE+"-"+OLD) / "run"
RESULTS = Path("/work/tg-warm-diagnostics")
DISPATCH_LOCK = Path("/run/lock/tg-joint-dispatch.lock")
WORKER_LOCK = Path("/run/lock/tg-joint-worker.lock")
QUEUE_LOCK = Path("/run/lock/tg-warm-main-queue.lock")
QUEUE = Path("/var/lib/tg-warm-main/session-"+OLD)
BUNDLE = Path(__file__).resolve().parent
URL = "https://github.com/elliotglazer/ternary-goldbach.git"
TOKEN = re.compile(r"[0-9a-f]{32}\Z")
GIT_ID = re.compile(r"[0-9a-f]{40}\Z")
DIGEST = re.compile(r"[0-9a-f]{64}\Z")


def need(condition, reason):
    if not condition:
        raise ValueError(reason)


def hash_file(path):
    with path.open("rb") as fp:
        return hashlib.file_digest(fp,"sha256").hexdigest()


def lock_file(path, nonblocking=False):
    fp = path.open("a+")
    try:
        fcntl.flock(fp,fcntl.LOCK_EX | (fcntl.LOCK_NB if nonblocking else 0))
    except OSError:
        fp.close()
        raise
    return fp


def status(unit):
    q=subprocess.run(["systemctl","show","-p","ActiveState","--value",unit],
                     stdout=subprocess.PIPE,stderr=subprocess.DEVNULL,text=True)
    return q.stdout.strip()


def cold_inactive():
    return all(status(unit) in {"inactive","failed"} for unit in ("tg-source-replay.service","tg-joint-replay.service"))


def validate_request(r):
    need(set(r)=={"token","commit","tree","receipt_sha","checks","main"},"Unknown job fields")
    need(TOKEN.fullmatch(r["token"]) and GIT_ID.fullmatch(r["commit"]) and GIT_ID.fullmatch(r["tree"]),
         "Invalid immutable candidate or job token")
    need(r["receipt_sha"]==PARENT_SHA,"Parent digest differs from the authenticated console reference")
    need(type(r["main"]) is bool and (r["main"] or r["checks"]),"Empty warm job")
    need(isinstance(r["checks"],list) and len(r["checks"])<=12,"Invalid probe list")
    for row in r["checks"]:
        need(isinstance(row,list) and len(row)==2 and
             re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*",row[0]) and
             DIGEST.fullmatch(row[1]),"Invalid individual warm source")


def parent_receipt(expected):
    f=OLD_ROOT/"evidence/receipt.json"
    log=OLD_ROOT/"evidence/source-preflight.log"
    for p in (f,log):
        need(p.is_file() and p.resolve()==p,"Unexpected original evidence path")
    data=json.loads(f.read_bytes())
    need((data["root"],data["pin"],data["git_tree"],data["runner_sha256"],data["status"])==
         (str(OLD_ROOT),BASE,OLD_TREE,WORKER,"failed"),"Wrong original failed receipt")
    pre=[s for s in data["steps"] if s["name"]=="source-preflight"]
    need(len(pre)==1 and type(pre[0].get("exit")) is int and pre[0]["exit"]!=0,"Missing failed preflight")
    need(log.stat().st_size<=64*2**20 and pre[0]["log_sha256"]==hash_file(log),"Terminal source log digest")
    with log.open("rb") as fp:
        need(hashlib.sha256(fp.read(225471)).hexdigest()=="b6d44339383a7374cbf13106659674f9e841fb9e5812e696b16ecad07d175906",
             "Retained log disagrees with known 225471-byte snapshot")
    digest=hash_file(f)
    need(expected==PARENT_SHA==digest,"Full receipt differs from the authenticated console reference")
    return digest


def run(cmd, **options):
    remaining=int(DEADLINE-time.time()-75)
    need(remaining>=30,"Too close to scheduled stop")
    return subprocess.run(cmd,timeout=min(remaining,options.pop("timeout",7200)),**options)


def prepare_repo(commit, tree, job):
    repo=job/"candidate.git"
    run(["git","init","--bare","-q",str(repo)],check=True,timeout=20)
    git=["git","--git-dir="+str(repo),"-c","core.hooksPath=/dev/null"]
    run([*git,"-c","fetch.fsckObjects=true","fetch","--no-tags","--depth=1",URL,commit],check=True,timeout=180,
        env={"PATH":"/usr/bin:/bin","HOME":"/root","GIT_CONFIG_NOSYSTEM":"1","GIT_TERMINAL_PROMPT":"0"})
    ids=run([*git,"rev-parse","FETCH_HEAD","FETCH_HEAD^{tree}"],check=True,text=True,capture_output=True).stdout.split()
    need(ids==[commit,tree],"Fetched Git commit/tree differs")
    return repo


def job_result(path,obj):
    tmp=path.with_suffix(".tmp")
    tmp.write_text(json.dumps(obj,indent=2,sort_keys=True)+"\n")
    tmp.replace(path)


def handle(r):
    validate_request(r)
    job=QUEUE/"jobs"/r["token"]
    job.mkdir(mode=0o755)
    result={"job":r,"started_unix":time.time(),"kind":"warm diagnostics only"}
    dest=job/"status.json"
    try:
        rec=parent_receipt(r["receipt_sha"])
        result["old_receipt_sha256"]=rec
        repo=prepare_repo(r["commit"],r["tree"],job)
        os.chmod(repo,0o755)
        unpriv=["setpriv","--reuid=grhreplay","--regid=grhreplay","--init-groups","--",
                "env","HOME=/work/home","PATH=/usr/bin:/bin","PYTHONDONTWRITEBYTECODE=1"]
        # Serial phases share the same worker cgroup and lifetime. The compiler sandbox itself
        # binds all source and dependency inputs read-only.
        for module,expected in r["checks"]:
            rel=module.replace(".","/")+".lean"
            git=["git","--git-dir="+str(repo)]
            choices=[name for name in ("CompactGRH/src/"+rel,rel)
                     if run([*git,"cat-file","-e",r["commit"]+":"+name],capture_output=True).returncode==0]
            need(len(choices)==1,"Ambiguous or absent warm candidate module "+module)
            raw=run([*git,"show",r["commit"]+":"+choices[0]],check=True,capture_output=True).stdout
            need(hashlib.sha256(raw).hexdigest()==expected and len(raw)<=512*1024,"Candidate probe bytes differ")
            import base64,gzip
            encoded=base64.b64encode(gzip.compress(raw,mtime=0)).decode()
            cmd=[*unpriv,"python3","-B",str(BUNDLE/"warm_probe.py"),"--commit",BASE,"--tree",OLD_TREE,
                 "--attempt",OLD,"--module",module,"--patch-commit",r["commit"],"--sha256",expected,"--data",encoded]
            # The helper observes the warm-main aggregate but the individual compiler gets one
            # available CPU, low priority and a timeout. No simultaneous Main frontend is running.
            cpu=min(os.sched_getaffinity(0))
            with (job/(module+".log")).open("xb") as output:
                step=run(["timeout","--kill-after=5s","240","nice","-n","19","taskset","-c",str(cpu),
                          "prlimit","--as=12884901888:12884901888","--",*cmd],
                         stdout=output,stderr=subprocess.STDOUT,timeout=255)
            result.setdefault("probe_exits",{})[module]=step.returncode
            job_result(dest,result)
        if r["main"]:
            path=RESULTS/(r["commit"]+"-"+r["token"])
            command=[*unpriv,"python3","-B",str(BUNDLE/"warm_main.py"),"--commit",r["commit"],"--tree",r["tree"],
                     "--source-repo",str(repo),"--receipt-sha",rec,"--deadline-epoch",str(DEADLINE),"--output",str(path)]
            result["warm_main_output"]=str(path)
            job_result(dest,result)
            with (job/"warm-main-driver.log").open("xb") as out:
                step=run(command,stdout=out,stderr=subprocess.STDOUT)
            result["warm_main_exit"]=step.returncode
    except Exception as error:
        result["error"]=str(error)
    finally:
        result["finished_unix"]=time.time()
        job_result(dest,result)
    print(json.dumps(result,sort_keys=True),flush=True)


def next_job():
    queue=sorted((QUEUE/"pending").glob("*.json"),key=lambda f:(f.stat().st_mtime_ns,f.name))
    if not queue:
        return None
    job=queue[0]
    moved=QUEUE/"claimed"/job.name
    job.rename(moved)
    return json.loads(moved.read_bytes())


def supervise():
    need(os.geteuid()==0 and Path("/proc/self/cgroup").read_text().strip()=="0::/system.slice/tg-warm-main.service",
         "Expected the named diagnostic service")
    with lock_file(WORKER_LOCK,True):
        need(cold_inactive(),"A cold replay is active")
        idle_end=time.monotonic()+IDLE
        while time.time()<DEADLINE-120:
            with lock_file(QUEUE_LOCK):
                work=next_job()
            if work is not None:
                handle(work)
                idle_end=time.monotonic()+IDLE
                continue
            if time.monotonic()>=idle_end:
                break
            time.sleep(3)
        # Acquire both admission locks, check the queue once more before the idle decision.
        # The enqueue handler rejects new work once this boot has marked itself closed.
        with lock_file(DISPATCH_LOCK), lock_file(QUEUE_LOCK):
            if any((QUEUE/"pending").glob("*.json")) and time.time()<DEADLINE-180:
                return "retry"
            need(cold_inactive(),"A cold replay owns the host; warm supervisor will not power it off")
            (QUEUE/"closed").write_text(Path("/proc/sys/kernel/random/boot_id").read_text())
            subprocess.run(["sync"],check=True)
            subprocess.run(["systemctl","--no-block","poweroff"],check=True)
    return "done"


if __name__=="__main__":
    while supervise()=="retry":
        pass
