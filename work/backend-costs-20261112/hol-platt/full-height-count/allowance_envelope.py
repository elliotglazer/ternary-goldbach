"""Rational upper envelopes for the Turing allowances and inverse-pair count.

Uses pi > 3.14 and the positive Taylor series for exp. Input phase bounds,
weighted brackets, and the published S-integral theorem are separate premises.
"""
import json
from fractions import Fraction as F
from pathlib import Path


def log_upper(q_height, limit):
    term = total = F(1)
    for n in range(1, 65):
        term *= limit / n
        total += term
    assert q_height < 2 * F(314, 100) * total
    return limit


def rumely(z):
    return F(18397, 10000) + F(1242, 10000) * z


def main():
    # Even-q height majorizes both parities. Allow an additional 200 guard units.
    q_max = 400000
    q_height = max(10**8 + 200*q_max, 75000000 + 400*q_max)
    z = log_upper(q_height, F(35, 2))
    moderate = (F(15927, 1000) + F(9, 4)*z) / F(314, 100)
    assert moderate < 18
    print("All moduli through 400000: allowances <=", rumely(z), moderate)

    data = json.loads(Path(__file__).with_name("counts.json").read_text())
    for pair, versions in data["counts"].items():
        for row in versions["fixed"]:
            width = F(5*row["extra"], 64)
            height = F(data["T"]) + width
            z = log_upper(10000*height, F(81, 5))
            weight = F(5*row["W_ticks"], 64*data["sub"])
            count_cap = (F(row["phase_upper"]) - weight + 2*rumely(z))/width
            margin = row["K"] + 1 - count_cap
            assert margin > 0
            print(pair, "guard", width, "strict count margin >=", margin)


if __name__ == "__main__":
    main()
