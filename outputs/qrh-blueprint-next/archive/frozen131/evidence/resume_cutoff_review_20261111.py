"""Instrumented exact replay of reduced-cutoff research; no spectral evidence."""
from pathlib import Path
from fractions import Fraction as F
import json, hashlib
HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parent/'major-constants'/'resume_cutoff_optimization_20261111.py'
code=AUTHOR.read_text(encoding='utf-8')
# The author's only write follows __file__; redirect it to this audit directory.
g={'__file__':str(HERE/'resume_cutoff_replayed_20261111.py'),'__name__':'__audit__'}
exec(compile(code,str(AUTHOR)+':audit','exec'),g)
actual=json.loads((HERE/'resume_cutoff_replayed_20261111.json').read_text())
expected=json.loads(AUTHOR.with_suffix('.json').read_text())
assert actual==expected
# Check the geometric-denominator comparisons omitted from the scalar script.
assert F('1.93')*F('4.4')>F(22,7)*F('2.7')
assert 1+1/(F('.1398')*F('4.4'))<3
# Complete principal and N norm transfer at the changed remainder.
assert 300000*1200000*F('4e-13')**2<F('3e-7')**2
assert (F('.032')+F('3.6e-7'))**2<F('1.23')
assert F('.032')**2>F('.001')
assert 720000000000*F('1e-15')**2<F('1e-9')**2
assert F('.6392')*F('13.597558')>F('2.94')**2
lower=(F('2.94')-F('.0002003')-F('1e-9'))**2
assert lower>F('8.6296')
# The local integrated route must also pay q-dependent coprime removal.
local=F('8e-6')
epsnorm=F('.002829')
assert epsnorm**2>local
restricted_residual=(epsnorm+3*F('1e-15'))**2
restricted=F('13.597558')*((1-F('.00354'))*F('.6392')-restricted_residual/F('.00354'))
assert (1-F('1e-6'))*restricted-F('7.2e-19')/F('1e-6')>F('8.6296')
print('AUDIT PASS: author JSON agrees, geometric denominators, N/Ep transfer, both lower-J routes checked.')
print('Direct lower J exact:',lower)
print('Author script SHA256:',hashlib.sha256(AUTHOR.read_bytes()).hexdigest())
