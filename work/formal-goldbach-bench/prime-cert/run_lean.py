from pathlib import Path
import subprocess, os, sys, json, time, ctypes

ROOT = Path(__file__).resolve().parent
PACKAGES = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
LEAN = Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
env = os.environ.copy()
env['LEAN_PATH'] = ';'.join([str(ROOT)] + [str(p/'.lake/build/lib/lean') for p in PACKAGES.iterdir() if p.is_dir()])
start = time.perf_counter()
run = subprocess.Popen([str(LEAN), *sys.argv[1:]], cwd=ROOT, env=env, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = run.communicate()
elapsed = time.perf_counter() - start
class FILETIME(ctypes.Structure):
    _fields_ = [('low',ctypes.c_uint32),('high',ctypes.c_uint32)]
creation, exit_time, kernel, user = FILETIME(), FILETIME(), FILETIME(), FILETIME()
get_times=ctypes.windll.kernel32.GetProcessTimes
get_times.argtypes=[ctypes.c_void_p]+[ctypes.POINTER(FILETIME)]*4
ok=get_times(int(run._handle),ctypes.byref(creation),ctypes.byref(exit_time),ctypes.byref(kernel),ctypes.byref(user))
cpu_seconds=((kernel.high<<32)+kernel.low+(user.high<<32)+user.low)/1e7 if ok else None
record={'exit':run.returncode,'wall_seconds':elapsed,'whole_process_cpu_seconds':cpu_seconds,'args':sys.argv[1:]}
(ROOT / f'run-{time.time_ns()}.log').write_text(stdout + stderr + '\n' + json.dumps(record), encoding='utf-8')
print(stdout, end='')
print(stderr, end='', file=sys.stderr)
print(json.dumps(record))
sys.exit(run.returncode)
