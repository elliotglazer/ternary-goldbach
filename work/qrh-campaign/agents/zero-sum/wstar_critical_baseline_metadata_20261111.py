"""Exact count majorants and conductor weights; no function or zero evaluations."""
from pathlib import Path
from fractions import Fraction as F
from math import gcd
import json
R=132900;L=2*R;scale=10**12
spf=list(range(L+1))
for p in range(2,L+1):
    if spf[p]==p:
        for n in range(p*p,L+1,p):
            if spf[n]==n:spf[n]=p
def fac(n):
    a=[]
    while n>1:
        p=spf[n];e=0
        while n%p==0:n//=p;e+=1
        a.append((p,e))
    return a
phi=[1]*(L+1);prim=[1]*(L+1);squarefree=[True]*(L+1)
for c in range(2,L+1):
    for p,e in fac(c):
        phi[c]*=(p-1)*p**(e-1)
        prim[c]*=(p-2 if e==1 else (p-1)**2*p**(e-2))
        if e>1:squarefree[c]=False
def ceil(q):return (q.numerator+q.denominator-1)//q.denominator
def oldH(c):return F(100000000,c) if c%2 or c<=125000 else F(200)+F(75000000,c)
def starH(c):
    qt=2*c if c%2 else c
    return F(max(1000,ceil(F(704*8*R,343*qt))))
power8=[8**k for k in range(40)];power3=[3**k for k in range(40)]
def bounds(c,T):
    lo=F(99,100)*T;hi=F(101,100)*T
    k=1
    while power8[k]*600*T.denominator<=power3[k]*c*101*T.numerator:k+=1
    b=42+F(693,100)*k
    upper=hi*(k-1)/3+1+200*b/T
    ell=0
    while power3[ell+1]*4400*T.denominator<c*99*T.numerator*7:ell+=1
    lower=lo*F(7,22)*(ell-1)-1-200*b/T
    return lower,upper,k,ell
profiles={'cap500':lambda c:min(oldH(c),F(500)),
          'cap1000':lambda c:min(oldH(c),F(1000)),
          'star_tail':starH,'original':oldH}
counts={name:{} for name in profiles}; samples={name:{} for name in profiles}
for c in range(3,L+1):
    if not ((c%2 and c<=R) or c%4==0):continue
    for name,fn in profiles.items():
        T=fn(c);low,up,k,ell=bounds(c,T)
        counts[name][c]=ceil(up)
        if c in [3,5,7,10001,132899,265800]:
            samples[name][str(c)]={'T':str(T),'count_lower':str(low),'count_upper_integer':ceil(up),'upper_log_integer':k,'lower_log_integer':ell}
out={name:{'weighted_count_A_upper_numerator':0,'weighted_count_B_upper_numerator':0} for name in profiles}
totient_weight=0;gausschecks=0
for q in range(1,L+1):
    if not ((q%2 and q<=R) or q%2==0):continue
    eligible=[1]
    for p,e in fac(q):
        if e==1:eligible += [c*p for c in eligible]
        else:eligible=[c*p**e for c in eligible]
    assert sum(c*prim[c] for c in eligible)==phi[q]**2
    gausschecks+=1
    if squarefree[q]:totient_weight+=(scale+phi[q]-1)//phi[q]
    for name in profiles:
        num=sum(c*prim[c]*counts[name].get(c,0) for c in eligible if c>1)
        out[name]['weighted_count_B_upper_numerator']+=(scale*num+phi[q]-1)//phi[q]
        if squarefree[q]:
            den=phi[q]**3
            out[name]['weighted_count_A_upper_numerator']+=(scale*num+den-1)//den
for name,v in out.items():
    v['Q_A_line_upper']=str(F(v['weighted_count_A_upper_numerator'],scale*10**25))
    v['Q_B_line_upper']=str(F(v['weighted_count_B_upper_numerator'],scale*10**25))
    v['A_upper_meets_target']=F(v['Q_A_line_upper'])<=F(4,7*10**18)
    v['B_upper_meets_target']=F(v['Q_B_line_upper'])<=F(4,7*10**6)
c3={}
for T in [F(2200000),F(100000000,3)]:
    low,up,k,ell=bounds(3,T)
    lowerQ=F(3,4)*low/F(10**25)
    assert lowerQ>F(4,7*10**18)
    c3[str(T)]={'count_lower':str(low),'Q_A_lower':str(lowerQ),'factor_over_target':str(lowerQ/F(4,7*10**18)),'upper_log':k,'lower_log':ell}
assert F(totient_weight,scale)<14
assert F(12,5)**8>1000
assert F(12,5)*F(out['star_tail']['Q_A_line_upper'])<F(4,7*10**18)
assert F(12,5)*F(out['star_tail']['Q_B_line_upper'])<F(4,7*10**6)
measureA=8*R*14
measureB=(3*R//2)*(8*R)*(2*R)
assert measureA<4000**2 and measureB<240000000**2
assert F(2,10**12)*4000<F(1,10**6)
assert F(2,10**12)*240000000<1
result={'status':'PASS_EXACT_WEIGHTED_COUNT_BOUNDS','R':R,'scale':scale,'profiles':out,
        'samples':samples,'c3_obstructions':c3,'Qset_count':gausschecks,
        'sum_squarefree_inverse_phi_upper':str(F(totient_weight,scale)),
        'remainder_measure_upper':{'A':measureA,'B':measureB},
        'finite_band_beta': '203/400',
        'finite_band_multiplier_upper':'12/5',
        'scope':'Count inequalities use reviewed integrated Turing+Binet paper contracts. Upper Q values are conditional all-critical baselines; c3 lower uses reflection and is unconditional at paper scope. No actual zero counts produced.'}
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'profiles':out,'c3':c3,'totient_weight':result['sum_squarefree_inverse_phi_upper']},indent=2))
