"""Exercise the operator gates locally against the pinned stock policy. Uses no AWS or systemd mutation."""
import argparse
import contextlib
import copy
import hashlib
import io
import json
import os
import subprocess
import sys
import tempfile
from pathlib import Path
from unittest.mock import patch

import protected_window as window
import stock_protected_handoff as handoff
import stock_rehearsal_job as worker


def refused(action, *args):
    try:
        action(*args)
    except (ValueError, FileExistsError):
        return True
    raise AssertionError("Expected an admission refusal")


def schedule(name, time):
    account="0"*12
    return {"Arn":"arn:aws:scheduler:us-east-1:"+account+":schedule/default/"+name,
            "Target":{"Arn":"arn:aws:scheduler:::aws-sdk:ec2:stopInstances",
                      "RoleArn":"arn:aws:iam::"+account+":role/synthetic",
                      "Input":json.dumps({"InstanceIds":["i-"+"0"*17]})},
            "ScheduleExpression":"at(2026-11-26T"+time+")","State":"ENABLED",
            "ScheduleExpressionTimezone":"UTC","FlexibleTimeWindow":{"Mode":"OFF"}}


def verify(policy, scratch):
    version=subprocess.check_output(["git","-C",str(policy),"rev-parse","HEAD"],text=True).strip()
    assert version==window.POLICY
    sys.path.insert(0,str(policy))
    from scripts import verify_submission as stock
    results={}
    p=stock.parser()
    p.parse_args(["prepare","--event","event","--work-dir","work","--output","report","--licensee","bundle"])
    p.parse_args(["check-capacity","--disk-path","work","--output","report"])
    exec_args=p.parse_args(["execute","--work-dir","work","--output","report","--bwrap","bwrap",
                            "--bwrap-source-tag","v0.12.0","--execution-budget-seconds","19800","--workflow-url","file:///report"])
    assert exec_args.execution_budget_seconds==19800
    assert stock.PROTECTED_KERNELS==(("nanoda","nanoda_bin"),("con-ron","con-ron"))
    old=stock._EXECUTION_DEADLINE
    try:
        with patch.object(stock,"_WALL_TIME",return_value=window.START+180),patch.object(stock,"_MONOTONIC",return_value=100.0):
            stock.install_execution_deadline(str(window.START),exec_args.execution_budget_seconds)
            assert stock._deadline_timeout(43200,["trusted command"])==19620
        with patch.object(stock,"_MONOTONIC",return_value=19720.0):
            try: stock._deadline_timeout(43200,["trusted command"])
            except subprocess.TimeoutExpired: pass
            else: raise AssertionError("Stock accepted activity at expired original deadline")
    finally:
        stock._EXECUTION_DEADLINE=old
    results["genuine_cli_and_330_minute_elapsed_deadline"]=True
    assert worker.BUDGET==handoff.BUDGET==window.PROOF_SECONDS==19800
    assert worker.WORKFLOW_SECONDS==handoff.WORKFLOW_SECONDS==window.WORKFLOW_SECONDS==21000
    for name,digest in window.HASHES.items():
        assert window.file_sha(Path(__file__).resolve().parent/name)==digest
    assert handoff.WORKER_SHA==window.HASHES["stock_rehearsal_job.py"]
    results["frozen_hashes_bound_across_three_helpers"]=True
    end=window.STOP-window.WORKFLOW_SECONDS
    window.admission(window.START,window.START)
    window.admission(end,end)
    assert refused(window.admission,window.START-1,window.START)
    assert refused(window.admission,end+1,end+1)
    assert refused(window.admission,window.START,window.START+19800)
    results["original_window_boundaries_including_latest_1110"]=True
    prev=schedule("original","10:17:24")
    cur=schedule("separate","17:00:00")
    window.overlaid_schedule(prev,cur)
    for group,key,value in ((None,"State","DISABLED"),(None,"ScheduleExpressionTimezone","America/New_York"),
                            (None,"Arn",prev["Arn"]),(None,"ScheduleExpression","at(2026-11-26T17:00:01)"),
                            ("Target","Input",json.dumps({"InstanceIds":["i-"+"a"*17]})),
                            ("Target","RoleArn","arn:aws:iam::000000000000:role/other"),("FlexibleTimeWindow","Mode","FLEXIBLE")):
        altered=copy.deepcopy(cur)
        (altered if group is None else altered[group])[key]=value
        assert refused(window.overlaid_schedule,prev,altered)
    results["distinct_schedules_and_seven_adverse_controls"]=True
    with tempfile.TemporaryDirectory(dir=scratch) as td:
        base=Path(td)
        base.chmod(0o700)
        mark=base/"origin.clock"
        mark.write_text(f"{window.START} {window.BOOT.read_text().strip()}\n")
        os.utime(mark,(window.START,window.START))
        a=argparse.Namespace(commit="0"*40,tree="1"*40,job=base/"job",setup_basis="original-before-trusted-setup",origin_record=mark)
        with patch.object(window.time,"time",return_value=window.START+60),contextlib.redirect_stdout(io.StringIO()):
            window.begin(a)
            result=window.read(a.job/"origin.json")
            assert result["job_started_at_epoch"]==window.START and result["origin_marker_sha256"]==window.file_sha(mark)
            assert refused(window.begin,a)
            a.job=base/"second"
            a.origin_record=None
            assert refused(window.begin,a)
            a.origin_record=mark
            os.utime(mark,(window.START+10,window.START+10))
            assert refused(window.begin,a)
            a.setup_basis="preprovisioned"
            a.origin_record=None
            window.begin(a)
            assert window.read(a.job/"origin.json")["job_started_at_epoch"]==window.START+60
    results["boot_bound_original_clock_and_preprovisioned_distinction"]=True
    keys=("outer_selected_profile","stock_phase","phase_cpu_32","phase_memory_limits","phase_has_zero_swap_cgroup","aggregate_32x64_swap0")
    ancestry=("common_memory64_enforced_by","common_cpu32_enforced_by","common_swap0_enforced_by")
    report={"profile":window.PROFILE,"policy":window.POLICY,"classification":{k:True for k in keys}}
    for k in ancestry: report["classification"][k]=[window.MANAGER_CGROUP]
    window.check_probe(report)
    for k in (*keys,*ancestry):
        bad=copy.deepcopy(report)
        bad["classification"][k]=False if k in keys else ["/sys/fs/cgroup"]
        assert refused(window.check_probe,bad)
    results["six_profile_requirements_and_three_common_resource_bounds"]=True
    for outcome,names in (("declined",["nanoda"]),("accepted",["nanoda","con-ron"])):
        d={"status":"pass","stage":"complete","kernel_attempts":[{"status":outcome}],"kernels":[{"name":n} for n in names]}
        window.check_decision(d)
        wrong=copy.deepcopy(d)
        wrong["kernels"]=[]
        assert refused(window.check_decision,wrong)
        wrong=copy.deepcopy(d)
        wrong["kernel_attempts"][0]["status"]="rejected"
        assert refused(window.check_decision,wrong)
        wrong=copy.deepcopy(d)
        wrong["status"]="pending"
        assert refused(window.check_decision,wrong)
    results["mandatory_kernels_and_only_stock_con_ron_dispositions"]=True
    return {"policy":version,"policy_verifier_sha256":hashlib.sha256((policy/"scripts/verify_submission.py").read_bytes()).hexdigest(),
            "genuine_python":sys.version.split()[0],"tests":results,"synthetic_examples":["AWS scheduler data","clock dates","kernel outcomes","aggregate probe fields"],
            "no_proof_or_cloud_dispatch":True}


if __name__=="__main__":
    a=argparse.ArgumentParser(description=__doc__)
    a.add_argument("--policy",required=True,type=Path)
    a.add_argument("--trusted-scratch",required=True,type=Path)
    a.add_argument("--output",required=True,type=Path)
    args=a.parse_args()
    outcome=verify(args.policy,args.trusted_scratch)
    args.output.write_text(json.dumps(outcome,sort_keys=True,indent=2)+"\n")
    print(json.dumps(outcome))
