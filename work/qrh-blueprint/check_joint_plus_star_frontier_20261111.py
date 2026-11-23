"""Exact scalar research only. No numerical analytic evaluations or prover calls."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

root = Path(__file__).resolve().parents[2]
pins = {
    'work/qrh-campaign/agents/audit/REVIEW_PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md': 'AD993398C6E41DCCE3A9826C0FA5BF6DA89A3B0139672429D7BD61E797DE9F0E',
    'work/qrh-blueprint/INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md': '943DE38EE628CFA9E7221100E75933D101C7593B613945F19B7CBDF90E97C128',
    'work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md': '22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7',
}
for path, expected in pins.items():
    assert hashlib.sha256((root / path).read_bytes()).hexdigest().upper() == expected
j = F('8.79')
C = F(914205504131, 4687500000)
E = F(64019155993729, 312500000000000000)
p = F('0.000001902')
h = F('2.965')
b = F('43.762')
assert h*h > j and b*b > 1915
assert E == j*F('0.00000367') + F('0.000000885')*C
rows = []
for a in map(F, ['0', '0.000001', '0.000002', '0.000003', '0.00001']):
    limit = (E-h*(p+a))/(C+h*b)
    rho = F(limit // F('0.000000001'), 10**9)
    reserve = E-h*(p+a+rho*b)-rho*C
    assert reserve > 0
    assert h*(p+a+(rho+F('0.000000001'))*b)+(rho+F('0.000000001'))*C > E
    assert 16*150000*19*rho*rho < F('0.006')**2
    cap = (rho-F(516, 10**15))**2-F('0.000000283')**2
    assert rho > F(516, 10**15) and cap > 0
    rows.append(dict(A=str(a*a), rho=str(rho), Eplus_cap=str(cap), cubic_reserve=str(reserve), envelope_rho_limit=str(limit)))
result = dict(scope='conditional scalar frontier only; no actual energies or spectra', pins=pins, sqrt_j_upper=str(h), sqrt_B_upper=str(b), B_upper=1915, rows=rows)
target = Path(__file__).with_name('joint_plus_star_frontier_20261111.json')
with target.open('x', encoding='utf-8') as f:
    json.dump(result, f, indent=2)
    f.write('\n')
print('PASS: five exact sufficient rows, maximal on the specified 1e-9 rho grid within the fixed rational envelope; three pins matched.')
