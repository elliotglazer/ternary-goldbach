"""Independent rational arithmetic and finite coverage count; not a Lean proof."""
from fractions import Fraction as F
from math import factorial
import json

def exp_interval(x,n=160):
    assert 0<=x<n+2
    s=sum((x**j/factorial(j) for j in range(n+1)),F(0))
    tail=x**(n+1)/factorial(n+1)/(1-x/F(n+2))
    return s,s+tail

assert exp_interval(F('4.9'))[1]<140
assert exp_interval(F('16.1'))[0]>9600000
assert exp_interval(F('.98'))[0]>F(259,98)
assert exp_interval(F('12.21'))[0]>200000
assert exp_interval(F(32))[0]>10**13
assert F('.002292')**2>F('1.05')/200000
assert F('.002237')**2>F(1,200000)
assert (F('3.8')/F('.000428'))**6<5*10**23
assert 79000000**3<5*10**23
assert F('1.254')**2>F(11,7)
C=(F('.68')*F('12.21')+F('.8764'))*F('.002292')+F('2.526')*F('.002237')
C+=(F('1.05')*(F('3.25')*F('12.21')+F('7.82'))+F('13.66')*F('12.21')+F('37.55'))/100000
C+=F('.000428')
assert C==F(593191013,20000000000)
assert 17*F(1,20)**3/3<F('.000709')
assert 17*F(65,8)/10**13<F('2e-9')
total=F('1.254')*C+F('.000709')+F('2e-9')
assert total==F(379020785151,10**13)<F('.038')

phi=list(range(150001))
primes=[]
for p in range(2,150001):
    if phi[p]==p:
        primes.append(p)
        for k in range(p,150001,p): phi[k]-=phi[k]//p
covered=[q for q in range(100000,150001) if 20*q<=21*phi[q]]
covered_primes=[p for p in primes if 100000<=p<=150000]
assert set(covered_primes)<=set(covered)
print(json.dumps({'status':'rational arithmetic passed; analytic proof separately reviewed',
 'central_coefficient':str(C),'total_coefficient':str(total),
 'covered_reduced_denominators':len(covered),'covered_primes':len(covered_primes),
 'covered_composites':len(covered)-len(covered_primes)},indent=2))
