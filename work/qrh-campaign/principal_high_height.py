"""Exact rational checks for the high-height principal quartet estimate.

These verify arithmetic only. The contour estimate and analytic reductions
are paper derivations, not Lean-checked statements.
"""
from fractions import Fraction as F
from math import factorial
import json

theta = F(17, 100)
c = F(94, 100)
b = 8 * F(22, 7) * theta
assert 1 - (2 * theta) ** 2 / 2 >= c
assert b * b / (2 * c) < 10
assert F(259, 100) ** 2 > 2 * F(22, 7) / c

# Taylor series and a geometric bound on its positive tail.
n = 80
partial_exp10 = sum((F(10) ** j / factorial(j) for j in range(n)), F(0))
tail_exp10 = (F(10) ** n / factorial(n)) / (1 - F(10, n + 1))
assert partial_exp10 + tail_exp10 < 22027
assert sum((F(85, 4) ** j / factorial(j) for j in range(100)), F(0)) > 1690000000

u = 22027 * F(259, 100)
r = 1 / c + b * u / c
assert u <= r
assert F(301, 100) * r < 800000
assert F(13565, 1000) ** 2 > 184
assert F(2829, 1000) ** 2 > 8

# sqrt(8)/3 < .943; x >= 10000 implies x^(-3/4) <= .001.
factor = F(943, 1000) * F(1001, 1000)
t = F(250)
moderate = factor * (t*t + F(225, 64)) * (4 * F(13565, 1000) / (t*t) + F(800000, 1690000000))
assert moderate < 80

# For t >= 400 use cutoff 200. At 400, .17*(400-200)=34>21.25.
# Both (t^2+a)*exp(-k*t) terms decrease in the ranges used.
assert 2 * 250 < F(85, 1000) * (250**2 + F(225, 64))
assert 2 * 400 < F(17, 100) * (400**2 + F(225, 64))
high = factor * (400**2 + F(225, 64)) * F(800000, 1690000000)
assert high < 80

print(json.dumps({
    "status": "rational arithmetic verified; analytic implications not Lean-checked",
    "contour_coefficient_upper": float(F(301, 100) * r),
    "ratio_upper_250_to_400": float(moderate),
    "ratio_upper_from_400": float(high),
    "claimed_safe_ratio": 80,
}, indent=2))
