"""Check the two assembly files after the shared project replay publishes their imports."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time
from uuid import uuid4

HERE = Path(__file__).resolve().parent
TEAM = HERE.parent
WORK = TEAM.parents[1]
PROJECT = WORK / "qrh-campaign/agents/integration"
WINDOW = TEAM / "local-window/closure"
BUILD = TEAM.parent / "build"
PACKAGES = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
LEAN = Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
ROOTS = [PROJECT / "artifacts", BUILD, WINDOW / "artifacts", TEAM / "local-leak"]
INPUTS = {
    "WeightedBound": ["TernaryGoldbach.Explicit.PsiExplicit", "TernaryGoldbach.Explicit.WeilLineSum",
                      "Vertical", "ZeroBudget"],
    "PrimeInterval": ["WeightedBound", "LocalLowZeros", "LeakOutside", "Transfer", "TernaryGoldbach.Statement"],
}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def find_olean(module):
    relative = Path(*module.split(".")).with_suffix(".olean")
    return next((path for root in ROOTS if (path := root / relative).is_file()), None)


def ready(module):
    if not find_olean(module):
        return False
    if module.startswith("TernaryGoldbach."):
        return (PROJECT / "logs" / (module + ".success.json")).is_file()
    if module == "LocalLowZeros":
        return (WINDOW / "logs/LocalLowZeros.success.json").is_file()
    return True


def check(module):
    source = HERE / (module + ".lean")
    result = BUILD / (module + ".olean")
    tag = uuid4().hex[:12]
    log = HERE / (module + "-" + tag + ".log")
    receipt = log.with_suffix(".json")
    staged = BUILD / ("stage-" + tag)
    staged.mkdir()
    output = staged / result.name
    inputs = {m: digest(find_olean(m)) for m in INPUTS[module]}
    source_sha = digest(source)
    env = os.environ.copy()
    env["LEAN_PATH"] = os.pathsep.join(str(path) for path in
        ROOTS + [p / ".lake/build/lib/lean" for p in PACKAGES.iterdir() if p.is_dir()])
    args = [str(LEAN), "-t0", "-j1", "-M4096", "-o", str(output), source.name]
    print(f"Checking {module}, log {log.name}", flush=True)
    before = time.monotonic()
    with log.open("x", encoding="utf-8") as stream:
        process = subprocess.run(args, env=env, cwd=HERE, stdout=stream, stderr=subprocess.STDOUT)
    details = {"source_sha256": source_sha, "inputs_sha256": inputs, "exit": process.returncode,
               "log": log.name, "log_sha256": digest(log), "seconds": time.monotonic() - before}
    if process.returncode == 0:
        if digest(source) != source_sha or any(digest(find_olean(m)) != sha for m, sha in inputs.items()):
            raise RuntimeError("A proof input changed during validation")
        if module == "PrimeInterval":
            flat = " ".join(log.read_text(encoding="utf-8").split())
            for name in ("exists_prime_in_local_interval", "ternary_goldbach_up_to_1e27_of_rh"):
                expected = f"'TernaryGoldbach.Explicit.{name}' depends on axioms: [propext, Classical.choice, Quot.sound]"
                if expected not in flat:
                    raise RuntimeError(f"Unexpected axiom inventory for {name}: {flat}")
        os.replace(output, result)
        details["olean_sha256"] = digest(result)
    receipt.write_text(json.dumps(details, indent=2), encoding="utf-8")
    if not any(staged.iterdir()):
        staged.rmdir()
    if process.returncode:
        print(log.read_text(encoding="utf-8"))
        raise SystemExit(process.returncode)
    print(f"Checked {module}, receipt {receipt.name}", flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--wait-minutes", type=float, default=0)
    args = parser.parse_args()
    stop = time.monotonic() + args.wait_minutes * 60
    for module, deps in INPUTS.items():
        pending = [dep for dep in deps if not ready(dep)]
        if pending:
            print(f"Waiting for {module} imports: {', '.join(pending)}", flush=True)
        while pending and time.monotonic() < stop:
            time.sleep(min(30, max(0, stop - time.monotonic())))
            pending = [dep for dep in deps if not ready(dep)]
        if pending:
            raise SystemExit(f"Waiting for {', '.join(pending)}")
        check(module)
