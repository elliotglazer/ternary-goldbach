"""Independent rational source envelopes; no author imports or coefficient values."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
A=ROOT/'work/qrh-campaign/agents'
author=A/'prime-estimates/stored_hurwitz_degree_bounds_20261111.json'
saved=json.loads(author.read_text())
pins=dict(saved['pins'])
pins.update({
'work/qrh-campaign/agents/prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
'work/qrh-campaign/agents/prime-estimates/stored_hurwitz_degree_bounds_20261111.py':'1F0D78DF0CF364A68DEE066D10CBA66C7B192A9C231AAB55B5B458A80B0BE6F5',
'work/qrh-campaign/agents/prime-estimates/stored_hurwitz_degree_bounds_20261111.json':'E947C32ED8EA30BA14ED64A7DFF83AA1C8E3F3F222AAD1AD8DAA8484013781BE'})
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
eta=Q(1,2**100);u=Q(1,2**110);rem=Q(1,2**116)
weighted=4*eta+330*u;flat=2**27*(eta/4+330*u)
ck(weighted==Q(saved['weighted_numeric_error']))
ck(flat==Q(saved['flat_numeric_error']) and flat<Q(1,2**73))
for j in range(1,32):ck(1+1/(Q(j)-Q(1,2))<=3)
for V,D in ((500,512),(1000,1024),(2000,2048),(5000,4096)):
 ck(Q(V+32,D)<Q(5,4))
ck(Q(7032,4096)<Q(7,4))
seed=10507*Q(1,2**118)+278753*Q(1,2**122)+rem
ck(seed<Q(107,1000)*eta)
ck(2*seed+351*u<Q(557,1000)*eta)
ck(31*159<7936)
ck(Q(156,1)/Q(635,2)*Q(7009,9006)**318<rem)
all_rows={}
for name,alpha,post,P in [('first_four',Q(5,4),Q(1),27),('final',Q(7,4),Q(1,2),28)]:
 xs=alpha/2
 H=1+xs+xs**2/(2*(1-xs/3))
 ck(H==Q(saved['finite_factorial_majorants']['first' if name=='first_four' else 'final']))
 ck(H<(2 if name=='first_four' else Q(5,2)))
 Z=[]
 for k,row in enumerate(saved['cohorts'][name]):
  err=min(4**k*weighted,flat) if name=='first_four' else eta
  if k==0:ideal=(Q(5170) if name=='first_four' else Q(4507)+Q(9,2))+rem
  else:
   ideal=(6*Q(5,4)**k if name=='first_four' else Q(15,2)*Q(7,8)**k)/factorial(k)
   finite=3*(alpha*post)**k/factorial(k)*sum(xs**m/factorial(m) for m in range(P-k))
   ck(finite<ideal)
  ck(ideal==Q(row['ideal_finite_polynomial_bound']))
  ck(err==Q(row['numerical_coefficient_error_bound']))
  Z.append(ideal+err)
  ck(Z[-1]==Q(row['stored_center_norm_bound']))
 e=Q(3,4)*Q(1,2**70)
 result=[]
 for j,row in enumerate(saved['cohorts'][name]):
  # Closed expansion, independent of author's descending recurrence.
  state=sum((Z[k]+e)*Q(1,4)**(k-j) for k in range(j,20))+sum(e*Q(1,4)**(k-j) for k in range(j,19))
  ck(state==Q(row['state_envelope_all_grids_at_least70']))
  q=row['state_strict_power_of_two'];ck(state<Q(2)**q and state>=Q(2)**(q-1))
  zq=row['stored_center_strict_power_of_two'];ck(Z[j]<Q(2)**zq and Z[j]>=Q(2)**(zq-1))
  ck(state<(8192 if j==0 else 16 if name=='first_four' else 8))
  if j:ck(Z[j]+e<8)
  if j<19:
   t=sum((Z[k]+e)*Q(1,4)**(k-j) for k in range(j+1,20))+sum(e*Q(1,4)**(k-j) for k in range(j,19))
   ck(t==Q(row['product_output_envelope_all_grids_at_least70']))
   tq=row['product_output_strict_power_of_two'];ck(t<Q(2)**tq and t>=Q(2)**(tq-1))
  result.append({'degree':j,'state':str(state),'strict_binary_cap':q})
 all_rows[name]=result
out={'checks':checks,'pins':pins,'status':'PASS_SOURCE_AND_EXACT_ENVELOPES',
'scope':'No coefficient/function evaluations, author imports, builds or cost adoption','rows':all_rows}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
