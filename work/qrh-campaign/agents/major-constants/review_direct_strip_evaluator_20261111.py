"""Exact scalar audit only; never evaluates an L-function or sums to N."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
NOTE = ROOT / "qrh-blueprint/turing-scalars/DIRECT_STRIP_EVALUATOR_CONVERGENCE_2026-11-11.md"
assert hashlib.sha256(NOTE.read_bytes()).hexdigest().upper() == "8C33A7A746D72B1ADF3C9C0A20951034E9C6F00B085C82BDC7CF7D29AAD34EEF"
q, b, d, u, v = 101, F(111, 200), F(2), F(7999, 8), F(8001, 8)
B = d + max(abs(u), abs(v))
C = (q + 1) * (1 + B / b)
L = (q + 1) * (1 / b + B / b**2)
assert (B, C, L) == (F(8017, 8), F(6818224, 37), F(1363644800, 4107))
assert L == C / b
e = F(1, 10**12)
rhs = (C / (e / 3)) ** b.denominator

def passes(k):
    return F(2 ** (k * b.numerator)) > rhs

assert not passes(106)
assert passes(107)
# Strict monotonicity then excludes all preceding nonnegative dyadic exponents.
first = next(k for k in range(108) if passes(k))
assert first == 107

# Finite Abel identity at s=1, checked for arbitrary rational coefficients.
# Each exact cell integral is A(n)*(1/n - 1/(n+1)).
coeffs = [F(2, 3), F(-5, 7), F(0), F(11, 13), F(-1)]
for N in range(1, len(coeffs) + 1):
    direct = sum((coeffs[n-1] / n for n in range(1, N+1)), F(0))
    partial = F(0)
    integral = F(0)
    for n in range(1, N):
        partial += coeffs[n-1]
        integral += partial * (F(1, n) - F(1, n+1))
    terminal = sum(coeffs[:N], F(0)) / N
    assert direct == integral + terminal

result = {
    "scope": "Exact scalar and finite telescoping checks only; analytic proof reviewed separately.",
    "author_note_sha256": hashlib.sha256(NOTE.read_bytes()).hexdigest().upper(),
    "B": str(B), "C": str(C), "L": str(L), "point_error": str(e),
    "tail_error": str(e/3), "least_dyadic_exponent": first,
    "fails_106": not passes(106), "passes_107": passes(107),
    "finite_abel_s1_examples": len(coeffs), "large_sum_attempted": False,
}
dest = HERE / "review_direct_strip_evaluator_20261111.json"
dest.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
print(json.dumps(result, indent=2))
