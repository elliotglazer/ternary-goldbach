"""Exact rational research checks, with no analytic evaluations."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

root = Path(__file__).resolve().parents[2]
pins = {
 'work/qrh-campaign/agents/zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md':'E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794',
 'work/qrh-campaign/agents/moebius/REVIEW_WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md':'422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4',
 'work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md':'22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7',
 'work/qrh-campaign/agents/audit/REVIEW_JOINT_PLUS_STAR_FRONTIER_2026-11-11.md':'98323DCEF9DF7E7E4F2A2D9BDAEFC691CDDC4D6BD048E441FFD8E82B816F6505',
}
for path, pin in pins.items():
    assert hashlib.sha256((root/path).read_bytes()).hexdigest().upper() == pin
G=F(7000000)
qa=F('2.321e-19'); qb=F('1.753e-12')
ta=F('8e-9'); tb=F('.00048')
a=F('1.284e-6'); b=F('.004')
assert a>ta and b>tb
assert G*qa < (a-ta)**2
assert G*qb < (b-tb)**2
j=F('8.79'); h=F('2.965'); p=F('1.902e-6'); rho=F('8.85e-7')
C=F(914205504131,4687500000)
E=F(64019155993729,312500000000000000)
assert h*h>j
assert 16*150000*19*rho*rho < F('.006')**2
reserve=E-h*(p+a+rho*b)-rho*C
assert reserve>0
cap=(rho-F('516e-15'))**2-F('2.83e-7')**2
rounded=F('7.03135e-13')
assert 0<rounded<=cap<rounded+F('1e-18')
odd=F('8.385e-7'); even=F('1.1858e-6')
assert odd*odd<rounded and even*even/2<rounded
assert qa>F(2320260719784375582,10**37)
assert qb>F(17521273377323822834049091,10**37)
out=dict(scope='conditional shared-RH paper budget only',pins=pins,
 QA_upper=str(qa), QB_upper=str(qb), sqrtA_upper=str(a),sqrtB_upper=str(b),
 rho=str(rho), cubic_reserve=str(reserve), Eplus_exact_cap=str(cap),
 Eplus_sufficient_rounded_cap=str(rounded), odd_coefficient=str(odd),
 even_coefficient_if_half_support_proved=str(even))
with Path(__file__).with_name('shared_rh_star_budget_20261111.json').open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2); f.write('\n')
print('PASS: four pins; line-count, full-norm, cubic, Z, energy and conditional support comparisons.')
