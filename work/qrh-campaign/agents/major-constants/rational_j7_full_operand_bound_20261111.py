"""Scalar/size inventory only. Does not import or run either evaluator.

Reads immutable JSON encodings to measure integer sizes, never evaluates an
elementary function, finite-g model, or interval image.
"""
import hashlib
import json
import math
from pathlib import Path

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    "integration/rational_direct_g_j7_producer_20261111.py": "B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7",
    "moebius/rational_direct_g_j7_independent_20261111.py": "4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC",
    "integration/small_em_batch_candidate_20261111_01.json": "2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E",
}
for name, digest in PINS.items():
    assert hashlib.sha256((AGENTS / name).read_bytes()).hexdigest().upper() == digest

data = json.loads((AGENTS / "integration/small_em_batch_candidate_20261111_01.json").read_text())
def literal_integer_bits(value):
    if type(value) is int:
        return abs(value).bit_length()
    if isinstance(value, dict):
        return max([0] + [literal_integer_bits(v) for v in value.values()])
    if isinstance(value, list):
        return max([0] + [literal_integer_bits(v) for v in value])
    return 0
all_integer_bits = literal_integer_bits(data)
assert all_integer_bits < 64
stats = {"rational_numerator_bits": 0, "rational_denominator_bits": 0,
         "dyadic_mantissa_bits": 0, "dyadic_expanded_numerator_bits": 0,
         "dyadic_denominator_exponent": 0}
def visit(value):
    if isinstance(value, dict):
        if set(value) == {"numerator", "denominator"}:
            p, q = int(value["numerator"]), int(value["denominator"])
            assert q > 0
            stats["rational_numerator_bits"] = max(stats["rational_numerator_bits"], abs(p).bit_length())
            stats["rational_denominator_bits"] = max(stats["rational_denominator_bits"], q.bit_length())
        elif set(value) == {"mantissa", "exponent"}:
            m, e = int(value["mantissa"]), value["exponent"]
            assert type(e) is int
            stats["dyadic_mantissa_bits"] = max(stats["dyadic_mantissa_bits"], abs(m).bit_length())
            stats["dyadic_expanded_numerator_bits"] = max(stats["dyadic_expanded_numerator_bits"], abs(m).bit_length()+max(e,0))
            stats["dyadic_denominator_exponent"] = max(stats["dyadic_denominator_exponent"], max(-e,0))
        else:
            for x in value.values(): visit(x)
    elif isinstance(value, list):
        for x in value: visit(x)

visit({"parameters": data["parameters"], "analytical_budget": data["analytical_budget"],
       "g": data["g_jets"][7], "panel": data["panels"][7], "endpoints": data["endpoints"][7:9]})
assert all(n < 2048 for n in stats.values())
mid_exponent = max(max(-c[a]["mid"]["exponent"], 0)
                   for c in data["g_jets"][7]["coefficients"] for a in ("re", "im"))
E = max(52, mid_exponent)

# Deliberately coarse common denominator; no numerical Bernoulli values needed.
g = 1057
DG = 2 * 10000**32 * math.factorial(33) * math.factorial(32) * 1025**31 * math.factorial(15) * 2**(16*g)
DS = 6 * 2**1593 * math.factorial(513) * 1025 * 3**1025 * 513 * 5**513
DPAD = 63 * 6150**32 * 15 * 2**33
assert DG < 2**20000 and DS < 2**10000
assert math.factorial(513) * 2**513 < 2**6000
assert DG.bit_length() < 18000
assert E < 2048
# Padded numerator image denominators divide 2^(E+64)*DPAD.
# A common denominator for each reciprocal rectangle is <2^114.
image_den_exponent = E + 64 + DPAD.bit_length() + 114
assert image_den_exponent < 3000

result = {
    "scope": "scalar bounds and immutable encoding sizes only; no evaluator imports, elementary/model/image evaluations",
    "pins": PINS, "target_size_statistics": stats,
    "all_target_json_integer_literal_bits": all_integer_bits,
    "old_coefficient_common_dyadic_exponent": E,
    "finite_g_common_denominator_bits": DG.bit_length(),
    "scalar_validator_common_denominator_bits": DS.bit_length(),
    "image_padding_common_denominator_bits": DPAD.bit_length(),
    "image_common_denominator_strict_power2_exponent": image_den_exponent,
    "global_reduced_denominator_strict_power2_exponent": 20000,
    "global_rational_magnitude_strict_power2_exponent": 6000,
    "raw_helper_product_strict_power2_exponent": 52000,
    "raw_helper_sum_strict_power2_exponent": 52001,
    "rounding_witness_strict_power2_exponent": 27090,
    "checked_bit_cap": 65536,
}
assert 52001 < 65536 and 27090 < 65536
(HERE / "rational_j7_full_operand_bound_20261111.json").write_text(json.dumps(result, indent=2)+"\n")
print(json.dumps(result, indent=2))
