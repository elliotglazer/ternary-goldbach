"""Prepare matched stock-HOL fixtures for the two largest grid changes."""
from hashlib import sha256
from math import gcd
from pathlib import Path
import json
import sys

HERE = Path(__file__).resolve().parent
WIDE = HERE.parent / "wide-band-slab"
sys.path.insert(0, str(WIDE))
from prepare import BASE_IN, M, OUT, PATH, Q, acb, arb, coefficients, ctx, pack


def emit(out, tag, j, grid, cell, rows):
    analytic = [coefficients(grid, cell, j + t) for t in range(8)]
    lanes = [[a[1][m][i] for a in analytic for i in (0, 1)] for m in range(20)]
    while not any(lanes[-1]):
        lanes.pop()
    coeff = [pack(v, BASE_IN) for v in lanes]
    bias = pack([BASE_IN // 2 + Q // 2] * 16, BASE_IN)
    acc = (sum(2 * abs(v) + int(v < 0) for v in coeff) + bias) % M
    count, count_rows, direct = 0, [(0, 0, acc)], 0
    print(tag, 4, bias, len(rows), file=out)
    print(*coeff, file=out)
    for n, (c, numerators) in enumerate(rows, 1):
        g = gcd(c, grid)
        den = 2 * c // g
        residuals = [(grid * a - c * cell) // g for a in numerators]
        print(den, *residuals, file=out)
        for a, r in zip(numerators, residuals, strict=True):
            assert 4 * abs(r) <= den
            w = [Q]
            for _ in lanes[1:]:
                w.append((2 * w[-1] * r + den) // (2 * den))
            vals = [sum(v * h for v, h in zip(column, w, strict=True)) for column in zip(*lanes, strict=True)]
            assert all(0 <= v + BASE_IN // 2 + Q // 2 < BASE_IN for v in vals)
            z = [(2 * v + Q) // (2 * Q) for v in vals]
            assert all(-OUT // 2 <= v < OUT // 2 for v in z)
            acc = (17 * acc + pack([v + OUT // 2 for v in z], OUT)) % M
            if direct < 1:
                for t, (s, _, bound) in enumerate(analytic):
                    true_value = s.zeta(arb(1) + arb(a) / c)
                    assert abs(true_value - acb(z[2*t], z[2*t+1]) / (1 << 94)) < arb(bound.numerator) / bound.denominator
                direct += 1
        count += 8 * len(residuals)
        if n in (8, 32, len(rows)):
            count_rows.append((n, count, acc))
    assert direct == 1 and len(count_rows) == 4
    for row in count_rows:
        print(*row, file=out)
    return dict(tag=tag, grid=grid, cell=cell, samples=count, degree=len(coeff)-1)


def main():
    ctx.prec, ctx.threads = 256, 1
    sys.set_int_max_str_digits(0)
    rows = json.loads(PATH.read_bytes())["conductors"]
    records = []
    with (HERE / "resident.txt").open("w", encoding="ascii", newline="\n") as out:
        for j, coarse in [(7041, 1024), (60001, 8192)]:
            active = sorted((r[0], r[1]) for r in rows if r[4] + 41 + 640 >= j + 8)
            assert len(active) >= 64
            half = sum(phi for _, phi in active) // 2
            chosen = 0
            for i, (_, phi) in enumerate(active):
                half -= phi
                if half <= 0:
                    chosen = min(max(0, i-32), len(active)-64)
                    break
            conductors = [c for c, _ in active[chosen:chosen+64]]
            cell = 385 * coarse // 997
            points = [(c, [a for a in range((2*cell-1)*c//(2*coarse)+1, (2*cell+1)*c//(2*coarse)+1) if gcd(c, a) == 1]) for c in conductors]
            control = emit(out, f"j{j}coarse", j, coarse, cell, points)
            fine = []
            for k in range(2*cell-1, 2*cell+2):
                subset = [(c, [a for a in aa if (4*coarse*a+c-1)//(2*c) == k]) for c, aa in points]
                fine.append(emit(out, f"j{j}fine{k}", j, 2*coarse, k, subset))
            assert sum(f["samples"] for f in fine) == control["samples"]
            records.append(dict(start=j, conductors=conductors, coarse=control, fine=fine))
    src = (WIDE / "BandSlabScript.sml").read_text()
    src = src.replace("Theory BandSlab\n", "Theory GuardCompare\n")
    src = src.replace("oneResident())[1,2,3,4]", "oneResident())(List.tabulate(8, fn i=>i))")
    assert "Theory GuardCompare\n" in src and "List.tabulate(8, fn i=>i)" in src
    (HERE/"GuardCompareScript.sml").write_text(src, newline="\n")
    pins = {str(p.name): sha256(p.read_bytes()).hexdigest() for p in (PATH, WIDE/"BandSlabScript.sml", HERE/"resident.txt", HERE/"GuardCompareScript.sml")}
    (HERE/"ab_inputs.json").write_text(json.dumps(dict(cases=records, hashes=pins), indent=2) + "\n")
    print([(r["start"], r["coarse"]["samples"], [x["samples"] for x in r["fine"]]) for r in records])


if __name__ == "__main__":
    main()
