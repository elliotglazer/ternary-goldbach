"""One capped complete-rectangle attempt with the frozen global inverse."""
from pathlib import Path
from fractions import Fraction as F
import importlib.util
import hashlib
import json
import sys
import time

HERE=Path(__file__).parent
SOURCE=HERE/'c5_residual_taylor_panels_20261111.py'
assert hashlib.sha256(SOURCE.read_bytes()).hexdigest()=='f1f91d5bc8b9daf5bca8b44fa55c1d333500662496157a453fb9e70cbd37fe4c'
spec=importlib.util.spec_from_file_location('accepted_c5_taylor',SOURCE)
t=importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)
em=t.em
PATH=Path(__file__).with_suffix('.json')
COEFF=[[em.acb(em.ar(F(z[0])),em.ar(F(z[1]))) for z in row]
       for row in t.old.data['coefficients']]
ABSCOEFF=[[abs(z).upper() for z in row] for row in COEFF]
MAX_CALLS=4000
MAX_SECONDS=180


def hashed(co):
    return hashlib.sha256(json.dumps([[t.enc(x) for x in row] for row in co],sort_keys=True).encode()).hexdigest()


def rational_jets(center,rho):
    s0=em.acb(em.ar(center[0]),em.ar(center[1]))
    jets=[[COEFF[0][k]]+[em.acb(0) for _ in range(t.D)] for k in range(3)]
    errors=[em.arb(0) for _ in range(3)]
    mind=None
    rr=em.ar(rho)
    for p,row,arow in zip(t.old.acbp,COEFF[1:],ABSCOEFF[1:]):
        diff=s0-p
        dist=abs(diff).lower()
        assert dist>rr
        if mind is None or dist<mind:mind=dist
        inv=1/diff
        power=inv
        for j in range(t.D+1):
            for k in range(3):jets[k][j]+=row[k]*power
            power*=-inv
        fac=rr**(t.D+1)/(dist**(t.D+1)*(dist-rr))
        for k in range(3):errors[k]+=arow[k]*fac
    return jets,list(map(t.upper,errors)),mind


class Model:
    def __init__(self,a,b):
        assert a[0]==b[0] or a[1]==b[1]
        self.a,self.b=a,b
        self.center=((a[0]+b[0])/2,(a[1]+b[1])/2)
        self.rho=(abs(a[0]-b[0])+abs(a[1]-b[1]))/2
        assert 0<self.rho<=F(1,64)<t.R
        assert self.center[0]-t.R>0
        gj=t.finite_l_jets(self.center)
        bj,be,mind=rational_jets(self.center,self.rho)
        M,Eouter=t.controls(self.center,t.R)
        _,Epanel=t.controls(self.center,self.rho)
        ratio=em.ar(self.rho/t.R)
        gtail=t.upper(M*ratio**(t.D+1)/(1-ratio))
        le=t.upper(Epanel+gtail)
        self.co=[]
        self.err=[]
        for k in range(3):
            co=[-x for x in t.polynomial_product(gj[k],bj[k])]
            co[0]+=1
            self.co.append(co)
            gp=t.poly_norm(gj[k],self.rho)
            bp=t.poly_norm(bj[k],self.rho)
            self.err.append(t.upper(le*(bp+be[k])+gp*be[k]))
        self.record={'a':list(map(str,a)),'b':list(map(str,b)),
            'center':list(map(str,self.center)),'radius':str(self.rho),
            'control_radius':str(t.R),'control_sigma_floor':str(self.center[0]-t.R),
            'minimum_pole_distance_lower':t.encu(mind),
            'finite_g_outer_bound':t.encu(M),'actual_L_minus_g_outer_bound':t.encu(Eouter),
            'actual_L_minus_g_panel_bound':t.encu(Epanel),'finite_g_Taylor_tail':t.encu(gtail),
            'rational_Taylor_tails':list(map(t.encu,be)),
            'residual_errors':list(map(t.encu,self.err)),
            'coefficient_sha256':hashed(self.co)}

    def bounds(self,a,b):
        for p in (a,b):
            assert (self.a[0]==self.b[0]==p[0] and
                    min(self.a[1],self.b[1])<=p[1]<=max(self.a[1],self.b[1])) or (
                    self.a[1]==self.b[1]==p[1] and
                    min(self.a[0],self.b[0])<=p[0]<=max(self.a[0],self.b[0]))
            assert abs(p[0]-self.center[0])+abs(p[1]-self.center[1])<=self.rho
        z=em.box((a[0]-self.center[0],a[1]-self.center[1]),
                 (b[0]-self.center[0],b[1]-self.center[1]))
        scalar=[t.eval_poly(co,z)+em.eb(err) for co,err in zip(self.co,self.err)]
        ii=em.acb(0,1)
        group=[sum((scalar[k-1]*ii**((-k*j)%4) for k in (1,2,3)),em.acb(0))/4
               for j in range(4)]
        q1=t.upper(sum((abs(z).upper() for z in group),em.arb(0)))
        q16=t.upper(sum((abs(z).upper()**32 for z in scalar),em.arb(0)))
        return q1,q16


def mesh():
    L,R,T=em.LEFT,em.RIGHT,em.T
    corners=[(L,-T),(R,-T),(R,T),(L,T),(L,-T)]
    rows=[]
    for edge,(a,b) in enumerate(zip(corners,corners[1:])):
        n=47 if edge%2==0 else 768
        for j in range(n):
            x=tuple(a[d]+(b[d]-a[d])*F(j,n) for d in range(2))
            y=tuple(a[d]+(b[d]-a[d])*F(j+1,n) for d in range(2))
            assert abs(y[0]-x[0])+abs(y[1]-x[1])<=F(1,32)
            rows.append((x,y))
    assert len(rows)==1630
    return rows


def check_prefix(rows,complete):
    L,R,T=em.LEFT,em.RIGHT,em.T
    prev=(L,-T)
    length=F(0)
    for row in rows:
        a,b=tuple(map(F,row['a'])),tuple(map(F,row['b']))
        assert a==prev
        assert ((a[1]==b[1]==-T and L<=a[0]<b[0]<=R) or
                (a[0]==b[0]==R and -T<=a[1]<b[1]<=T) or
                (a[1]==b[1]==T and L<=b[0]<a[0]<=R) or
                (a[0]==b[0]==L and -T<=b[1]<a[1]<=T))
        length+=abs(a[0]-b[0])+abs(a[1]-b[1])
        prev=b
    if complete:
        assert prev==(L,-T) and length==2*(R-L+2*T)
    else:assert length<=2*(R-L+2*T)
    return length


def replay(saved):
    assert saved['candidate_sha256']==hashlib.sha256(t.old.CANDIDATE.read_bytes()).hexdigest()
    assert saved['script_sha256']==hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    complete=saved['status']=='PASS_EXTERNAL_COMPLETE_C5_GLOBAL_INVERSE'
    models=[]
    for row in saved['models']:
        m=Model(tuple(map(F,row['a'])),tuple(map(F,row['b'])))
        assert m.record==row
        models.append(m)
    for row in saved['panels']:
        q=models[row['model']].bounds(tuple(map(F,row['a'])),tuple(map(F,row['b'])))
        index=0 if row['method']=='l1' else 1
        assert q[index]<1 and q[index]<=em.ar(F(row['bound']))
        tau=F(row['scalar_residual_upper'])
        assert 0<=tau<1
        if index==0:assert F(row['bound'])<=tau
        else:assert F(row['bound'])<=tau**32
    length=check_prefix(saved['panels'],complete)
    return {'status':'COMPLETE_REPLAY_PASS' if complete else 'PARTIAL_REPLAY_ONLY',
            'complete':complete,'models':len(models),'panels':len(saved['panels']),
            'length':str(length)}


def main():
    start=time.perf_counter()
    if '--replay' in sys.argv:
        r=replay(json.loads(PATH.read_text()))
        r['seconds']=time.perf_counter()-start
        print(json.dumps(r));return
    models=[];panels=[];attempts=[]
    calls=0;failures=0;maxdepth=0;modeltime=0.0;paneltime=0.0
    status='INCOMPLETE_DIAGNOSTIC';reason='not completed'

    def limit():
        if time.perf_counter()-start>=MAX_SECONDS or calls>=MAX_CALLS:
            raise RuntimeError('180-second/4000-panel cap reached')

    def visit(model,modelid,a,b,depth):
        nonlocal calls,failures,maxdepth,paneltime
        limit();calls+=1;maxdepth=max(maxdepth,depth)
        stamp=time.perf_counter();q1,q16=model.bounds(a,b)
        paneltime+=time.perf_counter()-stamp
        passed=[bool(q1<1),bool(q16<1)]
        attempts.append({'model':modelid,'a':list(map(str,a)),'b':list(map(str,b)),
                         'depth':depth,'passed':passed,'l1_upper':t.encu(q1),'T16_upper':t.encu(q16)})
        if any(passed):
            index=0 if passed[0] else 1
            bound=F(t.encu(q1 if index==0 else q16))
            tau=bound if index==0 else (31+bound)/32
            assert 0<=tau<1 and (index==0 or tau**32>=bound)
            panels.append({'model':modelid,'a':list(map(str,a)),'b':list(map(str,b)),
                'depth':depth,'method':'l1' if index==0 else'T16',
                'bound':str(bound),'scalar_residual_upper':str(tau)})
        else:
            failures+=1
            mid=((a[0]+b[0])/2,(a[1]+b[1])/2)
            visit(model,modelid,a,mid,depth+1)
            visit(model,modelid,mid,b,depth+1)

    try:
        for a,b in mesh():
            limit();stamp=time.perf_counter();model=Model(a,b)
            modeltime+=time.perf_counter()-stamp
            modelid=len(models);models.append(model.record)
            visit(model,modelid,a,b,0)
            if len(models)%200==0:
                print(json.dumps({'models':len(models),'calls':calls,'accepted':len(panels),
                                  'seconds':time.perf_counter()-start}),flush=True)
        check_prefix(panels,True)
        status='PASS_EXTERNAL_COMPLETE_C5_GLOBAL_INVERSE';reason='all closed-boundary panels certified'
    except RuntimeError as ex:
        reason=str(ex)
        check_prefix(panels,False)
    nm=len(models)
    result={'status':status,'reason':reason,'candidate_sha256':hashlib.sha256(t.old.CANDIDATE.read_bytes()).hexdigest(),
        'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'model_source_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
        'rectangle':['111/200','2','-12','12'],'characters':[1,2,3],'generator':2,
        'degree':t.D,'precision_bits':em.ctx.prec,'inherited_constant_bits':128,
        'initial_mesh_panels':1630,'model_count':nm,'panel_calls':calls,'panel_count':len(panels),
        'failed_panel_evaluations':failures,'max_refinement_depth':maxdepth,
        'l1_acceptances':sum(r['method']=='l1' for r in panels),
        'moment_only_acceptances':sum(r['method']=='T16' for r in panels),
        'model_build_seconds':modeltime,'panel_evaluation_seconds':paneltime,
        'elapsed_seconds':time.perf_counter()-start,
        'max_calls':MAX_CALLS,'max_seconds':MAX_SECONDS,
        'cost_counts':{'finite_series_exponentials':262*nm,'pole_reciprocals':385*nm,
            'rational_jet_coefficient_products':385*(t.D+1)*3*nm,
            'rational_power_updates':385*(t.D+1)*nm,'residual_polynomial_products':3*(t.D+1)**2*nm,
            'outer_control_bounds':nm,'initial_disk_control_bounds':nm,
            'scalar_residual_horner_products':3*(2*t.D)*calls,
            'scalar_moment_integer_powers':3*calls,'group_convolutions':0,
            'extra_L_point_calls':0},
        'models':models,'panels':panels,'attempts':attempts}
    PATH.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ('models','panels','attempts')},indent=2))


if __name__=='__main__':main()
