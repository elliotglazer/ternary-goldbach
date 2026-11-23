"""Tiny exact Bluestein diagnostic, not an L-function or family computation.

Arithmetic is in Q[X]/(X^8-X^4+1), with X the primitive 24th root.
The four lengths below have all required chirps/twiddles in this ring.
"""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json


def scalar(n):
    return (F(n),) + (F(0),) * 7


ZERO, ONE = scalar(0), scalar(1)


def add(a, b):
    return tuple(x + y for x, y in zip(a, b))


def scale(a, q):
    return tuple(q * x for x in a)


def mul(a, b):
    p = [F(0)] * 15
    for i in range(8):
        for j in range(8):
            p[i+j] += a[i]*b[j]
    for k in range(14, 7, -1):
        p[k-4] += p[k]
        p[k-8] -= p[k]
        p[k] = 0
    return tuple(p[:8])


X = (F(0), F(1)) + (F(0),) * 6
ROOTS = [ONE]
for _ in range(24):
    ROOTS.append(mul(ROOTS[-1], X))
assert ROOTS[24] == ONE


def root(n):
    return ROOTS[n % 24]


def fft_plus(a):
    """Normalized positive radix-two transform, ordinary output order."""
    n = len(a)
    d = n.bit_length()-1
    assert n == 1 << d and 24 % n == 0
    rev = lambda k: int(f'{k:0{d}b}'[::-1], 2) if d else 0
    b = [a[rev(k)] for k in range(n)]
    for ell in range(1, d+1):
        size = 1 << ell
        for start in range(0, n, size):
            for r in range(size//2):
                u = b[start+r]
                v = mul(root((24//size)*r), b[start+r+size//2])
                b[start+r] = scale(add(u, v), F(1, 2))
                b[start+r+size//2] = scale(add(u, scale(v, -1)), F(1, 2))
    return b


def fft_minus(a):
    b = fft_plus(a)
    return [b[(-k) % len(a)] for k in range(len(a))]


def direct(a, sign=1):
    m = len(a)
    assert 24 % m == 0
    return [sum_ring(mul(a[j], root(sign*(24//m)*j*k)) for j in range(m))
            for k in range(m)]


def sum_ring(xs):
    result = ZERO
    for x in xs:
        result = add(result, x)
    return result


def bluestein(a, corrupt=None):
    m = len(a)
    n = 1
    while n < 2*m-1:
        n *= 2
    assert 24 % (2*m) == 0
    chirp = lambda j: root((24//(2*m))*(j*j % (m if corrupt == 'mod_m' else 2*m)))
    aa = [mul(a[j], chirp(j)) if j < m else ZERO for j in range(n)]
    bb = [ZERO] * n
    for t in range(-(m-1), m):
        if corrupt == 'drop_negative' and t < 0:
            continue
        bb[t % n] = root(-(24//(2*m))*t*t)
    ah, bh = fft_plus(aa), fft_plus(bb)
    product = [mul(x, y) for x, y in zip(ah, bh)]
    cc = fft_minus(product)
    factor = n if corrupt == 'scale_n' else n*n
    cc = [scale(x, factor) for x in cc]
    if corrupt is None:
        cyclic = [sum_ring(mul(aa[j], bb[(k-j) % n]) for j in range(n))
                  for k in range(n)]
        assert cc == cyclic
    return [mul(chirp(k), cc[k]) for k in range(m)], n


I = root(6)
values = [add(scalar(1), scale(I, 2)), add(scalar(-3), I),
          add(scalar(2), scale(I, -1)), add(scalar(4), scale(I, -2))]
cases = []
for m in (1, 2, 3, 4):
    got, n = bluestein(values[:m])
    assert got == direct(values[:m])
    cases.append({'m': m, 'padding_length': n, 'positive_dft_matches': True})
assert direct(values[:3]) != direct(values[:3], -1)
for bug in ('mod_m', 'drop_negative', 'scale_n'):
    assert bluestein(values[:3], bug)[0] != direct(values[:3])


def R(d, B, q):
    return (q*B/2+q)*sum((1+q/2)**j for j in range(d))


scalar_checks = 0
for m in (1, 2, 3, 4, 7, 17, 65):
    n = 1
    while n < 2*m-1:
        n *= 2
    d = n.bit_length()-1
    for B in (F(0), F(1, 3), F(5)):
        a1 = B+1+d*(2*B+3)
        b1 = 1+4*d
        p1 = a1+B*b1+a1*b1+1
        w1 = p1+d*(B+p1+2)
        K = 2*n*n*w1+m*B+1
        tau = F(1, 1000)
        p = 0
        while F(1, 2**p) > min(F(1, d+1), tau/(2*K)):
            p += 1
        q = F(1, 2**p)
        ea, eb = q*(B+1), q
        Ealpha = ea+R(d, B+ea, q)
        Ebeta = eb+R(d, 1+eb, q)
        A, D = F(m, n)*B, F(2*m-1, n)
        Ep = D*Ealpha+A*Ebeta+Ealpha*Ebeta+q
        Ew = Ep+R(d, A*D+Ep, q)
        final = (1+q)*n*n*Ew+q*m*B+q
        assert final <= K*q <= tau/2
        scalar_checks += 1

path = Path(__file__)
receipt = {'status': 'PASS', 'scope': 'exact small algebraic diagnostics and rational error bounds only',
           'ring': 'Q[X]/(X^8-X^4+1), X=exp(2*pi*i/24)',
           'cases': cases, 'odd_case_negative_sign_distinguished': True,
           'corruptions_rejected': ['chirp square modulo m', 'dropped negative differences', 'N rather than N^2 scale'],
           'rational_bound_cases': scalar_checks, 'actual_L_function_samples': 0,
           'script_sha256': hashlib.sha256(path.read_bytes()).hexdigest().upper()}
path.with_suffix('.json').write_text(json.dumps(receipt, indent=2)+'\n', encoding='utf-8')
print(json.dumps(receipt, indent=2))
