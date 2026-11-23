"""Run the frozen high-end inverse pair at its scheduled height."""
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path
import sys
from flint import dirichlet_char

out=Path(__file__).resolve().parent
team=out.parent
work=team.parents[1]
prior=team/'high-conductor-pilot'
manifest=work/'qrh-campaign/agents/integration/transform_structural_manifest_20261111.json'
freeze=json.loads((prior/'freeze.json').read_bytes())
assert sha256(manifest.read_bytes()).hexdigest()==freeze['manifest_sha256']
q,_,_,T,*_=freeze['row']
a,b=freeze['labels']
assert q==265800 and T==455 and a*b%q==1
assert all(dirichlet_char(q,x).is_primitive() and not dirichlet_char(q,x).parity() for x in [a,b])
main=(64*T+4)//5
last=main+640
V=F(5*last,64)
theta=80
W=q*V/theta
eps=F(1,2**82*3**theta)
r=F(3,8)
assert V>=2*theta and W>=1
K=L=1
while 128*W*W*r**K>=eps: K+=1
while 48*W*r**L>=eps: L+=1
assert F(8,3)**20>=W*(20+L)
n0=16384
v0=3*n0**2/W
z0=3*(2*n0+1)/W-F(1,n0)
assert v0>=2 and z0>0 and 44*2*n0*(1+1/z0)*r**int(v0)<eps/8
N=1
while F(5*N,64)<max(2*V*K/theta,V+2*K,6): N*=2
J=(25*N+191)//192
assert J<N//2 and main+640+128<N
memo=dict(q=q,T=T,V=str(V),qV=str(q*V),theta=theta,W=str(W),K=K,L=L,n0=n0,N=N,J=J,
          v0=str(v0),z0=str(z0),labels=[a,b],prior_sha256=sha256((prior/'freeze.json').read_bytes()).hexdigest())
(out/'selector.json').write_text(json.dumps(memo,indent=2))
print(memo,flush=True)
def once(src,old,new):
    assert src.count(old)==1,old
    return src.replace(old,new)
s=(prior/'spectrum.py').read_text()
s=once(s,'return 3072, 3712, 32768, 4267, 64',f'return {main}, {last}, {N}, {J}, {theta}')
(out/'spectrum.py').write_text(s)
(out/'grid.py').write_text((prior/'grid.py').read_text())
t=(prior/'repair.py').read_text().replace('240*64',f'{T}*64').replace('T="240"',f'T="{T}"')
t=once(t,'2*(80000000//theta)**2+1',f'2*F({W.numerator},{W.denominator})**2+1')
(out/'repair.py').write_text(t)
parent=work/'backend-costs-20261112/hol-platt'
sys.path.extend([str(parent/'one-character-completeness'),str(parent/'small-character-kernel')])
import spectrum,grid,repair
for stage in (spectrum,grid,repair):
    print(stage.__name__,flush=True)
    stage.run()
