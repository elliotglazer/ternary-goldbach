"""Independent integer/rational review; no analytic values or author imports."""
from pathlib import Path
from fractions import Fraction as F
from math import gcd
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
AG = ROOT / 'work/qrh-campaign/agents'
AUTHOR = AG / 'independent-feasibility/MODULUS_WEIGHTED_PLUS_STAR_RESEARCH_2026-11-11.md'
expected = 'A86643A179B34576117DF2F9125E78B7029696A367D5057EAA8531769B30DE1A'
assert hashlib.sha256(AUTHOR.read_bytes()).hexdigest().upper() == expected
saved = json.loads((AUTHOR.parent / 'modulus_weighted_plus_star_scalars_20261111.json').read_text())
checks = {}
def ck(name, value):
    assert value, name
    checks[name] = True
for row in saved['pins']:
    ck('pin:' + row['path'], hashlib.sha256((ROOT / row['path']).read_bytes()).hexdigest().upper() == row['sha256'])

def factors(n):
    out = []
    p = 2
    while p * p <= n:
        e = 0
        while n % p == 0:
            n //= p
            e += 1
        if e:
            out.append((p, e))
        p += 1
    if n > 1:
        out.append((n, 1))
    return out

def phi(n):
    for p, _ in factors(n):
        n = n // p * (p - 1)
    return n

def squarefree(n):
    return all(e == 1 for _, e in factors(n))

def kappa(n):
    f = factors(n)
    prod = F(1)
    for p, e in f:
        if e >= 2:
            prod *= F(p - 1, p)
    return prod - F(int(all(e == 1 for _, e in f)), phi(n))

floors = 0
count = 0
grid = 1 << 64
pair_identity = True
for d in range(1, 44301):
    if gcd(d, 6) != 1 or not squarefree(d):
        continue
    v = phi(d)
    term = F(1, v) - F(1, 2*v*v)
    # Reconstruct both actual ambient-modulus weights, not the author's sieve.
    pair = sum((kappa(q) * F(3, phi(q)) for q in (3*d, 6*d)), F(0))
    pair_identity &= pair == 3*term
    floors += term.numerator * grid // term.denominator
    count += 1
ck('all_ambient_pairs', pair_identity)
ck('term_count', count == 13468)
ck('floor_sum', floors == 67935707915980013489)
lo = F(floors, grid)
hi = lo + F(count, grid)
ck('G_bounds', F(18, 5) < lo < hi < F(369, 100))
ck('directed_receipt', saved['weighted_G6']['floor_sum'] == floors and saved['weighted_G6']['terms'] == count)
ck('q1_q2', kappa(1) == kappa(2) == 0)
ck('q3', kappa(3) == F(1, 2))
ck('four_divisible', all(0 <= kappa(q) <= F(1, 2) for q in range(4, 257, 4)))
ck('endpoint_R_over_3', 132900 // 3 == 44300 and 6*44300 == 2*132900)
ck('eta2_log_cancellation', F(1,2)-F(1,2) == 0 and -F(3,16)+F(3,4) == F(9,16))
ck('moments_and_test', 2*F(9,16) == F(9,8) and 3*F(5,4)-F(9,8) == F(21,8))
ck('test_norm', F(3)**3/3 == 9)
ck('V_lower', F(21,8)**2/9 == F(49,64) > F(3,4))
eps = F(702, 10**15)
j = F(879, 100)
u0 = F(367, 10**8)
ceiling = j*u0*u0/eps
obstruction = 49*F(3,4)*(6*F(18,5)-14)
ck('target_ceiling', ceiling < 169)
ck('obstruction', obstruction == F(2793,10) > 169)
ck('mixed_sqrt_bound', 50*eps < F(5925,10**9)**2)
allocation = F(1902,10**9)+F(3,10**6)+F(5925,10**9)+F(283,10**9)/10+F(1,10**15)*1000
ck('allocation_total', allocation == F('0.000010855301'))
ck('allocation_target', allocation**2 < j*u0*u0)
ck('principal_integrated_bound', F('0.640208')*F(32,13) < F('1.256')**2 and F('1.502e-6')*F('1.262')+F('2e-9')*3 < F('1.902e-6'))

result = {'status':'PASS', 'scope':'Independent exact finite metadata and scalar review, no analytic evaluation',
          'author_sha256':expected, 'pins':saved['pins'], 'checks':checks,
          'terms':count,'floor_sum':floors,'G_lower':str(lo),'G_upper':str(hi),
          'target_ceiling':str(ceiling),'comparison_lower':str(obstruction)}
out = Path(__file__).with_suffix('.json')
if out.exists():
    assert json.loads(out.read_text()) == result
else:
    with out.open('x', encoding='utf-8', newline='\n') as f:
        json.dump(result, f, indent=2)
        f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks),'terms':count}))
