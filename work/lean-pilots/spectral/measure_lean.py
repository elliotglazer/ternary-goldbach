"""Strict direct Lean measurement, no dependency build or proof-source modification."""
from pathlib import Path
import ctypes,hashlib,json,os,subprocess,sys,time
from ctypes import wintypes
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
LEAN=Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
PKG=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
CACHE=ROOT/'work/qrh-campaign/agents/integration/artifacts'
name=sys.argv[1]; assert name.isidentifier()
source=HERE/(name+'.lean'); output=HERE/(name+'.olean')
assert not output.exists(), 'Fresh measured artifact required'
digest=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
source_hash=digest(source)
env=dict(os.environ)
env['LEAN_PATH']=';'.join([str(CACHE)]+[str(p/'.lake/build/lib/lean') for p in PKG.iterdir() if p.is_dir()])
stamp=time.strftime('%Y%m%d_%H%M%S')
log=HERE/(name+'_strict_'+stamp+'.log')
cmd=[str(LEAN),'-t0','-j','2','-R',str(HERE),'-o',str(output),str(source)]
class Memory(ctypes.Structure):
    _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[(n,ctypes.c_size_t) for n in
      ['PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage',
       'QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage','PrivateUsage']]
psapi=ctypes.WinDLL('psapi',use_last_error=True)
psapi.GetProcessMemoryInfo.argtypes=[wintypes.HANDLE,ctypes.POINTER(Memory),wintypes.DWORD]
kernel=ctypes.WinDLL('kernel32',use_last_error=True)
kernel.GetProcessTimes.argtypes=[wintypes.HANDLE]+[ctypes.POINTER(wintypes.FILETIME)]*4
peak_working=peak_private=0
start=time.monotonic()
with log.open('x',encoding='utf8') as stream:
    proc=subprocess.Popen(cmd,cwd=HERE,env=env,stdout=stream,stderr=subprocess.STDOUT)
    handle=wintypes.HANDLE(int(proc._handle))
    while proc.poll() is None:
        mem=Memory();mem.cb=ctypes.sizeof(mem)
        if psapi.GetProcessMemoryInfo(handle,ctypes.byref(mem),mem.cb):
            peak_working=max(peak_working,mem.PeakWorkingSetSize)
            peak_private=max(peak_private,mem.PrivateUsage)
        time.sleep(.1)
    wall=time.monotonic()-start
    times=[wintypes.FILETIME() for _ in range(4)]
    ok=kernel.GetProcessTimes(handle,*[ctypes.byref(t) for t in times])
    seconds=lambda t:((t.dwHighDateTime<<32)|t.dwLowDateTime)/10000000
    cpu=seconds(times[2])+seconds(times[3]) if ok else None
receipt=dict(command=cmd,exit_code=proc.returncode,wall_seconds=wall,cpu_seconds=cpu,
 peak_working_set_bytes=peak_working,sampled_peak_private_bytes=peak_private,
 source_sha256=source_hash,source_unchanged=source_hash==digest(source),
 lean_binary_sha256=digest(LEAN),log_sha256=digest(log),dependency_build=False,
 fresh_owned_artifact=True,trust_level=0)
if proc.returncode==0:receipt['olean_sha256']=digest(output)
with log.with_suffix('.json').open('x',encoding='utf8') as f:json.dump(receipt,f,indent=2)
print(log.read_text(encoding='utf8')); print(json.dumps(receipt,indent=2))
sys.exit(proc.returncode)
