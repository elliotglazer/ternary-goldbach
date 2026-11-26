#!/usr/bin/env python3
"""Run Palomar's official intake or its complete judgment on a fresh, pinned Goldbach checkout."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import time

POLICY = "14aa8d6b3c2f14a8540605e37144560b9a00e7e7"
PROFILE = "palomar-namespace-32x64-v1"
BUDGET = 19800
WORKFLOW_SECONDS = 21000
WINDOW_OPEN = 1795689000
DEADLINE = 1795712400
PROTECTED = {
    "GoldbachChallenge.lean": "f9e6190b4c77c9bf474c6d36748278af41140237432fff72e8084a4c572a382a",
    "GoldbachSolution.lean": "4cea88129a02f692ab896084d017ae83e43aca78770585897baf823c4b03eae7",
    "comparator.json": "073582e85645abd6e5949deb0531c11797ac9c1266073bf913b02d86173ebdcb",
    "lean-toolchain": "ca5f1f601d34c49079e38d7e7041eb0f2a9c227fbc1df0f404820069a052330c",
}
F850 = "f85040a7a5263b32cce873ac345010a7d0f1f2b9"
F850_TREE = "728ed945f3e4e2a7c48d7ff0c01412cf43cc2ff9"
ACCOUNT = "elliotglazer/ternary-goldbach"

def require(ok, reason):
    if not ok:
        raise ValueError(reason)

def digest(path):
    with path.open("rb") as fp:
        return hashlib.file_digest(fp, "sha256").hexdigest()

def write(path, obj):
    with path.open("x") as out:
        json.dump(obj, out, indent=2, sort_keys=True)
        out.write("\n")

def read(path):
    return json.loads(path.read_bytes())

def output(argv, **kw):
    return subprocess.check_output(argv, text=True, **kw).strip()

def validate_window(mode, start, now, deadline, outer=None):
    require(WINDOW_OPEN <= start <= now, "The separately reviewed job cannot start before 10:30 UTC")
    require(now < deadline-45, "Retained-host deadline has passed or leaves no evidence recovery time")
    if mode == "protected":
        if outer is None:
            require(start+BUDGET <= deadline,
                    "The original host cutoff cannot accommodate the full 19,800-second verification window")
        else:
            require(type(outer) is int and start+60 <= outer <= min(start+BUDGET, deadline-180)
                    and now < outer, "Invalid or expired local wall cutoff")
        require(now < start+BUDGET, "Original verification deadline already reached")

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("mode", choices=("prepare", "protected"))
    p.add_argument("--commit", required=True)
    p.add_argument("--tree", required=True)
    p.add_argument("--clock", required=True, type=Path,
                   help="Root-recorded original job start, candidate identity, setup basis and cutoff.")
    p.add_argument("--directory", type=Path, required=True, help="A new directory under a writable parent.")
    p.add_argument("--policy", type=Path, required=True)
    p.add_argument("--bundle", type=Path, required=True)
    p.add_argument("--bwrap", type=Path)
    args = p.parse_args()
    require(sys.version_info[:3] == (3, 11, 10), "Use the vetted Python 3.11.10 environment")
    require(os.geteuid() != 0, "Run inside the unprivileged verifier session")
    require(all(re.fullmatch("[0-9a-f]{40}", x) for x in (args.commit, args.tree)), "Need full immutable Git identities")
    require((args.commit != F850 or args.tree == F850_TREE), "Wrong reviewed f850 tree")
    clock_path = args.clock.resolve(strict=True)
    meta = clock_path.stat()
    require(meta.st_uid == 0 and meta.st_mode & 0o022 == 0, "Use a root-owned, non-group/world-writable clock")
    clock = read(clock_path)
    require(clock["commit"] == args.commit and clock["tree"] == args.tree and clock["mode"] == args.mode and
            clock["host_deadline_epoch"] == DEADLINE, "Clock or immutable source identity mismatch")
    require(clock["setup_basis"] in ("preprovisioned", "original-before-trusted-setup"), "Missing setup basis")
    start = clock["job_started_at_epoch"]
    require(type(start) is int, "Invalid job-start field")
    outer = clock.get("local_outer_cutoff_epoch")
    validate_window(args.mode, start, int(time.time()), DEADLINE, outer)
    if args.mode == "protected":
        require(clock.get("aggregate_profile_verified") is True, "The common cgroup has not been qualified")
        require(args.bwrap is not None and output([str(args.bwrap),"--version"]) == "bubblewrap 0.12.0", "Wrong bubblewrap")
    policy = args.policy.resolve(strict=True)
    env = os.environ.copy()
    env.update(PYTHONDONTWRITEBYTECODE="1", PALOMAR_EXECUTION_PROFILE=PROFILE, PALOMAR_JOB_STARTED_AT=str(start),
               GIT_OPTIONAL_LOCKS="0", GIT_CONFIG_GLOBAL="/dev/null", GIT_CONFIG_NOSYSTEM="1", GIT_TERMINAL_PROMPT="0")
    def git(where, *argv):
        return output(["git", "-c", f"safe.directory={where}", "-C", str(where), *argv], env=env)
    require(git(policy, "rev-parse", "HEAD") == POLICY and not git(policy, "status", "--porcelain", "--ignored"),
            "Pinned stock verifier checkout must contain only clean tracked files")
    base = args.directory.absolute()
    base.mkdir(mode=0o700, exist_ok=False)
    work = base/"work"
    mechanical = base/"mechanical-report.json"
    options = {"comparator_config_path":"comparator.json",
               "authorization_relationship":"I have approval from a responsible author or maintainer",
               "authorization_evidence":"Local mechanical preflight directed by the named repository maintainer in this workspace. No registry submission is being made."}
    write(base/"event.json", {"inputs":{"request_id":"localpilot01","repository":ACCOUNT,"commit":args.commit,
                                        "mode":"full","options":json.dumps(options)}})
    write(base/"job-origin.json", {"clock":clock, "clock_sha256":digest(clock_path),
                                   "policy":POLICY, "runner_sha256":digest(Path(__file__)),
                                   "proof_artifacts_reused":False})
    verifier = str(policy/"scripts/verify_submission.py")
    def stock(stage, *argv):
        print(stage, flush=True)
        with (base/(stage+".log")).open("xb") as out:
            cmd=[sys.executable, "-B", verifier, stage, *map(str,argv)]
            # Stock enforces its 330-minute deadline from the original clock. Its report and evidence use the 350-minute envelope.
            seconds=min(start+WORKFLOW_SECONDS, DEADLINE, outer or DEADLINE)-time.time()
            require(seconds > 0, "Job's time allowance was exhausted")
            subprocess.run(cmd, cwd=policy, env=env, check=True, stdout=out, stderr=subprocess.STDOUT, timeout=seconds)
    try:
        stock("prepare","--event",base/"event.json","--work-dir",work,"--output",mechanical,"--licensee",args.bundle)
        summary=read(mechanical)
        shutil.copyfile(mechanical,base/"prepared-report.json")
        source=work/"source"
        require(summary["status"]=="pending" and summary["stage"]=="prepared" and not summary["errors"] and not summary["warnings"],"Intake did not pass cleanly")
        require(summary["source"]["commit"]==args.commit and summary["source"]["repository"]==ACCOUNT and
                git(source,"rev-parse","HEAD")==args.commit and git(source,"rev-parse","HEAD^{tree}")==args.tree and
                not (source/".lake").exists() and not git(source,"status","--porcelain","--ignored"),"Stock source identity or freshness mismatch")
        require(summary["verification_profile"]["id"]==PROFILE and summary["verification_profile"]["limits"]["execution_budget_seconds"]==BUDGET and
                summary["lean_toolchain"]=="leanprover/lean4:v4.35.0" and summary["license"]["detected_identifier"]=="Apache-2.0",
                "Unexpected verification profile, toolchain or license")
        require(summary["comparator"]["theorem_names"]==["PalomarTernaryGoldbach.ternary_goldbach"] and
                summary["comparator"]["definition_names"]==[] and set(summary["comparator"]["permitted_axioms"])=={"propext","Quot.sound","Classical.choice"} and
                all(digest(source/k)==v for k,v in PROTECTED.items()),"Unexpected protected theorem, entry point or axiom contract")
        if args.commit==F850:
            require(summary["source_requirements"]["files_checked"]==1529 and summary["source"]["bytes"]==364823631, "Unexpected f850 intake census")
        if args.mode=="protected":
            stock("check-capacity","--disk-path",work,"--output",mechanical)
            stock("execute","--work-dir",work,"--output",mechanical,"--bwrap",args.bwrap,
                  "--bwrap-source-tag","v0.12.0","--execution-budget-seconds",BUDGET,"--workflow-url",mechanical.as_uri())
            judged=read(mechanical)
            require((judged.get("status"),judged.get("stage"))==("pass","complete"),"Stock proof judgment did not pass")
            if outer is not None:
                finished = time.time()
                require(finished <= outer, "Stock completion arrived after the local cutoff")
                write(base/"stock-completed-before-cutoff.json", {"commit":args.commit,"tree":args.tree,
                      "job_started_at_epoch":start,"local_outer_cutoff_epoch":outer,"finished_epoch":finished,
                      "mechanical_sha256":digest(mechanical),"verified_clock_sha256":digest(clock_path)})

    finally:
        exports=work/"exports"
        files=[x for x in base.iterdir() if x.is_file()]
        files += [p for p in (work/"resource-metrics.jsonl",) if p.is_file()]
        if exports.is_dir():
            files += [p for p in exports.iterdir() if p.is_file() and not p.is_symlink()]
        # Bound artifact capture by the same outer service deadline. Preserve every earlier hash if interrupted.
        with (base/"SHA256SUMS").open("x") as out:
            for f in sorted(files,key=lambda f:(f.parent==exports,str(f))):
                out.write(f"{digest(f)}  {f.relative_to(base)}\n")
                out.flush()
    print(json.dumps({"mode":args.mode,"commit":args.commit,"tree":args.tree,"setup_basis":clock["setup_basis"],
                      "status":read(mechanical)["status"],"stage":read(mechanical)["stage"],
                      "stock_report_sha256":digest(mechanical),"intake_census":summary["source_requirements"],
                      "source_bytes":summary["source"]["bytes"]}),flush=True)

if __name__=="__main__":
    main()
