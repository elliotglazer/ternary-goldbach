"""Fixed paper scalar/pin checks only; no inventory or kernel values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
HERE=Path(__file__).resolve().parent
AG=HERE.parent
BLUE=AG.parent.parent/'qrh-blueprint'
pins={
 BLUE/'SHARED_HIGH_PRECISION_KERNEL_ADAPTER_2026-11-11.md':'6393BBAD96123F0AD7E1171CFE1BF2D50A1B27641E55C926BCD30D23155ABE42',
 AG/'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md':'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
 AG/'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md':'09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
 HERE/'CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md':'1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A',
 AG/'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md':'15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2',
}
checks=0
def ck(b):
 global checks
 assert b
 checks+=1
for p,h in pins.items():ck(hashlib.sha256(p.read_bytes()).hexdigest().upper()==h)
# Exact coefficient identities in A (constant, linear), not function samples.
ck((F(1),F(1))==(F(1),F(1))) # raw: A*u_H+u_p, u_H<=u_p
ck((F(1),F(1))!=(F(3,2),F(1,2)))
ck((F(1)-F(3,2),F(1)-F(1,2))==(F(-1,2),F(1,2)))
ck(F(-1,2)+F(1,2)==0) # remaining (A-1)/2>=0 for A>=1
ck(2<4) # sqrt(2)/2<1 for complex nearest rounding
ck(2**(108-100)==256 and 108-100==8)
# An abstract scalar illustrates why the two producer identities differ.
# This is not a kernel/root/analytic value or certificate construction.
def rnd(x,p):
 z=x*2**p+F(1,2)
 return F(z.numerator//z.denominator,2**p)
x=F(3,8)
ck(rnd(x,0)==0)
ck(rnd(rnd(x,1),0)==1)
ck(rnd(F(1,2),1)==F(1,2))
out={'scope':'Five pins and fixed rational paper checks only; no inventories/values.',
 'checks':checks,'pins':{str(p):h for p,h in pins.items()},
 'general_proof_in_review':True,
 'double_rounding_abstract_example':{'raw':'3/8','direct_grid0':'0','via_grid1':'1'},
 'production_or_saving_claim':False}
dest=HERE/'review_shared_high_precision_kernel_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
