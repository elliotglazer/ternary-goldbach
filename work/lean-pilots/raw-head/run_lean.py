"""Bounded project-only builds. Root runs these sequentially; dependencies stay read-only."""
import ctypes
import hashlib
import json
import os
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
here = Path(__file__).resolve().parent
work = here.parents[1]
lean = Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
packages = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
source, label = sys.argv[1:3]
assert Path(source).name == source and source.endswith(".lean")
assert label.replace("_", "").isalnum()
path = here / source
source_hash = hashlib.sha256(path.read_bytes()).hexdigest()
environment = dict(os.environ)
environment["LEAN_PATH"] = ";".join(map(str, [here, here.parent / "spectral", here.parent / "batched-transform",
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
command = [str(lean), "-t0", "-j1", "-M4096", "-o", str(path.with_suffix(".olean")), str(path)]
started = time.perf_counter()
peak_private = peak_working = 0
stop = None
with (here / (label + ".log")).open("x", encoding="utf-8") as log:
    process = subprocess.Popen(command, cwd=here, env=environment, stdin=subprocess.DEVNULL,
        stdout=log, stderr=subprocess.STDOUT, creationflags=subprocess.CREATE_NO_WINDOW)
    while process.poll() is None:
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
        time.sleep(.05)
    exit_code = process.wait()
wall_seconds = time.perf_counter() - started
times = [FileTime() for _ in range(4)]
valid_time = get_time(int(process._handle), *[ctypes.byref(t) for t in times])
seconds = lambda t: ((t.hi << 32) | t.lo) / 1e7
cpu_seconds = seconds(times[2]) + seconds(times[3]) if valid_time else None
receipt = dict(command=command, exit_code=exit_code, stop=stop,
    wall_seconds=wall_seconds, cpu_seconds=cpu_seconds,
    observed_peak_private_bytes=peak_private, peak_working_set_bytes=peak_working,
    source_sha256=source_hash, source_unchanged=source_hash == hashlib.sha256(path.read_bytes()).hexdigest(),
    log_sha256=hashlib.sha256((here / (label + ".log")).read_bytes()).hexdigest(), dependency_builds=False)
if exit_code == 0:
    receipt["olean_sha256"] = hashlib.sha256(path.with_suffix(".olean").read_bytes()).hexdigest()
with (here / (label + ".json")).open("x", encoding="utf-8") as output:
    json.dump(receipt, output, indent=2)
    output.write("\n")
print(json.dumps(receipt))
if exit_code:
    print((here / (label + ".log")).read_text(encoding="utf-8")[:18000])
sys.exit(exit_code)
