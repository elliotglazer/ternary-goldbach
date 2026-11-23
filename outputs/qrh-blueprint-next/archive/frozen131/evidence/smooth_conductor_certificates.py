"""Exact rational certificates for the smooth-conductor research note."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial,isqrt
import csv,json
R=Path('work/qrh-campaign/agents/zero-sum')
def exp_bounds(x,N=80):
 upper=sum((-x)**k/F(factorial(k)) for k in range(N+1))
 return upper-x**(N+1)/factorial(N+1),upper
def power_lower(x):
 lo=0;hi=5000
 while hi-lo>1:
  m=(lo+hi)//2
  if F(m,1000)**8<=x**7:lo=m
  else:hi=m
 return F(lo,1000)
g=F(0)
for j in range(16):
 a=F(j,4);b=F(j+1,4)
 al,_=exp_bounds(a*a/2);_,bu=exp_bounds(b*b/2)
 assert al>bu
 g+=power_lower(a)*(al-bu)
assert F(273,500)**8>F(1,128)
A=4*(1-F(273,500))**2/F(7,8)**2
flow=A*g-2*F(22,7)**2*F(17,125)**2*F(135,64)
assert flow>F(2,5)
assert 10**25*F(74,100000)**8<1
rows=list(csv.DictReader((R/'base_gap_smooth_conductors.csv').open()))
output=[]
for q in [90090,120120,180180,240240]:
 rr=[r for r in rows if int(r['q'])==q];ph={90090:17280,120120:23040,180180:34560,240240:46080}[q]
 m=F(0)
 for r in rr:
  c=int(r['c']);n=int(r['primitive']);k=0
  assert int(r['even'])==int(r['odd'])
  while F(11,4)**(k+1)<c:k+=1
  m+=F(n*isqrt(c),ph)*(F(k,2)-F(273,2000))
 cost=m*F(74,100000)*F(9,32)
 if q in [180180,240240]:assert cost>F(1,10)
 output.append(dict(q=q,delta_0136_is_in_gap=(q in [180180,240240]),mass_prescribed_lower=str(m),pair_envelope_cost_lower=str(cost),cost_decimal_diagnostic=float(cost)))
result=dict(status='rational checks pass; analytic derivation documented separately',G_lower_decimal_diagnostic=float(g),F_lower_decimal_diagnostic=float(flow),rows=output)
(R/'smooth_conductor_certificates.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps(result,indent=2))
