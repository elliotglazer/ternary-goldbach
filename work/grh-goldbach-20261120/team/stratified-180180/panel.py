"""Freeze eight inverse pairs by parity; run every frozen stratum under the same policy."""
from pathlib import Path
from hashlib import sha256
from math import gcd
import json
import subprocess
import sys
from flint import dirichlet_char

out=Path(__file__).resolve().parent
team=out.parent
work=team.parents[1]
q=180180
manifest=work/'qrh-campaign/agents/integration/transform_structural_manifest_20261111.json'
raw=manifest.read_bytes()
seed=sha256(raw).hexdigest()
row=next(r for r in json.loads(raw)['conductors'] if r[0]==q)
choices=[[],[]]
for a in range(1,q):
    if gcd(a,q)!=1: continue
    b=pow(a,-1,q)
    if a>=b: continue
    c=dirichlet_char(q,a)
    if not c.is_primitive(): continue
    key=f'{seed}/sparse-stratified-180180/v1/{a}/{b}'
    choices[c.parity()].append([sha256(key.encode()).hexdigest(),a,b])
for cohort in choices: cohort.sort()
freeze=dict(q=q,row=row,seed=seed,rule='First four SHA-256 digests within each parity, no draws replaced',
            key_format='manifest_sha256/sparse-stratified-180180/v1/a/b',eligible=[len(x) for x in choices],
            selected=[x[:4] for x in choices],guard=50,moderate=18,endpoint_policy='inclusive, aligned, no endpoint-only probes')
f=out/'freeze.json'
if f.exists(): assert json.loads(f.read_bytes())==freeze
else: f.write_text(json.dumps(freeze,indent=2))
print(freeze,flush=True)
if '--freeze' in sys.argv: sys.exit()
if len(sys.argv)==1:
    status=[]
    for i in range(4):
        try:
            with (out/f'group{i}.log').open('w') as log:
                rc=subprocess.run([sys.executable,__file__,str(i)],stdout=log,stderr=subprocess.STDOUT,timeout=200,check=False).returncode
        except subprocess.TimeoutExpired: rc='timeout'
        status.append(rc)
        (out/'status.json').write_text(json.dumps(status))
        print('finished',i,rc,flush=True)
    sys.exit(int(any(x!=0 for x in status)))

i=int(sys.argv[1])
p=out/f'group{i}'
p.mkdir(exist_ok=True)
old=team/'gaussian-panel-q180180'
a,b=freeze['selected'][0][i][1:]
c,d=freeze['selected'][1][i][1:]
def replace(s,old,new):
    assert s.count(old)==1,old
    return s.replace(old,new)
s=replace((old/'spectrum.py').read_text(),'BASE_LABELS = (40343, 139583)',f'BASE_LABELS = ({a}, {c})')
(p/'spectrum.py').write_text(s)
g=(old/'grid.py').read_text()
(p/'grid.py').write_text(g)
r=(old/'repair.py').read_text()
(p/'repair.py').write_text(r)
parent=work/'backend-costs-20261112/hol-platt'
sys.path.insert(0,str(p))
sys.path.extend([str(parent/'one-character-completeness'),str(parent/'small-character-kernel')])
import spectrum,grid,repair
assert spectrum.LABELS==(a,b,c,d)
for stage in [spectrum,grid,repair]:
    stage.run()
subprocess.run([sys.executable,str(team/'high-conductor-full/inclusive.py'),'--round-main',str(p)],check=True)
