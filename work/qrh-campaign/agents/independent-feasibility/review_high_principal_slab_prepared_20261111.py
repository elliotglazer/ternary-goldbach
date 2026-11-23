"""Prepared independent 13-model high-slab audit. NO execution on import.

Execution requires a future coordinator manifest binding the frozen candidate,
producer code, analytic plan review, source adapter review and this script.
No producer import; no builtin zeta/theta/Gamma/RS or indexed-zero evaluation.
"""
from fractions import Fraction as Q
from pathlib import Path
from math import comb, factorial
import argparse
import hashlib
import json
import time

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
T = 1000000
LEFT, RIGHT = Q(629, 1250), Q(2)
BOTTOM, TOP = Q(T)-Q(1, 8), Q(T)
N, M, K = 300001, 36, 26
B = N+1
OUTER = Q(3, 4)
BITS = 160
SECONDS = 300
MAX_PANELS = 256
MAX_DEPTH = 12
MAX_MEMORY = 512*1024**2
CENTERS = [Q(j, 8) for j in range(5, 16, 2)]
TARGET = {'function': 'actual_zeta=zetaF/(s-1)', 'left': str(LEFT),
          'right': str(RIGHT), 'bottom': str(BOTTOM), 'top': str(TOP)}
PINS = {
 'moebius/PRINCIPAL_HIGH_ENDPOINT_SLAB_DESIGN_2026-11-11.md':
 '5163C4208A5FC6F670FF0EDBC149A43C38FA5246F1D6CA567C75E055DD7EA2C8',
 'major-constants/HIGH_PRINCIPAL_SLAB_SCALAR_SUPPORT_2026-11-11.md':
 '5176DAF690017CF8889BF14F22A882CF93B713B76D126983AAB7359BA8ECB060',
 'independent-feasibility/REVIEW_EM_TOP_HORIZONTAL_2026-11-11.md':
 '6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E',
 'moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md':
 '5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1',
 'zero-sum/em_top_horizontal_20261111.json':
 '9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26',
}
ROTATIONS = {'1': (Q(1), Q(0)), '-1': (Q(-1), Q(0)),
             'i': (Q(0), Q(1)), '-i': (Q(0), Q(-1))}


def need(ok, why):
    if not ok: raise ValueError(why)


def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest().upper()
def point(z): return [str(x) for x in z]
def readpoint(z):
    need(len(z) == 2, 'complex coordinate pair')
    return Q(z[0]), Q(z[1])
def real_product(a, b): return a[0]*b[0]-a[1]*b[1]


def base_panels():
    out = []
    for i, c in enumerate(CENTERS):
        out.append(('bottom', 'bottom_'+str(i), (max(LEFT,c-Q(1,8)),BOTTOM), (c+Q(1,8),BOTTOM)))
    out.append(('right', None, (RIGHT,BOTTOM), (RIGHT,TOP)))
    for i in range(5,-1,-1):
        c = CENTERS[i]
        out.append(('top', 'top_'+str(i), (c+Q(1,8),TOP), (max(LEFT,c-Q(1,8)),TOP)))
    out.append(('left', 'left', (LEFT,TOP), (LEFT,BOTTOM)))
    return out


def specifications():
    # All six top models are fresh: the old independent receipt contains no jets.
    out = [('top_'+str(i), (c,TOP), Q(1,8)) for i,c in enumerate(CENTERS)]
    out += [('bottom_'+str(i), (c,BOTTOM), Q(1,8)) for i,c in enumerate(CENTERS)]
    return out+[('left', (LEFT,Q(T)-Q(1,16)), Q(1,16))]


def geometry(candidate):
    target = candidate['target']
    need(target['rectangle'] == {k:TARGET[k] for k in ('left','right','bottom','top')}, 'fixed slab')
    need((target['T'],target['N'],target['M'],target['Taylor_length']) == (T,333334,32,24), 'author model header')
    need(Q(target['outer_radius']) == 1 and Q(target['target_radius']) == Q(1,8), 'author radii')
    models = candidate['models']
    need(set(models) == {x[0] for x in specifications()}, 'all thirteen consumed models')
    for name, center, _ in specifications():
        need(readpoint(models[name]['center']) == center, 'exact model center')
        need(len(models[name]['coefficients_zetaF']) == 24, 'author coefficient length')
    panels = candidate['accepted_panels']
    need(14 <= len(panels) <= MAX_PANELS and not candidate['pending_panels'], 'complete bounded panel list')
    need(candidate['status'] == 'PASS_EXTERNAL_HIGH_SLAB_WINDING_ZERO', 'candidate completion status')
    need(len(candidate['attempts']) <= MAX_PANELS, 'author attempt cap')
    bases = {(s,m):(a,b) for s,m,a,b in base_panels()}
    lengths = {s:Q(0) for s in ('bottom','right','top','left')}
    order = []
    for i,p in enumerate(panels):
        a,b = readpoint(p['start']),readpoint(p['end'])
        need(b == readpoint(panels[(i+1)%len(panels)]['start']), 'exact consecutive input vertices')
        key = p['side'],p['model']
        need(key in bases, 'side/model binding')
        u,v = bases[key]
        axis = 0 if p['side'] in ('bottom','top') else 1
        need(a[1-axis] == b[1-axis] == u[1-axis], 'boundary line')
        t0,t1 = (a[axis]-u[axis])/(v[axis]-u[axis]),(b[axis]-u[axis])/(v[axis]-u[axis])
        depth = p['depth']
        need(type(depth) is int and 0 <= depth <= MAX_DEPTH, 'depth cap')
        need(0 <= t0 < t1 <= 1 and t1-t0 == Q(1,2**depth)
             and (t0*2**depth).denominator == 1, 'dyadic child of original panel')
        need(p['rotation'] in ROTATIONS, 'signed coordinate rotation')
        lengths[p['side']] += abs(b[axis]-a[axis])
        if not order or order[-1] != p['side']: order.append(p['side'])
    need(readpoint(panels[0]['start']) == (LEFT,BOTTOM), 'initial corner')
    need(order == ['bottom','right','top','left'], 'one CCW circuit')
    need(lengths == {'bottom':RIGHT-LEFT,'right':TOP-BOTTOM,'top':RIGHT-LEFT,'left':TOP-BOTTOM}, 'complete side lengths')
    return panels


def polygon(candidate, panels):
    pg = candidate['polygon']; vs = list(map(readpoint, pg['vertices']))
    need(len(vs) == len(panels)+1 and vs[0] == vs[-1], 'one closed shared polygon')
    crossings = []
    for j,p in enumerate(panels):
        a,b = vs[j],vs[j+1]; r = ROTATIONS[p['rotation']]
        need(real_product(r,a)>0 and real_product(r,b)>0, 'both shared vertices in panel half-plane')
        det = a[0]*b[1]-a[1]*b[0]
        dot = a[0]*b[0]+a[1]*b[1]
        need(det != 0 or dot > 0, 'polygon segment excludes origin')
        if a[1] <= 0 < b[1] and det > 0: crossings.append(1)
        elif b[1] <= 0 < a[1] and det < 0: crossings.append(-1)
        else: crossings.append(0)
    need(crossings == pg['crossings'] and sum(crossings) == pg['winding'] == 0, 'exact half-open winding zero')
    return {'vertices': [point(z) for z in vs], 'crossings':crossings,'winding':0}


class Runtime:
    def __init__(self):
        self.start=time.monotonic(); self.peak=0
        import ctypes
        from ctypes import wintypes
        class Memory(ctypes.Structure):
            _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[(n,ctypes.c_size_t) for n in
                ('PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage',
                 'QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage')]
        self.ctypes=ctypes; self.Memory=Memory
        kernel=ctypes.WinDLL('kernel32'); kernel.GetCurrentProcess.restype=wintypes.HANDLE
        self.handle=kernel.GetCurrentProcess()
        self.get=ctypes.WinDLL('psapi').GetProcessMemoryInfo
        self.get.argtypes=[wintypes.HANDLE,ctypes.POINTER(Memory),wintypes.DWORD]
        self.get.restype=wintypes.BOOL
    def guard(self):
        need(time.monotonic()-self.start <= SECONDS, 'independent 300-second cap')
        p=self.Memory();p.cb=self.ctypes.sizeof(p)
        need(self.get(self.handle,self.ctypes.byref(p),p.cb), 'working-set measurement')
        self.peak=max(self.peak,p.PeakWorkingSetSize)
        need(self.peak <= MAX_MEMORY, '512-MiB working-set cap')


class Evaluator:
    def __init__(self, runtime):
        from flint import arb, acb, acb_series, ctx
        self.arb,self.acb,self.series=arb,acb,acb_series
        self.rt=runtime;ctx.prec=BITS;ctx.cap=K
        self.logs=[]
        for n in range(1,N+1):
            self.logs.append(self.ar(n).log())
            if n % 4096 == 0:self.rt.guard()
        self.lb=self.ar(B).log()
        bern=[Q(1)]
        for n in range(1,2*M+1):
            bern.append(-sum(Q(comb(n+1,k))*bern[k] for k in range(n))/Q(n+1))
        self.co=[self.ar(bern[2*k]/factorial(2*k)) for k in range(1,M+1)]
        self.powers=[self.ar(B)**(1-2*k) for k in range(1,M+1)]
    def ar(self,q):
        q=Q(q);return self.arb(str(q.numerator))/q.denominator
    def rb(self,z):return [str(z.lower().fmpq()),str(z.upper().fmpq())]
    def cb(self,z):return {'re':self.rb(z.real),'im':self.rb(z.imag)}
    def ri(self,lo,hi):
        need(lo<=hi,'ordered rational import')
        z=self.arb(self.ar((lo+hi)/2),self.ar((hi-lo)/2).upper())
        l,u=map(Q,self.rb(z));need(l<=lo<=hi<=u,'outward rational import')
        return z
    def ej(self,center,logarithm):
        # Scalar exp plus explicit Taylor-coefficient recurrence, no series exp.
        terms=[(-center*logarithm).exp()]
        for j in range(1,K):terms.append(terms[-1]*(-logarithm)/j)
        return self.series(terms,prec=K)
    def model(self,name,center,h):
        began=time.monotonic();cx,cy=center
        z=self.acb(self.ar(cx),self.ar(cy));s=self.series([z,1],prec=K)
        partial=self.series([0],prec=K)
        for i,l in enumerate(self.logs):
            partial+=self.ej(z,l)
            if i%4096==0:self.rt.guard()
        bp=self.ej(z,self.lb);rise=self.series([1],prec=K);corr=self.series([0],prec=K)
        for j in range(1,2*M):
            rise*=s+j-1
            if j%2:corr+=self.co[(j-1)//2]*self.powers[(j-1)//2]*rise
        g=(s-1)*(partial+bp*(corr+self.ar(Q(1,2))))+B*bp
        jet=[g[j] for j in range(K)]
        # Entire finite g only: no actual-zeta EM assertion on this outer disk.
        S=abs(z)+self.ar(OUTER);sigma=cx-OUTER
        main=self.ar(N)*(self.ar(1) if sigma>=0 else (-self.ar(sigma)*self.logs[-1]).exp())
        bpower=(-self.ar(sigma)*self.lb).exp();rise=self.ar(1);corr=self.ar(0)
        for j in range(1,2*M):
            rise*=S+j-1
            if j%2:corr+=abs(self.co[(j-1)//2])*self.powers[(j-1)//2]*rise
        outer=(S+1)*(main+bpower*(corr+self.ar(Q(1,2))))+B*bpower
        # EM floor 1/2 is asserted only at the actual tested panel points.
        Si=abs(z)+self.ar(h);rise=self.ar(1)
        for j in range(2*M):rise*=Si+j
        em=4*(Si+1)*rise*((self.ar(Q(1,2))-2*M)*self.lb).exp()/(6**(2*M)*self.ar(Q(2*M)-Q(1,2)))
        tail=outer*self.ar(h/OUTER)**K/(1-self.ar(h/OUTER))
        error=em+tail
        record={'name':name,'center':point(center),'target_radius':str(h),'outer_radius':str(OUTER),
                'coefficients_zetaF':[self.cb(v) for v in jet], 'outer_bound':self.rb(outer),
                'EM_error_zetaF':self.rb(em),'Taylor_error_zetaF':self.rb(tail),
                'seconds':time.monotonic()-began}
        return (center,h,jet,error),record
    def image(self,model,a,b):
        center,h,jet,error=model;cx,cy=center
        need(min(a[0],b[0])>=LEFT and max(a[0],b[0])<=RIGHT
             and min(a[1],b[1])>=BOTTOM and max(a[1],b[1])<=TOP,'actual-panel EM domain')
        need(all((x-cx)**2+(y-cy)**2<=h*h for x,y in (a,b)),'whole segment in fixed target disk')
        ss=self.acb(self.ri(min(a[0],b[0]),max(a[0],b[0])),self.ri(min(a[1],b[1]),max(a[1],b[1])))
        dz=self.acb(self.ri(min(a[0],b[0])-cx,max(a[0],b[0])-cx),self.ri(min(a[1],b[1])-cy,max(a[1],b[1])-cy))
        value=jet[-1]
        for coefficient in reversed(jet[:-1]):value=value*dz+coefficient
        er=self.arb(0,error.upper())
        need(Q(self.rb((ss-1).imag)[0])>0,'whole quotient denominator excludes zero')
        return self.cb((value+self.acb(er,er))/(ss-1))


def margin(box,rotation):
    if rotation=='1':return Q(box['re'][0])
    if rotation=='-1':return -Q(box['re'][1])
    if rotation=='i':return -Q(box['im'][1])
    if rotation=='-i':return Q(box['im'][0])
    raise ValueError('unknown rotation')


def authorized_inputs(path,candidate_path):
    auth=json.loads(path.read_text(encoding='utf-8'))
    need(auth.get('coordinator_authorized') is True and auth.get('target')==TARGET,'fresh fixed-target authorization')
    need(auth['independent_script_sha256']==sha(Path(__file__)),'independent script pin')
    need(auth['candidate_sha256']==sha(candidate_path),'frozen candidate pin')
    for rel,digest in PINS.items():need(sha(AGENTS/rel)==digest,'source pin '+rel)
    # Final reviews were not yet frozen when preparation began. The coordinator
    # must bind and read them before authorizing; their truth is not inferred here.
    for key in ('producer','analytic_plan_review','source_adapter','source_adapter_review'):
        entry=auth[key];need(sha(AGENTS/entry['path'])==entry['sha256'],'approved input '+key)
    data=json.loads(candidate_path.read_text(encoding='utf-8'))
    need(data['source_sha256']==auth['producer']['sha256'],'candidate producer binding')
    return auth,data


def execute(auth_path,candidate_path,output):
    need(output.resolve().parent==HERE and not output.exists(),'new owned output only')
    auth,candidate=authorized_inputs(auth_path,candidate_path)
    panels=geometry(candidate);pg=polygon(candidate,panels)
    rt=Runtime();out={'status':'INCOMPLETE','target':TARGET,'candidate_sha256':sha(candidate_path),
                     'input_pins':PINS,'authorization':auth,'N':N,'M':M,'K':K,'precision_bits':BITS,
                     'models':{},'panel_checks':[],'endpoint_boxes':{},'geometry_checked':True,'polygon':pg}
    progress=output.with_suffix('.progress.jsonl')
    try:
        with progress.open('x',encoding='utf-8') as log:
            ev=Evaluator(rt);models={}
            for name,center,h in specifications():
                rt.guard();model,record=ev.model(name,center,h)
                models[name]=model;out['models'][name]=record
                log.write(json.dumps({'completed_model':record})+'\n');log.flush()
            need(len(models)==13,'all top/bottom/left models recomputed')
            for index,p in enumerate(panels):
                rt.guard();a,b=readpoint(p['start']),readpoint(p['end'])
                if p['side']=='right':
                    need(p['rotation']=='1','analytic right edge supports positive real half-plane')
                    record={'index':index,'side':'right','rotation':'1','strict_margin_lower':'1/4',
                            'proof':'source absolute-convergence bound Re(zeta(2+it))>1/4'}
                else:
                    model=models[p['model']];box=ev.image(model,a,b)
                    lower=margin(box,p['rotation']);need(lower>0,'independent whole-panel half-plane')
                    record={'index':index,'model':p['model'],'start':p['start'],'end':p['end'],
                            'rotation':p['rotation'],'image_zeta':box,'strict_margin_lower':str(lower)}
                    # Every numerical incident endpoint receives its own full
                    # model enclosure. Shared surrogate vertices were checked
                    # exactly above; overlap of endpoint boxes is not a premise.
                    for z in (a,b):
                        endpoint=ev.image(model,z,z)
                        need(margin(endpoint,p['rotation'])>0,'independent endpoint half-plane')
                        key=';'.join(point(z))
                        out['endpoint_boxes'].setdefault(key,[]).append({'model':p['model'],'value':endpoint})
                out['panel_checks'].append(record)
                log.write(json.dumps({'completed_panel':record})+'\n');log.flush()
            need(len(out['panel_checks'])==len(panels),'every consumed panel checked')
            rt.guard();out['status']='PASS_ALL_13_MODELS_ALL_CONSUMED_PANELS_WINDING_ZERO'
    except (ValueError,RuntimeError,ArithmeticError) as exc:
        out['failure']=type(exc).__name__+': '+str(exc)
    finally:
        out['elapsed_seconds']=time.monotonic()-rt.start;out['peak_working_set_bytes']=rt.peak
        out['script_sha256']=sha(Path(__file__))
        out['scope']='External elementary interval arithmetic and reviewed EM/Taylor/local-winding analysis; no Lean or larger-height certificate'
        output.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':out['status'],'models':len(out['models']),
                      'panels':len(out['panel_checks']),'failure':out.get('failure')}))
    return 0 if out['status'].startswith('PASS_') else 2


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--authorize',type=Path,required=True)
    parser.add_argument('--candidate',type=Path,required=True)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    return execute(args.authorize,args.candidate,args.output)


if __name__=='__main__':raise SystemExit(main())
