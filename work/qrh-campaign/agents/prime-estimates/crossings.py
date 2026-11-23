import math

# Diagnostic crossings for an assumed C*x^(7/8)*log(x)^2 error.
# These computations do not establish that error estimate.
def crossing(coefficient, target, exponent):
    lo, hi = 40.0, 400.0
    for _ in range(100):
        mid = (lo + hi) / 2
        if coefficient * math.exp(-mid / 8) * mid**exponent > target:
            lo = mid
        else:
            hi = mid
    return hi, hi / math.log(10)

for coefficient in [1, 10, 100, 1000]:
    print(coefficient, crossing(coefficient, .00985, 3), crossing(coefficient, 1, 5))
