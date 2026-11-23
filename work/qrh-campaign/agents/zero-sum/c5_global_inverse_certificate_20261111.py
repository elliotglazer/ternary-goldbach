"""Whole-boundary primitive group-algebra inverse certificate, conductor5 only."""
from fractions import Fraction as F
from pathlib import Path
import importlib.util
import hashlib
import json
import sys
import time

HERE = Path(__file__).parent
GEN = HERE/'c5_global_inverse_candidate_20261111.py'
CANDIDATE = GEN.with_suffix('.json')
spec = importlib.util.spec_from_file_location('candidate_tools',GEN)
gen = importlib.util.module_from_spec(spec)
spec.loader.exec_module(gen)
em=gen.em
em.ctx.prec=160
PATH=Path(__file__).with_suffix('.json')
data=json.loads(CANDIDATE.read_text())
assert data['status']=='CANDIDATE_ONLY_NO_BOUNDARY_ACCEPTANCE'
assert data['characters']==[1,2,3] and data['residues']==[1,2,4,3]
assert data['source_sha256']==hashlib.sha256(gen.SOURCE.read_bytes()).hexdigest()
poles=[(F(x),F(y)) for x,y in data['poles']]
assert all(x==F(1,2)<em.LEFT and -12<=y<=12 for x,y in poles)
assert len(set(poles))==len(poles)==385
acbp=[em.acb(em.ar(x),em.ar(y)) for x,y in poles]


def cmul(x,y):
    return (x[0]*y[0]-x[1]*y[1],x[0]*y[1]+x[1]*y[0])


roots=[(F(1),F(0)),(F(0),F(1)),(F(-1),F(0)),(F(0),F(-1))]
coeff=[]
for row in data['coefficients']:
    chars=[tuple(map(F,z)) for z in row]
    out=[]
    for j in range(4):
        summ=[F(0),F(0)]
        for k,z in enumerate(chars,1):
            w=cmul(z,roots[(-k*j)%4])
            summ=[summ[d]+w[d]/4 for d in range(2)]
        out.append(em.acb(em.ar(summ[0]),em.ar(summ[1])))
    coeff.append(out)
assert len(coeff)==len(poles)+1
E=[em.acb(em.ar(F(3,4)))]+[em.acb(em.ar(F(-1,4)))]*3


def convolution(a,b):
    result=[em.acb(0) for _ in range(4)]
    for j in range(4):
        for k in range(4):
            result[(j+k)%4]+=a[j]*b[k]
    return result


def group_em(s):
    # Same four pole-cancelled EM expressions as frozen evaluate().
    # Projection by e subtracts their common mean; no individual L outputs.
    poch=[em.acb(1)]
    for j in range(2*em.M):
        poch.append(poch[-1]*(s+j))
    lb0=em.pre[0][1]
    base=((1-s)*lb0).exp()
    raw=[]
    scale=(-s*em.ar(5).log()).exp()
    for logs,lb,powers in em.pre:
        bp=(-s*lb).exp()
        z=sum(((-s*l).exp() for l in logs),em.acb(0))+bp/2
        z+=bp*sum((em.co[k-1]*poch[2*k-1]*powers[k-1]
                   for k in range(1,em.M+1)),em.acb(0))
        err=4*abs(poch[2*em.M])*(lb*(1-em.ar(em.LEFT)-2*em.M)).exp()
        err/=6**(2*em.M)*(em.ar(em.LEFT)+2*em.M-1)
        step=lb-lb0
        raw.append(scale*(z-base*step*em.exprel((1-s)*step)+em.eb(err)))
    mean=sum(raw,em.acb(0))/4
    return [z-mean for z in raw]


def group_candidate(s):
    out=list(coeff[0])
    for pole,row in zip(acbp,coeff[1:]):
        inv=1/(s-pole)
        for j in range(4):
            out[j]+=row[j]*inv
    return out


def bounds(a,b):
    s=em.box(a,b)
    av=group_em(s)
    bv=group_candidate(s)
    ab=convolution(av,bv)
    r=[E[j]-ab[j] for j in range(4)]
    l1=sum((abs(z).upper() for z in r),em.arb(0)).upper()
    power=r
    for _ in range(4):
        power=convolution(power,power)
    moment=4*sum((abs(z).upper()*abs(z).upper() for z in power),em.arb(0))
    return l1,moment.upper()


def rational_upper(z):
    return str(em.dy(z.upper()))


def main():
    start=time.perf_counter()
    if '--replay' in sys.argv:
        old=json.loads(PATH.read_text())
        assert old['status']=='PASS_EXTERNAL_GLOBAL_INVERSE_C5'
        assert old['candidate_sha256']==hashlib.sha256(CANDIDATE.read_bytes()).hexdigest()
        assert old['script_sha256']==hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
        count=0
        for method,ind in [('l1',0),('T16',1)]:
            em.check_partition(old[method+'_panels'])
            for row in old[method+'_panels']:
                a,b=tuple(map(F,row['a'])),tuple(map(F,row['b']))
                q=bounds(a,b)[ind]
                assert q<1 and q<=em.ar(F(row['bound']))
                count+=1
        print(json.dumps({'status':'REPLAY_PASS','panel_rechecks':count,
                          'seconds':time.perf_counter()-start}))
        return
    attempts=[]
    panels=[[],[]]
    failed=[0,0]
    calls=0

    def visit(a,b,depth,active):
        nonlocal calls
        if time.perf_counter()-start>180 or calls>=30000 or depth>24:
            raise RuntimeError('bounded construction incomplete')
        calls+=1
        q=bounds(a,b)
        passed=[bool(z<1) for z in q]
        attempts.append({'a':list(map(str,a)),'b':list(map(str,b)),
                         'depth':depth,'active':active,'passed':passed})
        remaining=[]
        for j in active:
            if passed[j]:
                panels[j].append({'a':list(map(str,a)),'b':list(map(str,b)),
                                  'depth':depth,'bound':rational_upper(q[j])})
            else:
                failed[j]+=1
                remaining.append(j)
        if remaining:
            mid=((a[0]+b[0])/2,(a[1]+b[1])/2)
            visit(a,mid,depth+1,remaining)
            visit(mid,b,depth+1,remaining)

    corners=[(em.LEFT,-em.T),(em.RIGHT,-em.T),(em.RIGHT,em.T),
             (em.LEFT,em.T),(em.LEFT,-em.T)]
    status='PASS_EXTERNAL_GLOBAL_INVERSE_C5'
    error=None
    try:
        for a,b in zip(corners,corners[1:]):
            visit(a,b,0,[0,1])
        for pp in panels:
            em.check_partition(pp)
    except RuntimeError as exc:
        status='INCOMPLETE_DIAGNOSTIC'
        error=str(exc)
    result={'status':status,'error':error,
            'rectangle':['111/200','2','-12','12'],
            'generator':2,'residues':[1,2,4,3],'characters':[1,2,3],
            'source_sha256':hashlib.sha256(gen.SOURCE.read_bytes()).hexdigest(),
            'candidate_sha256':hashlib.sha256(CANDIDATE.read_bytes()).hexdigest(),
            'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'bits':160,'EM_N':em.N,'EM_M':em.M,
            'inherited_constant_precision_bits':128,
            'pole_count':len(poles),'pole_clearance':'11/200',
            'group_coefficient_count':len(coeff)*4,
            'combined_vector_panel_evaluations':calls,
            'primitive_EM_term_exponentials_per_call':4*em.N,
            'candidate_reciprocals_per_call':len(poles),
            'candidate_complex_multiplies_per_call':4*len(poles),
            'group_convolutions_per_call':5,
            'complex_products_per_group_convolution':16,
            'l1_failed_active_panels':failed[0], 'T16_failed_active_panels':failed[1],
            'l1_panel_count':len(panels[0]),'T16_panel_count':len(panels[1]),
            'elapsed_seconds':time.perf_counter()-start,
            'l1_panels':panels[0],'T16_panels':panels[1],'attempts':attempts}
    PATH.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ('attempts','l1_panels','T16_panels')},indent=2))


if __name__=='__main__':
    main()
