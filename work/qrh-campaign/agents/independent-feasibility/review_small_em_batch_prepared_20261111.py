"""Prepared independent small EM batch verifier. No numerical work on import.

Execution requires a coordinator manifest and a frozen complete candidate.
No producer imports, FFT, builtin zeta/L/Gamma/theta/RS, retries or retuning.
Only AST/syntax checks are authorized during code preparation.
"""
from fractions import Fraction as Q
from pathlib import Path
from math import comb, factorial, gcd
import argparse
import hashlib
import json
import re
import time

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
N, B, M, K, P, J, L = 1024, 1025, 16, 16, 24, 8, 32
BITS = 224
SECONDS = 360
MEMORY = 512 * 1024**2
FILE_LIMIT = 64 * 1024**2
SIGMA, T0, DELTA, RHO = Q(629,1250), Q(31999,16), Q(-1,8), Q(1,16)
EPS = Q(1,2**110)
G_HALF = Q(1,2**52)
PINS = {
 'moebius/SMALL_EM_BATCH_PILOT_SPECIFICATION_2026-11-11.md':
 '3977881D20CFE9F948E850AC9A83CF50084AA1EF7D0B7023E5D1A95DE845B929',
 'major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md':
 '47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23',
 'integration/SMALL_EM_BATCH_RECEIPT_CONTRACT_2026-11-11.md':
 'DA2740C39148A2F1AB2291E6581B5C55A75BF33456E8006CB148B34B516178AF',
 'independent-feasibility/REVIEW_SMALL_EM_BATCH_PILOT_PREFLIGHT_2026-11-11.md':
 'E8D928EB25CA0AAB583609D33DF982CFC2A1D01E65890AE8BCBBB58C4BF9C7F0',
 'major-constants/em_small_batch_budget_20261111.py':
 '13E200EDFF99D2C44CFA19EEE8CC83C071488362E2DF3997D71E7A79BB65B59D',
 'major-constants/em_small_batch_budget_20261111.json':
 '41FF7A626495159CCEB34C19ED6426F480DEB9759962784885120E8B4E76E931',
 'moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md':
 '814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818',
 'independent-feasibility/REVIEW_FINITE_EM_VERTICAL_BATCHING_2026-11-11.md':
 'B8EE7250B9E2AAEE8099A7109C08FF34FBD70E880182E99E2B3F30970C49717E',
 'major-constants/EM_SOURCE_PROOF_PLAN_2026-11-11.md':
 'A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485',
 'moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md':
 '5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1',
 'major-constants/EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md':
 'ADE7149EE7D5C3586A2AA7267C39363828747D801DE5EF1F4508A21B737F69D3',
 'prime-estimates/REVIEW_EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md':
 '3A9150606721D555C130B29EB3AB5E324286925D76FB2F638105A846BDB8758E',
 'integration/FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md':
 '170C8F976A8AF8B299E4AB737E6924260B3B1D8328FA54C0F2BF7F6E9720F997',
 'audit/REVIEW_FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md':
 'F2DC3A12F4474E8469D45C741E0F1A7FBA5A1CAF61AEF6A1509749FDE8BFD406',
 'integration/small_em_batch_candidate_20261111.py':
 '23D358590279AA810EAE764D3FEEA0756C51DF8CF0EA6F05B457A192BB82822C',
 'integration/SMALL_EM_BATCH_CODE_PREPARATION_2026-11-11.md':
 '65379869F849BB27BE9DF4974F73984269FECF1C408C442D2C772BFF37E53500',
}
PRODUCER_PIN_KEYS = (
 'moebius/SMALL_EM_BATCH_PILOT_SPECIFICATION_2026-11-11.md',
 'independent-feasibility/REVIEW_SMALL_EM_BATCH_PILOT_PREFLIGHT_2026-11-11.md',
 'major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md',
 'major-constants/em_small_batch_budget_20261111.py',
 'major-constants/em_small_batch_budget_20261111.json',
 'integration/SMALL_EM_BATCH_RECEIPT_CONTRACT_2026-11-11.md',
 'moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md',
 'independent-feasibility/REVIEW_FINITE_EM_VERTICAL_BATCHING_2026-11-11.md',
 'integration/FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md',
 'audit/REVIEW_FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md',
)


def need(ok, reason):
    if not ok:
        raise ValueError(reason)


def keys(obj, required, optional=()):
    need(type(obj) is dict, 'object required')
    need(set(required) <= set(obj) <= set(required) | set(optional), 'object keys')


def exact_int(x, limit=16384):
    need(type(x) is int and x.bit_length() <= limit, 'bounded exact integer')
    return x


def decimal_int(x):
    need(type(x) is str and 1 <= len(x) <= 4096, 'bounded integer string')
    need(re.fullmatch(r'0|-?[1-9][0-9]*', x) is not None, 'canonical integer string')
    return exact_int(int(x))


def qr(x):
    keys(x, ('numerator','denominator'))
    n,d = decimal_int(x['numerator']),decimal_int(x['denominator'])
    need(d > 0 and gcd(n,d) == 1, 'reduced rational with positive denominator')
    return Q(n,d)


def qout(q):
    return {'numerator':str(q.numerator),'denominator':str(q.denominator)}


def dy(x):
    keys(x, ('mantissa','exponent'))
    m,e=decimal_int(x['mantissa']),exact_int(x['exponent'],15)
    need(abs(e) <= 8192 and m.bit_length() <= 4096, 'dyadic allocation cap before shift')
    need((m==0 and e==0) or m%2!=0, 'canonical dyadic mantissa/exponent')
    return Q(m*2**e) if e >= 0 else Q(m,2**(-e))


def rb(x):
    keys(x, ('mid','rad'))
    m,r=dy(x['mid']),dy(x['rad'])
    need(r >= 0, 'nonnegative radius')
    return (m-r,m+r)


def cb(x):
    keys(x, ('re','im'))
    return rb(x['re']),rb(x['im'])


def center(x):
    keys(x, ('re','im'))
    return dy(x['re']),dy(x['im'])


def rect(x):
    keys(x, ('re','im'))
    out=[]
    for axis in ('re','im'):
        keys(x[axis], ('lo','hi'))
        a,b=qr(x[axis]['lo']),qr(x[axis]['hi'])
        need(a <= b, 'ordered rational interval')
        out.append((a,b))
    return tuple(out)


def rout(z):
    return {a:{'lo':qout(v[0]),'hi':qout(v[1])} for a,v in zip(('re','im'),z)}


def add(a,b): return a[0]+b[0],a[1]+b[1]
def neg(a): return -a[1],-a[0]
def mul(a,b):
    vals=[x*y for x in a for y in b]
    return min(vals),max(vals)
def square(a):
    return (Q(0) if a[0]<=0<=a[1] else min(a[0]**2,a[1]**2),max(a[0]**2,a[1]**2))
def cadd(a,b): return add(a[0],b[0]),add(a[1],b[1])
def cmul(a,b):
    return add(mul(a[0],b[0]),neg(mul(a[1],b[1]))),add(mul(a[0],b[1]),mul(a[1],b[0]))
def cinv(z):
    den=add(square(z[0]),square(z[1]))
    need(den[0]>0, 'full denominator excludes zero')
    inv=(1/den[1],1/den[0])
    return mul(z[0],inv),mul(neg(z[1]),inv)
def singleton(a,b=Q(0)): return ((Q(a),Q(a)),(Q(b),Q(b)))


def exact_image(coeffs, owner, ylo, yhi, pad):
    t=T0+owner*DELTA
    z=((Q(0),Q(0)),(ylo-t,yhi-t))
    out=coeffs[-1]
    for a in reversed(coeffs[:-1]):
        out=cadd(cmul(out,z),a)
    out=(add(out[0],(-pad,pad)),add(out[1],(-pad,pad)))
    denominator=((SIGMA-1,SIGMA-1),(ylo,yhi))
    return cmul(out,cinv(denominator))


def unique_pairs(items):
    out={}
    for key,value in items:
        need(key not in out, 'duplicate JSON key')
        out[key]=value
    return out


def json_integer(s):
    need(len(s)<=1024, 'JSON integer digit cap')
    return exact_int(int(s))


def reject_constant(x):
    raise ValueError('nonfinite JSON constant '+x)


def load_json(path):
    need(path.is_file() and path.stat().st_size <= FILE_LIMIT, 'bounded input file')
    with path.open('rb') as handle:
        raw=handle.read(FILE_LIMIT+1)
    need(len(raw)<=FILE_LIMIT, 'input grew beyond cap')
    obj=json.loads(raw,object_pairs_hook=unique_pairs,parse_int=json_integer,
                   parse_constant=reject_constant)
    count=0
    def walk(x,depth=0):
        nonlocal count
        count+=1
        need(depth<=32 and count<=2000000, 'JSON shape resource cap')
        if type(x) is str: need(len(x)<=4096, 'JSON string cap')
        elif type(x) is int: exact_int(x)
        elif type(x) is float:
            need(x==x and abs(x)<1e100, 'finite bounded metadata float')
        elif type(x) is list:
            need(len(x)<=20000,'JSON array cap')
            for y in x: walk(y,depth+1)
        elif type(x) is dict:
            need(len(x)<=128,'JSON object cap')
            for k,v in x.items(): walk(k,depth+1);walk(v,depth+1)
        else: need(x is None or type(x) is bool, 'JSON type')
    walk(obj)
    return obj,hashlib.sha256(raw).hexdigest().upper()


def bound_path(s):
    need(type(s) is str and len(s)<=1024, 'bounded path')
    p=(AGENTS/s).resolve()
    need(p.is_relative_to(AGENTS.resolve()), 'path stays inside agents workspace')
    return p


def filehash(path):
    need(path.is_file() and path.stat().st_size<=FILE_LIMIT, 'bounded pinned file')
    with path.open('rb') as handle:
        data=handle.read(FILE_LIMIT+1)
    need(len(data)<=FILE_LIMIT,'pinned file grew beyond cap')
    return hashlib.sha256(data).hexdigest().upper()


def pinned(record):
    keys(record,('path','sha256'))
    p=bound_path(record['path'])
    need(type(record['sha256']) is str and re.fullmatch('[0-9A-F]{64}',record['sha256']), 'SHA256 form')
    need(filehash(p)==record['sha256'],'pinned bytes: '+record['path'])
    return p


class Runtime:
    def __init__(self):
        self.start=time.monotonic(); self.peak=0
        import ctypes
        from ctypes import wintypes
        class Memory(ctypes.Structure):
            _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[(name,ctypes.c_size_t) for name in
                ('PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage',
                 'QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage')]
        self.ctypes,self.Memory=ctypes,Memory
        kernel=ctypes.WinDLL('kernel32');kernel.GetCurrentProcess.restype=wintypes.HANDLE
        self.handle=kernel.GetCurrentProcess()
        self.get=ctypes.WinDLL('psapi').GetProcessMemoryInfo
        self.get.argtypes=[wintypes.HANDLE,ctypes.POINTER(Memory),wintypes.DWORD]
        self.get.restype=wintypes.BOOL

    def guard(self):
        p=self.Memory();p.cb=self.ctypes.sizeof(p)
        need(self.get(self.handle,self.ctypes.byref(p),p.cb), 'Windows peak-working-set telemetry unavailable')
        self.peak=max(self.peak,int(p.PeakWorkingSetSize))
        need(self.peak<=MEMORY, '512 MiB peak-working-set exceeded')
        need(time.monotonic()-self.start<=SECONDS,'360-second total cap exceeded')

    def telemetry(self):
        return {'elapsed_seconds':time.monotonic()-self.start,'peak_working_set_bytes':self.peak}


def validate(candidate, manifest, rt):
    required=('schema','status','parameters','pins','bins','moments','transforms','g_jets',
              'panels','endpoints','analytical_budget','producer_code_sha256','telemetry',
              'elementary','twiddles','main_jets','corrections')
    keys(candidate,required,('failure','software'))
    need(candidate['schema']=='small-em-batch-candidate-v1' and candidate['status']=='PASS','complete fixed candidate')
    need(candidate['producer_code_sha256']==manifest['producer_code']['sha256'],'producer code provenance')
    params=candidate['parameters']
    ints={'N':N,'B':B,'M':M,'K':K,'p':P,'J':J,'L':L,'precision_bits':192}
    rats={'sigma':SIGMA,'t0':T0,'Delta':DELTA,'outer_radius':Q(1),'panel_radius':RHO}
    keys(params,tuple(ints)+tuple(rats))
    for name,v in ints.items(): need(exact_int(params[name])==v,'fixed '+name)
    for name,v in rats.items(): need(qr(params[name])==v,'fixed '+name)
    need(candidate['pins']=={name:PINS[name] for name in PRODUCER_PIN_KEYS},'exact complete producer pin dictionary')
    telemetry=candidate['telemetry']
    need(type(telemetry) is dict,'producer telemetry')
    elapsed=telemetry.get('elapsed_seconds'); peak=telemetry.get('peak_working_set_bytes')
    need(type(elapsed) in (int,float) and 0<=elapsed<=180,'producer time cap')
    need(type(peak) is int and 0<peak<=MEMORY,'producer peak cap')
    budget=candidate['analytical_budget']
    keys(budget,('EM','Taylor'),('outer_finite_g_bound','full_quotient_error_budget',
                                'exact_image_rounding','coefficient_padding_added_twice'))
    em=Q(4*2003*33)*Q(2,63)*Q(2034,6*B)**32
    tay=Q(1,15*2**33)
    need(qr(budget['EM'])==em and qr(budget['Taylor'])==tay,'exact predivision analytical pads')
    if 'outer_finite_g_bound' in budget:
        need(qr(budget['outer_finite_g_bound'])==2**27,'fixed finite-g outer allowance')
    if 'full_quotient_error_budget' in budget:
        need(qr(budget['full_quotient_error_budget'])==Q(1540133,92233720368547758080),'fixed full quotient ledger')
    if 'exact_image_rounding' in budget:
        need(qr(budget['exact_image_rounding'])==0,'exact rational image arithmetic')
    if 'coefficient_padding_added_twice' in budget:
        need(budget['coefficient_padding_added_twice'] is False,'no coefficient double charge')
    for name,length in [('bins',N),('moments',K*P*L),('transforms',K*P*J),('g_jets',J),('panels',J),('endpoints',J+1)]:
        need(type(candidate[name]) is list and len(candidate[name])==length,'complete '+name)
    for idx,row in enumerate(candidate['bins']):
        keys(row,('n','x','mid','q','k','residual'))
        need(exact_int(row['n'])==idx+1,'ordered n')
        keys(row['x'],('lo','hi'))
        lo,hi=qr(row['x']['lo']),qr(row['x']['hi']); mid=qr(row['mid'])
        need(lo<=hi and hi-lo<=Q(1,4) and mid==(lo+hi)/2,'rational bin witness width/midpoint')
        q=exact_int(row['q']);k=exact_int(row['k'])
        need(-5<=q<=0 and q==(mid+Q(1,2)).__floor__() and k==q%L,'full signed bin label')
        rb(row['residual'])
        if idx%64==0:rt.guard()
    for name,width,coord in [('moments',L,'k'),('transforms',J,'j')]:
        for idx,row in enumerate(candidate[name]):
            required=('h','m',coord,'center','radius')+(('index',) if name=='transforms' else ())
            keys(row,required,('computed',))
            h,rem=divmod(idx,P*width);m,v=divmod(rem,width)
            need((exact_int(row['h']),exact_int(row['m']),exact_int(row[coord]))==(h,m,v),'canonical complete indexed '+name)
            if name=='transforms': need(exact_int(row['index'])==(-v)%L,'transform sign/index')
            c=center(row['center']);r=dy(row['radius'])
            need(r in (Q(0),EPS),'fixed Euclidean radius')
            if r==0:need(c==(Q(0),Q(0)),'zero radius only for an exact zero entry')
            if 'computed' in row:
                box=cb(row['computed'])
                distance=sum(max(abs(box[a][0]-c[a]),abs(box[a][1]-c[a])) for a in (0,1))
                need(distance<=r,'full producer computed box fits claimed disk')
            if idx%128==0:rt.guard()
    jets=[]
    for j,row in enumerate(candidate['g_jets']):
        keys(row,('j','center','coefficients'))
        keys(row['center'],('re','im'))
        need(exact_int(row['j'])==j and qr(row['center']['re'])==SIGMA and qr(row['center']['im'])==T0+j*DELTA,'exact g center')
        need(type(row['coefficients']) is list and len(row['coefficients'])==K,'all normalized g orders')
        coeffs=[]
        for a in row['coefficients']:
            box=cb(a)
            need(dy(a['re']['rad'])==dy(a['im']['rad'])==G_HALF,'fixed g coordinate halfwidth')
            coeffs.append(box)
        jets.append(coeffs)
    for j,row in enumerate(candidate['panels']):
        keys(row,('index','owner','top','bottom','image'))
        need(exact_int(row['index'])==exact_int(row['owner'])==j,'panel owner')
        need(qr(row['top'])==2000-Q(j,8) and qr(row['bottom'])==2000-Q(j+1,8),'exact closed panel')
        rect(row['image'])
    for l,row in enumerate(candidate['endpoints']):
        keys(row,('index','owner','height','image'))
        need(exact_int(row['index'])==l and exact_int(row['owner'])==min(l,7),'endpoint owner')
        need(qr(row['height'])==2000-Q(l,8),'exact endpoint')
        rect(row['image'])
    return jets,em+tay


def diagnostic_schema(candidate,rt):
    """Check required shapes/budgets; these are not an independent proof of every internal ball."""
    def seq(x,length):
        need(type(x) is list and len(x)==length,'diagnostic array length')
    def error(x):
        q=qr(x);need(q>=0,'nonnegative diagnostic error');return q
    el=candidate['elementary']
    keys(el,('pi','log_B','logs','base_weights','bin_counts'))
    rb(el['pi']);rb(el['log_B']);seq(el['logs'],N);seq(el['base_weights'],N);seq(el['bin_counts'],L)
    counts=[0]*L
    for j,row in enumerate(el['logs']):
        keys(row,('n','value'));need(exact_int(row['n'])==j+1,'diagnostic log order');rb(row['value'])
        cb(el['base_weights'][j]);counts[candidate['bins'][j]['k']]+=1
    need([exact_int(x) for x in el['bin_counts']]==counts,'complete bin partition counts')
    need(rb(el['logs'][0]['value'])==(Q(0),Q(0)) and cb(el['base_weights'][0])==singleton(1),'exact n=1 inputs')
    seq(candidate['twiddles'],31)
    labels=[(length,r) for length in (2,4,8,16,32) for r in range(length//2)]
    for row,(length,r) in zip(candidate['twiddles'],labels):
        keys(row,('length','r','value'))
        need((exact_int(row['length']),exact_int(row['r']))==(length,r),'positive twiddle stage order');cb(row['value'])
    seq(candidate['main_jets'],K)
    for h,row in enumerate(candidate['main_jets']):
        keys(row,('h','values'));need(exact_int(row['h'])==h,'main jet order');seq(row['values'],J)
        for j,v in enumerate(row['values']):
            keys(v,('j','center','contraction','contraction_error','source_input_error',
                    'transform_error','residual_taylor_error','total_error'))
            need(exact_int(v['j'])==j,'main center index')
            c=center(v['center']);box=cb(v['contraction']);y=Q(j,J)
            source=Q(0);transform=Q(0);exact=[Q(0),Q(0)]
            for m in range(P):
                weight=y**m
                source+=weight*sum(dy(a['radius']) for a in candidate['moments'][(h*P+m)*L:(h*P+m+1)*L])
                tf=candidate['transforms'][(h*P+m)*J+j]
                transform+=L*weight*dy(tf['radius'])
                z=center(tf['center'])
                for axis in (0,1):exact[axis]+=L*weight*z[axis]
            need(all(box[a][0]<=exact[a]<=box[a][1] for a in (0,1)),'exact rational contraction lies in recorded arithmetic ball')
            contraction=error(v['contraction_error'])
            distance=sum(max(abs(box[a][0]-c[a]),abs(box[a][1]-c[a])) for a in (0,1))
            need(distance<=contraction<=Q(1,2**100),'whole contraction ball error allocation')
            residual=Q(64*7**h,factorial(h)*factorial(P))
            need(error(v['source_input_error'])==source and error(v['transform_error'])==transform,'separated input/transform errors')
            need(error(v['residual_taylor_error'])==residual,'all-jet residual tail')
            need(error(v['total_error'])==source+transform+contraction+residual,'complete main error sum')
            need(source+transform+contraction<Q(1,2**98),'main arithmetic cap')
        rt.guard()
    cor=candidate['corrections']
    keys(cor,('bernoulli','log_B_coefficients','base','step','base_center','step_center',
              'base_error','step_error','A_B_upper','phases','rows'))
    seq(cor['bernoulli'],M);seq(cor['log_B_coefficients'],K);seq(cor['phases'],J);seq(cor['rows'],J)
    bn=[Q(1)]
    for n in range(1,2*M+1):bn.append(-sum(Q(comb(n+1,k))*bn[k] for k in range(n))/Q(n+1))
    for k,v in enumerate(cor['bernoulli'],1):
        keys(v,('k','bernoulli','factor'))
        need(exact_int(v['k'])==k and qr(v['bernoulli'])==bn[2*k] and
             qr(v['factor'])==bn[2*k]*Q(B)**(1-2*k)/factorial(2*k),'exact correction constants')
    for x in cor['log_B_coefficients']:rb(x)
    cb(cor['base']);cb(cor['step']);center(cor['base_center']);center(cor['step_center'])
    base_error,step_error=error(cor['base_error']),error(cor['step_error'])
    need(qr(cor['A_B_upper'])==1,'fixed B-phase magnitude bound')
    previous=base_error
    for j,v in enumerate(cor['phases']):
        keys(v,('j','center','error','point_product','rounding_error'))
        need(exact_int(v['j'])==j,'phase order');center(v['center'])
        rounding=error(v['rounding_error']);claimed=error(v['error'])
        if j==0:
            need(v['point_product'] is None and rounding==0 and claimed==base_error,'initial phase error')
        else:
            cb(v['point_product'])
            need(claimed==(1+step_error)*previous+step_error+rounding,'phase recurrence error')
        previous=claimed
    for j,row in enumerate(cor['rows']):
        keys(row,('j','R','Q','C','centers','errors','products','assembly','full_g_errors'))
        need(exact_int(row['j'])==j,'correction row order')
        for name in ('R','Q','C','centers','errors','products','assembly','full_g_errors'):seq(row[name],K)
        for h in range(K):
            for name in ('R','Q','C'):cb(row[name][h])
            center(row['centers'][h])
            need(error(row['errors'][h])<=Q(1,2**80),'complete correction error cap')
            need(error(row['full_g_errors'][h])<Q(1,2**53),'complete finite-g coefficient cap')
            v=row['products'][h]
            keys(v,('h','C_center','C_error','point_product','rounding_error'))
            need(exact_int(v['h'])==h,'correction product index')
            center(v['C_center']);error(v['C_error']);cb(v['point_product']);error(v['rounding_error'])
            v=row['assembly'][h]
            keys(v,('h','point_assembly','rounding_error'))
            need(exact_int(v['h'])==h,'assembly index');cb(v['point_assembly'])
            need(error(v['rounding_error'])<=Q(1,2**80),'assembly error cap')
        rt.guard()


class Numerical:
    def __init__(self, runtime):
        from flint import arb, acb, ctx, __version__
        ctx.prec=BITS
        self.arb,self.acb,self.ctx,self.rt=arb,acb,ctx,runtime
        self.version=__version__

    def ar(self,q):
        q=Q(q)
        return self.arb(str(q.numerator))/q.denominator

    def z(self,re,im=Q(0)): return self.acb(self.ar(re),self.ar(im))

    def exact_part(self,x):
        need(x.is_finite() and x.is_exact(),'exact finite computed dyadic required')
        m,e=x.man_exp();m,e=int(m),int(e)
        need(abs(e)<=8192 and m.bit_length()<=4096,'computed dyadic cap before shift')
        if m==0:
            e=0
        else:
            while m%2==0:
                m//=2;e+=1
            need(abs(e)<=8192,'normalized computed dyadic exponent cap')
        return {'mantissa':str(m),'exponent':e}

    def real_payload(self,x):
        need(x.is_finite(),'nonfinite numerical real ball')
        return {'mid':self.exact_part(x.mid()),'rad':self.exact_part(x.rad())}

    def payload(self,z):
        return {'re':self.real_payload(z.real),'im':self.real_payload(z.imag)}

    def box(self,z): return cb(self.payload(z))

    def contain_disk(self,z,row,label):
        payload=self.payload(z); box=cb(payload);c=center(row['center']);r=dy(row['radius'])
        # All four corners are bounded by the L1 maximum, so the entire rectangle fits.
        distance=sum(max(abs(box[a][0]-c[a]),abs(box[a][1]-c[a])) for a in (0,1))
        need(distance<=r,'full independent box not contained in '+label)
        return {'box':payload,'L1_distance_upper':qout(distance),'claimed_radius':qout(r)}

    def inputs(self,candidate,out):
        self.pi=self.arb.pi(); self.logs=[]; self.residuals=[]
        for idx,row in enumerate(candidate['bins']):
            n=idx+1
            log=self.arb(0) if n==1 else self.ar(n).log()
            x=L*self.ar(DELTA)*log/(2*self.pi)
            xi=rb(self.real_payload(x));lo,hi=qr(row['x']['lo']),qr(row['x']['hi'])
            need(lo<=xi[0]<=xi[1]<=hi,'independent actual x contained in bin witness')
            residual=J*(self.ar(DELTA)*log-2*self.pi*row['q']/L)
            ri=rb(self.real_payload(residual));claimed=rb(row['residual'])
            need(claimed[0]<=ri[0]<=ri[1]<=claimed[1],'independent actual residual inclusion')
            need(max(abs(ri[0]),abs(ri[1]))<Q(55,56),'actual real residual bound')
            out.append({'n':n,'q':row['q'],'k':row['k'],
                        'x':self.real_payload(x),'residual':self.real_payload(residual)})
            self.logs.append(log);self.residuals.append(residual)
            if n%32==0:self.rt.guard()
        self.lb=self.ar(B).log()
        self.rt.guard()

    def moments(self,candidate,out):
        arrays=[self.acb(0) for _ in range(K*P*L)]
        c0=self.z(SIGMA,T0)
        # n-major accumulation; cache each n's h and m factors only for that n.
        for idx,log in enumerate(self.logs):
            w=[(-c0*log).exp()]
            for h in range(1,K):w.append(w[-1]*(-log)/h)
            v=[self.acb(1)]
            r=self.acb(0,self.residuals[idx])
            for m in range(1,P):v.append(v[-1]*(-r)/m)
            k=candidate['bins'][idx]['k']
            for h in range(K):
                for m in range(P):
                    pos=(h*P+m)*L+k
                    arrays[pos]+=w[h]*v[m]
            if idx%8==0:self.rt.guard()
        for idx,(z,row) in enumerate(zip(arrays,candidate['moments'])):
            out.append(self.contain_disk(z,row,'moment '+str(idx)))
            if idx%64==0:self.rt.guard()
        del arrays

    def direct_transforms(self,candidate,out):
        roots=[self.acb(1)]
        for k in range(1,L):roots.append(self.acb(0,2*self.pi*k/L).exp())
        for line in range(K*P):
            values=[]
            for row in candidate['moments'][line*L:(line+1)*L]:
                a,b=center(row['center']);values.append(self.z(a,b))
            for j in range(J):
                index=(-j)%L
                result=self.acb(0)
                for k in range(L):result+=values[k]*roots[(index*k)%L]
                result/=L
                row=candidate['transforms'][line*J+j]
                out.append(self.contain_disk(result,row,'direct normalized transform '+str(line*J+j)))
            self.rt.guard()

    def direct_g(self,candidate,out):
        bern=[Q(1)]
        for n in range(1,2*M+1):
            bern.append(-sum(Q(comb(n+1,k))*bern[k] for k in range(n))/Q(n+1))
        need(bern[2]==Q(1,6),'Bernoulli convention')
        factors=[bern[2*k]*Q(B)**(1-2*k)/factorial(2*k) for k in range(1,M+1)]
        for j in range(J):
            c=self.z(SIGMA,T0+j*DELTA)
            main=[self.acb(0) for _ in range(K)]
            for idx,log in enumerate(self.logs):
                v=(-c*log).exp()
                for h in range(K):
                    main[h]+=v
                    if h+1<K:v=v*(-log)/(h+1)
                if idx%32==0:self.rt.guard()
            rising=[self.acb(1)]+[self.acb(0) for _ in range(K-1)]
            A=[self.acb(0) for _ in range(K)]
            for length in range(1,2*M):
                old=rising
                rising=[(c+length-1)*old[h]+(old[h-1] if h else 0) for h in range(K)]
                if length%2:
                    f=self.ar(factors[(length-1)//2])
                    for h in range(K):A[h]+=f*rising[h]
            eb=[(-c*self.lb).exp()]
            # Separate pole-removal exponential rather than B times eb[0].
            hp=[((1-c)*self.lb).exp()]
            for h in range(1,K):
                eb.append(eb[-1]*(-self.lb)/h)
                hp.append(hp[-1]*(-self.lb)/h)
            D=[]
            for h in range(K):
                d=main[h]+eb[h]/2
                for r in range(h+1):d+=eb[r]*A[h-r]
                D.append(d)
            row=[]
            for h in range(K):
                g=(c-1)*D[h]+(D[h-1] if h else 0)+hp[h]
                payload=self.payload(g);box=cb(payload)
                expected=cb(candidate['g_jets'][j]['coefficients'][h])
                need(all(expected[a][0]<=box[a][0]<=box[a][1]<=expected[a][1] for a in (0,1)),
                     'full independent direct g containment j='+str(j)+' h='+str(h))
                row.append(payload)
            out.append({'j':j,'coefficients':row})
            self.rt.guard()


def verify_images(candidate,jets,pad,rt):
    results={'panels':[],'endpoints':[]}
    for j,row in enumerate(candidate['panels']):
        result=exact_image(jets[j],j,qr(row['bottom']),qr(row['top']),pad)
        need(result==rect(row['image']),'exact complete panel image equality '+str(j))
        results['panels'].append({'index':j,'image':rout(result)})
        rt.guard()
    for l,row in enumerate(candidate['endpoints']):
        owner=min(l,7);y=qr(row['height'])
        result=exact_image(jets[owner],owner,y,y,pad)
        need(result==rect(row['image']),'exact endpoint image equality '+str(l))
        results['endpoints'].append({'index':l,'owner':owner,'image':rout(result)})
        rt.guard()
    return results


def run(manifest_path):
    rt=Runtime()
    need(manifest_path.is_relative_to(AGENTS.resolve()),'coordinator manifest in agents workspace')
    manifest,_=load_json(manifest_path)
    keys(manifest,('schema','authorize','independent_code_sha256','producer_code','candidate',
                   'static_review','pins','output'))
    need(manifest['schema']=='small-em-batch-independent-run-v1' and
         manifest['authorize']=='RUN_ONE_SMALL_EM_BATCH_REVIEW','explicit coordinator authorization')
    need(manifest['independent_code_sha256']==filehash(Path(__file__)),'independent frozen code')
    need(manifest['pins']==PINS,'exact independent source/contract pin set')
    for name,pin in PINS.items():
        need(filehash(bound_path(name))==pin,'fixed source '+name)
        rt.guard()
    producer_name='integration/small_em_batch_candidate_20261111.py'
    need(manifest['producer_code']=={'path':producer_name,'sha256':PINS[producer_name]},'frozen producer/schema binding')
    pinned(manifest['producer_code']);pinned(manifest['static_review'])
    candidate_path=pinned(manifest['candidate'])
    output=bound_path(manifest['output'])
    need(output.parent==HERE and output.suffix=='.json','owned new JSON output')
    need(not output.exists(),'no overwrite')
    # Exclusive reservation creates one bounded attempt; all following writes own this handle.
    with output.open('xb+') as handle:
        handle.write(b'{"status":"INCOMPLETE","reason":"reserved bounded attempt"}\n');handle.flush()
        result={'schema':'small-em-batch-independent-review-v1','status':'INCOMPLETE',
                'pins':PINS,'manifest':manifest,'precision_bits':BITS,
                'bin_checks':[],'moments':[],'transforms':[],'direct_g':[],'scope':
                'External elementary FLINT interval review; no spectral or Lean claim.'}
        try:
            candidate,candidate_hash=load_json(candidate_path)
            need(candidate_hash==manifest['candidate']['sha256'],'candidate unchanged during read')
            jets,pad=validate(candidate,manifest,rt)
            rt.guard()
            diagnostic_schema(candidate,rt)
            numerical=Numerical(rt)
            result['software']={'flint_module':numerical.version}
            numerical.inputs(candidate,result['bin_checks'])
            numerical.moments(candidate,result['moments'])
            numerical.direct_transforms(candidate,result['transforms'])
            numerical.direct_g(candidate,result['direct_g'])
            result['images']=verify_images(candidate,jets,pad,rt)
            need((len(result['bin_checks']),len(result['moments']),len(result['transforms']),len(result['direct_g']),
                  len(result['images']['panels']),len(result['images']['endpoints']))==(1024,12288,3072,8,8,9),'all consumed outputs checked')
            need(filehash(candidate_path)==candidate_hash,'candidate unchanged after review')
            rt.guard()
            result['status']='PASS_INDEPENDENT_SMALL_EM_BATCH'
            result['counts']={'bin_witnesses':1024,'moments':12288,'direct_normalized_transforms':3072,'direct_g_jets':128,'panels':8,'endpoints':9}
        except BaseException as exc:
            result['status']='FAIL_INDEPENDENT_SMALL_EM_BATCH'
            result['failure']=type(exc).__name__+': '+str(exc)[:2000]
        # Serialize inside the same caps. A post-write cap failure replaces only this
        # exclusively reserved attempt with a small failure record, never another file.
        try:
            rt.guard()
            # Serialize the complete large payload first. The telemetry footer is a
            # snapshot after that serialization, before publication. The guard after
            # publication and stdout record additionally include footer/write costs.
            payload=json.dumps(result,separators=(',',':'),allow_nan=False).encode('utf-8')
            rt.guard()
            footer=json.dumps({'telemetry':rt.telemetry(),
                'telemetry_snapshot_phase':'after_payload_serialization_before_publication'},
                separators=(',',':'),allow_nan=False).encode('utf-8')
            encoded=payload[:-1]+b','+footer[1:]+b'\n'
            need(len(encoded)<=FILE_LIMIT,'64 MiB independent receipt cap')
            receipt_hash=hashlib.sha256(encoded).hexdigest().upper()
            rt.guard()
            handle.seek(0);handle.write(encoded);handle.truncate();handle.flush()
            need(handle.tell()==len(encoded) and output.stat().st_size==len(encoded),'complete binary receipt write')
            rt.guard()
        except BaseException as exc:
            result={'schema':'small-em-batch-independent-review-v1','status':'FAIL_RESOURCE_OR_SERIALIZATION',
                    'failure':type(exc).__name__+': '+str(exc)[:2000],
                    'telemetry':rt.telemetry(),'manifest':manifest,'pins':PINS}
            encoded=(json.dumps(result,separators=(',',':'),allow_nan=False)+'\n').encode('utf-8')
            need(len(encoded)<=FILE_LIMIT,'bounded failure record')
            receipt_hash=hashlib.sha256(encoded).hexdigest().upper()
            handle.seek(0);handle.write(encoded);handle.truncate();handle.flush()
    # Acceptance also requires this final binding record and process exit zero.
    # A killed/interrupted process cannot authenticate a merely PASS-looking file.
    print(json.dumps({'status':result['status'],'output':str(output),
                      'receipt_sha256':receipt_hash,
                      'candidate_sha256':manifest['candidate']['sha256'],
                      'independent_code_sha256':manifest['independent_code_sha256'],
                      'telemetry':rt.telemetry()}),flush=True)
    return result['status']=='PASS_INDEPENDENT_SMALL_EM_BATCH'


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--manifest',required=True)
    args=parser.parse_args()
    try:
        ok=run(Path(args.manifest).resolve())
    except BaseException as exc:
        print(json.dumps({'status':'FAIL_BEFORE_OR_DURING_ATTEMPT','reason':type(exc).__name__+': '+str(exc)[:2000]}),flush=True)
        ok=False
    raise SystemExit(0 if ok else 1)
