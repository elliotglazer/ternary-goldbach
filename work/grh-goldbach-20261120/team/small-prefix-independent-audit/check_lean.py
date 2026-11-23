from pathlib import Path
import os,subprocess,hashlib,json,time
p=Path(__file__).resolve().parent;small=p.parent/'small-prefix';work=p.parents[2]
release=small/'ten-billion/compact';live=small/'contiguous-extension'
packages=Path.home()/'Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages'
lean=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe'
deps=[live,release/'.split-build',small,p.parent/'aws-pilot/wide/b8192-02',work/'backend-costs-20261112/finite-lean',work/'formal-goldbach-bench/prime-cert']
deps.extend(sorted(x/'.lake/build/lib/lean' for x in packages.iterdir() if x.is_dir()))
def sha(f):return hashlib.sha256(f.read_bytes()).hexdigest()
out={}
for name,expected in [('Positive',0),('SkippedEven',1)]:
    source=p/(name+'.lean');start=time.monotonic()
    r=subprocess.run([lean,'-j1','-M3000','-t0',source.name],cwd=p,env=dict(os.environ,LEAN_PATH=os.pathsep.join(map(str,deps))),stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    log=p/(name+'.log');log.write_bytes(r.stdout);txt=r.stdout.decode('utf8');assert r.returncode==expected,txt
    if expected:assert '10402653188' in txt and '10402653186' in txt and 'mismatch' in txt.lower(),txt
    else:assert '[propext, Classical.choice, Quot.sound]' in txt and 'sorryAx' not in txt
    out[name]=dict(code=r.returncode,source=sha(source),log=sha(log),elapsed=time.monotonic()-start)
out['imported_public_olean']=sha(live/'ExtendedPrefixB.olean');(p/'lean-controls.json').write_text(json.dumps(out,indent=2));print(out)
