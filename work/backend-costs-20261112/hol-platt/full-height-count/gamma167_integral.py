"""Compare both fixed 167-step phase receipts to a direct log-Gamma integral."""
import json
import sys
from fractions import Fraction
from pathlib import Path
from time import process_time

from flint import acb, arb, ctx

here = Path(__file__).resolve().parent
sys.path.insert(0, str(here.parent / "one-character-completeness"))
from phase_ends import independent_integral, ball


def main():
    receipts = json.loads((here / "counts.json").read_bytes())
    ctx.prec = 160
    ctx.threads = 1
    start = process_time()
    for parity, pair in enumerate(("(3, 6667)", "(11, 9091)")):
        row, = (r for r in receipts["counts"][pair]["fixed"] if r["extra"] == 167)
        bound = Fraction(row["phase_upper"])
        lower = Fraction(receipts["T"])
        upper = lower + Fraction(835, 64)
        integral = independent_integral(10000, parity, lower, upper)
        assert integral.imag.contains(0)
        assert integral.real < ball(bound)
        assert integral.real > ball(bound - Fraction(1, 2**32))
        print(pair, integral.real, "upper minus phase", ball(bound)-integral.real)
    print("CPU seconds", process_time() - start)


if __name__ == "__main__":
    main()
