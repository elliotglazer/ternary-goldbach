"""Reconcile frozen source bytes. No Lean or analytic function evaluation."""
from pathlib import Path
from hashlib import sha256
import re
import json

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/openai-math/lean/OAI/NumberTheory/DirichletL'
AUTHOR = ROOT / 'work/qrh-campaign/agents/integration/QRH_ZERO_GROWTH_RECOVERY_ANALYTIC_AUDIT_2026-11-11.md'
EXPECTED = 'E7E7459604669F251BDC7A1FE196CEDCC734D1AF37C4005B96EA1781F4CA720D'
assert sha256(AUTHOR.read_bytes()).hexdigest().upper() == EXPECTED
pins = re.findall(r'^\| `([^`]+)` \| `([A-F0-9]{64})` \|$', AUTHOR.read_text(encoding='utf-8'), re.M)
assert len(pins) == 38
records = []
for name, expected in pins:
    path = (ROOT if name.startswith('work/') else SRC) / name
    data = path.read_bytes()
    actual = sha256(data).hexdigest().upper()
    assert actual == expected, name
    records.append({'path': name, 'sha256': actual, 'lines': len(data.splitlines())})
extra = []
for name in ['Energy/ZeroReferenceChild.lean', 'Energy/ReferenceLowChild.lean',
             'Energy/ReferenceState.lean', 'Energy/ReferenceDivisors.lean',
             'Energy/ReferenceProfileBudget.lean']:
    data = (SRC / name).read_bytes()
    extra.append({'path': name, 'sha256': sha256(data).hexdigest().upper(), 'lines': len(data.splitlines())})
out = {'scope': 'Byte reconciliation only; mathematical derivations and explicit lower cut are in the companion review.',
       'author_report_sha256': EXPECTED,
       'expected_source_commit': '4eaee87548250b2682affda7d05d947c05554bae',
       'verified_author_pins': records, 'additional_read_source_pins': extra}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2)+'\n', encoding='utf-8')
print('31 source and 7 prior-scope pins verified; 5 additional read-source hashes recorded')
