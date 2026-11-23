"""Two short rational wave blocks, exact interval inputs and dyadic updates.

No high-height EM, zeta, Gamma, FFT, or zero-count calculation.
"""
from fractions import Fraction as Q
from pathlib import Path
from hashlib import sha256
from math import factorial,isqrt
from time import monotonic,process_time
import importlib.util,json

HERE=Path(__file__).parent
HELPER=HERE/'principal_k0_point_certificates_20261111.py'
HELPER_SHA='9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22'
assert sha256(HELPER.read_bytes()).hexdigest().upper()==HELPER_SHA
spec=importlib.util.spec_from_file_location('pinned_point_helpers',HELPER)
E=importlib.util.module_from_spec(spec);spec.loader.exec_module(E)
START=monotonic();CPU=process_time()
CBITS=48;CSCALE=2**CBITS;B=16;H=Q(1,64)
LOGS={n:E.log_point(Q(n)) for n in range(1,399)}
ROOTS={n:E.sqrt_point(Q(n)) for n in range(1,399)}


def tick():
    if monotonic()-START>570: raise RuntimeError('Bounded wave pilot timeout')


def roundq(x): return Q(E.floorq(x*CSCALE+Q(1,2)),CSCALE)
def cadd(z,w): return z[0]+w[0],z[1]+w[1]
def cmul(z,w): return z[0]*w[0]-z[1]*w[1],z[0]*w[1]+z[1]*w[0]
def l1(z): return abs(z[0])+abs(z[1])
def rounded_center(z): return roundq(z[0]),roundq(z[1])


def center_box(rect):
    v=tuple(roundq((lo+hi)/2) for lo,hi in rect)
    r=sum((max(abs(vv-lo),abs(vv-hi)) for vv,(lo,hi) in zip(v,rect)),Q(0))
    return v,r


def trig(arg):
    c=(arg[0]+arg[1])/2
    k=E.floorq(c/(E.PI[0]+E.PI[1])+Q(1,2))
    red=E.sub(arg,E.scale(2*k,E.PI))
    assert -4<=red[0]<=red[1]<=4
    x,r=(red[0]+red[1])/2,(red[1]-red[0])/2
    co=sum(((-1)**j*x**(2*j)/factorial(2*j) for j in range(24)),Q(0))
    si=sum(((-1)**j*x**(2*j+1)/factorial(2*j+1) for j in range(24)),Q(0))
    err=E.COS_TAIL+r
    out=E.rounded((co-err,co+err)),E.rounded((si-err,si+err))
    return out,{'argument':arg,'k':k,'reduced':red,'output':out}


def point_parts(t):
    a=E.sqrt_interval(E.div(E.pt(t),E.scale(2,E.PI)))
    n=E.floorq(a[0]);assert 2*E.PI[1]*n*n<t<2*E.PI[0]*(n+1)**2
    assert n<a[0]<=a[1]<n+1
    z=E.sub(E.pt(1),E.scale(2,E.sub(a,E.pt(n))))
    larg=E.div(E.pt(t),E.scale(2,E.PI));lv=E.log_interval(larg)
    theta=E.add(E.sub(E.sub(E.scale(t/2,lv),E.pt(t/2)),E.scale(Q(1,8),E.PI)),E.pt(1/(48*t)))
    f,fw=E.coefficient(z);ra=E.sqrt_interval(a)
    correction=E.scale(-(-1)**n,E.div(f,ra))
    return n,theta,correction,{'a':a,'z':z,'log_argument':larg,'log_value':lv,
                             'theta':theta,'F_witness':fw,'sqrt_a':ra,'J':correction}


def direct_khat(t,n,theta,correction):
    total=E.pt(0);terms=[]
    for k in range(1,n+1):
        tick()
        arg=E.sub(theta,E.scale(t,LOGS[k]))
        co,wit=E.cosine(arg)
        term=E.div(E.scale(2,co),ROOTS[k])
        total=E.add(total,term)
        terms.append({'n':k,'cosine':wit,'term':term})
    return E.add(total,correction),terms


def block(m):
    tick()
    kl=E.floorq(128*m*m*E.PI[0]);ku=E.floorq(128*m*m*E.PI[1]);assert kl==ku
    k=kl;t0=Q(k-8,64);top=t0+B*H
    assert 1500<t0<top<1000000
    assert t0+8*H<2*m*m*E.PI[0]<2*m*m*E.PI[1]<t0+9*H
    assert 2*E.PI[1]*(m-1)**2<t0 and top<2*E.PI[0]*(m+1)**2
    e=Q(19,1000)/top
    E0=e/(64*m);delta=min(Q(1,2*B),e/(128*m*B));eta=e/(128*m*B)
    wave_bound=2*(E0+B*(delta+eta));assert wave_bound==e/(16*m)
    assert B*delta<=Q(1,2)
    rootceil=isqrt(m)+(isqrt(m)**2<m);A=2*rootceil+1
    assert (A-1)**2>=4*m
    init=[];v=[];radii=[];rot=[];rot_rad=[]
    for n in range(1,m+1):
        tick()
        unit,uw=trig(E.scale(-t0,LOGS[n]))
        amplitude=E.div(E.pt(1),ROOTS[n])
        wb=E.mul(amplitude,unit[0]),E.mul(amplitude,unit[1])
        vi,ri=center_box(wb);assert ri<=E0
        rb,rw=trig(E.scale(-H,LOGS[n]));qi,di=center_box(rb);assert di<=delta
        v.append(vi);radii.append(ri);rot.append(qi);rot_rad.append(di)
        init.append({'n':n,'wave_trig':uw,'wave_box':wb,'center':vi,'radius':ri,
                     'rotation_trig':rw,'rotation_center':qi,'rotation_radius':di})
    samples=[];states=[];updates=[]
    for j in range(B+1):
        tick()
        t=t0+j*H
        n,theta,J,pw=point_parts(t)
        assert n==(m-1 if j<=8 else m)
        assert max(radii)<=wave_bound
        S=(sum((x[0] for x in v[:n]),Q(0)),sum((x[1] for x in v[:n]),Q(0)))
        sum_error=sum(radii[:n],Q(0));assert sum_error<=e/16
        # All centers share a dyadic grid, so the active sum is exact.
        ub,ut=trig(theta);u,du=center_box(ub);assert du<=e/(16*A)
        jc=roundq((J[0]+J[1])/2);je=max(abs(jc-J[0]),abs(jc-J[1]));assert je<=e/4
        raw=2*cmul(u,S)[0]+jc
        kval=roundq(raw);finalerr=abs(kval-raw);assert finalerr<=e/8
        arithmetic_radius=2*(sum_error+du*l1(S))+je+finalerr
        assert arithmetic_radius<=3*e/4
        wave_interval=kval-arithmetic_radius,kval+arithmetic_radius
        direct,terms=direct_khat(t,n,theta,J)
        assert wave_interval[0]<=direct[0]<=direct[1]<=wave_interval[1]
        power=E.sqrt_interval(E.sqrt_interval(E.pt(t**3)))
        hr=Q(E.ceilq((Q(47,100)/power[0])*E.SCALE),E.SCALE)
        assert hr>0 and hr**4*t**3>=Q(47,100)**4
        assert arithmetic_radius**4*t**3<Q(19,1000)**4
        hardy=kval-hr,kval+hr
        sign='positive' if hardy[0]>0 else 'negative' if hardy[1]<0 else 'inconclusive'
        samples.append({'j':j,'t':t,'N':n,'point_parts':pw,'active_sum_center':S,
                        'active_sum_radius':sum_error,'sum_rounding_error':Q(0),
                        'phase_trig':ut,'phase_center':u,'phase_radius':du,
                        'correction_center':jc,'correction_radius':je,
                        'final_unrounded':raw,'center':kval,'final_rounding_error':finalerr,
                        'arithmetic_radius':arithmetic_radius,'Khat_wave':wave_interval,
                        'direct_Khat':direct,'direct_terms':terms,'Hardy_radius':hr,
                        'Hardy_interval':hardy,'isolated_sign':sign})
        states.append({'j':j,'centers':v[:],'radii':radii[:]})
        if j<B:
            nv=[];nr=[];errs=[]
            for z,rz,q,dq in zip(v,radii,rot,rot_rad):
                exact=cmul(q,z);new=rounded_center(exact)
                error=l1((new[0]-exact[0],new[1]-exact[1]));assert error<=eta
                # Split with the exact unit rotation, not the nonunit center q.
                radius=rz+dq*l1(z)+error
                assert radius<=wave_bound
                nv.append(new);nr.append(radius);errs.append(error)
            updates.append({'from_j':j,'count':m,'maximum_rounding_l1':max(errs),
                            'sum_rounding_l1':sum(errs,Q(0))})
            v,radii=nv,nr
    return {'M':m,'B':B,'h':H,'k':k,'t0':t0,'top':top,'A':A,'e':e,
            'allocations':{'E0':E0,'delta':delta,'eta':eta,'wave_bound':wave_bound,
                           'sum_rounding':e/16,'phase':e/(16*A),'correction':e/4,'final':e/8},
            'initial_and_rotation':init,'states':states,'update_summaries':updates,
            'samples':samples,'inconclusive_j':[s['j'] for s in samples if s['isolated_sign']=='inconclusive']}


def encode(x):
    if isinstance(x,Q):return f'{x.numerator}/{x.denominator}'
    if isinstance(x,dict):return {k:encode(v) for k,v in x.items()}
    if isinstance(x,(list,tuple)):return [encode(v) for v in x]
    return x


def run():
    blocks=[]
    for m in (18,398):
        b=block(m);blocks.append(b)
        print(json.dumps({'completed_M':m,'samples':17,'inconclusive_j':b['inconclusive_j'],
                          'elapsed_seconds':monotonic()-START}),flush=True)
    return {'status':'PASS two bounded wave blocks, no spectral conclusion',
            'helper_sha256':HELPER_SHA,'center_bits':CBITS,'elementary_bits':E.BITS,
            'pi':E.PI,'logs':LOGS,'square_roots':ROOTS,'blocks':blocks,
            'resources':{'wall_seconds':monotonic()-START,'cpu_seconds':process_time()-CPU}}


if __name__=='__main__':
    data=run();out=HERE/'principal_block_wave_pilot_20261111.json'
    out.write_text(json.dumps(encode(data),indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':data['status'],'resources':data['resources'],'output':str(out)}))
