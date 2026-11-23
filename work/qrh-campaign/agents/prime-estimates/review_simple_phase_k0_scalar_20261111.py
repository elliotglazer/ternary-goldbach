"""Independent exact algebra for the simple-phase K0 composition.
No author imports, special functions, interval library, or spectral data.
All analytic inputs retain the paper-proof status stated in the review.
"""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

checks = {}
def ck(name, value):
    assert value, name
    checks[name] = True

t0 = Q(1500)
gamma = Q(13, 50)
ck('weak_phase_threshold', gamma/(Q(1,40)-Q(1,48)) == Q(312,5) < t0)
weak_u = 8*(Q(1,48)+gamma/t0)
ck('weak_U_bound_after_tau_squared_division', weak_u < Q(1,5))
ck('tau_at_most_one_over_40', 8*t0 >= 40**2)
e1 = Q(42,10) + Q(1,5)*(1+Q(8,5)/40)
ck('E1_coefficient_below_441', e1 < Q(441,100))
r = Q(198,125)
ck('fourth_root_pi_upper_from_22_over_7', r**4 > Q(44,7))
ck('sqrt_height_lower', 38**2 < t0)
analytic = r**3/(3*Q(157,50)) + Q(441,100)*r/(8*38)
ck('reviewed_analytic_coefficient_identity', analytic == Q(3317717799,7457500000))
ck('analytic_coefficient_below_045', analytic < Q(45,100))
phase_at_t0 = 4*gamma/t0
ck('global_phase_relative_coefficient', phase_at_t0 == Q(13,18750))
final_coarse = Q(45,100)+phase_at_t0
final_sharp = analytic+phase_at_t0
ck('composed_coarse_below_0451', final_coarse < Q(451,1000))
ck('composed_coarse_below_047', final_coarse < Q(47,100))
ck('composed_sharper_below_coarse', final_sharp < final_coarse)
ck('pinned_047_alternative_below_0471', Q(47,100)+phase_at_t0 < Q(471,1000))
ck('finite80_phase_at_endpoint', 80*gamma/t0**2 < Q(1,100000))
ck('global_045_slack', Q(47,100)-final_coarse > 0)

out = {
    'status': 'PASS independent exact conditional algebra',
    'checks': checks,
    'check_count': len(checks),
    'weak_U_relative_to_tau_squared': str(weak_u),
    'E1_relative_to_tau_squared': str(e1),
    'reviewed_analytic_coefficient': str(analytic),
    'global_phase_relative_coefficient_upper': str(phase_at_t0),
    'coarse_composed_coefficient': str(final_coarse),
    'sharper_composed_coefficient': str(final_sharp),
    'remaining_to_047': str(Q(47,100)-final_coarse),
    'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'scope': 'Exact scalar composition only. Normalized Binet, finite-sum integral comparison, actual-Hardy adapter, Mordell/RS contours and low-order analytic remainder still require proof.'
}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2)+'\n')
print(json.dumps(out, indent=2))
