"""Fixed rational/syntax checks only; no inventories or analytic values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
BLUEPRINT = AGENTS.parent.parent / 'qrh-blueprint'
PINS = {
 'integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md':'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C',
 'audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md':'96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D',
 'audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md':'6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA',
 'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
 'major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
 'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md':'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
 'independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md':'412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7',
 'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md':'09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
 'major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md':'1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A',
 'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md':'15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2',
}
checks = 0
def ck(value):
 global checks
 checks += 1
 if not value: raise AssertionError(checks)
for name, digest in PINS.items():
 ck(hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper()==digest)
root_name = 'LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md'
root_hash = 'EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39'
ck(hashlib.sha256((BLUEPRINT/root_name).read_bytes()).hexdigest().upper()==root_hash)
V = 2**14
Sg = 202305920
Cg = 1266*Sg*V
Dg = 29961461170177
Sold = 424706204
allowance = F(Cg,2**108)
T = F(927193523,10**9*2**46)
fixed = T + 135*(F(1,2**82)+F(4,2**63)) + F(10,2**54) + F(93,2**55) + F(1,2**51)
ratio = (fixed+135*allowance)*2**45
ck(Cg==4196258524692480)
ck(ratio==F(2804840254168152529,4294967296000000000))
ck(ratio<F(691,1024))
ck(8192+633+1==8826)
ck(8826+1+1==8828 and 8828<V)
ck(Dg<2**45 and 2*Sold<2**30 and 2**45<2**80)
ck(F(1,2)+F(1,2)==1)  # two coordinate squared errors <= u^2/2
ck(F(1,2)<1)
rows=[]
for p in range(80,109):
 u=F(1,2**p)
 rho=int(p<100)
 ck(2**p>=Dg and 2**p>=2*Sold)
 ck(F(8827)+u<V)
 # This worst-case magnitude bootstrap does not claim selector admission.
 eps=F(Cg+633*rho,2**p)
 rL=eps+F(1,2**82)+F(4,2**63)
 rY=27*rL+F(2,2**54)+F(2,2**55)
 ck(rL<1 and rY<1)
 ck(516*4033<2**21 and 4033<2**12)
 if p<100:
  d=100-p
  ck(1<=d<=20)
  ck((2**114-1)+2**(d-1)<2**115)
  ck((2**(p+14)-1)*2**d+(2**d-1)<2**115)
  # Signed synthetic nearest-rounding cases, not source coordinates.
  for z in (-(2**d)-1,-(2**d),-2**(d-1),-1,0,1,2**(d-1),2**d-1,2**d+1):
   q=(z+2**(d-1))//2**d
   t=z+2**(d-1)-q*2**d
   ck(0<=t<2**d and -2**d<=2*(z-q*2**d)<2**d)
 else:
  ck(0<=p-100<=8)
 rows.append({'p':p,'regrid_indicator':rho,'data_magnitude_bits_at_input':p+14})
# Pure conditional examples, not assignments to a conductor or plan.
for p,s in ((82,2),(84,12),(90,771)):
 ck(F(633*(2*s*V+1),2**p)<=allowance)
# Piecewise selector is the former selector when p>=100; cancel (2V)^2.
ck(Cg==2*V*(633*Sg))
ck((1266*Sg*V)**2==(2*V)**2*(633*Sg)**2)
# No-regrid p108 fallback follows from phi^2 <= c*633^2.
ck(265800<633**2 and Sg>0)
result={
 'scope':'fixed rational/synthetic signed-integer checks only; no metadata scan',
 'checks':checks,
 'sources':PINS,
 'blueprint_source':{'path':root_name,'sha256':root_hash},
 'candidate_range':[80,108],
 'V':V,'source_center_bound':8826,'regridded_augmented_bound':8828,
 'C_global':Cg,'R108_over_2^-45':[ratio.numerator,ratio.denominator],
 'cases':rows,
 'source_or_sign_values_evaluated':False,
}
raw=(json.dumps(result,indent=2)+'\n').encode()
if len(raw)>65536: raise AssertionError('receipt cap')
out=HERE/'subgrid100_transform_input_regrid_20261111.json'
with out.open('xb') as handle: handle.write(raw)
print(json.dumps({'checks':checks,'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest().upper()}))
