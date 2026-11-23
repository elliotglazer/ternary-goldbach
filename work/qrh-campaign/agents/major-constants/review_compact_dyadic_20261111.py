"""Bounded independent regression, not a Lean proof or performance test."""
from fractions import Fraction
from itertools import product
import json
from pathlib import Path
import hashlib

def val(p):
    m, e = p
    return Fraction(m * (2 ** max(e, 0)), 2 ** max(-e, 0))

def sign(n):
    return (n > 0) - (n < 0)

def top(p):
    return p[1] + abs(p[0]).bit_length()

def sign_small(terms):
    initial_width = max((abs(m).bit_length() for m,e in terms), default=0)
    terms = [(m,e) for m,e in terms if m]
    assert len(terms) <= 3
    while len(terms) > 1:
        terms.sort(key=top, reverse=True)
        if top(terms[0]) - top(terms[1]) >= 2:
            return sign(terms[0][0])
        (m,e),(n,f) = terms[:2]
        g = min(e,f)
        assert max(e-g,f-g) <= initial_width + 2
        merged = (m * 2**(e-g) + n * 2**(f-g),g)
        assert abs(merged[0]).bit_length() <= initial_width + 4
        terms = terms[2:] + ([merged] if merged[0] else [])
    return sign(terms[0][0]) if terms else 0

def rounding(p,t):
    m,e = p
    if m == 0 or e >= t:
        return p,p
    k = t-e
    if k >= abs(m).bit_length():
        return ((0,t),(1,t)) if m > 0 else ((-1,t),(0,t))
    q,r = divmod(m,2**k)
    return (q,t),(q+bool(r),t)

def main():
    terms = [(m,e) for m in [-7,-2,-1,0,1,2,7] for e in [-3,0,3]]
    count = 0
    for triple in product(terms,repeat=3):
        assert sign_small(triple) == sign(sum(map(val,triple)))
        count += 1
    rounded = 0
    for m,e,t in product(range(-31,32),range(-8,9),range(-8,9)):
        lo,hi = rounding((m,e),t)
        x = val((m,e))
        assert val(lo) <= x <= val(hi)
        grid = val((1,t))
        assert x-val(lo) < grid and val(hi)-x < grid
        assert val(lo)/grid == (val(lo)/grid).__floor__()
        assert val(hi)/grid == (val(hi)/grid).__floor__()
        rounded += 1
    huge = 10**100
    cases = [([(1,0),(1,-huge),(-1,0)],1),
             ([(1,0),(-1,-huge),(-1,0)],-1),
             ([(1,huge),(-1,huge),(1,-huge)],1),
             ([(1,0),(-1,-2),(-1,-2)],1),
             ([(-1,0),(1,-2),(1,-2)],-1),
             ([(1,huge),(1,huge),(-1,huge+1)],0)]
    for triple,s in cases:
        assert sign_small(triple) == s
    assert rounding((-1,-huge),0) == ((-1,0),(0,0))
    assert rounding((1,-huge),0) == ((0,0),(1,0))
    divisions = 0
    for a,b,p,e,f in product(range(1,17),range(1,17),range(1,7),[-5,0,5],[-5,0,5]):
        k = p+b.bit_length()-a.bit_length()
        numerator,denominator = (a*2**k,b) if k>=0 else (a,b*2**(-k))
        q,r = divmod(numerator,denominator)
        assert numerator == q*denominator+r and 0<=r<denominator
        assert q.bit_length() <= p+1
        lo,hi = (q,e-f-k),(q+bool(r),e-f-k)
        actual = val((a,e))/val((b,f))
        assert val(lo)<=actual<=val(hi)
        assert val((lo[0],lo[1]))*val((b,f))<=val((a,e))
        assert val((a,e))<=val(hi)*val((b,f))
        assert -val(hi)<=-actual<=-val(lo)
        divisions += 1
    data = dict(scope='Finite exact arithmetic regression only; no Lean or throughput claim',
                sign_triples=count,rounding_cases=rounded,huge_exponent_sign_cases=len(cases),
                huge_exponent_rounding_cases=2,quotient_cases=divisions,
                reviewed_note_sha256=hashlib.sha256((Path(__file__).parent.parent/'integration'/'COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md').read_bytes()).hexdigest().upper(),passed=True)
    target = Path(__file__).with_suffix('.json')
    target.write_text(json.dumps(data,indent=2)+'\n')
    print(json.dumps(data))

if __name__ == '__main__':
    main()
