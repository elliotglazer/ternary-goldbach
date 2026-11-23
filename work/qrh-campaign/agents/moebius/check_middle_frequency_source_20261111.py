"""Byte reconciliation only: no Lean or analytic evaluation."""
from pathlib import Path
from hashlib import sha256
import re
import json

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/openai-math/lean/OAI/NumberTheory/DirichletL'
AGENTS = ROOT / 'work/qrh-campaign/agents'
AUTHOR = AGENTS / 'integration/QRH_MIDDLE_FREQUENCY_ANALYTIC_AUDIT_2026-11-11.md'
EXPECTED = '1B4B178F58A8DE23573F978D0C302F2AD2D02FEC5D31474BD9DE81B264F1348B'
assert sha256(AUTHOR.read_bytes()).hexdigest().upper() == EXPECTED
pins = re.findall(r'^\| ([^|]+?) \| ([A-F0-9]{64}) \|$', AUTHOR.read_text(encoding='utf-8'), re.M)
assert len(pins) == 16
records = []
for name, digest in pins:
    path = (SRC if name.endswith('.lean') else AGENTS) / name
    data = path.read_bytes()
    assert sha256(data).hexdigest().upper() == digest, name
    records.append({'path': name, 'sha256': digest, 'lines': len(data.splitlines())})
out = {'scope': 'Byte reconciliation only; companion review specifies inspected proof bodies and lower boundaries.',
       'author_report_sha256': EXPECTED,
       'expected_source_commit': '4eaee87548250b2682affda7d05d947c05554bae',
       'verified_author_pins': records}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2) + '\n', encoding='utf-8')
print('10 source and 6 supporting-report pins verified')
