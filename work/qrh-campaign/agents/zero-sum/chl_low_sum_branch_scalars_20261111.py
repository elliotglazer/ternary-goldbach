"""Exact scalar branch tests only; no zero/function evaluations."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

checks = []
def ck(name, condition):
    assert condition, name
    checks.append(name)

elo, ehi = F(19,7), F(87,32)
ck('e lower from positive partial sum', sum(F(1,factorial(k)) for k in range(6)) > elo)
ck('e upper from geometric remainder', sum(F(1,factorial(k)) for k in range(9))+F(10,9*factorial(9)) < ehi)
ck('log28 below4', elo**4 > 28)
ck('R(T1) below7', F(110,1000)*28+F(290,1000)*4+F(229,100) < 7)
T0, N0, S0 = 104537615, 260000000, F('21.98308')
rows=[]
for tag,m,delta,T1,L,lr,lg,fl,cap in [
    (55,9,F('1.757070e-10'),93307030000,26,6,19,7,72),
    (60,30,F('4.873014e-11'),989087200000,28,9,21,12,226),
]:
    ck(f'{tag}:logT1 upper', T1 < elo**L)
    ck(f'{tag}:log ratio lower', F(T1,T0) > ehi**lr)
    ck(f'{tag}:log geometric lower', T0*T1 > 49*ehi**(2*lg))
    lam=F(2*factorial(2*m+1),4**m*factorial(m)**2)
    ck(f'{tag}:F1 lower',lam>fl)
    f0=1+delta/2
    ck(f'{tag}:F0 upper',f0<F(1001,1000))
    nup=F(T1*L,6)+8
    count=delta*f0*nup
    slow=F(lr*lg,7)
    ck(f'{tag}:B1 count upper',count<cap)
    ck(f'{tag}:B1 branch separation',cap<fl*slow)
    ck(f'{tag}:B0 count below1',delta*f0*N0<1)
    ck(f'{tag}:B0 reciprocal above1',fl*S0>1)
    rows.append(dict(row=tag,m=m,delta=str(delta),T1=T1,
        F1_lower=fl,S1_lower=str(slow),scaled_count_upper=str(count),
        simple_count_cap=cap,reciprocal_lower=str(fl*slow)))

out=dict(status='PASS_EXACT_SCALAR_BRANCH_TESTS_ONLY',checks=checks,rows=rows,
    scope='No RH, zero count, reciprocal sum, or full prime-gap inequality certified.')
path=Path(__file__).with_suffix('.json')
path.write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(out,indent=2))
