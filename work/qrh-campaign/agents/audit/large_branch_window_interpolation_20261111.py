"""Exact scalar checks only. No analytic-function or spectral evaluation."""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import hashlib
import json

root = Path(__file__).resolve().parents[1]
checks = []
def check(name, condition):
    assert condition, name
    checks.append(name)

check('exp(.7)>2 by positive Taylor polynomial', sum(Q(7,10)**j/factorial(j) for j in range(7)) > 2)
delta = Q(5,64)
B = Q(1,2)/delta
check('sampling bandwidth', B == Q(32,5))
check('odd Fourier exponential margin', Q(3,2)*2*3*B-Q(3,2)**2/2 > 80*Q(7,10))
check('even Fourier exponential margin', Q(5,2)*2*3*B-Q(5,2)**2/2 > 132*Q(7,10))
check('conductor magnitude', 265800 < 2**19)
check('Gaussian integral cap', 4*(7000+2) < 2**15)
check('odd prefactor cap', Q(2*2**19*2*2**15,1)/(3*Q(3,2)) < 2**34)
check('even prefactor cap', Q(2*2**38*2*2**15,1)/(3*Q(5,2)) < 2**53)
z = 256*delta
check('sample cutoff', z == 20)
check('sample envelope decreasing', z*(2+z) > 1)
check('geometric ratio below one half', (2*z*delta+delta**2)/2 > 2*Q(7,10))
check('polynomial ratio below two', 1+delta/(2+z) < 2)
check('tail exponential margin', z*z/2 > 285*Q(7,10))
check('tail polynomial cap', 2+7000+z < 2**13)
check('two sides and geometric inverse', 2*144*2**19*2**13*2 < 2**42)
check('sample tail exponent', 42-285 == -243)
check('analytic sum', Q(1,2**46)+Q(1,2**243) < Q(1,2**45))
check('current upper target plus conservative guards within source domain', Q(424195,64)+257*delta < 7000)
pins = {}
for relative, expected in [
    ('audit/platt_turing_1305_3087.pdf','8FD109AA21345BC3FEAC4FDE2FAA7DFB51B4EF1FC9A430F643323612A39EF417'),
    ('audit/platt_turing_1305_3087.txt','2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9'),
    ('audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md','96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D'),
    ('zero-sum/REVIEW_LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md','F6F38CBFC4237AB0C4AAC978EF1D0157754DFAA461D01FC3D54D921B1FE45D54'),
    ('prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md','06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E'),
]:
    digest=hashlib.sha256((root/relative).read_bytes()).hexdigest().upper()
    check('source '+relative,digest==expected)
    pins[relative]=digest
out={'scope':'exact scalar metadata; conditional paper route only','checks':checks,'count':len(checks),'pins':pins,
     'parameters':{'delta':'5/64','B':'32/5','h':1,'m':256,'max_conductor':265800,'max_target_height':7000},
     'Fourier_error_upper':'2^-46','sample_tail_upper':'2^-243','sign_success':False}
path=Path(__file__).with_suffix('.json')
with path.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2)
    f.write('\n')
print(f'PASS {len(checks)} exact checks; {path.name}')
