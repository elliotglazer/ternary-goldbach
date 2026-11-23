"""Independent metadata-only bounds, not a spectral or runtime computation.

Uses the multiplicative primitive-character count and directed integer rounding.
Prints JSON to stdout, writes no files, and imports no producer implementation.
"""
import json
from fractions import Fraction

LIMIT = 300_000
SCALE = 100_000_000
spf = list(range(LIMIT + 1))
for p in range(2, 548):
    if spf[p] == p:
        for n in range(p * p, LIMIT + 1, p):
            if spf[n] == n:
                spf[n] = p


def primitive_count(c):
    count = 1
    while c > 1:
        p = spf[c]
        exponent = 0
        while c % p == 0:
            c //= p
            exponent += 1
        count *= p - 2 if exponent == 1 else (p - 1) ** 2 * p ** (exponent - 2)
    return count


def euler_phi(c):
    result = c
    while c > 1:
        p = spf[c]
        result = result // p * (p - 1)
        while c % p == 0:
            c //= p
    return result


def old_height(c):
    qt = 2 * c if c % 2 else c
    candidate = 200 + max(Fraction(1000), Fraction(844_800_000, 7 * qt))
    ceiling = -(-candidate.numerator // candidate.denominator)
    return min(Fraction(ceiling), Fraction(100_000_000, c))


groups = {k: dict(conductors=0, labels=0, old_lo=0, old_hi=0, new_lo=0, new_hi=0,
                  old_em_bases=0, new_em_bases=0)
          for k in ('unchanged', 'high_odd', 'high_even')}
for c in range(1, LIMIT + 1):
    if not ((c % 2 and c <= 150_000) or c % 4 == 0):
        continue
    n = primitive_count(c)
    group = 'unchanged' if c <= 100_000 else 'high_odd' if c % 2 else 'high_even'
    h_old = old_height(c)
    h_new = h_old if c <= 100_000 else Fraction(50_000_000 if c % 2 else 99_000_000, c)
    assert h_new <= h_old
    g = groups[group]
    g['conductors'] += 1
    g['labels'] += n
    for name, h in (('old', h_old), ('new', h_new)):
        q, r = divmod(h.numerator * SCALE, h.denominator)
        g[name + '_lo'] += n * q
        g[name + '_hi'] += n * (q + bool(r))
        if c > 1:
            # Literal one-top-center EM proxy only, not evaluator operations.
            ceiling = -(-h.numerator // h.denominator)
            g[name + '_em_bases'] += euler_phi(c) * (ceiling + 36)

total = {key: sum(g[key] for g in groups.values()) for key in groups['unchanged']}
assert total['conductors'] == 150_000
assert total['labels'] == 5_543_640_188
assert old_height(1) == 60_343_058
assert total['old_em_bases'] == 8_500_555_507_588
assert total['new_em_bases'] == 7_467_072_337_142
ratio_lo = Fraction(total['new_lo'], total['old_hi'])
ratio_hi = Fraction(total['new_hi'], total['old_lo'])
result = dict(scale=SCALE, definition='sum of primitive label count times positive inclusive height',
              groups=groups, total=total,
              ratio_lower=str(ratio_lo), ratio_upper=str(ratio_hi),
              ratio_display=[float(ratio_lo), float(ratio_hi)],
              scope='Metadata only. No zero count, samples, runtime, or proof size inferred.')
print(json.dumps(result, indent=2))
