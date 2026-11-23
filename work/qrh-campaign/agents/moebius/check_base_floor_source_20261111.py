"""Read-only source-pin reconciliation; exact scalar identities, no analytic evaluation."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
import json
import re

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/openai-math/lean/OAI/NumberTheory/DirichletL'
AUTHOR = ROOT / 'work/qrh-campaign/agents/integration/QRH_BASE_FLOOR_ANALYTIC_AUDIT_2026-11-11.md'
EXPECTED = '7EBE8A5D2A7E2D4B78416A5BB34E1C7EF34E50155A25461A05C698F4989CEF7E'
assert sha256(AUTHOR.read_bytes()).hexdigest().upper() == EXPECTED
pins = re.findall(r'^\| `([^`]+)` \| `([A-F0-9]{64})` \|$', AUTHOR.read_text(encoding='utf-8'), re.M)
assert len(pins) == 36
records = []
for name, expected in pins:
    path = (ROOT if name.startswith('work/') else SRC) / name
    data = path.read_bytes()
    actual = sha256(data).hexdigest().upper()
    assert actual == expected, name
    records.append({'path': name, 'sha256': actual, 'lines': len(data.splitlines())})
extra = []
for name in ['Moments/RayNonprincipal.lean', 'Moments/PrimeGlobal.lean']:
    data = (SRC / name).read_bytes()
    extra.append({'path': name, 'sha256': sha256(data).hexdigest().upper(), 'lines': len(data.splitlines())})
checks = {
    'original_growth_modulus': F(3,5)+F(1,10)+F(3,10) == 1,
    'zero_floor_extra_le_one_half': F(1,4)+4*F(1,16) == F(1,2),
    'positive_floor_extra': F(3,4)+F(1,96) == F(73,96) < 1,
    'positive_floor_reserve': 1-(F(3,4)+F(1,96)) == F(23,96),
    'positive_kappa_lower': 2*F(51,100)-1 == F(1,50) > 0,
    'height_budget': 8*F(1,32)+F(1,2) == F(3,4) < 1,
    'height_auxiliary_smallness': F(1,2000) < F(1,1000),
}
assert all(checks.values())
out = {'scope': 'Byte reconciliation and exact rational scalar checks only; no Lean or analytic evaluation.',
       'author_report_sha256': EXPECTED,
       'expected_source_commit': '4eaee87548250b2682affda7d05d947c05554bae',
       'verified_author_pins': records, 'additional_read_source_pins': extra,
       'exact_scalar_checks': checks}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2)+'\n', encoding='utf-8')
print('31 source and 5 scope pins verified; 2 additional source pins; 7 exact scalar checks passed')
