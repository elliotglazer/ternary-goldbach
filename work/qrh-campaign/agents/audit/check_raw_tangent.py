from pathlib import Path
from fractions import Fraction as F
import sys,contextlib,io,json,hashlib
peer=Path('work/qrh-campaign/agents/major-constants').resolve()
src=peer/'base_gap_raw_tangent.py'
# Execute unchanged source with an audit-owned output path; imports stay read-only.
ns={'__file__':str(Path('work/qrh-campaign/agents/audit/raw_tangent_replay.py').resolve()),'__name__':'__main__'}
sys.path.insert(0,str(peer))
with contextlib.redirect_stdout(io.StringIO()):exec(compile(src.read_text(),str(src),'exec'),ns)
actual=json.loads(src.with_suffix('.json').read_text())
assert actual==ns['out']
for result in ns['results']:
 passing=[x['D_index'] for x in result['D_rows'] if x['passes']]
 assert passing==list(range(7,16))
 assert F(result['D_rows'][7]['Dlo'])==F(13200000,49)
 for row in result['D_rows']:
  for c in row['r_cells']:
   A=F(c['A']);B=F(c['B']);lo=F(c['rlo']);hi=F(c['rhi'])
   gap=min((ns['b'].LOWA-A)*r+ns['b'].LOWB-B for r in (lo,hi))
   assert F(c['gap_lower'])<=gap
 print(result['Q0'],result['Q1'],'passing D cells',passing,'minimum certified passing gap',min(F(c['gap_lower']) for row in result['D_rows'] if row['passes'] for c in row['r_cells']))
print('PASS: exact source replay matches full stored JSON and all endpoint gaps.')
for p in [src,src.with_suffix('.json'),peer/'BASE_GAP_BINNED.md']:print(hashlib.sha256(p.read_bytes()).hexdigest(),p.name)
