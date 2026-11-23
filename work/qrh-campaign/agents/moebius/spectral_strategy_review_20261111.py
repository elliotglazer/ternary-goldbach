"""Independent bounded height review. Does not evaluate any L-function."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parent/'zero-sum'
name='resume_spectral_strategy_20261111'
expected=json.loads((AUTHOR/(name+'.json')).read_text())
best=None
for q in range(1,150001):
    numerator=290400000;denominator=7*q
    h=max(250,(numerator+denominator-1)//denominator)
    assert h*q<50000000
    candidate=(F(50000000-h*q,q),q,h)
    if best is None or candidate[0]<best[0]:best=candidate
assert str(best[0])==expected['minimum_rounded_height_margin']
assert best[1]==expected['minimum_q'] and best[2]==expected['H']
# Analytic proof: raw margin >56, ceiling consumes <1, floor <common.
assert 59600000>56*7*150000
assert 50000000>250*150000
names=['RESUME_SPECTRAL_CERTIFICATE_STRATEGY_2026-11-11.md',name+'.py',name+'.json']
out={'status':'Independent all-q integer inequalities pass; no spectral assertion proved',
     'input_sha256':{n:hashlib.sha256((AUTHOR/n).read_bytes()).hexdigest() for n in names},
     'q_count':150000,'minimum_margin':str(best[0]),'minimum_q':best[1],'H':best[2],
     'uniform_strict_margin_lower':55,
     'scope_correction':'Section 3 aggregate Euler identity requires c>1; at c=1 subtract 1/(s-1) from the Dirichlet series.'}
HERE.joinpath('spectral_strategy_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
