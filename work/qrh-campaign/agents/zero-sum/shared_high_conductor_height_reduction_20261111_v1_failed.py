"""Exact scalar bounds only: proposed high-conductor cutoff change.
No function/zero evaluation, no imports of predecessor scripts, no floats in acceptance.
"""
from fractions import Fraction as F
from math import gcd, factorial, isqrt
from functools import lru_cache
from pathlib import Path
import json, hashlib, time
START=time.monotonic()
MAX=300000; SCALE=10**20
PI=F(22,7)
def ceil(x): return -(-x.numerator//x.denominator)
def up(x,s=SCALE): return F(ceil(x*s),s)
def sqrtup(x,s=10**12):
    n=ceil(x*s*s); a=isqrt(n)
    if a*a<n:a+=1
    return F(a,s)
E=sum((F(1,factorial(j)) for j in range(21)),F(0))
@lru_cache(None)
def eneg(z):
    k=z.numerator//z.denominator; r=z-k; t=F(1); v=t
    for j in range(1,17): t=t*r/j;v+=t
    return 1/(E**k*v)
def eb(t):
    assert t>=50
    t=min(t,F(2000))
    return F('0.892')*t*eneg(F('.1598')*t)
def ea(t,d):
    assert t>=10*PI*d
    u=min(t/(PI*d),F(40))
    return F('.588')*u*u*eneg(F('.1065')*u*u)
def oldhs(c):
    d=F(1200000,2*c if c%2 else c)
    return ceil(max(F(1000),F(704,343)*d))
def H(c):return F(50000000 if c%2 else 99000000,c)
def tail(lo,hi,odd):
    d=F(600000 if odd else 1200000,lo); h=H(hi)
    assert h-200>=max(F(50),10*PI*d)
    g=3+d/F('2.7'); ga=800*g+106/h*g*g;gb=2400+954/h
    t=F('3.5')*(eb(h-100)*gb+ea(h-100,d)*ga)
    t+=F('.00625')*(eb(h-200)*gb+ea(h-200,d)*ga)
    return ceil(t/2125*SCALE)
# Re-establish all affected-height elementary domain requirements.
assert F(99000000,300000)==330
assert 99000000-200*300000>10*PI*1200000
assert 50000000-200*150000>10*PI*600000
assert 250*300000<99000000
assert 250*150000<50000000
assert F(580800000,7)+300000<99000000
assert F(290400000,7)+150000<50000000
# e<3, so log(10/3)>1; kappa<=12 gives c3<52.8/H<53/H.
assert F(12)*F('4.4')<53
# Old polynomial log bound (<349) only needs H<=1e8, not a lower floor.
# Changed H ranges [330,1000), hence satisfies that same upper bound.
assert H(100004)<1000 and H(100001)<1000
phi=list(range(MAX+1)); spf=list(range(MAX+1)); mu=[1]*(MAX+1)
a=[0]*(MAX+1);a[1]=1
for p in range(2,MAX+1):
    if spf[p]==p:
        for n in range(p,MAX+1,p):
            phi[n]-=phi[n]//p;mu[n]*=-1
            if spf[n]==n:spf[n]=p
        for n in range(p*p,MAX+1,p*p):mu[n]=0
for n in range(2,MAX+1):
    p=spf[n];v=n;e=0
    while v%p==0:v//=p;e+=1
    a[n]=a[v]*(p-2 if e==1 else p**(e-2)*(p-1)**2)
tails=[0]*(MAX+1);cells=[]
for odd in (True,False):
    lo=100001 if odd else 100004;lim=150000 if odd else MAX;step=2 if odd else 4
    while lo<=lim:
        # Narrow cells retain source-tail applicability at the two corners.
        hi=min(lim,lo+100);hi=lo+(hi-lo)//step*step
        t=tail(lo,hi,odd)
        for c in range(lo,hi+1,step):tails[c]=t
        cells.append({'lo':lo,'hi':hi,'odd':odd,'tail_numerator':t})
        lo=hi+step
ET=[0]*(MAX+1);ES=[0]*(MAX+1);GW=[0]*(MAX+1)
active=[];changed=[];weighted_old=F(0);weighted_new=F(0)
for c in range(1,MAX+1):
    if not a[c] or(c%2 and c>150000):continue
    active.append(c)
    if c>100000:
        changed.append(c)
        assert oldhs(c)==1000
        weighted_old+=a[c]*F(100000000,c)
        weighted_new+=a[c]*H(c)
    ns=ceil(400*(F(50,87)*oldhs(c)+2))
    for q in range(c,MAX+1,c):
        if q%2 and q>150000:continue
        r=q//c
        if mu[r] and gcd(c,r)==1:
            w=c*a[c];ET[q]+=w*tails[c]**2;ES[q]+=w*ns;GW[q]+=w
assert len(active)==150000 and sum(a[c] for c in active)==5543640188
assert len(changed)==75000
nt=F(0);mixcoeff=F(0);at=F(0)
for q in range(1,MAX+1):
    if q%2 and q>150000:continue
    assert GW[q]==phi[q]**2
    d=F(1200000,2*q if q%2 else q)
    nt+=up(2*d*F(ET[q],phi[q]*SCALE**2))
    mixcoeff+=up(F(ET[q]*ES[q],phi[q]**2*SCALE**2),10**8)
    if mu[q]:
        at+=up(min(F('381.22'),2*d*F('1.2534')**2)*F(ET[q],phi[q]**3*SCALE**2),10**32)
ystar=F('5.625e-23');assert ystar**4*10**89>1
mix=mixcoeff*(49*102000)*ystar
# Add the OLD FULL-family envelope, intentionally double-counting old high c.
NT=nt+F('.025');IT=mix+F('2.5e-8');AT=at+F('1e-20')
# Star at the new common minimum330, independently rechecked.
hs=F(330);ds=F(12,49);gs=F('3.1')
star=2*(eb(hs)*(2400+954/hs)+ea(hs,ds)*(800*gs+106/hs*gs*gs))/1333
assert star<F('1e-18')
d0=F('2e-15');dstar=F('2e-12')
extra=d0*55000+dstar*25+dstar*sqrtup(300000*NT)+d0*dstar*180000000000
cross=(F('.0005')+sqrtup(IT)+extra)**2
ast=(F('.00049')+F('1.2e-6'))**2
ap=(F('.00007')+sqrtup(AT)+F('2e-9'))**2
n=(F('.032')+sqrtup(NT)+F('2e-9'))**2
ep=(F('.0002')+F('1e-8'))**2
checks={'Aplus':ap<F('5e-7'),'Astar':ast<F('2.5e-7'),'N':n<F('1.23'),'Ep':ep<F('1e-4'),'Astar_plus_Cross':ast+cross<F('9.5e-7')}
def pack(x):return {'exact':str(x),'display':format(float(x),'.15g')}
out={'status':'PASS_EXACT_SCALAR_PROPOSAL' if all(checks.values()) else 'FAIL_SUFFICIENT_SCALAR_BUDGET',
 'checks':checks,'profile':{'unchanged_through':100000,'odd_numerator':50000000,'even_numerator':99000000},
 'cells':len(cells),'changed_conductors':len(changed),'changed_characters':sum(a[c] for c in changed),
 'new_high_N_energy':pack(nt),'new_high_mixed_energy':pack(mix),'new_high_Aplus_energy':pack(at),
 'total_N_energy':pack(NT),'total_mixed_energy':pack(IT),'total_Aplus_energy':pack(AT),
 'star_tail':pack(star),'mixed_extra_norm':pack(extra),'Aplus':pack(ap),'Astar':pack(ast),'Cross':pack(cross),
 'Astar_plus_Cross':pack(ast+cross),'N':pack(n),'Ep':pack(ep),
 'changed_weighted_height_old':pack(weighted_old),'changed_weighted_height_new':pack(weighted_new),
 'weighted_height_ratio':pack(weighted_new/weighted_old),
 'max_new_tail':pack(F(max(tails),SCALE)),
 'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
 'elapsed_seconds_diagnostic':time.monotonic()-START}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
Path(__file__).with_name(Path(__file__).stem+'_cells.json').write_text(json.dumps(cells,separators=(',',':'))+'\n')
print(json.dumps(out,indent=2))
