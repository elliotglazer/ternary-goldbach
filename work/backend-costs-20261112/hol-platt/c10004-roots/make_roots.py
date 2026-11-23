"""Generate integer twiddles on the pinned c=10004 transform's positive p81 grid."""

import argparse
import json
from fractions import Fraction
from math import comb
from pathlib import Path


LENGTHS = (2, 3, 5, 10, 15, 20, 30, 40, 60)
SCALE = 1 << 81
DEGREE = 59
TABLE = Path(__file__).with_name("table.json")


def recurrence(x):
    """Return d^59 U_59(a/d) with d positive and x in lowest terms."""
    twice_a, d_squared = 2 * x.numerator, x.denominator**2
    previous, current = 1, twice_a
    for _ in range(2, DEGREE + 1):
        previous, current = current, twice_a * current - d_squared * previous
    return current


def expanded(a, d):
    """Independent evaluation of the homogeneous polynomial by binomial coefficients."""
    return sum(
        (-1)**j * comb(DEGREE - j, j) * (2*a)**(DEGREE - 2*j) * d**(2*j)
        for j in range(DEGREE // 2 + 1)
    )


def rounded(x):
    return (2 * SCALE * x.numerator + x.denominator) // (2 * x.denominator)


def locate(lo, hi, left_positive):
    while rounded(lo) != rounded(hi):
        mid = (lo + hi) / 2
        value = recurrence(mid)
        if value == 0:
            return rounded(mid)
        if (value > 0) == left_positive:
            lo = mid
        else:
            hi = mid
    return rounded(lo)


def generate_positive_centers():
    # This mesh avoids all positive rational roots of U59 and brackets all 29
    # positive zeros. The independent check verifies coverage from the degree.
    mesh = [Fraction(i, 1024) for i in range(1, 1024, 2)]
    values = [recurrence(x) for x in mesh]
    if 0 in values:
        raise ValueError("unexpected root at coarse endpoint")
    ascending = [
        locate(lo, hi, a > 0)
        for lo, hi, a, b in zip(mesh, mesh[1:], values, values[1:])
        if (a > 0) != (b > 0)
    ]
    return ascending[::-1]


def cosine(centers, j):
    j %= 120
    j = min(j, 120 - j)
    if j > 30:
        return -cosine(centers, 60 - j)
    if j == 30:
        return 0
    if j == 0:
        return SCALE
    return centers[j - 1]


def generate():
    centers = generate_positive_centers()
    rows = {}
    for n in LENGTHS:
        stride = 120 // n
        rows[str(n)] = [
            [cosine(centers, stride*k), cosine(centers, 30 - stride*k)]
            for k in range(n)
        ]
    return dict(fraction_bits=81, positive_cosines=centers, rows=rows)


def verify(table):
    if type(table['fraction_bits']) is not int or table['fraction_bits'] != 81:
        raise ValueError("wrong grid")
    centers = table['positive_cosines']
    if len(centers) != 29 or any(type(c) is not int for c in centers):
        raise ValueError("wrong root count or type")
    previous_left = 2*SCALE
    for c in centers:
        left, right = 2*c - 1, 2*c + 1
        if not 0 < left < right < previous_left:
            raise ValueError("overlapping, unordered or out-of-range isolation bins")
        a, b = expanded(left, 2*SCALE), expanded(right, 2*SCALE)
        if a*b >= 0:
            raise ValueError("interval fails sign-change check")
        previous_left = left

    # Build the ordered 120-vector separately from the generator's indexing.
    quadrant = [SCALE, *centers, 0]
    grid = quadrant[:-1] + [-v for v in reversed(quadrant[1:])]
    grid += [-v for v in grid]
    rows = table['rows']
    if set(rows) != {str(n) for n in LENGTHS}:
        raise ValueError("incorrect transform lengths")
    for n in LENGTHS:
        row = rows[str(n)]
        if len(row) != n:
            raise ValueError("wrong number of roots")
        for k, pair in enumerate(row):
            j = k * (120 // n)
            expected = [grid[j], grid[(j - 30) % 120]]
            if (len(pair) != 2 or any(type(v) is not int for v in pair)
                    or pair != expected):
                raise ValueError(f"incorrect root at length {n}, index {k}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--verify", action="store_true", help="check the saved table")
    args = parser.parse_args()
    if args.verify:
        verify(json.loads(TABLE.read_text()))
    else:
        table = generate()
        verify(table)
        TABLE.write_text(json.dumps(table, indent=2) + "\n", encoding="ascii")
    print(f"Verified 29 algebraic isolation bins and {sum(LENGTHS)} ordered twiddles.")
