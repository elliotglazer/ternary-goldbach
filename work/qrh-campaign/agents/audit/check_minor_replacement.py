from fractions import Fraction as F
from pathlib import Path
import runpy, contextlib, io, hashlib, json
p=Path('work/qrh-campaign/agents/major-constants/minor_energy_tolerance.py')
with contextlib.redirect_stdout(io.StringIO()):
    d=runpy.run_path(str(p))
a=F('.65')
for r in d['rows']:
    v=r['vals']; den=v['L₀']/2-F('1.3066')
    s=(a*v['L₀']-F('.021095'))/den
    tau=(a*v['L₁']-F('.021095'))*(1-v['clt']/(v['L₁']/2-F('1.3064')))
    assert s>=0 and tau>=0 and v['cl0']*s>=F('8.6294')
    assert r['slope']*a+r['intercept']<=F('1.037')
    assert r['slope']*a-v['G0']*F('8.6294')<=F('1.037')
assert d['aslope']*a-d['G0']*F('8.6294')<=F('1.037')
assert (6*10**38)**2<(49*10**25)**3
files=[p,Path('work/qrh-campaign/agents/mellin/MINOR_ENERGY_QRH.md'),Path('work/qrh-campaign/agents/mellin/minor_energy_constants.py'),Path('work/qrh-campaign/agents/moebius/EBOUND_UNCONDITIONAL.md')]
print('PASS: nine cell positivity/base/zero-offset checks, asymptotic zero-offset bound, vertical remainder.')
for q in files: print(hashlib.sha256(q.read_bytes()).hexdigest(),q)
