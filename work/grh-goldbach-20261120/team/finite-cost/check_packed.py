"""Fresh-process Lean 4.35.0 checks with explicit dependency hashes and CPU receipts."""

import ctypes
from ctypes import wintypes
from hashlib import sha256
import json
import os
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
WORK = HERE.parents[2]
PKGS = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
LEAN = Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
TREE = HERE.parent / "certificate/checks/endpoint02"
FINITE = WORK / "backend-costs-20261112/finite-lean"
SUPPORT = WORK / "formal-goldbach-bench/prime-cert"
modules = ["PackedDigits", "PackedChunks", "PackedGoldbach", "PackedExample", "PackedEndpoint"]
run = HERE / "receipts" / sys.argv[1]
run.mkdir(parents=True,exist_ok=False)
env = dict(os.environ, LEAN_PATH=os.pathsep.join(map(str, [
    run, TREE, FINITE, SUPPORT, *sorted(p / ".lake/build/lib/lean" for p in PKGS.iterdir() if p.is_dir())])))
get_times = ctypes.windll.kernel32.GetProcessTimes
get_times.argtypes = [wintypes.HANDLE] + [ctypes.POINTER(wintypes.FILETIME)] * 4
def digest(path):
    return sha256(path.read_bytes()).hexdigest()
deps = [TREE / "UpperBinaryPilot.olean", FINITE / "BatchPrime.olean", FINITE / "PrimeBitmap.olean",
        SUPPORT / "PrimeSupport.olean", HERE.parent / "certificate/upper-fixture.json"]
log = dict(lean=subprocess.check_output([str(LEAN),"--version"],text=True).strip(),
           dependency_sha256={str(p.relative_to(WORK)):digest(p) for p in deps}, checked=[])
for name in modules:
    source, out = HERE / (name+".lean"), run / (name+".olean")
    cmd = [str(LEAN), "-t0", "-j1", "-M2048", "-o", str(out), str(source)]
    start = time.monotonic()
    with (run/(name+".log")).open("w",encoding="utf-8") as file:
        proc = subprocess.Popen(cmd,cwd=HERE,env=env,stdout=file,stderr=subprocess.STDOUT,
                                stdin=subprocess.DEVNULL,creationflags=subprocess.CREATE_NO_WINDOW)
        try:
            code = proc.wait(timeout=300)
        except subprocess.TimeoutExpired:
            proc.kill()
            code = proc.wait()
        elapsed = time.monotonic()-start
        times = [wintypes.FILETIME() for _ in range(4)]
        if not get_times(int(proc._handle), *map(ctypes.byref,times)):
            raise ctypes.WinError()
    cpu = sum((t.dwHighDateTime << 32) + t.dwLowDateTime for t in times[2:])/1e7
    row = dict(module=name, exit=code, cpu_seconds=cpu, wall_seconds=elapsed,
               command=cmd,source_sha256=digest(source),log_sha256=digest(run/(name+".log")))
    if code==0:
        row["olean_sha256"]=digest(out)
    log["checked"].append(row)
    (run/"receipts.json").write_text(json.dumps(log,indent=2)+"\n",encoding="utf-8")
    print(name,code,cpu,elapsed,flush=True)
    if code:
        print((run/(name+".log")).read_text(encoding="utf-8"))
        sys.exit(code)
