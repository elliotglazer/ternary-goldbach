"""Rational scalar checks only; no zeta, zero data, or function evaluator.

Continuum reduction is proved in the companion note, not by sampling.
"""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import hashlib
import json


def exp_bounds(x, n=100):
    assert 0 <= x < n + 2
    terms = [x**k / factorial(k) for k in range(n + 1)]
    lo = sum(terms, F(0))
    hi = lo + terms[-1] * x / (n + 1) / (1 - x / (n + 2))
    return lo, hi


def log_unit(x, n=50):
    assert 1 <= x <= 2
    z = (x - 1) / (x + 1)
    lo = 2 * sum((z**(2*k+1)/(2*k+1) for k in range(n)), F(0))
    return lo, lo + 2*z**(2*n+1)/((2*n+1)*(1-z*z))


def log_bounds(x):
    x = F(x)
    assert x >= 1
    k = 0
    while x > 2:
        x /= 2
        k += 1
    lo, hi = log_unit(x)
    l2, u2 = log_unit(F(2))
    return lo + k*l2, hi + k*u2


def down(x, digits=15):
    d = 10**digits
    return F((x*d).numerator//(x*d).denominator, d)


def up(x, digits=15):
    return -down(-x, digits)


def logs(x):
    a, b = log_bounds(x)
    return down(a), up(b)


def cosh_upper(x):
    lo, hi = exp_bounds(x)
    return up((hi+1/lo)/2)


# Established elementary bounds on pi, independently bracketed by Machin.
def atan_bounds(x, n=40):
    s = sum(((-1)**k*x**(2*k+1)/(2*k+1) for k in range(n)), F(0))
    t = (-1)**n*x**(2*n+1)/(2*n+1)
    return min(s, s+t), max(s, s+t)

al, au = atan_bounds(F(1,5))
bl, bu = atan_bounds(F(1,239))
pl, pu = F('3.14159265358979'), F('3.14159265358980')
assert pl < 16*al-4*bu < 16*au-4*bl < pu
assert 1/exp_bounds(F(1))[0] < F('.368')
assert 1/(2*exp_bounds(F(1,2))[0]) < F('.304')

L, A, NA = F(2233,100), 1500, 1069
d = F(11,200)
head = F(417,250)+F(NA,A)
a = F(1,500)/L
q = F(1,500)**2/(2*L*L*(L+10))
la, ua = logs(A)
lc, uc = logs(2*pl)[0], logs(2*pu)[1]
lr_lo = logs(500)[0]+logs(L)[0]+logs(L+10)[0]/2
lr_hi = logs(500)[1]+logs(L)[1]+logs(L+10)[1]/2
zlo, zhi = lr_lo-uc, lr_hi-lc
ell_lo, ell_hi = la-uc, ua-lc
gap_lo = (ell_lo-1)/(2*pu)+(5*la+F(167,8)-NA)/A
gap_hi = (ell_hi-1)/(2*pl)+(5*ua+F(167,8)-NA)/A
assert gap_lo > 0
Dhi = gap_hi+(zhi*zhi-ell_lo*ell_lo)/(4*pl)+(F('.368')*zhi+F('.304'))/(2*pl)+F(5,A)
Dlo = gap_lo+(zlo*zlo-ell_hi*ell_hi)/(4*pu)
assert Dlo > 1

# Analytic derivative proof uses only these global coarse comparisons.
assert 500*35*7 < 125000
assert exp_bounds(F(11))[0] > F(125000,6)
assert (F(11)+F('.368'))*F(3,2)/6 < 3
assert 4/L+d < F(1,2)
assert 4/L < 1

eg = up(exp_bounds(q)[1])
ea = up(exp_bounds(a/2)[1])
el2 = down(exp_bounds(L/2)[0])
el = down(exp_bounds(L)[0])
cbig = cosh_upper(d*(L+a))
csmall = cosh_upper(d*7)  # log(1000)<7
assert exp_bounds(F(7))[0] > 1000
assert exp_bounds(L)[1] < 5*10**9
primary = 2*eg*L*ea*(head+cbig*Dhi)/el2
cutoff = 2*eg*L*32*(head+csmall*Dhi)/el
zeros = primary+cutoff
other = F('.002188002001')
total = F('1.000001')*(zeros+other)
assert zeros < F('.0077')
assert total < F('.0096') < F('.01')

out = {
    'scope': 'Exact scalar endpoint check after analytic continuum reduction; conditional spectral inputs, no evaluations',
    'L_interval': ['22.33','35'], 'A': A, 'N_A': NA,
    'head_positive_reciprocal_upper': str(head),
    'log_R_over_2pi_upper': str(up(zhi)),
    'count_boundary_gap_over_A_upper': str(up(gap_hi)),
    'damped_positive_tail_upper': str(up(Dhi)),
    'primary_scaled_zero_upper': str(up(primary)),
    'cutoff_scaled_zero_upper': str(up(cutoff)),
    'total_scaled_zero_upper': str(up(zeros)),
    'other_scaled_allowance': str(other),
    'full_scaled_error_upper': str(up(total)),
    'safe_full_cap': '.0096',
    'margin_below_point01_lower': str(down(F('.01')-total)),
    'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2)+'\n')
print(json.dumps(out, indent=2))
