"""Rational constants for the analytic Jensen count; no zeta or Lean execution.

Reuses the separately frozen spectral-leaf scalar checker, which has no writes.
"""
import contextlib
import io
with contextlib.redirect_stdout(io.StringIO()):
    from resume_psi_spectral_leaf_20261111 import Q, elo, eup, pl, pu, logs, cl, cu

assert eup(Q(2,9))<Q(19,15)  # log(19/15)>2/9
assert elo(4)>48             # log48<4
assert 18+Q(13,8)<20
# For t>=1500, |s|/(|s-1|)<2, and |s|/Re(s)<=10t+39.
assert Q(1500)+Q('3.9') < 2*(Q(1500)-Q('1.9'))
assert 41 < 2*1500
# Gamma error (1/3 +3/(16t))/pi <1/8.
assert (Q(1,3)+Q(3,16*1500))/3<Q(1,8)

# Power-series coefficients after clearing the Binet kernel inequalities.
# Lower numerator: (t-2)exp(t)+t+2, n>=3 coefficient (n-2)/n!.
# Upper numerator: (t^2-6t+12)exp(t)-t^2-6t-12,
# n>=5 coefficient (n-3)(n-4)/n!.
# These symbolic formulas establish positivity for all later indices;
# the finite checks below only verify cancellations at small indices.
from math import factorial
for n in range(3):
    coeff= -Q(2,factorial(n)) + (Q(1,factorial(n-1)) if n>=1 else 0)
    coeff += 2 if n==0 else (1 if n==1 else 0)
    assert coeff==0
for n in range(5):
    coeff=Q(12,factorial(n))
    if n>=1: coeff-=Q(6,factorial(n-1))
    if n>=2: coeff+=Q(1,factorial(n-2))
    coeff-=12 if n==0 else (6 if n==1 else (1 if n==2 else 0))
    assert coeff==0

a=1500
al,au=map(Q,logs[a]); tl,tu=map(Q,logs[10**6])
main=((tu-cl)**2-(al-cu)**2)/(4*pl)+(au-cl-1)/(2*pl)+Q(7,8*a)
paired=1+eup(Q('.035'))
def moment(A,B):
    return paired*(2+main+(Q(A)*(au+1)+Q(B))/a)

for A,B,cap in [(4,10,'23.965'),(5,10,'23.976'),(6,10,'23.987'),
                (7,10,'23.999'),(5,20,'23.990')]:
    v=moment(A,B); assert v<Q(cap)<24
    scale=10**12
    print('A,B=',A,B,'W upper=',Q((v.numerator*scale+v.denominator-1)//v.denominator,scale))
# The chosen A=5,B=20 has ample margin in the direct coefficient criterion.
assert 5*(au+1)+20<Q('61.567')
# Stronger exact sufficient criterion, avoiding a numerical logarithmic optimum:
assert paired*(2+main+Q('69.5')/a)<24
print('PASS: analytic count constants and conditional moment, not a formal theorem or finite zero data.')
