"""Independent exact scalars and saved metadata only; no evaluator imports."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib
import json

A = Path(__file__).resolve().parents[1]
pins = {
    'audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md': '076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430',
    'audit/raw_small_theta_sign_scalars_20261111.py': '77F9FF9C0E903F9CF723934C3DDEB6773CACD0168BA4E8243E71D0810B47C384',
    'audit/raw_small_theta_sign_scalars_20261111.json': 'D6FA13513E2A01B4B3ACFFD0A93B7B0C811F864A1C4FDAB3E907FA23626532CB',
}
checks = 0
def check(ok):
    global checks
    checks += 1
    assert ok, checks
for name, pin in pins.items():
    check(hashlib.sha256((A/name).read_bytes()).hexdigest().upper() == pin)
author = json.loads((A/'audit/raw_small_theta_sign_scalars_20261111.json').read_text())
for name, pin in author['pins'].items():
    check(hashlib.sha256((A/name).read_bytes()).hexdigest().upper() == pin)
data = json.loads((A/'prime-estimates/small_family_theta_inventory_final_20261111.json').read_text())
eps_min = F(1, 4*2**80*3**128)
check(44*(2*1250000**2+1)*F(605,1344)**340 < eps_min/16)
check(F(3,24)+F(21,704) == F(109,704))
check(F(109,704)*F(44,7) == F(109,112) < 1)
check(F(109,704) < F(5,32))
check(F(1,448) < F(7,2816))
check(F(506,21)+F(22,21) <= 45)
check(F(7*2**31,2816*2**80) < 1)

# Reconstruct all seven exact interpolation norms without author code.
norms = []
for offset in range(1,8):
    x = F(offset,8)
    total = F(1)
    for j in range(-169,171):
        total *= x-j
    weights = [total/((x-j)*(-1)**(170-j)*factorial(j+169)*factorial(170-j))
               for j in range(-169,171)]
    norm = sum(map(abs,weights))
    check(norm < 4)
    check(sum(weights) == 1)
    check(sum(w*j for w,j in zip(weights,range(-169,171))) == x)
    norms.append(str(norm))

# Exercise every supported radix-two length, with normalized dimensionless
# coefficients. This is exact specialization of the paper error recurrence.
for k in range(1,32):
    P = F(5*2**k,64)
    L, H = 6/P, F(44,7)/P
    check(F(3,4)/L+F(3,16)/H == F(109,704)*P)
    check(P/448 < 1/(64*H))
    if P >= 6:
        J = (5*P/3).__ceil__()
        check(H*(2*J+1) <= F(506,21) < 44)
        check(H*(2*J+1)+H <= 45)

rows = []
for row in author['rows']:
    e = row['extra']
    t = next(s['totals'] for s in data['scenarios'] if s['theta']==128 and s['extra_nodes']==e)
    t64 = next(s['totals'] for s in data['scenarios'] if s['theta']==64 and s['extra_nodes']==e)
    q, n = t['primitive_grid_outputs'], t['primitive_labels']
    expected = {
        'extra': e, 'coarse_outputs': q,
        'removed_coarse_omega_scalings': t['omega_complex_scalings'],
        'removed_coarse_Y_products': t['final_Y_real_products'],
        'removed_shared_positive_updates': t['positive_scale_real_updates'],
        'removed_positive_exp_seeds': t['conductors'],
        'retained_radial_exp_seeds': t['real_exp_seed_certificates']-t['conductors'],
        'full_time_outputs': t['time_dft_complex_outputs'],
        'dense_new_eighth_points': 7*q-7*n,
        'dense_all_eighth_points': 8*q-7*n,
        'dense_direct_interpolation_terms': 2380*(q-n),
    }
    for key, value in expected.items():
        check(row[key] == value)
    check(q == t64['primitive_grid_outputs'])
    check(t['positive_scale_real_updates'] == t64['positive_scale_real_updates'])
    check(expected['removed_positive_exp_seeds'] == expected['retained_radial_exp_seeds'] == 7499)
    rows.append(expected)
out = {'status':'PASS exact scalar/count review only', 'checks':checks,
       'pins':{**pins, **author['pins']}, 'lagrange_l1_norms':norms, 'rows':rows}
dest = Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8',newline='\n') as f:
    json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'status':out['status'],'checks':checks,'receipt':str(dest)}))
