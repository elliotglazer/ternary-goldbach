"""Exact rational bounds and metadata only; no source coefficient evaluation."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

checks = 0

def verify(condition):
    global checks
    assert condition
    checks += 1

b = [100, 100] + [100-j for j in range(2, 20)]
verify(len(b) == 20 and min(b) == 81)
verify(F(1, 2) < F(9, 16))
s19 = sum(F(2)**(100-b[j]) * F(1, 4)**j for j in range(20))
s18 = sum(F(2)**(100-b[j]) * F(1, 4)**j for j in range(19))
verify(s19 == F(7, 4)-F(1, 2**19))
verify(s18 == F(7, 4)-F(1, 2**18))
error = F(3, 4)*(s19+s18)
verify(error < F(21, 8) < F(8, 3))
verify(F(8, 3)-error > F(1, 24))
verify(633*F(21, 8) == F(13293, 8) < 1688)
verify(sum(b) == 1811)
verify(sum(b[:19]) == 1730)
verify(F(40665)+F(3, 4)*F(2)**(-81) < 2**16)
verify(F(2**17, 4)+2**16+1 < 2**17)
verify(F(265800, 2) < 2**18)
verify(2*265800 < 2**20)
rows = []
for j in range(19):
    delta = b[j]-b[j+1]
    verify(delta == (0 if j == 0 else 2 if j == 1 else 1))
    verify(b[j+1]+17+18+delta == b[j]+35)
    verify(2**(b[j]+15)+F(1, 2) < 2**(b[j]+16))
    verify(2**(b[j]+35)+2**(b[j]+36) < 2**(b[j]+37))
    rows.append(dict(stage=j, fractional_bits=b[j], alignment_shift=delta,
                     accumulator_signed_bits=b[j]+18,
                     raw_product_signed_bits=b[j]+36,
                     residual_signed_bits=b[j]+38,
                     doubled_residual_signed_bits=b[j]+39))

base = Path(__file__).resolve().parent.parent/'qrh-campaign'/'agents'
pins = {
    'integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':
        '9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4',
    'integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md':
        'B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815',
    'audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':
        '793AD4410778F45B39040F246B361E8877876ABA11083A2C9492288B2492B16D',
}
for path, expected in pins.items():
    verify(hashlib.sha256((base/path).read_bytes()).hexdigest().upper() == expected)

result = dict(checks=checks, grid=b, coefficient_weight=str(s19),
              arithmetic_weight=str(s18), error_in_u=str(error),
              reserve_in_u=str(F(8, 3)-error), stage_widths=rows,
              input_pins=pins,
              scope='Exact scalar bounds only; no actual coefficients or kernel proofs.')
output = Path(__file__).with_suffix('.json')
output.write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
print(json.dumps({'checks': checks, 'receipt': str(output), 'error_in_u': str(error)}))
