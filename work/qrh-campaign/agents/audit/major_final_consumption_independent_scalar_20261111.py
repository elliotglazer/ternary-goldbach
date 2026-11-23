"""Independent rational comparisons only; no producer import or analytic evaluation."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

root = Path(__file__).resolve().parent.parent
author = root / 'major-constants/MAJOR_FINAL_CONSUMPTION_JOIN_2026-11-11.md'
a, bp, bs = F('1.01'), F('3.03e-23'), F('3.03e-17')
A = a*F('5e-7') + F('381.22')*F('2.85')*bp
Q = a*a*F('9.5e-7') + F('.640208')*F('2.85')*bs + a*bp*10001 + a*bs*F('1.2301') + bp*bs*F('3.6e11')
M = F('.640208')*F('13.59756')
t,u = F('.0034'),F('1e-6')
J = (1+u)*((1+t)*M+(1+1/t)*F('1e-4')+F('1.23'))+(1+1/u)*F('7.2e-19')
checks = {
 'J': J<10,
 'Mlower': F('.6392')*F('13.597558')>F('2.94')**2,
 'Jlower': (F('2.94')-F('.00020001')-F('1e-9'))**2>F('8.6296'),
 'star_norm': F('7.2e11')*F('2e-12')**2<F('2e-6')**2,
 'star_energy': (100+F('2e-6'))**2<10001,
 'A_cap': A<F('5.050000000000330e-7'),
 'Q_cap': Q<F('9.817952468e-7'),
 'A_sqrt': (20+2*M)*F('5.050000000000330e-7')<F('.0043466')**2,
 'Q_sqrt': 20*F('9.817952468e-7')<F('.0044313')**2,
 'loss': F('.0043466')+F('.0044313')<F('.008778'),
 'main': F('1.314')*F('.800689')-49*F('2.03e-5')*F('2.85')-F('.008778')==F('1.040492451'),
 'nonprime': F('1.589e8')*F('4.0804')*49/F('2.64')**31<F('.00271'),
 'reserve': F('1.0404')-F('1.0376')-F('.00271')==F('.00009'),
}
assert all(checks.values())
result = {'scope':'Independent exact arithmetic only; no analytic evaluation or Lean', 'author_sha256':hashlib.sha256(author.read_bytes()).hexdigest().upper(),'checks':checks,'A':str(A),'Q':str(Q),'J':str(J)}
out=Path(__file__).with_suffix('.json')
with out.open('x',encoding='utf-8') as f:
    f.write(json.dumps(result,indent=2)+'\n')
print(len(checks),'checks passed',hashlib.sha256(out.read_bytes()).hexdigest().upper())
