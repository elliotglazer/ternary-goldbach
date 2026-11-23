"""Exact rational consumer checks only; no analytic function evaluation."""
from fractions import Fraction as F
from pathlib import Path
import json

target = F('7.83e-13')
energy = F('7.02e-13')
principal = F('2.83e-7')
removal = F('1e-15')
root_cap = F('8.844e-7')
full_cap = root_cap + 516 * removal
old = F('4.25e-7') ** 2
checks = {
    'phi_root_cap': 265800 < 516**2,
    'coprime_centered_cap': energy + principal**2 < root_cap**2,
    'full_residual_cap': full_cap**2 < target,
    'downstream_rho': target < F('8.85e-7')**2,
    'principal_delta_domain': 8 * 132900 // 2 < 600000,
    'original_q_domain': 2 * 132900 < 300000,
    'larger_energy_allowance': energy > old,
    'generic_energy_countermodel': F(1, 6) > energy,
}
assert all(checks.values())
def rat(x):
    return {'numerator': x.numerator, 'denominator': x.denominator}
out = {
    'scope': 'Fraction arithmetic only; conditional consumer implication, no new energy bound',
    'checks': checks,
    'energy': rat(energy), 'old_energy': rat(old),
    'allowance_ratio': rat(energy / old),
    'coprime_norm_square_cap': rat(energy + principal**2),
    'full_norm_square_cap': rat(full_cap**2),
    'strict_residual_reserve': rat(target - full_cap**2),
    'countermodel_energy': rat(F(1, 6)),
}
path = Path(__file__).with_suffix('.json')
path.write_text(json.dumps(out, indent=2) + '\n', encoding='utf-8')
print(json.dumps({'checks': len(checks), 'all_pass': True}))
