"""Exact rational checks for the A-only source comparison; no value evaluator."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
from math import isqrt
import json

here=Path(__file__).resolve().parent
root=here.parents[3]
paths=[
'work/qrh-campaign/agents/major-constants/PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md',
'work/qrh-campaign/agents/audit/REVIEW_PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md',
'work/qrh-campaign/agents/audit/ETA_U_PRIME_COEFFICIENT_ENERGY_2026-11-11.md',
'work/qrh-campaign/agents/mellin/PointwiseSmoothingTail.md',
'work/qrh-campaign/agents/audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md',
'work/qrh-campaign/agents/independent-feasibility/MODULUS_WEIGHTED_PLUS_STAR_RESEARCH_2026-11-11.md',
'work/ternary-goldbach/TernaryGoldbach/MinorArcs/LargeSieveProof.lean',
'work/ternary-goldbach/TernaryGoldbach/MinorArcs/LargeSieveWeights.lean',
'work/ternary-goldbach/TernaryGoldbach/MinorArcs/LSQuot1.lean',
'work/ternary-goldbach/TernaryGoldbach/MinorArcs/Bombieri.lean',
'work/ternary-goldbach/TernaryGoldbach/MajorArcs/EtaCirc.lean',
'work/ternary-goldbach/TernaryGoldbach/MajorArcs/MajorTotal.lean',
]
pins={p:sha256((root/p).read_bytes()).hexdigest().upper() for p in paths}
checks={}
def check(name,v):
    assert v,name
    checks[name]=True

# Exact integration on [-1,1] of (1-u^2)^3 (1-u^2/2).
poly=[F(1),F(-7,2),F(9,2),F(-5,2),F(1,2)]
integral=sum(2*a/F(2*k+1) for k,a in enumerate(poly))
check('polynomial_integral',integral==F(272,315))
pmin=integral-F('0.00221')
check('actual_P0_lower',pmin>F('.86'))
check('q3_q6_weight',2*F(3,2**3)==F(3,4))
check('coefficient_ratio',F(3,4)/3==F(1,4))
coeff=F(3,2)*F('.86')**2
check('liminf_C_log',coeff==F('1.1094'))
epr=F('1.502e-6')
check('principal_amplitude', (F('1.415')-epr)**2>2)
Lmax=F('.640208')*F(32,13)*F('1.415')**2
check('principal_subtraction_upper',Lmax<F('3.156'))
floor=49*coeff*(1-F('.000468'))*F(49,64)-Lmax
check('comparison_floor_gt_38',floor>38)
check('new_target_smaller',F('1e-10')<38)
threshold=F(1915)*F(21,4)**2/F('1e-10')
k=isqrt(threshold.numerator//threshold.denominator)
check('C_square_threshold',F(k*k)<=threshold<F((k+1)**2))
check('beyond_conductor_domain',k>132900)
splits={str(c):str(F(1915)*F(21,4*c)**2) for c in [10000,50000,100000,132899]}
for c,v in splits.items(): check('tail_bound_above_target_'+c,F(v)>F('1e-10'))
check('q3_required_L2',F('1e-10')/F(3,8)==F(1,3750000000))
out=dict(status='PASS_EXACT_A_ONLY_COMPARISON',checks=checks,pins=pins,
         P0_lower=str(pmin),coefficient_lower=str(coeff),principal_upper=str(Lmax),
         comparison_lower=str(floor),split_upper_comparisons=splits,
         first_integer_C_passing_scalar_tail=k+1,
         scope='Upper-comparison obstruction and conditional split inequalities; no actual A lower bound.')
dest=here/'star_a_only_scalars_20261111.json'
with dest.open('x',encoding='utf-8') as f: json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':len(checks),'comparison_lower':str(floor),'C_min':k+1,
                  'receipt_sha256':sha256(dest.read_bytes()).hexdigest().upper()}))
