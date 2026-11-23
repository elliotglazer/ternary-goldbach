"""Exact finite algebra checks only. No special functions or spectral data."""
from fractions import Fraction as F
from math import gcd
import argparse
import json
from pathlib import Path


def divisors(n):
    return [d for d in range(1, n + 1) if n % d == 0]


def phi(n):
    return sum(gcd(j, n) == 1 for j in range(1, n + 1))


def mu(n):
    sign = 1
    p = 2
    while p * p <= n:
        if n % p == 0:
            n //= p
            sign = -sign
            if n % p == 0:
                return 0
        p += 1
    return -sign if n > 1 else sign


def row(c):
    group = [g for g in range(1, c) if gcd(g, c) == 1]
    v = len(group)
    e = {g: sum((F(mu(c // d) * phi(d), v)
                 for d in divisors(c) if (g - 1) % d == 0), F(0))
         for g in group}

    def conv(a, b):
        result = {g: F(0) for g in group}
        for x in group:
            for y in group:
                result[x * y % c] += a[x] * b[y]
        return result

    assert conv(e, e) == e
    assert all(e[pow(g, -1, c)] == e[g] for g in group)
    assert sum(e.values(), F(0)) == 0
    rank = sum(mu(c // d) * phi(d) for d in divisors(c))
    assert v * e[1] == rank
    assert v * sum((x * x for x in e.values()), F(0)) == rank
    r = {g: e[g] / 2 for g in group}
    power = {g: F(int(g == 1)) for g in group}
    for _ in range(9):
        power = conv(power, r)
    moment = v * sum((x * x for x in power.values()), F(0))
    assert moment == F(rank, 4 ** 9) < 1
    return {"conductor": c, "units": group,
            "projector": [str(e[g]) for g in group],
            "primitive_rank": rank,
            "l1_projector": str(sum(map(abs, e.values()), F(0))),
            "synthetic_half_residual_moment_k9": str(moment)}


def calculate():
    n = 149991
    a = F(n, 4 ** 9)
    b = n * F(4, 9) ** 16
    assert a < 1 and b < 1
    assert 2 * 3 * 5 * 7 * 11 * 13 * 17 == 510510 > 300000
    return {"status": "PASS_EXACT_ALGEBRA_ONLY",
            "maximum_primitive_count": n,
            "half_residual_k9_upper": str(a),
            "two_thirds_residual_k16_upper": str(b),
            "projector_checks": [row(c) for c in (5, 8, 40, 120)]}


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--recompute", action="store_true")
    args = parser.parse_args()
    receipt = Path(__file__).with_suffix(".json")
    result = calculate()
    if args.recompute:
        assert json.loads(receipt.read_text()) == result
    else:
        receipt.write_text(json.dumps(result, indent=2) + "\n")
    print(result["status"])
