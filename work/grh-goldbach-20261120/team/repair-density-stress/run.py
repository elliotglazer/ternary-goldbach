"""Sign-blind density stress for an even, primitive nonreal pair."""
import json
from math import gcd,log,pi
from hashlib import sha256
from fractions import Fraction as F
from pathlib import Path
import sys
from flint import dirichlet_char

out=Path(__file__).resolve().parent
team=out.parent
work=team.parents[1]
manifest=work/'qrh-campaign/agents/integration/transform_structural_manifest_20261111.json'
raw=manifest.read_bytes()
rows=[x for x in json.loads(raw)['conductors'] if x[0]%4==0 and 3000<=x[3]<=3400]
def score(r):
    return r[3]*log(r[0]*r[3]/(2*pi))**4
row=max(rows,key=score)
q,_,_,T,*_=row
opts=[]
for a in range(1,q):
    if gcd(a,q)!=1: continue
    b=pow(a,-1,q)
    if a>=b: continue
    c=dirichlet_char(q,a)
    if c.parity() or not c.is_primitive(): continue
    key=f'repair-density-stress/v1/{q}/{a}/{b}'
    opts.append((sha256(key.encode()).hexdigest(),a,b,key))
digest,a,b,key=min(opts)
frozen=dict(row=row,score=score(row),eligible=len(rows),formula='T log(q*T/(2*pi))^4',height_budget=[3000,3400],
    reason='Expected unresolved pairs under quadratic small-spacing repulsion scale like density times cubed local spacing in mean units.',
    eligibility='multiple of 4; 3000<=T<=3400; distinct primitive even inverse labels',
    pair=[a,b],pair_sha256=digest,key=key,eligible_pairs=len(opts),guard=50,manifest_sha256=sha256(raw).hexdigest())
path=out/'freeze.json'
if path.exists(): assert json.loads(path.read_bytes())==frozen
else: path.write_text(json.dumps(frozen,indent=2))
print(frozen,flush=True)
if '--freeze' in sys.argv: sys.exit(0)
main=(64*T+4)//5
last=main+640
V=F(5*last,64)
theta=64
W=q*V/theta
eps=F(1,2**82*3**theta)
K=L=1
while 128*W*W*F(3,8)**K>=eps: K+=1
while 48*W*F(3,8)**L>=eps: L+=1
assert F(8,3)**20>=W*(20+L) and V>=2*theta and W>=1
n0=8192; v0=3*n0*n0/W; z0=3*(2*n0+1)/W-F(1,n0)
assert v0>=2 and z0>0 and 88*n0*(1+1/z0)*F(3,8)**int(v0)<eps/8
N=1
while F(5*N,64)<max(2*V*K/theta,V+2*K,6): N*=2
J=(25*N+191)//192
assert J<N//2 and last+128<N
(out/'selector.json').write_text(json.dumps(dict(q=q,T=T,V=str(V),W=str(W),N=N,J=J,K=K,L=L,theta=theta),indent=2))
src=team/'high-conductor-pilot'
def once(s,old,new):
    assert s.count(old)==1,old
    return s.replace(old,new)
s=once((src/'spectrum.py').read_text(),'Q = 265800',f'Q = {q}')
s=once(s,'BASE_LABELS = (9539,)',f'BASE_LABELS = ({a},)')
s=once(s,'return 3072, 3712, 32768, 4267, 64',f'return {main}, {last}, {N}, {J}, {theta}')
(out/'spectrum.py').write_text(s)
g=once((src/'grid.py').read_text(),'if j in (0,1,main,last):','if j in (-1,0,1,main,last):')
(out/'grid.py').write_text(g)
r=(src/'repair.py').read_text().replace('240*64',f'{T}*64').replace('T="240"',f'T="{T}"')
r=once(r,'2*(80000000//theta)**2+1',f'2*F({W.numerator},{W.denominator})**2+1')
(out/'repair.py').write_text(r)
parent=work/'backend-costs-20261112/hol-platt'
sys.path.extend([str(parent/'one-character-completeness'),str(parent/'small-character-kernel')])
import spectrum,grid,repair
assert spectrum.LABELS==(a,b)
for stage in (spectrum,grid,repair):
    print(stage.__name__,flush=True)
    stage.run()
