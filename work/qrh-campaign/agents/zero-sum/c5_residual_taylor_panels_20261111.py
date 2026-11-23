"""Four frozen panels only: centered finite-EM/rational residual models."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import importlib.util
import hashlib
import json
import sys
import time
from flint import acb_series

HERE=Path(__file__).parent
OLD=HERE/'c5_global_inverse_certificate_20261111.py'
OLD_DATA=OLD.with_suffix('.json')
spec=importlib.util.spec_from_file_location('old_c5_inverse',OLD)
old=importlib.util.module_from_spec(spec)
spec.loader.exec_module(old)
em=old.em
em.ctx.prec=192
D=12
em.ctx.cap=D+1
R=F(1,4)
INDICES=[29999,3871,457,24860]
PATH=Path(__file__).with_suffix('.json')


def upper(x): return x.upper()
def enc(x):
    return {'re':[str(em.dy(x.real.lower())),str(em.dy(x.real.upper()))],
            'im':[str(em.dy(x.imag.lower())),str(em.dy(x.imag.upper()))]}
def encu(x): return str(em.dy(x.upper()))


def finite_l_jets(center):
    s=acb_series([em.acb(em.ar(center[0]),em.ar(center[1])),1],prec=D+1)
    poch=[s*0+1]
    for j in range(2*em.M): poch.append(poch[-1]*(s+j))
    base=((1-s)*em.pre[0][1]).exp()
    raw=[]
    for logs,lb,powers in em.pre:
        bp=(-s*lb).exp()
        val=sum(((-s*l).exp() for l in logs),s*0)+bp/2
        val+=bp*sum((em.co[k-1]*poch[2*k-1]*powers[k-1]
                     for k in range(1,em.M+1)),s*0)
        step=lb-em.pre[0][1]
        z=(1-s)*step
        term=poly=z*0+1
        for j in range(1,19):
            term=term*z/(j+1)
            poly+=term
        raw.append(val-base*step*poly)
    scale=(-s*em.ar(5).log()).exp()
    ii=em.acb(0,1)
    ls=[scale*sum((raw[j]*(ii**(k*j)) for j in range(4)),s*0)
        for k in (1,2,3)]
    return [[x[j] for j in range(D+1)] for x in ls]


def controls(center,radius):
    """Outer finite-g bound and actual L-minus-g bound on a closed disk."""
    s0=em.acb(em.ar(center[0]),em.ar(center[1]))
    sig=em.ar(center[0]-radius)
    assert center[0]-radius>0
    S=upper(abs(s0))+em.ar(radius)
    poch=[em.arb(1)]
    for j in range(2*em.M): poch.append(poch[-1]*(S+j))
    base=((1-sig)*em.pre[0][1]).exp()
    scale=(-sig*em.ar(5).log()).exp()
    finite=em.arb(0)
    error=em.arb(0)
    for logs,lb,powers in em.pre:
        bp=(-sig*lb).exp()
        # Hurwitz's n=0 base lies below1. Its maximum is at the OTHER
        # real endpoint. The absolute-log formula handles both signs.
        val=sum(((-em.ar(center[0])*l+em.ar(radius)*upper(abs(l))).exp()
                 for l in logs),em.arb(0))+bp/2
        val+=bp*sum((upper(abs(em.co[k-1]))*poch[2*k-1]*powers[k-1]
                     for k in range(1,em.M+1)),em.arb(0))
        step=upper(abs(lb-em.pre[0][1]))
        z=(S+1)*step
        term=poly=em.arb(1)
        for j in range(1,19):
            term=term*z/(j+1)
            poly+=term
        finite+=val+base*step*poly
        exprem=base*step*z.exp()*z**19/factorial(20)
        emrem=4*poch[2*em.M]*(lb*(1-sig-2*em.M)).exp()
        emrem/=6**(2*em.M)*(sig+2*em.M-1)
        error+=exprem+emrem
    return upper(scale*finite),upper(scale*error)


def rational_jets(center,rho):
    s0=em.acb(em.ar(center[0]),em.ar(center[1]))
    coeff=old.data['coefficients']
    exact=[[em.acb(em.ar(F(z[0])),em.ar(F(z[1]))) for z in row] for row in coeff]
    jets=[[exact[0][k]]+[em.acb(0) for _ in range(D)] for k in range(3)]
    errs=[em.arb(0) for _ in range(3)]
    min_dist=None
    rr=em.ar(rho)
    for pole,row in zip(old.acbp,exact[1:]):
        diff=s0-pole
        dist=abs(diff).lower()
        assert dist>rr
        if min_dist is None or dist<min_dist:min_dist=dist
        inv=1/diff
        power=inv
        for j in range(D+1):
            for k in range(3):jets[k][j]+=row[k]*power
            power*=-inv
        for k in range(3):
            errs[k]+=upper(abs(row[k]))*rr**(D+1)/(dist**(D+1)*(dist-rr))
    return jets,list(map(upper,errs)),min_dist


def polynomial_product(a,b):
    result=[em.acb(0) for _ in range(len(a)+len(b)-1)]
    for j,x in enumerate(a):
        for k,y in enumerate(b):result[j+k]+=x*y
    return result


def eval_poly(co,z):
    value=co[-1]
    for c in reversed(co[:-1]):value=value*z+c
    return value


def poly_norm(co,rho):
    return upper(sum((upper(abs(z))*em.ar(rho)**j for j,z in enumerate(co)),em.arb(0)))


def one(index,row):
    a,b=tuple(map(F,row['a'])),tuple(map(F,row['b']))
    assert a[0]==b[0] and a[0] in (em.LEFT,em.RIGHT)
    center=((a[0]+b[0])/2,(a[1]+b[1])/2)
    rho=abs(a[1]-b[1])/2
    assert 0<rho<R
    s0=em.acb(em.ar(center[0]),em.ar(center[1]))
    z=em.box((F(0),a[1]-center[1]),(F(0),b[1]-center[1]))
    gj=finite_l_jets(center)
    bj,be,min_dist=rational_jets(center,rho)
    M,Eouter=controls(center,R)
    _,Epanel=controls(center,rho)
    ratio=em.ar(rho/R)
    gtail=upper(M*ratio**(D+1)/(1-ratio))
    Lerror=upper(Epanel+gtail)
    scalar_boxes=[]
    residual_coeff=[]
    residual_errors=[]
    for k in range(3):
        co=[-x for x in polynomial_product(gj[k],bj[k])]
        co[0]+=1
        Gbound=poly_norm(gj[k],rho)
        Bbound=poly_norm(bj[k],rho)
        err=upper(Lerror*(Bbound+be[k])+Gbound*be[k])
        scalar_boxes.append(eval_poly(co,z)+em.eb(err))
        residual_coeff.append(co)
        residual_errors.append(err)
    ii=em.acb(0,1)
    group=[sum((scalar_boxes[k-1]*ii**((-k*j)%4) for k in (1,2,3)),em.acb(0))/4
           for j in range(4)]
    q1=upper(sum((upper(abs(x)) for x in group),em.arb(0)))
    power=group
    for _ in range(4):power=old.convolution(power,power)
    q16=upper(4*sum((upper(abs(x))*upper(abs(x)) for x in power),em.arb(0)))
    old1,old16=old.bounds(a,b)
    point_values=em.evaluate(s0)
    point_b=[eval_poly(co,em.acb(0)) for co in bj]
    point_r=[1-x*y for x,y in zip(point_values,point_b)]
    return {'attempt_index':index,'a':list(map(str,a)),'b':list(map(str,b)),
            'center':list(map(str,center)),'half_length':str(rho),'control_radius':str(R),
            'control_sigma_floor':str(center[0]-R),'minimum_pole_distance_lower':encu(min_dist),
            'finite_g_outer_bound':encu(M),'actual_L_minus_g_outer_bound':encu(Eouter),
            'actual_L_minus_g_panel_bound':encu(Epanel),'finite_g_Taylor_tail':encu(gtail),
            'actual_L_coefficient_errors': [encu(Eouter/em.ar(R)**j) for j in range(D+1)],
            'rational_Taylor_tails':list(map(encu,be)),
            'residual_analytic_errors':list(map(encu,residual_errors)),
            'g_coefficients':[[enc(x) for x in co] for co in gj],
            'B_coefficients':[[enc(x) for x in co] for co in bj],
            'residual_coefficients':[[enc(x) for x in co] for co in residual_coeff],
            'residual_scalar_boxes':list(map(enc,scalar_boxes)),
            'residual_group_boxes':list(map(enc,group)),
            'center_actual_residual_boxes':list(map(enc,point_r)),
            'old_l1_upper':encu(old1),'old_T16_upper':encu(old16),
            'old_pass':[bool(old1<1),bool(old16<1)],
            'new_l1_upper':encu(q1),'new_T16_upper':encu(q16),
            'new_pass':[bool(q1<1),bool(q16<1)]}


def main():
    start=time.perf_counter()
    saved=json.loads(OLD_DATA.read_text())
    assert saved['status']=='INCOMPLETE_DIAGNOSTIC'
    assert saved['script_sha256']==hashlib.sha256(OLD.read_bytes()).hexdigest()
    assert saved['candidate_sha256']==hashlib.sha256(old.CANDIDATE.read_bytes()).hexdigest()
    rows=[one(i,saved['attempts'][i]) for i in INDICES]
    result={'status':'FOUR_FIXED_PANELS_ONLY','all_four_new_tests_pass':all(all(r['new_pass']) for r in rows),
            'full_rectangle_certified':False,'degree_L':D,'degree_B':D,'degree_residual':2*D,
            'precision_bits':em.ctx.prec,'inherited_constant_bits':128,
            'candidate_sha256':saved['candidate_sha256'],
            'old_receipt_sha256':hashlib.sha256(OLD_DATA.read_bytes()).hexdigest(),
            'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'finite_series_exp_calls_per_panel':262,
            'rational_pole_reciprocals_per_panel':385,
            'rational_jet_coefficient_products_per_panel':385*(D+1)*3,
            'rational_power_updates_per_panel':385*(D+1),
            'residual_polynomial_products_per_panel':3*(D+1)**2,
            'old_bound_recomputations':4,'center_EM_vector_calls':4,
            'elapsed_seconds':time.perf_counter()-start,'panels':rows}
    if '--recompute' in sys.argv:
        existing=json.loads(PATH.read_text())
        existing.pop('elapsed_seconds'); comp=dict(result);comp.pop('elapsed_seconds')
        assert existing==comp
    else:
        PATH.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='panels'},indent=2))
    for row in rows:
        print(json.dumps({'index':row['attempt_index'],'old':row['old_pass'],'new':row['new_pass'],
            'new_l1':float(F(row['new_l1_upper'])),'old_l1':float(F(row['old_l1_upper'])),
            'new_T16':float(F(row['new_T16_upper']))}))


if __name__=='__main__':main()
