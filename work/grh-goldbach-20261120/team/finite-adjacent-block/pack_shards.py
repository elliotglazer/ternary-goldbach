"""Use the same sampled data and eight-row proofs with one Lean worker startup."""
from pathlib import Path
from block import balanced, interval_at

here = Path(__file__).resolve().parent
lines = ['import AdjacentData', 'namespace AdjacentPacked', 'open SmallGoldbach',
         'set_option maxHeartbeats 0', 'set_option maxRecDepth 20000']
for i in range(4):
    shard=(here/f'AdjacentShard{i}.lean').read_text(encoding='utf-8')
    lines.append(shard[shard.index('theorem piece'):shard.index('theorem covered')])
lines += [f'theorem covered : Covered {interval_at(0)} {interval_at(256)} :=',
          '  '+balanced([f'piece{i}' for i in range(32)]), '#print axioms covered', 'end AdjacentPacked']
(here/'AdjacentPacked256.lean').write_text('\n'.join(lines)+'\n',encoding='utf-8')
