#!/usr/bin/env python3
"""Pinned, local-only HOL dependency staging. No command runs on import.

preflight stages sources and runs ONLY Holmake --json.
build-dependencies and build-helper are separate, explicit root actions.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import sys
import time

INPUT_SHA = "d02012728214e9a4a069dabcc65f45d2cf8bd91bf5347282d8930c42eea6ad86"
OWNER = Path(__file__).resolve().parent
SETUP = OWNER.parents[1] / "hol4-setup"
MAX_GRAPH_BYTES = 16 * 1024 * 1024
MAX_LOG_BYTES = 64 * 1024 * 1024
MAX_STAGE_BYTES = 2 * 1024**3
MAX_STAGE_FILES = 10000
TOTAL_SECONDS = 10800
FLAGS = ["--no_prereqs", "--no-project", "--no_preexecs", "--no-cache", "-j1"]
THEORIES = [
    "hrat", "hreal", "realax", "real_arith", "real", "intreal",
    "RealFieldContext", "res_quan", "topology", "real_sigma", "metric", "nets",
    "real_topology", "derivative", "seq", "lim", "powser", "transc", "complex",
]
LIBRARIES = {
    "hol88Lib", "Cond_rewrite", "res_quanLib", "res_quanTools", "realPP",
    "realSyntax", "RealArith0", "RealArith", "realSimps", "RealField",
    "isqrtLib", "realLib", "complexPP", "Diff",
}


def require(test, message):
    if not test:
        raise RuntimeError(message)


def sha(path):
    digest = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def read_json(path, cap=MAX_GRAPH_BYTES):
    require(path.stat().st_size <= cap, "JSON size cap: " + str(path))
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path, obj):
    with path.open("x", encoding="utf-8") as stream:
        json.dump(obj, stream, indent=2, sort_keys=True)
        stream.write("\n")


def configuration():
    require(os.name == "posix", "Run only in the installed Linux HOL environment")
    source = OWNER / "dependency_inputs.json"
    require(sha(source) == INPUT_SHA, "Pinned input manifest changed")
    data = read_json(source)
    require(data["schema"] == 1 and len(data["sources"]) == 45, "Input schema")
    require(sum(r["bytes"] for r in data["sources"]) == 2756114, "Source byte sum")
    require(len({Path(r["path"]).name for r in data["sources"]}) == 45,
            "Flattened source collision")
    return data, SETUP / data["hol_directory"]


def verify_record(root, record):
    path = root / record["path"]
    require(path.is_file(), "Missing pinned input: " + str(path))
    require(path.stat().st_size == record["bytes"], "Input size changed: " + str(path))
    require(sha(path) == record["sha256"], "Input hash changed: " + str(path))


def verify_originals(data, hol):
    for record in data["sources"]:
        verify_record(hol, record)
    for record in data["boundary"]:
        verify_record(SETUP, record)
    verify_record(OWNER, data["helper"])


def stage_path(label):
    require(re.fullmatch(r"dependency-build-[A-Za-z0-9_-]+", label) is not None,
            "Stage name must begin dependency-build- and contain no path separators")
    path = OWNER / label
    require(not path.is_symlink(), "Stage cannot be a symlink")
    require(path.resolve().parent == OWNER, "Stage outside owner")
    return path


def limits():
    import resource
    resource.setrlimit(resource.RLIMIT_AS, (4 * 1024**3, 4 * 1024**3))
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))


def stage_usage(stage):
    count = size = 0
    for root, dirs, files in os.walk(stage, followlinks=False):
        for name in dirs + files:
            path = Path(root) / name
            require(not path.is_symlink(), "Unexpected stage symlink: " + str(path))
        for name in files:
            count += 1
            require(count <= MAX_STAGE_FILES, "Stage file count cap")
            path = Path(root) / name
            n = path.stat().st_size
            size += n
            if path.parent == stage / "logs":
                require(n <= MAX_LOG_BYTES, "Log cap: " + str(path))
        require(size <= MAX_STAGE_BYTES, "Stage storage cap")
    return {"files": count, "bytes": size}


def command(stage, hol, label, extra, seconds):
    require(seconds > 0, "Total wall budget exhausted")
    out = stage / "logs" / (label + ".out")
    err = stage / "logs" / (label + ".err")
    receipt = stage / "logs" / (label + ".json")
    args = [str(SETUP / "run.sh"), str(hol / "bin/Holmake")] + FLAGS + extra
    env = dict(os.environ)
    env.pop("HOLBUILD", None)
    started = time.monotonic()
    child = None
    problem = None
    returncode = None
    with out.open("xb") as stdout, err.open("xb") as stderr:
        try:
            child = subprocess.Popen(args, cwd=stage, env=env, stdout=stdout,
                                     stderr=stderr, start_new_session=True,
                                     preexec_fn=limits)
            while child.poll() is None:
                require(time.monotonic() - started < seconds, "Wall-time cap")
                stage_usage(stage)
                time.sleep(0.5)
            returncode = child.returncode
            require(returncode == 0, "Holmake failed with exit " + str(returncode))
            stage_usage(stage)
        except BaseException as exc:
            problem = str(exc)
            if child is not None and child.poll() is None:
                os.killpg(child.pid, signal.SIGTERM)
                try:
                    child.wait(timeout=3)
                except subprocess.TimeoutExpired:
                    os.killpg(child.pid, signal.SIGKILL)
                    child.wait()
                returncode = child.returncode
        finally:
            elapsed = time.monotonic() - started
            write_json(receipt, {"argv": args, "cwd": str(stage), "wall_seconds": elapsed,
                                "returncode": returncode, "error": problem,
                                "address_space_bytes_per_process": 4 * 1024**3,
                                "one_job": True})
    require(problem is None, problem or "unknown execution failure")
    return out, elapsed


def resolved_dir(text, stage):
    path = Path(text)
    return (path if path.is_absolute() else stage / path).resolve()


def validate_graph(path, stage, data):
    graph = read_json(path)
    require(isinstance(graph, list) and 0 < len(graph) <= 10000, "Graph node cap/schema")
    expected = set(THEORIES) | {"RawPairRound"}
    stems = LIBRARIES | {n + "Script" for n in expected} | {n + "Theory" for n in expected}
    seen = set()
    prospective = []
    for node in graph:
        for field in ("node_id", "target", "seqnum", "phony", "dependencies",
                      "command", "dir", "mtime", "needs_rebuild"):
            require(field in node, "Missing graph field " + field)
        require(type(node["node_id"]) is int and node["node_id"] not in seen,
                "Duplicate/noninteger graph node")
        seen.add(node["node_id"])
        require(type(node["phony"]) is bool and not node["phony"], "Phony action forbidden")
        require(type(node["needs_rebuild"]) is bool, "Rebuild flag must be bool")
        require(isinstance(node["target"], str) and isinstance(node["dir"], str)
                and isinstance(node["command"], str), "Graph strings")
        target = Path(node["target"])
        require(target.is_absolute(), "Expected absolute target from hm_target.toString")
        target = target.resolve()
        directory = resolved_dir(node["dir"], stage)
        cmd = node["command"]
        if cmd:
            # Check even currently fresh command nodes, not merely pending ones.
            require(directory == stage and target.parent in (stage, stage / ".hol/objs"),
                    "Prospective compilation outside stage: " + str(target))
            require(target.stem in stems, "Unexpected local output module: " + str(target))
            require(target.suffix in {".sml", ".sig", ".uo", ".ui", ".dat"},
                    "Unexpected local output suffix: " + str(target))
            if cmd.startswith("BIC_Build "):
                script = cmd[len("BIC_Build "):]
                script_path = Path(script)
                if script_path.is_absolute() or len(script_path.parts) > 1:
                    require(resolved_dir(script, stage).parent == stage,
                            "Script path outside stage: " + script)
                require(script_path.name in expected or
                        script_path.name in {n + "Script" for n in expected},
                        "Unexpected script command: " + cmd)
            else:
                require(cmd == "BIC_Compile", "Custom shell command forbidden: " + cmd)
            if node["needs_rebuild"]:
                prospective.append({"target": str(target), "command": cmd})
        elif node["needs_rebuild"]:
            require(target.parent in (stage, stage / ".hol/objs") and target.stem in stems,
                    "Unresolved external prerequisite: " + str(target))
        require(isinstance(node["dependencies"], list)
                and all(type(i) is int for i in node["dependencies"]), "Graph edges")
    for node in graph:
        require(all(i in seen for i in node["dependencies"]), "Dangling graph edge")
    return {"graph_sha256": sha(path), "nodes": len(graph),
            "prospective_compilations": prospective, "local_only": True}


def verify_stage(stage, data, hol):
    require(stage.is_dir(), "Missing staged preflight")
    binding = read_json(stage / "stage_binding.json")
    require(binding["input_sha256"] == INPUT_SHA, "Stage input binding")
    require(binding["runner_sha256"] == sha(Path(__file__)), "Runner changed after staging")
    require(binding["stage"] == str(stage), "Stage identity changed")
    require(sha(stage / "Holmakefile") == binding["holmakefile_sha256"], "Local Holmakefile changed")
    for record in data["sources"] + [data["helper"]]:
        verify_record(stage, dict(record, path=Path(record["path"]).name))
    verify_originals(data, hol)
    return binding


def graph_preflight(stage, hol, data, label, targets, seconds):
    graph, elapsed = command(stage, hol, label, ["--json"] + targets, min(180, seconds))
    result = validate_graph(graph, stage, data)
    write_json(stage / "logs" / (label + ".validated.json"), result)
    verify_originals(data, hol)
    return elapsed


def preflight(stage, data, hol):
    require(not stage.exists(), "Refusing existing stage; preserve old attempt")
    verify_originals(data, hol)
    stage.mkdir()
    (stage / "logs").mkdir()
    for record in data["sources"]:
        with (stage / Path(record["path"]).name).open("xb") as output:
            output.write((hol / record["path"]).read_bytes())
    with (stage / data["helper"]["path"]).open("xb") as output:
        output.write((OWNER / data["helper"]["path"]).read_bytes())
    with (stage / "Holmakefile").open("x", encoding="utf-8") as output:
        output.write("INCLUDES = " + str(hol / "src/integer") + " " +
                     str(hol / "src/res_quan/src") + " " + str(SETUP) +
                     "\nall: RawPairRoundTheory.uo\n")
    write_json(stage / "stage_binding.json", {
        "stage": str(stage), "input_sha256": INPUT_SHA,
        "runner_sha256": sha(Path(__file__)), "source_count": 45,
        "source_bytes": 2756114, "holmakefile_sha256": sha(stage / "Holmakefile")})
    verify_stage(stage, data, hol)
    elapsed = graph_preflight(stage, hol, data, "preflight_graph",
                              ["RawPairRoundTheory.uo"], 180)
    write_json(stage / "PREFLIGHT_PASSED.json", {
        "only_graph_was_run": True, "wall_seconds": elapsed,
        "stage": str(stage), "input_sha256": INPUT_SHA,
        "usage": stage_usage(stage)})
    print("PREFLIGHT_PASSED; NO HOL THEORY BUILD EXECUTED", stage)


def object_path(stage, name):
    for p in (stage / ".hol/objs" / name, stage / name):
        if p.is_file():
            return p
    raise RuntimeError("Expected local object absent: " + name)


def build(stage, data, hol, helper_only):
    verify_stage(stage, data, hol)
    gate = read_json(stage / "PREFLIGHT_PASSED.json")
    require(gate["input_sha256"] == INPUT_SHA and gate["only_graph_was_run"], "Preflight gate")
    label = "helper" if helper_only else "dependencies"
    write_json(stage / (label + "_STARTED.json"), {"explicit_command": label,
               "started_unix": time.time(), "no_automatic_retry": True})
    used = gate["wall_seconds"]
    if helper_only:
        old = read_json(stage / "DEPENDENCIES_PASSED.json")
        used = old["wall_seconds_total"]
        for item in old["objects"]:
            require(sha(Path(item["path"])) == item["sha256"], "Dependency output changed")
        targets = ["RawPairRoundTheory.uo"]
    else:
        targets = [n + "Theory.uo" for n in THEORIES]
        targets += ["realLib.uo", "RealField.uo"]
    started = time.monotonic()
    for i, target in enumerate(targets):
        verify_stage(stage, data, hol)
        remaining = TOTAL_SECONDS - used - (time.monotonic() - started)
        tag = label + "_%02d_" % i + target[:-3]
        graph_preflight(stage, hol, data, tag + "_graph", [target], remaining)
        remaining = TOTAL_SECONDS - used - (time.monotonic() - started)
        cap = 3600 if target == "real_topologyTheory.uo" else 1800
        command(stage, hol, tag + "_build", [target], min(cap, remaining))
        verify_stage(stage, data, hol)
        object_path(stage, target)
    products = []
    for target in targets:
        p = object_path(stage, target)
        products.append({"path": str(p), "sha256": sha(p), "bytes": p.stat().st_size})
        if target.endswith("Theory.uo"):
            p = object_path(stage, target[:-3] + ".dat")
            products.append({"path": str(p), "sha256": sha(p), "bytes": p.stat().st_size})
    final = "HELPER_PASSED.json" if helper_only else "DEPENDENCIES_PASSED.json"
    write_json(stage / final, {"objects": products, "input_sha256": INPUT_SHA,
               "wall_seconds_total": used + time.monotonic() - started,
               "usage": stage_usage(stage), "exact_type_audit_still_required": helper_only})
    print(final, stage)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("action", choices=["preflight", "build-dependencies", "build-helper"])
    parser.add_argument("--stage", default="dependency-build-01")
    args = parser.parse_args()
    data, hol = configuration()
    stage = stage_path(args.stage)
    try:
        if args.action == "preflight":
            preflight(stage, data, hol)
        else:
            build(stage, data, hol, args.action == "build-helper")
    except BaseException as exc:
        print("FAILED_CLOSED:", type(exc).__name__, str(exc), file=sys.stderr)
        print("Preserve partial stage:", stage, file=sys.stderr)
        raise


if __name__ == "__main__":
    main()
