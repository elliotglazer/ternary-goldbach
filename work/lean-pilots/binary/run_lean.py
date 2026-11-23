from pathlib import Path
import subprocess, os, sys, json, time, ctypes

ROOT = Path(__file__).resolve().parent
PACKAGES = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
LEAN = Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
env = os.environ.copy()
env['LEAN_PATH'] = ';'.join([str(ROOT)] + [str(p/'.lake/build/lib/lean') for p in PACKAGES.iterdir() if p.is_dir()])
start = time.perf_counter()
run = subprocess.Popen([str(LEAN), '-j', '1', '-t', '0', *sys.argv[1:]], cwd=ROOT, env=env,
                       text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = run.communicate()
elapsed = time.perf_counter()-start
class FILETIME(ctypes.Structure):
    _fields_=[('low',ctypes.c_uint32),('high',ctypes.c_uint32)]
creation,exit_time,kernel,user=FILETIME(),FILETIME(),FILETIME(),FILETIME()
gt=ctypes.windll.kernel32.GetProcessTimes
gt.argtypes=[ctypes.c_void_p]+[ctypes.POINTER(FILETIME)]*4
ok=gt(int(run._handle),ctypes.byref(creation),ctypes.byref(exit_time),ctypes.byref(kernel),ctypes.byref(user))
cpu=((kernel.high<<32)+kernel.low+(user.high<<32)+user.low)/1e7 if ok else None
record={'exit':run.returncode,'wall_seconds':elapsed,'process_cpu_seconds':cpu,
        'command':[str(LEAN),'-j','1','-t','0',*sys.argv[1:]],'cwd':str(ROOT)}
stamp=time.time_ns()
(ROOT/f'run-{stamp}.log').write_text(stdout+stderr,encoding='utf-8')
(ROOT/f'run-{stamp}.json').write_text(json.dumps(record,indent=2)+'\n')
print(stdout,end='');print(stderr,end='',file=sys.stderr);print(json.dumps(record))
sys.exit(run.returncode)
