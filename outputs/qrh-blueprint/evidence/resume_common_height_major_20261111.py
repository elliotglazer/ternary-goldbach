"""Exact scalar certificate for the conditional common-height major-arc route.

This checks rational envelopes and finite arithmetic, not zeros or analytic lemmas.
Only the optional decimal displays convert exact fractions to float.
"""
from fractions import Fraction as F
from math import gcd, factorial
from pathlib import Path
import json, hashlib, time

START=time.time()
M=300000; R=150000; SCALE=10**18
def ceilf(x): return -(-x.numerator//x.denominator)
def up(x,scale=SCALE): return F(ceilf(x*scale),scale)
ELOW=sum((F(1,factorial(j)) for j in range(21)),F(0))
def expneg(z):
    """exp(-z) <= inverse positive Taylor lower sums; no float decisions."""
    k=z.numerator//z.denominator; r=z-k
    t=F(1); s=t
    for j in range(1,17): t*=r/j; s+=t
    return 1/(ELOW**k*s)
def eb(t):
    assert t>=50
    t=min(t,F(2000))
    return F('0.892')*t*expneg(F('0.1598')*t)
def ea(t,d):
    assert t>=10*F(22,7)*d
    u=min(t/(F(22,7)*d),F(40))
    assert u>=10
    return F('0.588')*u*u*expneg(F('0.1065')*u*u)
def oldhp(c):
    d=F(1200000,2*c if c%2 else c)
    return ceilf(200+max(F(1000),F(704,7)*d))
def oldhs(c):
    d=F(1200000,2*c if c%2 else c)
    return ceilf(max(F(1000),F(704,343)*d))
def cutp(c): return min(F(100000000,c),F(oldhp(c)))
def cuts(c): return min(F(100000000,c),F(oldhs(c)))
def tailcell(lo,hi,odd):
    d=F(1200000,(2 if odd else 1)*lo)
    h=cutp(hi)
    g=3+d/F('2.7'); ga=800*g+106/h*g*g; gb=2400+954/h
    assert h-200>=max(F(50),10*F(22,7)*d)
    val=F('3.5')*(eb(h-100)*gb+ea(h-100,d)*ga)
    val+=F('.00625')*(eb(h-200)*gb+ea(h-200,d)*ga)
    return ceilf(val/F(2125)*SCALE)

# Source-derived Fourier mass inequalities and endpoint normalization.
assert F(368)/(3*F('3.141')*100**3)<F('.00625')**2
assert F('2.03')*3/F('3.141')<F('1.94')
assert F(368)/(81*F('3.141'))<F('1.21')**2
assert F('1.94')+F('1.21')<F('3.5')
assert 2125**8<49*10**25
YSTAR=F('5.625e-23')
assert YSTAR**4*10**89>1  # y0^(-.89) < YSTAR, y0=10^25.

phi=list(range(M+1));spf=list(range(M+1));mu=[1]*(M+1)
a=[0]*(M+1);a[1]=1
for p in range(2,M+1):
    if spf[p]==p:
        for n in range(p,M+1,p):
            phi[n]-=phi[n]//p;mu[n]*=-1
            if spf[n]==n:spf[n]=p
        for n in range(p*p,M+1,p*p):mu[n]=0
for n in range(2,M+1):
    p=spf[n];v=n;e=0
    while v%p==0:v//=p;e+=1
    a[n]=a[v]*(p-2 if e==1 else p**(e-2)*(p-1)**2)

# Monotone conductor cells: <=0.25% relative width, capped at 200 integers.
# Each parity has its own formula. Empty primitive families do not contribute.
tails=[0]*(M+1); cells=[]
for odd in (True,False):
    lo=1 if odd else 4; limit=R if odd else M; step=2 if odd else 4
    while lo<=limit:
        span=min(200,max(0,lo//400))
        hi=min(limit,lo+span); hi=lo+((hi-lo)//step)*step
        t=tailcell(lo,hi,odd)
        for c in range(lo,hi+1,step): tails[c]=t
        cells.append({'lo':lo,'hi':hi,'odd':odd,'tail_numerator':t})
        lo=hi+step
print('enclosed cells',len(cells),'elapsed',round(time.time()-START,2),flush=True)

ET=[0]*(M+1); ES=[0]*(M+1); GW=[0]*(M+1)
active=[]
for c in range(1,M+1):
    if not a[c] or(c%2 and c>R):continue
    active.append(c)
    assert cuts(c)<=oldhs(c) and cutp(c)<=oldhp(c)
    if cuts(c)<oldhs(c):
        assert c>100000 and oldhs(c)==1000
    ns=ceilf(400*(F(50,87)*oldhs(c)+2))
    for q in range(c,M+1,c):
        if q%2 and q>R:continue
        r=q//c
        if mu[r] and gcd(c,r)==1:
            w=c*a[c]
            ET[q]+=w*tails[c]**2
            ES[q]+=w*ns
            GW[q]+=w
assert len(active)==150000 and sum(a[c] for c in active)==5543640188

nt=F(0); mix_coefficient=F(0); at=F(0)
for q in range(1,M+1):
    if q%2 and q>R:continue
    assert GW[q]==phi[q]**2
    d=F(1200000,2*q if q%2 else q)
    nt+=up(2*d*F(ET[q],phi[q]*SCALE**2))
    # Round this unscaled coefficient at 1e-6; its eventual factor is <3e-16.
    mix_coefficient+=up(F(ET[q]*ES[q],phi[q]**2*SCALE**2),10**6)
    if mu[q]:
        at+=up(min(F('381.22'),2*d*F('1.2534')**2)*F(ET[q],phi[q]**3*SCALE**2),10**30)
mix=mix_coefficient*(49*102000)*YSTAR
assert nt<F('.025')
assert mix<F('2.5e-8')
assert at<F('1e-20')

# Star tail when the common cutoff, rather than old Hstar, is active.
# Then c>100000, H>=1000/3, d=D/49<=12/49, G<3.1.
# H/(pi*d)>= (100000000*49/1200000)/(22/7)>1299.
# Capping EA at u=40 is already ample.
hs=F(1000,3); ds=F(12,49); gs=F('3.1')
starcoef=2*(eb(hs)*(2400+954/hs)+ea(hs,ds)*(800*gs+106/hs*gs*gs))
assert starcoef/F(1333)<F('1e-18')
assert 1333**8<10**25

# Complete perturbation ledger. New plus spectral tail is aggregated above;
# remaining plus error is d0. Star error includes its new high tail.
d0=F('2e-15'); ds0=F('2e-12')
# Bounds for low moment norms and the previously reviewed two-character norm.
assert F('.16')**2>F('.025')
assert F('.00016')**2>F('2.5e-8')
assert F('.032')**2>F('.001')
extra=d0*55000+ds0*25+ds0*87+d0*ds0*180000000000
assert 87**2>300000*F('.025')
assert extra<F('1e-9')
rmix=F('.00016')+extra
assert rmix<F('.000160001')
cross=(F('.0005')+rmix)**2
assert cross<F('7e-7')
ap=(F('.00007')+F('1e-10')+F('2e-9'))**2
ast=(F('.00049')+F('1.2e-6'))**2
n=(F('.032')+F('.16')+F('2e-9'))**2
ep=(F('.0002')+F('1e-8'))**2
assert ap<F('5e-7') and ast<F('2.5e-7') and n<F('1.23') and ep<F('1e-4')
assert ast+cross<F('9.5e-7')
assert (F('2.94')-F('.00020001')-F('1e-9'))**2>F('8.6296')

def pack(v):return {'rational':str(v),'decimal_diagnostic':float(v)}
out={'status':'exact scalar checks only; conditional analytic implication; no zero certificate',
     'cells':len(cells),'active_conductors':len(active),'primitive_characters':sum(a[c] for c in active),
     'tail_rounding_denominator':SCALE,'maximum_tail':pack(F(max(tails),SCALE)),
     'maximum_tail_conductor':tails.index(max(tails)),
     'N_high_energy':pack(nt),'mixed_high_low_energy':pack(mix),'Aplus_high_energy':pack(at),
     'star_high_bound':pack(up(starcoef/1333,10**30)),
     'mixed_extra_norm':pack(extra),'mixed_remainder_norm':pack(rmix),
     'Aplus_full':pack(ap),'Astar_full':pack(ast),'N_full':pack(n),'Ep_full':pack(ep),'Cross_full':pack(cross),
     'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
Path(__file__).with_name('resume_common_height_major_20261111_cells.json').write_text(json.dumps(cells,separators=(',',':'))+'\n')
print(json.dumps(out,indent=2));print('elapsed',round(time.time()-START,2))
