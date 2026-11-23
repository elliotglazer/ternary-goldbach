"""Independent exact arithmetic and affine-sign checks; no analytic proof claim."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRODUCER = ROOT / 'work/qrh-blueprint/turing-scalars'
pins = {
    'ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md': '0875b2b87a02421b7b8cd6cad0d1c33433a051e240f48ea4c5f45fe04558bd27',
    'elementary_horizontal_upper.py': '9369b77d2e46b5f90e9aeb0fd1641bd9d428c630cf4e1da180bf0c41862fa0fb',
    'elementary_horizontal_upper.json': '0c3ae91cdc3a5d1a100679ac7def6f6e05d242f1468d2093864eb2b28d38ac07',
}
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
assert all(sha(PRODUCER/name) == pin for name,pin in pins.items())
source_receipt = json.loads((PRODUCER/'elementary_horizontal_upper.json').read_text())
assert source_receipt['script_sha256'] == pins['elementary_horizontal_upper.py']
assert all(source_receipt['checks'].values())

# Derive the exponential polynomial by its term recurrence independently.
term = Q(1)
exp_lower = term
for j in range(1,7):
    term *= Q(3,j)
    exp_lower += term
assert exp_lower == Q(1553,80)

length = Q(5,4)-Q(1,2)
sigma_ratio_square = (Q(5,4)/50)**2
norm_ratio = Q(1001,1000)
L_factor = Q(3,2)*2*norm_ratio
upper = (3*length+Q(148,125), length)
lower_magnitude = (Q(34507,10000),Q(6,25))
common = tuple(x+y for x,y in zip(upper,lower_magnitude))
new = (Q(11,5),Q(8,25))
old = (Q(18397,10000),Q(621,5000))
delta = tuple(x-y for x,y in zip(new,old))

# Polynomials are exact coefficient lists [1,Z2,d] with d=Z2-Z1>=0.
positive_difference = (common[0], common[1], -lower_magnitude[1])
negative_difference = (common[0], common[1], -upper[1])
common_poly = (common[0],common[1],Q(0))
positive_slack = tuple(x-y for x,y in zip(common_poly,positive_difference))
negative_slack = tuple(x-y for x,y in zip(common_poly,negative_difference))
assert positive_slack == (0,0,Q(6,25))
assert negative_slack == (0,0,Q(3,4))

margins = {
    'norm_squared_slack': norm_ratio**2-1-sigma_ratio_square,
    'factor_to_19_slack': 19 - 2*L_factor*Q(22,7),
    'Taylor_to_19_slack': exp_lower-19,
    'positive_Z_ratio_slack': 2*50/(2*Q(22,7))-1,
    'Turing_intercept_slack_at_pi_lower': new[0]*Q(157,50)-common[0],
    'Turing_slope_slack_at_pi_lower': new[1]*Q(157,50)-common[1],
}
assert all(x>0 for x in margins.values())
assert upper == (Q(1717,500),Q(3,4))
assert common == (Q(68847,10000),Q(99,100))
assert delta == (Q(3603,10000),Q(979,5000))
two_channel = tuple(2*x for x in delta)
assert two_channel == (Q(3603,5000),Q(979,2500))

receipt = {
    'status': 'PASS_INDEPENDENT_EXACT_SCALARS_AND_AFFINE_SIGNS',
    'producer_pins': pins,
    'script_sha256': sha(Path(__file__)),
    'exp3_degree6': str(exp_lower),
    'compact_length': str(length),
    'L_norm_factor': str(L_factor),
    'upper_coefficients': list(map(str,upper)),
    'common_difference_coefficients': list(map(str,common)),
    'difference_variables': ['1','Z2','d=Z2-Z1>=0'],
    'common_minus_positive_difference': list(map(str,positive_slack)),
    'common_minus_negative_difference': list(map(str,negative_slack)),
    'strict_rational_margins': {k:str(v) for k,v in margins.items()},
    'allowance_delta_coefficients': list(map(str,delta)),
    'surcharge_numerator_coefficients': list(map(str,two_channel)),
    'surcharge_denominator': 'h>0',
    'scope': 'Exact scalars only. Lower horizontal bound, canonical Littlewood identity, analytic adapters, and actual packet saturation remain obligations.',
}
assert all(sha(PRODUCER/name) == pin for name,pin in pins.items())
HERE.joinpath('review_elementary_horizontal_upper_20261111.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
