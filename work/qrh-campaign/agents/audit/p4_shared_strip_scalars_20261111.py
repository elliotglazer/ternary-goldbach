"""Exact scalar checks for the root's P4 shared-strip paper reduction.

No analytic functions are evaluated and no spectral data is read.
"""
from fractions import Fraction as F
from math import factorial
import json


def exp_lower(x, n):
    return sum((x**k / factorial(k) for k in range(n + 1)), F(0))


def exp_upper_small(x):
    assert 0 <= x < 1
    return 1 + x + x*x / (2 * (1 - x/3))


checks = {}
def check(name, condition):
    assert condition, name
    checks[name] = True


check('e_upper_11_over_4', sum((F(1, factorial(k)) for k in range(6)), F(0)) + F(1, factorial(6)) / (1-F(1, 7)) < F(11, 4))
check('e_lower_27_over_10', exp_lower(F(1), 5) > F(27, 10))
check('log_1500_lt_8', F(27, 10)**8 > 1500)
check('log_million_lt_14', F(27, 10)**14 > 10**6)
check('log_height_ratio_lt_7', F(27, 10)**7 > F(10**6, 1500))
check('count_1500_lt_1600', F(1500, 6)*(8-1-1)+F(7, 8)+5*8+20 < 1600)
check('count_uniform_slope', F(7, 8)+5*14+20 < F(1500, 12))
check('kernel_ratio_lt_5_over_4', F(8, 9)+F(15, 8)/F(239, 100)**2 < F(5, 4))
check('low_reciprocal_lt_17', F(7, 100)*3200*F(5, 4) < 17**2)
check('high_reciprocal_lt_100_over_3', 2*F(25, 12)*(1+7) == F(100, 3))
check('total_reciprocal_lt_151_over_3', 17+F(100, 3) == F(151, 3))
check('weight_exponent_lt_2', 35*(F(111, 200)-F(1, 2)) < 2)
check('weighted_moment_lt_381', F(151, 3)*F(121, 16) < 381)

L0 = F(2233, 100)
a = F(1, 500)/L0
delta_sq = F(1, 500)**2/(L0**2*(L0+10))
lower_endpoint_exponent = F(89, 200)*(L0-7)
check('lower_endpoint_lt_1_over_900', exp_lower(lower_endpoint_exponent, 32) > 900)
endpoint_upper = exp_upper_small(delta_sq/2) * (exp_upper_small(F(111, 200)*a)+F(1, 900))
check('endpoint_factor_lt_1_002', endpoint_upper < F(501, 500))
check('sqrt_5e9_gt_70700', 70700**2 < 5*10**9)
check('low_error_lt_0_0054', F(501, 500)*381/F(70700) < F(27, 5000))
other_scaled = F('0.00016')+F('0.002001')+F('0.000009')+F('0.000018')+F('0.000000002')+F('0.000000000001')
check('other_error_lt_0_0001', other_scaled / 22 < F(1, 10000))
check('final_error_lt_0_005501', (F(27, 5000)+F(1, 10000))*F('1.000001') < F('0.005501'))
check('p4_margin', F('0.005501') < F('0.0064'))

print(json.dumps({'scope': 'exact scalar implications only; not analytic or Lean proof', 'checks': checks, 'count': len(checks), 'weighted_moment_upper': str(F(151, 3)*F(121, 16)), 'endpoint_factor_upper': str(endpoint_upper)}, indent=2))
