"""Exact rational checks for the hybrid high-height tail, conditional on source lemmas."""
from fractions import Fraction as F
from math import ceil
import json

def exp_lower(x, degree):
    term = F(1)
    result = term
    for k in range(1, degree + 1):
        term *= x / k
        result += term
    return result

# Gaussian-tail endpoint certificates; only positive Taylor terms are used.
assert exp_lower(F('0.1065') * 32**2, 500) > F('.588') * 32**2 * 10**44
assert exp_lower(F('.1598') * 1000, 600) > F('.892') * 1000 * 10**65
assert exp_lower(F(13), 60) > 300001
assert exp_lower(F(19), 90) > F('1.25') * (10**8 + 22)
assert exp_lower(F(8), 50) > 1400
assert exp_lower(F(2), 30) > F(1, 1) / F('.355')

# log(10/3)>1 follows from e<3<10/3; these are analytic scalar inputs.
log_bp_upper = 8 + 10 * 13 + 19 + 10 * 19 + 2
assert log_bp_upper == 349 < 400
assert F('1.93') * F('4.4') / F(22, 7) > F('2.7')
geom = 1 + F(600001, 1) / F('2.7')
assert 800 * geom + F(106, 1000) * geom**2 < 10**10
assert 1 + 1 / (F('.1398') * F('4.4')) < 3 < geom
tail = 1000 * F(10**10) * (F(1, 10**44) + F(1, 10**65))
assert tail < F(1, 10**30)

# Finite count uses unit-height windows at centers up to 61 million+1.
count = 2 * (61000000 + 1) * 400
assert count < 10**11
assert count * 106000 < 2 * 10**16
assert count * 4 < 10**12

# Very coarse Gauss-weighted mixed measure, including all q<=300000.
measure = 300000 * 1200000 * 300000**2
assert measure < (2 * 10**11)**2
assert (F(2 * 10**16) + 10**12 + F(1, 10**30)) * F(1, 10**30) < F(3, 10**14)
assert F(49 * 10**25) * 10**25 > 10**48  # (x0*y0)^(-1/8)<1e-6
assert 2 * 10**11 * F(3, 10**14) * F(1, 10**6) == F(6, 10**9)
assert F('2.79e-8') * 25 < F('.0008352')**2
assert (F('.0008352') + F('1e-6'))**2 < F('7e-7')

rows = []
for c in [1, 3, 100, 1000, 10000, 149999, 300000]:
    qt = c if c % 2 == 0 else 2 * c
    d = F(1200000, qt)
    hp = ceil(200 + max(F(1000), F(704, 7) * d))
    hs = ceil(max(F(1000), F(704, 343) * d))
    assert hp < 61000000 and hs < 1300000
    rows.append({'conductor': c, 'plus_height': hp, 'star_height': hs})
print(json.dumps({'status': 'PASS_EXACT_ARITHMETIC_ONLY', 'tail_coefficient_upper': str(tail),
                  'mixed_high_height_norm_upper': '6e-9', 'cutoff_examples': rows}, indent=2))
