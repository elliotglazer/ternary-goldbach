"""Exact scalar checks only. No analytic function or spectral evaluation."""
from fractions import Fraction as F
from itertools import product
import json


def main():
    local_cases = 0
    equality_cases = []
    for c, d, nonunit in product(range(1, 25), range(1, 25), [False, True]):
        if c != d and min(c, d) % 6:
            continue
        saving = F(c + d) - F(5 * min(c, d), 6) - 1
        saving += int(c == d and c % 6 != 0 and not nonunit)
        saving += F(int(c == d and c % 6 != 0 and nonunit), 6)
        saving += F(int(c == d and c == 1 and nonunit), 3)
        assert saving >= F(c + d, 3)
        local_cases += 1
        if saving == F(c + d, 3):
            equality_cases.append([c, d, nonunit])
    # A negative control: dropping the forcing correction breaks c=d=1.
    without_forcing = F(2) - F(5, 6) - 1 + F(1, 6)
    assert without_forcing == F(1, 3) < F(2, 3)

    scalar_cases = 0
    for index, (c, d) in enumerate([(1, 1), (2, 3), (7, 49), (64, 9), (F(1, 3), 5), (5, F(2, 7))]):
        c, d = F(c), F(d)
        g, u, v, f, p = map(F, [index + 1, index + 2, index + 3, index + 4, index + 5])
        K, H, a = F(index + 2, 3), F(index + 5, 2), F(index + 1, 7)
        for h, sk, sa, sb in product([F(1, 1000), F(1), F(1000)], [F(1), F(2), F(7, 3)], [F(1), F(2), F(7, 3)], [F(1), F(2), F(7, 3)]):
            k = K * g * v / (c * d) * sk
            A, B = a * H / c * sa, a * H / d * sb
            x = k * h / (A * B)
            assert x <= (1 + x) ** 6
            lhs6 = (K * g * H * p) ** 6 * h / ((c * d) ** 9 * u ** 6 * (A * B) ** 3 * f ** 2 * (1 + x) ** 6)
            rhs6 = H ** 2 * K ** 5 * g ** 5 * p ** 6 / (a ** 4 * (c * d) ** 6 * u ** 6 * v * f ** 2)
            assert lhs6 <= rhs6
            scalar_cases += 1
    result = {
        "scope": "Exact rational examples; general argument is in the author report; no Lean validation",
        "local_exponent_cases": local_cases,
        "local_equality_cases": equality_cases,
        "negative_control_without_forcing": "1/3 < 2/3",
        "physical_scalar_sixth_power_cases": scalar_cases,
        "status": "all assertions passed",
    }
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
