"""Exact source-envelope metadata; no Hurwitz or coefficient evaluations."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
pins={
 'work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
 'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
 'work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md':'E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9',
 'work/qrh-campaign/agents/major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md':'483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716',
}
checks=0
def ck(ok):
 global checks
 checks+=1
 assert ok
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
eta=F(1,2**100); uT=F(1,2**110); R=F(1,2**116)
W=4*eta+330*uT
flat=2**27*(eta/4+330*uT)
H=lambda x:1+x+x*x/(2*(1-x/3))
ck(H(F(5,8))<2 and H(F(7,8))<F(5,2))
ck(flat<F(1,2**73))
ck(W<F(1,2**97))
for x in (F(5,8),F(7,8)):
 for degree in range(29):
  ck(sum(x**m/F(factorial(m)) for m in range(degree+1))<=H(x))
for V,D,N in ((500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720)):
 ck(F(V+32,D)<F(5,4))
ck(F(7032,4096)<F(7,4))

def strict_binary_cap(x):
 e=0
 while F(2)**e<=x:e+=1
 while F(2)**(e-1)>x:e-=1
 ck(x<F(2)**e and x>=F(2)**(e-1))
 return e

cohorts={}
for name in ('first_four','final'):
 Z=[]; rows=[]
 for k in range(20):
  if name=='first_four':
   error=min(4**k*W,flat)
   ideal=F(3*1720+10)+R if k==0 else 6*F(5,4)**k/factorial(k)
  else:
   error=eta
   ideal=F(4507)+F(9,2)+R if k==0 else F(15,2)*F(7,8)**k/factorial(k)
  z=ideal+error;Z.append(z)
  if k:ck(z+F(3,4)*F(2)**-70<8)
  rows.append(dict(degree=k,ideal_finite_polynomial_bound=str(ideal),
   numerical_coefficient_error_bound=str(error),stored_center_norm_bound=str(z),
   stored_center_strict_power_of_two=strict_binary_cap(z)))
 # A uniform envelope valid for every direct-conversion profile with bj>=70.
 e=F(3,4)*F(2)**-70
 states=[F(0)]*20
 states[19]=Z[19]+e
 for j in range(18,-1,-1):states[j]=Z[j]+2*e+states[j+1]/4
 for j in range(20):
  rows[j]['state_envelope_all_grids_at_least70']=str(states[j])
  rows[j]['state_strict_power_of_two']=strict_binary_cap(states[j])
  ck(states[j]<(8192 if j==0 else (16 if name=='first_four' else 8)))
  if j<19:
   rounded_product=states[j+1]/4+e
   rows[j]['product_output_envelope_all_grids_at_least70']=str(rounded_product)
   rows[j]['product_output_strict_power_of_two']=strict_binary_cap(rounded_product)
 cohorts[name]=rows
out=dict(status='PASS_STORED_FINITE_JET_AND_RECURSIVE_MAGNITUDE_ENVELOPES',checks=checks,
 pins=pins,weighted_numeric_error=str(W),flat_numeric_error=str(flat),
 finite_factorial_majorants=dict(first=str(H(F(5,8))),final=str(H(F(7,8)))),
 cohorts=cohorts,
 scope='Rational envelope metadata only; no coefficient arrays, functions, costs, values or builds.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps(dict(status=out['status'],checks=checks,
 first_state_powers=[r['state_strict_power_of_two'] for r in cohorts['first_four']],
 final_state_powers=[r['state_strict_power_of_two'] for r in cohorts['final']])))
