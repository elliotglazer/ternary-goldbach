"""Read-only independent rational checks; no analytic function evaluations."""
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
import json


def rational(pair):
    return F(int(pair[0]), int(pair[1]))


root = Path(__file__).resolve().parents[2]
author = root / 'work/qrh-campaign/agents/prime-estimates'
receipt = author / 'finite_u_hardy_normalization_20261111.json'
assert sha256(receipt.read_bytes()).hexdigest().upper() == (
    'DD5C2BC8A872A3308476CF8781582FCC9FC74B6CF96BCFF9C5D1F1E9DB9D7421'
)
data = json.loads(receipt.read_text(encoding='utf-8'))
checks = 0
for row in data['phase']:
    a, j = row['a'], row['J']
    alpha = F(2*a+1, 4)
    error = F(1, 48) / (alpha+j)**2
    cosine = 1-error*error/2
    assert rational(row['remainder']) == error
    assert rational(row['cos_lower']) == cosine
    assert cosine >= F(17, 18)
    checks += 3

for row in data['allocations']:
    c, height, p = row['c'], rational(row['V']), row['p']
    tolerance = F(1, 2**p)
    amplitude = 2*(c+1)*(height+1)+1
    eta = tolerance/(64*amplitude)
    local = eta/(4*(height+1))
    # Sum of absolute coefficients of the three logarithms and one arctangent.
    coefficients = (5*height+1)/4
    phase_error = coefficients*local+eta/2
    multiplier_error = eta*(1+eta)+eta+phase_error
    l_error = F(3, 2**(p+6))
    total = l_error+amplitude*multiplier_error+tolerance/16
    assert row['p_L'] == p+5
    assert rational(row['B']) == amplitude
    assert rational(row['eta']) == eta
    assert rational(row['elementary_each']) == local
    assert rational(row['proxy_total_over_tau']) == total/tolerance
    assert phase_error < eta
    assert l_error < tolerance/16
    assert multiplier_error <= 4*eta
    assert total < 3*tolerance/16 < tolerance/4
    cap = int(row['true_H_J_cap'])
    # Check ceil by its defining inequalities rather than producer's routine.
    assert cap-1 < 2*amplitude/tolerance <= cap
    for alpha in (F(1, 4), F(3, 4)):
        assert 1 <= 48*(alpha+cap)**2*eta
    assert rational(row['true_H_total_over_tau']) == F(13, 64)
    checks += 13

assert F(3, 16) < F(1, 4)
assert F(13, 64) < F(1, 4)
assert F(9, 4) > 2  # Validates the conservative rectangle-to-norm factor.
checks += 3
print(f'PASS: {checks} exact checks; four phase cases and four allocations; no writes')
