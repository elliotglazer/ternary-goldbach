"""Polynomial integrals and rational allocation checks; no analytic evaluations."""
from fractions import Fraction as F
from pathlib import Path
import json

def D(poly):
    out = {}
    for k, a in poly.items():
        out[k] = out.get(k, F(0)) + k*a
        out[k+1] = out.get(k+1, F(0)) + a
    return {k: a for k, a in out.items() if a}

p0 = {2:F(8), 3:F(-12), 4:F(6), 5:F(-1)}
p2 = D(D(p0))
square = {}
for k,a in p2.items():
    for l,b in p2.items():
        square[k+l] = square.get(k+l,F(0)) + a*b
integral = sum(a*F(2)**k/k for k,a in square.items())
h = F(87,25)
gram_per_window = 49*2*(96+F(2904)/(3*h*h))
B0, B1 = F(171), F(226)
closed_polynomial_lower = 2*B0+2*B1+330 + 11*(2*B0+6*B1+1430)
checks = {
    'polynomial_integral': integral == F(16128,715),
    'g_second_norm_cap': 21*integral == F(338688,715),
    'exp3_cap_from_e_upper': F(11,4)**3 < 21,
    'first_log_derivative_40': F(200,3)*F(39,2) < 40**2,
    'second_log_derivative_180': F(200,3)*21*integral < 180**2,
    'fourier_constant': F(4,2)+F(4,6)+F(48,36)+F(320,36) == F(116,9),
    'fourier_log_coefficient': F(220,36) == F(55,9),
    'gram_constant': gram_per_window < 17500,
    'band_count_coefficient': 4/h+F(2,1024) < 2,
    'sqrt_35000_cap': 35000 < 188**2,
    'band_coefficient_17': F(188*1920,9*2401) < 17,
    'H_log_condition_at_1024': F(1024,48) > F(10*3,4),
    'D_at_most_H': 1920*5 > 2401,
    'D_at_least_one': F(2401*48,1920)*1024 > 1,
    'closed_polynomial_lower': closed_polynomial_lower == 35532,
    'failed_coarse_tail_at_million': F(17*35532,10**9)/2 > F(1,10**6),
}
assert all(checks.values())
def enc(x):
    if isinstance(x,F): return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
    if isinstance(x,dict): return {str(k):enc(v) for k,v in x.items()}
    return x
data={'scope':'exact polynomial/rational checks only', 'P2':p2,
      'integral_P2_squared_div_t':integral, 'gram_per_window':gram_per_window,
      'closed_tail_lower_at_H_1e6':F(17*35532,10**9), 'checks':checks}
Path(__file__).with_suffix('.json').write_text(json.dumps(enc(data),indent=2)+'\n',encoding='utf-8')
print(f'PASS: {len(checks)} exact checks')
