"""One intentional bounded build of the validated win01 stage. No automatic retry."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import time

OWNER = Path(__file__).resolve().parent
PINS = {
    "recover_preflight_windows.py": "9530f4c29d7b19b1e19fa6e95f3cf77b76e56d3c6b0e125fd639ea603aa00305",
    "validate_recovery_offline_v2.py": "89e799275bc961466fde63f00fb2b1377167aa24bf6b3d8388c6c39ab225f9b9",
    "recovery01-offline-validation-v2/RECEIPT.json": "e6e5b91478c0e7b808dd914bac09b208110ffa924f2c4752e9681bb89a748b3d",
    "recovery01-offline-validation-v2/graph_validation.json": "33a10b73c801512716c66f28bb89bdd36d705265aa5228300f8663cac4fb1b76",
    "recovery01-offline-validation-v2/graph.json": "452e41cd91c2892dcea17c29a27c616c9aad4005b56f4387cb35ebc9a25e7f78",
}
# All variable paths are positional arguments, never interpolated shell text.
# ulimit -f is conservative: 32768 shell blocks is at most 32 MiB on this shell.
# It applies to regular output files of the builder too, not only stdout/stderr.
SHELL = r'''set -eu
cd "$1"
test -x /usr/bin/time
test ! -e "$4"
test ! -e "$5"
test ! -e "$6"
ulimit -v 4194304
ulimit -c 0
ulimit -f 32768
set -C
unset HOLBUILD
exec "$2" /usr/bin/time -v -o "$4" timeout -k 15 10800 "$3" --no_prereqs --no-project --no_preexecs --no-cache -j1 RawPairRoundTheory.uo > "$5" 2> "$6"
'''


def require(value, message):
    if not value:
        raise RuntimeError(message)


def digest(path):
    h = hashlib.sha256()
    with path.open("rb") as f:
        for b in iter(lambda: f.read(1024 * 1024), b""):
            h.update(b)
    return h.hexdigest()


def main():
    require(os.name == "nt", "Use Windows Python")
    for name, pin in PINS.items():
        require(digest(OWNER / name) == pin, "Pinned evidence changed: " + name)
    sys.dont_write_bytecode = True
    spec = importlib.util.spec_from_file_location("recovery_definition_only", OWNER / "recover_preflight_windows.py")
    recovery = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(recovery)
    old = recovery.load_adapter()
    base = old.load_base()
    require(Path(sys.executable).resolve() == old.PYTHON.resolve(), "Use specified Python")
    require(digest(OWNER / "dependency_inputs.json") == old.INPUT_SHA, "Input manifest")
    data = base.read_json(OWNER / "dependency_inputs.json")
    setup = OWNER.parents[1] / "hol4-setup"
    hol = setup / data["hol_directory"]
    stage = OWNER / "dependency-build-win01"
    require(stage.is_dir() and not stage.is_symlink(), "Expected owned existing stage")
    stage_linux = old.linux_path(stage)
    validated = base.read_json(OWNER / "recovery01-offline-validation-v2/RECEIPT.json")
    require(validated["status"] == "PASS" and validated["offline_only"] and
            validated["unchanged_object_files"] == 40, "Validated starting state")
    binding = base.read_json(stage / "windows_stage_binding.json")
    require(binding["adapter_sha256"] == recovery.ADAPTER_SHA and
            binding["input_sha256"] == old.INPUT_SHA and binding["linux_stage"] == stage_linux,
            "Original stage binding")
    require(binding["holmakefile_sha256"] == digest(stage / "Holmakefile"), "Holmakefile changed")
    require(digest(hol / "tools/Holmake/core/Holmake.sml") == recovery.HOLMAKE_SOURCE_SHA,
            "Dispatch source changed")
    for name, pin in validated["pins"].items():
        require(digest(OWNER / name) == pin, "Recovery input changed: " + name)
    base.verify_originals(data, hol)
    for r in data["sources"] + [data["helper"]]:
        base.verify_record(stage, dict(r, path=Path(r["path"]).name))
    snapshot = base.read_json(OWNER / "PREFLIGHT_FAILURE_READONLY_SNAPSHOT.json")
    for r in snapshot["stage_files"]:
        if r["path"].startswith(".hol/objs/"):
            p = stage / r["path"]
            require(p.stat().st_size == r["bytes"] and digest(p).upper() == r["sha256"].upper(),
                    "Validated initial object changed: " + r["path"])
    original_objects = {r["path"] for r in snapshot["stage_files"] if r["path"].startswith(".hol/objs/")}
    require({p.relative_to(stage).as_posix() for p in (stage / ".hol/objs").rglob("*") if p.is_file()} == original_objects,
            "Validated initial object set changed")
    usage_before = base.stage_usage(stage)
    # Preserve all old logs/bindings explicitly; .hol metadata and new local objects
    # are permitted to change in this intentional build.
    protected_paths = [stage / "windows_stage_binding.json", stage / "Holmakefile"]
    protected_paths += [p for p in (stage / "logs").iterdir() if p.is_file()]
    protected = {str(p.relative_to(stage)): digest(p) for p in protected_paths}
    run = OWNER / "build-existing-win01"
    require(not run.exists(), "One attempt only; refusing existing run directory")
    run.mkdir()
    argv = [str(Path(os.environ["WINDIR"]) / "System32/wsl.exe"), "-d", old.DISTRIBUTION,
            "--exec", "sh", "-c", SHELL, "raw-analytic-actual-build", stage_linux,
            old.linux_path(setup / "run.sh"), old.linux_path(hol / "bin/Holmake"),
            old.linux_path(run / "time.txt"), old.linux_path(run / "build.out"),
            old.linux_path(run / "build.err")]
    base.write_json(run / "STARTED.json", {"intentional_actual_build": True,
        "script_sha256": digest(Path(__file__)), "evidence_pins": PINS,
        "input_sha256": old.INPUT_SHA, "argv": argv, "stage_usage_before": usage_before,
        "prior_partial_build_preserved": True, "no_retries": True,
        "linux_wall_timeout_seconds": 10800, "linux_kill_grace_seconds": 15,
        "linux_address_space_per_process_bytes": 4 * 1024**3,
        "regular_file_limit_shell_blocks": 32768})
    started = time.monotonic()
    rc = None
    error = None
    launcher_timeout = False
    try:
        # HOL output goes directly to Linux-visible capped regular files. These
        # separate launcher logs contain only WSL/shell setup diagnostics.
        with (run / "launcher.out").open("xb") as out, (run / "launcher.err").open("xb") as err:
            try:
                rc = subprocess.run(argv, cwd=OWNER, stdout=out, stderr=err, timeout=10900).returncode
            except subprocess.TimeoutExpired:
                launcher_timeout = True
                raise RuntimeError("Windows launch timeout; Linux survivor check required, no retry")
        require(rc == 0, "Actual build returned " + str(rc))
        required = [stage / ".hol/objs" / ("RawPairRoundTheory" + ext)
                    for ext in (".uo", ".ui", ".dat", ".sml", ".sig")]
        require(all(p.is_file() for p in required), "Missing completed helper outputs")
        require((run / "time.txt").is_file(), "Missing GNU time evidence")
    except BaseException as exc:
        error = str(exc)
    post_errors = []
    try:
        base.verify_originals(data, hol)
        for r in data["sources"] + [data["helper"]]:
            base.verify_record(stage, dict(r, path=Path(r["path"]).name))
        for name, pin in protected.items():
            require(digest(stage / name) == pin, "Old log/binding changed: " + name)
        for name, pin in PINS.items():
            require(digest(OWNER / name) == pin, "Validation evidence changed: " + name)
        usage_after = base.stage_usage(stage)
    except BaseException as exc:
        post_errors.append(str(exc))
        usage_after = None
    outputs = []
    for p in sorted((stage / ".hol/objs").glob("*")):
        if p.is_file():
            outputs.append({"path": p.relative_to(stage).as_posix(),
                            "bytes": p.stat().st_size, "sha256": digest(p)})
    metrics = {}
    if (run / "time.txt").is_file():
        for line in (run / "time.txt").read_text(encoding="utf-8", errors="replace").splitlines():
            text = line.strip()
            for key in ("User time (seconds)", "System time (seconds)",
                        "Elapsed (wall clock) time (h:mm:ss or m:ss)",
                        "Maximum resident set size (kbytes)", "Exit status"):
                if text.startswith(key + ": "):
                    metrics[key] = text[len(key) + 2:]
    if error is None and (len(metrics) != 5 or metrics.get("Exit status") != "0"):
        error = "Missing/incomplete GNU time evidence or nonzero timed exit"
    success = error is None and not post_errors
    base.write_json(run / "RESULT.json", {"status": "PASS" if success else "FAIL",
        "returncode": rc, "error": error, "postcheck_errors": post_errors,
        "windows_wall_seconds": time.monotonic() - started,
        "windows_launcher_timed_out": launcher_timeout,
        "windows_timeout_does_not_certify_linux_process_exit": True,
        "linux_timeout_and_file_limits_authoritative": True,
        "gnu_time": metrics, "stage_usage_after": usage_after,
        "local_object_inventory": outputs, "protected_old_files": protected,
        "script_sha256": digest(Path(__file__)), "evidence_pins": PINS})
    require(success, "Build failed; preserve all output and inspect RESULT.json; no retry")
    print("BUILD_PASS; actual RawPairRound target completed; inspect theory and timing evidence")


if __name__ == "__main__":
    main()
