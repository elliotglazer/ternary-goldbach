#!/usr/bin/env python3
"""Clock, qualify, and execute the stock Goldbach verification within the second reviewed AWS window."""
import argparse
import contextlib
import hashlib
import json
import os
from pathlib import Path
import pwd
import re
import subprocess
import time

START = 1795689000
STOP = 1795712400
PROOF_SECONDS = 19800
WORKFLOW_SECONDS = 21000
POLICY = "14aa8d6b3c2f14a8540605e37144560b9a00e7e7"
PROFILE = "palomar-namespace-32x64-v1"
HASHES = {
    "stock_rehearsal_job.py": "ccc1bb35f52535e7167b4e9592dfa5daf618900cc091a75d6fcbce43733e635d",
    "stock_protected_handoff.py": "9829ffd65707b24316498298057ddfc508e1035c700c364e0c2eabbc4fa9f693",
    "probe-stock-32x64.py": "a24992ee326a5314160ea0e5eece28116d8a08a7605396dd90da55e1411a5413",
    "guard-aggregate-restarts.sh": "c68ed57fd5580268d76b677ae6b2db4c5c3f1c98b4ac5bca06282c9ea7b59838",
}
ROOT = Path("/opt/palomar-verifier-14aa8d6b")
MANAGER_CGROUP="/sys/fs/cgroup/user.slice/user-1001.slice/user@1001.service"
BOOT=Path("/proc/sys/kernel/random/boot_id")

def check(ok,message):
    if not ok:
        raise ValueError(message)

def file_sha(path):
    with path.open("rb") as source:
        return hashlib.file_digest(source,"sha256").hexdigest()

def record(path,value):
    with path.open("x") as target:
        json.dump(value,target,sort_keys=True,indent=2)
        target.write("\n")
        target.flush()
        os.fsync(target.fileno())
    path.chmod(0o444)

def read(path):
    return json.loads(path.read_bytes())

def root_trusted(path):
    check(path.is_absolute() and path.resolve(strict=True)==path,"Need an absolute physical path")
    for member in (path,*path.parents):
        st=member.stat()
        check(st.st_uid==0 and not (st.st_mode & 0o022),"Trusted path writable by others: "+str(member))
    return path

def validate_pins(commit,tree):
    check(all(re.fullmatch("[0-9a-f]{40}",i) for i in (commit,tree)),"Expected full candidate commit and tree")

class LocalWallCutoff(RuntimeError):
    pass

def admission(start, now, outer=None):
    check(START <= start <= now, "Outside the originally admitted window")
    if outer is None:
        check(start+WORKFLOW_SECONDS <= STOP, "Full 350-minute job cannot fit in the separate approved window")
    else:
        check(type(outer) is int and start+60 <= outer <= min(start+PROOF_SECONDS, STOP-180),
              "Local wall cutoff must be between 60 s and 330 min, with 180 s left for host cleanup")
        if now >= outer:
            raise LocalWallCutoff("Local wall cutoff reached")
    check(now < start+PROOF_SECONDS, "Original stock execution budget already elapsed")

def aggregate_seconds(requested, outer):
    if outer is None:
        return requested
    available = int(outer-time.time())
    if available < 45:
        raise LocalWallCutoff("Fewer than 45 s remain for the reviewed aggregate service")
    return min(requested, available)


def overlaid_schedule(previous,current):
    def target(row):
        key=row["Target"]
        check(key["Arn"]=="arn:aws:scheduler:::aws-sdk:ec2:stopInstances","Unexpected account stop target")
        ids=json.loads(key["Input"])["InstanceIds"]
        check(len(ids)==1 and re.fullmatch("i-[a-f0-9]{17}",ids[0]),"One retained instance is required")
        check(row.get("ScheduleExpressionTimezone","UTC")=="UTC" and row["FlexibleTimeWindow"]["Mode"]=="OFF","Unexpected timezone or flexible stop")
        arn=row["Arn"].split(":",5)
        check(len(arn)==6 and arn[1:4]==["aws","scheduler","us-east-1"] and re.fullmatch("[0-9]{12}",arn[4]),"Wrong scheduler region")
        check(key["RoleArn"].startswith("arn:aws:iam::"+arn[4]+":role/"),"Unexpected scheduling role")
        return ids[0],key["RoleArn"],arn[4]
    check(previous["Arn"]!=current["Arn"] and previous["ScheduleExpression"]=="at(2026-11-26T10:17:24)" and
          current["ScheduleExpression"]=="at(2026-11-26T17:00:00)" and current["State"]=="ENABLED",
          "Expected distinct original and second one-shot stops")
    check(target(previous)==target(current),"Second stop points at a different instance, role or account")

def check_probe(report):
    keys=("outer_selected_profile","stock_phase","phase_cpu_32","phase_memory_limits","phase_has_zero_swap_cgroup","aggregate_32x64_swap0")
    check(report["profile"]==PROFILE and report["policy"]==POLICY and all(report["classification"].get(k) is True for k in keys),"Aggregate qualification failed")
    check(all(MANAGER_CGROUP in report["classification"].get(k,[]) for k in
              ("common_memory64_enforced_by","common_cpu32_enforced_by","common_swap0_enforced_by")),"Missing required common cgroup")

def check_decision(decision):
    check((decision["status"],decision["stage"])==("pass","complete"),"Protected verifier did not complete")
    # At the pinned policy, Lean is Comparator's built-in judge. Only its external kernels appear here.
    external={entry["name"] for entry in decision["kernels"]}
    attempts=decision.get("kernel_attempts",[])
    check(len(attempts)==1 and attempts[0]["status"] in ("accepted","declined"),"Missing con-ron disposition")
    expected={"nanoda","con-ron"} if attempts[0]["status"]=="accepted" else {"nanoda"}
    check(external==expected,"Stock external-kernel set does not match the recorded verdict")

def user_directory(path):
    account=pwd.getpwnam("grhreplay")
    check(account.pw_uid==1001,"Unexpected dedicated UID")
    path.mkdir(mode=0o700)
    os.chown(path,account.pw_uid,account.pw_gid)

def command_runner(staged,job):
    return ["/bin/bash","-c",
            'set -eu; . "$1/lean-license-runtime/activate.sh"; exec "$1/venv/bin/python" -B "$2/stock_protected_handoff.py" '
            '--clock "$3/clock.json" --scratch "$3/proof-scratch" --probe "$2/probe-stock-32x64.py" '
            '--worker "$2/stock_rehearsal_job.py" --bundle "$1/lean-license-runtime/bin/bundle" --bwrap "$1/bwrap-bin/bwrap"',
            "palomar",str(ROOT),str(staged),str(job)]

def begin(args):
    now=int(time.time())
    validate_pins(args.commit,args.tree)
    check(os.geteuid()==0,"Root must timestamp the original verification job")
    root_trusted(args.job.parent)
    boot=BOOT.read_text().strip()
    start=now
    marker_sha=None
    if args.origin_record:
        marker=root_trusted(args.origin_record)
        stamp,marker_boot=marker.read_text().split()
        check(marker.is_file() and re.fullmatch("[0-9]{10}",stamp) and marker_boot==boot,
              "Origin marker has the wrong contents or boot")
        start=int(stamp)
        check(abs(marker.stat().st_mtime-start)<3,"Origin marker timestamp disagrees with its creation")
        marker_sha=file_sha(marker)
    else:
        check(args.setup_basis=="preprovisioned","Whole-job timing requires an independently recorded original start")
    outer_seconds = getattr(args, "outer_seconds", None)
    outer = None if outer_seconds is None else start+outer_seconds
    if outer is not None:
        check(marker_sha is not None, "An independent original trusted-setup timestamp is required for a limited rehearsal")
    admission(start,now,outer)
    extra = {} if outer is None else {"local_outer_cutoff_epoch":outer}
    args.job.mkdir(mode=0o755,exist_ok=False)
    record(args.job/"origin.json",{"job_started_at_epoch":start,"origin_marker_sha256":marker_sha,"boot_id":boot,
               "host_deadline_epoch":STOP,"mode":"protected","commit":args.commit,"tree":args.tree,"setup_basis":args.setup_basis,**extra})
    print("Recorded original stock job start",start,flush=True)

def run(args):
    job=root_trusted(args.job)
    staged=root_trusted(args.staged)
    start_record=read(root_trusted(job/"origin.json"))
    validate_pins(start_record["commit"],start_record["tree"])
    start=start_record["job_started_at_epoch"]
    outer = start_record.get("local_outer_cutoff_epoch")
    admission(start,int(time.time()),outer)
    check(os.geteuid()==0 and start_record["boot_id"]==BOOT.read_text().strip() and start_record["host_deadline_epoch"]==STOP,
          "Wrong boot, original deadline, or operator")
    old,new=root_trusted(args.previous_stop),root_trusted(args.separate_stop)
    overlaid_schedule(read(old),read(new))
    for file,digest in HASHES.items():
        check(file_sha(root_trusted(staged/file))==digest,"Unreviewed "+file)
    check(re.fullmatch("[0-9a-f]{64}",args.aggregate_sha256) and file_sha(root_trusted(staged/"stock_aggregate.py"))==args.aggregate_sha256,
          "Aggregate launcher differs from the separately reviewed immutable revision")
    # The independent measurement uses its own genuinely stock pipeline checkout. The handoff freshly fetches the same commit again.
    policy=job/"preliminary-policy"
    user_directory(policy)
    gid=pwd.getpwnam("grhreplay").pw_gid
    git=["/usr/bin/setpriv","--reuid=1001",f"--regid={gid}","--init-groups","--","/usr/bin/env","-i","PATH=/usr/bin:/bin",
         "GIT_CONFIG_GLOBAL=/dev/null","GIT_CONFIG_NOSYSTEM=1","GIT_TERMINAL_PROMPT=0","git","-C",str(policy),"-c","core.hooksPath=/dev/null"]
    for cmd in (["init","-q"],["fetch","-q","--no-tags","--depth=1","https://github.com/PalomarRegistry/PalomarSubmission.git",POLICY],
                ["checkout","-q","--detach","FETCH_HEAD"]):
        subprocess.run([*git,*cmd],check=True,timeout=min(300,max(0,min(start+PROOF_SECONDS, outer or STOP)-time.time())))
    check(subprocess.check_output([*git,"rev-parse","HEAD"],text=True).strip()==POLICY,"Official source mismatch")
    for directory in ("pre-qualification","in-session-qualification","proof-scratch"):
        user_directory(job/directory)
    run_aggregate=["/usr/bin/python3","-I",str(staged/"stock_aggregate.py"),"launch"]
    guard=["/bin/sh",str(staged/"guard-aggregate-restarts.sh")]
    existing=subprocess.check_output([*guard,"status"],text=True).strip()
    check(existing=="Inactive" or existing.startswith("Active on needrestart "),"Untrusted previous needrestart state")
    with contextlib.ExitStack() as stack:
        if existing=="Inactive":
            subprocess.run([*guard,"install"],check=True)
            stack.callback(subprocess.run,[*guard,"remove"],check=True)
        with (job/"pre-qualification.log").open("x") as out:
            subprocess.run([*run_aggregate,str(aggregate_seconds(150, outer)),str(policy),str(job/"pre-qualification")],stdout=out,stderr=subprocess.STDOUT,check=True)
        results=list((job/"pre-qualification").glob("stock-32x64-palomar-*.json"))
        check(len(results)==1,"Official aggregate qualification did not produce a unique raw report")
        check_probe(read(results[0]))
        record(job/"clock.json",{**start_record,"aggregate_profile_verified":True,
               "aggregate_launcher_sha256":args.aggregate_sha256,"previous_probe_sha256":file_sha(results[0]),
               "previous_account_stop_receipt_sha256":file_sha(old),"new_account_stop_receipt_sha256":file_sha(new)})
        now=int(time.time())
        admission(start,now,outer)
        remaining=aggregate_seconds(start+WORKFLOW_SECONDS-now, outer)
        with (job/"protected-console.log").open("x") as out:
            subprocess.run([*run_aggregate,str(remaining),str(policy),str(job/"in-session-qualification"),"--",
                            *command_runner(staged,job)],stdout=out,stderr=subprocess.STDOUT,check=True)
    report=job/"proof-scratch/proof/mechanical-report.json"
    decision=read(report)
    check_decision(decision)
    check(int(time.time())<=start+WORKFLOW_SECONDS,"Proof finished outside its local 350-minute workflow envelope")
    if outer is not None:
        if int(time.time()) > outer:
            raise LocalWallCutoff("The complete rehearsal did not return before its local cutoff")
        limited_evidence(job, start_record, "pass", "Stock pass/complete and required kernels validated")
    print(json.dumps({"status":"pass","stage":"complete","source":start_record["commit"],"sha256":file_sha(report),
                      "setup_basis":start_record["setup_basis"],"elapsed_seconds":int(time.time())-start,"evidence":str(report)}))

def read_small_json(path):
    import stat
    if path.resolve(strict=True)!=path:
        raise ValueError("Unexpected link in the verifier evidence path")
    fd=os.open(path,os.O_RDONLY|os.O_NOFOLLOW|os.O_NONBLOCK)
    with os.fdopen(fd,"rb") as stream:
        info=os.fstat(stream.fileno())
        if not stat.S_ISREG(info.st_mode) or info.st_size>4*1024*1024:
            raise ValueError("Unexpected verifier evidence file")
        raw=stream.read(4*1024*1024+1)
    check(len(raw)<=4*1024*1024, "Evidence grew while being read")
    return json.loads(raw),hashlib.sha256(raw).hexdigest()

def proof_completed_before_cutoff(job, origin):
    # The dedicated coordinator writes this marker after official execute returns zero
    # and before hashing large exports. Submitted processes cannot write its parent.
    try:
        proof=job/"proof-scratch/proof"
        clock,clock_sha=read_small_json(root_trusted(job/"clock.json"))
        host,_=read_small_json(job/"proof-scratch/verified-host.json")
        marker,_=read_small_json(proof/"stock-completed-before-cutoff.json")
        decision,report_sha=read_small_json(proof/"mechanical-report.json")
        same=["commit","tree","job_started_at_epoch","local_outer_cutoff_epoch"]
        if not all(origin[k]==marker[k]==clock[k] for k in same):
            return False
        if not (clock["aggregate_profile_verified"] is True and
                host["source_commit"]==origin["commit"] and host["source_tree"]==origin["tree"] and
                host["boot_id"]==origin["boot_id"]==clock["boot_id"] and host["policy"]==POLICY and
                host["profile"]==PROFILE and host["clock_sha256"]==clock_sha==marker["verified_clock_sha256"] and
                marker["mechanical_sha256"]==report_sha and decision["source"]["commit"]==origin["commit"] and
                decision["verification_profile"]["id"]==PROFILE and
                origin["job_started_at_epoch"]<=marker["finished_epoch"]<=origin["local_outer_cutoff_epoch"]):
            return False
        check_decision(decision)
        return True
    except (OSError, ValueError, KeyError, TypeError):
        return False

def limited_evidence(job, origin, status, reason):
    # Keep the complete work tree, process logs, exports and stock artifacts in place.
    # The recovery summary reads only a bounded, regular mechanical report.
    cutoff = origin["local_outer_cutoff_epoch"]
    data = {"classification":status, "reason":reason, "commit":origin["commit"], "tree":origin["tree"],
            "job_started_at_epoch":origin["job_started_at_epoch"], "local_outer_cutoff_epoch":cutoff,
            "host_stop_epoch":STOP, "stock_budget_seconds":PROOF_SECONDS, "recorded_at_epoch":int(time.time()),
            "artifacts_in_place":["origin.json","clock.json","pre-qualification.log","protected-console.log",
                "in-session-qualification","proof-scratch/verified-host.json","proof-scratch/proof"]}
    path = job/"proof-scratch/proof/mechanical-report.json"
    try:
        current,report_sha=read_small_json(path)
        data.update(mechanical_report_sha256=report_sha, last_stock_status=current.get("status"),
                    last_stock_stage=current.get("stage"))
    except (ValueError, OSError, AttributeError):
        data["last_stock_stage"]="no complete readable stock report"
    record(job/"limited-outcome.json", data)
    print(json.dumps(data),flush=True)

def recover(args):
    check(os.geteuid()==0, "Only the operator can record a recovery result")
    job = root_trusted(args.job)
    origin = read(root_trusted(job/"origin.json"))
    cutoff = origin.get("local_outer_cutoff_epoch")
    check(type(cutoff) is int and time.time()>=cutoff, "Recover only expired optional attempts")
    validate_pins(origin["commit"],origin["tree"])
    out=job/"limited-outcome.json"
    if out.exists():
        previous=read(root_trusted(out))
        check((previous["commit"],previous["tree"])==(origin["commit"],origin["tree"]), "Wrong prior outcome identity")
        print(json.dumps(previous),flush=True)
        return 0 if previous["classification"]=="pass" else 2
    if proof_completed_before_cutoff(job,origin):
        limited_evidence(job,origin,"pass","Recovered a genuine stock completion recorded before the local cutoff")
        return 0
    limited_evidence(job,origin,"inconclusive-local-cutoff","No complete valid stock judgment was recorded before the cutoff")
    return 2

def dispatch(args):
    if args.mode=="begin":
        return begin(args)
    if args.mode=="recover":
        return recover(args)
    job=root_trusted(args.job)
    origin=read(root_trusted(job/"origin.json"))
    outer=origin.get("local_outer_cutoff_epoch")
    if outer is None:
        return run(args)
    # A resumed invocation cannot overwrite the first bounded attempt's verdict.
    check(not (job/"limited-outcome.json").exists(), "Limited outcome already recorded")
    try:
        return run(args)
    except (OSError, ValueError, RuntimeError, subprocess.SubprocessError) as err:
        cutoff=isinstance(err, LocalWallCutoff) or time.time()>=outer
        if cutoff and proof_completed_before_cutoff(job,origin):
            limited_evidence(job,origin,"pass","Stock comparison finished before cutoff; later artifact collection or shutdown was interrupted")
            return 0
        why="Local cutoff left full-budget verification unresolved" if cutoff else "Local rehearsal or stock verifier exited before its cutoff"
        limited_evidence(job,origin,"inconclusive-local-cutoff" if cutoff else "incomplete-or-error",why)
        if cutoff:
            return 2
        raise

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    children=parser.add_subparsers(dest="mode",required=True)
    first=children.add_parser("begin")
    first.add_argument("--commit",required=True)
    first.add_argument("--tree",required=True)
    first.add_argument("--outer-seconds", type=int, help="Optional stricter local cutoff, measured from the original trusted timestamp")
    first.add_argument("--origin-record",type=Path,help="Root-owned timestamp and boot marker created before trusted setup")
    first.add_argument("--setup-basis",choices=["preprovisioned","original-before-trusted-setup"],required=True)
    second=children.add_parser("run")
    second.add_argument("--staged",type=Path,required=True)
    second.add_argument("--aggregate-sha256",required=True)
    second.add_argument("--previous-stop",type=Path,required=True)
    second.add_argument("--separate-stop",type=Path,required=True)
    recovery=children.add_parser("recover",help="Classify preserved records after an interrupted local cutoff")
    for sub in (first,second,recovery):
        sub.add_argument("--job",type=Path,required=True)
    args=parser.parse_args()
    return dispatch(args)

if __name__=="__main__":
    raise SystemExit(main())
