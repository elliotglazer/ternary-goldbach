"""Exact scalar checks for an elementary Turing upper-bound alternative."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import hashlib
import json

checks = {
    'norm_factor_square': F(1001, 1000)**2 > 1 + F(1, 1600),
    'L_factor': F(3, 2)*2*F(1001, 1000) == F(3003, 1000),
    'pi_factor_lt_19': F(6006, 1000)*F(22, 7) < 19,
    'exp3_gt_19': sum((F(3)**j / factorial(j) for j in range(7)), F(0)) > 19,
    'Z_positive': 2*50 > 2*F(22, 7),
    'upper_intercept': F(3, 4)*3 + F(148, 125) == F(1717, 500),
    'difference_intercept': F(1717, 500)+F(34507, 10000) == F(68847, 10000),
    'difference_slope': F(3, 4)+F(6, 25) == F(99, 100),
    'Turing_intercept_round': F(11, 5)*F(157, 50) > F(68847, 10000),
    'Turing_slope_round': F(8, 25)*F(157, 50) > F(99, 100),
    'allowance_delta_intercept': F(11, 5)-F(18397, 10000) == F(3603, 10000),
    'allowance_delta_slope': F(8, 25)-F(621, 5000) == F(979, 5000),
}
assert all(checks.values())
receipt = {
    'status': 'PASS_EXACT_SCALARS_ONLY',
    'checks': checks,
    'upper_bound': '1717/500 + (3/4)*log(Q*t/(2*pi))',
    'conditional_Turing_bound': '11/5 + (8/25)*log(Q*t2/(2*pi))',
    'conditions': 'Turing consequence still requires lower horizontal bound and Littlewood identity; no Lean proof.',
    'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
}
Path(__file__).with_suffix('.json').write_text(json.dumps(receipt, indent=2)+'\n',encoding='utf-8')
print(json.dumps(receipt, indent=2))
