import contextlib,io,runpy,hashlib
from pathlib import Path
with contextlib.redirect_stdout(io.StringIO()):
 d=runpy.run_path('work/qrh-campaign/agents/major-constants/base_gap_binned.py')
for r in d['results']:
 print(r['Q0'],r['Q1'],r['v'],r['passed'],r['gap_lower'],r['worst_bin'])
print('bins',len(d['bins']),'tail',d['TAIL'])
print('source_sha256',hashlib.sha256(Path('work/qrh-campaign/agents/major-constants/base_gap_binned.py').read_bytes()).hexdigest())
