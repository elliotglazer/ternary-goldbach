"""Plan and resume the pinned Goldbach modules and the localized zero-sum audit."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import statistics
import subprocess
import sys
import time
from uuid import uuid4

HERE = Path(__file__).resolve().parent
WORK = HERE.parents[2]
SHARED = WORK / "qrh-campaign/agents/integration"
spec = importlib.util.spec_from_file_location("goldbach_driver", SHARED / "build_project.py")
driver = importlib.util.module_from_spec(spec)
spec.loader.exec_module(driver)
ROOTS = ["TernaryGoldbach.Explicit.WeilWindow", "TernaryGoldbach.Explicit.WeilNumC"]
GOLDBACH_SHA = "23b2d68ca344203d4384e0aff7affa4ec034bef9"
BUILT = HERE / "closure/artifacts"
LOGS = HERE / "closure/logs"
LOCAL_SOURCES = {
    "LocalWeight": HERE / "LocalWeight.lean",
    "DensityBound": HERE / "DensityBound.lean",
    "ShiftedWeight": HERE / "ShiftedWeight.lean",
    "LocalMellin": HERE / "LocalMellin.lean",
    "WeilWindowRH": HERE.parent / "weil/WeilWindowRH.lean",
    "WeilWeightedRH": HERE / "WeilWeightedRH.lean",
    "LocalLowZeros": HERE / "LocalLowZeros.lean",
}

def check_pins():
    manifest = json.loads((driver.SOURCE / "lake-manifest.json").read_text(encoding="utf-8"))
    pins = [(driver.SOURCE, GOLDBACH_SHA)] + [(driver.PACKAGES / p["name"], p["rev"])
                                              for p in manifest["packages"]]
    for directory, expected in pins:
        actual = subprocess.check_output(["git", "-C", str(directory), "rev-parse", "HEAD"],
                                         text=True).strip()
        if actual != expected:
            raise RuntimeError(f"{directory}: expected {expected}, found {actual}")
    return {directory.name: sha for directory, sha in pins}

def project_plan():
    ordered = []
    rows = {}
    packages = [driver.PACKAGES / "mathlib"] + sorted(p for p in driver.PACKAGES.iterdir()
                                                      if p.is_dir() and p.name != "mathlib")
    environment = driver.environment_identity(packages)

    def visit(module):
        if module in rows:
            return
        deps = driver.imports(module)
        for dep in deps:
            visit(dep)
        receipt = driver.LOGS / (module + ".success.json")
        path = driver.output_path(module)
        valid = False
        seconds = None
        generation = None
        if receipt.exists() and path.is_file() and all(rows[dep]["verified_cache"] for dep in deps):
            data = json.loads(receipt.read_text())
            key = data["key"]
            valid = (key["module"] == module and key["environment"] == environment and
                     key["source_sha256"] == driver.digest(driver.source_path(module)) and
                     data["artifacts"] == driver.inventory(path) and
                     key["dependency_receipts"] == {
                         dep: driver.digest(driver.LOGS / (dep + ".success.json")) for dep in deps})
            if valid:
                generation = data.get("generation")
                seconds = data.get("evidence", {}).get("seconds")
        rows[module] = dict(module=module, deps=deps, verified_cache=valid,
                            generation=generation, previous_wall_seconds=seconds)
        ordered.append(rows[module])

    for m in ROOTS:
        visit(m)
    return ordered

def deps_for(path):
    return [m for m in re.findall(r"^import\s+([.\w]+)", path.read_text(encoding="utf-8"), re.M)
            if m in LOCAL_SOURCES or m.startswith("TernaryGoldbach.")]

def compile_local(plan):
    if not all(row["verified_cache"] for row in plan):
        raise RuntimeError("The upstream closure is incomplete. Resume the upstream stage first.")
    BUILT.mkdir(parents=True, exist_ok=True)
    LOGS.mkdir(parents=True, exist_ok=True)
    env = os.environ.copy()
    env["LEAN_PATH"] = os.pathsep.join([str(BUILT), str(driver.ARTIFACTS)] +
        [str(p / ".lake/build/lib/lean") for p in driver.PACKAGES.iterdir() if p.is_dir()])
    audit = HERE / "closure/AuditActual.lean"
    names = ["TernaryGoldbach.Explicit.weil_windowH_of_rh", "TernaryGoldbach.Explicit.weil_weightedH_of_rh",
             "TernaryGoldbach.Explicit.localized_low_zeros_lt"]
    audit.write_text("import LocalLowZeros\n" + "".join(f"#print axioms {n}\n" for n in names),
                     encoding="utf-8")
    sources = {**LOCAL_SOURCES, "AuditActual": audit}
    for name, path in sources.items():
        dependencies = deps_for(path)
        output = BUILT / (name + ".olean")
        receipt = LOGS / (name + ".success.json")
        log = LOGS / (name + ".log")
        key = {"source": driver.digest(path), "lean": driver.digest(driver.LEAN),
               "mathlib": "56a005855ea17e0b0958f73ec801ae140b0a1679",
               "dependencies": {m: driver.digest((driver.LOGS if m.startswith("TernaryGoldbach.") else LOGS)
                                                   / (m + ".success.json")) for m in dependencies}}
        if output.is_file() and receipt.is_file():
            old = json.loads(receipt.read_text())
            if old["key"] == key and old["olean"] == driver.digest(output):
                print("cached", name, flush=True)
                continue
        staging = BUILT / ("stage-" + uuid4().hex)
        staging.mkdir()
        target = staging / output.name
        cmd = [str(driver.LEAN), "-t0", "-j1", "-M4096", "-o", str(target), path.name]
        start = time.monotonic()
        print("checking", name, flush=True)
        with log.open("w", encoding="utf-8") as stream:
            p = subprocess.run(cmd, cwd=path.parent, env=env, stdout=stream, stderr=subprocess.STDOUT)
        if p.returncode:
            print(log.read_text(encoding="utf-8"))
            raise SystemExit(p.returncode)
        if name == "AuditActual":
            text = log.read_text(encoding="utf-8")
            for n in names:
                if f"'{n}' depends on axioms: [propext, Classical.choice, Quot.sound]" not in text:
                    raise RuntimeError("Inspect the axiom inventory of " + n)
        if key["source"] != driver.digest(path):
            raise RuntimeError(f"{name} changed during compilation")
        os.replace(target, output)
        staging.rmdir()
        driver.write_receipt(receipt, {"key": key, "olean": driver.digest(output), "exit": 0,
                                       "seconds": time.monotonic()-start, "command": cmd})

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("action", choices=["plan", "upstream", "local", "all"])
    args = parser.parse_args()
    pins = check_pins()
    if args.action in ("upstream", "all"):
        subprocess.run([sys.executable, str(SHARED / "build_project.py"), "--max-memory-mb", "4096", *ROOTS], check=True)
    plan = project_plan()
    n = sum(row["verified_cache"] for row in plan)
    times = [r["previous_wall_seconds"] for r in plan if r["previous_wall_seconds"]]
    median = statistics.median(times) if times else None
    mean = statistics.mean(times) if times else None
    directory = HERE / "closure"
    directory.mkdir(exist_ok=True)
    record = {"pins": pins, "verified_upstream": n, "upstream_count": len(plan),
              "ordered_upstream": plan, "ordered_local": list(LOCAL_SOURCES) + ["AuditActual"],
              "timed_modules": len(times), "median_wall_seconds": median, "mean_wall_seconds": mean}
    driver.write_receipt(directory / "plan.json", record)
    print(f"{n}/{len(plan)} upstream receipts verified, {len(plan)-n} missing; "
          f"historical mean/median {mean:.1f}/{median:.1f} seconds per timed module", flush=True)
    if args.action in ("local", "all"):
        compile_local(plan)

if __name__ == "__main__":
    main()
