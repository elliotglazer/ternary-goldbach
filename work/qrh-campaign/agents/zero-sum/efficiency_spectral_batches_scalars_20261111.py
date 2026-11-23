"""Integer/Fraction metadata only. No analytic-function or character evaluation."""
from fractions import Fraction as F
from math import factorial
import json
from pathlib import Path

J, L, modes = 1024, 4096, 24
checks = {
    "24_factorial_gt_2_79": factorial(24) > 2**79,
    "main_profile_X_lt_2_28": 135_000_000 + 42 * 300_000 < 2**28,
    "head_residual_lt_2_minus64": F(2**15, factorial(24)) < F(1, 2**64),
    "M18_point_EM_lt_2_minus68": F(4 * 2**28, 36**18) * F(2, 71) < F(1, 2**68),
    "Q24_pole_tail_lt_2_minus67": F(3 * 2**14, factorial(24) * 25) < F(1, 2**67),
    "analytic_sum_lt_one_eighth_tau60": F(1, 2**68) + F(1, 2**64) + F(1, 2**67) < F(1, 8 * 2**60),
}
assert all(checks.values())
rows = []
for c, v, primitive in [(262144, 131072, 65536), (5, 4, 3)]:
    H = F(100_000_000, c) if c % 2 else max(F(100_000_000, c), 200 + F(75_000_000, c))
    T = H.numerator // H.denominator + 1
    N = T + 40
    rows.append(dict(c=c, v=v, primitive=primitive, H=str(H), T=T, N=N,
        J=J, L=L, residual_orders=modes, head_terms=v*N,
        direct_height_contributions=v*N*J, direct_phase_steps=v*N*(J-1),
        batch_moment_contributions=v*N*modes,
        time_butterflies=v*modes*(L//2)*12,
        mode_contraction_terms=v*J*modes,
        dense_moment_slots=v*modes*L, one_mode_slots=v*L,
        contracted_residue_slots=v*J))
precision = []
for b in [0, 10, 20]:
    scale = 2**29 * 2**b * (2 + 3*29) * modes
    P = 60 + (scale - 1).bit_length()
    assert F(scale, 2**P) <= F(1, 2**60)
    assert F(scale, 2**(P-1)) > F(1, 2**60)
    precision.append(dict(stages=29, output_bits=60, input_scale_exponent=b,
                          residual_orders=modes, sufficient_fractional_bits=P))
receipt = dict(status="PASS_EXACT_SCALAR_AND_LITERAL_COUNT_CHECKS",
               checks=checks, rows=rows, precision_examples=precision,
               scope="No value, margin, FFT, spectral assertion or runtime measurement")
path = Path(__file__).with_suffix('.json')
path.write_text(json.dumps(receipt, indent=2) + '\n', encoding='utf8', newline='\n')
print(json.dumps(receipt, indent=2))
