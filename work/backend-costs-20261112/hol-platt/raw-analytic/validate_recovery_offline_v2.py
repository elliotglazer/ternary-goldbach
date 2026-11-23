"""Validate the saved, exactly prefixed recovery graph. Never launch a process."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

OWNER = Path(__file__).resolve().parent
PINS = {
    "recover_preflight_windows.py": "9530f4c29d7b19b1e19fa6e95f3cf77b76e56d3c6b0e125fd639ea603aa00305",
    "PREFLIGHT_FAILURE_READONLY_SNAPSHOT.json": "59027e210e968ee8d8ca5825fde2ddae5e63aeb246acf38d2b45829987f861fe",
    "dependency-build-win01/logs/recovery01_graph.out": "c2c0b4f8a54f73fa50ad04da7565aa61fc18023ea2955a49e4152cb9a18babac",
    "dependency-build-win01/logs/recovery01_result.json": "219020afdacf600eb0c5d66b4bc6907fd7b9f656bac9c488b7d2ddbe594474ba",
    "dependency-build-win01/logs/recovery01_command.json": "87e13d4f0eb324cac8023f5117897464df3ef6b7735a5a92f1989a8db286f07b",
}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def require(test, message):
    if not test:
        raise RuntimeError(message)


def validate_selected(old, base, graph, output, stage_linux, hol_linux):
    required = {"node_id", "target", "seqnum", "phony", "dependencies", "command",
                "dir", "mtime", "needs_rebuild"}
    ids = {}
    for n in graph:
        require(isinstance(n, dict) and required <= n.keys(), "Graph schema")
        require(type(n["node_id"]) is int and n["node_id"] not in ids, "Graph id")
        require(type(n["phony"]) is bool and type(n["needs_rebuild"]) is bool, "Graph flag")
        require(isinstance(n["target"], str) and n["target"].startswith("/"), "Target path")
        require(isinstance(n["command"], str) and isinstance(n["dir"], str), "Command/dir")
        require(isinstance(n["dependencies"], list) and
                all(type(i) is int for i in n["dependencies"]), "Edges")
        ids[n["node_id"]] = n
    require(all(i in ids for n in graph for i in n["dependencies"]), "Dangling edge")
    def exact(target):
        found = [n for n in graph if n["target"] == target]
        require(len(found) == 1, "Unique exact target: " + target)
        return found[0]
    aggregate = exact(stage_linux + "/all")
    helper = exact(stage_linux + "/RawPairRoundTheory.uo")
    state = exact(hol_linux + "/bin/hol.state")
    require(aggregate["command"] == "" and not aggregate["phony"] and
            old.linux_resolve(aggregate["dir"], stage_linux) == stage_linux and
            len(aggregate["dependencies"]) == 2 and
            set(aggregate["dependencies"]) == {state["node_id"], helper["node_id"]},
            "Exact harmless local aggregate")
    require(state["command"] == "" and not state["needs_rebuild"] and not state["phony"],
            "Pinned existing HOL state")
    require(all(aggregate["node_id"] not in n["dependencies"] for n in graph),
            "Aggregate must be root only")
    seen = set()
    todo = [helper["node_id"], state["node_id"]]
    while todo:
        i = todo.pop()
        if i not in seen:
            seen.add(i)
            todo.extend(ids[i]["dependencies"])
    selected = [n for n in graph if n["node_id"] in seen]
    require(all(not n["phony"] for n in selected), "No phony selected component")
    external = [n for n in selected if old.linux_resolve(n["dir"], stage_linux) != stage_linux]
    require(all(not n["needs_rebuild"] for n in external), "Unresolved external selected dependency")
    # Source status semantics make commands on Succeeded external nodes dormant.
    # Retain original selected graph; separately erase only those dormant commands
    # for the predecessor's local-command safety validator. No dependency is erased.
    checked = [dict(n, command="") if n in external else n for n in selected]
    base.write_json(output / "selected_graph.json", selected)
    base.write_json(output / "local_command_check_graph.json", checked)
    result = old.graph_check(base, output / "local_command_check_graph.json", stage_linux)
    result.update({"full_graph_nodes": len(graph), "checked_exact_all": aggregate,
                   "selected_nodes": len(selected), "external_succeeded_nodes": len(external),
                   "selected_graph_sha256": digest(output / "selected_graph.json"),
                   "dormant_external_commands_erased_only_in_check_projection": True,
                   "unselected_nodes_not_treated_as_build_actions": len(graph)-len(selected)-1})
    return result


def main():
    for name, pin in PINS.items():
        require(digest(OWNER / name) == pin, "Pinned input changed: " + name)
    sys.dont_write_bytecode = True
    spec = importlib.util.spec_from_file_location("recovery_definition_only", OWNER / "recover_preflight_windows.py")
    recovery = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(recovery)
    old = recovery.load_adapter()
    base = old.load_base()
    require(digest(OWNER / "dependency_inputs.json") == old.INPUT_SHA, "Manifest changed")
    data = base.read_json(OWNER / "dependency_inputs.json")
    setup = OWNER.parents[1] / "hol4-setup"
    hol = setup / data["hol_directory"]
    tools_source = hol / "tools/Holmake/core/Holmake_tools.sml"
    require(digest(tools_source) == "b9a679bc109622736a99f700f4f1bfb7625ddc6d0ca515aae8ee595bc5695b8b", "Output-function source changed")
    require(digest(hol / "tools/Holmake/core/Holmake.sml") == recovery.HOLMAKE_SOURCE_SHA, "Dispatch source changed")
    depgraph_source = hol / "tools/Holmake/deps/HM_DepGraph.sml"
    require(digest(depgraph_source) == "9c4ad829b57c9ee093e49a39b19ff71680cca11030351717a472eb624835612f", "Graph status source changed")
    stage = OWNER / "dependency-build-win01"
    stage_linux = old.linux_path(stage)
    result = base.read_json(stage / "logs/recovery01_result.json")
    require(result["returncode"] == 0 and result["error"] is None, "Recovery command failed")
    command = base.read_json(stage / "logs/recovery01_command.json")
    require(command["has_positional_holmake_target"] is False, "Wrong dispatch mode")
    require(command["argv"][6] == recovery.SHELL, "Saved shell differs from reviewed recovery")
    raw = (stage / "logs/recovery01_graph.out").read_bytes()
    require(len(raw) <= base.MAX_GRAPH_BYTES, "Graph size cap")
    # One exact byte prefix at offset zero, no search/extraction or whitespace stripping.
    prefix = b"Holmake: "
    require(raw.startswith(prefix + b"["), "Expected exact Holmake info prefix")
    payload = raw[len(prefix):]
    graph = json.loads(payload.decode("utf-8"))
    require(isinstance(graph, list) and 0 < len(graph) <= 10000, "Graph shape/cap")
    # json.loads requires the entire remainder to be one JSON value; extra log lines fail.
    base.verify_originals(data, hol)
    snapshot = base.read_json(OWNER / "PREFLIGHT_FAILURE_READONLY_SNAPSHOT.json")
    protected = []
    for r in snapshot["stage_files"]:
        if not r["path"].startswith(".hol/make-deps/"):
            p = stage / r["path"]
            require(p.stat().st_size == r["bytes"] and digest(p).upper() == r["sha256"].upper(),
                    "Preexisting protected file changed: " + r["path"])
            protected.append(r)
    original_objects = {r["path"] for r in snapshot["stage_files"] if r["path"].startswith(".hol/objs/")}
    current_objects = {p.relative_to(stage).as_posix() for p in (stage / ".hol/objs").rglob("*") if p.is_file()}
    require(current_objects == original_objects, "Object inventory changed")
    for r in data["sources"] + [data["helper"]]:
        base.verify_record(stage, dict(r, path=Path(r["path"]).name))
    binding = base.read_json(stage / "windows_stage_binding.json")
    require(binding["adapter_sha256"] == recovery.ADAPTER_SHA and
            binding["input_sha256"] == old.INPUT_SHA and binding["linux_stage"] == stage_linux and
            binding["holmakefile_sha256"] == digest(stage / "Holmakefile"), "Stage binding changed")
    usage = base.stage_usage(stage)
    output = OWNER / "recovery01-offline-validation-v2"
    require(not output.exists(), "Refusing to overwrite validation output")
    output.mkdir()
    normalized = output / "graph.json"
    with normalized.open("xb") as stream:
        stream.write(payload)
    graph_result = validate_selected(old, base, graph, output, stage_linux, old.linux_path(hol))
    base.write_json(output / "graph_validation.json", graph_result)
    # Confirm normalization and validation have not changed the raw evidence.
    for name, pin in PINS.items():
        require(digest(OWNER / name) == pin, "Input changed during validation: " + name)
    base.write_json(output / "RECEIPT.json", {
        "status": "PASS", "offline_only": True, "processes_launched": 0,
        "script_sha256": digest(Path(__file__)), "pins": PINS,
        "output_function_source_sha256": digest(tools_source),
        "graph_status_source_sha256": digest(depgraph_source),
        "previous_offline_attempt": "Strict all-node checker rejected implicit hol.state aggregate edge; normalized graph preserved in recovery01-offline-validation. No process launched and no original/stage file changed.",
        "normalization": "Remove exactly one leading nine-byte Holmake: prefix including its space; parse entire remaining UTF-8 JSON value",
        "raw_bytes": len(raw), "normalized_sha256": digest(normalized),
        "graph_validation_sha256": digest(output / "graph_validation.json"),
        "full_graph_nodes": len(graph), "strict_component_nodes": graph_result["nodes"],
        "prospective_local_compilations": len(graph_result["planned_compilations"]),
        "original_source_boundary_helper_checks": 62, "staged_source_helper_checks": 46,
        "protected_existing_stage_files": len(protected), "unchanged_object_files": len(current_objects),
        "stage_usage_before_offline_output": usage,
        "linux_graph_returncode": 0, "linux_graph_wall_seconds": result["wall_seconds"],
        "prior_attempt_performed_actual_partial_build": True,
        "raw_graph_and_previous_artifacts_preserved": True,
        "remaining_build_not_executed": True,
    })
    print(json.dumps({"status": "PASS", "full_graph_nodes": len(graph),
                      "planned_compilations": len(graph_result["planned_compilations"]),
                      "receipt_sha256": digest(output / "RECEIPT.json")}))


if __name__ == "__main__":
    main()
