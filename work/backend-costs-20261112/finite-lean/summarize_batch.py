"""Audit the bounded stock-Lean batch experiment before reporting its costs."""
import hashlib
import json
import re
import statistics
from pathlib import Path

here = Path(__file__).resolve().parent

def read(name):
    return json.loads((here / name).read_text(encoding="utf-8"))

def successful(label):
    result = read(label + ".json")
    assert result["exit_code"] == 0 and result["stop"] is None, label
    for artifact in result["artifacts"]:
        if artifact["path"].endswith((".log", ".lean")):
            actual = hashlib.sha256((here / artifact["path"]).read_bytes()).hexdigest().upper()
            assert actual == artifact["sha256"], artifact["path"]
    return result

fixture = read("fixture1024.json")
data = read("BATCH_DATA_AUDIT.json")
assert data["passed"]
assert data["source_sha256"].upper() == hashlib.sha256((here / "BatchData1024.lean").read_bytes()).hexdigest().upper()
assert (data["certificate_nodes"], data["expanded_factors"], data["root_primes"], data["witnesses"]) == (1537, 7614, 393, 1024)
successful("batchcontrols01")
controls = (here / "batchcontrols01.log").read_text(encoding="utf-8").splitlines()
assert len(controls) == 14
assert all(re.fullmatch(r"CONTROL,BatchControls1024\.\w+,accepted=(true|false),expected=\1", line) for line in controls)
assert sum("expected=false" in line for line in controls) == 9
successful("batchaudit01")
audit = (here / "batchaudit01.log").read_text(encoding="utf-8")
assert audit.count("[propext, Classical.choice, Quot.sound]") == 2
assert "sorryAx" not in audit
assert str(fixture["target"]) in audit and str(fixture["end_exclusive"]) in audit
assert "∀ p ∈ BatchData1024.roots, Nat.Prime p" in audit

phases = {}
for phase in ("full", "primality", "roots", "cover"):
    runs = [successful(f"batch{phase}_sample{i}") for i in (1, 2, 3)]
    assert all(len(run["rows"]) == 1 for run in runs)
    assert all(run["limits_lines"] == ["LIMITS,trust=0,heartbeats=0,recdepth=65536"] for run in runs)
    rows = [run["rows"][0] for run in runs]
    assert all(row["width"] == 1024 and row["repetitions"] == 1 for row in rows)
    assert len({row["declarations"] for row in rows}) == 1
    samples = [row["kernel_bundle_wall_ns"] / 1e9 for row in rows]
    phases[phase] = {
        "kernel_elapsed_seconds": samples,
        "median_kernel_elapsed_seconds": statistics.median(samples),
        "declarations": rows[0]["declarations"],
        "median_process_cpu_seconds": statistics.median(run["cpu_seconds"] for run in runs),
        "median_process_wall_seconds": statistics.median(run["wall_seconds"] for run in runs),
        "observed_peak_private_bytes": max(run["observed_peak_private_bytes"] for run in runs),
    }

labels = ["batchprime02", "batchdata02"] + [f"batchvalid_{i:02}" for i in range(8)] + ["batchblock02"]
builds = {label: successful(label) for label in labels}
proof_files = ["BatchPrime.lean", "BatchData1024.lean", "BatchBlock1024.lean"] + [f"BatchValidPart{i:02}.lean" for i in range(8)]
assert all(not re.search(r"\b(?:sorry|axiom|native_decide)\b", (here / name).read_text(encoding="utf-8")) for name in proof_files)
baseline = read("RESULTS.json")
out = {
    "passed": True,
    "scope": "1537-node Lucas graph, all 393 requested root primes and closed 1024-target interval",
    "interval": [fixture["target"], fixture["end_exclusive"]],
    "axioms": ["propext", "Classical.choice", "Quot.sound"],
    "data_audit": data,
    "positive_controls": 5,
    "negative_controls": 9,
    "phases": phases,
    "baseline_full_median_kernel_elapsed_seconds": baseline["phases"]["full"]["median_kernel_elapsed_seconds"],
    "new_over_baseline_full_replay_ratio": phases["full"]["median_kernel_elapsed_seconds"] / baseline["phases"]["full"]["median_kernel_elapsed_seconds"],
    "incremental_project_build_cpu_seconds": sum(run["cpu_seconds"] for run in builds.values()),
    "incremental_project_build_wall_seconds": sum(run["wall_seconds"] for run in builds.values()),
    "build_components": {label: {key: run[key] for key in ("cpu_seconds", "wall_seconds")} for label, run in builds.items()},
    "limitations": [
        "Generic support and literal definitions are imported, not rechecked in timed certificate replay",
        "Kernel loop reports elapsed time; separate whole-process CPU includes imports and warmup",
        "Incremental build uses prebuilt common PrimeBitmap/PrimeSupport/Mathlib and excludes audits, replays, failed attempts",
        "Some corruptions reject at an earlier guard; they do not isolate every individual check",
        "The root conjunction contains 162 primes unused by these explicit pair witnesses",
        "No transfer of HOL's prime-phase speedup to stock Lean or full TG",
    ],
}
(here / "BATCH_RESULTS.json").write_text(json.dumps(out, indent=2) + "\n", encoding="utf-8")
print(json.dumps({key: out[key] for key in ("passed", "phases", "new_over_baseline_full_replay_ratio", "incremental_project_build_cpu_seconds")}))
