"""Independent rational review; no author imports or spectral evaluations."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json
import math

HERE = Path(__file__).resolve().parent
AUTHOR = HERE.parent / 'major-constants'
NAMES = {
    'WEIGHTED_EXCESS_DENSITY_FEASIBILITY_2026-11-11.md': '37505FDC4F83F99727FE636654E4803E3EB1EBF7C1B35FBF4E8C627097A72C90',
    'weighted_excess_density_feasibility_20261111.py': 'B9EC0EED1269680FFC50E2522204863EA09D68B11B277C191477123D5C65BACA',
    'weighted_excess_density_feasibility_20261111.json': 'DA8CD2CE342D8E29C3CE5A64EACB68FFEDF5F327D3CC7823B248B9C6E582C43A',
}
for name, expected in NAMES.items():
    assert hashlib.sha256((AUTHOR / name).read_bytes()).hexdigest().upper() == expected

def root_floor(n, d):
    lo, hi = 0, 1 << ((n.bit_length() + d - 1) // d)
    while lo + 1 < hi:
        mid = (lo + hi) // 2
        if mid**d <= n:
            lo = mid
        else:
            hi = mid
    assert lo**d <= n < (lo+1)**d
    return lo

def power_enclosure(z, exponent):
    assert exponent <= 0
    if not exponent:
        return F(1), F(1)
    scale = 10**50
    n, d = -exponent.numerator, exponent.denominator
    q = root_floor(scale**d // z**n, d)
    assert q**d*z**n <= scale**d < (q+1)**d*z**n
    return F(q, scale), F(q+1, scale)

b, a = F(111, 200), F(7, 8)
X, Y, Q = 49*10**25, 10**25, 300000
def k_bounds(beta):
    pairs = []
    for z in (X, Y):
        lo, hi = power_enclosure(z, beta-a)
        blo, bhi = power_enclosure(z, b-a)
        pairs.append((lo-bhi, hi-blo))
    return max(t[0] for t in pairs), max(t[1] for t in pairs)

data = json.loads((AUTHOR / 'weighted_excess_density_feasibility_20261111.json').read_text())
rows = []
for row in data['weight_rows']:
    beta = F(row['beta'])
    lo, hi = k_bounds(beta)
    assert lo > 0
    floor_lo, floor_hi = math.floor(6/hi), math.floor(6/lo)
    assert floor_lo == floor_hi == row['necessary_count_upper']
    assert lo <= F(row['k_upper']) and F(row['k_lower']) <= hi
    rows.append({'beta': str(beta), 'floor_6_over_actual_k': floor_lo,
                 'k_lower': str(lo), 'k_upper': str(hi)})
ka, _ = k_bounds(a)
assert ka > F(99,100)
assert 8*ka > F(792,100)
assert F(88)+(421+127*5)/F(8) == 220
assert F(5,2)+F(1,6)/(1-F(1,4)) < F(11,4)
assert F(11,4)**12 < Q
ram_add = 32*Q**2*36**2
ram_int = F(99,100)*ram_add
assert ram_add == 3732480000000000
assert ram_int == 3695155200000000
assert F(data['exact_Ramare_integral_lower']) == ram_int
assert F(data['exact_TZ_integral_lower']) == F(99,100)*10**220
assert F(99,100)*10**220 > ram_int
conductors = [c for c in range(100001,300001) if (c%2 and c<=150000) or c%4 == 0]
assert len(conductors) == 75000
assert min(F(10**8,c) for c in conductors) == F(1000,3)
assert max(F(10**8,c) for c in conductors) < 1000
assert 1200 > 1000 and F(704,7)*1200000 > 10**8
c = 100003
assert all(c%d for d in range(2,math.isqrt(c)+1))
assert c%4 == 3 and c in conductors and F(10**8,c) > 4
pins = dict(NAMES)
for name in ('density_ramare_primary_20261111.pdf','density_ramare_primary_20261111.png'):
    pins[name] = hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest().upper()
out = {'scope':'Independent rational arithmetic and source-hash review; not spectral or Lean evidence',
       'pass':True, 'input_sha256':pins, 'decimal_scale':10**50,
       'rows':rows,'conductor_count':len(conductors),
       'ramare_additive_lower':str(ram_add),'ramare_integral_lower':str(ram_int),
       'TZ_integral_lower':str(F(99,100)*10**220),
       'synthetic_right_occurrences':8,'synthetic_total_occurrences':16,
       'diagnostic_decimal_transcendentals_replayed':False}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'pass':True,'rows':[(r['beta'],r['floor_6_over_actual_k']) for r in rows],
                  'ramare_integral_lower':str(ram_int),'pins':pins},indent=2))
