"""Exact rational receipts for the K=1-to-K=0 paper reduction.

This does not prove Gabcke's contour identity or the analytic inequalities.
No special-function evaluations or numerical acceptance decisions are used.
"""
from fractions import Fraction as F

w = F(17, 36)
# 1/(sqrt(2)*pi) < 250/1099, from sqrt(2)>7/5 and pi>157/50.
y2 = F(250, 1099) * (F(3, 2)/w + F(5, 6)/w**2 + F(1, 9)/w**3)
y3 = F(100, 157) * (F(3, 2) + F(5, 3) + F(4, 9))
assert y2 < F(182, 100)
assert y3 < F(231, 100)
assert F(8, 3)**20 > 300_000_000
# t0=1500, theta=1/4; discard denominators greater than one.
assert F(9, 4) + F(25, 12)*100 + F(7, 36)*100**2 < 2200
assert F(9, 4) + F(25, 12)*1500 + F(7, 36)*1500**2 < 450000
y1 = F(22000, 300_000_000)
y4 = F(39*450000, 2**40)
assert y1 < F(1, 1000) and y4 < F(1, 1000)
assert y1 + y2 + y3 + y4 < F(42, 10)
assert F(1, 16) > F(14, 1500)
assert 1500 > F(7, 1)/F(44, 100)

# Published phase expansion, after division by tau^2 and tau<=1/40.
phase = F(1, 6) + F(28, 45)/40**4 + F(3968, 315)/40**8 + F(8**7, 3322)/40**12
assert phase < F(1, 5)
assert F(1, 5)*(1 + F(8, 5)/40) < F(21, 100)

r = F(198, 125)  # upper bound for (2*pi)^(1/4)
assert r**4 > F(44, 7)
assert 38**2 < 1500
coefficient = r**3/(3*F(157, 50)) + r*F(441, 100)/(8*38)
assert coefficient < F(45, 100) < F(47, 100)
print('Y2 upper:', y2, float(y2))
print('Y3 upper:', y3, float(y3))
print('RS1/tau^2 upper:', y1+y2+y3+y4, float(y1+y2+y3+y4))
print('phase/tau^2 upper:', phase, float(phase))
print('K0 coefficient upper:', coefficient, float(coefficient))
print('PASS: conditional scalar reduction only; analytic source lemmas remain to prove.')
