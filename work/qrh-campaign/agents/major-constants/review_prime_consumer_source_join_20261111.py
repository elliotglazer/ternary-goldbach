"""Independent rational checks; no function evaluation or imported evaluator."""
from fractions import Fraction as F
from pathlib import Path
import json, hashlib
out = {}
def check(name, value):
    assert value, name
    out[name] = bool(value)
H=60343058
check('height_floor', F(239,100)**2 < F(23,4))
for a in (F(9,8),F(15,8)):
    check('mass_endpoint_'+str(a), a-F(8,25)*(a*a+F(9,4)) >= 0)
check('mass_log_bound', F(27,10)**18 > 1+F(H+3,2))
check('harmonic_log_bound', F(27,10)**13 > 333333)
check('bin_count', 12/F(8,25) < 38)
base=F(7600,239)+F(1064,3)
check('harmonic_arithmetic', base==F(277096,717))
check('unweighted_moment',base<387)
x=F(14,125)
check('exponential_tail_ratio',x/3<1)
check('weight_bound',1+x+x*x/(2*(1-x/3))<F(9,8))
check('weighted_moment',387*F(9,8)<436)
check('sqrt_endpoint',70700**2<5000000000)
check('low_error',F(1002,1000)*436/70700<F(618,100000))
other=sum(map(F,['.00016','.002001','.000009','.000018','.000000002','.000000000001']))
check('other_error_identity',other==F('.002188002001'))
check('other_error',other/22<F('.0001'))
final=(F('.00618')+F('.0001'))*F('1.000001')
check('smoothing_final',final==F('.00628000628') and final<F('.006281')<F('.0064'))
check('upper_range',F('.0081')/35<F('.0064'))
check('finite_first',1+F('1.5262')/5000==F('1.00030524')<F('1.0004'))
check('finite_second',F('1.0001')*F(4001,4000)+F('1.4262')/30000==F('1.000397565')<F('1.0004'))
check('small_psi_root',F('26.47')**2<701 and F('.03883')*F('26.47')>1)
v=F('3.162')
check('finite_nonprime_base',F('.4262')*v**3-F('1.03883')*v-F('9.39643')>0)
check('finite_nonprime_derivative',3*F('.4262')*v**2-F('1.03883')>0)
receipt={'scope':'independent exact scalar checks only; no spectral or prime certificates', 'checks':out, 'count':len(out),'scalars':{'unweighted_upper':str(base),'other_L_error':str(other),'relative_error_upper':str(final)}}
path=Path(__file__).with_suffix('.json')
path.write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'count':len(out),'sha256':hashlib.sha256(path.read_bytes()).hexdigest().upper()}))
