from pathlib import Path
import subprocess,ctypes,json,time,hashlib
from ctypes import wintypes
p=Path(__file__).resolve().parent
exec((p/'check_lean.py').read_text().split('out={}')[0])
def cputime(proc):
    fn=ctypes.windll.kernel32.GetProcessTimes
    times=[wintypes.FILETIME() for _ in range(4)]
    ok=fn(wintypes.HANDLE(int(proc._handle)),*[ctypes.byref(t) for t in times]);assert ok
    return sum((v.dwHighDateTime<<32)+v.dwLowDateTime for v in times[2:])/1e7
def go(name,rep):
    label=name+str(rep);cmd=[str(lean),'-j1','-M3000','-t0']
    if name=='FactorialExtend':cmd+=['-o',name+'.olean']
    cmd+=[name+'.lean']
    start=time.monotonic()
    with (p/(label+'.log')).open('wb') as log:
        proc=subprocess.Popen(cmd,cwd=p,env=dict(os.environ,LEAN_PATH=os.pathsep.join(map(str,[p]+deps))),stdout=log,stderr=subprocess.STDOUT)
        rc=proc.wait();cpu=cputime(proc)
    out=dict(name=name,rep=rep,rc=rc,cpu=cpu,wall=time.monotonic()-start,source_hash=sha(p/(name+'.lean')))
    print(out,flush=True)
    assert rc==0,(p/(label+'.log')).read_text()
    return out
res=[]
for i,n in [(0,'FactorialExtend'),(1,'ImportFactorial'),(1,'FullFactorial'),(1,'DeltaFactorial'),(2,'DeltaFactorial'),(2,'FullFactorial'),(2,'ImportFactorial')]:
    res.append(go(n,i));(p/'factorial-timings.json').write_text(json.dumps(res,indent=2))
