"""Independent complete rational K0 evaluations and optional explicit EM checks.

No producer import, no builtin zeta, Gamma, Riemann--Siegel or zero routines.
"""
from fractions import Fraction as Q
from math import factorial, isqrt
from pathlib import Path
from functools import lru_cache
import hashlib, json, time

BITS = 320
D = 1 << BITS
HERE = Path(__file__).resolve().parent
START = time.monotonic()


def limit():
    if time.monotonic()-START > 560:
        raise RuntimeError('560-second computation limit')


def box(lo, hi=None):
    lo = Q(lo); hi = lo if hi is None else Q(hi)
    assert lo <= hi
    l = (lo*D).numerator // (lo*D).denominator
    z = -hi*D
    h = -(z.numerator // z.denominator)
    out = Q(l, D), Q(h, D)
    assert out[0] <= lo <= hi <= out[1]
    return out


def add(a,b): return box(a[0]+b[0],a[1]+b[1])
def neg(a): return -a[1],-a[0]
def sub(a,b): return add(a,neg(b))
def mul(a,b):
    p=[x*y for x in a for y in b]
    return box(min(p),max(p))
def scale(c,a): return mul((Q(c),Q(c)),a)
def inv(a):
    assert a[0]>0 or a[1]<0
    return box(1/a[1],1/a[0])
def div(a,b): return mul(a,inv(b))
def square(a):
    return box(0 if a[0]<=0<=a[1] else min(x*x for x in a),max(x*x for x in a))
def absolute(a):
    return box(0 if a[0]<=0<=a[1] else min(abs(x) for x in a),max(abs(x) for x in a))
def sqrt_point(q):
    assert q>=0
    m=isqrt((q*D*D).numerator//(q*D*D).denominator)
    assert Q(m,D)**2<=q<Q(m+1,D)**2
    return Q(m,D),Q(m+1,D)
def sqrt_box(a):
    assert a[0]>=0
    return sqrt_point(a[0])[0],sqrt_point(a[1])[1]
def widen(a,e):
    assert e>=0
    return box(a[0]-e,a[1]+e)
def encode(a): return list(map(str,a))


def atan_point(x,n):
    assert 0<x<1 and n%2==0
    s=sum(((-1)**j*x**(2*j+1)/Q(2*j+1) for j in range(n)),Q(0))
    return box(s,s+x**(2*n+1)/Q(2*n+1))


PI= sub(scale(16,atan_point(Q(1,5),40)),scale(4,atan_point(Q(1,239),16)))
assert 3<PI[0]<=PI[1]<Q(22,7)


def log_small(y):
    assert 1<=y<=2
    if y==1: return Q(0),Q(0)
    u=(y-1)/(y+1)
    ub=box(u); v=square(ub)
    m=64
    h=box(Q(1,2*m-1))
    for j in range(m-2,-1,-1): h=add(box(Q(1,2*j+1)),mul(v,h))
    s=scale(2,mul(ub,h))
    e=2*Q(1,3)**(2*m+1)/((2*m+1)*(1-Q(1,9)))
    return box(s[0],s[1]+e)


LOG2=log_small(Q(2))


@lru_cache(None)
def log_point(q):
    assert q>0
    y=q; k=0
    while y>2: y/=2; k+=1
    while y<1: y*=2; k-=1
    return add(scale(k,LOG2),log_small(y))


def log_box(a):
    assert a[0]>0
    return log_point(a[0])[0],log_point(a[1])[1]


def cos_box(a):
    center=(a[0]+a[1])/2
    pcenter=(PI[0]+PI[1])/2
    z=center/(2*pcenter)+Q(1,2)
    k=z.numerator//z.denominator
    y=sub(a,scale(2*k,PI))
    assert -4<=y[0]<=y[1]<=4
    v=square(y); m=40
    h=box(Q((-1)**(m-1),factorial(2*m-2)))
    for j in range(m-2,-1,-1):
        h=add(box(Q((-1)**j,factorial(2*j))),mul(v,h))
    e=Q(2*4**(2*m),factorial(2*m))
    return widen(h,e)


def sinc_box(a):
    assert -2<=a[0]<=a[1]<=2
    v=square(a); m=32
    h=box(Q((-1)**(m-1),factorial(2*m-1)))
    for j in range(m-2,-1,-1):
        h=add(box(Q((-1)**j,factorial(2*j+1))),mul(v,h))
    return widen(h,Q(2*2**(2*m),factorial(2*m+1)))


@lru_cache(None)
def sqrt_integer(n): return sqrt_box((Q(n),Q(n)))


def evaluate(t):
    limit(); assert t>=1500
    tb=(t,t)
    asq=div(tb,scale(2,PI))
    n=isqrt(asq[0].numerator//asq[0].denominator)
    assert 2*PI[1]*n*n<t<2*PI[0]*(n+1)**2
    a=sqrt_box(asq); assert n<a[0]<=a[1]<n+1
    z=sub(box(1),scale(2,sub(a,box(n))))
    w=absolute(z); w=(max(w[0],Q(0)),min(w[1],Q(1)))
    assert 0<=w[0]<=w[1]<=1
    aa=scale(Q(1,2),mul(PI,sub(square(w),box(Q(1,4)))))
    bb=mul(PI,sub(w,box(Q(1,2))))
    sn,sd=sinc_box(aa),sinc_box(bb)
    assert sd[0]>Q(1,2)
    f=div(mul(scale(Q(1,2),add(w,box(Q(1,2)))),sn),sd)
    theta=add(sub(sub(scale(t/2,log_box(asq)),box(t/2)),scale(Q(1,8),PI)),box(1/(48*t)))
    terms=[]
    for j in range(1,n+1):
        arg=sub(theta,scale(t,log_point(Q(j))))
        terms.append(div(scale(2,cos_box(arg)),sqrt_integer(j)))
    correction=scale(-(-1)**n,div(f,sqrt_box(a)))
    value=box(0)
    for v in terms+[correction]: value=add(value,v)
    power=sqrt_box(sqrt_box((1/t**3,1/t**3)))
    radius=Q(451,1000)*power[1]
    hardy=widen(value,radius)
    assert value[1]-value[0]<Q(1,10**30)
    return {"t":str(t),"N":n,"a":encode(a),"z":encode(z),"w":encode(w),
            "A":encode(aa),"B":encode(bb),"sqrt_a":encode(sqrt_box(a)),
            "theta_hat":encode(theta),"sinc_numerator":encode(sn),
            "sinc_denominator":encode(sd),"F":encode(f),
            "terms":[encode(v) for v in terms],"correction":encode(correction),
            "Khat":encode(value),"power":encode(power),"hardyZ":encode(hardy)}


def explicit_em(ts):
    from flint import arb,acb,ctx
    ctx.prec=224
    def ar(q):
        q=Q(q); return arb(str(q.numerator))/q.denominator
    def enc(v): return [str(v.lower().fmpq()),str(v.upper().fmpq())]
    def ball(b):
        lo,hi=map(Q,b)
        return ar((lo+hi)/2)+arb(0,ar((hi-lo)/2).upper())
    pi=ball(PI)
    b=900; m=44
    logs=[arb(0)]+[arb(n).log() for n in range(1,b+1)]
    bern=[Q(1)]
    for n in range(1,2*m+1):
        bern.append(-sum((bern[k]/factorial(n+1-k) for k in range(n)),Q(0)))
    assert bern[2]==Q(1,12) and bern[4]==Q(-1,720)
    rows=[]
    for t in ts:
        limit(); tt=ar(t); s=acb(ar(Q(1,2)),tt)
        v=sum((-s*logs[n]).exp() for n in range(1,b))
        bp=(-s*logs[b]).exp(); v+=bp*(b/(s-1)+ar(Q(1,2)))
        rising=acb(1); normprod=arb(1)
        for j in range(2*m):
            rising*=s+j
            normprod*=((ar(Q(1,2)+j))**2+tt*tt).sqrt()
            if j%2==0:
                k=(j+2)//2
                v+=bp*rising*ar(bern[2*k])*ar(Q(b)**(1-2*k))
        ez=4*normprod*((ar(Q(1,2))-2*m)*logs[b]).exp()/(6**(2*m)*ar(Q(2*m)-Q(1,2)))
        er=arb(0,ez.upper()); v+=acb(er,er)
        theta=tt*(tt.log()-arb(2).log()-pi.log()-1)/2-pi/8+1/(48*tt)
        proxy=theta.cos()*v.real-theta.sin()*v.imag
        delta=Q(13,50)/t**2
        cosine=ball((1-delta**2/2,Q(1)))
        actual=proxy/cosine
        rows.append({"t":str(t),"B":b,"M":m,"bits":ctx.prec,
                     "EM_error":enc(ez),"theta_hat_proxy":enc(proxy),
                     "phase_cosine":enc(cosine),"hardyZ":enc(actual)})
    return rows


def run():
    producer=HERE.parent/'prime-estimates'
    pins={
        'PRINCIPAL_K0_POINT_CERTIFICATES_2026-11-11.md':'309A465F31597E8B57C45D83F364E5132D3E96AE6490469C14E7013AB2398F9E',
        'principal_k0_point_certificates_20261111.py':'9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22',
        'principal_k0_point_certificates_20261111.json':'4FF92EBCE1BF9416215CEDB57680ABD2971441440FC0D052B6FC23BF48807385',
    }
    for name,pin in pins.items():
        assert hashlib.sha256((producer/name).read_bytes()).hexdigest().upper()==pin
    source=json.loads((producer/'principal_k0_point_certificates_20261111.json').read_text())
    expected=list(map(Q,['1500','2000','1659.153620177110','1608.495438637974','1608.495438637975']))
    assert len(source['points'])==5
    assert list(map(lambda r:Q(r['t']),source['points']))==expected
    counts={"interval_containments":0,"exact_ledger_checks":0}
    def contains(outer,inner):
        lo,hi=map(Q,outer); a,b=map(Q,inner)
        assert lo<=a<=b<=hi,(outer,inner)
        counts['interval_containments']+=1
    contains(source['pi'],PI); contains(source['log2'],LOG2)
    independent=[]
    for src,t in zip(source['points'],expected):
        own=evaluate(t); n=own['N']; assert src['N']==n and len(src['terms'])==n
        pi0,pi1=map(Q,source['pi'])
        assert 2*pi1*n*n<t<2*pi0*(n+1)**2
        for key in ('a','z','theta_hat','sqrt_a','correction','Khat'):
            contains(src[key],own[key])
        source_f=src['coefficient']
        for key in ('w','A','B','F'): contains(source_f[key],own[key])
        contains(source_f['sinc_A']['output'],own['sinc_numerator'])
        contains(source_f['sinc_B']['output'],own['sinc_denominator'])
        contains(src['theta_log_argument'],div((t,t),scale(2,PI)))
        contains(src['theta_log'],log_box(div((t,t),scale(2,PI))))
        theta=tuple(map(Q,own['theta_hat']))
        for j,term in enumerate(src['terms'],1):
            assert term['n']==j
            ln=log_point(Q(j)); rt=sqrt_integer(j)
            contains(term['log_n'],ln); contains(term['sqrt_n'],rt)
            arg=sub(theta,scale(t,ln)); contains(term['argument'],arg)
            cw=term['cosine']; k=cw['period_integer']
            contains(cw['reduced'],sub(arg,scale(2*k,PI)))
            lo,hi=map(Q,cw['reduced'])
            assert -4<=lo<=hi<=4
            assert Q(cw['midpoint'])==(lo+hi)/2
            assert Q(cw['input_radius'])==(hi-lo)/2
            assert Q(cw['tail'])==Q(2*4**48,factorial(48))
            contains(cw['output'],cos_box(arg)); contains(term['term'],own['terms'][j-1])
            counts['exact_ledger_checks']+=4
        for key,argument in [('sinc_A','A'),('sinc_B','B')]:
            r=source_f[key]; lo,hi=map(Q,source_f[argument])
            assert Q(r['midpoint'])==(lo+hi)/2 and Q(r['input_radius'])==(hi-lo)/2
            assert Q(r['tail'])==Q(2*2**32,factorial(33))
            counts['exact_ledger_checks']+=3
        lo,hi=map(Q,src['Khat']); mid=Q(src['midpoint']); rad=Q(src['arithmetic_radius'])
        assert mid==(lo+hi)/2 and rad==(hi-lo)/2
        eta=Q(src['arithmetic_budget']); assert eta==Q(19,1000)/t
        assert 0<=rad<=eta and rad**4*t**3<=Q(19,1000)**4
        rr=Q(src['HardyZ_radius']); assert rr>0 and rr**4*t**3>=Q(47,100)**4
        assert list(map(Q,src['HardyZ']))==[mid-rr,mid+rr]
        power0,power1=map(Q,src['t_three_quarters'])
        assert 0<power0<=power1 and power0**4<=t**3<=power1**4
        counts['exact_ledger_checks']+=8
        independent.append(own)
    em=explicit_em(expected)
    for src,own,external,sign in zip(source['points'],independent,em,[1,1,1,-1,-1]):
        contains(src['HardyZ'],external['hardyZ'])
        contains(own['hardyZ'],external['hardyZ'])
        for interval in [src['HardyZ'],own['hardyZ'],external['hardyZ']]:
            lo,hi=map(Q,interval)
            assert (lo>0 if sign>0 else hi<0)
            counts['exact_ledger_checks']+=1
    limit()
    result={"status":"PASS_ALL_FIVE_COMPLETE_INDEPENDENT_K0_AND_EM_CHECKS",
            "scope":"External interval evidence plus exact arithmetic checks, not Lean or zero counts.",
            "producer_sha256":pins,"parameters":{"bits":BITS,"Machin":[40,16],
            "log_terms":64,"cos_degree":80,"sinc_terms":32,"EM_B":900,"EM_M":44,"EM_bits":224},
            "checks":counts,"points":independent,"explicit_EM":em,
            "elapsed_seconds":time.monotonic()-START,
            "script_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
    out=Path(__file__).with_suffix('.json')
    out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({"status":result['status'],"checks":counts,
                      "elapsed_seconds":result['elapsed_seconds'],
                      "script_sha256":result['script_sha256'],
                      "receipt_sha256":hashlib.sha256(out.read_bytes()).hexdigest().upper()}))


if __name__=='__main__': run()
