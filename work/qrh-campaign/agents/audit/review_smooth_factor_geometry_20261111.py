"""Saved integer-data review only; no primality or modular-power evaluation."""
import hashlib
import itertools
import json
import math
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCE = HERE.parent / 'prime-estimates' / 'smooth_factor_ladder_geometry_20261111.json'
data = json.loads(SOURCE.read_text(encoding='utf-8'))
assert hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper() == '122AD820955BC6753C3DFB5550D3451693848410A295A2EC8B47D61499C72655'
primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
assert data['prime_factors'] == primes
P = math.prod(primes)
assert P == data['primorial31'] == 200560490130
N = 10**27
assert data['N'] == N
Fs = [m*P for m in [160, 162, 165, 168, 175, 180]]

def ceildiv(a, b):
    return -((-a)//b)

def count(e, width, f):
    first = ceildiv(e-width-1, f)
    last = (e-1)//f
    return max(0, last-first+1)

def cost(e):
    return e.bit_length()-1, e.bit_count()-1

nodes = {v['mask']: v for v in data['complement_tree']}
assert len(nodes) == 10
visited = set()
leaves = {}

def product(mask):
    return math.prod(q for j, q in enumerate(primes) if mask & (1 << j))

def visit(mask, outside):
    if mask & (mask-1) == 0:
        q = product(mask)
        assert outside == P//q
        assert q not in leaves
        leaves[q] = outside
        return 0, 0
    assert mask not in visited
    visited.add(mask)
    node = nodes[mask]
    left, right = node['left'], node['right']
    assert left > 0 and right > 0 and left & right == 0 and left | right == mask
    assert node['left_exponent'] == product(right)
    assert node['right_exponent'] == product(left)
    a = visit(left, outside*product(right))
    b = visit(right, outside*product(left))
    c, d = cost(product(left)), cost(product(right))
    return tuple(a[j]+b[j]+c[j]+d[j] for j in (0, 1))

tree_cost = visit((1 << len(primes))-1, 1)
assert visited == set(nodes) and set(leaves) == set(primes)
for row, f in zip(data['portfolio'], Fs, strict=True):
    m = row['m']
    assert f == row['F'] == m*P
    assert set(row['factors']) == set(map(str, primes))
    assert math.prod(int(q)**e for q, e in row['factors'].items()) == f
    assert f*f-N == row['square_margin'] > 0
    assert row['max_k'] == (N-1)//f
    assert row['max_k'] < 2**45
    assert row['outputs'] == [f]+[f//q for q in primes]
    sq, mul = cost(m)
    assert row['minus_one_variant_squares'] == sq+tree_cost[0] == 128
    assert row['complement_tree_squares'] == sq+tree_cost[0]+1
    assert row['complement_tree_products'] == mul+tree_cost[1]
    assert row['fixed_binary_squares'] == max(row['outputs']).bit_length()-1
    assert row['fixed_binary_products'] == sum(e.bit_count()-1 for e in row['outputs'])

subsets = []
for size in range(1, 7):
    for values in itertools.combinations(Fs, size):
        subsets.append((1 if size % 2 else -1, math.lcm(*values)))
period = math.lcm(*Fs)
union = sum(sign*(period//f) for sign, f in subsets)
assert period == data['period'] and union == data['distinct_candidates_per_period']
assert union == data['density_numerator'] and period == data['density_denominator']
for row in data['windows']:
    B, S, D = row['B'], row['S'], row['D']
    assert S == B//2 and D == S-2 and B == S+D+2
    assert S % 2 == D % 2 == 0 and N % S == 0
    assert row['slots'] == N//S
    per = [count(N, D, f) for f in Fs]
    assert per == row['per_F_top_counts']
    assert row['per_F_min'] == [D//f for f in Fs]
    assert row['per_F_max'] == [ceildiv(D, f) for f in Fs]
    exact = sum(sign*count(N, D, f) for sign, f in subsets)
    lower = sum(D//f if sign == 1 else -ceildiv(D, f) for sign, f in subsets)
    upper = sum(ceildiv(D, f) if sign == 1 else -(D//f) for sign, f in subsets)
    assert row['portfolio_union_top'] == exact
    assert row['portfolio_union_any_window_min'] == max(0, lower)
    assert row['portfolio_union_any_window_max'] == upper
    assert lower <= exact <= upper and row['duplicated_top'] == sum(per)
    assert row['power2_45_top'] == count(N, D, 2**45)

out = {
    'status': 'PASS',
    'scope': 'Saved integer geometry and exponent schedules only; no prime or modular-power evaluation.',
    'source_sha256': hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper(),
    'factor_rows': 6,
    'window_rows': 5,
    'inclusion_exclusion_terms': len(subsets),
    'tree_internal_nodes': len(nodes),
    'exact_leaf_exponents': {str(q): e for q, e in leaves.items()},
    'tree_cost_excluding_multiplier': tree_cost,
    'period': period,
    'union_per_period': union,
    'prime_certificates_checked': 0,
}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2)+'\n', encoding='utf-8')
print(json.dumps(out, indent=2))
