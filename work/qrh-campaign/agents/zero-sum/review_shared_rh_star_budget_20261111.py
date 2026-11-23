"""Independent exact budget review; no author execution or function values."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
checks={}
def ck(name,ok):
    assert ok,name
    checks[name]=True
def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()
pins={
 'work/qrh-blueprint/SHARED_RH_STAR_BUDGET_2026-11-11.md':'A5457ABF7E67FD98C88F46B8F08DF4F8BD35B44B48A3B734E5F660F94CCAA993',
 'work/qrh-blueprint/check_shared_rh_star_budget_20261111.py':'43384BF37C7DA48D4D11B4D9B5D8D2A8D4CF32AE5B9A2FCBBE45732AA7846B2D',
 'work/qrh-blueprint/shared_rh_star_budget_20261111.json':'32CBBA77D2C2C37CA0F4DD4E055DB2131D0E4DC6571A8CB0104FC402665C36C4',
 'work/qrh-campaign/agents/zero-sum/wstar_floor300_metadata_20261111.json':'7750B7D1BB25A96D9B4F54A75C4090B9C7ECE591D905DEDC7D244FBA12CCDAD5',
}
saved=json.loads((ROOT/'work/qrh-blueprint/shared_rh_star_budget_20261111.json').read_text())
pins.update(saved['pins'])
extra=['work/qrh-campaign/agents/audit/FINITE_RH_CONSUMER_DEMAND_MATRIX_2026-11-11.md',
       'work/qrh-campaign/agents/prime-estimates/REVIEW_FINITE_RH_CONSUMER_DEMAND_MATRIX_2026-11-11.md']
for p in extra:
    pins[p]=sha(ROOT/p)
for p,h in pins.items():
    ck('pin_'+p,sha(ROOT/p)==h)
base=json.loads((ROOT/'work/qrh-campaign/agents/zero-sum/wstar_floor300_metadata_20261111.json').read_text())
qa,qb=F('2.321e-19'),F('1.753e-12')
ck('A_round_up',F(base['Q_A_line_upper'])<qa)
ck('B_round_up',F(base['Q_B_line_upper'])<qb)
ck('A_exact_count',F(base['weighted_count_A_numerator'],10**37)==F(base['Q_A_line_upper']))
ck('B_exact_count',F(base['weighted_count_B_numerator'],10**37)==F(base['Q_B_line_upper']))
ta,tb=F(base['TA_upper']),F(base['TB_upper'])
a,b=F('1.284e-6'),F('.004')
ck('positive_A_difference',a>ta)
ck('positive_B_difference',b>tb)
ck('A_norm',7000000*qa<(a-ta)**2)
ck('B_norm',7000000*qb<(b-tb)**2)
ck('A_energy',a*a==F('1.648656e-12'))
ck('B_energy',b*b==F('1.6e-5'))
rho,p,j=F('8.85e-7'),F('1.902e-6'),F('8.79')
ck('integrated_Z',16*150000*19*rho*rho<F('.006')**2)
ck('X_root',F('.640208')*F('13.59756')<F('2.951')**2)
ck('X', (F('2.951')+F('.006'))**2<j)
ck('principal_bound',F('1.502e-6')*F('1.262')+F('2e-9')*3<p)
ck('j_upper',F('2.965')**2>j)
C=F(49,9)*(j+F('.640208')*F('13.59756'))+F(9,2)*F('7.78')*F('2.85')
E=j*F('3.67e-6')+rho*C
ck('C',C==F(914205504131,4687500000))
ck('E',E==F(64019155993729,312500000000000000))
reserve=E-F('2.965')*(p+a+rho*b)-rho*C
ck('reserve',reserve==F(228023139,10**13) and reserve>0)
cap=(rho-F('516e-15'))**2-F('2.83e-7')**2
roundcap=F('7.03135e-13')
ck('cap_positive',rho>F('516e-15') and cap>0)
ck('cap_downward',roundcap<=cap<roundcap+F('1e-18'))
ck('uniform_coeff',F('8.385e-7')**2<roundcap)
ck('conditional_even_coeff',F('1.1858e-6')**2/2<roundcap)
reconstructed=dict(QA_upper=qa,QB_upper=qb,sqrtA_upper=a,sqrtB_upper=b,rho=rho,cubic_reserve=reserve,Eplus_exact_cap=cap,Eplus_sufficient_rounded_cap=roundcap,odd_coefficient=F('8.385e-7'),even_coefficient_if_half_support_proved=F('1.1858e-6'))
for k,v in reconstructed.items():
    ck('saved_'+k,F(saved[k])==v)
out=dict(scope='conditional paper composition and exact scalar review only',checks=checks,count=len(checks),pins=pins,results={k:str(v) for k,v in reconstructed.items()})
with (HERE/'review_shared_rh_star_budget_20261111.json').open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(str(len(checks))+' exact checks passed')
