"""Reconcile source/report bytes only. No Lean or analytic evaluation."""
from pathlib import Path
from hashlib import sha256
import re
import json

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/openai-math/lean/OAI/NumberTheory/DirichletL'
AGENTS = ROOT / 'work/qrh-campaign/agents'
AUTHOR = AGENTS / 'integration/QRH_RETAINED_WINDOW_ANALYTIC_AUDIT_2026-11-11.md'
EXPECTED = '994D7AE2F9A63CD1151268E8735D93C7A6E70F505C96714AB442FB77C4FFC58B'
assert sha256(AUTHOR.read_bytes()).hexdigest().upper() == EXPECTED
pins = re.findall(r'^\| ([^|]+?) \| ([A-F0-9]{64}) \|$', AUTHOR.read_text(encoding='utf-8'), re.M)
assert len(pins) == 44
records = []
for name, digest in pins:
    path = (SRC if name.endswith('.lean') else AGENTS) / name
    data = path.read_bytes()
    assert sha256(data).hexdigest().upper() == digest, name
    records.append({'path': name, 'sha256': digest, 'lines': len(data.splitlines())})
extra = []
for name in ['Descent/Basic.lean', 'Inversion/InitialEnergyCallerState.lean']:
    data = (SRC / name).read_bytes()
    extra.append({'path': name, 'sha256': sha256(data).hexdigest().upper(), 'lines': len(data.splitlines())})
out = {'scope': 'Byte reconciliation only; companion review specifies inspected proof bodies and lower boundaries.',
       'author_report_sha256': EXPECTED, 'expected_source_commit': '4eaee87548250b2682affda7d05d947c05554bae',
       'verified_author_pins': records, 'additional_inspected_sources': extra}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2) + '\n', encoding='utf-8')
print('32 source and 12 supporting-report pins verified; 2 additional source hashes recorded')
