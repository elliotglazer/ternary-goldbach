"""Exact scalar receipt for the simple-phase K0 paper assembly.

Analytic identities, integral inequalities, and interval semantics are not
proved by these rational checks. No floating comparison controls acceptance.
"""
from fractions import Fraction as F
from pathlib import Path
import json

checks = {}
values = {}

def record(name, lhs, rhs):
    assert lhs < rhs, name
    checks[name] = {"lhs": str(lhs), "rhs": str(rhs), "relation": "<"}

t0 = F(1500)
record("coarse_phase_from_B3", F(1,4)+F(23,384)/t0, F(13,50))
record("weak_U_phase", F(1,48)+F(13,50)/t0, F(1,40))
assert F(1,40) == F(1,8)/5  # tau^2=1/(8t)
record("tau_le_one_over_40_squared", F(1,8)/t0, F(1,40)**2)

# Reproduce the scalar part of the accepted first-order reduction.
w = F(17,36)
y2 = F(250,1099)*(F(3,2)/w+F(5,6)/w**2+F(1,9)/w**3)
y3 = F(100,157)*(F(3,2)+F(5,3)+F(4,9))
y1 = F(22000,300000000)
y4 = F(39*450000,2**40)
record("RS1_constant", y1+y2+y3+y4, F(42,10))
record("U_times_polynomial", F(1,5)*(1+F(8,5)/40), F(21,100))
assert F(42,10)+F(21,100) == F(441,100)
r = F(198,125)
record("pi_fourth_root_upper", F(44,7), r**4)
record("sqrt_t_lower_squared", F(38**2), t0)
base = r**3/(3*F(157,50))+F(441,100)*r/(8*38)
record("actual_phase_K0", base, F(45,100))

phase_relative = F(26,25)/t0
record("global_main_sum_phase", phase_relative, F(1,1000))
record("simple_phase_using_045", F(45,100)+phase_relative, F(451,1000))
record("simple_phase_exact_base", base+phase_relative, F(451,1000))
record("published_allowance_retained", F(451,1000), F(47,100))
assert F(47,100)-F(451,1000) == F(19,1000)
values["base_coefficient"] = str(base)
values["phase_relative_upper"] = str(phase_relative)
values["base_045_plus_phase"] = str(F(45,100)+phase_relative)
values["analytic_bound_selected"] = "451/1000 * t^(-3/4), t>=1500"
values["arithmetic_room_if_using_047"] = "19/1000 * t^(-3/4)"
receipt = {
    "status": "PASS: exact scalar assembly only; analytic and checker proofs remain open",
    "scope": "all real t>=1500 after the monotonicity and amplitude lemmas in the note",
    "checks": checks,
    "values": values,
    "uses_sharp_Gabcke_phase": False,
    "uses_finite_zero_data": False,
}
out = Path(__file__).with_suffix('.json')
out.write_text(json.dumps(receipt, indent=2)+'\n', encoding='utf-8')
print(json.dumps(receipt, indent=2))
