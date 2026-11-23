"""Read-only frozen author imports, exact type/axiom probe only."""
from pathlib import Path
import hashlib,json,os,subprocess,sys,time
H=Path(__file__).resolve().parent;R=H.parents[3];S=R/'work/lean-pilots/spectral'
LEAN=Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
P=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
def pin(p):
 b=p.read_bytes();return dict(path=str(p),bytes=len(b),sha256=hashlib.sha256(b).hexdigest().upper())
expected={x['file']:x['sha256'] for x in json.loads((H/'fixed_rational_receipt.json').read_text())['source_pins']}
expected['SampleBox.lean']=sys.argv[1].upper();assert len(expected['SampleBox.lean'])==64
inputs=[]
for name,sha in expected.items():
 assert pin(S/name)['sha256']==sha
 receipts=[]
 for r in S.glob(Path(name).stem+'_*.json'):
  j=json.loads(r.read_text())
  if j.get('exit_code')==0 and j.get('source_sha256','').upper()==sha:receipts.append((r,j))
 assert receipts,name
 rp,rj=sorted(receipts,key=lambda x:str(x[0]))[-1]
 op=S/Path(name).with_suffix('.olean')
 assert pin(op)['sha256']==rj['olean_sha256'].upper()
 inputs.extend([pin(S/name),pin(op),pin(rp)])
env=os.environ.copy();env['LEAN_PATH']=';'.join([str(H),str(S),str(S.parent/'spectral-abel'),str(R/'work/qrh-campaign/agents/integration/artifacts')]+[str(p/'.lake/build/lib/lean') for p in P.iterdir() if p.is_dir()])
cmd=[str(LEAN),'-t0','-j2','-R',str(H),'-o',str(H/'AuditInputs.olean'),str(H/'AuditInputs.lean')]
assert not (H/'AuditInputs.olean').exists()
t=time.perf_counter()
with (H/'AuditInputs.log').open('x',encoding='utf-8') as f:
 p=subprocess.Popen(cmd,cwd=H,env=env,stdout=f,stderr=subprocess.STDOUT,stdin=subprocess.DEVNULL,creationflags=subprocess.CREATE_NO_WINDOW)
 try:rc=p.wait(timeout=180)
 except subprocess.TimeoutExpired:p.kill();p.wait();raise
for row in inputs:assert pin(Path(row['path']))==row
out=dict(command=cmd,exit_code=rc,wall_seconds=time.perf_counter()-t,inputs=inputs,lean_path=env['LEAN_PATH'],dependency_build=False,source_unchanged=True,source=pin(H/'AuditInputs.lean'),log=pin(H/'AuditInputs.log'))
if rc==0:out['olean']=pin(H/'AuditInputs.olean')
with (H/'probe_receipt.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(out,indent=2));sys.exit(rc)
