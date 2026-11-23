#!/usr/bin/env python3
"""Read-preserving graph-only recovery for the interrupted win01 stage."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import time

OWNER = Path(__file__).resolve().parent
ADAPTER_SHA = "d9a02ad7a656d390082e5207c8eac19d70e12c3f241fe51c972f521a4db67461"
SNAPSHOT_SHA = "59027e210e968ee8d8ca5825fde2ddae5e63aeb246acf38d2b45829987f861fe"
HOLMAKE_SOURCE_SHA = "77e43540bf2e3f06661c9e3c4bffd50eb55dd44ec67b61b6471fa0a00b675923"
OLD_GRAPH_SHA = "5b9112def37299d82f8bf35f8808c7a03728fede4fcc5fe76f29bd46f161f747"
OLD_RESULT_SHA = "764f4c1474f73b61ba2bd900c146b6bb9c4b74f5ae68c286100e3ee9b1eecc02"
# NO POSITIONAL TARGET: this reaches work()'s [] branch and dispatch_built_graph.
# The explicit-target branch in this installed source ignores show_json.
SHELL = r'''set -eu
cd "$1"
ulimit -v 4194304
ulimit -c 0
unset HOLBUILD
exec "$2" timeout -k 5 180 "$3" --no_prereqs --no-project --no_preexecs --no-cache -j1 --json
'''


def load_adapter():
    import hashlib
    path = OWNER / "preflight_windows.py"
    if hashlib.sha256(path.read_bytes()).hexdigest() != ADAPTER_SHA:
        raise RuntimeError("Original adapter changed")
    sys.dont_write_bytecode = True
    spec = importlib.util.spec_from_file_location("original_windows_preflight", path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def check_aggregate_and_graph(old, base, graph_path, stage_linux):
    graph = base.read_json(graph_path)
    old.require(isinstance(graph, list) and 0 < len(graph) <= 10000, "Graph list/cap")
    old.require(all(isinstance(n, dict) and type(n.get("node_id")) is int
                    for n in graph), "Full graph node/id schema")
    old.require(len({n["node_id"] for n in graph}) == len(graph),
                "Duplicate full graph node id")
    aggregate = [n for n in graph if isinstance(n, dict) and
                 n.get("target") == stage_linux + "/all"]
    old.require(len(aggregate) <= 1, "Multiple all aggregates")
    if not aggregate:
        return old.graph_check(base, graph_path, stage_linux)
    node = aggregate[0]
    old.require(node.get("command") == "", "all aggregate has a command")
    old.require(old.linux_resolve(node.get("dir"), stage_linux) == stage_linux,
                "all aggregate is not local")
    old.require(type(node.get("node_id")) is int and type(node.get("phony")) is bool
                and type(node.get("needs_rebuild")) is bool, "Invalid all aggregate schema")
    edges = node.get("dependencies")
    old.require(isinstance(edges, list) and len(edges) == 1 and type(edges[0]) is int,
                "all must depend only on the helper's object")
    objects = [n for n in graph if isinstance(n, dict) and n.get("node_id") == edges[0]]
    old.require(len(objects) == 1 and objects[0].get("target") in
                (stage_linux + "/RawPairRoundTheory.uo",
                 stage_linux + "/.hol/objs/RawPairRoundTheory.uo"),
                "all dependency is not the exact helper object")
    rest = [n for n in graph if n is not node]
    old.require(all(isinstance(n, dict) and node["node_id"] not in n.get("dependencies", [])
                    for n in rest), "Another node depends on the all aggregate")
    # Validate a recorded graph decomposition with the unchanged strict checker.
    # Only the already-checked, empty-command root aggregate is omitted.
    component_path = graph_path.parent / "recovery01_graph_components.json"
    base.write_json(component_path, rest)
    result = old.graph_check(base, component_path, stage_linux)
    result.update({"full_graph_sha256": old.digest(graph_path),
                   "full_node_count": len(graph),
                   "checked_empty_command_all_aggregate": node})
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--confirmed-no-survivors", action="store_true")
    args = parser.parse_args()
    old = load_adapter()
    old.require(args.confirmed_no_survivors, "Root must confirm no previous Linux build survives")
    old.require(os.name == "nt" and Path(sys.executable).resolve() == old.PYTHON.resolve(),
                "Use the specified Windows Python")
    base = old.load_base()
    old.require(old.digest(OWNER / "dependency_inputs.json") == old.INPUT_SHA, "Input manifest")
    snapshot_file = OWNER / "PREFLIGHT_FAILURE_READONLY_SNAPSHOT.json"
    old.require(old.digest(snapshot_file) == SNAPSHOT_SHA, "Failure snapshot changed")
    snapshot = base.read_json(snapshot_file)
    data = base.read_json(OWNER / "dependency_inputs.json")
    setup = OWNER.parents[1] / "hol4-setup"
    hol = setup / data["hol_directory"]
    stage = OWNER / "dependency-build-win01"
    stage_linux = old.linux_path(stage)
    old.require(stage.is_dir() and not stage.is_symlink(), "Expected original owned stage")
    old.require(old.digest(hol / "tools/Holmake/core/Holmake.sml") == HOLMAKE_SOURCE_SHA,
                "Reviewed dispatch source changed")
    old.require(old.digest(stage / "logs/graph.out") == OLD_GRAPH_SHA, "Failed attempt log changed")
    old.require(old.digest(stage / "logs/graph_result.json") == OLD_RESULT_SHA, "Failed attempt receipt changed")
    base.verify_originals(data, hol)
    binding = base.read_json(stage / "windows_stage_binding.json")
    old.require(binding["adapter_sha256"] == ADAPTER_SHA and
                binding["input_sha256"] == old.INPUT_SHA and
                binding["linux_stage"] == stage_linux and
                binding["holmakefile_sha256"] == old.digest(stage / "Holmakefile"),
                "Original stage binding mismatch")
    expected_hmf = ("INCLUDES = " + old.linux_path(hol) + "/src/integer " +
                    old.linux_path(hol) + "/src/res_quan/src " + old.linux_path(setup) +
                    "\nall: RawPairRoundTheory.uo\n")
    old.require((stage / "Holmakefile").read_text(encoding="utf-8") == expected_hmf,
                "Unexpected default target or Holmakefile content")
    for record in data["sources"] + [data["helper"]]:
        base.verify_record(stage, dict(record, path=Path(record["path"]).name))
    # Verify all recorded files before running. Afterwards protect every existing
    # file except rebuildable .hol/make-deps metadata, which graph construction
    # may legitimately refresh. Existing logs, bindings, sources and objects stay exact.
    protected = []
    for record in snapshot["stage_files"]:
        path = stage / record["path"]
        old.require(path.stat().st_size == record["bytes"] and
                    old.digest(path).upper() == record["sha256"].upper(),
                    "Recorded partial artifact changed: " + str(path))
        if not record["path"].startswith(".hol/make-deps/"):
            protected.append(record)
    base.write_json(stage / "logs/recovery01_STARTED.json", {
        "prior_attempt_was_actual_build": True, "prior_failure_snapshot_sha256": SNAPSHOT_SHA,
        "corrected_runner_sha256": old.digest(Path(__file__)),
        "input_sha256": old.INPUT_SHA, "holmake_dispatch_source_sha256": HOLMAKE_SOURCE_SHA,
        "root_confirmed_no_survivors": True, "no_retry": True})
    wsl = Path(os.environ["WINDIR"]) / "System32/wsl.exe"
    argv = [str(wsl), "-d", old.DISTRIBUTION, "--exec", "sh", "-c", SHELL,
            "raw-analytic-recovery", stage_linux, old.linux_path(setup / "run.sh"),
            old.linux_path(hol / "bin/Holmake")]
    base.write_json(stage / "logs/recovery01_command.json", {"argv": argv,
                    "has_positional_holmake_target": False, "intended_action": "graph-only"})
    start = time.monotonic()
    child = None
    error = None
    rc = None
    try:
        with (stage / "logs/recovery01_graph.out").open("xb") as out, (stage / "logs/recovery01_graph.err").open("xb") as err:
            child = subprocess.Popen(argv, cwd=OWNER, stdout=out, stderr=err)
            while child.poll() is None:
                old.require(time.monotonic() - start < 240, "Windows wrapper timeout")
                base.stage_usage(stage)
                time.sleep(0.5)
            rc = child.returncode
            old.require(rc == 0, "WSL graph exit " + str(rc))
            base.stage_usage(stage)
    except BaseException as exc:
        error = str(exc)
        if child is not None and child.poll() is None:
            child.terminate()
            try:
                child.wait(timeout=5)
            except subprocess.TimeoutExpired:
                child.kill()
                child.wait()
            rc = child.returncode
    finally:
        base.write_json(stage / "logs/recovery01_result.json", {
            "wall_seconds": time.monotonic() - start, "returncode": rc, "error": error,
            "linux_timeout_authoritative": True,
            "windows_termination_does_not_certify_linux_group_exit": True})
    old.require(error is None, error or "Graph command failed")
    result = check_aggregate_and_graph(old, base, stage / "logs/recovery01_graph.out", stage_linux)
    base.write_json(stage / "logs/recovery01_validated.json", result)
    base.verify_originals(data, hol)
    for record in protected:
        path = stage / record["path"]
        old.require(old.digest(path).upper() == record["sha256"].upper(),
                    "Preexisting protected artifact changed: " + str(path))
    recorded_objects = {r["path"] for r in snapshot["stage_files"]
                        if r["path"].startswith(".hol/objs/")}
    current_objects = {p.relative_to(stage).as_posix()
                       for p in (stage / ".hol/objs").rglob("*") if p.is_file()}
    old.require(current_objects == recorded_objects,
                "Object inventory changed during graph-only recovery")
    base.write_json(stage / "RECOVERY01_PREFLIGHT_PASSED.json", {
        "prior_attempt_was_actual_build": True, "prior_failure_snapshot_sha256": SNAPSHOT_SHA,
        "corrected_runner_sha256": old.digest(Path(__file__)), "input_sha256": old.INPUT_SHA,
        "graph_sha256": old.digest(stage / "logs/recovery01_graph.out"),
        "protected_existing_artifact_count": len(protected),
        "graph_only_recovery": True, "no_actual_build_authorized_by_this_gate": True})
    print("RECOVERY01_PREFLIGHT_PASSED; prior partial build preserved; no new theory build")


if __name__ == "__main__":
    try:
        main()
    except BaseException as exc:
        print("RECOVERY_FAILED_CLOSED:", type(exc).__name__, str(exc), file=sys.stderr)
        raise
