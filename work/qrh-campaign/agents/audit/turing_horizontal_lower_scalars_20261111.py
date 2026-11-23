"""Exact arithmetic for the local-disk lower plan; no analytic or Lean proof."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

checks = {}
def check(name, proposition):
    assert proposition, name
    checks[name] = True

R, r = F(7, 5), F(6, 5)
check('outer_left_real', F(3, 2)-R == F(1, 10))
check('inner_radius_gt_segment_radius', r > 1)
check('outer_radius_gt_inner', R > r)
check('growth_coefficient', F(3, 2)*10*(1+F(29, 10)/50) == F(1587, 100))
check('growth_below_16', F(1587, 100) < 16)
check('log_radius_ratio_integral_lower', (R/r-1)/(R/r) == F(1, 7))
check('harnack_ratio', (r+1)/(r-1) == 11)
exp1_lower = sum((F(1, factorial(k)) for k in range(6)), F(0))
check('exp1_above_27_over_10', exp1_lower > F(27, 10))
check('exp1_above_R_plus_1', exp1_lower > R+1)
check('log_96pi_lt6', F(27, 10)**6 > 96*F(22, 7))
check('common_budget_harmonic_coefficient', 11 <= 21)
check('common_budget_zero_coefficient', 3 == 21*F(1, 7))
intercept = 21*6+F(148, 125)
check('lower_intercept', intercept == F(15898, 125))
check('lower_intercept_below128', intercept < 128)
upper = F(1717, 500)
check('upper_intercept', upper == F(3434, 1000))
check('final_turing_intercept', 128+upper < 42*F(157, 50))
check('final_turing_slope', 21+F(3, 4) < F(693, 100)*F(157, 50))
historical = F(18, 10000)+F(12183, 10000)+F(148, 100)*(F(11, 10000)+F(1506, 1000))
check('historical_intercept', historical == F(215663, 62500))
check('historical_rounding', historical < F(34507, 10000))
check('historical_slope', (F(148, 100)-1)/2 == F(24, 100))
out = {
    'status': 'exact rational scalar checks passed; analytic proof not kernel checked',
    'checks': checks,
    'count': len(checks),
    'disk_lower_intercept_exact': str(intercept),
    'disk_lower_slope': '21',
    'rounded_lower': 'I(t) > -128 - 21*log(Q*t/(2*pi))',
    'conditional_turing': '|integral S| < 42 + (693/100)*log(Q*t2/(2*pi))',
    'historical_intercept_exact': str(historical),
    'historical_analytic_leaves_certified_here': False,
    'lean_validation': False,
}
path = Path(__file__).with_suffix('.json')
path.write_text(json.dumps(out, indent=2)+'\n', encoding='utf-8')
print(json.dumps(out, indent=2))
