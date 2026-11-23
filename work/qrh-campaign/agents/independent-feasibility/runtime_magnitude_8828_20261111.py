"""Fixed rational context identities only; no inventory or value reads."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266',
 'independent-feasibility/SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md':'39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761',
 'audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD',
 'independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md':'5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A',
 'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md':'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
 'independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md':'412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7',
 'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md':'09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
 'independent-feasibility/NORMALIZED_BLUESTEIN_STRUCTURAL_COST_FOLD_2026-11-11.md':'F673EFE298538627F30DEAFD2C7F5AFF9606BA468D887A76677E14FF5C963B46',
 'integration/transform_structural_inventory_20261111.py':'584A16F00A905AD68C3FE11F4128FE2205F772FB67916EF312B596518F1ADB55',
 'integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md':'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C',
}
checks=0
def ck(x):
 global checks
 checks+=1
 if not x:raise AssertionError(checks)
for name,h in PINS.items():ck(hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper()==h)
def pow2(k):return F(2**k) if k>=0 else F(1,2**(-k))
def clog(x):
 x=F(x)
 k=x.numerator.bit_length()-x.denominator.bit_length()
 if pow2(k)<x:k+=1
 ck(pow2(k-1)<x<=pow2(k))
 return k
V=8828;OLD=16384
ck(1<=V<OLD<2*V)
ck(F(8192,V)==F(2048,2207))
fixtures=[F(1),F(3,2),F(2),F(3),F(4),F(7),F(31,4),F(77,8),F(16384,V),F(16384,V)+F(1,2**20)]
rows=[]
for f in fixtures:
 k=clog(f); old=14+k;new=clog(f*V)
 ck(old-new in (0,1))
 ck((old-new==1)==(f*V<=pow2(k+13)))
 ck(clog(f*OLD)==old)
 for p in (80,100,108):
  a=p+new;b=p+1
  ck(a>=1 and b>=1)
  ck(a+b+2+2==a+b+4)
 rows.append({'factor':[f.numerator,f.denominator],'old_integer_exponent':old,'new_integer_exponent':new})
ck(clog(F(3,2))==clog(2)==1)
ck(clog(F(3,2)*V)==14 and clog(2*V)==15)
# Fixed abstract Blue fixtures. They are not a plan or conductor scan.
blue=[]
for n,P in ((2,4),(3,8),(5,16)):
 Z=F(n*(2*n-1),P)+2
 ck(P>=2*n-1 and P//2<2*n-1)
 for j in (1,P.bit_length()-1):
  root=pow2(j)*Z;add=pow2(j+1)*Z
  ck(add==2*root)
  for a in (F(1),F(6)):
   for f in (a*(n+2),a*Z,a*root,a*add,a*2*n):
    ck(14+clog(f)-clog(V*f) in (0,1))
 blue.append({'n':n,'P':P,'Z':[Z.numerator,Z.denominator]})
out={'scope':'fixed rational identities; no metadata, values, assignment or pricing',
 'checks':checks,'sources':PINS,'V_runtime':V,'old_V':OLD,'fixtures':rows,'abstract_blue_fixtures':blue}
raw=(json.dumps(out,indent=2)+'\n').encode()
with (HERE/'runtime_magnitude_8828_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps({'checks':checks,'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest().upper()}))
