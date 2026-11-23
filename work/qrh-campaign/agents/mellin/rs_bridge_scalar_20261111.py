"""Exact arithmetic checks for the conditional RS bridge, not an RS proof."""
from fractions import Fraction as Q
from math import factorial

# If the extracted FLINT remainder inequality is proved, t>=1500 and pi<22/7
# give a=sqrt(t/(2*pi))>15. At sigma=1/2, the code uses cbar=4/7.
# Two reflected auxiliary errors suffice since |chi(1/2+it)|=1.
K = 24
e = Q(8, 7) * Q(11, 150) ** (K + 1) * factorial(K // 2)
assert Q(1500 * 7, 44) > 15**2
assert e < Q(1, 10**19)

def coefficients(sigma, nmax):
    rows = [{0: Q(1)}]
    for n in range(1, nmax + 1):
        old, row = rows[-1], {}
        for j in range(3*n//2 + 1):
            m = 3*n - 2*j
            if m:
                row[j] = (old.get(j, Q(0))/2 + (1-2*sigma)*old.get(j-1, Q(0)))/(2*m) - (m+1)*old.get(j-2, Q(0))
        if n % 2 == 0:
            h = 3*n//2
            row[h] = -sum((-1)**(h-r)*row[r]*Q(factorial(2*h-2*r), factorial(h-r)) for r in range(h))
        rows.append(row)
    return rows

d = coefficients(Q(1, 2), 2)
assert d[1] == {0: Q(1,12), 1: Q(0)}
assert d[2] == {0: Q(1,288), 1: Q(0), 2: Q(-1,4), 3: Q(-1,12)}
print('PASS exact conditional K24 error < 1e-19; recurrence checks')
print('conditional_error_rational =', e)
print('conditional_error_float_display =', float(e))
