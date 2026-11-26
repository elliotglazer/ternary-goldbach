from pathlib import Path
import contextlib, copy, hashlib, io, json, os, subprocess, sys, tempfile
from types import SimpleNamespace
from unittest.mock import patch
import protected_window as window
import stock_rehearsal_job as worker

def expect_error(call, *args):
    try:
        call(*args)
    except (ValueError, RuntimeError, OSError):
        return
    raise AssertionError("invalid control was admitted")

def put(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value))

def test(directory, policy):
    src=Path(__file__).resolve().parent
    assert all(window.file_sha(src/k)==v for k,v in window.HASHES.items())
    origin_time=window.START+2*3600
    cutoff=origin_time+7200
    assert origin_time>window.STOP-window.WORKFLOW_SECONDS
    expect_error(window.admission,origin_time,origin_time)
    window.admission(window.STOP-window.WORKFLOW_SECONDS,window.STOP-window.WORKFLOW_SECONDS)
    window.admission(origin_time,origin_time+60,cutoff)
    for bad in (origin_time+59,window.STOP-179,origin_time+19801):
        expect_error(window.admission,origin_time,origin_time,bad)
    expect_error(window.admission,origin_time,cutoff,cutoff)
    worker.validate_window("protected",origin_time,origin_time+60,window.STOP,cutoff)
    expect_error(worker.validate_window,"protected",origin_time,origin_time+60,window.STOP)
    with patch.object(window.time,"time",return_value=cutoff-100):
        assert window.aggregate_seconds(150,cutoff)==100
    with patch.object(window.time,"time",return_value=cutoff-44):
        expect_error(window.aggregate_seconds,150,cutoff)
    candidate="1"*40;tree="2"*40
    scratch=directory/"job"
    marker=directory/"true-origin"
    marker.write_text(f"{origin_time} {window.BOOT.read_text().strip()}\n")
    os.utime(marker,(origin_time,origin_time))
    args=SimpleNamespace(commit=candidate,tree=tree,job=scratch,origin_record=marker,setup_basis="preprovisioned",outer_seconds=7200,mode="begin")
    with patch.object(window.time,"time",return_value=origin_time+35):
        expect_error(window.begin,SimpleNamespace(**{**vars(args),"origin_record":None}))
        window.begin(args)
    origin=window.read(scratch/"origin.json");assert origin["job_started_at_epoch"]==origin_time and origin["local_outer_cutoff_epoch"]==cutoff
    clock={**origin,"aggregate_profile_verified":True}
    put(scratch/"clock.json",clock)
    proof=scratch/"proof-scratch/proof"
    proof.parent.mkdir()
    argv=["worker","protected","--commit",candidate,"--tree",tree,"--clock",str(scratch/"clock.json"),"--directory",str(proof),
          "--policy",str(policy),"--bundle","/trusted/bundle","--bwrap","/trusted/bwrap"]
    # Test the operator's real worker and stage sequence using deterministic stock subprocess outputs.
    # The parser/clock tests of the genuine pinned Palomar verifier are run separately.
    stages=[]
    now=origin_time+180
    deadline_vals=[]
    decision={"status":"pass","stage":"complete","kernels":[{"name":"nanoda"}],
              "kernel_attempts":[{"status":"declined"}],"source":{"commit":candidate},"verification_profile":{"id":window.PROFILE}}
    def fake_output(cmd,**kw):
        if cmd[0].endswith("bwrap"): return "bubblewrap 0.12.0"
        if "status" in cmd:return ""
        if str(policy) in [str(x) for x in cmd]:return window.POLICY
        return tree if "HEAD^{tree}" in cmd else candidate
    def fake_stock(cmd,**kw):
        stage=cmd[3]; stages.append(stage)
        assert kw["env"]["PALOMAR_JOB_STARTED_AT"]==str(origin_time)
        assert kw["env"]["PALOMAR_EXECUTION_PROFILE"]==window.PROFILE
        deadline_vals.append(kw["timeout"])
        mechanical=Path(cmd[cmd.index("--output")+1])
        if stage=="prepare":
            co=proof/"work/source";co.mkdir(parents=True)
            for k in worker.PROTECTED: (co/k).touch()
            report={"status":"pending","stage":"prepared","warnings":[],"errors":[],"source":{"commit":candidate,"repository":worker.ACCOUNT,"bytes":1},
                    "verification_profile":{"id":window.PROFILE,"limits":{"execution_budget_seconds":19800}},"lean_toolchain":"leanprover/lean4:v4.35.0",
                    "license":{"detected_identifier":"Apache-2.0"},"comparator":{"theorem_names":["PalomarTernaryGoldbach.ternary_goldbach"],
                    "definition_names":[],"permitted_axioms":["propext","Quot.sound","Classical.choice"]},"source_requirements":{}}
            put(mechanical,report)
        elif stage=="execute":
            assert cmd[cmd.index("--execution-budget-seconds")+1]=="19800"
            put(mechanical,decision)
        return subprocess.CompletedProcess(cmd,0)
    digest0=worker.digest
    def fixture_digest(path):
        if str(path).startswith(str(proof/"work/source")+"/"):return worker.PROTECTED[Path(path).name]
        return digest0(path)
    with patch.object(worker.sys,"argv",argv),patch.object(worker.os,"geteuid",return_value=65534),patch.object(worker.time,"time",return_value=now), \
         patch.object(worker,"output",side_effect=fake_output),patch.object(worker.subprocess,"run",side_effect=fake_stock),patch.object(worker,"digest",side_effect=fixture_digest):
        worker.main()
    assert stages==["prepare","check-capacity","execute"] and all(k==cutoff-now for k in deadline_vals)
    host={"source_commit":candidate,"source_tree":tree,"boot_id":origin["boot_id"],"policy":window.POLICY,"profile":window.PROFILE,
          "clock_sha256":window.file_sha(scratch/"clock.json")}
    put(scratch/"proof-scratch/verified-host.json",host)
    assert window.proof_completed_before_cutoff(scratch,origin)
    decisionfile=proof/"mechanical-report.json"
    raw=decisionfile.read_bytes()
    put(decisionfile,{**decision,"stage":"setup"})
    assert not window.proof_completed_before_cutoff(scratch,origin)
    decisionfile.write_bytes(raw)
    origin2={**origin,"tree":"3"*40}
    assert not window.proof_completed_before_cutoff(scratch,origin2)
    markerpath=proof/"stock-completed-before-cutoff.json";old=markerpath.read_bytes()
    put(markerpath,{**json.loads(old),"finished_epoch":cutoff+1})
    assert not window.proof_completed_before_cutoff(scratch,origin)
    markerpath.write_bytes(old)
    args.mode="run"
    def real_short_timeout(_):
        subprocess.run([sys.executable,"-c","import time; time.sleep(2)"],timeout=0.05,check=True)
    with patch.object(window,"run",side_effect=real_short_timeout),patch.object(window.time,"time",return_value=cutoff+1):
        assert window.dispatch(args)==0
    assert window.read(scratch/"limited-outcome.json")["classification"]=="pass"
    assert decisionfile.read_bytes()==raw
    # Separate fresh root to check that an uncompleted run never inherits a result.
    empty=directory/"inconclusive";empty.mkdir();put(empty/"origin.json",origin)
    original_partial={"status":"pending","stage":"prepared"}
    put(empty/"proof-scratch/proof/mechanical-report.json",original_partial)
    args.job=empty
    with patch.object(window,"run",side_effect=real_short_timeout),patch.object(window.time,"time",return_value=cutoff+1):
        assert window.dispatch(args)==2
    outcome=window.read(empty/"limited-outcome.json")
    assert outcome["classification"]=="inconclusive-local-cutoff" and outcome["last_stock_stage"]=="prepared"
    assert window.read(empty/"proof-scratch/proof/mechanical-report.json")==original_partial
    expect_error(window.dispatch,args)
    with patch.object(window.time,"time",return_value=cutoff+1):
        assert window.recover(args)==2
    fresh=directory/"post-reboot";fresh.mkdir();put(fresh/"origin.json",origin);args.job=fresh
    with patch.object(window.time,"time",return_value=cutoff-1):
        expect_error(window.recover,args)
    with patch.object(window.time,"time",return_value=cutoff+1):
        assert window.recover(args)==2
        assert window.recover(args)==2
    assert window.read(fresh/"limited-outcome.json")["classification"]=="inconclusive-local-cutoff"
    failed=directory/"early-failure";failed.mkdir();put(failed/"origin.json",origin);args.job=failed
    with patch.object(window,"run",side_effect=ValueError("fixture setup failed")),patch.object(window.time,"time",return_value=now):
        expect_error(window.dispatch,args)
    assert window.read(failed/"limited-outcome.json")["classification"]=="incomplete-or-error"
    return {"original_1110_rule_preserved":True,"later_mode_with_trusted_marker":True,
      "unchanged_stock_budget_and_profile":True,"all_three_stock_stages_receive_same_original_clock":True,
      "outer_subprocess_timeout_enforced":True,"unchanged_inputs_checked":True,"interval_and_recovery_reserve_rejections":True,
      "late_digest_mismatch_and_wrong_tree_rejected":True,"completed_stock_before_artifact_cutoff_recovered":True,
      "partial_report_with_outer_timeout_inconclusive":True,"early_infrastructure_error_distinguished":True,
      "receipt_immutable_and_source_evidence_preserved":True, "offline_recovery_refuses_early_and_is_idempotent":True,
      "scope":"Clock and subprocess controls exercised locally. Stock stage success, cgroup qualification and kernel verdict data in the operator fixtures are simulated. A separate suite checks the actual pinned policy deadline functions and CLI. No AWS dispatch, Registry action or TG proof."}

if __name__=="__main__":
    policy=Path(sys.argv[1]); report=Path(sys.argv[2])
    with tempfile.TemporaryDirectory(dir="/run",prefix="palomar-limited-controls-") as temp:
        with contextlib.redirect_stdout(io.StringIO()):
            result=test(Path(temp),policy)
    report.write_text(json.dumps(result,indent=2,sort_keys=True)+"\n")
    print(json.dumps(result))
