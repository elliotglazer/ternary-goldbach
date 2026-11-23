"""Exact arithmetic manifest checks; no L-function evaluations or Lean claims."""
from collections import Counter
from fractions import Fraction
from itertools import product
from math import gcd, lcm, prod
from pathlib import Path
import hashlib
import json

LIMIT = 300000


def factor(n):
    out = []
    p = 2
    while p * p <= n:
        if n % p == 0:
            k = 0
            while n % p == 0:
                n //= p
                k += 1
            out.append((p, k))
        p += 1
    if n > 1:
        out.append((n, 1))
    return out


def valuation(n, p):
    assert n > 0
    k = 0
    while n % p == 0:
        n //= p
        k += 1
    return k


def local_data(p, k):
    q = p ** k
    if p != 2:
        order = (p - 1) * p ** (k - 1)
        prime_divisors = [r for r, _ in factor(order)]
        g = next(g for g in range(1, q) if gcd(g, q) == 1 and
                 all(pow(g, order // r, q) != 1 for r in prime_divisors))
        dims = (order,)
        lookup = {pow(g, j, q): (j,) for j in range(order)}
        generators = [g]
    elif k == 1:
        dims, generators, lookup = (), [], {1: ()}
    elif k == 2:
        dims, generators = (2,), [q - 1]
        lookup = {1: (0,), q - 1: (1,)}
    else:
        dims, generators = (2, 2 ** (k - 2)), [q - 1, 5]
        lookup = {((-1) ** e * pow(5, j, q)) % q: (e, j)
                  for e in range(2) for j in range(2 ** (k - 2))}
    assert len(lookup) == (p - 1) * p ** (k - 1)
    assert set(lookup) == {u for u in range(q) if gcd(u, q) == 1}
    return q, dims, generators, lookup


def local_conductor(p, k, coords):
    if p != 2:
        r = coords[0]
        return 1 if r == 0 else p ** max(1, k - valuation(r, p))
    if k == 1:
        return 1
    if k == 2:
        return 1 if coords[0] == 0 else 4
    e, f = coords
    return (1 if e == 0 else 4) if f == 0 else 2 ** (k - valuation(f, 2))


def pilot(c):
    fs = factor(c)
    locals_ = [local_data(p, k) for p, k in fs]
    dims = sum((x[1] for x in locals_), ())
    root_order = lcm(*dims) if dims else 1
    units = [u for u in range(c) if gcd(u, c) == 1]
    unit_coords = {u: sum((local[3][u % local[0]] for local in locals_), ())
                   for u in units}
    coord_space = list(product(*(range(d) for d in dims)))
    assert len(set(unit_coords.values())) == len(units) == len(coord_space)
    assert set(unit_coords.values()) == set(coord_space)
    for u in units:
        for v in units:
            assert unit_coords[u * v % c] == tuple((x + y) % d for x, y, d in
                                                   zip(unit_coords[u], unit_coords[v], dims))
    divisors = [d for d in range(1, c + 1) if c % d == 0]
    rows = {}
    conductor_hist = Counter()
    primitive = []
    for label in coord_space:
        row = tuple(sum(r * j * (root_order // d) for r, j, d in
                        zip(label, unit_coords[u], dims)) % root_order for u in units)
        assert row not in rows.values()
        rows[label] = row
        pos = 0
        local_cs = []
        for (p, k), local in zip(fs, locals_):
            width = len(local[1])
            local_cs.append(local_conductor(p, k, label[pos:pos + width]))
            pos += width
        cond = prod(local_cs)
        # The exact source FactorsThrough criterion, checked for EVERY divisor.
        descends = [d for d in divisors if all(row[i] == 0 for i, u in enumerate(units)
                                              if (u - 1) % d == 0)]
        assert descends == [d for d in divisors if d % cond == 0]
        conductor_hist[cond] += 1
        parity_phase = row[units.index(c - 1)]
        assert (2 * parity_phase) % root_order == 0
        if cond == c:
            primitive.append({'coordinates': label, 'parity': int(parity_phase != 0),
                              'conjugate': tuple((-r) % d for r, d in zip(label, dims)),
                              'real': all((2 * r) % d == 0 for r, d in zip(label, dims))})
    for label, row in rows.items():
        bar = tuple((-r) % d for r, d in zip(label, dims))
        assert rows[bar] == tuple((-x) % root_order for x in row)
    return {'conductor': c, 'factorization': fs, 'coordinate_orders': dims,
            'root_order': root_order, 'local_generators': [x[2] for x in locals_],
            'unit_group_order': len(units), 'distinct_characters': len(rows),
            'all_divisor_kernel_tests': len(rows) * len(divisors),
            'conductor_histogram': dict(sorted(conductor_hist.items())),
            'primitive_count': len(primitive),
            'primitive_even': sum(x['parity'] == 0 for x in primitive),
            'primitive_odd': sum(x['parity'] == 1 for x in primitive),
            'primitive_real': sum(x['real'] for x in primitive),
            'primitive_labels': primitive}


def full_counts():
    spf = list(range(LIMIT + 1))
    for p in range(2, LIMIT + 1):
        if spf[p] == p:
            for n in range(p, LIMIT + 1, p):
                if spf[n] == n:
                    spf[n] = p
    a, phi, parity_sum = [0] * (LIMIT + 1), [0] * (LIMIT + 1), [0] * (LIMIT + 1)
    a[1] = phi[1] = parity_sum[1] = 1
    for n in range(2, LIMIT + 1):
        p, k, m = spf[n], 0, n
        while m % p == 0:
            m //= p
            k += 1
        a[n] = a[m] * (p - 2 if k == 1 else p ** (k - 2) * (p - 1) ** 2)
        phi[n] = phi[m] * (p - 1) * p ** (k - 1)
        b = (-1 if k == 1 else 0) if p != 2 else (-1 if k == 2 else 0)
        parity_sum[n] = parity_sum[m] * b
    # Independent divisor-sum identity checks all 300000 levels.
    ds, ps = [0] * (LIMIT + 1), [0] * (LIMIT + 1)
    for d in range(1, LIMIT + 1):
        for n in range(d, LIMIT + 1, d):
            ds[n] += a[d]
            ps[n] += parity_sum[d]
    assert ds[1:] == phi[1:]
    assert ps[1] == ps[2] == 1 and all(t == 0 for t in ps[3:])
    active = [c for c in range(1, LIMIT + 1) if a[c] > 0 and (c % 2 == 0 or c <= 150000)]
    assert active == [c for c in range(1, LIMIT + 1) if c % 4 == 0 or (c % 2 == 1 and c <= 150000)]
    assert len(active) == 150000
    total = sum(a[c] for c in active)
    assert total == 5543640188
    def height(c):
        qt = c if c % 2 == 0 else 2 * c
        raw = Fraction(704 * 1200000, 7 * qt)
        hp = 200 + max(1000, -(-raw.numerator // raw.denominator))
        return str(min(Fraction(hp), Fraction(100000000, c)))
    return {'active_conductors': len(active), 'primitive_characters': total,
            'odd_conductor_characters': sum(a[c] for c in active if c % 2),
            'four_divisible_conductor_characters': sum(a[c] for c in active if c % 4 == 0),
            'even_characters': sum((a[c] + parity_sum[c]) // 2 for c in active),
            'odd_characters': sum((a[c] - parity_sum[c]) // 2 for c in active),
            'all_levels_divisor_sum_check': LIMIT,
            'height_samples_exact': {c: height(c) for c in [1, 3, 4, 40, 101, 120, 150000, 299996, 300000]}}


if __name__ == '__main__':
    receipt = {'status': 'PASS: exact arithmetic checks only; no Lean proof or spectral certificate',
               'counts': full_counts(), 'pilots': [pilot(c) for c in [4, 8, 16, 27, 40, 72, 120]],
               'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    Path(__file__).with_suffix('.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print(json.dumps({'status': receipt['status'], 'counts': receipt['counts'],
                      'pilots': [{k: p[k] for k in ['conductor', 'coordinate_orders', 'primitive_count',
                                                  'primitive_even', 'primitive_odd', 'primitive_real']}
                                 for p in receipt['pilots']]}, indent=2))
