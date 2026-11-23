"""An exact-statement A/B against all four prior 21-declaration fixtures."""
from pathlib import Path
import re,json,hashlib
H=Path(__file__).resolve().parent
original=H.parent/'arithmetic-calibration/ArithmeticComplete.lean'
source=original.read_text(encoding='utf-8').split('namespace Replay')[0]
source=source.replace('namespace Fixture','namespace LegacyP0N4').replace('end Fixture','end LegacyP0N4')
(H/'LegacyP0N4.lean').write_text(source,encoding='utf-8')
finals=re.findall(r'^theorem (\w+_certificate) : (.*?) := by exact',source,re.M)
assert len(finals)==4
condensed=['import LegacyP0N4','namespace CondensedP0N4']
for name,statement in finals:
    condensed.append(f'theorem {name} : {statement} := by decide +kernel')
condensed.append('end CondensedP0N4')
(H/'CondensedP0N4.lean').write_text('\n'.join(condensed)+'\n',encoding='utf-8')
for v in ['Legacy','Condensed']:
    (H/f'Replay{v}P0N4.lean').write_text(
        f'import {v}P0N4\nimport Replay\n#replay_stage "{v}" 0 4 50 ['+
        ', '.join(f'{v}P0N4.{name}' for name,_ in finals)+']\n')
(H/'legacy_comparison.json').write_text(json.dumps(dict(
    original_sha256=hashlib.sha256(original.read_bytes()).hexdigest(),
    declarations=[name for name,_ in finals],exact_statement_match=True),indent=2)+'\n')
