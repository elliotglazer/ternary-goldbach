"""Prepared rational direct-g j7 producer. No evaluator runs on import.

Execution requires a new coordinator manifest and external supervisor. A worker
CANDIDATE is not combined acceptance or a Lean theorem. Integer/Fraction math only.
"""
from fractions import Fraction as Q
from math import comb, factorial, gcd
from pathlib import Path
import argparse
import ctypes
from ctypes import wintypes
import hashlib
import json
import os
import sys
import time

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
SCHEMA = 'rational-direct-g-j7-v1'
TARGET_NAME = 'small_em_batch_candidate_20261111_01.json'
TARGET_SHA = '2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E'
SECONDS, MEMORY, OUTPUT_CAP = 600, 512 * 1024 * 1024, 16 * 1024 * 1024
MAX_BITS, MAX_EXPONENT = 65536, 32768
N, B, M, K = 1024, 1025, 16, 16
PINS = {
 'major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md':
 '8AE42550658C25548352161EBBB8A1FDCBC967F7E32772C9D2FF1826AAACEEC2',
 'zero-sum/REVIEW_RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md':
 '0ED13860F941BE3786D9EE780F71590581D2C658BF30B84A8CE79AF383ABE4ED',
 'major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md':
 '60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9',
 'zero-sum/REVIEW_FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md':
 'E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B',
 'major-constants/FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md':
 '50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541',
 'major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md':
 '47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23',
 'integration/FINITE_EM_RATIONAL_CHECKER_BLUEPRINT_2026-11-11.md':
 'F6B784776E24F767FA3A45C3006394F0E718FF491712077FC9EBDC74EDE92F22',
 'audit/REVIEW_FINITE_EM_RATIONAL_CHECKER_BLUEPRINT_2026-11-11.md':
 'C62EEA09A4C1871E15FAB18EB3A3525777022E106F1AB39318F674D0272B448F',
 'independent-feasibility/FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md':
 '19DB61735647D0267954692733C2CF045B977D540A4CF55B5DBDB1145EE82CB8',
 'zero-sum/REVIEW_FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md':
 '022C335200DCD43E6E9639E978F122F5619199B3EBCC2B98F7B997C1328C8D8E',
 'moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md':
 'EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B',
 'prime-estimates/REVIEW_SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md':
 'F0D115608E1742220E4CAB26EA8DA930D24F2D1D410ED34609EA7B7DC4DABDA5',
}


class Reject(Exception):
    pass


def need(ok, message):
    if not ok:
        raise Reject(message)


def integer(n):
    need(type(n) is int and abs(n).bit_length() <= MAX_BITS, 'integer type/bit bound')
    return n


def rat(x):
    x = Q(x)
    integer(x.numerator); integer(x.denominator)
    return x


def raw_mul(a,b):
    integer(a);integer(b)
    if a and b:
        need(abs(a).bit_length()+abs(b).bit_length()-1<=MAX_BITS,'raw integer product bit bound')
    return integer(a*b)


def add(a, b):
    a,b=rat(a),rat(b)
    n=integer(raw_mul(a.numerator,b.denominator)+raw_mul(b.numerator,a.denominator))
    return rat(Q(n,raw_mul(a.denominator,b.denominator)))
def sub(a, b): return add(a,-rat(b))
def mul(a, b):
    a,b=rat(a),rat(b)
    return rat(Q(raw_mul(a.numerator,b.numerator),raw_mul(a.denominator,b.denominator)))
def div(a, b):
    a,b=rat(a),rat(b);need(b != 0, 'zero rational divisor')
    return rat(Q(raw_mul(a.numerator,b.denominator),raw_mul(a.denominator,b.numerator)))
def two(e):
    need(type(e) is int and abs(e) <= MAX_EXPONENT, 'power exponent bound')
    return Q(1 << e) if e >= 0 else Q(1, 1 << (-e))
def zero(): return Q(0), Q(0)
def one(): return Q(1), Q(0)
def cadd(a, b): return add(a[0], b[0]), add(a[1], b[1])
def csub(a, b): return sub(a[0], b[0]), sub(a[1], b[1])
def cmul(a, b): return sub(mul(a[0], b[0]), mul(a[1], b[1])), add(mul(a[0], b[1]), mul(a[1], b[0]))
def scale(a, x): return mul(a[0], x), mul(a[1], x)
def l1(a): return add(abs(a[0]), abs(a[1]))
def center(): return Q(629, 1250), Q(31985, 16)


def qwire(x):
    x = rat(x)
    return {'numerator': str(x.numerator), 'denominator': str(x.denominator)}


def dwire(x):
    x = rat(x); d = x.denominator; n = x.numerator
    need(d & (d-1) == 0, 'non-dyadic wire value')
    if n == 0: return {'mantissa': '0', 'exponent': 0}
    e = -(d.bit_length()-1)
    while n % 2 == 0: n //= 2; e += 1
    need(abs(e) <= MAX_EXPONENT, 'wire exponent bound')
    return {'mantissa': str(n), 'exponent': e}


def cpwire(z): return dict(re=dwire(z[0]), im=dwire(z[1]))
def cqwire(z): return dict(re=qwire(z[0]), im=qwire(z[1]))


def parsed_int(s):
    need(type(s) is str and 1 <= len(s) <= 20000, 'integer string bound')
    need(s == '0' or (s[0] == '-' and len(s)>1 and s[1] != '0' and s[1:].isascii() and s[1:].isdigit())
         or (s[0] in '123456789' and s.isascii() and s.isdigit()), 'canonical integer string')
    n = integer(int(s)); need(str(n) == s, 'noncanonical integer'); return n


def qread(d):
    need(type(d) is dict and set(d) == {'numerator', 'denominator'}, 'rational schema')
    n, den = parsed_int(d['numerator']), parsed_int(d['denominator'])
    need(den > 0 and gcd(n, den) == 1, 'reduced positive denominator')
    return Q(n, den)


def dread(d):
    need(type(d) is dict and set(d) == {'mantissa', 'exponent'}, 'dyadic schema')
    n, e = parsed_int(d['mantissa']), d['exponent']
    need(type(e) is int and abs(e) <= MAX_EXPONENT, 'dyadic exponent guard before shift')
    need((n == 0 and e == 0) or (n != 0 and n % 2 != 0), 'canonical dyadic')
    need(abs(n).bit_length() + max(e, 0) <= MAX_BITS, 'dyadic expanded numerator bound')
    return mul(Q(n), two(e))


def cpread(d):
    need(type(d) is dict and set(d) == {'re', 'im'}, 'complex point schema')
    return dread(d['re']), dread(d['im'])


def same(a, b):
    if type(a) is not type(b): return False
    if type(a) is dict: return set(a) == set(b) and all(same(a[k], b[k]) for k in a)
    if type(a) is list: return len(a) == len(b) and all(same(x, y) for x, y in zip(a, b))
    return a == b


def unique(pairs):
    out = {}
    for k, v in pairs:
        need(k not in out, 'duplicate JSON key'); out[k] = v
    return out


def read_json(path, cap):
    need(path.stat().st_size <= cap, 'input size bound before read')
    with path.open('rb') as stream: raw = stream.read(cap+1)
    need(len(raw) <= cap, 'input size bound')
    return json.loads(raw, object_pairs_hook=unique,
                      parse_constant=lambda s: (_ for _ in ()).throw(Reject('nonfinite JSON')))


def sha(path):
    digest = hashlib.sha256()
    with Path(path).open('rb') as stream:
        while True:
            chunk = stream.read(65536)
            if not chunk: break
            digest.update(chunk)
    return digest.hexdigest().upper()


def params():
    return dict(N=N, B=B, M=M, K=K, j=7, center=cqwire(center()),
                outer_radius=qwire(1), panel_radius=qwire(Q(1,16)))


def recipe():
    return dict(name='horner-j7-v1', rounding='floor(x*2^g+1/2); ties toward +infinity',
                inner_grid=1041, canonical_grid=1025, outer_grid=513,
                log_terms=512, atan_terms=256, exp_terms=513, real_squarings=4,
                raw_log2_cache=True, log_order='n ascending; all512 updates except n1',
                head_order='n ascending', normalization='complex-s derivative / h!',
                period='floor(theta/(2*pi_hat)+1/2)', digest='sha256 real-gate (g,p,q,m,remainder) decimal lines',
                finite_g_rounds=['completed head', 'completed full correction', 'assembled g'])


def analytical_budget():
    return dict(EM=qwire(Q(4*2003*33)/Q(63,2)*Q(2034,6*1025)**32),
                Taylor=qwire(Q(1,15)*two(-33)))


def radd(a,b): return add(a[0],b[0]),add(a[1],b[1])
def rneg(a): return -a[1],-a[0]
def rsub(a,b): return radd(a,rneg(b))
def rmul(a,b):
    v=[mul(x,y) for x in a for y in b]; return min(v),max(v)
def rsquare(a):
    v=[mul(x,x) for x in a]
    return (Q(0) if a[0]<=0<=a[1] else min(v)),max(v)
def rdiv(a,b):
    need(b[0]>0,'positive rectangle denominator')
    v=[div(x,y) for x in a for y in b];return min(v),max(v)
def rcadd(a,b): return radd(a[0],b[0]),radd(a[1],b[1])
def rcmul(a,b): return rsub(rmul(a[0],b[0]),rmul(a[1],b[1])),radd(rmul(a[0],b[1]),rmul(a[1],b[0]))
def rcinv(a):
    den=radd(rsquare(a[0]),rsquare(a[1]));need(den[0]>0,'nonzero whole denominator')
    return rdiv(a[0],den),rdiv(rneg(a[1]),den)
def rectwire(a): return {k:{'lo':qwire(lo),'hi':qwire(hi)} for k,(lo,hi) in zip(('re','im'),a)}
def rectread(a):
    need(type(a) is dict and set(a)=={'re','im'},'rectangle keys')
    out=[]
    for k in ('re','im'):
        need(set(a[k])=={'lo','hi'},'rectangle axis keys')
        lo,hi=qread(a[k]['lo']),qread(a[k]['hi']);need(lo<=hi,'ordered rectangle');out.append((lo,hi))
    return tuple(out)
def old_box(a):
    need(type(a) is dict and set(a)=={'re','im'},'old square keys')
    out=[]
    for k in ('re','im'):
        need(set(a[k])=={'mid','rad'},'old coordinate ball keys')
        mid,rad=dread(a[k]['mid']),dread(a[k]['rad'])
        need(rad==two(-52),'immutable old radius');out.append((sub(mid,rad),add(mid,rad)))
    return tuple(out)


def validate_target(t):
    need(type(t) is dict and set(t)=={'sha256','g_jets','panel','endpoints','analytical_budget'},'target fields')
    need(t['sha256']==TARGET_SHA,'target source hash')
    row=t['g_jets'];need(set(row)=={'j','center','coefficients'},'old g row fields')
    need(type(row['j']) is int and row['j']==7 and same(row['center'],cqwire(center())),'exact j7 center')
    need(type(row['coefficients']) is list and len(row['coefficients'])==16,'all16 old squares')
    for box in row['coefficients']:old_box(box)
    p=t['panel'];need(set(p)=={'index','owner','top','bottom','image'},'panel fields')
    need(type(p['index']) is int and type(p['owner']) is int and p['index']==p['owner']==7,'panel index/owner')
    need(qread(p['top'])==Q(15993,8) and qread(p['bottom'])==1999,'panel closed heights');rectread(p['image'])
    need(type(t['endpoints']) is list and len(t['endpoints'])==2,'two endpoints')
    for r,e in zip((7,8),t['endpoints']):
        need(set(e)=={'index','owner','height','image'},'endpoint fields')
        need(type(e['index']) is int and type(e['owner']) is int and e['index']==r and e['owner']==7,'endpoint index/owner')
        need(qread(e['height'])==(Q(15993,8) if r==7 else Q(1999)),'endpoint height');rectread(e['image'])
    need(same(t['analytical_budget'],analytical_budget()),'both exact analytic tails required')


def load_target():
    path=HERE/TARGET_NAME;need(sha(path)==TARGET_SHA,'immutable old source bytes')
    data=read_json(path,16*1024*1024)
    expected=dict(N=1024,B=1025,M=16,K=16,p=24,J=8,L=32,precision_bits=192,
                  sigma=qwire(Q(629,1250)),t0=qwire(Q(31999,16)),Delta=qwire(Q(-1,8)),
                  outer_radius=qwire(1),panel_radius=qwire(Q(1,16)))
    need(same(data['parameters'],expected),'literal original parameters')
    need(len(data['g_jets'])==8 and len(data['panels'])==8 and len(data['endpoints'])==9,'old complete array sizes')
    t=dict(sha256=TARGET_SHA,g_jets=data['g_jets'][7],panel=data['panels'][7],
           endpoints=data['endpoints'][7:9],analytical_budget=analytical_budget())
    validate_target(t);return t


def reconstruct(t):
    validate_target(t);coefs=[old_box(c) for c in t['g_jets']['coefficients']]
    pad=sum((qread(v) for v in t['analytical_budget'].values()),Q(0))
    def image(bottom,top):
        z=((Q(0),Q(0)),(sub(bottom,center()[1]),sub(top,center()[1])))
        value=((Q(0),Q(0)),(Q(0),Q(0)))
        for a in reversed(coefs): value=rcadd(rcmul(value,z),a)
        value=tuple((sub(lo,pad),add(hi,pad)) for lo,hi in value)
        den=((center()[0]-1,center()[0]-1),(bottom,top))
        return rectwire(rcmul(value,rcinv(den)))
    p=dict(t['panel']);p['image']=image(Q(1999),Q(15993,8))
    es=[]
    for e in t['endpoints']:
        out=dict(e);h=qread(e['height']);out['image']=image(h,h);es.append(out)
    result=dict(panel=p,endpoints=es)
    need(same(result,dict(panel=t['panel'],endpoints=t['endpoints'])),'all3 exact immutable image equalities')
    return result


class Monitor:
    class MemoryCounters(ctypes.Structure):
        _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[(n,ctypes.c_size_t) for n in
          ('PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage',
           'QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage','PrivateUsage')]

    def __init__(self,start):
        need(os.name=='nt','Windows lifetime peak telemetry required')
        self.start=start;self.stage='initialization';self.peak=0;self.samples=0
        self.max_bits=0;self.gates=0;self.pending_owned=False;self.final_owned=False;self.completion_owned=False
        k=ctypes.WinDLL('kernel32',use_last_error=True)
        k.GetCurrentProcess.restype=wintypes.HANDLE;k.GetCurrentProcess.argtypes=[]
        self.handle=k.GetCurrentProcess()
        k.IsProcessInJob.argtypes=[wintypes.HANDLE,wintypes.HANDLE,ctypes.POINTER(wintypes.BOOL)]
        k.IsProcessInJob.restype=wintypes.BOOL;inside=wintypes.BOOL()
        need(k.IsProcessInJob(self.handle,None,ctypes.byref(inside)) and inside.value,'external job assignment required')
        self.api=ctypes.WinDLL('psapi',use_last_error=True).GetProcessMemoryInfo
        self.api.argtypes=[wintypes.HANDLE,ctypes.POINTER(self.MemoryCounters),wintypes.DWORD];self.api.restype=wintypes.BOOL
        self.guard()

    def guard(self,stage=None):
        if stage is not None:self.stage=stage
        c=self.MemoryCounters();c.cb=ctypes.sizeof(c)
        need(self.api(self.handle,ctypes.byref(c),c.cb),'OS peak query failure')
        peak=int(c.PeakWorkingSetSize);need(peak>0 and peak>=self.peak,'invalid lifetime peak')
        self.peak=peak;self.samples+=1;elapsed=time.monotonic()-self.start
        need(elapsed<=SECONDS,'600s cooperative deadline exceeded')
        need(peak<=MEMORY,'512MiB lifetime peak exceeded')
        return dict(worker_elapsed_seconds=elapsed,peak_working_set_bytes=peak,samples=self.samples,
                    children_spawned=0,scope='worker observation only; external post-exit seal required')


class Gates:
    def __init__(self,monitor):
        self.monitor=monitor;self.count=0;self.hash=hashlib.sha256()

    def real(self,x,g):
        x=rat(x);need(type(g) is int and 0<=g<=MAX_EXPONENT,'grid guard')
        p,q=x.numerator,x.denominator;s=1<<g
        a=raw_mul(raw_mul(2,p),s);b=raw_mul(2,q);numerator=integer(a+q)
        m=integer(numerator//b);r=integer(numerator-raw_mul(b,m))
        verify_round(p,q,g,m,r)
        for v in (g,p,q,m,r):self.hash.update((str(v)+'\n').encode('ascii'))
        self.count+=1;self.monitor.gates+=1
        self.monitor.max_bits=max(self.monitor.max_bits,*(abs(v).bit_length() for v in (p,q,a,b,m,r)))
        if self.monitor.gates%2048==0:self.monitor.guard()
        return rat(Q(m,s))

    def complex(self,z,g): return self.real(z[0],g),self.real(z[1],g)
    def summary(self): return dict(count=self.count,sha256=self.hash.hexdigest().upper())


def verify_round(p,q,g,m,r):
    for v in (p,q,g,m,r):integer(v)
    need(q>0 and 0<=g<=MAX_EXPONENT,'rounding input domain')
    a=raw_mul(raw_mul(2,p),1<<g);twom=raw_mul(2,m);twoq=raw_mul(2,q)
    need(raw_mul(integer(twom-1),q)<=a<raw_mul(integer(twom+1),q),'signed nearest witness')
    need(integer(a+q)==integer(raw_mul(twoq,m)+r) and 0<=r<twoq,'Euclidean rounding remainder')


def scalar_checks():
    eta,eps,delta=two(-1024),two(-512),two(-1040)
    tlog=Q(22,1025)*Q(1,3**1025)/Q(8,9)
    tpi=Q(20,513*5**513)
    er=81*Q(2)*two(-513)/factorial(513)+283*delta
    ec=Q(2*4**513,factorial(513))+81*delta+2**13*eta
    inequalities={
      'log_tail_lt_eta_16':tlog<eta/16,'pi_tail_lt_eta_16':tpi<eta/16,
      'log_total_lt_eta':tlog+Q(77,4)*delta+eta/2<eta,
      'pi_total_lt_eta':tpi+Q(145,6)*delta+eta/2<eta,
      'real_exp_lt_eta':er<eta,'all_real_square_errors_lt_one':er<1,
      'complex_exp_lt_2p16_eta':2*er+ec+eta<2**16*eta,
      'primitive_lt_epsilon':2**16*eta<eps,
      'actual_phase_lt_2p13_epsilon':(3*2001+1)*eps<2**13*eps,
      'head_bound':1024*(2**13*eps*2**45+2**46*eps)+eps<2**70*eps,
      'correction_bound':2**48*(2**13*eps*2**13+2**13*eps)+eps<2**78*eps,
      'g_bound':2002*2**70*eps+2**78*eps+eps<2**84*eps,
      'g_declared_radius':2**84*eps<two(-420),
    }
    need(all(inequalities.values()),'fixed exact scalar inequality failure')
    return dict(checks=inequalities,log_tail=qwire(tlog),pi_tail=qwire(tpi),
                real_exp_error=qwire(er),cis_error=qwire(ec),
                eta=dwire(eta),epsilon=dwire(eps),delta=dwire(delta),
                actual_phase_radius=dwire(two(-499)),g_error_bound=dwire(two(-428)),g_radius=dwire(two(-420)))


def log_inner(t,gate):
    need(0<=t<=Q(1,3),'atanh reduced domain');v=Q(0);t2=mul(t,t)
    for j in range(511,-1,-1):v=gate.real(add(Q(1,2*j+1),mul(t2,v)),1041)
    return gate.real(mul(2*t,v),1041)


def atan_inner(t,gate):
    need(t in (Q(1,5),Q(1,239)),'Machin argument');v=Q(0);t2=mul(t,t)
    for j in range(255,-1,-1):v=gate.real(sub(Q(1,2*j+1),mul(t2,v)),1041)
    return gate.real(mul(t,v),1041)


def exp_real_horner(x,gate):
    need(abs(x)<=Q(1,2),'real exponential reduced domain');v=Q(1)
    for k in range(511,-1,-1):v=gate.real(add(Q(1),div(mul(x,v),Q(k+1))),1041)
    for _ in range(4):v=gate.real(mul(v,v),1041)
    return v


def exp_cis_horner(r,gate):
    need(abs(r)<4,'cis reduced domain');z=(Q(0),r);v=one()
    for k in range(511,-1,-1):v=gate.complex(cadd(one(),scale(cmul(z,v),Q(1,k+1))),1041)
    return v


def phase_at(logn,pi,gate):
    z=scale(center(),-logn);x,theta=z
    need(-8<=x<=0 and abs(theta)<2**14,'phase exact-input domain')
    ratio=div(theta,2*pi);period=(2*ratio.numerator+ratio.denominator)//(2*ratio.denominator)
    need(abs(period)<2**12,'period bound')
    need(Q(period)-Q(1,2)<=ratio<Q(period)+Q(1,2),'period integer witness')
    reduced=sub(theta,mul(Q(2*period),pi));need(abs(reduced)<=pi<4,'reduced angle bound')
    er=exp_real_horner(div(x,Q(16)),gate);ec=exp_cis_horner(reduced,gate)
    return z,period,reduced,gate.complex(scale(ec,er),1025)


def bernoullis():
    out=[Q(1)]
    for n in range(1,33):
        total=Q(0)
        for k in range(n):total=add(total,mul(Q(comb(n+1,k)),out[k]))
        out.append(div(-total,Q(n+1)))
    verify_bernoulli(out);return out


def verify_bernoulli(out):
    need(len(out)==33 and out[0]==1 and out[1]==Q(-1,2),'Bernoulli size/sign')
    for n in range(1,33):
        total=sum((Q(comb(n+1,k))*out[k] for k in range(n+1)),Q(0))
        need(rat(total)==0,'signed Bernoulli recurrence')


def normalized_powers(logn):
    out=[Q(1)]
    for h in range(1,16):out.append(div(mul(out[-1],-logn),Q(h)))
    return out


def correction_c(bn):
    verify_bernoulli(bn);c=center();rising=[one()]+[zero() for _ in range(15)]
    cc=[(Q(1,2),Q(0))]+[zero() for _ in range(15)]
    for length in range(1,32):
        factor=(add(c[0],Q(length-1)),c[1]);old=rising
        rising=[cadd(cmul(factor,old[h]),old[h-1] if h else zero()) for h in range(16)]
        if length%2:
            m=(length+1)//2;coefficient=div(bn[2*m],Q(factorial(2*m)))
            weight=div(coefficient,Q(integer(B**length)))
            need(abs(coefficient)<=1,'Bernoulli coefficient bound')
            cc=[cadd(cc[h],scale(rising[h],weight)) for h in range(16)]
    return cc


def verify_full_q(out,cc):
    need(len(out)==len(cc)==16,'full Q retained degree')
    cm1=(center()[0]-1,center()[1])
    for h in range(16):
        expected=cadd(cmul(cm1,cc[h]),cc[h-1] if h else zero())
        if h==0:expected=cadd(expected,(Q(B),Q(0)))
        need(out[h]==expected,'full Q affine identity with B pole term')


def full_q(bn):
    cc=correction_c(bn);c=center()
    cm1=(c[0]-1,c[1]);out=[cadd(cmul(cm1,cc[h]),cc[h-1] if h else zero()) for h in range(16)]
    out[0]=cadd(out[0],(Q(B),Q(0)))
    verify_full_q(out,cc)
    need(sum((l1(v) for v in out),Q(0))<2**48,'full Q coefficient l1 bound')
    return out


def require_labels(rows,count,label):
    need(type(rows) is list and len(rows)==count,label+' complete count')
    for n,row in enumerate(rows,1):need(type(row['n']) is int and row['n']==n,label+' exact labels')


def ball_containment(c,r,box):
    out={}
    for axis,value,(lo,hi) in zip(('re','im'),c,box):
        left=sub(sub(value,r),lo);right=sub(hi,add(value,r))
        need(left>=0 and right>=0,'fresh ball outside old square')
        out[axis]={'lower_margin':qwire(left),'upper_margin':qwire(right)}
    return out


def require_inside(inner,ri,outer,ro):
    distance=l1(csub(inner,outer));need(distance+ri<=ro,'norm ball containment')
    return distance


class Engine:
    def __init__(self,monitor): self.monitor=monitor

    def shared(self,result):
        self.monitor.guard('shared log2 and pi');g=Gates(self.monitor)
        raw=log_inner(Q(1,3),g)
        a=atan_inner(Q(1,5),g);b=atan_inner(Q(1,239),g)
        pi=g.real(sub(mul(Q(16),a),mul(Q(4),b)),1025)
        need(3<pi<4 and 0<raw<1,'shared exact domain bounds')
        result['shared']=dict(log2_raw=dwire(raw),pi=dwire(pi),gate_summary=g.summary())
        return raw,pi

    def leaves(self,result,raw,pi):
        for n in range(1,1026):
            self.monitor.guard('log and phase '+str(n));g=Gates(self.monitor)
            k=n.bit_length()-1;t=Q(n-(1<<k),n+(1<<k))
            if n==1:logn=Q(0)
            else:logn=g.real(add(mul(Q(k),raw),log_inner(t,g)),1025)
            need(0<=logn<=8,'canonical log range')
            result['logs'].append(dict(n=n,k=k,t=qwire(t),center=dwire(logn),
                                        radius=dwire(Q(0) if n==1 else two(-1024)),gates=g.summary()))
            g=Gates(self.monitor)
            if n==1:z=zero();period=0;reduced=Q(0);phase=one()
            else:z,period,reduced,phase=phase_at(logn,pi,g)
            need(l1(phase)<2,'phase l1 coarse bound')
            result['phases'].append(dict(n=n,input=cqwire(z),period=period,reduced=qwire(reduced),
                    center=cpwire(phase),radius=dwire(Q(0) if n==1 else two(-499)),gates=g.summary()))

    def finite_g(self,result):
        require_labels(result['logs'],1025,'logs');require_labels(result['phases'],1025,'phases')
        sums=[zero() for _ in range(16)]
        for n in range(1,1025):
            if n%16==0:self.monitor.guard('exact direct head '+str(n))
            logn=dread(result['logs'][n-1]['center']);p=cpread(result['phases'][n-1]['center'])
            powers=normalized_powers(logn)
            for h in range(16):sums[h]=cadd(sums[h],scale(p,powers[h]))
        head=[]
        for h in range(16):
            g=Gates(self.monitor);v=g.complex(sums[h],513);head.append(v)
            result['head'].append(dict(h=h,center=cpwire(v),radius=dwire(two(-442)),gates=g.summary()))
        bn=bernoullis();result['bernoulli']=[qwire(v) for v in bn]
        qp=full_q(bn);logb=dread(result['logs'][-1]['center']);phaseb=cpread(result['phases'][-1]['center'])
        bp=normalized_powers(logb);correction=[]
        for h in range(16):
            self.monitor.guard('full correction '+str(h));v=zero()
            for a in range(h+1):v=cadd(v,scale(qp[a],bp[h-a]))
            v=cmul(phaseb,v);g=Gates(self.monitor);v=g.complex(v,513);correction.append(v)
            result['correction'].append(dict(h=h,center=cpwire(v),radius=dwire(two(-434)),gates=g.summary()))
        cm1=(center()[0]-1,center()[1])
        for h in range(16):
            v=cadd(cadd(cmul(cm1,head[h]),head[h-1] if h else zero()),correction[h])
            g=Gates(self.monitor);v=g.complex(v,513);r=two(-420)
            result['g'].append(dict(h=h,center=cpwire(v),radius=dwire(r),gates=g.summary(),
                    old_containment=ball_containment(v,r,old_box(result['target']['g_jets']['coefficients'][h]))))


def negative_controls(result):
    """Bounded semantic mutations. Reuse leaves, never recompute another run."""
    outcomes=[]
    def reject(name,call):
        try:call()
        except Reject as e:outcomes.append(dict(name=name,rejected=True,reason=str(e)));return
        raise Reject('negative control incorrectly accepted: '+name)
    t=result['target']
    changed=dict(t);changed['g_jets']=dict(t['g_jets'],j=6)
    reject('changed j index',lambda:validate_target(changed))
    changed2=dict(t);changed2['g_jets']=dict(t['g_jets'],center=cqwire((center()[0],center()[1]+1)))
    reject('changed center',lambda:validate_target(changed2))
    changed3=dict(t);changed3['endpoints']=[dict(t['endpoints'][0],owner=6),t['endpoints'][1]]
    reject('endpoint owner',lambda:validate_target(changed3))
    missing=result['phases'][:1023]+result['phases'][1024:]
    reject('omitted n1024',lambda:require_labels(missing,1025,'phases'))
    bn=[qread(v) for v in result['bernoulli']];bad=list(bn);bad[2]=-bad[2]
    reject('changed signed Bernoulli',lambda:verify_bernoulli(bad))
    qp=full_q(bn);cc=correction_c(bn);missing_b=list(qp)
    missing_b[0]=csub(missing_b[0],(Q(B),Q(0)))
    reject('omitted B pole polynomial coefficient',lambda:verify_full_q(missing_b,cc))
    certified=cpread(result['phases'][1]['center']);r=dread(result['phases'][1]['radius'])
    reject('shifted elementary center',lambda:require_inside(certified,r,cadd(certified,(Q(1),Q(0))),r))
    reject('invalid signed tie rounding witness',lambda:verify_round(-1,2,0,-1,1))
    changed4=dict(t);changed4['analytical_budget']=dict(t['analytical_budget'],Taylor=qwire(0))
    reject('omitted analytic Taylor tail',lambda:validate_target(changed4))
    changed5=dict(t);e=dict(t['endpoints'][1]);box=dict(e['image']);axis=dict(box['re'])
    axis['hi']=qwire(qread(axis['hi'])+1);box['re']=axis;e['image']=box
    changed5['endpoints']=[t['endpoints'][0],e]
    reject('changed immutable endpoint image',lambda:reconstruct(changed5))
    return outcomes


def validate_result(r):
    need(r['schema']==SCHEMA and same(r['parameters'],params()) and same(r['recipe'],recipe()),'result target/recipe')
    validate_target(r['target']);require_labels(r['logs'],1025,'logs');require_labels(r['phases'],1025,'phases')
    pi=dread(r['shared']['pi']);need(3<pi<4,'pi domain')
    for n,(lr,pr) in enumerate(zip(r['logs'],r['phases']),1):
        k=n.bit_length()-1;need(type(lr['k']) is int and lr['k']==k,'log integer reduction')
        need(qread(lr['t'])==Q(n-(1<<k),n+(1<<k)),'log rational reduction')
        logn=dread(lr['center']);need(0<=logn<=8,'log domain')
        need(dread(lr['radius'])==(Q(0) if n==1 else two(-1024)),'fixed actual-log radius')
        need(same(pr['input'],cqwire(scale(center(),-logn))),'actual phase input binding')
        period=pr['period'];need(type(period) is int and abs(period)<4096,'period type/domain')
        theta=-center()[1]*logn;ratio=theta/(2*pi)
        need(Q(period)-Q(1,2)<=ratio<Q(period)+Q(1,2),'signed period witness')
        need(qread(pr['reduced'])==theta-2*period*pi,'reduced phase identity')
        need(dread(pr['radius'])==(Q(0) if n==1 else two(-499)),'fixed actual-phase radius')
        for record,count in ((lr,0 if n==1 else 514),(pr,0 if n==1 else 1542)):
            need(record['gates']['count']==count,'complete deterministic leaf gates')
        if n==1:need(logn==0 and cpread(pr['center'])==one(),'exact n1 identities')
    verify_bernoulli([qread(v) for v in r['bernoulli']])
    for name,radius in (('head',two(-442)),('correction',two(-434)),('g',two(-420))):
        need(len(r[name])==16,'all16 '+name)
        for h,row in enumerate(r[name]):
            need(type(row['h']) is int and row['h']==h and dread(row['radius'])==radius,'coefficient label/radius')
            need(row['gates']['count']==2,'single complex outer gate')
            if name=='g':need(same(row['old_containment'],ball_containment(cpread(row['center']),radius,
                         old_box(r['target']['g_jets']['coefficients'][h]))),'stored exact containment witness')
    need(same(r['images'],reconstruct(r['target'])),'all3 actual image reconstructions')
    need(len(r['negative_controls'])==10 and all(c['rejected'] is True for c in r['negative_controls']),'negative controls complete')


def own_name(name):
    need(type(name) is str and Path(name).name==name and len(name)<160,'plain owned filename')
    path=(HERE/name).resolve();need(path.parent==HERE and path.suffix=='.json','owned JSON output');return path


def manifest_check(path,monitor):
    m=read_json(path,65536);required={'runtime_authorized','producer_code_sha256','pins','parameters','output',
            'caps','static_review','supervision','preparation'}
    need(type(m) is dict and set(m)==required,'run manifest keys')
    need(m['runtime_authorized'] is True and m['producer_code_sha256']==sha(__file__),'exact runtime authorization')
    need(same(m['pins'],PINS) and same(m['parameters'],params()),'manifest pins and target')
    need(same(m['caps'],dict(seconds=SECONDS,peak_working_set_bytes=MEMORY,aggregate_bytes=OUTPUT_CAP)),'fixed caps')
    s=m['supervision'];need(type(s) is dict and set(s)=={'protocol','supervisor_pid','post_exit_seal_required','no_children'},'supervision fields')
    need(s['protocol']=='external-retained-handle-v1' and type(s['supervisor_pid']) is int and s['supervisor_pid']>0
         and s['post_exit_seal_required'] is True and s['no_children'] is True,'external supervision contract')
    for key in ('static_review','preparation'):
        ref=m[key];need(type(ref) is dict and set(ref)=={'path','sha256'},'review/preparation reference')
        need(type(ref['path']) is str and type(ref['sha256']) is str,'reference types')
        p=(AGENTS/ref['path']).resolve();need(p.is_relative_to(AGENTS) and p.suffix=='.md','safe reference path')
        need(sha(p)==ref['sha256'],'review/preparation hash binding')
    for p,h in PINS.items():monitor.guard('source pin '+p);need(sha(AGENTS/p)==h,'source pin mismatch '+p)
    return m,own_name(m['output'])


def output_family(path):
    return [path,path.with_suffix('.pending'),path.with_suffix('.attempt.json'),
            path.with_suffix('.failure.json'),path.with_suffix('.completion.json')]


def stream_json(path,value,cap):
    enc=json.JSONEncoder(ensure_ascii=True,allow_nan=False,separators=(',',':'));count=0
    with path.open('xb') as out:
        for chunk in enc.iterencode(value):
            b=chunk.encode('ascii');count+=len(b);need(count<=cap,'bounded retained output');out.write(b)
        out.flush();os.fsync(out.fileno())
    return count


def publish(result,path,monitor):
    # Reserve 256KiB for the manifest/log/supervisor seal outside this file.
    pending=path.with_suffix('.pending');need(not pending.exists() and not path.exists(),'no overwrite')
    result['telemetry']=monitor.guard('before candidate serialization');result['status']='CANDIDATE'
    monitor.pending_owned=True
    size=stream_json(pending,result,OUTPUT_CAP-262144)
    monitor.guard('after full candidate serialization')
    total=sum(p.stat().st_size for p in output_family(path) if p.exists())
    need(total<=OUTPUT_CAP-131072,'reserve for supervisor seal/logs')
    need(not path.exists(),'destination appeared');os.rename(pending,path)
    monitor.pending_owned=False;monitor.final_owned=True
    telemetry=monitor.guard('after publication')
    completion=dict(status='CANDIDATE',sha256=sha(path),bytes=size,telemetry=telemetry,
                    external_post_exit_seal_required=True,independent_acceptance_required=True)
    monitor.completion_owned=True
    stream_json(path.with_suffix('.completion.json'),completion,32768)
    monitor.guard('after completion publication')
    return completion


def save_failure(result,path,monitor,exc):
    # Remove only files created by this attempt, never an earlier artifact.
    for p,owned in ((path,monitor.final_owned),(path.with_suffix('.pending'),monitor.pending_owned),
                    (path.with_suffix('.completion.json'),monitor.completion_owned)):
        if owned and p.exists():need(p.resolve().parent==HERE,'cleanup ownership');p.unlink()
    result['status']='INCOMPLETE';result['failure']=dict(type=type(exc).__name__,reason=str(exc)[:1000],stage=monitor.stage)
    try:result['telemetry']=monitor.guard('failure snapshot')
    except Exception:result['telemetry']=dict(last_peak_working_set_bytes=monitor.peak,complete=False)
    failure=path.with_suffix('.failure.json')
    try:stream_json(failure,result,OUTPUT_CAP-262144)
    except Exception:
        if failure.exists():failure.unlink()
        stream_json(failure,dict(status='INCOMPLETE',failure=result['failure'],
                    completed_logs=len(result.get('logs',[])),completed_phases=len(result.get('phases',[]))),32768)


def main():
    start=time.monotonic()
    if hasattr(sys,'set_int_max_str_digits'):sys.set_int_max_str_digits(21000)
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--manifest',required=True)
    args=parser.parse_args();monitor=Monitor(start)
    manifest,path=manifest_check(Path(args.manifest),monitor)
    need(all(not p.exists() for p in output_family(path)),'one attempt, no resume/overwrite')
    stream_json(path.with_suffix('.attempt.json'),dict(code_sha256=sha(__file__),manifest_sha256=sha(args.manifest),
             parameters=params(),supervision=manifest['supervision'],one_attempt=True),32768)
    result=dict(schema=SCHEMA,producer_code_sha256=sha(__file__),pins=PINS,parameters=params(),recipe=recipe(),
                target={},scalar_checks={},shared={},logs=[],phases=[],bernoulli=[],head=[],correction=[],g=[],
                images={},negative_controls=[],counters={})
    try:
        result['target']=load_target();result['scalar_checks']=scalar_checks()
        engine=Engine(monitor);raw,pi=engine.shared(result);engine.leaves(result,raw,pi);engine.finite_g(result)
        result['images']=reconstruct(result['target']);result['negative_controls']=negative_controls(result)
        result['counters']=dict(rounding_coordinate_gates=monitor.gates,observed_rounding_integer_bits=monitor.max_bits,
                  logs=1025,phases=1025,normalized_g_coefficients=16,whole_panels=1,endpoints=2,
                  scope='rounding observed sizes only; not all arithmetic temporary allocations')
        validate_result(result);completion=publish(result,path,monitor)
        print(json.dumps(completion,separators=(',',':')));return 0
    except BaseException as exc:
        save_failure(result,path,monitor,exc)
        print(json.dumps(dict(status='INCOMPLETE',stage=monitor.stage,reason=str(exc)[:1000])),file=sys.stderr)
        return 1


if __name__=='__main__':
    raise SystemExit(main())
