"""Exact rational diagnostics for the paper P6 proof and finite P4/P5/P7 extensions."""
from fractions import Fraction as F
import json
f=lambda s:F(str(s))
a=f('3.162')
checks={
'e_upper27': f('2.72')**27 < 10**12,
'e_lower8': f('2.7')**8 > 2700,
'root12': a**12 < 10**6,
'small_sqrt701': f('26.47')**2 < 701,
'small_linear': f('.03883')*f('26.47') > 1,
'exp_tail_mid': f('7.3576')*f('2.7182818283') > 20,
'mid_poly_constant': f('.4262')*a**3-f('1.03883')*a-f('9.39643') > 0,
'mid_poly_linear': 3*f('.4262')*a*a-f('1.03883') > 0,
'large_coefficient': f('1.387')*f('1.011')+f('.01') < f('1.4262'),
'finite_P4': 1+f('1.5262')/5000 < f('1.0064'),
'finite_P5': 1+2*(f('1.5262')+F(4,3))/5000+F(10**12,(25*10**6)**2)<f('1.022'),
'finite_P7': (f('1.6')*f('14.51')+4)/1400 < f('.15'),
}
assert all(checks.values()),checks
print(json.dumps({'checks':checks,'P6_large':str(f('1.387')*f('1.011')+f('.01')),'P6_margin':str(f('1.4262')-f('1.387')*f('1.011')-f('.01')),'mid_polynomial_margin':str(f('.4262')*a**3-f('1.03883')*a-f('9.39643')),'P5_coefficient':str(1+2*(f('1.5262')+F(4,3))/5000+F(10**12,(25*10**6)**2))},indent=2))