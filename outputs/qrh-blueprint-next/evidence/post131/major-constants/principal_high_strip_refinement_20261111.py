"""Exact scalar implication from the reviewed RH1500 head and analytic count.

No zero data/evaluator imports. All acceptance comparisons use Fraction.
Only the JSON receipt beside this uniquely named script is written.
"""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import hashlib
import json


def atan_bounds(x, n=45):
    assert 0 < x < 1
    s = sum(((-1)**j*x**(2*j+1)/F(2*j+1) for j in range(n)), F(0))
    next_term = (-1)**n*x**(2*n+1)/F(2*n+1)
    return min(s, s+next_term), max(s, s+next_term)


def log_unit(x, n=65):
    assert 1 <= x <= 2
    z = (x-1)/(x+1)
    low = 2*sum((z**(2*j+1)/F(2*j+1) for j in range(n)), F(0))
    high = low + 2*z**(2*n+1)/(F(2*n+1)*(1-z*z))
    return low, high


log2lo, log2hi = log_unit(F(2))


def log_bounds(x):
    x = F(x)
    assert x >= 1
    k = 0
    while x > 2:
        x /= 2
        k += 1
    lo, hi = log_unit(x)
    return lo+k*log2lo, hi+k*log2hi


def exp_bounds(x, n=35):
    assert 0 <= x < n+2
    terms = [x**j/F(factorial(j)) for j in range(n+1)]
    lo = sum(terms, F(0))
    hi = lo + terms[-1]*x/F(n+1)/(1-x/F(n+2))
    return lo, hi


def down(x, digits=12):
    scale = 10**digits
    return F((x*scale).numerator//(x*scale).denominator, scale)


def up(x, digits=12):
    return -down(-x, digits)


al, au = atan_bounds(F(1,5))
bl, bu = atan_bounds(F(1,239))
pl, pu = 16*al-4*bu, 16*au-4*bl
assert F('3.14159265358979') < pl < pu < F('3.14159265358980')

A, T, NA, QA = 1500, 10**6, 1069, F(417,250)
la, ua = log_bounds(A)
lt, ut = log_bounds(T)
lc, _ = log_bounds(2*pl)
_, uc = log_bounds(2*pu)
assert la-uc-1 > 0 and lt-uc > ua-lc > 0

# B0=F(A)/A+[log(T/(2pi))^2-log(A/(2pi))^2]/(4pi).
b0lo = ((lt-uc)**2-(ua-lc)**2)/(4*pu) + (la-uc-1)/(2*pu) + F(7,8*A)
b0hi = ((ut-lc)**2-(la-uc)**2)/(4*pl) + (ua-lc-1)/(2*pl) + F(7,8*A)

# H=G(T)/T-N(A)/A+integral_A^T G(t)/t^2 dt.
# G=F+5log+20; exact error integral retains the negative endpoint -5/T.
hlo = b0lo + (5*(la+1)+20)/A - F(5,T) - F(NA,A)
hhi = b0hi + (5*(ua+1)+20)/A - F(5,T) - F(NA,A)
low_head = 2*(QA+F(NA,A))
assert 0 < hlo < hhi < F('9.072023958329')
assert low_head == F(17855,3750)


def w_bounds(delta):
    el, eu = exp_bounds(35*delta)
    return low_head+(1+el)*hlo, low_head+(1+eu)*hhi


rows = []
for delta, cap in [(F(1,400), F('23.735')),
                   (F(3,1000), F('23.910')),
                   (F(2,625), F('23.981')),
                   (F(13,4000), F('23.999'))]:
    lo, hi = w_bounds(delta)
    assert lo <= hi < cap < 24
    rows.append({'delta': str(delta), 'beta_lower': str(F(1,2)-delta),
                 'beta_upper': str(F(1,2)+delta),
                 'W_lower_rounded_down': str(down(lo)),
                 'W_upper_rounded_up': str(up(hi)),
                 'safe_cap': str(cap),
                 'margin_lower_rounded_down': str(down(24-hi))})

# This brackets the crossing of this particular conservative upper model.
# It does not give a necessary condition on actual zeta zeros.
limit_lo, limit_hi = F(325476,10**8), F(325477,10**8)
assert w_bounds(limit_lo)[1] < 24 < w_bounds(limit_hi)[0]

out = {
    'scope': 'Exact scalar implication only; no Lean proof or new finite zero assertion',
    'A': A, 'T': T, 'N_A': NA, 'Q_A_safe_upper': str(QA),
    'analytic_count': 'N(t)<=t/(2*pi)*(log(t/(2*pi))-1)+7/8+5*log(t)+20 for t>=1500',
    'exact_N_T_used': False,
    'low_head_upper': str(low_head),
    'high_mass_lower_rounded_down': str(down(hlo)),
    'high_mass_upper_rounded_up': str(up(hhi)),
    'primary_delta': str(F(2,625)),
    'rows': rows,
    'model_limit_interval': [str(limit_lo), str(limit_hi)],
    'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2)+'\n')
print(json.dumps(out, indent=2))
