"""Exact rational scalar replay, conditional on the pinned EM endpoint enclosures.

No floating-point arithmetic, FLINT, complex log, Gamma or zeta evaluation.
This is research evidence, not a Lean checker or an independent EM evaluator.
"""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[3]
SOURCE = ROOT / 'work/qrh-campaign/agents/zero-sum/em_top_horizontal_20261111.json'
EXPECTED = '9f8d349077cea0598c50c61377c80a0098ffbb0ef723a0a68d85a18fc73aec26'

def add(a, b):
    return a[0] + b[0], a[1] + b[1]

def neg(a):
    return -a[1], -a[0]

def scale(a, r):
    return (r*a[0], r*a[1]) if r >= 0 else (r*a[1], r*a[0])

def mul(a, b):
    corners = [x*y for x in a for y in b]
    return min(corners), max(corners)

def div(a, b):
    assert b[0] > 0
    return mul(a, (1/b[1], 1/b[0]))

def atan_small(t, n=80):
    assert abs(t) <= Q(1, 2) and n > 0
    if t < 0:
        return neg(atan_small(-t, n))
    # Even partial sum is below; the next odd partial sum is above.
    assert n % 2 == 0
    s = sum(((-1)**j * t**(2*j+1) / (2*j+1) for j in range(n)), Q(0))
    return s, s + t**(2*n+1)/(2*n+1)

PI = add(scale(atan_small(Q(1, 5)), 16), scale(atan_small(Q(1, 239)), -4))
assert 3 < PI[0] < PI[1] < 4

def atan_rational(t):
    if t < 0:
        return neg(atan_rational(-t))
    if t > 1:
        return add(scale(PI, Q(1, 2)), neg(atan_rational(1/t)))
    if t > Q(1, 2):
        u = (t-1)/(t+1)
        assert Q(-1, 3) <= u <= 0
        return add(scale(PI, Q(1, 4)), atan_small(u))
    return atan_small(t)

def log_unit(y, n=80):
    assert 1 <= y <= 2
    t = (y-1)/(y+1)
    s = 2*sum((t**(2*j+1)/(2*j+1) for j in range(n)), Q(0))
    tail = 2*t**(2*n+1)/((2*n+1)*(1-t*t))
    return s, s+tail

LOG2 = log_unit(Q(2))

def log_rational(x):
    assert x > 0
    k, y = 0, x
    while y > 2:
        k, y = k+1, y/2
    while y < 1:
        k, y = k-1, y*2
    return add(scale(LOG2, k), log_unit(y))

def rounded(a, places=22):
    d = 10**places
    lo = (a[0]*d).__floor__()
    hi = (a[1]*d).__ceil__()
    return [str(Q(lo, d)), str(Q(hi, d))]

def main():
    assert hashlib.sha256(SOURCE.read_bytes()).hexdigest() == EXPECTED
    data = json.loads(SOURCE.read_text())
    assert data['status'] == 'PASS_EXPLICIT_EM_TOP_PATH' and len(data['blocks']) == 6
    endpoint = data['endpoints']['1/2']
    re, im = (tuple(map(Q, endpoint[k])) for k in ('re', 'im'))
    ratio = div(im, re)
    arg = atan_rational(ratio[0])[0], atan_rational(ratio[1])[1]
    s = div(arg, PI)
    # F(T)=x(log x-1)+7/8. Here both positive factors are monotone.
    x = div((Q(data['T']), Q(data['T'])), scale(PI, 2))
    assert x[0] > 1
    # Round x outward before evaluating log to keep rational sizes bounded.
    x = tuple(map(Q, rounded(x, 30)))
    llog, ulog = log_rational(x[0]), log_rational(x[1])
    assert llog[0] > 1
    f = x[0]*(llog[0]-1)+Q(7, 8), x[1]*(ulog[1]-1)+Q(7, 8)
    count = add(add(f, s), (Q(-1, 8), Q(1, 8)))
    lower, upper = count[0].__ceil__(), count[1].__floor__()
    assert lower == upper
    for t in [Q(0), Q(1, 2), Q(3, 4), Q(1), Q(2), Q(1000)]:
        a = atan_rational(t)
        assert a[0] <= a[1] and atan_rational(-t) == neg(a)
        assert a[1]-a[0] < Q(1, 10**45)
    result = dict(status='PASS_EXACT_SCALAR_REPLAY', source_sha256=EXPECTED,
                  pi=rounded(PI), S=rounded(s), F=rounded(f),
                  count_interval=rounded(count), unique_integer=lower,
                  scope='Exact scalar arithmetic only; endpoint EM and analytic count identity remain dependencies')
    output = Path(__file__).with_suffix('.json')
    output.write_text(json.dumps(result, indent=2)+'\n', encoding='utf8')
    print(json.dumps(result))

if __name__ == '__main__':
    main()
