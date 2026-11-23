#!/usr/bin/env python3
"""Windows-only staging and WSL graph validation. Never builds a HOL theory."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path, PurePosixPath
import posixpath
import re
import subprocess
import sys
import time

OWNER = Path(__file__).resolve().parent
BASE_SHA = "52cd80d1b83b464d2da28302799680a3668c256972c75b6022e279fb1aaf6e3e"
INPUT_SHA = "d02012728214e9a4a069dabcc65f45d2cf8bd91bf5347282d8930c42eea6ad86"
PYTHON = Path("C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe")
DISTRIBUTION = "docker-desktop"
# Every variable path is a distinct positional argument. No path is interpolated
# into this shell program. timeout limits the actual Linux Holmake process.
SHELL = r'''set -eu
cd "$1"
ulimit -v 4194304
ulimit -c 0
unset HOLBUILD
exec "$2" timeout -k 5 180 "$3" --no_prereqs --no-project --no_preexecs --no-cache -j1 --json RawPairRoundTheory.uo
'''


def require(value, message):
    if not value:
        raise RuntimeError(message)


def digest(path):
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for part in iter(lambda: stream.read(1024 * 1024), b""):
            h.update(part)
    return h.hexdigest()


def load_base():
    sys.dont_write_bytecode = True
    path = OWNER / "isolated_dependencies.py"
    require(digest(path) == BASE_SHA, "Unrun original runner changed")
    spec = importlib.util.spec_from_file_location("pinned_dependency_helpers", path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    # The preserved module has only definitions/constants outside its main guard.
    # Its Linux-only configuration, execution and main functions are never called.
    return module


def linux_path(path):
    path = path.resolve()
    require(path.drive.lower() == "c:", "Only the explicit C: mount is supported")
    require(not any(c in str(path) for c in "\r\n\x00"), "Invalid path character")
    return "/mnt/host/c/" + "/".join(path.parts[1:])


def linux_resolve(text, cwd):
    require(isinstance(text, str) and not any(c in text for c in "\r\n\x00"),
            "Invalid graph path")
    return posixpath.normpath(text if text.startswith("/") else posixpath.join(cwd, text))


def graph_check(base, graph_file, stage_linux):
    nodes = base.read_json(graph_file)
    require(isinstance(nodes, list) and 0 < len(nodes) <= 10000, "Graph list/node cap")
    theories = set(base.THEORIES) | {"RawPairRound"}
    stems = base.LIBRARIES | {n + "Script" for n in theories} | {n + "Theory" for n in theories}
    ids = set()
    planned = []
    for node in nodes:
        require(isinstance(node, dict), "Non-object graph node")
        fields = {"node_id", "target", "seqnum", "phony", "dependencies", "command",
                  "dir", "mtime", "needs_rebuild"}
        require(fields <= node.keys(), "Missing graph field")
        require(type(node["node_id"]) is int and node["node_id"] not in ids,
                "Duplicate/noninteger node id")
        ids.add(node["node_id"])
        require(type(node["phony"]) is bool and not node["phony"], "Phony command forbidden")
        require(type(node["needs_rebuild"]) is bool, "Invalid rebuild flag")
        require(isinstance(node["target"], str) and node["target"].startswith("/"),
                "Expected absolute Linux graph target")
        target = PurePosixPath(linux_resolve(node["target"], stage_linux))
        directory = linux_resolve(node["dir"], stage_linux)
        command = node["command"]
        require(isinstance(command, str), "Invalid command field")
        if command:
            require(directory == stage_linux and str(target.parent) in
                    (stage_linux, stage_linux + "/.hol/objs"),
                    "Prospective compilation outside stage: " + str(target))
            require(target.stem in stems and target.suffix in
                    {".sml", ".sig", ".uo", ".ui", ".dat"},
                    "Unexpected generated module/output: " + str(target))
            if command.startswith("BIC_Build "):
                script = command[len("BIC_Build "):]
                p = PurePosixPath(script)
                if p.is_absolute() or len(p.parts) > 1:
                    require(posixpath.dirname(linux_resolve(script, stage_linux)) == stage_linux,
                            "Script source outside stage")
                require(p.name in theories or p.name in {n + "Script" for n in theories},
                        "Unknown BIC script: " + command)
            else:
                require(command == "BIC_Compile", "Custom command forbidden: " + command)
            if node["needs_rebuild"]:
                planned.append({"target": str(target), "command": command})
        elif node["needs_rebuild"]:
            require(str(target.parent) in (stage_linux, stage_linux + "/.hol/objs")
                    and target.stem in stems, "Unresolved external prerequisite: " + str(target))
        require(isinstance(node["dependencies"], list) and
                all(type(i) is int for i in node["dependencies"]), "Invalid edge list")
    for node in nodes:
        require(all(i in ids for i in node["dependencies"]), "Dangling graph edge")
    return {"graph_sha256": digest(graph_file), "nodes": len(nodes),
            "planned_compilations": planned, "all_prospective_compilations_local": True}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--stage", default="dependency-build-win01")
    args = parser.parse_args()
    require(os.name == "nt", "This adapter requires Windows Python")
    require(Path(sys.executable).resolve() == PYTHON.resolve(), "Use the explicitly installed Python")
    require(re.fullmatch(r"dependency-build-[A-Za-z0-9_-]+", args.stage) is not None,
            "Invalid stage basename")
    base = load_base()
    require(digest(OWNER / "dependency_inputs.json") == INPUT_SHA, "Input manifest changed")
    data = base.read_json(OWNER / "dependency_inputs.json")
    require(data["schema"] == 1 and len(data["sources"]) == 45 and
            sum(r["bytes"] for r in data["sources"]) == 2756114, "Source schema/count/bytes")
    require(len({Path(r["path"]).name for r in data["sources"]}) == 45, "Source collision")
    setup = OWNER.parents[1] / "hol4-setup"
    hol = setup / data["hol_directory"]
    base.verify_originals(data, hol)
    stage = OWNER / args.stage
    require(not stage.exists() and not stage.is_symlink(), "Refusing existing stage")
    require(stage.resolve().parent == OWNER, "Stage outside owner")
    wsl = Path(os.environ["WINDIR"]) / "System32/wsl.exe"
    require(wsl.is_file(), "Missing Windows WSL launcher")
    stage_linux = linux_path(stage)
    hol_linux = linux_path(hol)
    setup_linux = linux_path(setup)
    stage.mkdir()
    (stage / "logs").mkdir()
    try:
        for record in data["sources"]:
            with (stage / Path(record["path"]).name).open("xb") as output:
                output.write((hol / record["path"]).read_bytes())
        with (stage / data["helper"]["path"]).open("xb") as output:
            output.write((OWNER / data["helper"]["path"]).read_bytes())
        with (stage / "Holmakefile").open("x", encoding="utf-8", newline="\n") as output:
            output.write("INCLUDES = " + hol_linux + "/src/integer " + hol_linux +
                         "/src/res_quan/src " + setup_linux + "\nall: RawPairRoundTheory.uo\n")
        for record in data["sources"] + [data["helper"]]:
            base.verify_record(stage, dict(record, path=Path(record["path"]).name))
        base.write_json(stage / "windows_stage_binding.json", {
            "schema": 1, "windows_stage": str(stage), "linux_stage": stage_linux,
            "adapter_sha256": digest(Path(__file__)), "original_runner_sha256": BASE_SHA,
            "input_sha256": INPUT_SHA, "python_executable": str(Path(sys.executable)),
            "python_version": sys.version, "wsl_distribution": DISTRIBUTION,
            "holmakefile_sha256": digest(stage / "Holmakefile"), "source_count": 45})
        argv = [str(wsl), "-d", DISTRIBUTION, "--exec", "sh", "-c", SHELL,
                "raw-analytic-preflight", stage_linux, setup_linux + "/run.sh",
                hol_linux + "/bin/Holmake"]
        base.write_json(stage / "logs/graph_command.json", {
            "argv": argv, "shell_is_static": True, "build_requested": False,
            "linux_timeout_seconds": 180, "linux_kill_after_seconds": 5,
            "linux_address_space_bytes_per_process": 4 * 1024**3})
        start = time.monotonic()
        child = None
        error = None
        rc = None
        try:
            with (stage / "logs/graph.out").open("xb") as out, (stage / "logs/graph.err").open("xb") as err:
                child = subprocess.Popen(argv, cwd=OWNER, stdout=out, stderr=err)
                while child.poll() is None:
                    require(time.monotonic() - start < 240, "Windows WSL-wrapper wall cap")
                    base.stage_usage(stage)
                    time.sleep(0.5)
                rc = child.returncode
                require(rc == 0, "WSL graph command failed, exit " + str(rc))
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
            base.write_json(stage / "logs/graph_result.json", {
                "returncode": rc, "wall_seconds": time.monotonic() - start, "error": error,
                "linux_timeout_is_authoritative": True,
                "windows_launcher_termination_does_not_certify_linux_group_exit": True})
        require(error is None, error or "Graph command failed")
        result = graph_check(base, stage / "logs/graph.out", stage_linux)
        base.write_json(stage / "logs/graph_validated.json", result)
        base.verify_originals(data, hol)
        for record in data["sources"] + [data["helper"]]:
            base.verify_record(stage, dict(record, path=Path(record["path"]).name))
        base.write_json(stage / "WINDOWS_PREFLIGHT_PASSED.json", {
            "only_graph_was_run": True, "input_sha256": INPUT_SHA,
            "graph_sha256": result["graph_sha256"], "linux_stage": stage_linux,
            "usage": base.stage_usage(stage), "actual_build_not_authorized_by_this_adapter": True})
        print("WINDOWS_PREFLIGHT_PASSED; no theory build executed:", stage)
    except BaseException as exc:
        print("FAILED_CLOSED:", type(exc).__name__, str(exc), file=sys.stderr)
        print("Preserve partial stage:", stage, file=sys.stderr)
        raise


if __name__ == "__main__":
    main()
