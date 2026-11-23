"""Exploratory evaluation of rigorous-form contour bounds.

The formulas have paper derivations in TwistBounds.md. Floating-point grid
values printed by this script are not interval certificates.
"""
import json
import math


def coefficient(theta, delta, favorable=False):
    c = math.cos(2 * theta)
    b = 0.0 if favorable else 2 * math.pi * abs(delta) * math.sin(theta)
    exponent = b * b / (2 * c)
    if exponent > 650:
        return math.inf
    half_gaussian = math.sqrt(math.pi / (2 * c))
    i0 = math.exp(exponent) * min(2 * half_gaussian, b / c + half_gaussian)
    i1 = 1 / c + b / c * i0
    return max(i0, i1)


def optimize(t, delta, favorable=False):
    if t == 0:
        return dict(bound=3.95, cutoff=None, angle=None)
    best = (3.95, None, None)
    for j in range(1, 201):
        cutoff = min(200.0, t) * j / 200
        tail = 0.0 if cutoff == 200.0 else math.sqrt(184) / cutoff ** 2
        for k in range(1, 390):
            angle = k * .002
            prefactor = coefficient(angle, delta, favorable)
            near = min(2.03 * cutoff / math.pi, 3.01) * prefactor * math.exp(-angle * (t - cutoff))
            value = tail + near
            if value < best[0]:
                best = (value, cutoff, angle)
    return dict(bound=best[0], cutoff=best[1], angle=best[2])


rows = []
for height in [0, 5, 10, 14, 20, 30, 50, 100, 200, 300, 500, 1000]:
    row = dict(height=height)
    row['favorable'] = optimize(height, 4, True)
    row['unfavorable_delta1'] = optimize(height, 1)
    row['unfavorable_delta4'] = optimize(height, 4)
    rows.append(row)
print(json.dumps(rows, indent=2))

