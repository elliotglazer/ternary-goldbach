"""Formal coefficient identities/counts only; no polynomial samples or values."""
from collections import Counter
from pathlib import Path
from math import comb, factorial
import json

checks=0
def ck(x):
    global checks
    assert x
    checks+=1
def add(*polys):
    out=Counter()
    for p in polys:
        for key,v in p.items():out[key]+=v
    return {key:v for key,v in out.items() if v}
def scale(p,q=0,g=0,n=1):
    return {(e,a+q,b+g):n*v for (e,a,b),v in p.items() if n*v}

S=[[0]*20 for _ in range(20)]
S[0][0]=1
for n in range(1,20):
    for k in range(1,n+1):S[n][k]=k*S[n-1][k]+S[n-1][k-1]

def closed(low,j):
    out={}
    for e in range(low,20):
        degree=e-low
        for ell in range(j,degree+1):
            coefficient=comb(degree,ell)*factorial(j)*S[ell][j]
            if coefficient:out[e,degree-ell,ell]=coefficient
    return out

def main():
    # A_e are independent formal coefficients. q0 and G are indeterminates.
    D=[{(19,0,0):1}]
    general=small=addition=0
    for low in range(18,-1,-1):
        old_degree=len(D)-1
        D.append(scale(D[-1],g=1,n=old_degree+1))
        small+=1
        for j in range(old_degree,0,-1):
            D[j]=add(scale(D[j],q=1),scale(D[j],g=1,n=j),
                     scale(D[j-1],g=1,n=j))
            general+=1;small+=1;addition+=1
        D[0]=add(scale(D[0],q=1),{(low,0,0):1})
        general+=1;addition+=1
        for j,p in enumerate(D):ck(p==closed(low,j))
    ck((general,small,addition)==(190,190,190))
    # Independent triangle of formal coefficient vectors, never value evaluation.
    # Coefficient of A_e in p(q0+vG) is expanded symbolically.
    rows=[]
    for v in range(20):
        p={}
        for e in range(20):
            for ell in range(e+1):
                n=comb(e,ell)*v**ell
                if n:p[e,e-ell,ell]=n
        rows.append(p)
    triangle=[]
    for order in range(20):
        triangle.append(rows[0])
        ck(triangle[-1]==D[order])
        rows=[add(rows[k+1],scale(rows[k],n=-1)) for k in range(len(rows)-1)]
    ck(len(rows)==0)
    # There is no binomial-basis coefficient of order20 in a degree19 polynomial.
    ck(closed(0,20)=={})
    micro_add=sum((20-j)*(j.bit_count()-1) for j in range(1,20))
    shifted=sum((20-j)*j.bit_count() for j in range(1,20))
    ck((micro_add,shifted)==(167,357))
    ck(190+micro_add==357)
    ck(20*19==380 and 20*19+sum(range(1,20))==570)
    # Symbolic scalar inequalities used in the screened partial-stage proof.
    ck(10+19<30)  # 1/4+19/40=29/40 <3/4
    ck(19<20)
    for i in range(19):
        for j in range(1,i+1):
            ck(3*(1<<j)+(1<<j)==4*(1<<j))
        ck(i+1<=19)
    power=(2*265800)**19
    ck(power.bit_length()==362)
    ck(122+362+37+1==522)
    ck(122+362+38+1==523)
    ck(2*265800 < 1<<20)
    ck(29*265800 < 20*(1<<19))
    out=dict(status='PASS_FORMAL_NEWTON_INITIALIZATION_IDENTITIES',checks=checks,
        degree=19,counts=dict(general_products=general,small_jG_scales=small,
        recurrence_additions=addition,tiny_binary_additions=micro_add,
        shifted_operand_occurrences=shifted,coefficient_prescales=19),
        denominator_power_bits=power.bit_length(),
        scope='All20independent coefficient indeterminates and two formal geometry indeterminates; no analytic or polynomial function samples, no circuit implementation.')
    path=Path(__file__).with_suffix('.json')
    with path.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
    print(json.dumps({'status':out['status'],'checks':checks}))

if __name__=='__main__':main()
