"""Four explicit modular-theta kernel points with derivative jets.

Arb is used only for elementary interval operations. No theta/zeta/Gamma
oracle. Reduced and direct Gaussian series have explicit omitted-tail bounds.
"""
from flint import arb,acb,ctx
from fractions import Fraction as Q
from math import isqrt
from pathlib import Path
from hashlib import sha256
from time import monotonic,process_time
import json

ctx.prec=256
OUTBITS=128
SCALE=2**OUTBITS
NRED=20
START=monotonic();CPU=process_time()
HERE=Path(__file__).parent
PLAN=HERE.parent/'integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md'
PLAN_SHA='C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D'
assert sha256(PLAN.read_bytes()).hexdigest().upper()==PLAN_SHA
PI=arb.pi();I=acb(0,1)


def tick():
    if monotonic()-START>550: raise RuntimeError('Bounded modular pilot timeout')


def ar(x):
    x=Q(x);return arb(x.numerator)/arb(x.denominator)


def endints(x):
    assert x.is_finite()
    lo=(x.lower()*SCALE).floor().unique_fmpz()
    hi=(x.upper()*SCALE).ceil().unique_fmpz()
    assert lo is not None and hi is not None
    # Always outward, including exponentially tiny values. Avoid converting
    # exact tiny endpoints to rational strings with enormous denominators.
    assert ar(Q(int(lo),SCALE))<=x.lower()
    assert x.upper()<=ar(Q(int(hi),SCALE))
    return int(lo),int(hi)


def rb(x):
    lo,hi=endints(x)
    return [f'{lo}/{SCALE}',f'{hi}/{SCALE}']


def binary(x):
    out=[]
    for endpoint in (x.lower(),x.upper()):
        m,e=endpoint.man_exp()
        out.append({'mantissa':str(m),'exponent':int(e)})
    return out


def cb(z):
    return {'re':rb(z.real),'im':rb(z.imag),
            'binary_re':binary(z.real),'binary_im':binary(z.imag)}
def jetsnap(jets):return [[cb(z) for z in jet] for jet in jets]


def error_add(z,e):
    er=arb(0,e.upper());return z+acb(er,er)


def root_factor(tau):
    z=-I*tau
    assert z.real>0
    norm=(z.real*z.real+z.imag*z.imag).sqrt()
    u=((norm+z.real)/2).sqrt();assert u>0
    v=z.imag/(2*u)
    root=acb(u,v);a=1/root
    return a,{'z':cb(z),'norm':rb(norm),'u':rb(u),'v':rb(v),
              'binary_norm':binary(norm),'binary_u':binary(u),'binary_v':binary(v),
              'root':cb(root),'A':cb(a)}


def phase8(n):
    h=1/arb(2).sqrt()
    return [acb(1),acb(h,h),acb(0,1),acb(-h,h),acb(-1),
            acb(-h,-h),acb(0,-1),acb(h,-h)][n%8]


def reduction(tau):
    steps=[];current=tau;inversions=0
    while True:
        tick()
        # This is only a proposal; the strict interval test certifies it.
        n=round(float(current.real.mid()))
        z=current-n
        assert abs(z.real)<ar(Q(3,5)) and z.imag>0
        steps.append({'kind':'T','n':n,'input':cb(current),'output':cb(z),
                      'phase8':cb(phase8(n))})
        if z.imag>ar(Q(2,5)):
            return z,steps,inversions
        assert z.imag<ar(Q(1,2))
        nxt=-1/z
        a,aw=root_factor(z)
        steps.append({'kind':'S','input':cb(z),'output':cb(nxt),'root_witness':aw,
                      '_tau':z,'_A':a})
        assert nxt.imag>ar(Q(100,61))*z.imag
        inversions+=1;assert inversions<=35
        current=nxt


def tail(alpha,u,j):
    alpha=ar(alpha);u=ar(u)
    moment=arb(1) if j==0 else (2*j/alpha)**j
    den=1-(-alpha*(2*u+1)/2).exp();assert den>0
    return 2*(4**j)*moment*(-alpha*u*u/2).exp()/den


def reduced_jets(tau):
    assert tau.imag>ar(Q(2,5))
    values=[[acb(0) for _ in range(3)] for _ in range(3)]
    # type order: theta2, theta3, theta4.
    terms=[]
    for n in range(NRED+1):
        if n==0:
            values[1][0]+=1;values[2][0]+=1
        else:
            h=PI*I*n*n;v=(h*tau).exp()
            term=[2*v*h**j for j in range(3)]
            for j in range(3):values[1][j]+=term[j];values[2][j]+=((-1)**n)*term[j]
            terms.append({'integer_n':n,'jet_term':[cb(x) for x in term]})
        if n<NRED:
            x=ar(Q(2*n+1,2));h=PI*I*x*x;v=(h*tau).exp()
            term=[2*v*h**j for j in range(3)]
            for j in range(3):values[0][j]+=term[j]
            terms.append({'half_index':n,'jet_term':[cb(x) for x in term]})
    tails=[tail(Q(6,5),Q(2*NRED+1,2),j) for j in range(3)]
    finite=jetsnap(values)
    for typ in range(3):
        for j in range(3):values[typ][j]=error_add(values[typ][j],tails[j])
    return values,{'terms':terms,'finite_jets':finite,'tail_bounds':[rb(e) for e in tails],
                   'binary_tail_bounds':[binary(e) for e in tails],
                   'enclosed_jets':jetsnap(values)}


def unwind(jets,steps):
    values=jets;trace=[]
    for step in reversed(steps):
        if step['kind']=='T':
            n=step['n'];p=phase8(n)
            values=[[p*z for z in values[0]],values[1 if n%2==0 else 2],values[2 if n%2==0 else 1]]
        else:
            tau=step['_tau'];A=step['_A'];out=[]
            for idx in (2,1,0):
                g,g1,g2=values[idx]
                out.append([A*g,A*(-g/(2*tau)+g1/tau**2),
                            A*(3*g/(4*tau**2)-3*g1/tau**3+g2/tau**4)])
            values=out
        trace.append({'kind':step['kind'],'jets':jetsnap(values)})
    return values,trace


def direct(tau,w):
    yl,_=endints(tau.imag);alpha=Q(3*yl,SCALE);assert alpha>0
    x=Q(400)/alpha
    n=isqrt((x.numerator+x.denominator-1)//x.denominator)+1
    assert alpha*n*n>=400
    if n>100000:return None,{'status':'not attempted','reason':'explicit 100000-term cap','required_N':n}
    # Evaluate each exponential directly. Repeated rectangular rotations can
    # suffer interval wrapping even though the exact Gaussian terms decay.
    exponent=PI*I*tau
    moments=[acb(0),acb(0),acb(0)]
    for k in range(1,n+1):
        if k%256==0:tick()
        term=(exponent*(k*k)).exp()
        moments[0]+=term;moments[1]+=k*k*term;moments[2]+=k**4*term
    jets=[1+2*moments[0],2*PI*I*moments[1],-2*PI**2*moments[2]]
    tails=[tail(alpha,Q(n+1),j) for j in range(3)]
    for j in range(3):jets[j]=error_add(jets[j],tails[j])
    p=(w/2).exp()*(6*tau*jets[1]+4*tau*tau*jets[2])
    # A second algebraic expression uses raw differentiated-kernel moments.
    raw=8*PI**2*(9*w/2).exp()*moments[2]-12*PI*(5*w/2).exp()*moments[1]
    rawtail=abs((w/2).exp())*(6*abs(tau)*tails[1]+4*abs(tau)**2*tails[2])
    raw=error_add(raw,rawtail)
    assert p.overlaps(raw)
    return (jets,p),{'status':'completed','N':n,'alpha':str(alpha),'jet_tails':[rb(e) for e in tails],
                    'binary_jet_tails':[binary(e) for e in tails],
                    'jets':[cb(z) for z in jets],'P':cb(p),'raw_kernel_P':cb(raw)}


def run_point(T,r):
    start=monotonic();eta=ar(Q(1,T+1));b=PI/4-eta;w=acb(ar(r),b)
    er=(2*ar(r)).exp()
    tau=acb(-er*(2*eta).cos(),er*(2*eta).sin())
    assert tau.imag>=eta
    reduced,steps,count=reduction(tau)
    vals,rw=reduced_jets(reduced)
    original,trace=unwind(vals,steps)
    j3=original[1]
    p=(w/2).exp()*(6*tau*j3[1]+4*tau*tau*j3[2])
    independent,dw=direct(tau,w)
    if independent is not None:
        jd,pd=independent
        assert all(a.overlaps(b) for a,b in zip(j3,jd)) and p.overlaps(pd)
    clean=[{k:v for k,v in step.items() if not k.startswith('_')} for step in steps]
    # Verify the serialized rational decisions too, after outward coarsening.
    for step in clean:
        if step['kind']=='T':
            lo,hi=map(Q,step['output']['re']);assert -Q(3,5)<lo<=hi<Q(3,5)
        else:
            lo,hi=map(Q,step['input']['im']);assert 0<lo<=hi<Q(1,2)
    lo,hi=map(Q,cb(reduced)['im']);assert lo>Q(2,5)
    pbox=cb(p)
    assert max(Q(pbox[k][1])-Q(pbox[k][0]) for k in ('re','im'))<Q(1,10**8)
    return {'T':T,'r':str(r),'eta':f'1/{T+1}','w':cb(w),'initial_tau':cb(tau),
            'steps':clean,'inversions':count,'reduced_tau':cb(reduced),
            'reduced_series':rw,'unwind_trace':trace,'original_jets':jetsnap(original),
            'P':pbox,'direct':dw,'elapsed_seconds':monotonic()-start}


def run():
    rows=[]
    for T in (1000000,60343058):
        for r in (Q(0),Q(1,8)):
            row=run_point(T,r);rows.append(row)
            print(json.dumps({'completed_T':T,'r':str(r),'S_steps':row['inversions'],
                              'direct_status':row['direct']['status'],
                              'direct_N':row['direct'].get('N'),'seconds':row['elapsed_seconds']}),flush=True)
    return {'status':'PASS bounded modular theta kernel pilot','plan_sha256':PLAN_SHA,
            'precision_bits':ctx.prec,'output_dyadic_bits':OUTBITS,'reduced_cutoff':NRED,
            'pi':rb(PI),'binary_pi':binary(PI),'points':rows,'resources':{'wall_seconds':monotonic()-START,'cpu_seconds':process_time()-CPU},
            'scope':'Coefficient evaluation only; no xi integration, FFT, contour, zero or spectral claim'}


if __name__=='__main__':
    result=run();out=HERE/'principal_theta_modular_pilot_20261111.json'
    out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':result['status'],'resources':result['resources'],'output':str(out)}))
