"""Finite arithmetic for exact Gauss-support induction; no analytic caps assumed."""
import json,math
from pathlib import Path
P=Path(__file__).resolve().parent
R=150000
flag=bytearray(b'\1')*(R+1);flag[:2]=b'\0\0'
for p in range(2,math.isqrt(R)+1):
    if flag[p]:flag[p*p::p]=b'\0'*((R-p*p)//p+1)
primes=[p for p in range(3,R+1,2) if flag[p]]
scale=1<<160

def constants(m=1,cutoff=R):
    # lambda(1/d)^2=(2*d*d+1+sqrt(4*d*d+1))/(2*d*d).
    # Enclose the square root and every product UP by integer arithmetic.
    factor=2 if m%2 else 1
    up=factor*scale;diagnostic=float(factor)
    for p in primes:
        if p>cutoff:break
        if m%p==0:continue
        d=p-1;radicand=(4*d*d+1)*scale*scale
        root=math.isqrt(radicand)
        if root*root<radicand:root+=1
        num=(2*d*d+1)*scale+root;den=2*d*d*scale
        up=(up*num+den-1)//den
        h=1/d;diagnostic*=((math.sqrt(4+h*h)+h)/2)**2
    return dict(m=m,cutoff=cutoff,exact_norm_product_diagnostic=diagnostic,
        rational_upper_numerator=str(up),rational_upper_denominator=str(scale),
        rational_upper_diagnostic=up/scale,ceiling=(up+scale-1)//scale)

globalc=constants()
blocks=[constants(m,R//m if m%2 else 2*R//m) for m in (1,4,8,9,16,36,900,144)]
prefactor=(4.9e26*1e25)**(-.25)
cap=7e-7
rows=[]
for joint in (.01,.1,1,10,100,1000):
    s=cap/(globalc['ceiling']*prefactor*joint)
    rows.append(dict(J_cell=joint,max_S=s,max_zero_count_if_b_per_zero_6=math.floor(s/36),
                     max_zero_count_single_conductor_if_b_per_zero_6=math.floor(math.sqrt(s)/6)))

# Independently check exact support coefficient against direct divisor enumeration.
def phi(n):
    out=n;p=2
    while p*p<=n:
        if n%p==0:
            out-=out//p
            while n%p==0:n//=p
        p+=1
    if n>1:out-=out//n
    return out
def sf(n):
    p=2
    while p*p<=n:
        if n%(p*p)==0:return False
        p+=1
    return True
def compatible(c,q):return q%c==0 and sf(q//c) and math.gcd(c,q//c)==1
def powpart(n):
    out=1;p=2
    while p*p<=n:
        power=1
        while n%p==0:n//=p;power*=p
        if power>p:out*=power
        p+=1
    return out
from fractions import Fraction as F
tests=[]
for c,d in [(1,1),(3,5),(3,3),(4,3),(9,3),(9,45),(36,180),(16,80),(8,16),(12,20),(15,21)]:
    r=300;l=math.lcm(c,d)
    direct=sum((F(c*d,phi(q)**2) for q in range(1,2*r+1)
        if (q%2==0 or q<=r) and compatible(c,q) and compatible(d,q)),F())
    if powpart(c)!=powpart(d):formula=F()
    else:
        formula=F(c*d,phi(l)**2)*sum((F(1,phi(k)**2) for k in range(1,2*r//l+1)
            if sf(k) and math.gcd(k,l)==1 and (l*k%2==0 or l*k<=r)),F())
    assert direct==formula,(c,d,direct,formula)
    tests.append(dict(c=c,d=d,weight=str(direct)))
result=dict(global_constant=globalc,blocks=blocks,spectral_prefactor=prefactor,
    illustrative_cross_cap=cap,cell_sensitivity=rows,pair_support_tests=tests,
    warning='Rational arithmetic certifies only the operator upper bound. Cell J and density statistics remain unproved analytic inputs. Sensitivity values are floating diagnostics.')
assert F(25)*F(279,10**10)<F(8352,10**7)**2
assert (F(8352,10**7)+F(1,10**6))**2<F(7,10**7)
dp=F(1,10**23);ds=F(14,10**22)
assert F(194,100)*(F(12400,69)+1)*13+1<4900
assert F(62,10)*(F(11600,69)+1)*13+1<14000
assert 11160000000**2>300000*415000000000000
assert 4136**2>300000*57
euler_norm=dp*11160000000+ds*4136+dp*ds*180000000000
assert euler_norm<F(12,10**14)
result['exact_budget_checks']=dict(I_cap='2.79e-8',mixed_remainder_norm_cap='1e-6',
    Cross_upper_from_rational_square=str((F(8352,10**7)+F(1,10**6))**2),
    Astar_cap='2.5e-7',Euler_mixed_norm_upper=str(euler_norm),
    Euler_scope='Requires J<=10 and prior coprime energy bounds; raw source removal lemmas plus elementary log/monotonicity bridges.')
(P/'resume_mixed_operator_20261111.json').write_text(json.dumps(result,indent=2))
print(json.dumps(result,indent=2))
