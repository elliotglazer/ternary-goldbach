"""Selected independent Taylor checks; does not claim a second full numeric replay.
Manually forms exponential Taylor coefficients; N512 M36 K28 R3/4,192bits.
No builtin zeta, L-function, or zeta jets are used.
"""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json,time
from flint import arb,acb,acb_series,ctx
HERE=Path(__file__).resolve().parent;AUTHOR=HERE.parent/'mellin'
p=AUTHOR/'psi_head_counts_20261111_h1500.json'
assert hashlib.sha256(p.read_bytes()).hexdigest()=='82ad7acdffbcac24d190a98acb78bf66471249d09bfe2c43051add2aaec0d030'
d=json.loads(p.read_text());blocks=d['blocks'];N=512;M=36;K=28;R=F(3,4);LEFT=F(-1,10)
ctx.prec=192;ctx.cap=K
def ar(q):q=F(q);return arb(str(q.numerator))/q.denominator
def pt(x):return tuple(map(F,x))
def ac(x):return acb(ar(x[0]),ar(x[1]))
def box(a,b):
    return acb(arb(ar((a[0]+b[0])/2),ar(abs(a[0]-b[0])/2)),
               arb(ar((a[1]+b[1])/2),ar(abs(a[1]-b[1])/2)))
logs=[arb(j).log() for j in range(1,N+1)];lb=arb(N+1).log()
co=[arb.bernoulli(2*k)/factorial(2*k) for k in range(1,M+1)]
powers=[arb(N+1)**(1-2*k) for k in range(1,M+1)]
def exponential_jet(center,l):
    values=[(-center*l).exp()]
    for k in range(1,K):values.append(values[-1]*(-l)/k)
    return acb_series(values,prec=K)
def model(a,b):
    center=((a[0]+b[0])/2,(a[1]+b[1])/2);h=(abs(a[0]-b[0])+abs(a[1]-b[1]))/2
    assert 0<h<=F(1,10)
    c=ac(center);s=acb_series([c,1],prec=K)
    base=exponential_jet(c,lb)
    finite=sum((exponential_jet(c,l) for l in logs),acb_series([0],prec=K))+base/2
    rising=acb_series([1],prec=K);correction=acb_series([0],prec=K)
    for j in range(1,2*M):
        rising=rising*(s+j-1)
        if j%2:correction+=co[(j-1)//2]*powers[(j-1)//2]*rising
    finite=(s-1)*(finite+base*correction)+arb(N+1)*base
    # Direct outer majorant of finite g on radius3/4.
    so=abs(c)+ar(R);sigma=ar(center[0]-R)
    outer=sum(((-sigma*l).exp() for l in logs),arb(0))+(-sigma*lb).exp()/2
    rise=arb(1);corr=arb(0)
    for j in range(1,2*M):
        rise*=so+j-1
        if j%2:corr+=abs(co[(j-1)//2])*powers[(j-1)//2]*rise
    outer=(so+1)*(outer+(-sigma*lb).exp()*corr)+((1-sigma)*lb).exp()
    inner=abs(c)+ar(h);rise=arb(1)
    for j in range(2*M):rise*=inner+j
    em=(inner+1)*4*rise*(lb*(1-ar(LEFT)-2*M)).exp()/(6**(2*M)*(ar(LEFT)+2*M-1))
    q=ar(h/R);error=em+outer*q**K/(1-q)
    return center,[finite[j] for j in range(K)],error
selected=set(range(6))|set(range(len(blocks)-6,len(blocks)))
selected|={i*(len(blocks)-1)//95 for i in range(96)}
selected|={i for i,b in enumerate(blocks) if len(b['panels'])>1}
began=time.perf_counter();checked=0;leaves=0;maxdepth=0
def verify(a,b,c,coef,error,axis,sign,depth=0):
    global leaves,maxdepth
    z=box((a[0]-c[0],a[1]-c[1]),(b[0]-c[0],b[1]-c[1]));value=coef[-1]
    for coefficient in reversed(coef[:-1]):value=value*z+coefficient
    e=arb(0,error.upper());value+=acb(e,e)
    if sign*(value.real if axis==0 else value.imag)>0:
        leaves+=1;maxdepth=max(maxdepth,depth);return
    assert depth<8
    mid=((a[0]+b[0])/2,(a[1]+b[1])/2)
    verify(a,mid,c,coef,error,axis,sign,depth+1);verify(mid,b,c,coef,error,axis,sign,depth+1)
for i in sorted(selected):
    block=blocks[i];center,coef,error=model(pt(block['a']),pt(block['b']))
    for row in block['panels']:
        axis,sign=row['witness'];verify(pt(row['a']),pt(row['b']),center,coef,error,axis,sign);checked+=1
out={'status':'Selected independent Taylor panel checks pass, not a second full numerical replay',
 'N':N,'M':M,'K':K,'radius':str(R),'precision_bits':ctx.prec,
 'selected_block_indices':sorted(selected),'selected_blocks':len(selected),
 'panels_checked':checked,'verified_leaves':leaves,'maximum_extra_depth':maxdepth,
 'seconds':time.perf_counter()-began,'input_sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
HERE.joinpath('psi_head_taylor_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='selected_block_indices'},indent=2))
