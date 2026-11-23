"""Exact low-order scalar/recurrence audit, conditional on analytic source lemmas."""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import json

coeff=[1]
rows=[coeff]
for n in range(2):
    get=lambda k:coeff[k] if 0<=k<len(coeff) else 0
    coeff=[(n+2*k-1)*(n+2*k)*get(k-1)+(2*n+4*k+1)*get(k) for k in range(n+2)]
    rows.append(coeff)
assert rows==[[1],[1,2],[3,20,40]]
t=1500;theta=Q(1,4);w=Q(17,36)
assert theta**2>Q(14,t) and t>Q(7)/Q(44,100)
# The elementary analytic inputs pi>3.14, sqrt2>1.4 give this prefactor bound.
y2=Q(250,1099)*sum(Q(coeff[k]*factorial(k),factorial(2+2*k))/w**(k+1) for k in range(3))
y3=Q(100,157)*sum(Q(2**k*coeff[k]*factorial(k),factorial(2+2*k)) for k in range(3))
poly=lambda x:sum(Q(coeff[k],factorial(2+2*k))*Q(3+2*k,2)*x**k for k in range(3))
assert poly(100)<2200 and poly(1500)<450000
assert theta**2*t<100 and theta**2*t<10**2 and t<39**2
assert sum(Q(1,factorial(k)) for k in range(5))>Q(8,3)
assert Q(8,3)**20>300000000 and Q(t,64)>20
assert Q(22,100)*t>40
# For both discarded sinh denominators: sqrt(2*pi*t)>16 and sqrt(pi)>1.
assert 2*Q(157,50)*t>16**2
assert Q(44,100)*2*4>1
y1=Q(22000,300000000);y4=Q(39*450000,2**40)
assert y2<Q(182,100) and y3<Q(231,100)
assert y1<Q(1,1000) and y4<Q(1,1000)
rs=y1+y2+y3+y4
assert rs<Q(42,10)
phase=Q(1,6)+Q(28,45)/40**4+Q(3968,315)/40**8+Q(8**7,3322)/40**12
assert phase<Q(1,5)
assert Q(1,5)*(1+Q(8,5)/40)<Q(21,100)
r=Q(198,125)
assert r**4>Q(44,7) and 38**2<t
cap=r**3/(3*Q(157,50))+Q(441,100)*r/(8*38)
assert cap<Q(45,100)
# With t>=1500, t^(25/4)>=1, so this coarse comparison absorbs phase error
# 80/(3322*t^7) into the .02*t^(-3/4) gap using t^(25/4)>=t>=1500.
assert Q(80,3322*1500)<Q(2,100)
out=dict(status='PASS_CONDITIONAL_SCALARS',recurrence_rows=rows,rs1_coefficient=str(rs),
         phase_coefficient=str(phase),final_coefficient=str(cap),
         source_analytic_lemmas_proved=False)
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps(out,indent=2))
