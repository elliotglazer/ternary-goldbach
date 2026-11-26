#!/usr/bin/env python3
"""Run an unchanged, pinned Palomar mechanical verifier on an existing prepared checkout."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shlex
import shutil
import subprocess
import sys
import tempfile
import time

POLICY = "14aa8d6b3c2f14a8540605e37144560b9a00e7e7"
PROFILE = "palomar-namespace-32x64-v1"
BUDGET = 19800
DEFAULT_REPORT = "2c6ddab6dd9f8dd611cbf297892f290f0809ad9827718c58624cf1a388e495a1"

def command(argv, env=None, cwd=None):
    return subprocess.check_output(argv, cwd=cwd, env=env, text=True).strip()

def require(condition, reason):
    if not condition:
        raise SystemExit(reason)

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("mode", choices=("plan", "probe", "execute"))
    parser.add_argument("--verifier", type=Path, required=True)
    parser.add_argument("--work-dir", type=Path, required=True)
    parser.add_argument("--prepared-report", type=Path, required=True)
    parser.add_argument("--report-sha256", default=DEFAULT_REPORT)
    parser.add_argument("--bwrap", type=Path, required=True, help="Path built by the pinned installer.")
    parser.add_argument("--output", type=Path, required=True, help="Fresh execution-report path.")
    parser.add_argument("--job-start", type=int, help="Unix epoch recorded before a fresh full pipeline bootstrap.")
    parser.add_argument("--execution-budget-seconds", type=int, default=BUDGET,
                        help="Wall-clock allowance for this local replay. Published profiles allow 19800 seconds.")
    args = parser.parse_args()
    require(args.execution_budget_seconds >= 60, "The stock verifier requires at least 60 seconds.")
    policy = args.verifier.resolve(strict=True)
    work = args.work_dir.resolve(strict=True)
    original = args.prepared_report.resolve(strict=True)
    bwrap = args.bwrap.resolve()
    output = args.output.resolve()
    require(output != original and not output.exists(), "Choose a new execution report path.")
    require(output.parent.is_dir(), "Create the output parent directory first.")
    require(re.fullmatch("[0-9a-f]{64}", args.report_sha256) and
            hashlib.sha256(original.read_bytes()).hexdigest() == args.report_sha256,
            "Prepared report digest mismatch.")
    report = json.loads(original.read_bytes())
    require(report.get("status") == "pending" and report.get("stage") == "prepared" and
            report["verification_profile"]["id"] == PROFILE and
            report.get("lean_toolchain") == "leanprover/lean4:v4.35.0", "Unexpected prepared report.")
    require(command(["git", "-C", str(policy), "rev-parse", "HEAD"]) == POLICY, "Wrong verifier commit.")
    require(not command(["git", "-C", str(policy), "status", "--porcelain", "--untracked-files=normal"]),
            "Use a clean verifier checkout.")
    source = work / "source"
    require(command(["git", "-C", str(source), "rev-parse", "HEAD"]) == report["source"]["commit"],
            "Prepared checkout does not match the report.")
    require(not command(["git", "-C", str(source), "status", "--porcelain", "--untracked-files=normal"])
            and not (source / ".lake").exists(), "A fresh stock-prepared candidate checkout is required.")
    require(report.get("challenge", {}).get("module") == "GoldbachChallenge" and
            report.get("solution", {}).get("module") == "GoldbachSolution",
            "Unexpected challenge or solution.")
    env = os.environ.copy()
    env["PYTHONDONTWRITEBYTECODE"] = "1"
    env["PALOMAR_EXECUTION_PROFILE"] = PROFILE
    epoch = args.job_start or int(env.get("PALOMAR_JOB_STARTED_AT", "0"))
    timing_basis = "full-pipeline" if epoch else "execution-only"
    if epoch:
        require(0 < epoch <= time.time() + 1, "Invalid job-start epoch.")
    else:
        print("Clock covers execution-stage work only. Supply the original start for a full timed replay.")
        epoch = int(time.time())
    env["PALOMAR_JOB_STARTED_AT"] = str(epoch)
    profile_budget = report["verification_profile"]["limits"]["execution_budget_seconds"]
    nonstandard_window = args.execution_budget_seconds != profile_budget
    window_path = output.with_name(output.name + ".timing.json")
    if nonstandard_window:
        require(not window_path.exists(), "Choose an unused local timing evidence path.")
        print(f"Local replay window {args.execution_budget_seconds}s; published profile window {profile_budget}s "
              f"({timing_basis} clock).", flush=True)
    cli = [sys.executable, str(policy / "scripts/verify_submission.py")]
    capacity = [*cli, "check-capacity", "--disk-path", str(work), "--output", str(output)]
    execution = [*cli, "execute", "--work-dir", str(work), "--output", str(output),
                 "--bwrap", str(bwrap), "--bwrap-source-tag", "v0.12.0",
                 "--execution-budget-seconds", str(args.execution_budget_seconds), "--workflow-url", output.as_uri()]
    for cmd in (capacity, execution):
        # The stock argument parser checks these exact constructed options; invoking it starts no jobs.
        statement = ("import sys; from scripts.verify_submission import parser; "
                     "parser().parse_args(sys.argv[1:])")
        subprocess.run([sys.executable, "-c", statement, *cmd[2:]], cwd=policy, env=env, check=True)
        print(shlex.join(cmd), flush=True)
    if args.mode == "plan":
        return 0
    if args.mode == "probe":
        # check-capacity writes observations; point it at an expendable copy.
        with tempfile.TemporaryDirectory(prefix="palomar-capacity-probe-", dir=output.parent) as tmp:
            copy = Path(tmp) / "report.json"
            shutil.copyfile(original, copy)
            rc = subprocess.run([*capacity[:-1], str(copy)], cwd=policy, env=env).returncode
            observed = json.loads(copy.read_bytes())
            print(json.dumps({"capacity": rc, "observed_host": observed["verification_profile"].get("observed_host"),
                              "diagnostics": observed.get("errors", [])}))
        missing = []
        if sys.version_info[:3] != (3, 11, 10):
            missing.append("Python 3.11.10")
        if not bwrap.is_file() or command([str(bwrap), "--version"]) != "bubblewrap 0.12.0":
            missing.append("pinned bubblewrap 0.12.0")
        lean = shutil.which("lean", path=env["PATH"])
        if not lean or "version 4.35.0," not in command([lean, "--version"], env=env, cwd=source):
            missing.append("Linux Lean 4.35.0 on PATH")
        print(json.dumps({"missing_tools": missing, "visible_cpus": len(os.sched_getaffinity(0)),
                          "pid1": Path("/proc/1/comm").read_text().strip()}))
        if rc or missing:
            return 1
        # Exercise the stock delegation probe while the verifier tree is trusted. No candidate code runs.
        probe = "from pathlib import Path; from scripts.verify_submission import supervisor_bootstrap; print(supervisor_bootstrap(Path.cwd()))"
        return subprocess.run([sys.executable, "-c", probe], cwd=policy, env=env).returncode
    require(sys.version_info[:3] == (3, 11, 10), "Use official Python 3.11.10 for this replay.")
    require(bwrap.is_file() and command([str(bwrap), "--version"]) == "bubblewrap 0.12.0",
            "Build bubblewrap with the pinned scripts/install_bwrap.sh.")
    lean = shutil.which("lean", path=env["PATH"])
    require(lean and "version 4.35.0," in command([lean, "--version"], env=env, cwd=source),
            "Use the submitted official Linux Lean toolchain.")
    if nonstandard_window:
        evidence = {
            "source_commit": report["source"]["commit"],
            "verification_policy_commit": POLICY,
            "prepared_report_sha256": args.report_sha256,
            "published_profile": PROFILE,
            "published_profile_budget_seconds": profile_budget,
            "local_replay_budget_seconds": args.execution_budget_seconds,
            "clock_basis": timing_basis,
            "job_started_at_epoch": epoch,
            "classification": "local alternate-window replay",
        }
        with window_path.open("x", encoding="utf-8") as dest:
            json.dump(evidence, dest, indent=2)
            dest.write("\n")
    with output.open("xb") as dest:
        dest.write(original.read_bytes())
    rc = subprocess.run(capacity, cwd=policy, env=env).returncode
    if rc == 0:
        rc = subprocess.run(execution, cwd=policy, env=env).returncode
    decision = json.loads(output.read_bytes())
    print(json.dumps({k: decision.get(k) for k in ("status", "stage", "errors", "warnings", "kernel_attempts")}))
    return 0 if rc == 0 and (decision.get("status"), decision.get("stage")) == ("pass", "complete") else (rc or 1)

if __name__ == "__main__":
    raise SystemExit(main())
