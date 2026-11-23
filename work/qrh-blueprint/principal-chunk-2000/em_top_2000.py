"""Short top path at T2000 using explicit finite-EM Taylor models only.
No builtin zeta/Gamma/RS or long vertical run. Budget120s.
"""
from fractions import Fraction as F
from math import comb,factorial,ceil
from pathlib import Path
import time,json,hashlib,sys,ctypes
from ctypes import wintypes
from flint import arb,acb,acb_series,ctx
ctx.prec=128;ctx.cap=24
T=2000;N=ceil(F(T,3));B=N+1;M=32;K=24;R=F(1);H=F(1,8);LEFT=F(1,2)
PATH=Path(__file__).with_suffix('.json');started=time.perf_counter()
def limit():
 if time.perf_counter()-started>120:raise RuntimeError('120second budget exceeded')
def ar(q):
 q=F(q);return arb(str(q.numerator))/q.denominator
def eb(r):
 e=arb(0,r.upper());return acb(e,e)
def rb(x):return [str(x.lower().fmpq()),str(x.upper().fmpq())]
def cb(z):return {'re':rb(z.real),'im':rb(z.imag)}
class PM(ctypes.Structure):
 _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[(n,ctypes.c_size_t) for n in ['PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage']]
def memory():
 p=PM();p.cb=ctypes.sizeof(p);kernel=ctypes.WinDLL('kernel32');kernel.GetCurrentProcess.restype=wintypes.HANDLE
 getmem=ctypes.WinDLL('psapi').GetProcessMemoryInfo;getmem.argtypes=[wintypes.HANDLE,ctypes.POINTER(PM),wintypes.DWORD];getmem.restype=wintypes.BOOL
 ok=getmem(kernel.GetCurrentProcess(),ctypes.byref(p),p.cb)
 return {'working_set_bytes':p.WorkingSetSize,'peak_working_set_bytes':p.PeakWorkingSetSize} if ok else {'unavailable':True}
logstart=time.perf_counter();logs=[]
for n in range(1,N+1):
 logs.append(ar(n).log())
 if n%8192==0:limit()
logseconds=time.perf_counter()-logstart;lb=ar(B).log()
bern=[F(1)]
for n in range(1,2*M+1):bern.append(-sum(F(comb(n+1,k))*bern[k] for k in range(n))/F(n+1))
coeff=[ar(bern[2*k]/factorial(2*k)) for k in range(1,M+1)]
powers=[ar(B)**(1-2*k) for k in range(1,M+1)]
def model(center):
 begin=time.perf_counter();s=acb_series([acb(ar(center),T),1],prec=K);v=acb_series([0],prec=K)
 for n,l in enumerate(logs):
  v+=(-s*l).exp()
  if n%4096==0:limit()
 bp=(-s*lb).exp();v+=bp/2;poch=acb_series([1],prec=K);terms=acb_series([0],prec=K)
 for j in range(1,2*M):
  poch*=s+j-1
  if j%2==1:
   k=(j+1)//2;terms+=coeff[k-1]*poch*powers[k-1]
 v=(s-1)*(v+bp*terms)+((1-s)*lb).exp();jet=[v[j] for j in range(K)]
 # Entire finite g on outer radius1; no EM theorem is invoked there.
 S=abs(acb(ar(center),T))+ar(R);sigma=ar(center-R)
 sm=ar(N)*(ar(N)**(-sigma) if center-R<0 else arb(1))
 bp0=(-sigma*lb).exp();sm+=bp0/2;poch0=arb(1);corr=arb(0)
 for j in range(1,2*M):
  poch0*=S+j-1
  if j%2==1:
   k=(j+1)//2;corr+=abs(coeff[k-1])*poch0*powers[k-1]
 outer=(S+1)*(sm+bp0*corr)+((1-sigma)*lb).exp()
 # Actual target points have sigma>=1/2; EM is separate from finite-g Taylor.
 Sa=abs(acb(ar(center),T))+ar(H);poch1=arb(1)
 for j in range(2*M):poch1*=Sa+j
 em=(Sa+1)*4*poch1*(lb*(1-ar(LEFT)-2*M)).exp()/(6**(2*M)*(ar(LEFT)+2*M-1))
 tay=outer*ar(H/R)**K/(1-ar(H/R));err=em+tay
 def image(lo,hi):
  z=acb(arb(ar((lo+hi)/2-center),ar((hi-lo)/2)));ans=jet[-1]
  for a in reversed(jet[:-1]):ans=ans*z+a
  ss=acb(arb(ar((lo+hi)/2),ar((hi-lo)/2)),T)
  return (ans+eb(err))/(ss-1)
 return image,{'center':str(center),'jet_seconds':time.perf_counter()-begin,'outer_bound':rb(outer),'EM_error_zetaF':rb(em),'Taylor_error_zetaF':rb(tay),'coefficients_zetaF':[cb(v) for v in jet]}
rows=[];endpoints={};status='INCOMPLETE';reason='not started'
try:
 # Harder leftmost block is tested first. All retained models share endpoint balls.
 centers=[F(5,8),F(7,8),F(9,8),F(11,8),F(13,8),F(15,8)]
 firstcost=None
 for idx,c in enumerate(centers):
  limit()
  if firstcost is not None and time.perf_counter()-started+1.3*firstcost*(6-idx)>120:
   raise RuntimeError('first-block cost predicts remaining blocks exceed budget')
  image,row=model(c);firstcost=firstcost or row['jet_seconds'];lo,hi=c-H,c+H;v=image(lo,hi)
  assert v.real>0,'whole quarter block not in right half-plane'
  row.update({'left':str(lo),'right':str(hi),'zeta_image':cb(v)})
  for x in [lo,hi]:
   value=image(x,x);assert value.real>0
   if x in endpoints:assert value.overlaps(endpoints[x])
   else:endpoints[x]=value
  rows.append(row)
  print(json.dumps({'progress_blocks':len(rows),'seconds':time.perf_counter()-started,'last_block_seconds':row['jet_seconds'],'memory':memory()}),flush=True)
 status='PASS_EXPLICIT_EM_TOP_PATH';reason='six complete quarter blocks, all Re(zeta)>0'
except RuntimeError as e:reason=str(e)
result={'status':status,'reason':reason,'T':T,'N':N,'M':M,'K':K,'outer_radius':str(R),'target_radius':str(H),'sigma_floor_EM':str(LEFT),'precision_bits':ctx.prec,'log_init_seconds':logseconds,'elapsed_seconds':time.perf_counter()-started,'memory':memory(),'blocks':rows,'endpoints':{str(k):cb(v) for k,v in sorted(endpoints.items())},'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'scope':'Short top horizontal path only; no builtin special evaluator or vertical millionheight run.'}
if status.startswith('PASS'):
 assert sorted(endpoints)==[F(1,2)+F(j,4) for j in range(7)]
 assert endpoints[F(2)].real>ar(F(1,4))
 # All blocks and the canonical sigma2 vertical path lie in Re(zeta)>0.
 Sarg=endpoints[F(1,2)].log().imag/arb.pi()
 main=ar(T)/(2*arb.pi())*((ar(T)/(2*arb.pi())).log()-1)+ar(F(7,8))
 count=main+Sarg+arb(0,ar(F(1,8)))
 lo,hi=map(F,rb(count));ni=-((-lo.numerator)//lo.denominator);nj=hi.numerator//hi.denominator
 assert ni==nj
 result.update({'S':rb(Sarg),'F_main':rb(main),'count_interval':rb(count),'unique_integer':ni,'count_contract':'Reviewed source normalized count and Binet error1/8, not numerically evaluated Gamma.'})
if '--recompute' not in sys.argv:PATH.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in('blocks','endpoints')},indent=2))

