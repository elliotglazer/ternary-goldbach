"""Exact rational witnesses only. No analytic function or zero evaluation."""
from fractions import Fraction as F
from pathlib import Path
import json

def wire(x):
    if isinstance(x, F):
        return {"numerator": str(x.numerator), "denominator": str(x.denominator)}
    if isinstance(x, dict):
        return {k: wire(v) for k, v in x.items()}
    return x

u = F(7, 8)
log_lower, log_upper = F(2, 15), F(15, 112)
p_upper = 2*u + u*log_upper - sum(u**(k+1)/F(k*(2*k+1)) for k in range(1, 7))
d_common = sum(F(k+1)*u**k/F(k*(2*k+1)) for k in range(1, 7))
d_lower, d_upper = 1 + log_lower - d_common, 1 + log_upper - d_common
checks = {
    "atanh_upper_identity": F(2, 15)/(1-F(1, 15)**2) == log_upper,
    "p_upper_lt_191_over_128": p_upper < F(191, 128),
    "derivative_lower_positive": 0 < d_lower,
    "derivative_order": d_lower <= d_upper,
    "derivative_upper_lt_one_eighth": d_upper < F(1, 8),
    "strong_concavity_allocation": F(191, 128) + F(1, 2)*F(1, 8)**2 == F(3, 2),
    "log2_upper_identity": F(2, 3)/(1-F(1, 3)**2) == F(3, 4),
    "lower_horizontal_constant": F(2393, 1000) + F(2525, 1000)*F(3, 2) == F(12361, 2000),
    "combined_constant": F(3434, 1000) + F(12361, 2000) == F(19229, 2000),
    "b9_at_Z18": F(19229, 2000) + 18 < 9*F(314, 100),
    "b10_at_Z20": F(19229, 2000) + 20 < 10*F(314, 100),
    "guard13_reserve": 2 - F(1, 2) - F(18, 13) == F(3, 26),
    "guard12_not_strict": F(1, 2) + F(18, 12) == 2,
    "actual_family_Z18_guard13": F(128160000 + 265800*13, 6) < F(8, 3)**18,
}
assert all(checks.values())
receipt = {
    "scope": "rational scalar witnesses; no logarithm, exponential, L-function or zero evaluation",
    "t0": u, "log_8_over_7_lower": log_lower, "log_8_over_7_upper": log_upper,
    "P6_upper": p_upper, "P6_derivative_lower": d_lower, "P6_derivative_upper": d_upper,
    "turing_numerator_at_Z18": F(19229, 2000) + 18,
    "checks": checks,
}
Path(__file__).with_suffix('.json').write_text(json.dumps(wire(receipt), indent=2) + '\n', encoding='utf-8')
print(f"PASS: {len(checks)} exact rational checks")
