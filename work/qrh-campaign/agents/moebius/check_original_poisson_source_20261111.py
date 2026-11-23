"""Read-only byte provenance for the original Poisson source review.

No Lean import, build, special-function evaluation, or proof validation.
"""
from hashlib import sha256
from pathlib import Path
import json
import re

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/openai-math/lean/OAI/NumberTheory/DirichletL'
AUTHOR = ROOT / 'work/qrh-campaign/agents/integration/QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md'
EXPECTED = 'DE7237156824F7503A51F36A9E4A777F57647F2FC98F82D624D000E5D5C12AFA'
assert sha256(AUTHOR.read_bytes()).hexdigest().upper() == EXPECTED
pins = re.findall(r'^\| `([^`]+)`(?: \(outside B\))? \| `([A-F0-9]{64})` \|$', AUTHOR.read_text(encoding='utf-8'), re.M)
assert len(pins) == 18
rows = []
for name, expected in pins:
    path = ROOT / name if name.startswith('work/') else SRC / name
    raw = path.read_bytes()
    digest = sha256(raw).hexdigest().upper()
    assert digest == expected, name
    rows.append({'path': name, 'sha256': digest, 'lines': len(raw.splitlines())})
out = {'scope': 'Source-byte reconciliation only; inspected mathematical bodies are specified in the companion review.',
       'expected_source_commit': '4eaee87548250b2682affda7d05d947c05554bae',
       'author_report_sha256': EXPECTED, 'verified_author_pins': rows}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2) + '\n', encoding='utf-8')
print('18 author source/manifest hashes verified; no analytic evaluation or build')
