import ctypes,hashlib,json,os,subprocess,sys,time
from pathlib import Path
HERE=Path(__file__).resolve().parent
LEAN=Path(os.environ.get('LEAN_BENCH_EXE','C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe'))
file=sys.argv[1] if len(sys.argv)>1 else 'QuickActual.lean'
stem=sys.argv[2] if len(sys.argv)>2 else Path(file).stem
log=HERE/(stem+'.log')
env=os.environ.copy();env['LEAN_PATH']=str(HERE)
t0=time.perf_counter()
p=subprocess.Popen([str(LEAN),"-t0",str(HERE/file)],cwd=HERE,env=env,stdin=subprocess.DEVNULL,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace')
lines=[]
with log.open('w',encoding='utf-8') as out:
 for line in p.stdout:
  out.write(line);out.flush();lines.append(line);print(line,end='',flush=True)
rc=p.wait();wall=time.perf_counter()-t0
class FT(ctypes.Structure):_fields_=[('lo',ctypes.c_uint32),('hi',ctypes.c_uint32)]
fs=[FT() for _ in range(4)]
ctypes.windll.kernel32.GetProcessTimes.argtypes=[ctypes.c_void_p]+[ctypes.POINTER(FT)]*4
ok=ctypes.windll.kernel32.GetProcessTimes(int(p._handle),*[ctypes.byref(f) for f in fs])
secs=lambda f:((f.hi<<32)|f.lo)/1e7
rows=[]
for line in lines:
 if line.startswith('RESULT,'):
  _,label,w,k,reps,accepted,rejected,ns=line.strip().split(',')
  rows.append(dict(label=label,width=int(w),masks=int(k),reps=int(reps),accepted=int(accepted),rejected=rejected=='true',kernel_seconds=int(ns)/1e9,ns_per_mask=int(ns)/(int(k)*int(reps))))
result=dict(source=file,source_sha256=hashlib.sha256((HERE/file).read_bytes()).hexdigest(),lean_executable=str(LEAN),trust_flag='-t0',timing_note='kernel_seconds is monotonic elapsed time inside checked declaration loop; kernel_cpu_seconds is Windows system CPU time for the entire process, not Lean logical-kernel time.',exit_code=rc,wall_seconds=wall,user_seconds=secs(fs[3]) if ok else None,kernel_cpu_seconds=secs(fs[2]) if ok else None,results=rows)
(HERE/(stem+'.json')).write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,indent=2),flush=True)
sys.exit(rc)
