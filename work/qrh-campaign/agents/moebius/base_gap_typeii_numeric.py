import math
Y=1e25
qs=[10000,20000,30000,50000,75000,100000,120000,150000]
def phi(n):
    out=n;p=2
    while p*p<=n:
        if n%p==0:
            out-=out//p
            while n%p==0:n//=p
        p+=1
    if n>1:out-=out//n
    return out

def bound(q,t,y=Y,ph=None):
    ph=phi(q) if ph is None else ph
    C=math.log1p(math.log(4*t)/(2*math.log(9*y**(1/3)/(2.004*t))))
    d=t/q
    raw=math.sqrt(C*(math.log(t)+.002)+math.log(4*t)/2)*math.sqrt(.30214*math.log(t)+.7468)/math.sqrt(d*ph)
    final=((.27125*C+.41415)*math.log(t)+.8764)/math.sqrt(d*ph)+2.526/math.sqrt(t)+2/t*(q/ph*(3.25*math.log(t)+7.82)+13.66*math.log(t)+37.55)+3.8*y**(-1/6)
    direct=raw+2.5257/math.sqrt(t)+13.2/(d*ph)+2/t*(16.267*math.log(t)+24.42)+3.77*y**(-1/6)+3*math.log(y)/y
    return final,direct,raw
print('q phi min-t final direct typeII-main | upper-t final direct')
for q in qs:
    lo=max(2*q,1200000/49/4);hi=max(2*q,300000)
    print(q,phi(q),lo,*[round(z,9) for z in bound(q,lo)],'|',*[round(z,9) for z in bound(q,hi)[:2]])
print('uniform phi floor 3/16, min t scan ranges; diagnostics only')
for lo,hi in [(10000,20000),(20000,50000),(50000,100000),(100000,150000)]:
    maxv=max((bound(q,2*q,ph=3*q/16)[0],q) for q in range(lo,hi+1))
    print(lo,hi,maxv)
for q in [10000,50000,100000,150000]:
    vals=[(bound(q,max(2*q,1200000/49/4)*math.exp(i/1000*math.log(max(2*q,300000)/max(2*q,1200000/49/4))))[0],i) for i in range(1001)]
    print('t sample maximum',q,max(vals))
print('w upper using u<1.2e6', (4*Y**(1/3)/(3*1200000))**1.5)
print('six prime ratio', 2*3/2*5/4*7/6*11/10*13/12)
print('Actual totients: suffix worst raw bound at w=1,t=2q; NOT a Mellin certificate')
ph=list(range(150001))
for p in range(2,150001):
    if ph[p]==p:
        for j in range(p,150001,p):ph[j]-=ph[j]//p
for lo in [10000,20000,30000,50000,75000,100000,120000,140000]:
    value,q=max((bound(q,2*q,ph=ph[q])[1],q) for q in range(lo,150001))
    print(lo,q,ph[q],round(value,9),round(value*math.sqrt(math.pi/2),9))
print('Optimistic phi=q, t300000, final/direct',bound(150000,300000,ph=150000)[:2])
