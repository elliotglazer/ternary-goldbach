"""Measure exact renamed replay with Windows process CPU samples around a synchronized phase."""
import ctypes
import hashlib
import json
import os
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
here = Path(__file__).resolve().parent
work = here.parents[1]
source, label = sys.argv[1:3]
assert Path(source).name == source and source.endswith(".lean")
assert label.replace("_", "").isalnum()
path = here / source
source_hash = hashlib.sha256(path.read_bytes()).hexdigest()
lean = Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
packages = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
env = dict(os.environ)
env["LEAN_PATH"] = ";".join(map(str, [here, here.parent / "spectral", here.parent / "batched-transform",
    work / "backend-costs-20261112/lean-dependent", work / "backend-costs-20261112/finite-lean",
    work / "formal-goldbach-bench/prime-cert"] +
    [p / ".lake/build/lib/lean" for p in packages.iterdir() if p.is_dir()]))

class FileTime(ctypes.Structure):
    _fields_ = [("lo", ctypes.c_uint32), ("hi", ctypes.c_uint32)]

class Memory(ctypes.Structure):
    _fields_ = [("cb", ctypes.c_uint32), ("faults", ctypes.c_uint32)] + [
        (name, ctypes.c_size_t) for name in
        ("peak_ws", "ws", "peak_paged", "paged", "peak_nonpaged", "nonpaged", "pagefile", "peak_pagefile", "private")]

get_time = ctypes.windll.kernel32.GetProcessTimes
get_time.argtypes = [ctypes.c_void_p] + [ctypes.POINTER(FileTime)] * 4
get_memory = ctypes.windll.psapi.GetProcessMemoryInfo
get_memory.argtypes = [ctypes.c_void_p, ctypes.POINTER(Memory), ctypes.c_uint32]

def cpu_seconds(process):
    values = [FileTime() for _ in range(4)]
    assert get_time(int(process._handle), *[ctypes.byref(value) for value in values])
    return sum(((value.hi << 32) | value.lo) / 1e7 for value in values[2:])

command = [str(lean), "-t0", "-j1", "-M4096", "-o", str(path.with_suffix(".olean")), str(path)]
local_import_roots = [here, work / "backend-costs-20261112/finite-lean"]
pending, seen, snapshot_paths = [path], set(), {here / "run_replay.py"}
while pending:
    current = pending.pop()
    if current in seen:
        continue
    seen.add(current)
    snapshot_paths.add(current)
    if current != path:
        snapshot_paths.add(current.with_suffix(".olean"))
    for import_line in re.findall(r"^import ([A-Za-z0-9_. ]+)$", current.read_text(encoding="utf-8"), re.M):
        for module in import_line.split():
            for directory in local_import_roots:
                candidate = directory / (module.replace(".", "/") + ".lean")
                if candidate.exists():
                    pending.append(candidate)
                    break

def snapshot():
    return [{"path": str(item), "sha256": hashlib.sha256(item.read_bytes()).hexdigest()}
        for item in sorted(snapshot_paths)]

before_snapshot = snapshot()
phase_starts, phase_cpu, reader_errors = {}, {}, []
handshake_directory = here / (label + "_handshake")
handshake_directory.mkdir()
env["RAW_REPLAY_HANDSHAKE"] = str(handshake_directory)
handled_requests = set()
started = time.perf_counter()
peak_private = peak_working = 0
stop = None
with (here / (label + ".log")).open("x", encoding="utf-8") as log:
    process = subprocess.Popen(command, cwd=here, env=env, stdin=subprocess.DEVNULL,
        stdout=log, stderr=subprocess.STDOUT, creationflags=subprocess.CREATE_NO_WINDOW)
    while process.poll() is None:
        try:
            for request in sorted(handshake_directory.glob("*.request")):
                if request.name in handled_requests:
                    continue
                marker = re.fullmatch(r"(START|STOP)\.([A-Za-z0-9_]+)\.request", request.name)
                assert marker and request.read_text(encoding="utf-8") == "ready\n"
                stage, name = marker.groups()
                now = cpu_seconds(process)
                if stage == "START":
                    assert name not in phase_starts
                    phase_starts[name] = now
                else:
                    assert name in phase_starts and name not in phase_cpu
                    phase_cpu[name] = now - phase_starts[name]
                acknowledgement = request.with_suffix(".ack")
                assert not acknowledgement.exists()
                temporary = request.with_suffix(".ack_temporary")
                with temporary.open("x", encoding="utf-8", newline="\n") as output:
                    output.write("go\n")
                temporary.rename(acknowledgement)
                handled_requests.add(request.name)
        except Exception as error:
            reader_errors.append(repr(error))
            stop = "CPU handshake failure"
        memory = Memory()
        memory.cb = ctypes.sizeof(memory)
        if get_memory(int(process._handle), ctypes.byref(memory), memory.cb):
            peak_private = max(peak_private, memory.private)
            peak_working = max(peak_working, memory.peak_ws)
        if time.perf_counter() - started > 600:
            stop = "600-second wall limit"
        if peak_private > 4 * 1024 ** 3:
            stop = "4-GiB observed private limit"
        if stop:
            process.kill()
            break
        time.sleep(.005)
    exit_code = process.wait()
wall_seconds = time.perf_counter() - started
text = (here / (label + ".log")).read_text(encoding="utf-8")
rows = []
for line in text.splitlines():
    if line.startswith("COVER,"):
        _, variant, width, reps, declarations, generation, checking = line.split(",")
        rows.append(dict(variant=variant, width=int(width), repetitions=int(reps), declarations=int(declarations),
            proof_pool_generation_ns=int(generation), kernel_elapsed_ns=int(checking),
            kernel_process_cpu_seconds=phase_cpu.get(variant)))
receipt = dict(command=command, exit_code=exit_code, stop=stop, wall_seconds=wall_seconds,
    cpu_seconds=cpu_seconds(process), phase_cpu_seconds=phase_cpu, reader_errors=reader_errors, rows=rows,
    limits_lines=[line for line in text.splitlines() if line.startswith("LIMITS,")],
    observed_peak_private_bytes=peak_private, peak_working_set_bytes=peak_working,
    source_sha256=source_hash, source_unchanged=source_hash == hashlib.sha256(path.read_bytes()).hexdigest(),
    log_sha256=hashlib.sha256((here / (label + ".log")).read_bytes()).hexdigest(), dependency_builds=False,
    handshake_directory=str(handshake_directory), handled_requests=sorted(handled_requests),
    protocol="Child waits on atomic file acknowledgements around parent CPU samples; first admission/imports/warmup excluded; handshake file IO and polling CPU included")
variants = [row["variant"] for row in rows]
expected_markers = {f"{stage}.{variant}.{suffix}" for variant in variants
    for stage in ("START", "STOP") for suffix in ("request", "ack")}
receipt["handshake_files"] = sorted(item.name for item in handshake_directory.iterdir())
receipt["handshake_files_valid"] = set(receipt["handshake_files"]) == expected_markers and \
    all(item.is_file() and item.read_text(encoding="utf-8") ==
        ("ready\n" if item.suffix == ".request" else "go\n")
        for item in handshake_directory.iterdir())
receipt["local_snapshot_before"] = before_snapshot
receipt["local_snapshot_after"] = snapshot()
receipt["local_imports_unchanged"] = receipt["local_snapshot_before"] == receipt["local_snapshot_after"]
receipt["protocol_valid"] = bool(rows) and not reader_errors and stop is None and exit_code == 0 and \
    receipt["source_unchanged"] and receipt["local_imports_unchanged"] and receipt["handshake_files_valid"] and \
    len(variants) == len(set(variants)) and \
    set(variants) == set(phase_starts) == set(phase_cpu) and \
    all(row["repetitions"] > 0 and row["declarations"] > 0 and
        row["kernel_process_cpu_seconds"] is not None and row["kernel_process_cpu_seconds"] >= 0 for row in rows) and \
    receipt["limits_lines"] == ["LIMITS,trust=0,heartbeats=0,recdepth=65536"]
with (here / (label + ".json")).open("x", encoding="utf-8") as output:
    json.dump(receipt, output, indent=2)
    output.write("\n")
print(json.dumps({key: receipt[key] for key in ("exit_code", "stop", "wall_seconds", "cpu_seconds", "rows", "reader_errors")}))
if exit_code:
    print(text[:12000])
sys.exit(exit_code or not receipt["protocol_valid"])
