"""Validate six saved state-replay runs; publish only on explicit root invocation.

No builds, subprocesses, producer evaluation, benchmark or author-script imports.
Missing or inconsistent evidence fails closed; output is created exclusively.
Construction, repeated kernel acceptance, generation and byte inventories remain
separate. This is a fixed representation comparison, never a TG forecast.
"""
from pathlib import Path
import hashlib
import json
import math
import re
import statistics
import sys

HERE = Path(__file__).resolve().parent
OUTPUT = HERE / "STATE_MEASUREMENTS.json"
FIXTURE = "01c3e9f1af2fd8df40c9ef770840078e02ec356737727637c58397836c5c6bf9"
LIMITS = "LIMITS,trust=0,heartbeats=0,recdepth=65536"
MARKER = "MATCHED_STATE_CONTRACT,8,129,full_output_and_analytic_enclosures"
PINS = {
    "ReplayRawStateExplicit.lean": "94fafdcd4bb38f1b4a0116114fb3f0ed679c2f290700fdff6574fd5710782d4b",
    "ReplayRawStateComputed.lean": "412ed61913da2ddd759de8126ceeab0ca382002e4e7061a5cd30b64998ef38d5",
    "AuditRawStateComparison.lean": "10c204094f51c5bac7b53192a848c9ae7d8bef5c49aa469b9f9e7e851f9390ef",
    "RawStateFixtureData.lean": "bb0388ffa768a4f4caf9154534c7f7d40cc5f4177f91513a301610fea1b72cfb",
    "RawStateSources.lean": "f501cdb3daf8b2b41489b430057aa822854391902802da091608eb31136756a6",
    "RawTraceCertificate.lean": "24b874fc56f7e9ea650d024ea702d1977c83d41282a721d72d91fb98c87e50fc",
    "RawReplay.lean": "3c2bff76bb762b21a5ed86d02946b4592d5741d843e46aa0a37734b57005e943",
    "run_replay.py": "aea4f1db24bc2298ee562332b3b106c92f70f04fe4a1119f1464af3a4d6c745c",
    "RawStateComputedPacked.lean": "a124e9404c40d7d9f29adf12fe6832e09e26eb5254bbcf418213e8f37c5e3ac6",
}
GROUPS = {
    "explicit": ("ReplayRawStateExplicit.lean", "RawStateExplicit", "RawStateExplicit.full_output_checked"),
    "computed": ("ReplayRawStateComputed.lean", "RawStateComputedPacked", "RawStateComputedPacked.full_output_checked"),
}
BASES = [1, 2, 3, 41, 61, 10004, 262144, 265800]
CONSTRUCTION = {
    "explicit": [("stateexplicitsupport_01", "RawStateExplicitSupport.lean"),
                 ("stateexplicit1_01", "RawStateExplicit1.lean")]
                + [(f"stateexplicit{x}_02", f"RawStateExplicit{x}.lean") for x in BASES[1:]]
                + [("stateexplicitassembly_02", "RawStateExplicit.lean"),
                   ("stateexplicitclosure01", "RawStateExplicitClosure.lean")],
    "computed": [("statecomputedpacked01", "RawStateComputedPacked.lean")],
}
SHARED = [("statefixture01", "RawStateFixtureData.lean"),
          ("statesources02", "RawStateSources.lean"),
          ("logcases02", "RawLogCases.lean")]


def require(ok, message):
    if not ok:
        raise ValueError(message)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def evidence(path):
    path = Path(path).resolve()
    return {"path": str(path), "sha256": sha(path), "bytes": path.stat().st_size}


def read(label):
    return json.loads((HERE / (label + ".json")).read_text(encoding="utf-8"))


def number(value, label, positive=False):
    require(type(value) in (int, float) and math.isfinite(value)
            and (value > 0 if positive else value >= 0), f"invalid {label}")
    return value


def command_check(r, source):
    c = r["command"]
    require(len(c) == 7 and Path(c[0]).name.lower() == "lean.exe"
            and c[1:5] == ["-t0", "-j1", "-M4096", "-o"]
            and Path(c[5]).resolve() == source.with_suffix(".olean")
            and Path(c[6]).resolve() == source, "unexpected Lean command")


def success(r, label, source):
    require(type(r.get("exit_code")) is int and r["exit_code"] == 0
            and r.get("stop") is None, f"{label}: unsuccessful run")
    require(r.get("source_unchanged") is True and r.get("dependency_builds") is False,
            f"{label}: source/dependency status")
    command_check(r, source)
    require(sha(source) == r["source_sha256"].lower(), f"{label}: source pin")
    require(sha(HERE / (label + ".log")) == r["log_sha256"].lower(), f"{label}: log pin")
    number(r["cpu_seconds"], "whole CPU", True)
    number(r["wall_seconds"], "whole wall", True)


def build(label, name):
    r = read(label)
    source = (HERE / name).resolve()
    success(r, label, source)
    obj = source.with_suffix(".olean")
    require(sha(obj) == r["olean_sha256"].lower(), f"{label}: object pin")
    return {"label": label, "receipt": evidence(HERE / (label + ".json")),
            "log": evidence(HERE / (label + ".log")), "source": evidence(source),
            "object": evidence(obj), "command": r["command"],
            "cpu_seconds": r["cpu_seconds"], "wall_seconds": r["wall_seconds"],
            "observed_peak_private_bytes": number(r["observed_peak_private_bytes"], "private bytes"),
            "peak_working_set_bytes": number(r["peak_working_set_bytes"], "working bytes")}


def expected_snapshot(source):
    """Reconstruct the runner's local source/object import inventory, no imports."""
    roots = [HERE, HERE.parents[1] / "backend-costs-20261112/finite-lean"]
    pending, seen, paths = [source], set(), {HERE / "run_replay.py"}
    while pending:
        current = pending.pop()
        if current in seen:
            continue
        seen.add(current)
        paths.add(current)
        if current != source:
            paths.add(current.with_suffix(".olean"))
        for line in re.findall(r"^import ([A-Za-z0-9_. ]+)$", current.read_text(encoding="utf-8"), re.M):
            for module in line.split():
                for root in roots:
                    candidate = root / (module.replace(".", "/") + ".lean")
                    if candidate.exists():
                        pending.append(candidate)
                        break
    return {str(p.resolve()): sha(p) for p in paths}


def snapshot(rows):
    require(isinstance(rows, list) and rows, "missing snapshot")
    out = {str(Path(x["path"]).resolve()): x["sha256"].lower() for x in rows}
    require(len(out) == len(rows), "duplicate snapshot path")
    return out


def replay(group, index):
    wrapper, prefix, root = GROUPS[group]
    label, variant = f"cpu_state_{group}_{index:02d}", f"state_{group}"
    source = (HERE / wrapper).resolve()
    r = read(label)
    success(r, label, source)
    for k in ["protocol_valid", "local_imports_unchanged", "handshake_files_valid"]:
        require(r.get(k) is True, f"{label}: {k}")
    require(r.get("reader_errors") == [], f"{label}: reader errors")
    wanted = f'#replay_raw "{variant}" "{prefix}" 1024 100 {root}'
    require([s.rstrip() for s in re.findall(r"^#replay_raw .+$", source.read_text(encoding="utf-8"), re.M)]
            == [wanted], f"{label}: root/prefix/size mismatch")
    require(r["limits_lines"] == [LIMITS], "limits mismatch")
    require(len(r["rows"]) == 1, "replay row count")
    row = r["rows"][0]
    require(row["variant"] == variant and type(row["width"]) is int and row["width"] == 1024
            and type(row["repetitions"]) is int and row["repetitions"] == 100, "replay contract")
    require(type(row["declarations"]) is int and row["declarations"] > 0, "declaration count")
    for k in ["proof_pool_generation_ns", "kernel_elapsed_ns"]:
        require(type(row[k]) is int and row[k] >= 0, f"invalid {k}")
    cpu = number(row["kernel_process_cpu_seconds"], "phase CPU", True)
    elapsed = number(row["kernel_elapsed_ns"] / 1e9, "loop elapsed", True)
    require(r["phase_cpu_seconds"] == {variant: cpu}, "CPU phase binding")
    require(r["cpu_seconds"] >= cpu and r["wall_seconds"] >= elapsed, "phase exceeds process")
    log = (HERE / (label + ".log")).read_text(encoding="utf-8").splitlines()
    cover = f'COVER,{variant},1024,100,{row["declarations"]},{row["proof_pool_generation_ns"]},{row["kernel_elapsed_ns"]}'
    require(log == [LIMITS, cover], "unexpected replay log/markers")
    before, after = snapshot(r["local_snapshot_before"]), snapshot(r["local_snapshot_after"])
    require(before == after == expected_snapshot(source), "local dependency/source/object snapshot mismatch")
    directory = HERE / (label + "_handshake")
    require(Path(r["handshake_directory"]).resolve() == directory.resolve(), "handshake directory")
    names = sorted(f"{stage}.{variant}.{suffix}" for stage in ["START", "STOP"] for suffix in ["request", "ack"])
    require(sorted(p.name for p in directory.iterdir()) == r["handshake_files"] == names, "handshake inventory")
    require(r["handled_requests"] == sorted(n for n in names if n.endswith(".request")), "handled requests")
    for n in names:
        require((directory / n).read_text(encoding="utf-8") == ("ready\n" if n.endswith(".request") else "go\n"), "marker contents")
    return {"label": label, "variant": variant, "width_updates": 1024, "retained_pairs": 1032,
            "repetitions": 100, "declarations": row["declarations"],
            "phase_cpu_seconds": cpu, "phase_cpu_seconds_per_block": cpu / 100,
            "phase_cpu_seconds_per_update": cpu / 102400,
            "loop_elapsed_seconds": elapsed, "loop_elapsed_seconds_per_block": row["kernel_elapsed_ns"] / 1e11,
            "loop_elapsed_seconds_per_update": row["kernel_elapsed_ns"] / (1e9 * 102400),
            "whole_process_cpu_seconds": r["cpu_seconds"], "whole_process_wall_seconds": r["wall_seconds"],
            "pool_renaming_seconds_once": row["proof_pool_generation_ns"] / 1e9,
            "observed_peak_private_bytes": number(r["observed_peak_private_bytes"], "private bytes"),
            "peak_working_set_bytes": number(r["peak_working_set_bytes"], "working bytes"),
            "snapshot": before, "command": r["command"], "protocol": r["protocol"],
            "receipt": evidence(HERE / (label + ".json")), "log": evidence(HERE / (label + ".log")),
            "wrapper": evidence(source), "markers": [evidence(directory / n) for n in names]}


def main():
    require(not OUTPUT.exists(), "immutable output already exists")
    for name, digest in PINS.items():
        require(sha(HERE / name) == digest, f"pinned source changed: {name}")
    require(sha(HERE / "state_fixture.json") == FIXTURE, "fixture changed")
    fixture = json.loads((HERE / "state_fixture.json").read_text(encoding="utf-8"))
    require(fixture["base_order"] == BASES and fixture["counts"]["state_pairs"] == 1032
            and fixture["counts"]["complex_state_updates"] == 1024, "fixture shape")
    audit = build("statecomparisonaudit01", "AuditRawStateComparison.lean")
    text = (HERE / "statecomparisonaudit01.log").read_text(encoding="utf-8")
    require(text.splitlines().count(MARKER) == 1, "missing/duplicate compiled exact-type marker")
    ax = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]", text)
    wanted = {"RawStateExplicit.full_output_checked", "RawStateComputedPacked.full_output_checked",
              "RawHead.inverseRootCandidate_eq_of_square_bounds", "RawHead.traceCertificate_actual_error"}
    require(len(ax) == 4 and {a for a, _ in ax} == wanted, "audit axiom inventory")
    for name, entries in ax:
        require(set(x.strip() for x in entries.split(",")) == {"propext", "Classical.choice", "Quot.sound"},
                f"nonstandard/mismatched axioms: {name}")
    construction = {}
    for group, jobs in CONSTRUCTION.items():
        runs = [build(label, name) for label, name in jobs]
        construction[group] = {"runs": runs, "successful_process_cpu_sum": sum(r["cpu_seconds"] for r in runs),
            "successful_process_wall_sum": sum(r["wall_seconds"] for r in runs),
            "variant_source_bytes": sum(r["source"]["bytes"] for r in runs),
            "variant_object_bytes": sum(r["object"]["bytes"] for r in runs)}
    shared = [build(label, name) for label, name in SHARED]
    controls = build("statecontrols01", "RawStateControls.lean")
    groups, union, commons = {}, {}, []
    for group in GROUPS:
        runs = [replay(group, i) for i in [1, 2, 3]]
        for r in runs[1:]:
            for k in ["snapshot", "command", "protocol", "declarations", "repetitions"]:
                require(r[k] == runs[0][k], f"{group}: inconsistent {k}")
        for r in runs:
            commons.append(set(r["snapshot"]))
            for path, digest in r["snapshot"].items():
                require(path not in union or union[path] == digest, "cross-group shared pin mismatch")
                union[path] = digest
        metrics = [k for k in runs[0] if k.endswith("seconds_per_block") or k.endswith("seconds_per_update")]
        metrics += ["whole_process_cpu_seconds", "whole_process_wall_seconds", "pool_renaming_seconds_once",
                    "observed_peak_private_bytes", "peak_working_set_bytes"]
        groups[group] = {"runs": runs, "summary": {k: {"min": min(r[k] for r in runs),
            "median": statistics.median(r[k] for r in runs), "max": max(r[k] for r in runs)} for k in metrics}}
    generic = []
    for group in GROUPS:
        snap = groups[group]["runs"][0]["snapshot"]
        generic.append({p: h for p, h in snap.items() if not Path(p).name.startswith(
            ("RawStateExplicit", "RawStateComputed", "ReplayRawStateExplicit", "ReplayRawStateComputed"))})
    require(generic[0] == generic[1], "different generic/data/setup dependency sets")
    for name in ["RawStateSources", "RawStateFixtureData", "RawLogCases", "RawTraceCertificate", "RawReplay"]:
        for suffix in [".lean", ".olean"]:
            require(str((HERE / (name + suffix)).resolve()) in generic[0], f"missing shared {name}{suffix}")
    for group in GROUPS:
        snap = groups[group]["runs"][0]["snapshot"]
        for b in construction[group]["runs"]:
            for k in ["source", "object"]:
                require(snap.get(b[k]["path"]) == b[k]["sha256"], "construction/replay provenance mismatch")
    common = set.intersection(*commons)
    ratios = {}
    for k in ["phase_cpu_seconds_per_block", "loop_elapsed_seconds_per_block"]:
        a, b = (groups[g]["summary"][k]["median"] for g in ["explicit", "computed"])
        ratios[k] = {"explicit_median": a, "computed_median": b, "explicit_divided_by_computed": a / b}
    failed = read("stateexplicit01")
    require(failed["exit_code"] != 0 and failed["stop"] is not None, "historical monolith no longer failed")
    require(sha(HERE / "stateexplicit01.log") == failed["log_sha256"], "failed attempt log changed")
    require(not (HERE / "stateexplicit2_01.json").exists()
            and (HERE / "stateexplicit2_01.log").read_bytes() == b"", "interrupted attempt evidence changed")
    result = {"status": "VALIDATED_SIX_STATE_REPLAY_RUNS", "groups": groups, "matched_replay_median_ratios": ratios,
        "compiled_comparison_audit": audit, "controls_build": controls,
        "successful_incremental_construction": construction, "selected_shared_setup_receipts": shared,
        "shared_setup_scope": "Selected data/source/log builds only, not complete generic-library development; not added to replay phases.",
        "common_dependency_pins": {p: union[p] for p in sorted(common)}, "all_dependency_pins": union,
        "unique_dependency_bytes": sum(Path(p).stat().st_size for p in union),
        "fixture": evidence(HERE / "state_fixture.json"), "reporter": evidence(Path(__file__)),
        "proposal_generation_observation": fixture.get("native_proposal_timing"),
        "generation_scope": "Fixture's declared native proposal boundary only. Lean certificate/source emitters and full library development are not measured by this field.",
        "excluded_engineering_evidence": {"failed_monolith_receipt": evidence(HERE / "stateexplicit01.json"),
            "failed_monolith_log": evidence(HERE / "stateexplicit01.log"),
            "recorded_cpu_seconds": failed["cpu_seconds"], "recorded_wall_seconds": failed["wall_seconds"],
            "included_in_successful_construction": False,
            "interrupted_base2_log": evidence(HERE / "stateexplicit2_01.log"),
            "interrupted_scope": "No JSON receipt; no invented timing. Replacement is stateexplicit2_02."},
        "interpretation": [
            "Matched complete eight-base,129-state output and analytic enclosure contract; 1024 updates,1032 retained pairs.",
            "Three fresh processes per variant;100 repeated checks of the same fixture within each process, not100 fresh payloads.",
            "Phase CPU includes synchronized child handshake overhead; inner-loop elapsed excludes handshake boundaries.",
            "Renamed concrete proof closure is rechecked; shared generic theory, source facts and literal data definitions remain imported.",
            "Imports, first admission and warmup are outside replay phase but inside process totals; process totals are not construction times.",
            "Replay wrappers disclose unlimited heartbeats and recursion65536 at trust0; source-construction receipts retain their own options.",
            "Successful construction sums count separate process startup/imports at each module; split versus packed layouts differ. Not isolated kernel costs.",
            "Pool preparation renames existing elaborated proofs; it is not candidate generation or elaboration.",
            "Output source/object bytes are unique per construction module; dependency bytes include both source and objects, not transport or peak memory.",
            "No summation of construction and optional replay as a mandatory acceptance bill; no full TG savings or extrapolation.",
        ]}
    encoded = (json.dumps(result, indent=2, sort_keys=True) + "\n").encode("utf-8")
    with OUTPUT.open("xb") as f:
        f.write(encoded)
    print(json.dumps({"status": "PUBLISHED", "output": str(OUTPUT), "bytes": len(encoded), "sha256": sha(OUTPUT)}))


if __name__ == "__main__":
    try:
        main()
    except Exception as error:
        print(json.dumps({"status": "PENDING", "reason": str(error), "output_exists": OUTPUT.exists(), "builds_launched": False}))
        sys.exit(2)
