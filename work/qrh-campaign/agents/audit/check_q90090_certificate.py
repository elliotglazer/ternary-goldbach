from pathlib import Path
from fractions import Fraction as F
import sys,contextlib,io,json,hashlib
peer=Path('work/qrh-campaign/agents/major-constants').resolve()
p=peer/'base_gap_90090_certificate.py';sys.path.insert(0,str(peer))
ns={'__name__':'__main__','__file__':str(Path('work/qrh-campaign/agents/audit/q90090_replay.py').resolve())}
with contextlib.redirect_stdout(io.StringIO()):exec(compile(p.read_text(),str(p),'exec'),ns)
assert ns['out']==json.loads(p.with_suffix('.json').read_text())
# Independent coarse structural side-condition arithmetic, valid at all larger T.
T=79000000;q=90090
assert T**3<5*10**23
assert 180180<425**2
assert F(T*T,61200)-1>F(14,3)*T
assert 96*q<T and 1536<T
assert 72*T-1>25000000
assert 72*T-1>2*F('2.7182818286')*q
assert 288<T*T
assert F(65000,q)<5*F('5.65')/(12*F(22,7))
assert F('5.65')**2<32
assert F(8*26000,q)<8
assert F(65000)<F(4,3)*T
assert F('.5')-2/F('3.14')**2>0
assert F('.125')-1/(2*F('3.14')**2)>0
for r in ns['results']:
 assert F(r['total_upper'])<F(r['ghat_lower'])
 assert F(r['gap_lower'])>0
 print(r['y_upper'],r['total_upper'],r['ghat_lower'],r['gap_lower'])
print('PASS: complete interval replay matches source JSON; independent structural side checks passed.')
for f in [p,p.with_suffix('.json'),peer/'BASE_GAP_90090_CERTIFICATE.md']:print(hashlib.sha256(f.read_bytes()).hexdigest(),f.name)
