"""Independent scalar replay. No Lean, zero certification, or prime enumeration."""
from pathlib import Path
from fractions import Fraction as F
from contextlib import redirect_stdout
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
SOURCE = AGENTS / 'integration/resume_psi_finite_strip_20261111.py'
REPORT = AGENTS / 'integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md'
REPLAY = HERE / 'resume_psi_strip_replay_20261111.py'

# The producer derives its sole output path from __file__. Redirect that path;
# compile still records the original input filename for useful tracebacks.
namespace = {'__file__': str(REPLAY), '__name__': '__independent_replay__'}
with (HERE / 'resume_psi_strip_replay_20261111.log').open('w', encoding='utf-8') as stream:
    with redirect_stdout(stream):
        exec(compile(SOURCE.read_text(encoding='utf-8'), str(SOURCE), 'exec'), namespace)

el = namespace['exp_lower']
eu = namespace['exp_upper']
L0 = F(35)
delta2 = F(1, 10**6) / L0**3
a0 = F(1, 1000) / L0

# Local translated-mass quadratic is concave, so endpoint tests suffice.
mass_endpoints = [a - F(8,25)*(a*a+F(9,4)) for a in [F(9,8),F(15,8)]]
assert min(mass_endpoints) >= 0
assert F(12) / F(8,25) < 38

# Derivative conditions used for the all-scale, rather than sampled, proof.
Cmin = F(76) / F(89,200)
assert 1/L0 + 38/(L0*Cmin) < F(89,200)
assert L0 > F(5,2) / F(1)  # L^(5/2) exp(-L)
assert L0 > F(5,2) / F(3,2)
assert F(200) > 8*7  # Covers L^4 and L^7 exp(-L/8).
assert L0 > 2  # L exp(-L/2), and the cutoff term.
assert 3*F(1,1000) < 1  # In particular 3 delta < 1 at L>=35.
assert L0 > 10+a0
assert el(10) > 10000
assert delta2 < 1 and delta2 < L0
assert 2 / el(L0/2) < 1
assert eu(delta2/8+a0/2) < F(1001,1000)

# An exact elementary bound for the Euler-series term of the xi estimate.
assert el(F(11,10)) > 3
assert F(7,10)/4 + F(11,10)/9 + (F(11,10)+1)/3 < 1

root = AGENTS.parents[2]
source_root = root / 'work/ternary-goldbach/TernaryGoldbach'
paths = [REPORT, SOURCE, AGENTS / 'integration/RESUME_PRINCIPAL_REVIEW_2026-11-11.md']
paths += [source_root / ('Explicit/'+p+'.lean') for p in [
    'XiPartial','Xi','WeilBridge','ZetaDatum','ZeroSumGen','ZetaZeroSums',
    'GaussSmooth','ZetaExplicit','PsiExplicit','PsiSandwich','PsiLarge']]
evidence = {
    'status': 'PASS: conditional paper/scalar audit only',
    'source_sha256': {str(p.relative_to(root)): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
    'extra_exact_checks': {
        'mass_endpoint_margins': [str(v) for v in mass_endpoints],
        'mass_count_upper': str(F(12)/F(8,25)),
        'low_log_derivative_upper_at_35': str(1/L0+38/(L0*Cmin)),
    },
    'replayed_exact_endpoint_bounds': namespace['result']['exact_endpoint_scaled_bounds'],
    'open': ['finite zeta strip beta<=111/200 through H=60343058',
             'genuine global 7/8 provider closure',
             'analytic bridge formalization including actual multiplicities',
             'psi envelope on [1e9,exp(35))'],
}
out = HERE / 'resume_psi_strip_audit_20261111.json'
out.write_text(json.dumps(evidence, indent=2)+'\n', encoding='utf-8')
print(json.dumps(evidence, indent=2))
