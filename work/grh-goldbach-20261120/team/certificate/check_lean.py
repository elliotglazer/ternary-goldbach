"""Compile the generated endpoint proof and print its axioms in one Lean process."""
import ctypes
from ctypes import wintypes
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
from time import perf_counter


HERE = Path(__file__).resolve().parent
WORK = HERE.parents[2]
FINITE = WORK / "backend-costs-20261112/finite-lean"
SUPPORT = WORK / "formal-goldbach-bench/prime-cert"
PACKAGES = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
LEAN = Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


source = HERE / "UpperBinaryPilot.lean"
run = HERE / "checks" / sys.argv[1]
run.mkdir(parents=True, exist_ok=False)
probe = run / source.name
probe.write_bytes(source.read_bytes() + b"\n#print UpperBinaryPilot.binary_interval\n"
                  b"#print axioms UpperBinaryPilot.binary_interval\n")
log = run / "lean.log"
olean = run / "UpperBinaryPilot.olean"
paths = [FINITE, SUPPORT] + sorted(p / ".lake/build/lib/lean" for p in PACKAGES.iterdir() if p.is_dir())
env = dict(os.environ, LEAN_PATH=os.pathsep.join(map(str, paths)))
command = [str(LEAN), "-t0", "-j1", "-M4096", "-o", str(olean), str(probe)]
start = perf_counter()
with log.open("w", encoding="utf-8") as stream:
    proc = subprocess.Popen(command, cwd=run, env=env, stdin=subprocess.DEVNULL,
                            stdout=stream, stderr=subprocess.STDOUT,
                            creationflags=subprocess.CREATE_NO_WINDOW)
    print(json.dumps({"pid": proc.pid, "command": command}), flush=True)
    reason = None
    try:
        code = proc.wait(timeout=600)
    except subprocess.TimeoutExpired:
        reason = "600-second wall limit"
        proc.kill()
        code = proc.wait()
    times = [wintypes.FILETIME() for _ in range(4)]
    get_times = ctypes.windll.kernel32.GetProcessTimes
    get_times.argtypes = [wintypes.HANDLE] + [ctypes.POINTER(wintypes.FILETIME)] * 4
    cpu = None
    if get_times(int(proc._handle), *map(ctypes.byref, times)):
        cpu = sum((t.dwHighDateTime << 32) + t.dwLowDateTime for t in times[2:]) / 1e7
project_dependencies = [FINITE / "BatchPrime", FINITE / "PrimeBitmap", SUPPORT / "PrimeSupport"]
pins = {str(base.with_suffix(ext)): digest(base.with_suffix(ext))
        for base in project_dependencies for ext in (".lean", ".olean")}
result = dict(exit_code=code, stop=reason, wall_seconds=perf_counter()-start,
              cpu_seconds=cpu, command=command, lean_path=list(map(str, paths)),
              project_dependencies=pins, source_sha256=digest(source),
              probe_sha256=digest(probe), log_sha256=digest(log))
if code == 0:
    result["olean_sha256"] = digest(olean)
(run/"receipt.json").write_text(json.dumps(result, indent=2)+"\n", encoding="utf-8")
print(json.dumps({k: result[k] for k in ["exit_code", "stop", "wall_seconds", "cpu_seconds"]}))
print(log.read_text(encoding="utf-8"))
sys.exit(code)
