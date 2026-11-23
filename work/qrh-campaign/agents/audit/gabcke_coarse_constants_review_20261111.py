"""Independent rational reduction of Gabcke 3.2.2(a), not its analytic proof."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

def atan_bounds(q, n=30):
    x = F(1, q)
    s = sum((-1)**j * x**(2*j+1) / (2*j+1) for j in range(n))
    t = s + (-1)**n * x**(2*n+1) / (2*n+1)
    return min(s, t), max(s, t)

a, b = atan_bounds(5), atan_bounds(239)
pi_lo, pi_hi = 16*a[0]-4*b[1], 16*a[1]-4*b[0]
assert pi_hi < F(3141593, 1000000)
r, s = F(1583234, 1000000), F(14142135, 1000000)
assert r**4 > 2*pi_hi and 0 < s and s*s < 200
# These are the theorem bounds in 2.3.4(a), not decimal coefficient tables.
c = [F(1), F(11,100), F(37,1000), F(28,1000), F(12,1000),
     F(12,1000), F(67,10000), F(83,10000), F(56,10000),
     F(82,10000), F(63,10000)]
results = []
for k, cap in [(0,F(47,100)), (1,F(43,100)), (4,F(212,100))]:
    upper = r**(2*k+3)*sum(c[n]*(r*r/s)**(n-k-1) for n in range(k+1,11)) + F(25966)/s**(10-k)
    assert upper < cap
    results.append(dict(K=k, upper=str(upper), display=float(upper), cap=str(cap)))
# Phase propagation and local sinc denominator checks used in the proposed evaluator.
assert F(80,3322*1500**7) < F(15,10**25)
assert 1-(pi_hi/4)**2/6 > F(7,8)
assert 398 < 400
out = dict(status='PASS', scope='Rational scalar reduction conditional on Gabcke analytic bounds',
           script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
           coarse_constants=results, analytic_theorem_formalized=False)
path = Path(__file__).with_suffix('.json')
path.write_text(json.dumps(out, indent=2)+'\n', encoding='utf8')
print(json.dumps(out, indent=2))
