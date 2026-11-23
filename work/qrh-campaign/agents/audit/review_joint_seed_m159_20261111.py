"""Independent exact m159 bounds and metadata. No function-value evaluation."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import json, hashlib

ROOT=Path(__file__).resolve().parents[4]
pins={
 'work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md':'E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9',
 'work/qrh-blueprint/check_joint_seed_m159_20261111.py':'7F0B7BD1C597629D6DBD687730E767C5CB660286F6B5CBA57599EF24757E84A4',
 'work/qrh-blueprint/joint_seed_m159_20261111.json':'EF16593CF667377CD68CA9D3C37343E3364ECA06CABACCC9B8465931E2D83D45',
 'work/qrh-blueprint/JOINT_SEED_224_CORRECTIONS_2026-11-11.md':'E438F4EF3AEC8352947B046E55C07418D9DA233B5E602B6FEF5CB402600F61F5',
 'work/qrh-campaign/agents/audit/REVIEW_JOINT_SEED_224_CORRECTIONS_2026-11-11.md':'7A74329B1D51F9E0113ECB76DC68DC1DC7F4182EAF29209DE47CE068EF84D888',
 'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
 'work/qrh-campaign/agents/audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A',
}
checks=0
def ck(b):
 global checks
 checks+=1
 assert b,checks
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
data=json.loads((ROOT/'work/qrh-blueprint/joint_seed_m159_20261111.json').read_text())
m,N,D,P,V,W=159,1500,4096,28,7000,7009
ck(data['parameters']==dict(m=m,N=N,D=D,P=P,V=V,W=W))
largest_index=(P-1)+2*m-1
ck(largest_index==344)
for j in range(largest_index+1):
 ck(4*V*V+(2*j+1)**2<4*W*W)
ck(N+2<39*39)
r=F(W,6*(N+1))
R=F(8*39,4*m-1)*r**(2*m)
ck(8*39*W**(2*m)*2**116<(4*m-1)*(6*(N+1))**(2*m))
ck(F(data['remainder'])==R)
ck(r<F(17,20) and F(W,D*(N+1))<1)
for k in range(P):
 ck(F(1,2)+k+2*m>1)
 individual=F(8*39,2*k+4*m-1)*F(W,D*(N+1))**k*r**(2*m)/factorial(k)
 ck(individual<=R)
e=F(0)
for ell in range(1,P+2*m-1):
 e=r*e+1
 ck(e<7)
ck(P+2*m-2==344)
ck(31*m==4929<7936)
ck(F(31*m,6)+1<1324)
delta,u,eta,ut=[F(1,2**n) for n in (118,122,100,110)]
seed=10507*delta+278753*u+R
ck(F(data['seed_over_eta'])==seed/eta)
ck(seed<F(107,1000)*eta and seed<eta/4)
ck(2*seed+351*ut<F(557,1000)*eta and 2*seed+351*ut<eta)
ck(2**P*(seed+350*ut)<1 and 6*(3*N+7)+1<2**16)
target=1266*F(V+20,4*8192)**20/factorial(20)
shift=1266*F(5*(V+P),8*D)**P/factorial(P)
ck(target+shift+2532*eta<F(4,25)*F(1,2**82))
slots=P*(D+1)
newterms=m*slots;newE=(P+2*m-2)*(D+1)
ck(data['gamma_terms']==newterms==18239844)
ck(data['E_stages']==newE==1409368)
rows={}
for predecessor in (256,224):
 oldterms=predecessor*slots;oldE=(P+2*predecessor-2)*(D+1)
 diff=dict(gamma_saved=oldterms-newterms,E_saved=oldE-newE)
 ck(data['savings_per_height'][str(predecessor)]==diff)
 rows[str(predecessor)]={str(H):{k:H*v for k,v in diff.items()} for H in (20199,20366,20519,20839)}
ck(m-64==95 and 2*m==318)
for p,h in data['pins'].items():ck(pins['work/'+p]==h)
out=dict(status='PASS conditional m159 refinement; no values/builds',checks=checks,pins=pins,last_rising_index=largest_index,remainder=str(R),seed_over_eta=str(seed/eta),output_over_eta=str((2*seed+351*ut)/eta),per_height=data['savings_per_height'],prefix_savings=rows)
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(f'PASS {checks} exact checks: Euclidean factors, remainder, inherited errors and counts.')
