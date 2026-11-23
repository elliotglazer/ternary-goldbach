"""Bounded direct-Lean process measurement; dependencies remain read-only."""
import ctypes, hashlib, json, os, subprocess, sys, time
from pathlib import Path
sys.stdout.reconfigure(encoding='utf-8')
H=Path(__file__).resolve().parent
LEAN=Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
source=sys.argv[1];label=sys.argv[2]
class FT(ctypes.Structure):_fields_=[('lo',ctypes.c_uint32),('hi',ctypes.c_uint32)]
class PMC(ctypes.Structure):
 _fields_=[('cb',ctypes.c_uint32),('faults',ctypes.c_uint32)]+[(n,ctypes.c_size_t) for n in ('peak_ws','ws','peak_paged','paged','peak_nonpaged','nonpaged','pagefile','peak_pagefile','private')]
gettime=ctypes.windll.kernel32.GetProcessTimes
gettime.argtypes=[ctypes.c_void_p]+[ctypes.POINTER(FT)]*4
getmem=ctypes.windll.psapi.GetProcessMemoryInfo
getmem.argtypes=[ctypes.c_void_p,ctypes.POINTER(PMC),ctypes.c_uint32]
cmd=[str(LEAN),'-t0','-j1','-M4096','-o',str(H/(Path(source).stem+'.olean')),str(H/source)]
env=os.environ.copy()
packages=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
env['LEAN_PATH']=';'.join([str(H)]+[str(p/'.lake/build/lib/lean') for p in packages.iterdir() if p.is_dir()])
begin=time.perf_counter();peakws=peakprivate=0;stop=None;samples=0
with (H/(label+'.log')).open('x',encoding='utf-8') as out:
 p=subprocess.Popen(cmd,cwd=H,env=env,stdin=subprocess.DEVNULL,stdout=out,stderr=subprocess.STDOUT,creationflags=subprocess.CREATE_NO_WINDOW)
 while p.poll() is None:
  pm=PMC();pm.cb=ctypes.sizeof(pm)
  if getmem(int(p._handle),ctypes.byref(pm),pm.cb):
   peakws=max(peakws,pm.peak_ws);peakprivate=max(peakprivate,pm.private);samples+=1
  if time.perf_counter()-begin>600:stop='600 second wall cap';p.kill();break
  if peakprivate>4*1024**3:stop='4 GiB observed private cap';p.kill();break
  time.sleep(.05)
 rc=p.wait();wall=time.perf_counter()-begin
 fs=[FT() for _ in range(4)];ok=gettime(int(p._handle),*[ctypes.byref(f) for f in fs])
 sec=lambda f:((f.hi<<32)|f.lo)/1e7
 user=sec(fs[3]) if ok else None;system=sec(fs[2]) if ok else None
log=(H/(label+'.log')).read_text(encoding='utf-8')
rows=[]
for line in log.splitlines():
 if line.startswith('STAGE,'):
  _,variant,prec,n,reps,decls,ns=line.split(',')
  rows.append(dict(variant=variant,precision=int(prec),butterflies=int(n),repetitions=int(reps),declarations=int(decls),kernel_wall_ns=int(ns)))
 if line.startswith('RESULT,'):
  _,prec,fixture,reps,decls,accepted,rejected,generation,check=line.split(',')
  rows.append(dict(precision=int(prec),fixture=int(fixture),repetitions=int(reps),declarations_per_bundle=int(decls),accepted=int(accepted),corrupt_rejected=rejected=='true',proof_pool_generation_ns=int(generation),kernel_bundle_wall_ns=int(check)))
artifacts=[]
for name in (source,label+'.log')+((Path(source).stem+'.olean',) if rc==0 else ()):
 path=H/name
 if path.exists():
  b=path.read_bytes();artifacts.append(dict(path=name,bytes=len(b),sha256=hashlib.sha256(b).hexdigest().upper()))
result=dict(command=cmd,exit_code=rc,stop=stop,wall_seconds=wall,user_cpu_seconds=user,system_cpu_seconds=system,
 cpu_seconds=(user+system if ok else None),peak_working_set_bytes=peakws,observed_peak_private_bytes=peakprivate,
 memory_samples=samples,measurement='Windows process times and peak working set; private memory sampled every50ms; kernel loop is elapsed time',
 rows=rows,limits_lines=[l for l in log.splitlines() if l.startswith('LIMITS,')],artifacts=artifacts,
 no_native_decide=True,dependency_builds=False)
with (H/(label+'.json')).open('x',encoding='utf-8') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({k:result[k] for k in ('exit_code','stop','wall_seconds','cpu_seconds','rows')}))
if rc: print(log)
sys.exit(rc)
