"""Ten explicit Gabcke K0 point enclosures, with a separate direct EM reference.

Only elementary Arb operations are used. No zeta, RS, Gamma or zero helper.
This is external interval evidence under the audited paper theorem, not Lean.
"""
import argparse, hashlib, json, time
from pathlib import Path
from fractions import Fraction as Q
from math import comb, factorial
from flint import arb, acb, ctx

ctx.prec = 160
BASE = Path(__file__).parent
PDF = BASE/'gabcke_1979_corrected_2015.pdf'
PDF_SHA = 'a28ae7be557f75997d1f9c48c9517247581f55ab89477181127f83e3dffbbe53'
OUT = Path(__file__).with_suffix('.json')

def ar(q):
    q=Q(q)
    return arb(str(q.numerator))/q.denominator
def rb(v): return [str(v.lower().fmpq()), str(v.upper().fmpq())]
def error_ball(e): return arb(0,e.upper())
def integer_floor(v):
    lo,hi=map(Q,rb(v))
    a,b=lo.numerator//lo.denominator,hi.numerator//hi.denominator
    if a!=b: raise RuntimeError('floor not uniquely certified')
    return a
def sign(v): return 1 if v>0 else -1 if v<0 else 0

def sinc(v,L=24):
    """Entire sine/x power series, with geometric absolute tail."""
    r=abs(v)
    assert r<1
    ans=arb(1); term=arb(1)
    for n in range(1,L+1):
        term*=-(v*v)/((2*n)*(2*n+1))
        ans+=term
    ratio=r*r/((2*L+4)*(2*L+5))
    tail=r**(2*L+2)/factorial(2*L+3)/(1-ratio)
    assert ratio<1
    return ans+error_ball(tail),tail

def correction_F(p,pi):
    # F is even. The selected local chart keeps the denominator sinc bounded.
    q=-p if p<0 else p
    u=q-ar(Q(1,2))
    if abs(u)<=ar(Q(1,4)):
        numerator,en=sinc(pi*u*(1+u)/2)
        denominator,ed=sinc(pi*u)
        assert denominator>ar(Q(7,8))
        return (1+u)*numerator/(2*denominator),'sinc',rb(en+ed)
    denominator=(pi*p).cos()
    assert not denominator.contains(0)
    return (pi*(p*p+ar(Q(3,4)))/2).cos()/denominator,'quotient',None

def gabcke(t,pi,logs):
    v=ar(t);a=(v/(2*pi)).sqrt();N=integer_floor(a)
    p=1-2*(a-N)
    theta0=v/2*((v/(2*pi)).log()-1)-pi/8
    theta=theta0+1/(48*v)+7/(5760*v**3)+31/(80640*v**5)
    main=arb(0)
    for n in range(1,N+1):
        main+=(theta-v*logs[n]).cos()/arb(n).sqrt()
    f,branch,tail=correction_F(p,pi)
    value=2*main+((-1)**(N-1))*f/a.sqrt()
    analytic=ar(Q(47,100))/(v.sqrt()*v.sqrt().sqrt())
    phase=ar(80)/(3322*v**7)
    value+=error_ball(analytic+phase)
    return value,dict(N=N,p=rb(p),correction_branch=branch,
        sinc_tail_sum=tail,analytic_R0_error=rb(analytic),phase_error=rb(phase))

def em_reference(t,pi,logs,check_budget):
    """Direct zeta EM, N=ceil(t/2)+17, M28; proxy divided by cos(phase gap).

    Unlike the Gabcke expression this computes no Riemann-Siegel correction.
    Unlike frozen head/top evaluators it directly uses zeta, not pole-canceled g.
    """
    M=28;N=-((-t.numerator)//(2*t.denominator))+17;B=N+1
    s=acb(ar(Q(1,2)),ar(t));v=acb(0)
    for n in range(1,N+1):
        v+=(-s*logs[n]).exp()
        if n%4096==0: check_budget()
    lb=logs[B];bp=(-s*lb).exp()
    v+=bp*B/(s-1)+bp/2
    bern=[Q(1)]
    for n in range(1,2*M+1):
        bern.append(-sum(Q(comb(n+1,k))*bern[k] for k in range(n))/Q(n+1))
    poch=acb(1)
    for j in range(1,2*M+1):
        poch*=s+j-1
        if j%2==1:
            k=(j+1)//2
            v+=bp*poch*ar(bern[2*k]/factorial(2*k))*ar(Q(B)**(1-2*k))
    sigma=ar(Q(1,2))
    err=4*abs(poch)*((1-sigma-2*M)*lb).exp()/(6**(2*M)*(sigma+2*M-1))
    ee=error_ball(err);v+=acb(ee,ee)
    tt=ar(t)
    theta0=tt/2*((tt/(2*pi)).log()-1)-pi/8
    proxy=(acb(0,theta0).exp()*v).real
    # Exact Hardy Z = proxy/cos(theta-theta0). No numerical Gamma needed.
    gap=1/(48*tt)+7/(5760*tt**3)+31/(80640*tt**5)
    gap+=error_ball(1/(3322*tt**7))
    denom=gap.cos();assert denom>ar(Q(999,1000))
    return proxy/denom,dict(N=N,M=M,EM_error_zeta=rb(err))

def point_list(pi):
    points=[('lower_endpoint',Q(1500)),('low_interior',Q(12001,8)),
        ('interior_10000',Q(10000)),('interior_100000',Q(100000)),
        ('interior_500000',Q(500000)),('top_endpoint',Q(1000000))]
    D=2**20
    for label,offset in [('near_p_plus_half',Q(1,4)),('near_p_minus_half',Q(3,4))]:
        target=2*pi*ar(100+offset)**2
        n=integer_floor(target*D)
        points.append((label,Q(n,D)))
    transition=2*pi*200**2
    n=integer_floor(transition*D)
    points.extend([('below_N_transition',Q(n,D)),('above_N_transition',Q(n+1,D))])
    assert len(points)==10 and len(set(t for _,t in points))==10
    return points

def run(budget):
    start=time.perf_counter()
    def check_budget():
        if time.perf_counter()-start>budget:raise RuntimeError('bounded time budget exhausted')
    assert hashlib.sha256(PDF.read_bytes()).hexdigest()==PDF_SHA
    pi=arb.pi();points=point_list(pi);rows=[]
    result=dict(status='INCOMPLETE',precision_bits=ctx.prec,budget_seconds=budget,
        paper_sha256=PDF_SHA,script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        theorem='Gabcke3.26,3.2.2(a)K0,4.2.3(d); external paper-level assumptions, not Lean',
        rows=rows)
    try:
        maxN=max(-((-t.numerator)//(2*t.denominator))+18 for _,t in points)
        logs=[arb(0)]
        for n in range(1,maxN+1):
            logs.append(arb(n).log())
            if n%4096==0:check_budget()
        result['log_init_seconds']=time.perf_counter()-start
        for label,t in points:
            check_budget();ts=time.perf_counter()
            g,gm=gabcke(t,pi,logs);tg=time.perf_counter()
            e,em=em_reference(t,pi,logs,check_budget);te=time.perf_counter()
            row=dict(label=label,t=str(t),gabcke=rb(g),reference=rb(e),
                gabcke_sign=sign(g),reference_sign=sign(e),overlap=g.overlaps(e),
                gabcke_contains_reference=g.contains(e),gabcke_seconds=tg-ts,
                reference_seconds=te-tg,gabcke_metadata=gm,reference_metadata=em)
            if label=='near_p_plus_half':assert abs(ar(Q(gm['p'][0]))-ar(Q(1,2)))<ar(Q(1,10**8)) and gm['correction_branch']=='sinc'
            if label=='near_p_minus_half':assert abs(ar(Q(gm['p'][0]))+ar(Q(1,2)))<ar(Q(1,10**8)) and gm['correction_branch']=='sinc'
            if label=='below_N_transition':assert gm['N']==199
            if label=='above_N_transition':assert gm['N']==200
            rows.append(row)
            print(json.dumps({k:row[k] for k in ('label','t','gabcke_sign','reference_sign','overlap','gabcke_contains_reference','gabcke_seconds','reference_seconds')}),flush=True)
        assert len(rows)==10
        result['status']='PASS_BOUNDED_POINT_ENCLOSURES' if all(r['overlap'] for r in rows) else 'FAIL_DISJOINT_ENCLOSURES'
        result['inconclusive_gabcke_signs']=sum(r['gabcke_sign']==0 for r in rows)
        result['scope']='Ten isolated points only; no zero count or strip/completeness conclusion.'
    except Exception as exc:
        result['reason']=type(exc).__name__+': '+str(exc)
    result['elapsed_seconds']=time.perf_counter()-start
    OUT.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='rows'},indent=2),flush=True)
    return 0 if result['status']=='PASS_BOUNDED_POINT_ENCLOSURES' else 2

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--budget',type=float,default=120)
    args=parser.parse_args();assert 0<args.budget<=120
    raise SystemExit(run(args.budget))
