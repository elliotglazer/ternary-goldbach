"""Exact arithmetic coverage diagnostic for the reviewed Type I/II envelope.

This is not a Lean proof and does not remove the Type I/II input's PlattGRH
dependency. All classification comparisons use rational upper bounds.
"""
from fractions import Fraction as F
from math import isqrt
from pathlib import Path
import json

LIMIT = 150000
SCALE = 10**9


def log_upper(n):
    """Upper bound from log x = 2 sum z^(2j+1)/(2j+1), z=(x-1)/(x+1)."""
    k = n.bit_length() - 1
    x = F(n, 2**k)

    def unit_upper(v):
        z = (v - 1) / (v + 1)
        terms = 24
        partial = 2 * sum((z**(2*j+1) / (2*j+1)
                           for j in range(terms)), F(0))
        tail = 2*z**(2*terms+1) / ((2*terms+1)*(1-z*z))
        return partial + tail

    upper = unit_upper(x) + k*unit_upper(F(2))
    scaled = upper*SCALE
    rounded = F(-(-scaled.numerator // scaled.denominator), SCALE)
    assert rounded >= upper
    return rounded


def reciprocal_sqrt_upper(n):
    upper = F(isqrt(SCALE*SCALE // n) + 1, SCALE)
    assert upper*upper*n >= 1
    return upper


def classify():
    phi = list(range(LIMIT+1))
    for p in range(2, LIMIT+1):
        if phi[p] == p:
            for q in range(p, LIMIT+1, p):
                phi[q] -= phi[q] // p
    # Ceil to a bin endpoint before taking the logarithm, then round upward.
    logs = {b: log_upper(2*b) for b in range(1000, LIMIT+1, 1000)}
    roots = {n: reciprocal_sqrt_upper(2*n) for n in range(1, LIMIT+1)}
    covered = []
    samples = {}
    buckets = {}
    for q in range(4, LIMIT+1):
        ell = logs[((q+999)//1000)*1000]
        ph = phi[q]
        central = ((F('.68')*ell+F('.8764'))*roots[ph]
                   + F('2.526')*roots[q]
                   + (F('3.25')*ell+F('7.82'))/ph
                   + (F('13.66')*ell+F('37.55'))/q
                   + F('.000428'))
        upper = F('1.254')*central+F('.000709002')
        passes = upper <= F('.04712')
        bucket = f'{((q-1)//10000)*10000+1}-{((q-1)//10000+1)*10000}'
        buckets[bucket] = buckets.get(bucket, 0) + int(passes)
        if passes:
            covered.append(q)
        if q in [4, 10000, 30030, 50000, 90090, 100000, 120120, 149993, 150000]:
            samples[str(q)] = dict(phi=ph, upper=str(upper),
                                   decimal=float(upper), passes=passes)
    original = [q for q in range(100000, LIMIT+1) if 20*q <= 21*phi[q]]
    assert len(original) == 8268
    assert set(original) <= set(covered)
    result = dict(status='Exact rational coverage diagnostic; not a Lean theorem',
                  envelope='Reviewed R<.68, w in [.05,8], all y>=1e25',
                  threshold='.04712', log_bin_width=1000, rounding_scale=SCALE,
                  domain=[4, LIMIT], excluded_small_Q=[1, 2, 3],
                  covered_count=len(covered), original_count=len(original),
                  newly_covered_count=len(covered)-len(original),
                  smallest_covered=min(covered),
                  covered_prime_count=sum(phi[q] == q-1 for q in covered),
                  covered_by_bucket=buckets, samples=samples,
                  covered_denominators=covered)
    target = Path(__file__).with_suffix('.json')
    target.write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
    print(json.dumps({k: v for k, v in result.items()
                      if k != 'covered_denominators'}, indent=2))


if __name__ == '__main__':
    classify()
