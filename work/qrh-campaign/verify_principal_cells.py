"""Independently check completeness, hashes, and CELL inequalities in the run log.

This replays the final inequalities from recorded Gram norm enclosures. It does
not recompute the Gram integrals and is not a Lean proof.
"""
from pathlib import Path
import hashlib
import json
from flint import arb, ctx

ctx.prec = 160
root = Path(__file__).resolve().parent / 'agents' / 'mellin'
source = root / 'joint_principal_certificate.py'
records = [json.loads(line) for line in (root / 'joint-principal-cells.jsonl').read_text(encoding='utf-8-sig').splitlines()]
header = records[0]
summary = records[-1]
cells = [r for r in records if r['kind'] == 'cell']
assert header['kind'] == 'header'
assert header['start'] == 0 and header['stop'] == 2750
assert header['source_sha256'] == hashlib.sha256(source.read_bytes()).hexdigest()
assert len(cells) == 2750
assert [r['index'] for r in cells] == list(range(2750))
assert summary['kind'] == 'summary' and summary['status'] == 'PASS_ALL_2750'
assert summary['processed'] == 2750 and summary['failed'] == []
assert (root / 'joint-principal-cells.exit').read_text(encoding='utf-8-sig').strip() == '0'
digest = hashlib.sha256()
maximum = arb(0)
for r in cells:
    digest.update(json.dumps(r, sort_keys=True).encode())
    k = r['index']
    if k < 2400:
        a, b = 16 + arb(k) / 100, 16 + arb(k + 1) / 100
    else:
        a, b = 40 + arb(k - 2400) / 10, 40 + arb(k - 2399) / 10
    assert abs(arb(r['left']) - a) < arb('1e-30')
    assert abs(arb(r['right']) - b) < arb('1e-30')
    assert abs(arb(r['gamma']) - (a + b) / 2) < arb('1e-30')
    assert r['passed'] is True and arb(r['ratio_upper']) < 85
    arg = arb(r['N0_upper']).upper() + arb(626) / 1000 * (b - a) / 2 + arb(313) / 100000
    threshold = arb(626) / 61000
    if arg >= threshold:
        f = arg
    elif arg <= threshold:
        f = threshold * (arg / threshold - 1).exp()
    else:
        f = arg.union(threshold * (arg / threshold - 1).exp())
    result = (b*b + arb(225)/64) / 6 * (f + arb('1e-9'))
    assert result < 85, (k, result)
    if result.upper() > maximum:
        maximum = result.upper()
assert digest.hexdigest() == summary['cell_records_sha256']
print(json.dumps({
    'status': 'PASS', 'checked_cells': len(cells),
    'recomputed_maximum_upper': str(maximum),
    'source_sha256': header['source_sha256'],
    'cell_records_sha256': digest.hexdigest(),
    'scope': 'Complete log and final inequality replay; Gram enclosures originate from the reviewed Arb checker, not Lean.'
}, indent=2))
