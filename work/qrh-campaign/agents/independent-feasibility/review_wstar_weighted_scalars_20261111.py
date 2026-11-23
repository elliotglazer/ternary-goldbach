"""Independent exact scalar/pin checks; no imported producer or analytic values."""
from fractions import Fraction as F
from pathlib import Path
import hashlib, json, re

ROOT = Path(__file__).resolve().parents[4]
AUTHOR = ROOT / 'work/qrh-campaign/agents/audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md'
assert hashlib.sha256(AUTHOR.read_bytes()).hexdigest().upper() == 'AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B'
pins = []
for path, expected in re.findall(r'\]\((C:/[^\n]+?)\) \| ([0-9A-F]{64}) \|', AUTHOR.read_text(encoding='utf-8')):
    actual = hashlib.sha256(Path(path).read_bytes()).hexdigest().upper()
    assert actual == expected, path
    pins.append({'path': path, 'sha256': actual})
assert len(pins) == 18
checks = {}
def ck(name, value):
    assert value, name
    checks[name] = True

rho, p, j, target = F('0.000000885'), F('0.000001504'), F('8.79'), F('0.00000367')
ck('sqrt_y_lower', 3160000000000**2 < 10**25)
ck('principal_unrestricted', F(1,10**17)+F(4700000,3160000000000) < F('0.0000015'))
ck('two_removals', F('0.0000015')+2*F(2,10**9) == p)
ck('star_twist_domain', F(4*132900,49) < 1200000)
ck('nonprincipal_norm', F(3,10**6)+3*rho == F('0.000005655'))
ck('full_wstar_target', F('0.000005655')**2 < j*(target-p)**2)
ck('mixture_mass', F('1.92182') < 2)
ck('gamma_split', 1+F(5,1)/F(5,2) == 3)
ck('kernel_zero', F(1,2)*4*3*4 == 24)
ck('kernel_second', 4*5*6*24 == 2880)
ck('regularized_decay', 24+2880 == 2904)
h=F('3.48'); G=7000000
ck('full_strip_window_radius', 4+(h/2)**2 < F('2.7')**2)
ck('gram_row', 49*800*(96+F(2904,3)/h**2) < G)
ck('spectral_A', G*F(4,7*10**18) == F(2,10**6)**2)
ck('spectral_B', G*F(4,7*10**6) == 4)
ck('remainder_A', (F(2,10**6)+F(1,10**6))**2 == F(9,10**12))
ck('remainder_B', (2+1)**2 == 9)
ck('etaO_integral', 8*F(2**4,4)-12*F(2**5,5)+6*F(2**6,6)-F(2**7,7) == F(32,35))
ck('plus_norm', F(32,35)+F('0.00221') == F(641547,700000) < 1)
ck('pointwise_tail_scalar', 368 < F('0.00221')**2*3*F('3.14')*200**3)
ck('conductor_three_weight', F(3,2**3)+F(3,2**3) == F(3,4))
ck('layer_cake_mass', 1-F(1,10**24) > F(1,2))
ck('density_comparison_obstruction', F(3,8)*3732480000000000 > 10**33*F(4,7*10**18))
# Symbolic polynomial identity for the integrated absolute second derivative:
# k^2+(4k+4)k/2+4k(k+2)/4 = 4k(k+1).
ck('H_second_moment_polynomial', (1+2+1, 2+2) == (4,4))
out = Path(__file__).with_suffix('.json')
payload={'scope':'Exact rational comparisons and pinned bytes only; no analytic values', 'source_pins':pins, 'checks':checks, 'count':len(checks)}
with out.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(payload,f,indent=2); f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks),'source_pins':len(pins)}))
