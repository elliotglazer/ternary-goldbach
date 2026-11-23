"""Exact small scalar checks only. No conductor/prime/zero scan or evaluator."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

x0, y0 = 49*10**25, 10**25
b0, b1 = F(111,200), F(113,200)
fx, fy = F(15,8), F(9,5)
assert b1-b0 == F(1,100)
assert fx**100 > x0
assert fy**100 > y0

ap_norm = F('.00007')*fx + F('1e-10')+F('2e-9')
astar_norm = F('.00049')*fy+F('1.2e-6')
n_norm = F('.032')*fx+F('.16')+F('2e-9')
assert F('.000032')**2 > F('1e-9')
low_p, low_s = F('.002')*fx**2, 10000*fy**2
assert 100000**2 > 300000*low_s
assert 46**2 > 300000*low_p
assert 87**2 > 300000*F('.025')
extra = F('2e-15')*100000+F('2e-12')*46+F('2e-12')*87+F('4e-27')*180000000000
assert extra < F('1e-9')
cross_norm = F('.000032')*fx*fy+F('.00016')*fy+F('1e-9')
assert ap_norm**2 < F('5e-7')
assert n_norm**2 < F('1.23')
combined = astar_norm**2+cross_norm**2
assert combined < F('9.5e-7')

# Full-sum removal: updated raw-star bound, same final consumer caps.
assert (180+F('2e-6'))**2 < 32401
a, bp, bs = F('1.01'), F('3.03e-23'), F('3.03e-17')
afull = a*F('5e-7')+F('381.22')*F('2.85')*bp
qfull = a*a*F('9.5e-7')+F('.640208')*F('2.85')*bs+a*bp*32401+a*bs*F('1.2301')+bp*bs*360000000000
assert afull < F('5.050000000000330e-7')
assert qfull < F('9.817952468e-7')

# Affected base-gap denominator q>50000 only; no grid enumeration.
assert F(290400000,7*50000)+1 < 831
nmax = 400*(F(50*831,87)+2)+1
assert nmax < 200000
assert 548**2 > 300000
ypow = F('1.4e-11')
assert ypow**8 * 10**87 > 1  # y0^(-87/200) < ypow
M = lambda beta: F('1.922')-F('.6686')*beta
assert M(F(7,8)) > 1
assert M(b1) < F(13,8)
assert 8-F('.6686') > 0  # log y >= 8 already suffices for beta monotonicity
pole = F('1.2534')*F(21,4)/100000
basegap = pole+548*F(13,8)*200000*ypow+548*F('3e-14')+549*F('2e-9')
assert basegap < F('.0026') < F('.04712')

out = {
    'scope': 'Conditional high-conductor real-part profile, current heights unchanged; exact scalar inequalities only',
    'low_conductors': 'c<=100000: beta<=111/200',
    'high_conductors': 'active c>100000: beta<=113/200',
    'endpoint_norm_inflations': [str(fx),str(fy)],
    'Aplus_upper': str(ap_norm**2),
    'Astar_upper': str(astar_norm**2),
    'N_upper': str(n_norm**2),
    'remaining_mixed_norm_upper': str(extra),
    'Cross_upper': str(cross_norm**2),
    'Astar_plus_Cross_upper': str(combined),
    'combined_margin': str(F('9.5e-7')-combined),
    'updated_raw_star_upper': '32401',
    'full_Q_upper': str(qfull),
    'affected_basegap_upper': str(basegap),
    'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
