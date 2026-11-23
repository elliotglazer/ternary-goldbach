"""Bounded c=40,120 unit-group transform with explicit rational EM boxes.

No L/zeta/Gamma/RS oracle. Reuses the pinned exact rational elementary helpers
from the preceding five-point pilot; all source-specific formulas are here.
"""
from fractions import Fraction as Q
from itertools import product
from math import factorial, comb, gcd
from hashlib import sha256
from pathlib import Path
import importlib.util
import json
from time import monotonic, process_time

HERE=Path(__file__).parent
HELPER=HERE/'principal_k0_point_certificates_20261111.py'
HELPER_SHA='9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22'
assert sha256(HELPER.read_bytes()).hexdigest().upper()==HELPER_SHA
spec=importlib.util.spec_from_file_location('pinned_elementary',HELPER)
E=importlib.util.module_from_spec(spec)
spec.loader.exec_module(E)
START=monotonic()
CPU=process_time()
CUTOFF=64
ORDER=12
ZERO=(E.pt(0),E.pt(0))


def tick():
    if monotonic()-START>570:
        raise RuntimeError('Bounded pilot stopped before ten minutes')


def cp(x,y=0): return E.pt(x),E.pt(y)
def ca(z,w): return E.add(z[0],w[0]),E.add(z[1],w[1])
def cn(z): return E.neg(z[0]),E.neg(z[1])
def cs(z,w): return ca(z,cn(w))
def cr(q,z): return E.scale(q,z[0]),E.scale(q,z[1])
def cm(z,w):
    return E.sub(E.mul(z[0],w[0]),E.mul(z[1],w[1])),E.add(E.mul(z[0],w[1]),E.mul(z[1],w[0]))


def phase(k,z):
    k%=4
    return (z,(E.neg(z[1]),z[0]),cn(z),(z[1],E.neg(z[0])))[k]


def exact_add(z,w): return z[0]+w[0],z[1]+w[1]
def exact_mul(z,w): return z[0]*w[0]-z[1]*w[1],z[0]*w[1]+z[1]*w[0]


def trig(x):
    center=(x[0]+x[1])/2
    k=E.floorq(center/(E.PI[0]+E.PI[1])+Q(1,2))
    y=E.sub(x,E.scale(2*k,E.PI))
    assert -4<=y[0]<=y[1]<=4
    c,r=(y[0]+y[1])/2,(y[1]-y[0])/2
    co=sum(((-1)**j*c**(2*j)/factorial(2*j) for j in range(24)),Q(0))
    si=sum(((-1)**j*c**(2*j+1)/factorial(2*j+1) for j in range(24)),Q(0))
    err=E.COS_TAIL+r
    return E.rounded((co-err,co+err)),E.rounded((si-err,si+err))


def power_base(x,sample):
    # Exact positive-base x^(-s); s is 1 or 1/2+10i.
    if sample=='one': return cp(1/x)
    logr=E.log_point(x)
    unit=trig(E.scale(-10,logr))
    amp=E.div(E.pt(1),E.sqrt_point(x))
    return E.mul(amp,unit[0]),E.mul(amp,unit[1])


BERNOULLI=[Q(1)]
for n in range(1,2*ORDER+1):
    BERNOULLI.append(-sum((comb(n+1,k)*BERNOULLI[k] for k in range(n)),Q(0))/Q(n+1))
for n in range(1,2*ORDER+1):
    assert sum((comb(n+1,k)*BERNOULLI[k] for k in range(n+1)),Q(0))==0


def em_error(sample):
    sigma,tt=(Q(1),Q(0)) if sample=='one' else (Q(1,2),Q(10))
    prod=Q(1)
    for j in range(2*ORDER): prod*=sigma+j+tt
    # B=N+q >=64; at sigma=1/2, sqrt(64)=8 exactly.
    bpower=Q(1,CUTOFF**(2*ORDER)) if sample=='one' else Q(8,CUTOFF**(2*ORDER))
    return 4*prod*bpower/(6**(2*ORDER)*(sigma+2*ORDER-1))


def hurwitz_deflated(q,sample):
    tick()
    B=q+CUTOFF
    head=ZERO
    for k in range(CUTOFF): head=ca(head,power_base(q+k,sample))
    bs=power_base(B,sample)
    half=cr(Q(1,2),bs)
    s=(Q(1),Q(0)) if sample=='one' else (Q(1,2),Q(10))
    rising=[(Q(1),Q(0))]
    for j in range(2*ORDER): rising.append(exact_mul(rising[-1],(s[0]+j,s[1])))
    corrections=[]
    total=ca(head,half)
    for r in range(1,ORDER+1):
        rr=rising[2*r-1]
        term=cr(BERNOULLI[2*r]/factorial(2*r)*B**(1-2*r),cm(cp(*rr),bs))
        corrections.append(term)
        total=ca(total,term)
    if sample=='one':
        # Limit of (B^(1-s)-1)/(s-1) at s=1.
        pole_difference=(E.neg(E.log_point(B)),E.pt(0))
    else:
        sm1=(s[0]-1,s[1]); norm=sm1[0]**2+sm1[1]**2
        inverse=cp(sm1[0]/norm,-sm1[1]/norm)
        pole_difference=cm(cs(cr(B,bs),cp(1)),inverse)
    total=ca(total,pole_difference)
    error=em_error(sample)
    result=ca(total,((Q(-error),Q(error)),(Q(-error),Q(error))))
    # At the real sample the exact function/remainder is real.
    if sample=='one': result=(result[0],E.pt(0))
    return result,{'q':q,'B':B,'head':head,'B_minus_s':bs,'half':half,
                   'corrections':corrections,'pole_difference':pole_difference,
                   'remainder_norm_bound':error,'deflated':result}


def configurations(c):
    dims=(2,2,4) if c==40 else (2,2,2,4)
    axes=list(product(*(range(m) for m in dims)))
    crt=(25,16) if c==40 else (105,40,96)
    moduli=(8,5) if c==40 else (8,3,5)
    assert all(e%q==1 and all(e%v==0 for v in moduli if v!=q) for e,q in zip(crt,moduli))
    residues=[]
    for x in axes:
        local=[((-1)**x[0]*5**x[1])%8]
        if c==120: local.append(pow(2,x[2],3))
        local.append(pow(2,x[-1],5))
        residues.append(sum(e*a for e,a in zip(crt,local))%c)
    assert residues[0]==1 and len(set(residues))==len(axes)
    assert set(residues)=={a for a in range(1,c) if gcd(a,c)==1}
    return dims,axes,residues,crt


def exponent(label,x,dims): return sum(r*v*(4//m) for r,v,m in zip(label,x,dims))%4


def primitive(label,c):
    return label[1]==1 and label[-1]!=0 and (c==40 or label[2]==1)


def direct_exp(a,label,c):
    # Independently decode local residues, not the tensor flattening map.
    lut8={1:(0,0),5:(0,1),7:(1,0),3:(1,1)}
    e,f=lut8[a%8]
    lut5={1:0,2:1,4:2,3:3}
    g=lut5[a%5]
    if c==40: return (2*label[0]*e+2*label[1]*f+label[2]*g)%4
    h={1:0,2:1}[a%3]
    return (2*label[0]*e+2*label[1]*f+2*label[2]*h+label[3]*g)%4


def tensor(data,axes,dims,sign=1):
    current=dict(zip(axes,data)); stages=[]
    for axis,m in enumerate(dims):
        nxt={}
        for key in axes:
            acc=ZERO
            for j in range(m):
                src=list(key); src[axis]=j
                acc=ca(acc,phase(sign*key[axis]*j*(4//m),current[tuple(src)]))
            nxt[key]=acc
        current=nxt
        stages.append([current[key] for key in axes])
    return [current[key] for key in axes],stages


def overlaps(a,b): return all(max(x[0],y[0])<=min(x[1],y[1]) for x,y in zip(a,b))


def pilot(c,sample):
    dims,axes,residues,crt=configurations(c)
    selected=[x for x in axes if primitive(x,c)]
    assert len(selected)==6
    roots=((1,0),(0,1),(-1,0),(0,-1))
    for label in axes:
        rsum=(0,0)
        for x,a in zip(axes,residues):
            assert exponent(label,x,dims)==direct_exp(a,label,c)
            rsum=exact_add(rsum,roots[exponent(label,x,dims)])
        assert rsum==((len(axes),0) if not any(label) else (0,0))
    H=[]; witnesses=[]
    for a in residues:
        value,wit=hurwitz_deflated(Q(a,c),sample)
        H.append(value); witnesses.append(wit)
    D=[ZERO]+[cs(h,H[0]) for h in H[1:]]
    outputs,stages=tensor(D,axes,dims)
    p=power_base(Q(c),sample)
    rawmap=dict(zip(residues,H)); rows=[]
    for label in selected:
        total=ZERO
        for a in range(1,c):
            if gcd(a,c)==1: total=ca(total,phase(direct_exp(a,label,c),rawmap[a]))
        direct=cm(p,total)
        transformed=cm(p,outputs[axes.index(label)])
        assert overlaps(direct,transformed)
        assert max(b-a for a,b in transformed)<Q(1,10**20)
        rows.append({'label':label,'index':axes.index(label),
                     'parity':(label[0]+sum(label[2:]))%2,
                     'inverse_label':tuple((-r)%m for r,m in zip(label,dims)),
                     'tensor_L':transformed,'direct_raw_deflated_L':direct})
    negative,_=tensor(D,axes,dims,-1)
    sign_rejected=[label for label in selected
                   if not overlaps(cm(p,negative[axes.index(label)]),
                                   rows[selected.index(label)]['direct_raw_deflated_L'])]
    assert sign_rejected
    # A wrong last-axis digit order remains a permutation but is not the CRT map.
    bad=residues[:]; bad[1],bad[2]=bad[2],bad[1]
    index_rejected=any(direct_exp(a,label,c)!=exponent(label,x,dims)
                       for label in axes for x,a in zip(axes,bad))
    assert index_rejected
    bad_label=list(selected[0]); bad_label[1]=0; bad_label=tuple(bad_label)
    assert not primitive(bad_label,c)
    bad_H=[D[residues.index(a)] for a in bad]
    bad_out,_=tensor(bad_H,axes,dims)
    bad_rows=[label for label in selected if not overlaps(cm(p,bad_out[axes.index(label)]),
                                                         rows[selected.index(label)]['direct_raw_deflated_L'])]
    assert bad_rows
    return {'c':c,'sample':sample,'s':(Q(1),Q(0)) if sample=='one' else (Q(1,2),Q(10)),
            'dimensions':dims,'crt_idempotents':crt,'coordinates':axes,'residues':residues,
            'coefficient_witnesses':witnesses,'centered_coefficients':D,
            'tensor_stages':stages,'all_centered_transform_outputs':outputs,
            'c_minus_s':p,'selected_rows':rows,
            'mutations':{'negative_sign_rejected_labels':sign_rejected,
                         'swapped_digits_rejected_by_exact_character_test':index_rejected,
                         'swapped_digits_disjoint_selected_labels':bad_rows,
                         'nonprimitive_label_rejected':bad_label},
            'principal_output_scope':'Centered row zero is retained as a transform output only; not a principal L value'}


def encode(x):
    if isinstance(x,Q): return f'{x.numerator}/{x.denominator}'
    if isinstance(x,dict): return {k:encode(v) for k,v in x.items()}
    if isinstance(x,(tuple,list)): return [encode(v) for v in x]
    return x


def run():
    runs=[]
    for c in (40,120):
        for s in ('one','half_plus_10i'):
            runs.append(pilot(c,s))
            print(json.dumps({'completed_modulus':c,'sample':s,'selected_rows':6}),flush=True)
    return {'status':'PASS external rational EM and exact-root tensor pilot',
            'helper_sha256':HELPER_SHA,'parameters':{'N':CUTOFF,'p':ORDER,'dyadic_bits':E.BITS,
                                                   'log_terms':E.LOG_N,'trig_cutoff':48},
            'pi':E.PI,'bernoulli_numbers':BERNOULLI,
            'uniform_EM_errors':{s:em_error(s) for s in ('one','half_plus_10i')},
            'runs':runs,'resources':{'wall_seconds':monotonic()-START,'cpu_seconds':process_time()-CPU},
            'scope':'No principal L value at s=1, no contour/zero/spectral or Lean conclusion'}


if __name__=='__main__':
    result=run()
    path=HERE/'unit_group_transform_pilot_20261111.json'
    path.write_text(json.dumps(encode(result),indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':result['status'],'resources':result['resources'],'output':str(path)}))
