"""Exact coefficient check of Endpoint.lean's polynomial identity.

No sampling, symbolic library, Lean execution, or numerical function evaluation.
The inequality also needs the domain/sign argument recorded in the audit.
"""
from fractions import Fraction as F


def const(value):
    return {(0, 0): F(value)}


def add(left, right):
    out = left.copy()
    for key, value in right.items():
        out[key] = out.get(key, F(0)) + value
    return {key: value for key, value in out.items() if value}


def sub(left, right):
    return add(left, {key: -value for key, value in right.items()})


def mul(left, right):
    out = {}
    for (i, j), value in left.items():
        for (k, l), other in right.items():
            key = i + k, j + l
            out[key] = out.get(key, F(0)) + value * other
    return {key: value for key, value in out.items() if value}


def scale(poly, value):
    return mul(poly, const(value))


delta = {(1, 0): F(1)}
y = {(0, 1): F(1)}
denominator = scale(add(const(37), scale(y, 34)), F(1, 18))
prime_weight = scale(add(add(const(7), scale(y, 18)), scale(mul(y, y), 8)), F(1, 9))
weight = add(const(51), scale(y, 41))
gap = sub(const(F(5, 6)), delta)
balance = add(mul(gap, denominator), mul(delta, prime_weight))

# Expanding the stated balancedExponent gives
# -E*balance = balance*(1/48+delta/16+delta*y/6)
#              - (13/32)*(5/6-delta)*delta*prime_weight.
minus_exponent_times_balance = sub(
    mul(balance, add(add(const(F(1, 48)), scale(delta, F(1, 16))),
                     scale(mul(delta, y), F(1, 6)))),
    scale(mul(mul(gap, delta), prime_weight), F(13, 32)),
)
left = scale(mul(weight, minus_exponent_times_balance), 10368)
square_base = sub(scale(mul(weight, delta), 4), const(79))
first = mul(add(const(3), scale(y, 5)), add(mul(square_base, square_base), const(49)))
inner = add(mul(mul(add(const(1), scale(y, 3)), add(const(15), scale(y, 32))), delta),
            sub(const(9), scale(y, 13)))
second = scale(mul(y, add(mul(scale(mul(weight, delta), 4), inner),
                          add(const(265), scale(y, 3485)))), 4)
residual = sub(left, add(first, second))
assert residual == {}, residual
assert F(49, 440640) - F(1, 10000) == F(617, 55080000)
print('PASS: exact polynomial identity; positive margin 617/55080000 over 1/10000')
