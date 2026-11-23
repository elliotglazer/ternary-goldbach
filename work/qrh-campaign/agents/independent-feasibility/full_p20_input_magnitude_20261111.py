"""Fixed P20 rational envelopes; no source coefficients or inventories."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
 'major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
 'moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md':'96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3',
 'independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266',
 'independent-feasibility/SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md':'39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761',
 'audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD',
 'independent-feasibility/RUNTIME_MAGNITUDE_8828_CONTEXT_WIDTHS_2026-11-11.md':'3363B798ED75652737431D46829C43483CF641F12169E1982F947DDF385CAD3C',
 'zero-sum/REVIEW_RUNTIME_MAGNITUDE_8828_CONTEXT_WIDTHS_2026-11-11.md':'8ED151A2CEAE534B668D900B473197E59DA88343A99FEF4D8ECAFB813F14BAE1',
}
checks=0
def ck(x):
 global checks
 checks+=1
 if not x:raise AssertionError(checks)
for name,h in PINS.items():ck(hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper()==h)
eta=F(1,2**100);ut=F(1,2**110);R=F(1,2**116)
W=4*eta+330*ut;flat=2**27*(eta/4+330*ut);e=F(3,4*2**70)
def H(x):return 1+x+x*x/(2*(1-x/3))
first=F(5170)+R+20*W+6*(H(F(5,16))-1)+F(8,3)*e
final=F(9023,2)+R+F(4,3)*eta+F(15,2)*(H(F(7,32))-1)+F(8,3)*e
ck(first<F(10345,2));ck(final<F(9027,2))
ck(sum(F(5,16)**j/factorial(j) for j in range(20))<H(F(5,16)))
ck(sum(F(7,32)**j/factorial(j) for j in range(20))<H(F(7,32)))
ck(265800<516**2)
ck(F(10345,2)+517+1+F(1,2**80)<5691)
ck(F(9027,2)+517+1+F(1,2**80)<5032)
ck(2**12<5032<5691<2**13)
profiles={'uniform100':[100]*20,
 'root_linear':[100,100,98,97,96,95,94,93,92,91,90,89,88,87,86,85,84,83,82,81],
 'fixed15442':[100,100,100,100,97,95,95,95,89,87,87,87,81,79,79,79,71,71,71,71]}
cases=[]
for band in ('first_four','final'):
 Z=[F(5170)+R+W if band=='first_four' else F(9023,2)+R+eta]
 for j in range(1,20):
  Z.append(6*F(5,4)**j/factorial(j)+min(4**j*W,flat) if band=='first_four' else F(15,2)*F(7,8)**j/factorial(j)+eta)
 for name,grids in profiles.items():
  ck(len(grids)==20 and min(grids)>=70 and grids[0]==100)
  E=[F(3,4*2**b) for b in grids]
  A=Z[19]+E[19]
  for j in range(18,-1,-1):A=Z[j]+E[j]+A/4+E[j]
  expanded=sum(Z[j]/4**j for j in range(20))+sum((1 if j==19 else 2)*E[j]/4**j for j in range(20))
  ck(A==expanded)
  ck(A<(first if band=='first_four' else final))
  ck(sum((1 if j==19 else 2)*E[j]/4**j for j in range(20))<F(8,3)*eta)
  cases.append({'band':band,'profile':name,'polynomial_cap':[10345,2] if band=='first_four' else [9027,2]})
for V in (5691,5032):
 for f in (F(1),F(3,2),F(2),F(31,4),F(77,8)):
  def cl(x):
   k=0
   while 2**k<x:k+=1
   return k
  ck(14+cl(f)-cl(V*f) in (1,2))
result={'checks':checks,'sources':PINS,'uniform_V':5691,'final_band_V':5032,
 'first_rational_upper':[first.numerator,first.denominator],
 'final_rational_upper':[final.numerator,final.denominator],
 'cases':cases,'source_values_or_inventory_read':False}
raw=(json.dumps(result,indent=2)+'\n').encode()
with (HERE/'full_p20_input_magnitude_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps({'checks':checks,'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest().upper()}))
