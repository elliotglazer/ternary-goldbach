"""Linux pilot: bootstrap the pinned dependencies, then compile and audit one interval."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys
import tempfile
from time import monotonic

ROOT = Path(__file__).resolve().parent
os.chdir(ROOT)
sys.dont_write_bytecode = True


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(command):
    return subprocess.check_output(command, text=True, cwd=ROOT).strip()


def check_inputs():
    pins = json.loads((ROOT / "inputs.json").read_text())
    for filename, expected in pins.items():
        if sha(ROOT / filename) != expected:
            raise ValueError(f"input hash mismatch: {filename}")
    return pins


def fixture_smoke():
    import pilot
    fixture = json.loads((ROOT / "upper-fixture.json").read_text())
    pairs = pilot.verify(fixture)
    with tempfile.TemporaryDirectory() as temp:
        pilot.HERE = Path(temp)
        pilot.emit_lean(fixture, pairs)
        original = (ROOT / "UpperBinaryPilot.lean").read_text(encoding="utf-8")
        regenerated = (Path(temp) / "UpperBinaryPilot.lean").read_text(encoding="utf-8")
        if original != regenerated:
            raise ValueError("the Lean data differ from the generated fixture")
    return len(pairs)


def measure(run, label, cmd, env, timeout):
    log = run / f"{label}.log"
    start = monotonic()
    with log.open("wb") as out:
        proc = subprocess.Popen(["timeout", "--kill-after=15", str(timeout), *cmd],
                                env=env, stdout=out, stderr=subprocess.STDOUT)
        _, status, usage = os.wait4(proc.pid, 0)
        proc.returncode = os.waitstatus_to_exitcode(status)
    row = dict(stage=label, command=cmd, exit_code=proc.returncode,
               user_seconds=usage.ru_utime, system_seconds=usage.ru_stime,
               max_rss_kib=usage.ru_maxrss, wall_seconds=monotonic()-start,
               log_sha256=sha(log))
    print(json.dumps(row), flush=True)
    return row


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--smoke", action="store_true", help="check input hashes and regenerate Lean input in a temporary directory")
    parser.add_argument("--bootstrap", action="store_true", help="allow Lake to fetch locked dependencies and their official cache")
    parser.add_argument("--run-dir", type=Path, default=Path("run"), help="new output directory for telemetry and objects")
    args = parser.parse_args()
    pins = check_inputs()
    targets = fixture_smoke()
    if args.smoke:
        print(json.dumps(dict(smoke="pass", targets=targets, pinned_inputs=len(pins),
                              platform=platform.platform(), python=platform.python_version())))
        return

    run = args.run_dir.resolve()
    run.mkdir(parents=True, exist_ok=False)
    receipt = dict(pinned_inputs=pins, platform=platform.platform(), machine=platform.machine(),
                   stages=[], passed=False)
    env = os.environ.copy()
    def stage(name, cmd, timeout=900):
        r = measure(run, name, cmd, env, timeout)
        receipt["stages"].append(r)
        if r["exit_code"]:
            raise RuntimeError(f"failed {name}; see {run / (name+'.log')}")
    try:
        receipt["lean"] = read(["lean", "--version"])
        if "version 4.35.0," not in receipt["lean"] or "eb6cafb7290e8bd5f2937522d8d804f58f02bafc" not in receipt["lean"]:
            raise ValueError("Lean binary does not match the recorded official release commit")
        if args.bootstrap:
            stage("bootstrap", ["lake","exe","cache","get","Mathlib.NumberTheory.LucasPrimality",
                                "Mathlib.Data.ZMod.Basic","Mathlib.Data.Nat.Bitwise","Mathlib.Data.List.Prime"],3600)
        dep_pins = json.loads((ROOT/"lake-manifest.json").read_text())["packages"]
        actual = {}
        for dep in dep_pins:
            path = ROOT/".lake/packages"/dep["name"]
            rev = read(["git","-C",str(path),"rev-parse","HEAD"])
            if rev != dep["rev"] or read(["git","-C",str(path),"status","--short","--untracked-files=no"]):
                raise ValueError(f"dependency checkout differs from pin: {path}")
            actual[dep["name"]] = rev
        receipt["dependency_revisions"] = actual
        check_inputs()
        original_path = read(["lake","env","printenv","LEAN_PATH"])
        env["LEAN_PATH"] = str(run) + os.pathsep + original_path
        for name in ("PrimeSupport","PrimeBitmap","BatchPrime","UpperBinaryPilot","Audit"):
            stage(name,["lean","-t0","-j1","-M4096","-o",str(run/(name+".olean")),name+".lean"])
        expected = "'UpperBinaryPilot.binary_interval' depends on axioms: [propext, Classical.choice, Quot.sound]"
        if expected not in (run/"Audit.log").read_text().splitlines():
            raise ValueError("audit differs from the expected three axioms")
        receipt["axioms_line"] = expected
        receipt["artifacts"] = {p.name:sha(p) for p in sorted(run.glob("*.olean"))}
        receipt["passed"] = True
    finally:
        (run/"receipt.json").write_text(json.dumps(receipt, indent=2)+"\n")


if __name__ == "__main__":
    main()
