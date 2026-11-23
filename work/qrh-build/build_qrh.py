"""Isolated QRH compatibility build against target Lean/Mathlib v4.35.
Reads pinned sources and writes only local artifacts/logs. Does not invoke Lake,
change dependency pins, or rebuild cached Mathlib. No proof claim until full
assembly and independent type/axiom checks succeed.
"""
from pathlib import Path
import argparse, hashlib, json, os, re, subprocess, sys, time
sys.setrecursionlimit(10000)
HERE=Path(__file__).resolve().parent
ROOT=HERE.parent.parent
SOURCES={
    'OAI':ROOT/'work/openai-math/lean',
    'PrimeNumberTheoremAnd':ROOT/'work/qrh-dependencies/PrimeNumberTheoremAnd',
    'RellichKondrachov':ROOT/'work/qrh-dependencies/rellich-kondrachov',
}
PACKAGES=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
LEAN=Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
ARTIFACTS=HERE/'artifacts'; LOGS=HERE/'logs'
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('modules',nargs='*',default=['OAI.NumberTheory.DirichletL.Nonvanishing'])
p.add_argument('--scan-only',action='store_true')
p.add_argument('--limit',type=int,help='Maximum uncached modules to compile in this invocation')
a=p.parse_args()
order=[]; deps={}; visiting=set(); seen=set(); external=set()
def source(m): return SOURCES[m.split('.')[0]].joinpath(*m.split('.')).with_suffix('.lean')
def visit(m):
    if m.split('.')[0] not in SOURCES: external.add(m); return
    if m in seen: return
    if m in visiting: raise ValueError('Import cycle: '+m)
    visiting.add(m)
    imports=[]
    for line in source(m).read_text(encoding='utf-8-sig').splitlines():
        match=re.match(r'^\s*(?:public\s+)?import\s+([^/-]+)',line)
        if match: imports.extend(match[1].split())
    for dep in imports: visit(dep)
    visiting.remove(m); seen.add(m)
    deps[m]=[d for d in imports if d.split('.')[0] in SOURCES]
    order.append(m)
for m in a.modules: visit(m)
print(json.dumps({'module_count':len(order),'external_roots':sorted({m.split('.')[0] for m in external}),'first_modules':order[:8]}),flush=True)
if a.scan_only: sys.exit(0)
if any(m.split('.')[0] not in {'Mathlib','Lean','Init','Batteries','Aesop','Qq'} for m in external):
    raise ValueError('Unexpected external package; inspect closure before building')
ARTIFACTS.mkdir(exist_ok=True); LOGS.mkdir(exist_ok=True)
env=dict(os.environ)
env['LEAN_PATH']=';'.join([str(ARTIFACTS)]+[str(d/'.lake/build/lib/lean') for d in PACKAGES.iterdir() if d.is_dir()])
count=0
for i,m in enumerate(order,1):
    src=source(m); out=ARTIFACTS.joinpath(*m.split('.')).with_suffix('.olean')
    log=LOGS/(m+'.log'); receipt=LOGS/(m+'.json')
    src_hash=hashlib.sha256(src.read_bytes()).hexdigest()
    dep_times={d:ARTIFACTS.joinpath(*d.split('.')).with_suffix('.olean').stat().st_mtime_ns for d in deps[m]}
    key={'source_sha256':src_hash,'dependency_times':dep_times,'lean':'4.35.0','mathlib':'56a005855ea17e0b0958f73ec801ae140b0a1679','autoImplicit':False}
    if out.exists() and receipt.exists() and json.loads(receipt.read_text())==key: continue
    if a.limit is not None and count>=a.limit: print('Reached requested module limit',flush=True); break
    print(f'{i}/{len(order)} checking {m}',flush=True)
    out.parent.mkdir(parents=True,exist_ok=True)
    start=time.monotonic()
    cmd=[str(LEAN),'-j','2','-DautoImplicit=false','-R',str(SOURCES[m.split('.')[0]]),'-o',str(out),str(src)]
    with log.open('w',encoding='utf-8') as stream:
        run=subprocess.run(cmd,cwd=SOURCES[m.split('.')[0]],env=env,stdout=stream,stderr=subprocess.STDOUT)
    print(f'exit={run.returncode} seconds={time.monotonic()-start:.1f} log={log}',flush=True)
    if run.returncode:
        print(log.read_text(encoding='utf-8'),flush=True);sys.exit(run.returncode)
    receipt.write_text(json.dumps(key,indent=2),encoding='utf-8');count+=1
else: print('Requested import closure compiled; separate statement and axiom audit still required.',flush=True)
