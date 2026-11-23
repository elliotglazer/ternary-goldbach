"""One modular-node Fourier Taylor disk; external elementary intervals only.

Reuses the frozen four-point theta helper, never a special-function oracle.
Integer centers have common denominator 2**128; products are summed exactly.
"""
from pathlib import Path
from fractions import Fraction as Q
from hashlib import sha256
from math import factorial
from time import monotonic,process_time
import importlib.util,json
from flint import arb,acb,ctx

HERE=Path(__file__).parent
HELPER=HERE/'principal_theta_modular_pilot_20261111.py'
HELPER_SHA='EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14'
assert sha256(HELPER.read_bytes()).hexdigest().upper()==HELPER_SHA
COMPOSITION=HERE.parent/'integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md'
COMPOSITION_SHA='5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571'
REVIEW=HERE.parent/'major-constants/REVIEW_PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md'
REVIEW_SHA='FB75E5919ECFD5F7800290C64DD1C0DFFCA7EA4FDFAE4B5FB4BFBBF4B3B27DAD'
assert sha256(COMPOSITION.read_bytes()).hexdigest().upper()==COMPOSITION_SHA
assert sha256(REVIEW.read_bytes()).hexdigest().upper()==REVIEW_SHA
spec=importlib.util.spec_from_file_location('frozen_theta_helper',HELPER)
H=importlib.util.module_from_spec(spec);spec.loader.exec_module(H)
ctx.prec=256
START=monotonic();CPU=process_time();S=2**128
K=2048;h=Q(1,512);V=Q(4);rho=Q(1,64);DEG=12
eta=Q(1,33);r=kappa=Q(1,66);T=Q(32);sigma=Q(3,5);t=Q(14)
ar=H.ar;PI=H.PI;I=acb(0,1);b=PI/4-ar(eta)

def guard():
    if monotonic()-START>240:raise RuntimeError('240-second computation guard')

def center(z):
    # L1 radius bounds the Euclidean complex error, entirely rational.
    a,c=H.endints(z.real);d,f=H.endints(z.imag)
    x=(a+c)//2;y=(d+f)//2
    e=max(x-a,c-x)+max(y-d,f-y)
    assert e>=0
    return x,y,e

def upper(x):
    assert x>=0
    return Q(H.endints(x)[1],S)

def pack(c):return [str(x) for x in c]

def evaluate_node(k):
    v=ar(k*h);w=acb(v,b);er=(2*v).exp()
    tau=acb(-er*(2*ar(eta)).cos(),er*(2*ar(eta)).sin())
    reduced,steps,inversions=H.reduction(tau)
    jets,_=H.reduced_jets(reduced)
    jets,_=H.unwind(jets,steps)
    g,g1,g2=jets[1]
    p=(w/2).exp()*(6*tau*g1+4*tau*tau*g2)
    word=[['T',s['n']] if s['kind']=='T' else ['S'] for s in steps]
    return p,word,inversions

def run():
    assert b>0 and b+ar(r)<PI/4
    assert ar(kappa)<(2*(b+ar(r))).cos()
    assert Q(4968,10000)<=sigma<=2 and abs(t)<=T
    C=3*kappa;q=C/2;z0=3*C/2
    A=(2048/C**2+96/C)*(1+z0)/z0
    M=A/q;D=A*(1/q+1/q**2)
    R=(2*ar(V)).exp();assert ar(q)*R>=2
    den=(2*PI*ar(r/h)).exp()-1;assert den>0
    qerr=[upper(2*ar(M)*(ar(T*r)).exp()/den)]
    qerr += [upper(2*ar(D)*ar((T+1)*r).exp()/den)]*DEG
    serr=[upper(ar(A/q)*(-ar(q)*R).exp())]
    serr += [upper(ar(A)*(-ar(q)*R).exp()*(R/ar(q)+ar(1/q**2)))]*DEG
    accum=[[0,0] for _ in range(DEG+1)]
    weight_error=[0]*(DEG+1);node_error=[arb(0) for _ in range(DEG+1)]
    rows=[];ninversions=0
    for k in range(K+1):
        guard();p,word,ninv=evaluate_node(k);ninversions+=ninv
        pc=center(p);wr=[]
        for sign in ([1] if k==0 else [1,-1]):
            v=sign*k*h;px,py,pe=pc
            if sign<0:py=-py
            expv=(acb(ar(sigma-Q(1,2)),ar(t))*ar(v)).exp()
            normexp=(ar((sigma-Q(1,2))*v)).exp()
            weights=[]
            for j in range(DEG+1):
                fac=h*v**j/factorial(j)
                wc=center(ar(fac)*expv);wx,wy,we=wc
                accum[j][0]+=wx*px-wy*py;accum[j][1]+=wx*py+wy*px
                weight_error[j]+=we*(abs(px)+abs(py))
                node_error[j]+=ar(h*Q(pe,S)*abs(v)**j/factorial(j))*normexp
                weights.append(pack(wc))
            wr.append({'sign':sign,'weights':weights})
        rows.append({'k':k,'word':word,'P':H.cb(p),'center_radius':pack(pc),'signed_weights':wr})
        if k%256==0:print(json.dumps({'completed_node':k,'of':K,'seconds':monotonic()-START}),flush=True)
    coeff=[]
    for j in range(DEG+1):
        ne=upper(node_error[j]);we=Q(weight_error[j],S*S)
        total=qerr[j]+serr[j]+ne+we
        coeff.append({'j':j,'center_numerators':pack(accum[j]),'center_denominator':str(S*S),
                      'Q':str(qerr[j]),'S':str(serr[j]),'node_error':str(ne),
                      'weight_error':str(we),'summation_error':'0','total_error':str(total)})
    remainder=D*rho**(DEG+1)/(1-rho)
    errors=sum(Q(c['total_error'])*rho**c['j'] for c in coeff)+remainder
    variation=arb(0)
    for j in range(1,DEG+1):
        z=acb(ar(Q(accum[j][0],S*S)),ar(Q(accum[j][1],S*S)))
        variation+=abs(z)*ar(rho**j)
    variation_upper=upper(variation)
    zcenter=acb(ar(Q(accum[0][0],S*S)),ar(Q(accum[0][1],S*S)))
    abscenter=abs(zcenter);lower=Q(H.endints(abscenter)[0],S)
    disk_radius=errors+variation_upper
    margin=lower-disk_radius
    return {'status':'completed one bounded Taylor disk','helper_sha256':HELPER_SHA,
            'composition_sha256':COMPOSITION_SHA,'composition_review_sha256':REVIEW_SHA,
            'precision_bits':256,'center_scale':str(S),'degree':DEG,
            'parameters':{k:str(v) for k,v in {'T':T,'sigma':sigma,'t':t,'eta':eta,'r':r,'kappa':kappa,'h':h,'K':K,'V':V,'rho':rho}.items()},
            'constants':{k:str(v) for k,v in {'C':C,'q':q,'z0':z0,'A':A,'M':M,'D':D}.items()},
            'pi':H.rb(PI),'b':H.rb(b),'q_exp_2V':H.rb(ar(q)*R),'denominator':H.rb(den),
            'nodes':rows,'total_inversions':ninversions,'coefficients':coeff,
            'disk':{'remainder':str(remainder),'coefficient_error_plus_remainder':str(errors),
                    'polynomial_variation_upper':str(variation_upper),'center_abs_lower':str(lower),
                    'total_radius_about_constant':str(disk_radius),'nonvanishing_margin':str(margin),
                    'nonvanishing':margin>0},
            'resources':{'wall_seconds':monotonic()-START,'cpu_seconds':process_time()-CPU},
            'scope':'One closed disk, external elementary interval arithmetic; no Lean, scan, FFT or zero count'}

if __name__=='__main__':
    data=run();path=HERE/'principal_modular_xi_panel_pilot_20261111.json'
    path.write_text(json.dumps(data,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':data['status'],'disk_nonvanishing':data['disk']['nonvanishing'],
                      'resources':data['resources'],'output':str(path)}),flush=True)
