"""Exploratory Mellin moment quadrature plus exact rational coarse checks.

Only the Fraction assertions certify arithmetic inequalities. Simpson quadrature
is ordinary floating-point computation and has no error certificate.
"""
import math
from fractions import Fraction as F


def simpson_moment(sigma, order, intervals=40000):
    left, right = -30.0, 3.0
    step = (right - left) / intervals
    total = 0.0
    for index in range(intervals + 1):
        u = left + index * step
        weight = 1 if index in (0, intervals) else 4 if index % 2 else 2
        total += weight * math.exp((2 * sigma + 2) * u - math.exp(2 * u)) * u ** (2 * order)
    return 3.15 ** 2 * total * step / 3


endpoint_moments = [[simpson_moment(sigma, j) for j in range(3)] for sigma in (1 / 8, 7 / 8)]
vertical_bounds = [2 * math.pi * max(row[j] for row in endpoint_moments) for j in range(3)]
a0, a1, a2 = vertical_bounds
h_bound = math.sqrt(a0 + 1.5 * math.sqrt(a0 * a1))
b_bound = math.sqrt(a1 + 1.5 * math.sqrt(a1 * a2))
print('Exploratory endpoint moment integrals', endpoint_moments)
print('Exploratory vertical bounds', vertical_bounds)
print('Exploratory window coefficient', h_bound / 3.48 + b_bound)

# Exact arithmetic verification once the mathematical bounds in derivation.md
# and the standard inequality pi <= 22/7 are supplied.
assert F(315, 100) * (F(8, 9) + F(384, 633)) < F(472, 100)
coarse = [2 * F(22, 7) * F(315, 100) ** 2 *
          (F(math.factorial(2 * j), 1) / F(9, 4) ** (2 * j + 1)
           + F(math.factorial(j + 1), 2)) for j in range(3)]

# H<=12.55 and B<=16.15 via square comparisons, avoiding floating square roots.
h_upper, b_upper = F(1255, 100), F(1615, 100)
rh = (h_upper ** 2 - coarse[0]) / F(3, 2)
rb = (b_upper ** 2 - coarse[1]) / F(3, 2)
assert rh >= 0 and rh ** 2 >= coarse[0] * coarse[1]
assert rb >= 0 and rb ** 2 >= coarse[1] * coarse[2]
assert h_upper / F(348, 100) + b_upper < F(1976, 100)
print('Exact rational checks passed: pointwise <4.72 and coarse window coefficient <19.76')
