"""Exact polynomial identities and operation counts; no modular evaluations."""
from pathlib import Path
from hashlib import sha256
import json

OUT = Path(__file__).resolve().parent
AGENTS = OUT.parent / 'qrh-campaign/agents'
PRIMES = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]

def add(a, b):
    c = [0] * max(len(a), len(b))
    for i, x in enumerate(a):
        c[i] += x
    for i, x in enumerate(b):
        c[i] += x
    return c

def mul(a, b):
    c = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i+j] += x*y
    return c

def sum_poly(n):
    if n == 1:
        return [1]
    if n == 2:
        return [1, 1]
    if n == 3:
        return [1, 1, 1]
    p = sum_poly(n//2)
    at_square = [0]*(2*len(p)-1)
    at_square[::2] = p
    return (add([1], mul([0, 1, 1], at_square)) if n % 2
            else mul([1, 1], at_square))

def count(n):
    # squares, other products, additions; reductions are separate.
    if n == 1:
        return (0, 0, 0)
    if n == 2:
        return (0, 0, 1)
    if n == 3:
        return (1, 0, 2)
    s, m, a = count(n//2)
    return (s+1, m+1, a+1+n%2)

rows = []
for q in PRIMES[1:]:
    assert sum_poly(q) == [1]*q
    s, m, a = count(q)
    ell = q.bit_length()-1
    epsilon = int(q >> (ell-1) == 3)
    assert s+m == 2*(ell-1)+epsilon
    rows.append({'q': q, 'squares': s, 'other_products': m, 'additions': a,
                 'sum_only_total': s+m,
                 'previous_generic_sum_total': 2*ell+q.bit_count()-2,
                 'binary_power_plus_unit_total': ell+q.bit_count()})

P = 1
for q in PRIMES:
    P *= q
portfolio = []
for tag in [160, 162, 165, 168, 175, 180]:
    F = tag*P
    remaining = F
    s = m = a = roots = 0
    components = []
    for q in PRIMES:
        e = 0
        while remaining % q == 0:
            remaining //= q
            e += 1
        if q == 2:
            cs, cm, ca = e-1, 0, 0
            roots += int(e > 1)
        else:
            exponent = q**(e-1)
            ps = exponent.bit_length()-1
            pm = exponent.bit_count()-1
            ss, sm, ca = count(q)
            cs, cm = ps+ss, pm+sm
            roots += 1
        s, m, a = s+cs, m+cm, a+ca
        components.append({'q': q, 'e': e, 'squares': cs,
                           'other_products': cm, 'sum_additions': ca})
    assert remaining == 1 and F*F > 10**27
    portfolio.append({'tag': tag, 'F': F, 'roots': roots, 'inverse_fields': 0,
                      'squares': s, 'other_products': m, 'sum_additions': a,
                      'total_modular_products': s+m, 'components': components})

paths = [
    AGENTS / 'moebius/EFFICIENCY_BINARY_DIRECT_ORDER_CERTIFICATES_2026-11-11.md',
    AGENTS / 'audit/REVIEW_EFFICIENCY_BINARY_DIRECT_ORDER_CERTIFICATES_2026-11-11.md',
    AGENTS / 'major-constants/EFFICIENCY_GROUPED_ORDER_ROOTS_2026-11-11.md',
    AGENTS / 'audit/REVIEW_EFFICIENCY_GROUPED_ORDER_ROOTS_2026-11-11.md',
    AGENTS / 'prime-estimates/SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md',
]
result = {'scope': 'symbolic polynomial and exact schedule arithmetic only',
          'prime_sum_schedules': rows, 'portfolio': portfolio,
          'source_pins': [{'path': str(p), 'sha256': sha256(p.read_bytes()).hexdigest().upper()}
                          for p in paths]}
receipt = OUT / 'cyclotomic_sum_only_schedules_20261111.json'
receipt.write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
print(json.dumps({'prime_sum_schedules': rows,
                  'portfolio': [{k:v for k,v in row.items() if k != 'components'} for row in portfolio],
                  'receipt_sha256': sha256(receipt.read_bytes()).hexdigest().upper()}, indent=2))
