"""Independent exact scalars for the proposed local-disk lower bound.

This proves no Jensen, Harnack, zero-removal, or L-function theorem.
"""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
PRODUCER=HERE.parent/'audit'
PINS={
    'TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md':'a8d21679e5bf2c631d7399d73a70e85e3486ebc6a92cc1668c5060e77e2e11c9',
    'turing_horizontal_lower_scalars_20261111.py':'5fd8cc03ca21be2028a6a68b6cb4021c71f13cee49a802533e7fc95b16fcdecb',
    'turing_horizontal_lower_scalars_20261111.json':'26e1e25dcc53f6d303622fd196cfe2422846559814c49a7cfaba1cfd07dc0b51',
}
digest=lambda path:hashlib.sha256(path.read_bytes()).hexdigest()
assert all(digest(PRODUCER/name)==pin for name,pin in PINS.items())

R, r, path_radius = F(7,5), F(6,5), F(1)
center_re, min_t = F(3,2), F(50)
minimum_re = center_re-R
growth_factor = F(3,2)/minimum_re*(1+(center_re+R)/min_t)
factor_denominator_ratio = (R*R+r*path_radius)/R
author_factor_ratio=R+1
harnack_factor = (r+path_radius)/(r-path_radius)
log_ratio_lower = (R/r-1)/(R/r)
assert minimum_re == F(1,10)
assert growth_factor == F(1587,100) < 16
assert harnack_factor == 11
assert log_ratio_lower == F(1,7)
assert factor_denominator_ratio == F(79,35) < F(5,2)
assert factor_denominator_ratio < author_factor_ratio == F(12,5) < F(5,2)

def exp_polynomial(x,degree):
    term=F(1)
    total=term
    for j in range(1,degree+1):
        term*=x/j
        total+=term
    return total

exp_one = exp_polynomial(F(1),2)
exp_six = exp_polynomial(F(6),8)
assert exp_one == F(5,2)
assert exp_six > 96*F(22,7)
assert exp_polynomial(F(1),5) > F(27,10)
assert F(27,10)**6 > 96*F(22,7)
zero_count_factor=1/log_ratio_lower
separate_budget_factor=harnack_factor+3*zero_count_factor
assert separate_budget_factor==32
# Joint center budget U=h0+sum log(R/|alpha|)>=h0+N/7.
compact_factor=max(harnack_factor,3*zero_count_factor)
assert compact_factor==21
assert compact_factor-harnack_factor==10
assert compact_factor*log_ratio_lower-3==0
raw_lower_intercept=compact_factor*6+F(148,125)
assert raw_lower_intercept == F(15898,125) < 128

upper=(F(1717,500),F(3,4))
lower=(F(128),F(21))
common=tuple(a+b for a,b in zip(upper,lower))
assert common==(F(65717,500),F(87,4))
# Both estimates are written in variables [1,Z2,d=Z2-Z1>=0].
positive=(common[0],common[1],-lower[1])
negative=(common[0],common[1],-upper[1])
base=(*common,F(0))
slack_plus=tuple(a-b for a,b in zip(base,positive))
slack_minus=tuple(a-b for a,b in zip(base,negative))
assert slack_plus == (0,0,21)
assert slack_minus == (0,0,F(3,4))
target=(F(42),F(693,100))
margins=tuple(a*F(157,50)-b for a,b in zip(target,common))
assert margins==(F(223,500),F(51,5000))
assert all(m>0 for m in margins)

receipt={
    'status':'PASS_INDEPENDENT_EXACT_SCALARS_ONLY',
    'producer_pins':PINS,
    'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'R':str(R),'r':str(r),'minimum_real_part':str(minimum_re),
    'growth_factor_before_rounding':str(growth_factor),
    'harnack_factor':str(harnack_factor),
    'log_R_over_r_strict_lower':str(log_ratio_lower),
    'factor_denominator_ratio':str(factor_denominator_ratio),
    'author_factor_denominator_ratio':str(author_factor_ratio),
    'exp1_degree2_lower':str(exp_one),'exp6_degree8_lower':str(exp_six),
    'exp6_vs_96pi_rational_margin':str(exp_six-96*F(22,7)),
    'compact_coefficient':str(compact_factor),
    'joint_budget_coefficient_slacks':['10','0'],
    'raw_lower_intercept':str(raw_lower_intercept),
    'lower_intercept_rounding_slack':str(128-raw_lower_intercept),
    'common_difference_coefficients':list(map(str,common)),
    'common_minus_positive_difference':list(map(str,slack_plus)),
    'common_minus_negative_difference':list(map(str,slack_minus)),
    'Turing_coefficients':list(map(str,target)),
    'Turing_rounding_margins_at_pi_lower':list(map(str,margins)),
    'scope':'Rational checks only; analytic disk argument and canonical Littlewood identity are separate.',
}
assert all(digest(PRODUCER/name)==pin for name,pin in PINS.items())
Path(__file__).with_suffix('.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
