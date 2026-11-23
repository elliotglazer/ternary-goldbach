"""Validate nine saved CPU replay receipts and publish one immutable summary.

No build, subprocess, Lean evaluation, candidate production or timing run is
performed. Missing or invalid evidence prints PENDING and writes no report.
This script is prepared for a separately authorized run after all nine jobs.
"""
from pathlib import Path
import hashlib
import json
import math
import re
import statistics
import sys

HERE = Path(__file__).resolve().parent
OUTPUT = HERE / "MEASUREMENTS.json"
LIMITS = "LIMITS,trust=0,heartbeats=0,recdepth=65536"
FIXTURE_HASH = "bb725a50ab0ec32a07f3516542e2fc3ce59081e75598e7283b686d0afdbb12c3"
GROUPS = {
    "logs": {
        "labels": ["cpu_logs64_02", "cpu_logs64_03", "cpu_logs64_04"],
        "variant": "raw_logs64", "wrapper": "CpuRawLogs64.lean",
        "wrapper_hash": "033872ee0509050e13a95911d06e56c015762858403dfed15d146cda577c08ac",
        "namespace": "RawLogCases64.", "root": "RawLogCases64.all_logs", "reps": 50,
    },
    "supplied_inverse": {
        "labels": ["cpu_inverse64_01", "cpu_inverse64_02", "cpu_inverse64_04"],
        "variant": "raw_inverse64", "wrapper": "CpuRawInverseRoots64.lean",
        "wrapper_hash": "661595ca11540f221b4cd871073d6497d8af3c978e9419e59d798d1a5a183e84",
        "namespace": "RawLogCases64.", "root": "RawLogCases64.all_inverse_roots", "reps": 1000,
    },
    "computed_inverse": {
        "labels": ["cpu_generated_inverse64_01", "cpu_generated_inverse64_02", "cpu_generated_inverse64_03"],
        "variant": "raw_generated_inverse64", "wrapper": "CpuRawGeneratedInverseRoots64.lean",
        "wrapper_hash": "26555dc23e6f605f0ef990d783dc522cc1852c18f27e854f528993151261b8a0",
        "namespace": "RawInverseRootGenerated64.",
        "root": "RawInverseRootGenerated64.all_inverse_roots", "reps": 1000,
    },
}


def require(condition, description):
    if not condition:
        raise ValueError(description)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def file_evidence(path):
    data = path.read_bytes()
    return {"path": str(path), "sha256": sha(data), "bytes": len(data)}


def positive(value, label):
    require(type(value) in (int, float) and math.isfinite(value) and value > 0,
            f"{label} must be finite and strictly positive")
    return value


def integer(value, label, minimum=1):
    require(type(value) is int and value >= minimum, f"invalid integer {label}")
    return value


def snapshot_map(rows):
    require(isinstance(rows, list) and rows, "empty/malformed local snapshot")
    answer = {}
    for row in rows:
        path = str(Path(row["path"]).resolve())
        digest = row["sha256"].lower()
        require(path not in answer, f"duplicate snapshot path {path}")
        require(re.fullmatch(r"[0-9a-f]{64}", digest) is not None, "invalid snapshot digest")
        require(sha(Path(path).read_bytes()) == digest, f"snapshot file changed: {path}")
        answer[path] = digest
    return answer


def validate(label, group):
    receipt_path = HERE / f"{label}.json"
    raw = receipt_path.read_bytes()
    receipt = json.loads(raw)
    for key in ("protocol_valid", "source_unchanged", "local_imports_unchanged", "handshake_files_valid"):
        require(receipt.get(key) is True, f"{label}: {key} is not true")
    require(type(receipt.get("exit_code")) is int and receipt["exit_code"] == 0,
            f"{label}: nonzero/missing exit")
    require(receipt.get("stop") is None and receipt.get("reader_errors") == [], f"{label}: stopped or reader error")
    require(receipt.get("dependency_builds") is False, f"{label}: dependency-build status")
    require(receipt.get("limits_lines") == [LIMITS], f"{label}: limits marker")

    wrapper = HERE / group["wrapper"]
    wrapper_raw = wrapper.read_bytes()
    require(sha(wrapper_raw) == group["wrapper_hash"] == receipt["source_sha256"].lower(),
            f"{label}: wrapper pin mismatch")
    replay_lines = re.findall(r'^#replay_raw .+$', wrapper_raw.decode("utf-8"), re.M)
    expected_line = (f'#replay_raw "{group["variant"]}" "{group["namespace"]}" '
                     f'64 {group["reps"]} {group["root"]}')
    require([line.rstrip() for line in replay_lines] == [expected_line], f"{label}: wrapper root/arguments")
    command = receipt["command"]
    require(len(command) == 7 and Path(command[0]).name.lower() == "lean.exe" and
            command[1:5] == ["-t0", "-j1", "-M4096", "-o"] and
            Path(command[5]).resolve() == wrapper.with_suffix(".olean").resolve() and
            Path(command[6]).resolve() == wrapper.resolve(), f"{label}: unexpected command")

    rows = receipt["rows"]
    require(isinstance(rows, list) and len(rows) == 1, f"{label}: expected exactly one row")
    row = rows[0]
    require(row["variant"] == group["variant"] and type(row["width"]) is int and row["width"] == 64,
            f"{label}: variant/width mismatch")
    reps = integer(row["repetitions"], "repetitions")
    require(reps == group["reps"], f"{label}: repetitions mismatch")
    declarations = integer(row["declarations"], "declarations")
    pool_ns = integer(row["proof_pool_generation_ns"], "proof pool nanoseconds", 0)
    loop_ns = integer(row["kernel_elapsed_ns"], "kernel elapsed nanoseconds")
    phase_cpu = positive(row["kernel_process_cpu_seconds"], "phase CPU")
    require(receipt["phase_cpu_seconds"] == {group["variant"]: phase_cpu}, f"{label}: phase CPU binding")
    whole_cpu = positive(receipt["cpu_seconds"], "whole-process CPU")
    whole_wall = positive(receipt["wall_seconds"], "whole-process wall")
    require(whole_cpu >= phase_cpu and whole_wall >= loop_ns / 1e9, f"{label}: phase exceeds process")

    log_path = HERE / f"{label}.log"
    log_raw = log_path.read_bytes()
    require(sha(log_raw) == receipt["log_sha256"].lower(), f"{label}: log hash mismatch")
    log_lines = log_raw.decode("utf-8").splitlines()
    require([line for line in log_lines if line.startswith("LIMITS,")] == [LIMITS], f"{label}: log limits")
    expected_cover = f'COVER,{group["variant"]},64,{reps},{declarations},{pool_ns},{loop_ns}'
    require([line for line in log_lines if line.startswith("COVER,")] == [expected_cover], f"{label}: COVER binding")

    directory = HERE / f"{label}_handshake"
    require(Path(receipt["handshake_directory"]).resolve() == directory.resolve(), f"{label}: marker directory")
    markers = sorted(f'{stage}.{group["variant"]}.{suffix}'
                     for stage in ("START", "STOP") for suffix in ("ack", "request"))
    require(receipt["handshake_files"] == markers and sorted(p.name for p in directory.iterdir()) == markers,
            f"{label}: marker set mismatch")
    require(receipt["handled_requests"] == sorted(m for m in markers if m.endswith(".request")),
            f"{label}: request consumption")
    marker_evidence = []
    for name in markers:
        path = directory / name
        require(path.is_file(), f"{label}: non-file marker")
        require(path.read_text(encoding="utf-8") == ("ready\n" if name.endswith(".request") else "go\n"),
                f"{label}: marker contents")
        marker_evidence.append(file_evidence(path))

    before = snapshot_map(receipt["local_snapshot_before"])
    after = snapshot_map(receipt["local_snapshot_after"])
    require(before == after, f"{label}: changed local imports")
    require(before.get(str(wrapper.resolve())) == group["wrapper_hash"], f"{label}: wrapper absent in snapshot")
    runner_path = str((HERE / "run_replay.py").resolve())
    require(runner_path in before, f"{label}: runner absent in snapshot")

    return {
        "label": label, "variant": row["variant"], "width": 64,
        "repetitions": reps, "declarations": declarations,
        "phase_cpu_seconds": phase_cpu,
        "phase_cpu_seconds_per_64": phase_cpu / reps,
        "phase_cpu_seconds_per_input": phase_cpu / (reps * 64),
        "loop_elapsed_seconds": loop_ns / 1e9,
        "loop_elapsed_seconds_per_64": loop_ns / (1e9 * reps),
        "loop_elapsed_seconds_per_input": loop_ns / (1e9 * reps * 64),
        "whole_process_cpu_seconds": whole_cpu, "whole_process_wall_seconds": whole_wall,
        "proof_pool_rename_seconds_once": pool_ns / 1e9,
        "observed_peak_private_bytes": integer(receipt["observed_peak_private_bytes"], "private bytes"),
        "peak_working_set_bytes": integer(receipt["peak_working_set_bytes"], "working set bytes"),
        "wrapper": file_evidence(wrapper), "receipt": {"path": str(receipt_path), "sha256": sha(raw), "bytes": len(raw)},
        "log": file_evidence(log_path), "markers": marker_evidence,
        "command": command, "protocol": receipt["protocol"], "snapshot": before,
    }


def stats(values):
    return {"min": min(values), "median": statistics.median(values), "max": max(values)}


def main():
    require(not OUTPUT.exists(), "MEASUREMENTS.json already exists; immutable output will not be replaced")
    missing = [f"{label}.json" for group in GROUPS.values() for label in group["labels"]
               if not (HERE / f"{label}.json").is_file()]
    require(not missing, "missing receipts: " + ", ".join(missing))
    fixture_path = HERE / "fixture64.json"
    fixture_raw = fixture_path.read_bytes()
    require(sha(fixture_raw) == FIXTURE_HASH, "fixture pin changed")
    fixture = json.loads(fixture_raw)
    require(len(fixture["rows"]) == 64, "fixture row count")
    groups, all_runs = {}, []
    metric_names = ["phase_cpu_seconds_per_64", "phase_cpu_seconds_per_input",
                    "loop_elapsed_seconds_per_64", "loop_elapsed_seconds_per_input",
                    "whole_process_cpu_seconds", "whole_process_wall_seconds",
                    "proof_pool_rename_seconds_once", "observed_peak_private_bytes", "peak_working_set_bytes"]
    for name, specification in GROUPS.items():
        runs = [validate(label, specification) for label in specification["labels"]]
        first = runs[0]
        for run in runs[1:]:
            for key in ("variant", "width", "repetitions", "declarations", "snapshot", "command", "protocol"):
                require(run[key] == first[key], f"{name}: incomparable repetitions, field {key}")
            require(run["wrapper"]["sha256"] == first["wrapper"]["sha256"], f"{name}: source group changed")
        groups[name] = {"runs": runs, "summary": {key: stats([run[key] for run in runs]) for key in metric_names}}
        all_runs.extend(runs)

    # Different groups have different imports, but every shared local object
    # must retain one hash across all nine runs, not merely within a group.
    joint_snapshot = {}
    for run in all_runs:
        for path, digest in run["snapshot"].items():
            require(path not in joint_snapshot or joint_snapshot[path] == digest,
                    f"cross-group shared import mismatch: {path}")
            joint_snapshot[path] = digest
    common_paths = set.intersection(*(set(run["snapshot"]) for run in all_runs))
    require(any(Path(path).name == "RawReplay.lean" for path in common_paths), "missing common replay source")
    require(any(Path(path).name == "FiniteReplay.olean" for path in common_paths), "missing common kernel replay import")
    ratios = {}
    for metric in ("phase_cpu_seconds_per_64", "loop_elapsed_seconds_per_64"):
        numerator = groups["supplied_inverse"]["summary"][metric]["median"]
        denominator = groups["computed_inverse"]["summary"][metric]["median"]
        ratios[metric] = {"supplied_median": numerator, "computed_median": denominator,
                          "supplied_divided_by_computed": numerator / denominator}
    result = {
        "status": "VALIDATED_NINE_SAVED_RUNS", "groups": groups,
        "excluded_interrupted_attempts": [{
            "label": "cpu_inverse64_03",
            "replacement_label": "cpu_inverse64_04",
            "provenance": "Root reported an interrupted attempt with no JSON receipt, an empty log and START request/acknowledgement only; no Lean process was live at the two reported checks (21:55:56 and 21:58:51). These are coordinator observations, not reporter measurements.",
            "artifact_policy": "Retain all 03 artifacts unchanged; do not use them as a valid run or impute CPU/wall cost.",
            "included_in_statistics": False,
        }],
        "inverse_replay_median_ratios": ratios,
        "shared_local_import_snapshot": {path: joint_snapshot[path] for path in sorted(common_paths)},
        "all_local_dependency_pins": joint_snapshot,
        "fixture": file_evidence(fixture_path), "reporter": file_evidence(Path(__file__).resolve()),
        "native_fixture_proposal": {
            "cpu_seconds": fixture.get("producer_cpu_seconds"),
            "wall_seconds": fixture.get("producer_wall_seconds"),
            "interpretation": "A CPU observation of zero is below timer resolution, not zero work; no native speed ratio is inferred.",
        },
        "interpretation": [
            "Three fresh processes per group; repetitions within each process reuse the same 64-input fixture.",
            "Phase CPU is parent-sampled process CPU around synchronized renamed-kernel replay; handshake polling/file IO CPU is included.",
            "Loop elapsed is the child's inner replay loop and excludes handshake boundaries; it is not the same clock interval as phase CPU.",
            "Initial admission, imports and warmup are excluded from phase CPU but included in whole-process costs.",
            "Proof-pool preparation renames existing elaborated terms; it is not certificate generation or tactic elaboration.",
            "Whole-process totals use different repetition counts across groups and are not compared as construction costs.",
            "Only the two inverse groups receive matched-contract replay ratios; these are not end-to-end production speedups.",
            "No TG cost, optimality, batching benefit, real-data scaling or arithmetic/analytic throughput transfer is inferred.",
            "The replay wrappers explicitly use maxHeartbeats=0 and maxRecDepth=65536; trust remains zero. These are recorded measurement settings, not hidden defaults.",
        ],
    }
    encoded = (json.dumps(result, indent=2, sort_keys=True) + "\n").encode("utf-8")
    # Exclusive publication occurs only after all checks and serialization pass.
    with OUTPUT.open("xb") as handle:
        handle.write(encoded)
    print(json.dumps({"status": "PUBLISHED", "output": str(OUTPUT), "bytes": len(encoded), "sha256": sha(encoded)}))


if __name__ == "__main__":
    try:
        main()
    except Exception as error:
        print(json.dumps({"status": "PENDING", "reason": str(error),
                          "output_exists": OUTPUT.exists(), "builds_launched": False}))
        sys.exit(2)
