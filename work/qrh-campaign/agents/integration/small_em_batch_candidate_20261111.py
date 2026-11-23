"""One fixed external FLINT experiment; preparation is not runtime authorization.

No numerical code executes on import. No old producer is imported. A separately
reviewed run manifest must authorize this exact source hash and new output name.
This is interval experimentation, not rational elementary proof or a Lean checker.
"""
from fractions import Fraction as Q
from math import factorial, comb, gcd
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
SCHEMA = 'small-em-batch-candidate-v1'
PRECISION = 192
SECONDS = 180
MEMORY = 512 * 1024 * 1024
MAX_RECEIPT = 64 * 1024 * 1024
MAX_BITS = 65536
MAX_EXPONENT = 16384
N, B, M, K, P, J, L = 1024, 1025, 16, 16, 24, 8, 32
SIGMA, T0, DELTA, RHO = Q(629,1250), Q(31999,16), Q(-1,8), Q(1,16)
EPS_MOMENT = EPS_FFT = Q(1,2**110)
EPS_HORNER = Q(1,2**100)
EPS_CORRECTION = EPS_ASSEMBLY = Q(1,2**80)
G_HALF = Q(1,2**52)
E_TAYLOR = Q(1,15*2**33)
E_EM = Q(4*2003*33,1)/Q(63,2)*Q(2034,6*1025)**32
PINS = {
 'moebius/SMALL_EM_BATCH_PILOT_SPECIFICATION_2026-11-11.md':
  '3977881D20CFE9F948E850AC9A83CF50084AA1EF7D0B7023E5D1A95DE845B929',
 'independent-feasibility/REVIEW_SMALL_EM_BATCH_PILOT_PREFLIGHT_2026-11-11.md':
  'E8D928EB25CA0AAB583609D33DF982CFC2A1D01E65890AE8BCBBB58C4BF9C7F0',
 'major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md':
  '47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23',
 'major-constants/em_small_batch_budget_20261111.py':
  '13E200EDFF99D2C44CFA19EEE8CC83C071488362E2DF3997D71E7A79BB65B59D',
 'major-constants/em_small_batch_budget_20261111.json':
  '41FF7A626495159CCEB34C19ED6426F480DEB9759962784885120E8B4E76E931',
 'integration/SMALL_EM_BATCH_RECEIPT_CONTRACT_2026-11-11.md':
  'DA2740C39148A2F1AB2291E6581B5C55A75BF33456E8006CB148B34B516178AF',
 'moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md':
  '814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818',
 'independent-feasibility/REVIEW_FINITE_EM_VERTICAL_BATCHING_2026-11-11.md':
  'B8EE7250B9E2AAEE8099A7109C08FF34FBD70E880182E99E2B3F30970C49717E',
 'integration/FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md':
  '170C8F976A8AF8B299E4AB737E6924260B3B1D8328FA54C0F2BF7F6E9720F997',
 'audit/REVIEW_FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md':
  'F2DC3A12F4474E8469D45C741E0F1A7FBA5A1CAF61AEF6A1509749FDE8BFD406',
}


class Reject(Exception):
    pass


def require(ok, message):
    if not ok:
        raise Reject(message)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest().upper()


def integer(n):
    require(type(n) is int and abs(n).bit_length() <= MAX_BITS, 'integer bound/type')
    return n


def qwire(x):
    x=Q(x); integer(x.numerator); integer(x.denominator)
    return {'numerator':str(x.numerator),'denominator':str(x.denominator)}


def dwire(x):
    x=Q(x); d=x.denominator
    require(d & (d-1) == 0, 'non-dyadic value')
    e=-(d.bit_length()-1); n=x.numerator
    if n == 0:
        return {'mantissa':'0','exponent':0}
    while n % 2 == 0:
        n//=2; e+=1
    integer(n); require(abs(e)<=MAX_EXPONENT,'dyadic exponent bound')
    return {'mantissa':str(n),'exponent':e}


def from_man_exp(n,e):
    n=integer(int(n)); e=int(e)
    require(abs(e)<=MAX_EXPONENT,'dyadic exponent before shift')
    return Q(n << e) if e>=0 else Q(n,1 << (-e))


def dvalue(d):
    require(set(d)=={'mantissa','exponent'},'dyadic keys')
    text=d['mantissa']
    require(type(text) is str and len(text)<=20000,'dyadic mantissa encoding')
    n=int(text); require(str(n)==text,'noncanonical integer')
    require(type(d['exponent']) is int,'dyadic exponent type')
    require((n==0 and d['exponent']==0) or (n!=0 and n%2!=0),'dyadic normalization')
    return from_man_exp(n,d['exponent'])


def qvalue(d):
    require(set(d)=={'numerator','denominator'},'rational keys')
    a,b=d['numerator'],d['denominator']
    require(type(a) is str and type(b) is str and max(len(a),len(b))<=20000,'rational encoding')
    n,dn=integer(int(a)),integer(int(b))
    require(str(n)==a and str(dn)==b and dn>0 and gcd(n,dn)==1,'rational normalization')
    return Q(n,dn)


def parameters():
    return dict(N=N,B=B,M=M,K=K,p=P,J=J,L=L,precision_bits=PRECISION,
                sigma=qwire(SIGMA),t0=qwire(T0),Delta=qwire(DELTA),
                outer_radius=qwire(1),panel_radius=qwire(RHO))


def unique_object(pairs):
    out={}
    for k,v in pairs:
        require(k not in out,'duplicate JSON key: '+k)
        out[k]=v
    return out


def read_json(path, cap=1024*1024):
    require(Path(path).stat().st_size<=cap,'manifest size cap before read')
    with Path(path).open('rb') as source:raw=source.read(cap+1)
    require(len(raw)<=cap,'manifest size cap')
    return json.loads(raw,object_pairs_hook=unique_object,
                      parse_constant=lambda s: (_ for _ in ()).throw(Reject('nonfinite JSON number')))


class Monitor:
    class Counters(ctypes.Structure):
        _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[
            (k,ctypes.c_size_t) for k in ('PeakWorkingSetSize','WorkingSetSize',
             'QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage',
             'QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage','PrivateUsage')]

    def __init__(self,start):
        require(os.name=='nt','Windows peak working-set telemetry required')
        self.start=start;self.stage='initialization';self.context={};self.peak=0;self.calls=0
        self.pending_owned=False;self.published_owned=False
        kernel=ctypes.WinDLL('kernel32',use_last_error=True)
        kernel.GetCurrentProcess.restype=wintypes.HANDLE
        kernel.GetCurrentProcess.argtypes=[]
        self.handle=kernel.GetCurrentProcess()
        self.api=ctypes.WinDLL('psapi',use_last_error=True).GetProcessMemoryInfo
        self.api.argtypes=[wintypes.HANDLE,ctypes.POINTER(self.Counters),wintypes.DWORD]
        self.api.restype=wintypes.BOOL
        self.guard()

    def sample(self):
        c=self.Counters();c.cb=ctypes.sizeof(c)
        require(bool(self.api(self.handle,ctypes.byref(c),c.cb)), 'working-set telemetry failure')
        self.peak=max(self.peak,int(c.PeakWorkingSetSize));self.calls+=1
        return dict(elapsed_seconds=time.monotonic()-self.start,
                    peak_working_set_bytes=self.peak,working_set_bytes=int(c.WorkingSetSize),
                    private_commit_bytes=int(c.PrivateUsage),guard_calls=self.calls)

    def guard(self,stage=None,**context):
        if stage is not None:self.stage=stage
        if context:self.context=context
        t=self.sample()
        require(t['elapsed_seconds']<=SECONDS,'180-second cap exceeded')
        require(t['peak_working_set_bytes']<=MEMORY,'512-MiB peak working-set cap exceeded')
        return t


# Exact rational rectangle operations. They deliberately use the reviewed
# dependency-widening reciprocal, not a nonlinear optimizer or a FLINT output.
def radd(a,b):return a[0]+b[0],a[1]+b[1]
def rneg(a):return -a[1],-a[0]
def rsub(a,b):return radd(a,rneg(b))
def rmul(a,b):
    z=[x*y for x in a for y in b];return min(z),max(z)
def rsquare(a):return (Q(0) if a[0]<=0<=a[1] else min(x*x for x in a)),max(x*x for x in a)
def rdiv(a,b):
    require(b[0]>0,'nonpositive reciprocal norm interval')
    z=[x/y for x in a for y in b];return min(z),max(z)
def cadd(a,b):return radd(a[0],b[0]),radd(a[1],b[1])
def cmul(a,b):return rsub(rmul(a[0],b[0]),rmul(a[1],b[1])),radd(rmul(a[0],b[1]),rmul(a[1],b[0]))
def cinv(a):
    den=radd(rsquare(a[0]),rsquare(a[1]))
    require(den[0]>0,'rectangle denominator contains zero')
    return rdiv(a[0],den),rdiv(rneg(a[1]),den)
def rectwire(a):
    require(all(x<=y for x,y in a),'unordered rational rectangle')
    return {k:{'lo':qwire(x),'hi':qwire(y)} for k,(x,y) in zip(('re','im'),a)}
def ball_rect(a):
    out=[]
    for k in ('re','im'):
        m,r=dvalue(a[k]['mid']),dvalue(a[k]['rad'])
        require(r>=0,'negative ball radius');out.append((m-r,m+r))
    return tuple(out)


def bernoullis(nmax):
    values=[Q(1)]
    for n in range(1,nmax+1):
        values.append(-sum(Q(comb(n+1,k))*values[k] for k in range(n))/Q(n+1))
    require(values[1]==Q(-1,2) and values[2]==Q(1,6),'Bernoulli convention')
    return values


def scalar_checks(bn):
    require(E_EM<Q(1,2**38),'EM scalar budget')
    require(E_TAYLOR==Q(1,15*2**33),'Taylor scalar budget')
    require(2*L*P*EPS_MOMENT+EPS_HORNER<Q(1,2**98),'main arithmetic allocation')
    require(Q(2**25,factorial(P))+Q(2002,2**98)+2*EPS_CORRECTION<Q(1,2**53),
            'full g midpoint allocation')
    for h in range(K):require(Q(64*7**h,factorial(h))<2**14,'all-jet weight bound')
    for k in range(1,M+1):require(abs(bn[2*k])/factorial(2*k)<=Q(4,6**(2*k)),'Bernoulli bound')
    total=Q(3,2)*(Q(1,2**38)+E_TAYLOR+Q(16,15)*G_HALF)/2**10+Q(1,2**64)
    require(total<Q(1,2**44),'full quotient allocation')
    return dict(EM=qwire(E_EM),Taylor=qwire(E_TAYLOR),outer_finite_g_bound=qwire(2**27),
                full_quotient_error_budget=qwire(total),
                exact_image_rounding=qwire(0),coefficient_padding_added_twice=False)


class Engine:
    def __init__(self, monitor):
        self.monitor=monitor
        # Lazy import: importing this prepared module performs no FLINT operation.
        import flint
        self.flint=flint;self.arb=flint.arb;self.acb=flint.acb;self.fmpq=flint.fmpq
        flint.ctx.prec=PRECISION
        require(flint.ctx.prec==PRECISION,'fixed precision')
        self.monitor.guard('FLINT imported')

    def ar(self,q):
        q=Q(q);integer(q.numerator);integer(q.denominator)
        return self.arb(self.fmpq(q.numerator,q.denominator))

    def exact(self,x):
        require(x.is_finite() and x.is_exact(),'expected exact finite dyadic')
        m,e=x.man_exp();return from_man_exp(m,e)

    def rb(self,x):
        require(x.is_finite(),'nonfinite real ball')
        m,r=self.exact(x.mid()),self.exact(x.rad())
        require(r>=0,'negative radius')
        return {'mid':dwire(m),'rad':dwire(r)}

    def cb(self,x):return {'re':self.rb(x.real),'im':self.rb(x.imag)}

    def center(self,x):
        require(x.real.is_finite() and x.imag.is_finite(),'nonfinite complex ball')
        return self.exact(x.real.mid()),self.exact(x.imag.mid())

    def rad(self,x):
        return self.exact(x.real.rad())+self.exact(x.imag.rad())

    def real_range(self,x):
        r=self.rb(x);m,e=dvalue(r['mid']),dvalue(r['rad']);return m-e,m+e

    def point(self,z):
        parts=[]
        for x in z:
            d=dwire(x);v=self.arb((int(d['mantissa']),d['exponent']))
            require(v.is_exact() and self.exact(v)==x,'exact FFT input center was rounded')
            parts.append(v)
        return self.acb(*parts)

    def cw(self,z):return {'re':dwire(z[0]),'im':dwire(z[1])}

    def disk(self,x,allowance):
        z=self.center(x);r=self.rad(x)
        require(r<=allowance,'computed ball does not fit fixed Euclidean disk')
        fixed=Q(0) if z==(Q(0),Q(0)) and r==0 else allowance
        return dict(center=self.cw(z),radius=dwire(fixed),computed=self.cb(x)),z,fixed

    def sj(self,j):return self.acb(self.ar(SIGMA),self.ar(T0+j*DELTA))

    def prepare(self,result):
        self.monitor.guard('elementary inputs')
        self.pi=self.arb.pi()
        lo,hi=self.real_range(self.pi);require(3<lo<hi<4,'pi enclosure')
        self.logB=self.arb(B).log();self.logs=[];self.residuals=[];self.bins=[];self.weights=[]
        elementary=dict(pi=self.rb(self.pi),logs=[],base_weights=[],log_B=self.rb(self.logB))
        s0=self.sj(0);counts=[0]*L
        for n in range(1,N+1):
            if n%16==1:self.monitor.guard('elementary/bin inputs',n=n)
            ell=self.arb(0) if n==1 else self.arb(n).log()
            weight=self.acb(1) if n==1 else (-s0*ell).exp()
            x=L*self.ar(DELTA)*ell/(2*self.pi)
            xl,xu=self.real_range(x);require(xl<=xu and xu-xl<=Q(1,4),'bin interval width')
            mid=(xl+xu)/2;q=(mid+Q(1,2)).numerator//(mid+Q(1,2)).denominator
            require(-5<=q<=0,'full signed bin bound')
            k=q%L;r=J*(self.ar(DELTA)*ell-2*self.pi*q/L)
            rl,ru=self.real_range(r);require(-Q(55,56)<rl<=ru<Q(55,56),'residual bound')
            require(max(abs(xl-mid),abs(xu-mid))<=Q(1,8),'bin midpoint witness')
            self.logs.append(ell);self.weights.append(weight);self.residuals.append(r);self.bins.append(k)
            counts[k]+=1
            result['bins'].append(dict(n=n,x={'lo':qwire(xl),'hi':qwire(xu)},mid=qwire(mid),
                                       q=q,k=k,residual=self.rb(r)))
            elementary['logs'].append(dict(n=n,value=self.rb(ell)))
            elementary['base_weights'].append(self.cb(weight))
        require(sum(counts)==N,'complete bin assignment')
        elementary['bin_counts']=counts;result['elementary']=elementary
        self.twiddles={};result['twiddles']=[]
        for length in (2,4,8,16,32):
            row=[]
            for r in range(length//2):
                w=self.acb(1) if r==0 else self.acb(0,2*self.pi*r/length).exp()
                row.append(w);result['twiddles'].append(dict(length=length,r=r,value=self.cb(w)))
            self.twiddles[length]=row

    def fft(self,centers):
        require(len(centers)==L,'FFT line length')
        rev=lambda n:int(format(n,'05b')[::-1],2)
        a=[self.point(centers[rev(k)]) for k in range(L)]
        for length in (2,4,8,16,32):
            for base in range(0,L,length):
                for r,w in enumerate(self.twiddles[length]):
                    u=a[base+r];v=a[base+r+length//2]
                    term=w*v
                    a[base+r]=(u+term)/2
                    a[base+r+length//2]=(u-term)/2
        return a

    def main_sum(self,result):
        self.main_centers=[];self.main_errors=[]
        for h in range(K):
            self.monitor.guard('moment row',h=h)
            arrays=[[self.acb(0) for _ in range(L)] for _ in range(P)]
            for n in range(N):
                if n%32==0:self.monitor.guard('moment accumulation',h=h,n=n+1)
                v=self.acb(1);factor=self.acb(0,-self.residuals[n]);k=self.bins[n]
                for m in range(P):
                    arrays[m][k]+=self.weights[n]*v
                    if m+1<P:v=v*factor/(m+1)
            center_lines=[];input_errors=[]
            for m in range(P):
                centers=[];eps=[]
                for k in range(L):
                    item,z,e=self.disk(arrays[m][k],EPS_MOMENT)
                    item.update(h=h,m=m,k=k);result['moments'].append(item)
                    centers.append(z);eps.append(e)
                center_lines.append(centers);input_errors.append(sum(eps))
            transformed=[];fft_errors=[]
            for m in range(P):
                self.monitor.guard('normalized positive FFT',h=h,m=m)
                out=self.fft(center_lines[m]);row=[];errors=[]
                for j in range(J):
                    index=(-j)%L
                    item,z,e=self.disk(out[index],EPS_FFT)
                    item.update(h=h,m=m,j=j,index=index);result['transforms'].append(item)
                    row.append(z);errors.append(e)
                transformed.append(row);fft_errors.append(errors)
            row_centers=[];row_errors=[];records=[]
            for j in range(J):
                self.monitor.guard('main contraction',h=h,j=j)
                y=Q(j,J);value=self.point(transformed[-1][j])
                for m in range(P-2,-1,-1):value=value*self.ar(y)+self.point(transformed[m][j])
                value*=L
                center=self.center(value);beta=self.rad(value)
                require(beta<=EPS_HORNER,'Horner plus L rounding budget')
                input_error=sum(y**m*input_errors[m] for m in range(P))
                fft_error=L*sum(y**m*fft_errors[m][j] for m in range(P))
                arithmetic=input_error+fft_error+beta
                require(arithmetic<Q(1,2**98),'main arithmetic bound')
                tail=Q(64*7**h,factorial(h)*factorial(P))
                require(tail<Q(2**14,factorial(P)),'main residual Taylor bound')
                error=tail+arithmetic
                records.append(dict(j=j,center=self.cw(center),contraction=self.cb(value),
                                    contraction_error=qwire(beta),source_input_error=qwire(input_error),
                                    transform_error=qwire(fft_error),residual_taylor_error=qwire(tail),
                                    total_error=qwire(error)))
                row_centers.append(center);row_errors.append(error)
            result['main_jets'].append(dict(h=h,values=records))
            self.main_centers.append(row_centers);self.main_errors.append(row_errors)
            if h+1<K:
                for n in range(N):
                    if n%64==0:self.monitor.guard('log weight recurrence',h=h,n=n+1)
                    self.weights[n]=self.weights[n]*(-self.logs[n])/(h+1)

    def corrections(self,result,bn):
        self.monitor.guard('correction preparation')
        factors=[Q(bn[2*k],factorial(2*k))*Q(B)**(1-2*k) for k in range(1,M+1)]
        b0=(-self.sj(0)*self.logB).exp()
        step=self.acb(0,-self.ar(DELTA)*self.logB).exp()
        base_center=self.center(b0);base_error=self.rad(b0)
        step_center=self.center(step);step_error=self.rad(step)
        eb=[self.arb(1)]
        for h in range(1,K):eb.append(eb[-1]*(-self.logB)/h)
        result['corrections']=dict(
            bernoulli=[dict(k=k,bernoulli=qwire(bn[2*k]),factor=qwire(factors[k-1])) for k in range(1,M+1)],
            log_B_coefficients=[self.rb(x) for x in eb],base=self.cb(b0),step=self.cb(step),
            base_center=self.cw(base_center),step_center=self.cw(step_center),
            base_error=qwire(base_error),step_error=qwire(step_error),A_B_upper=qwire(1),
            phases=[],rows=[])
        phase_center,phase_error=base_center,base_error
        for j in range(J):
            self.monitor.guard('complete correction row',j=j)
            if j==0:
                phase_record=dict(j=0,center=self.cw(phase_center),error=qwire(phase_error),
                                  point_product=None,rounding_error=qwire(0))
            else:
                product=self.point(phase_center)*self.point(step_center)
                nu=self.rad(product);phase_center=self.center(product)
                phase_error=(1+step_error)*phase_error+step_error+nu
                phase_record=dict(j=j,center=self.cw(phase_center),error=qwire(phase_error),
                                  point_product=self.cb(product),rounding_error=qwire(nu))
            result['corrections']['phases'].append(phase_record)
            sj=self.sj(j);R=[self.acb(0) for _ in range(K)];R[0]=self.acb(self.ar(Q(1,2)))
            rising=[self.acb(0) for _ in range(K)];rising[0]=self.acb(1)
            for length in range(1,2*M):
                prev=rising
                rising=[prev[h]*(sj+length-1)+(prev[h-1] if h else 0) for h in range(K)]
                if length%2:
                    f=self.ar(factors[(length-1)//2])
                    R=[R[h]+f*rising[h] for h in range(K)]
            polyQ=[(sj-1)*R[h]+(R[h-1] if h else B) for h in range(K)]
            C=[sum((polyQ[h-r]*eb[r] for r in range(h+1)),self.acb(0)) for h in range(K)]
            correction_centers=[];correction_errors=[];products=[];gcoeff=[];gerrors=[];assembly_records=[]
            for h in range(K):
                chat=self.center(C[h]);gamma=self.rad(C[h])
                product=self.point(phase_center)*self.point(chat)
                center=self.center(product);nu=self.rad(product)
                chat_norm=abs(chat[0])+abs(chat[1])
                chi=phase_error*chat_norm+gamma+nu  # A_B= B^-sigma <=1
                require(chi<=EPS_CORRECTION,'complete correction block budget')
                correction_centers.append(self.cw(center));correction_errors.append(qwire(chi))
                products.append(dict(h=h,C_center=self.cw(chat),C_error=qwire(gamma),
                                     point_product=self.cb(product),rounding_error=qwire(nu)))
                value=(sj-1)*self.point(self.main_centers[h][j])+self.point(center)
                if h:value+=self.point(self.main_centers[h-1][j])
                final_center=self.center(value);rounding=self.rad(value)
                require(rounding<=EPS_ASSEMBLY,'final assembly/midpoint budget')
                multiplier=abs(SIGMA-1)+abs(T0+j*DELTA)
                require(multiplier+1<2002,'center factor bound')
                error=multiplier*self.main_errors[h][j]+(self.main_errors[h-1][j] if h else 0)+chi+rounding
                require(error<Q(1,2**53),'actual full-g midpoint budget')
                gcoeff.append({k:{'mid':dwire(c),'rad':dwire(G_HALF)} for k,c in zip(('re','im'),final_center)})
                gerrors.append(qwire(error));assembly_records.append(dict(h=h,point_assembly=self.cb(value),rounding_error=qwire(rounding)))
            result['corrections']['rows'].append(dict(j=j,R=list(map(self.cb,R)),Q=list(map(self.cb,polyQ)),
                C=list(map(self.cb,C)),centers=correction_centers,errors=correction_errors,
                products=products,assembly=assembly_records,full_g_errors=gerrors))
            result['g_jets'].append(dict(j=j,center={'re':qwire(SIGMA),'im':qwire(T0+j*DELTA)},coefficients=gcoeff))


def image_from_coefficients(coefficients,owner,top,bottom):
    require(bottom<=top,'image heights')
    tc=T0+owner*DELTA
    z=((Q(0),Q(0)),(bottom-tc,top-tc))
    require(-RHO<=z[1][0]<=z[1][1]<=RHO,'panel outside own Taylor domain')
    values=[ball_rect(c) for c in coefficients]
    out=values[-1]
    for c in reversed(values[:-1]):out=cadd(cmul(out,z),c)
    pad=E_EM+E_TAYLOR
    out=tuple((lo-pad,hi+pad) for lo,hi in out)
    denominator=((SIGMA-1,SIGMA-1),(bottom,top))
    require(bottom>=1999,'actual-point EM height domain')
    return rectwire(cmul(out,cinv(denominator)))


def images(result,monitor):
    for j in range(J):
        monitor.guard('exact rational panel image',j=j)
        top=Q(2000)-Q(j,8);bottom=top-Q(1,8)
        image=image_from_coefficients(result['g_jets'][j]['coefficients'],j,top,bottom)
        result['panels'].append(dict(index=j,owner=j,top=qwire(top),bottom=qwire(bottom),image=image))
    for r in range(J+1):
        monitor.guard('exact rational endpoint image',r=r)
        owner=min(r,J-1);height=Q(2000)-Q(r,8)
        image=image_from_coefficients(result['g_jets'][owner]['coefficients'],owner,height,height)
        result['endpoints'].append(dict(index=r,owner=owner,height=qwire(height),image=image))


def typed_equal(a,b):
    if type(a) is not type(b):return False
    if isinstance(a,dict):return a.keys()==b.keys() and all(typed_equal(a[k],b[k]) for k in a)
    if isinstance(a,list):return len(a)==len(b) and all(typed_equal(x,y) for x,y in zip(a,b))
    return a==b


def validate_records(result,monitor):
    """Consistency and encoding checks, not a second analytic evaluation."""
    require(typed_equal(result['parameters'],parameters()),'fixed parameter binding')
    require(result['pins']==PINS,'source pin binding')
    for key,count in (('bins',N),('moments',K*P*L),('transforms',K*P*J),
                      ('g_jets',J),('panels',J),('endpoints',J+1),('main_jets',K),('twiddles',31)):
        require(type(result[key]) is list and len(result[key])==count,'array count: '+key)
    for n,row in enumerate(result['bins'],1):
        require(type(row['n']) is int and row['n']==n,'bin source index')
        require(type(row['q']) is int and type(row['k']) is int and row['k']==row['q']%L,'bin integer labels')
        lo,hi=qvalue(row['x']['lo']),qvalue(row['x']['hi']);mid=qvalue(row['mid'])
        require(lo<=mid<=hi and mid==(lo+hi)/2,'bin interval midpoint')
        require(row['q']==(mid+Q(1,2)).numerator//(mid+Q(1,2)).denominator,'bin floor witness')
    for key,width in (('moments',L),('transforms',J)):
        for i,row in enumerate(result[key]):
            if i%512==0:monitor.guard('record validation',section=key,index=i)
            h,m,k=i//(P*width),(i//width)%P,i%width
            expected={'h':h,'m':m,'k' if key=='moments' else 'j':k}
            require(all(type(row[a]) is int and row[a]==b for a,b in expected.items()),'array index binding')
            if key=='transforms':require(type(row['index']) is int and row['index']==(-k)%L,'negative-time DFT index')
            radius=dvalue(row['radius']);require(radius in (Q(0),EPS_MOMENT),'fixed disk radius')
            center=(dvalue(row['center']['re']),dvalue(row['center']['im']))
            box=ball_rect(row['computed'])
            errors=[max(abs(lo-c),abs(hi-c)) for (lo,hi),c in zip(box,center)]
            require(sum(errors)<=radius,'computed rectangle outside claimed norm disk')
            if radius==0:require(center==(Q(0),Q(0)),'zero-radius exception only for exact zero')
    for j,row in enumerate(result['g_jets']):
        require(type(row['j']) is int and row['j']==j,'g row index')
        require(row['center']=={'re':qwire(SIGMA),'im':qwire(T0+j*DELTA)},'g source center')
        require(len(row['coefficients'])==K,'all normalized g jets retained')
        for box in row['coefficients']:
            ball_rect(box)
            require(all(dvalue(box[c]['rad'])==G_HALF for c in ('re','im')),'fixed g square radius')
    require(len(result['elementary']['logs'])==N and len(result['elementary']['base_weights'])==N,'elementary input coverage')
    require(len(result['corrections']['phases'])==J and len(result['corrections']['rows'])==J,'correction coverage')
    for key in ('panels','endpoints'):
        for i,row in enumerate(result[key]):
            require(type(row['index']) is int and row['index']==i,'image index')
            require(type(row['owner']) is int and row['owner']==min(i,J-1),'image owner')
            for axis in ('re','im'):
                require(qvalue(row['image'][axis]['lo'])<=qvalue(row['image'][axis]['hi']),'ordered image interval')
    visits=0
    def walk(x):
        nonlocal visits
        visits+=1
        if visits%2048==0:monitor.guard('payload encoding validation',objects=visits)
        if type(x) is dict:
            if set(x)=={'mantissa','exponent'}:dvalue(x);return
            if set(x)=={'numerator','denominator'}:qvalue(x);return
            require(all(type(k) is str for k in x),'JSON key type')
            for value in x.values():walk(value)
        elif type(x) is list:
            for value in x:walk(value)
        elif type(x) is int:integer(x)
        else:require(x is None or type(x) in (str,bool),'unexpected payload scalar')
    walk(result)
    monitor.guard('complete payload validated')


def own_path(name):
    require(type(name) is str and len(name)<=180 and Path(name).name==name,'output must be a plain filename')
    path=(HERE/name).resolve()
    require(path.parent==HERE and path.suffix=='.json','output must be new JSON in integration')
    return path


def check_manifest(path,code_hash,monitor):
    data=read_json(path)
    expected={'runtime_authorized','producer_code_sha256','parameters','pins','static_review','output','caps'}
    require(type(data) is dict and set(data)==expected,'run manifest keys')
    require(data['runtime_authorized'] is True,'coordinator has not enabled this run')
    require(data['producer_code_sha256']==code_hash,'run manifest source hash')
    require(typed_equal(data['parameters'],parameters()),'run manifest parameters/types')
    require(data['pins']==PINS,'run manifest source pins')
    require(typed_equal(data['caps'],dict(seconds=SECONDS,peak_working_set_bytes=MEMORY,receipt_bytes=MAX_RECEIPT)),
            'run manifest fixed caps')
    review=data['static_review']
    require(type(review) is dict and set(review)=={'path','sha256'},'static review binding')
    require(type(review['path']) is str and type(review['sha256']) is str,'static review field types')
    review_path=(AGENTS/review['path']).resolve()
    require(review_path.is_relative_to(AGENTS) and review_path.suffix=='.md','static review path')
    require(sha(review_path)==review['sha256'],'static review hash mismatch')
    for relative,digest in PINS.items():
        monitor.guard('source pin check',path=relative)
        require(sha(AGENTS/relative)==digest,'frozen source mismatch: '+relative)
    return data,own_path(data['output'])


def serialize_and_publish(result,path,monitor):
    """Only the new attempt's pending file is mutable; no old artifact is touched."""
    pending=path.with_suffix('.pending')
    require(not path.exists() and not pending.exists(),'output/pending already exists')
    encoder=json.JSONEncoder(ensure_ascii=True,allow_nan=False,separators=(',',':'))
    count=0;next_guard=0
    with pending.open('xb') as stream:
        monitor.pending_owned=True
        def write(raw):
            nonlocal count,next_guard
            count+=len(raw);require(count<=MAX_RECEIPT,'64-MiB receipt cap exceeded')
            stream.write(raw)
            if count>=next_guard:
                monitor.guard('receipt serialization',bytes=count);next_guard=count+65536
        write(b'{')
        first=True
        for key,value in result.items():
            require(key not in ('telemetry','status'),'publication-only fields supplied early')
            if not first:write(b',')
            first=False
            write(json.dumps(key).encode('ascii')+b':')
            for chunk in encoder.iterencode(value):write(chunk.encode('ascii'))
        write(b',"telemetry":{"elapsed_seconds":')
        elapsed_offset=stream.tell();write(b'                   0')
        write(b',"peak_working_set_bytes":')
        peak_offset=stream.tell();write(b'                   0')
        write(b',"scope":"after_full_serialization_before_publication",'
              b'"method":"Windows GetProcessMemoryInfo PeakWorkingSetSize",'
              b'"children_spawned":0},"status":"PASS"}\n')
        stream.flush();os.fsync(stream.fileno())
        snapshot=monitor.guard('post-serialization limit check',bytes=count)
        elapsed=f"{snapshot['elapsed_seconds']:20.9f}".encode('ascii')
        peak=f"{snapshot['peak_working_set_bytes']:20d}".encode('ascii')
        require(len(elapsed)==20 and len(peak)==20,'telemetry placeholder width')
        stream.seek(elapsed_offset);stream.write(elapsed)
        stream.seek(peak_offset);stream.write(peak)
        stream.flush();os.fsync(stream.fileno())
        monitor.guard('post-telemetry-write limit check',bytes=count)
    require(pending.stat().st_size==count<=MAX_RECEIPT,'final receipt size')
    require(not path.exists(),'output appeared during run')
    # On Windows rename fails if a destination already exists. No replacement.
    os.rename(pending,path)
    monitor.pending_owned=False;monitor.published_owned=True
    final=monitor.guard('post-publication limit check',bytes=count)
    return count,final


def small_failure(path,code_hash,monitor,exc,result):
    """Keep the attempt marker; remove only its own newly created PASS/pending."""
    for owned,created_here in ((path,monitor.published_owned),(path.with_suffix('.pending'),monitor.pending_owned)):
        if created_here and owned.exists():
            require(owned.resolve().parent==HERE,'failure cleanup escaped owned directory')
            owned.unlink()
    failure=dict(schema=SCHEMA,status='FAIL',producer_code_sha256=code_hash,
                 failure=dict(type=type(exc).__name__,reason=str(exc)[:2000],stage=monitor.stage,
                              context=monitor.context),
                 counts={k:len(result.get(k,[])) for k in ('bins','moments','transforms','g_jets','panels','endpoints')})
    try:failure['telemetry']=monitor.sample()
    except Exception:failure['telemetry']={'available':False}
    raw=json.dumps(failure,separators=(',',':'),allow_nan=False).encode('utf8')
    require(len(raw)<=65536,'failure record bound')
    with path.with_suffix('.failure.json').open('xb') as out:out.write(raw)
    return failure


def main():
    start=time.monotonic()
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--manifest',required=True,help='future coordinator run record; no record is prepared by this code')
    args=parser.parse_args()
    code_hash=sha(__file__);monitor=Monitor(start)
    manifest,path=check_manifest(Path(args.manifest),code_hash,monitor)
    related=[path,path.with_suffix('.pending'),path.with_suffix('.attempt.json'),path.with_suffix('.failure.json')]
    require(all(not p.exists() for p in related),'attempt/output already exists; no restart or overwrite')
    attempt=dict(producer_code_sha256=code_hash,run_manifest_sha256=sha(args.manifest),output=path.name,
                 one_attempt=True,parameters=parameters(),caps=manifest['caps'])
    with path.with_suffix('.attempt.json').open('x',encoding='utf8') as out:
        json.dump(attempt,out,sort_keys=True,indent=2)
    result={}
    try:
        monitor.guard('attempt reserved')
        bn=bernoullis(2*M);budget=scalar_checks(bn)
        result=dict(schema=SCHEMA,producer_code_sha256=code_hash,parameters=parameters(),pins=PINS,
                    analytical_budget=budget,bins=[],moments=[],transforms=[],g_jets=[],panels=[],endpoints=[],main_jets=[])
        engine=Engine(monitor)
        result['software']=dict(python=sys.version,python_flint=str(getattr(engine.flint,'__version__','unknown')),
            scope='external FLINT interval experiment; no independent verification or Lean proof',
            run_manifest_sha256=sha(args.manifest),static_review=manifest['static_review'],
            single_attempt=True,automatic_retuning=False)
        engine.prepare(result);engine.main_sum(result);engine.corrections(result,bn)
        images(result,monitor);validate_records(result,monitor)
        size,final=serialize_and_publish(result,path,monitor)
        print(json.dumps(dict(status='PASS',output=str(path),bytes=size,telemetry=final),sort_keys=True))
        return 0
    except BaseException as exc:
        failure=small_failure(path,code_hash,monitor,exc,result)
        print(json.dumps(failure,sort_keys=True),file=sys.stderr)
        return 1


if __name__=='__main__':
    raise SystemExit(main())
