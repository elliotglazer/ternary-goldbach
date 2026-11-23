"""Exact scalar/algebra checks for the coarse Binet phase derivation.
No Gamma, zeta, spectral data, floating-point acceptance, or Lean execution.
Analytic identities are proved in the accompanying note, not by these checks.
"""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

checks = {}

def check(name, proposition):
    assert proposition, name
    checks[name] = True

def derivative(p):
    return [j * p[j] for j in range(1, len(p))]

P2 = [Q(1, 6), Q(-1), Q(1)]
P3 = [Q(0), Q(1, 2), Q(-3, 2), Q(1)]
check('P3_derivative_is_3P2', derivative(P3) == [3 * x for x in P2])
check('P3_endpoints_zero', P3[0] == 0 and sum(P3) == 0)
check('P2_endpoints_one_sixth', P2[0] == sum(P2) == Q(1, 6))
check('P2_prime_endpoints_minus_plus_one', derivative(P2)[0] == -1 and sum(derivative(P2)) == 1)
check('P2_second_derivative_two', derivative(derivative(P2)) == [Q(2)])
# In powers u^-1,u^-2,u^-3, the finite-cell Laplace integral is
# C0 + exp(-u)*C1, obtained from -exp(-ux)(P2/u+P2'/u²+P2''/u³).
C0 = [P2[0], derivative(P2)[0], derivative(derivative(P2))[0]]
C1 = [-sum(P2), -sum(derivative(P2)), -sum(derivative(derivative(P2)))]
check('unit_Laplace_coefficients', C0 == [Q(1,6),Q(-1),Q(2)] and C1 == [Q(-1,6),Q(-1),Q(-2)])
check('B3_bound_product', Q(1,4)*Q(1,2) == Q(1,8))
check('split_cubic_integral_constant', Q(1)+Q(1,2) == Q(3,2))
check('Binet_remainder_t_constant', Q(1,3)*Q(1,8)*Q(3,2)*4 == Q(1,4))
check('first_phase_coefficient', Q(1,16)+Q(1,8)-Q(1,6) == Q(1,48))
check('phase_elementary_error', Q(1,128)+Q(1,96)+Q(1,24) == Q(23,384))
t = Q(1500)
fine = Q(1,4)/t**2 + Q(23,384)/t**3
coarse = Q(13,50)/t**2
check('coarse_enlargement_at_lower_endpoint', fine < coarse)
check('80_times_phase_below_1e_minus_5', 80*coarse < Q(1,100000))
check('weak_phase_below_one_over_40t', Q(1,48)+Q(13,50)/t < Q(1,40))
check('weak_phase_threshold', Q(13,50)/(Q(1,40)-Q(1,48)) == Q(312,5))
check('K0_slack_threshold', (80*Q(13,50))/Q(2,100) == Q(1040))
check('conditional_045_base_plus_finite80_phase_via_t_power_ge_t', Q(45,100)+80*Q(13,50)/t < Q(47,100))
check('pinned_047_base_plus_global_amplitude_phase_below_0471', Q(47,100)+4*Q(13,50)/t < Q(471,1000))
check('conditional_045_base_plus_global_amplitude_phase_below_0451', Q(45,100)+4*Q(13,50)/t < Q(451,1000))

out = {
    'status': 'PASS exact rational scalar and polynomial checks',
    'checks': checks,
    'check_count': len(checks),
    'height_lower_bound': str(t),
    'phase_error_coarse_at_1500': str(coarse),
    'phase_error_unrounded_at_1500': str(fine),
    '80_times_coarse_at_1500': str(80*coarse),
    'conditional_045_base_finite80_combined_coefficient': str(Q(45,100)+80*Q(13,50)/t),
    'pinned_047_base_global_combined_coefficient': str(Q(47,100)+4*Q(13,50)/t),
    'conditional_045_base_global_combined_coefficient': str(Q(45,100)+4*Q(13,50)/t),
    'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'scope': 'Checks algebra and scalar margins only; Binet, Fubini, integration by parts, normalized phase and K0 remainder remain analytic proof tasks.'
}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2)+'\n')
print(json.dumps(out, indent=2))
