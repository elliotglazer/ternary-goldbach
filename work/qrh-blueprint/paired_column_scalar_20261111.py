"""Exact scalar checks for the paired-column author report; no analytic evaluation."""
from fractions import Fraction as F
from itertools import product
import json


def main():
    counts = {}
    n = 0
    rs = [F(-3), F(-1), F(0), F(1, 2), F(2), F(4)]
    xs = [F(0), F(1, 2), F(1), F(3)]
    allowances = [F(0), F(1, 2), F(2)]
    for r, x, y, allowance, slack in product(rs, xs, xs, allowances, allowances):
        log_norm = y + allowance - slack
        if log_norm < 0:
            continue
        assert -x - max(r - x, 0) == -max(r, x)
        assert max(r - x, 0) == max(max(r, 0) - x, 0)
        assert -x - y - max(r - x, 0) <= allowance - r - log_norm
        n += 1
    counts['max_and_shell_examples'] = n

    n = 0
    # Squared form avoids square roots; V/d0 is exactly the residual volume.
    for frozen, live, h, volume, d0, cap in product(
            [F(0), F(1), F(3, 2)], [F(0), F(2)], [F(0), F(5, 3)],
            [F(1, 4), F(7)], [F(1), F(5, 2)], [F(1), F(9, 4)]):
        slot = frozen * live + 1
        lhs = frozen**2 / d0 * (h * live)**2 * (volume / d0) / cap**2
        exact = (h * frozen * live)**2 * volume / (d0**2 * cap**2)
        bound = (h * slot)**2 * volume / (d0**2 * cap**2)
        assert lhs == exact and exact <= bound
        n += 1
    counts['allocation_normalization_examples'] = n

    n = 0
    for budget, shell_delta in product([F(0), F(1, 2), F(20)], [F(1, 100), F(1), F(3)]):
        small = shell_delta / (2 * (budget + 1))
        assert small > 0 and 2 * budget * small <= shell_delta
        for r in rs:
            assert shell_delta / 2 + (shell_delta / 2 - r) == shell_delta - r
            n += 1
    counts['shell_budget_examples'] = n

    # These must FAIL when key source conditions are removed.
    # 1. A single scale does not control the main coefficient independently of E.
    x, s, a, c, error = F(1), F(0), F(2), F(1), F(2)
    assert abs(s - x*a) <= error and abs(s) <= c*x and abs(a) > c
    # 2. Equal-product cancellation cannot survive unequal scale products, even at E=0.
    assert F(1)*F(1) - F(2)*F(1) != 0
    # 3. The raw-cap identity requires nonnegative log reduction.
    r, log_reduction = F(-1), F(-2)
    assert max(r-log_reduction, 0) != max(max(r, 0)-log_reduction, 0)
    # 4. Without the actual active support boundary, the shell implication can fail.
    r, left, right, allowance, log_norm = map(F, [1, 0, 0, 0, 1])
    assert -left-right-max(r-left, 0) > allowance-r-log_norm
    # 5. Two bounds by Z^-1 imply their minimum, not Z^-2.
    z = F(2)
    assert min(1/z, 1/z) > 1/z**2
    counts['negative_controls'] = 5
    print(json.dumps({'status': 'PASS', 'checks': counts, 'analytic_evaluation': False}, indent=2))


if __name__ == '__main__':
    main()
