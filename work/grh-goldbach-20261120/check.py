"""Check selected new modules with existing, read-only Lean 4.35 dependencies.

No Lake update, dependency build, or dependency artifact writes are performed.
Outputs and measurements are confined to this directory.
"""
from pathlib import Path
import ctypes
import hashlib
import json
import os
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
LEAN = Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
PACKAGES = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
env = os.environ.copy()
env['LEAN_PATH'] = ';'.join([str(HERE / 'build')] +
    [str(p / '.lake/build/lib/lean') for p in PACKAGES.iterdir() if p.is_dir()])

class FT(ctypes.Structure):
    _fields_ = [('lo', ctypes.c_uint32), ('hi', ctypes.c_uint32)]

gettime = ctypes.windll.kernel32.GetProcessTimes
gettime.argtypes = [ctypes.c_void_p] + [ctypes.POINTER(FT)] * 4

source = Path(sys.argv[1]).resolve()
label = sys.argv[2]
module = sys.argv[3] if len(sys.argv) > 3 else source.stem
out = HERE / 'build' / (module.replace('.', '/') + '.olean')
out.parent.mkdir(parents=True, exist_ok=True)
log = HERE / (label + '.log')
cmd = [str(LEAN), '-t0', '-j1', '-M4096', '-o', str(out), str(source)]
start = time.perf_counter()
with log.open('x', encoding='utf-8') as stream:
    proc = subprocess.Popen(cmd, cwd=source.parent, env=env, stdin=subprocess.DEVNULL,
        stdout=stream, stderr=subprocess.STDOUT, creationflags=subprocess.CREATE_NO_WINDOW)
    try:
        print(json.dumps(dict(pid=proc.pid, source=str(source), label=label)), flush=True)
        code = proc.wait(timeout=600)
        stop = None
    except subprocess.TimeoutExpired:
        proc.kill()
        code = proc.wait()
        stop = '600 second wall cap'
    times = [FT() for _ in range(4)]
    ok = gettime(int(proc._handle), *[ctypes.byref(t) for t in times])
    cpu = sum(((t.hi << 32) | t.lo) / 1e7 for t in times[2:]) if ok else None
result = dict(command=cmd, exit_code=code, stop=stop, cpu_seconds=cpu,
    wall_seconds=time.perf_counter() - start, source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
    log_sha256=hashlib.sha256(log.read_bytes()).hexdigest(), dependency_builds=False)
if code == 0:
    result['olean_sha256'] = hashlib.sha256(out.read_bytes()).hexdigest()
(HERE / (label + '.json')).write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
print(json.dumps(result))
print(log.read_text(encoding='utf-8'))
sys.exit(code)
