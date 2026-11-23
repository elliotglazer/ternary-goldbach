"""Freeze one deterministic inverse pair and replay a bounded Gaussian/Turing pilot."""
from fractions import Fraction as F
from hashlib import sha256
from math import gcd
import json
from pathlib import Path
import sys

from flint import dirichlet_char

out = Path(__file__).resolve().parent
team = out.parent
work = team.parents[1]
parent = work/'backend-costs-20261112/hol-platt'
manifest = work/'qrh-campaign/agents/integration/transform_structural_manifest_20261111.json'
raw = manifest.read_bytes()
row = max(json.loads(raw)['conductors'], key=lambda r:r[0])
q = row[0]
T = 240
main = T*64//5
last = main+640
theta = 64
W = F(80000000,theta)
eps = F(1,2**82*3**theta)
K = L = 1
while 128*W*W*F(3,8)**K >= eps: K+=1
while 48*W*F(3,8)**L >= eps: L+=1
assert q*F(5*last,64)<80000000 and F(8,3)**20>=W*(20+L)
need = max(F(2*last*K,theta),F(5*last+128*K,5),F(384,5))
N=1
while N<need: N*=2
J=(25*N+191)//192
freeze=out/'freeze.json'
if not freeze.exists():
    best=None
    count=0
    for a in range(1,q):
        if gcd(a,q)!=1: continue
        b=pow(a,-1,q)
        if a>=b: continue
        c=dirichlet_char(q,a)
        if c.parity() or not c.is_primitive(): continue
        count+=1
        key=f'repair-v1/{q}/{a}/{b}'
        item=(sha256(key.encode()).hexdigest(),a,b,key)
        if best is None or item<best: best=item
    digest,a,b,key=best
    freeze.write_text(json.dumps(dict(manifest_sha256=sha256(raw).hexdigest(),row=row,
        rule='largest scheduled q; least SHA-256 over even primitive nonself inverse pairs',
        candidates=count,labels=[a,b],key=key,sha256=digest,T=T,guards=[320,640],
        final_height=str(F(5*last,64)),qV=str(q*F(5*last,64)),theta=theta,K=K,L=L,N=N,J=J),indent=2))
memo=json.loads(freeze.read_bytes())
a,b=memo['labels']
assert a*b%q==1 and all(dirichlet_char(q,x).is_primitive() and not dirichlet_char(q,x).parity() for x in (a,b))
print(memo,flush=True)
if '--freeze' in sys.argv: sys.exit()

def once(src,old,new):
    assert src.count(old)==1,old
    return src.replace(old,new)

source=team/'q10004-gaussian'
s=(source/'spectrum.py').read_text()
s=once(s,'Q = 10004',f'Q = {q}')
s=once(s,'BASE_LABELS = (6559, 5499)',f'BASE_LABELS = ({a},)')
s=once(s,'return 84199, 84839, 524288, 68267, 64',f'return {main}, {last}, {N}, {J}, {theta}')
s=once(s,'== [0,0,1,1]','== [0,0]')
s=once(s,'((0,1),(2,3))','((0,1),)')
(out/'spectrum.py').write_text(s)
(out/'grid.py').write_text((source/'grid.py').read_text())
r=(source/'repair.py').read_text().replace('6578',str(T))
r=once(r,'[LABELS[:2],LABELS[2:]]','[LABELS[:2]]')
(out/'repair.py').write_text(r)
sys.path.extend([str(parent/'one-character-completeness'),str(parent/'small-character-kernel')])
import spectrum,grid,repair
for stage in (spectrum,grid,repair):
    print(stage.__name__,flush=True)
    stage.run()
