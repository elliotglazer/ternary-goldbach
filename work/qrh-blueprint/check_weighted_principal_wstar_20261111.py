"""Rational checks for a weighted principal Wstar contribution, not spectral data."""
from fractions import Fraction as F
from pathlib import Path
import json

root = Path(__file__).resolve().parent
out = root / 'weighted_principal_wstar_20261111.json'
assert not out.exists(), 'Frozen receipt already exists'
rho, u, j = F(885,10**9), F(367,10**8), F(879,100)
p1, d0 = F(1502,10**9), F(2,10**9)
cP, m3 = F(640208,10**6), F(32,13)
assert F(3,16) < 1
assert 2/(1-F(3,16)) == m3
assert cP*m3 < F(1256,1000)**2
assert F(1256,1000)+F(6,1000) == F(1262,1000)
assert j < 3**2
principal = p1*F(1262,1000)+d0*3
budget = F(1902,10**9)
assert principal == F(1901524,10**12) < budget
assert F(2964,1000)**2 < j
rows=[]
for a_root, b in [(F(3,10**6),45),(F(2,10**6),62),(F(1,10**6),81),(F(0),102)]:
    r=(u*F(2964,1000)-budget-a_root)/rho
    assert r > 0 and b < r*r
    rows.append({'A_bound':str(a_root*a_root), 'B_bound':b,
        'sqrtB_upper_allowed':str(r),'squared_margin':str(r*r-b)})
assert (u*3-budget)**2/rho**2 < F(588,5)
receipt={'status':'PASS_EXACT_WEIGHTED_PRINCIPAL_WSTAR',
    'scope':'Conditional source-mathematics scalar bounds only; no actual energy estimate',
    'M3_bound':str(m3),'principal_intermediate':str(principal),
    'principal_budget':str(budget),'allocations':rows,
    'coarse_B_ceiling_for_this_allocation':str((u*3-budget)**2/rho**2)}
out.write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print(json.dumps(receipt,indent=2))
