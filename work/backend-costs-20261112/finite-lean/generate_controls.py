import json
import sys
from pathlib import Path
H=Path(__file__).resolve().parent
width=int(sys.argv[1]);f=json.loads((H/f'fixture{width}.json').read_text())['fixture']
data=f'FiniteData{width}';ns=f'FiniteP0N{width}'
mask=f'(2 ^ {width} - 1)'
good=f'PrimeCoverage.shiftedUnion {data}.source {data}.shifts &&& {mask}'
q=f['anchors'][0];s=f['shifts'][0]
cases=[('good_cover',f'({good}) == {mask}','accept'),
       ('empty_source',f'(PrimeCoverage.shiftedUnion 0 {data}.shifts &&& {mask}) == {mask}','reject'),
       ('empty_anchors',f'(PrimeCoverage.shiftedUnion {data}.source [] &&& {mask}) == {mask}','reject'),
       ('wrong_mask',f'({good}) == ({mask} - 1)','reject'),
       ('wrong_origin',f'({data}.first + 2 * {s} + {q}) == ({data}.target + 2)','reject'),
       ('bad_lucas_base',f'decide (Nat.powMod 1 (({q} - 1) / 2) {q} ≠ 1)','reject')]
lines=[f'import Block{width}','import Replay','set_option maxRecDepth 65536','set_option maxHeartbeats 0',f'namespace CoverageControls{width}']
for name,expr,outcome in cases:
    lines += [f'def {name} : Prop := ({expr}) = true',f'#kernel_control CoverageControls{width}.{name} {outcome}']
lines.append(f'end CoverageControls{width}')
(H/f'Controls{width}.lean').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
for label,root in [('full','binary_interval'),('source','source_primes'),('anchors','anchor_primes'),('cover','coverage')]:
    text=f'import Block{width}\nimport FiniteReplay\nset_option maxRecDepth 65536\nset_option maxHeartbeats 0\n#replay_cover "{label}" "{ns}." {width} 1 {ns}.{root}\n'
    (H/f'Replay{label.capitalize()}{width}.lean').write_text(text,encoding='utf-8',newline='\n')
print('controls and phase replays generated')
