"""Independent direct compile of byte-identical owned copy, read-only imports."""
from pathlib import Path
import ctypes,hashlib,json,os,subprocess,sys,time
H=Path(__file__).resolve().parent
ROOT=H.parents[3]
AUTHOR=ROOT/'work/lean-pilots/spectral-abel/FiniteAbel.lean'
EXPECTED='98B68F87E5F4EB842E2B839C368F7066B958A6A266B3C42D995F576A3BD46310'
LEAN=Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
PACKAGES=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
CACHE=ROOT/'work/qrh-campaign/agents/integration/artifacts'
def pin(p):
 b=p.read_bytes();return dict(path=str(p),bytes=len(b),sha256=hashlib.sha256(b).hexdigest().upper())
assert pin(AUTHOR)['sha256']==EXPECTED
name=sys.argv[1];assert name in ('FiniteAbel','Audit')
if name=='FiniteAbel':
 with (H/'FiniteAbel.lean').open('xb') as f:f.write(AUTHOR.read_bytes())
source=H/(name+'.lean');out=H/(name+'.olean')
assert not out.exists()
env=os.environ.copy();env['LEAN_PATH']=';'.join([str(H),str(CACHE)]+[str(p/'.lake/build/lib/lean') for p in PACKAGES.iterdir() if p.is_dir()])
cmd=[str(LEAN),'-t0','-j2','-R',str(H),'-o',str(out),str(source)]
t=time.perf_counter()
with (H/(name+'.log')).open('x',encoding='utf-8') as f:
 p=subprocess.Popen(cmd,cwd=H,env=env,stdout=f,stderr=subprocess.STDOUT,stdin=subprocess.DEVNULL,creationflags=subprocess.CREATE_NO_WINDOW)
 try:rc=p.wait(timeout=180)
 except subprocess.TimeoutExpired:p.kill();p.wait();raise
receipt=dict(command=cmd,exit_code=rc,wall_seconds=time.perf_counter()-t,source=pin(source),author=pin(AUTHOR),log=pin(H/(name+'.log')),lean_path=env['LEAN_PATH'],dependency_build=False,options_overrides=False)
assert receipt['author']['sha256']==EXPECTED
if rc==0:receipt['olean']=pin(out)
with (H/(name+'.json')).open('x',encoding='utf-8') as f:json.dump(receipt,f,indent=2);f.write('\n')
print(json.dumps(receipt,indent=2));sys.exit(rc)
