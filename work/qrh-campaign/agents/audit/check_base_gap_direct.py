from fractions import Fraction as F
from math import factorial
from pathlib import Path
import contextlib,io,runpy,hashlib

def exp_bounds(x,N=160):
 x=F(x)
 s=sum((x**k/factorial(k) for k in range(N+1)),F(0))
 tail=x**(N+1)/factorial(N+1)/(1-x/(N+2))
 return s,s+tail
assert exp_bounds(F('4.9'))[1]<140
assert exp_bounds(F('16.1'))[0]>9600000
assert exp_bounds(F('.98'))[0]>F(259,98)
assert exp_bounds(F('12.21'))[0]>200000
assert exp_bounds(32)[0]>10**13
assert F('.002292')**2>F('1.05')/200000
assert F('.002237')**2*200000>1
assert (F('3.8')/F('.000428'))**6<F('5e23')
assert F('1.254')**2>F(11,7)
assert F(79000000)**3<F('5e23')
assert F(200000000)**3<10**25
assert F(9)*79000000/(F('2.004')*2400000)>140
assert F('1.5')*600000*4<200000000
C=(F('.68')*F('12.21')+F('.8764'))*F('.002292')+F('2.526')*F('.002237')+(F('1.05')*(F('3.25')*F('12.21')+F('7.82'))+F('13.66')*F('12.21')+F('37.55'))/100000+F('.000428')
assert C==F(593191013,20000000000)
assert 17*F('.05')**3/3<F('.000709')
assert 17*F(65,8)/10**13<F('.000000002')
B=F('1.254')*C+F('.000709')+F('.000000002')
assert B==F(379020785151,10**13)<F('.038')
with contextlib.redirect_stdout(io.StringIO()):
 d=runpy.run_path('work/qrh-campaign/agents/major-constants/base_gap_variable_budget.py')
assert d['b']>0 and d['uniform_strong']>F('.04712') and d['K']>79
assert F('.038')<d['uniform_strong']
print('PASS: direct branch geometry, exponential/square/sixth-root bounds, Gaussian tail arithmetic, exact.038 and variable-envelope compatibility.')
print('central=',C,'total=',B,'margin below.04712=',F('.04712')-B)
for p in ['work/qrh-campaign/agents/major-constants/BASE_GAP_VARIABLE_BUDGET.md','work/qrh-campaign/agents/major-constants/base_gap_variable_budget.py','work/qrh-campaign/agents/independent-feasibility/BASE_GAP_ALTERNATIVES.md']:
 print(hashlib.sha256(Path(p).read_bytes()).hexdigest(),p)
