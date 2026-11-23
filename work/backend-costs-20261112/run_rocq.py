"""Measure a real Rocq compilation without invoking dependency builds."""
import ctypes,hashlib,json,os,subprocess,sys,time
from pathlib import Path
H=Path(__file__).resolve().parent
BIN=Path('C:/Users/glaze/AppData/Local/RocqPlatform/9.1.0/bin')
sys.stdout.reconfigure(encoding='utf-8')
name,label=sys.argv[1:3]
class FT(ctypes.Structure): _fields_=[('lo',ctypes.c_uint32),('hi',ctypes.c_uint32)]
gt=ctypes.windll.kernel32.GetProcessTimes
gt.argtypes=[ctypes.c_void_p]+[ctypes.POINTER(FT)]*4
cmd=[str(BIN.parent/'lib/rocq-runtime/rocqworker.exe'),'--kind=compile','-q',name+'.v']
env=os.environ.copy();env['PATH']=str(BIN)+os.pathsep+env['PATH']
begin=time.perf_counter()
with (H/(label+'.log')).open('x',encoding='utf8') as log:
    p=subprocess.Popen(cmd,cwd=H,env=env,stdout=log,stderr=subprocess.STDOUT,
                       creationflags=subprocess.CREATE_NO_WINDOW)
    try: rc=p.wait(timeout=300)
    except subprocess.TimeoutExpired: p.kill(); p.wait(); rc=-999
    elapsed=time.perf_counter()-begin
    ts=[FT() for _ in range(4)]
    ok=gt(int(p._handle),*[ctypes.byref(x) for x in ts])
    sec=lambda t:((t.hi<<32)|t.lo)/1e7
    cpu=sec(ts[2])+sec(ts[3]) if ok else None
result=dict(command=cmd,exit_code=rc,wall_seconds=elapsed,cpu_seconds=cpu,
    source_sha256=hashlib.sha256((H/(name+'.v')).read_bytes()).hexdigest(),
    log_sha256=hashlib.sha256((H/(label+'.log')).read_bytes()).hexdigest())
if rc==0:
    obj=H/(name+'.vo')
    result.update(vo_bytes=obj.stat().st_size,vo_sha256=hashlib.sha256(obj.read_bytes()).hexdigest())
(H/(label+'.json')).write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result))
print((H/(label+'.log')).read_text(encoding='utf8'))
sys.exit(1 if rc else 0)
