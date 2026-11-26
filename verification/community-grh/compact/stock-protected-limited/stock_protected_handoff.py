#!/usr/bin/env python3
"""Run a fresh stock cgroup probe, source intake, and protected judgment in one qualified session."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time

WORKER_SHA = "ccc1bb35f52535e7167b4e9592dfa5daf618900cc091a75d6fcbce43733e635d"
PROBE_SHA = "a24992ee326a5314160ea0e5eece28116d8a08a7605396dd90da55e1411a5413"
POLICY = "14aa8d6b3c2f14a8540605e37144560b9a00e7e7"
PROFILE = "palomar-namespace-32x64-v1"
WINDOW_OPEN = 1795689000
DEADLINE = 1795712400
BUDGET = 19800
WORKFLOW_SECONDS = 21000
GIB = 1024**3

def check(ok,message):
    if not ok:
        raise ValueError(message)

def sha(path):
    with path.open("rb") as inp:
        return hashlib.file_digest(inp,"sha256").hexdigest()

def save(path,values):
    with path.open("x") as out:
        json.dump(values,out,indent=2,sort_keys=True)
        out.write("\n")

def verify_probe(report,uid,outer_leaf):
    check(report["policy"]==POLICY and report["profile"]==PROFILE,"Stock probe identity mismatch")
    flags=report["classification"]
    must=("outer_selected_profile","stock_phase","phase_cpu_32","phase_memory_limits",
          "phase_has_zero_swap_cgroup","aggregate_32x64_swap0")
    check(all(flags.get(k) is True for k in must),"No measured 32-CPU/64-GiB aggregate bound across outer and stock phase")
    outer,inner=report["outer"],report["inner"]
    check(outer["uid"]==inner["uid"]==uid and outer["leaf"]==str(outer_leaf),
          "Stock measurement was taken in a different session")
    check(outer["cpu"]==inner["cpu"]==32 and outer["memory"]==64*GIB,"Unexpected observed host")
    common=set(outer["ancestors"]) & set(inner["ancestors"])
    for key in ("common_memory64_enforced_by","common_cpu32_enforced_by","common_swap0_enforced_by"):
        paths=flags.get(key,[])
        check(paths and all(p in common and outer_leaf.is_relative_to(p) and Path(inner["leaf"]).is_relative_to(p) for p in paths),
              "Missing common cgroup ancestor")
    check(report["stock_status"]["state"]=="finished" and report["stock_status"]["placement_ok"] is True
          and report["stock_status"]["exit_status"]==0,"Stock placement control did not exit successfully")

def main():
    p=argparse.ArgumentParser(description=__doc__)
    for name in ("clock","scratch","probe","worker","bwrap","bundle"):
        p.add_argument("--"+name,type=Path,required=True)
    a=p.parse_args()
    check(sys.version_info[:3]==(3,11,10) and os.geteuid()!=0,"Need the unprivileged verified runtime")
    cf=a.clock.resolve(strict=True)
    check(cf.stat().st_uid==0 and cf.stat().st_mode & 0o022==0,"Untrusted job clock")
    clock=json.loads(cf.read_bytes())
    start=clock["job_started_at_epoch"]
    now=int(time.time())
    check(clock["mode"]=="protected" and clock["host_deadline_epoch"]==DEADLINE and
          re.fullmatch("[0-9a-f]{40}",clock["commit"]) and re.fullmatch("[0-9a-f]{40}",clock["tree"]),"Invalid planned proof identity")
    outer = clock.get("local_outer_cutoff_epoch")
    check(type(start) is int and WINDOW_OPEN <= start <= now < start+BUDGET, "Invalid original verification clock")
    if outer is None:
        check(start+BUDGET <= DEADLINE, "Full original stock verification window does not fit")
    else:
        check(type(outer) is int and start+60 <= outer <= min(start+BUDGET, DEADLINE-180)
              and now < outer and clock.get("origin_marker_sha256"), "Invalid local cutoff or missing trusted origin")
    check(clock["boot_id"]==Path("/proc/sys/kernel/random/boot_id").read_text().strip(),"Job clock belongs to another boot")
    check(clock["aggregate_profile_verified"] is True, "Require operator's completed aggregate-envelope qualification")
    check(clock["setup_basis"] in ("original-before-trusted-setup","preprovisioned"),"Specify the timing basis")
    check(sha(a.probe)==PROBE_SHA and sha(a.worker)==WORKER_SHA,"Trusted handoff or resource probe digest mismatch")
    # Record the real deadline before any validator, source or package checkout in this invocation.
    env=os.environ.copy()
    env.update(PALOMAR_EXECUTION_PROFILE=PROFILE,PALOMAR_JOB_STARTED_AT=str(start),PYTHONDONTWRITEBYTECODE="1",
               GIT_CONFIG_GLOBAL="/dev/null",GIT_CONFIG_NOSYSTEM="1",GIT_TERMINAL_PROMPT="0",GIT_OPTIONAL_LOCKS="0")
    root=a.scratch.resolve(strict=True)
    check(root.is_dir() and root.stat().st_uid==os.geteuid() and not list(root.iterdir()),"Provide an empty dedicated project directory")
    policy=root/"pipeline"; probe_dir=root/"stock-probe"; probe_dir.mkdir(mode=0o700)
    def run(cmd,finalize=False,**kw):
        rest=min(start+(WORKFLOW_SECONDS if finalize else BUDGET), DEADLINE, outer or DEADLINE)-time.time()
        check(rest>0,"Full-run window exhausted")
        return subprocess.run(cmd,env=env,check=True,timeout=rest,**kw)
    run(["git","init","-q",str(policy)])
    git=["git","-C",str(policy),"-c","core.hooksPath=/dev/null"]
    run([*git,"fetch","-q","--no-tags","--depth=1","https://github.com/PalomarRegistry/PalomarSubmission.git",POLICY])
    run([*git,"checkout","-q","--detach","FETCH_HEAD"])
    with (root/"stock-probe.log").open("x") as log:
        run([sys.executable,"-B",str(a.probe.resolve()),str(policy),str(probe_dir)],stdout=log,stderr=subprocess.STDOUT)
    paths=list(probe_dir.glob("stock-32x64-palomar-*.json"))
    check(len(paths)==1,"Probe must emit exactly one fresh raw stock report")
    receipt=paths[0]
    # Stock probe reports resolved cgroup filesystem paths, based on the same cgroup v2 proc mapping.
    cg=Path("/proc/self/cgroup").read_text().splitlines()
    mapping=next(x[3:] for x in cg if x.startswith("0::"))
    leaf=Path("/sys/fs/cgroup")/mapping.lstrip("/")
    verify_probe(json.loads(receipt.read_bytes()),os.getuid(),leaf)
    save(root/"verified-host.json",{"boot_id":clock["boot_id"],"job_start":start,"source_commit":clock["commit"],"source_tree":clock["tree"],
                                    "profile":PROFILE,"policy":POLICY,"clock_sha256":sha(cf),"probe_source_sha256":PROBE_SHA,
                                    "raw_probe_sha256":sha(receipt),"outer_cgroup":str(leaf),"setup_basis":clock["setup_basis"]})
    run([sys.executable,"-B",str(a.worker.resolve()),"protected","--commit",clock["commit"],"--tree",clock["tree"],
         "--directory",str(root/"proof"),"--clock",str(cf),"--policy",str(policy),"--bundle",str(a.bundle),"--bwrap",str(a.bwrap)],finalize=True)

if __name__=="__main__":
    main()
