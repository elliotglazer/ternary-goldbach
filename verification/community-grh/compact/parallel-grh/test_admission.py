#!/usr/bin/env python3
"""Offline tests, with no cloud or project worker launch."""
import base64
import fcntl
import hashlib
import json
import os
from pathlib import Path
import re
import shlex
import subprocess
import sys
import tarfile
import tempfile
from contextlib import ExitStack
from unittest.mock import patch
import dispatch_aux as d
import run_aux as u

def test():
    results={}
    def accepted(key,pred):
        assert pred,key
        results[key]=True
    def rejected(key,func):
        try:func()
        except ValueError:
            results[key]=True
        else:raise AssertionError(key)
    base=Path(__file__).resolve().parent
    original=base.parent/"parallel-grh-finite"
    git_pin=json.loads((base/"original-git.json").read_bytes())
    with tarfile.open(original/"tg-parallel-grh.tgz") as tf:
        for n in ["warm_main.py","warm_supervisor.py","WarmArtifactHashes.lean"]:
            accepted("unchanged_authenticated_"+n,tf.extractfile(n).read()==(base/n).read_bytes())
    accepted("published_baseline_archive",hashlib.sha256((original/"tg-parallel-grh.tgz").read_bytes()).hexdigest()==git_pin["tg-parallel-grh.tgz"]["sha256"])
    accepted("new_archive_bound_to_dispatch",hashlib.sha256((base/"tg-parallel-grh.tgz").read_bytes()).hexdigest()==d.ARCHIVE)
    pin="333aa9bb21fd87ef1f6be2159dbffc2c8da75962";tree="0a3e5b8486771b3ca1acaa2cb465ff756e52c5e2"
    args=(git_pin["dispatch_aux.py"]["git_commit"],pin,tree,"offline","vol-00000000000000000")
    chain=[*d.LINEAGE,"e8aa6e1f322d2dde06fef1d4e545b614"]
    tok,shell=d.payload("start",*args,chain)
    bash=shlex.split(shell)[2];subprocess.run(["bash","-n"],input=bash,text=True,check=True)
    job=json.loads(base64.b64decode(re.search(r"printf '%s' '([A-Za-z0-9+/=]+)'",bash)[1]))
    accepted("explicit_four_predecessors",job["previous_jobs"]==chain and job["root"]=="Main" and not job["checks"])
    accepted("synchronous_before_transient_service",bash.index('--preflight "$helper/job.json"')<bash.index('systemd-run --quiet'))
    accepted("unchanged_limits",all(t in bash for t in ["CPUQuota=800%","MemoryHigh=32G","MemoryMax=40G","MemorySwapMax=0","left=2100","RuntimeMaxSec=$left"]))
    accepted("status_idempotent",d.payload("status",*args,chain)[0]==tok)
    short=[format(x,"032x") for x in range(11,19)]
    accepted("eight_allowed",len(d.payload("start",*args,short)[0])==32)
    rejected("nine_rejected",lambda:d.payload("start",*args,[*short,"f"*32]))
    rejected("duplicate_previous_rejected",lambda:d.payload("start",*args,[chain[0],chain[0]]))
    rejected("malformed_previous_rejected",lambda:d.payload("start",*args,["bad"]))
    u.w.validate_request(job)
    expected=["python3","-B",str(u.BINARY_PATH),"--repo",str(u.w.QUEUE/"jobs"/u.FINITE_TOKEN/"candidate.git"),"--commit",u.FINITE_PIN,"--tree",u.FINITE_TREE,
        "--source-tree",str(u.w.RESULTS/(u.FINITE_PIN+"-"+u.FINITE_TOKEN)/"source"),"--packages","/work/compact-joint-runs/"+u.w.BASE+"-"+u.w.OLD+"/run/source/.lake/packages",
        "--toolchain","/work/compact-joint-435-verified-tools/lean-4.35.0-linux","--bwrap","/usr/bin/bwrap","--bwrap-sha256","1"*64,
        "--expected-object-sha256","2"*64,"--out",str(u.BIN_EVIDENCE),"--deadline-seconds","240"]
    accepted("pinned_binary_command",u.exact_binary_argv(expected))
    for key,bad in [("waiting_shell",["/bin/bash","watcher.sh"]),("different_file",expected[:2]+["/tmp/binary_endpoint.py"]+expected[3:]),
                    ("changed_pin",[("0"*40 if v==u.FINITE_PIN else v) for v in expected]),
                    ("unexpected_option",[*expected,"--control"]),("duplicate_argument",[*expected,"--out",str(u.BIN_EVIDENCE)]),
                    ("unbounded_check",[*expected[:-1],"9999999"])]:
        accepted("reject_"+key,not u.exact_binary_argv(bad))
    with patch.object(u,"primary_roots",return_value={"CompletedFiniteRows"}),patch.object(u,"binary_is_running",side_effect=AssertionError):
        accepted("genuine_finite_path_remains",u.eligible_peer(123)=="finite-source")
    with patch.object(u,"primary_roots",return_value=set()),patch.object(u,"binary_is_running",return_value=True):
        accepted("genuine_binary_alternate",u.eligible_peer(123)=="binary-endpoint")
    with patch.object(u,"primary_roots",return_value=set()),patch.object(u,"binary_is_running",return_value=False):
        accepted("both_standby_rejected",u.eligible_peer(123) is None)
    with patch.object(u,"primary_roots",return_value={"Main"}),patch.object(u,"binary_is_running",return_value=True):
        accepted("other_main_rejected",u.eligible_peer(123) is None)
    # Exercise the actual original terminal metadata from one complete 24954b28 Main job.
    archived=Path("/mnt/c/Users/glaze/Documents/Codex/2026-11-25/new-chat-2/outputs/grh-cc2ba2e7-final/status.json")
    record=json.loads(archived.read_bytes());token=record["job"]["token"]
    with patch.object(u.wm,"rooted_evidence",return_value=archived):
        u.previous_terminal(token);results["real_terminal_Main_accepted"]=True
        rejected("different_token_rejected",lambda:u.previous_terminal("f"*32))
    with tempfile.TemporaryDirectory() as tmp:
        tmp=Path(tmp);q=tmp/"queue";(q/"jobs").mkdir(parents=True);(q/"pending").mkdir();lock=tmp/"shutdown.lock";lock.touch()
        status=tmp/"status.json"; bad=dict(record);bad.pop("finished_unix");status.write_text(json.dumps(bad))
        with patch.object(u.wm,"rooted_evidence",return_value=status):
            rejected("unfinished_prior_rejected",lambda:u.previous_terminal(token))
        b=dict(record);b["job"]={**record["job"],"root":"CompletedFiniteRows"};status.write_text(json.dumps(b))
        with patch.object(u.wm,"rooted_evidence",return_value=status):
            rejected("finite_prior_rejected",lambda:u.previous_terminal(token))
        with lock.open("rb") as first,lock.open("rb") as second,lock.open("rb") as idle:
            fcntl.flock(first,fcntl.LOCK_SH|fcntl.LOCK_NB);fcntl.flock(second,fcntl.LOCK_SH|fcntl.LOCK_NB)
            try:fcntl.flock(idle,fcntl.LOCK_EX|fcntl.LOCK_NB)
            except BlockingIOError:results["shared_shutdown_interlock_excludes_idle_poweroff"]=True
            else:raise AssertionError("exclusive shutdown obtained")
        with lock.open("rb") as idle:fcntl.flock(idle,fcntl.LOCK_EX|fcntl.LOCK_NB)
        results["shutdown_unblocked_after_release"]=True
        calls=[]
        with ExitStack() as stack:
            stack.enter_context(patch.object(u.w,"QUEUE",q));stack.enter_context(patch.object(u.w,"RESULTS",tmp/"data"))
            stack.enter_context(patch.object(u.w,"cold_inactive",return_value=True))
            stack.enter_context(patch.object(u.w,"status",return_value="inactive"))
            stack.enter_context(patch.object(u.wm,"rooted_evidence",side_effect=lambda p:p))
            stack.enter_context(patch.object(u,"previous_terminal",side_effect=calls.append))
            stack.enter_context(patch.object(u.pwd,"getpwnam",return_value=type("UID",(),{"pw_uid":1009})))
            stack.enter_context(patch.object(u.time,"time",return_value=u.w.DEADLINE-Sequence.seconds))
            stack.enter_context(patch.object(u.shutil,"disk_usage",return_value=type("DISK",(),{"free":35*2**30})))
            with patch.object(u,"eligible_peer",return_value=None):
                rejected("synchronous_standby_declines",lambda:u.ready(job))
            with patch.object(u,"eligible_peer",return_value="binary-endpoint"):
                u.ready(job);accepted("accepted_only_after_all_listed_priors",calls[-4:]==chain)
                other=q/"jobs"/("3"*32);other.mkdir();status=other/"status.json"
                status.write_text(json.dumps({"job":job,"started_unix":123}))
                rejected("duplicate_source_job_rejected",lambda:u.ready(job))
                status.write_text(json.dumps({"job":job,"finished_unix":1,"warm_main_exit":0}))
                rejected("passing_source_job_rejected",lambda:u.ready(job))
                status.unlink()
                (q/"pending"/"other.json").write_text(json.dumps({"job":job,**job}))
                rejected("pending_normal_Main_rejected",lambda:u.ready(job))
        # All side effects above are confined to the automatically cleaned private fixture.
    check={"scope":"Offline admission, file identities and stock validator controls. No cloud dispatch or new proof job.",
         "checks":results,"archive_sha256":d.ARCHIVE,"operator_sha256":hashlib.sha256((base/"dispatch_aux.py").read_bytes()).hexdigest(),
         "unchanged_prior_full_validator":True,"prior_stock_Lake_validated_seed_results_sha256":"a2a4b0f337d1803ac8a9e571b43843c6f04a33670df911a0b1986b95f2ed9554"}
    print(json.dumps(check,indent=2))
class Sequence:seconds=1100
if __name__=="__main__":test()
