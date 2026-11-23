"""Materialized Hurwitz alpha grid: explicit EM only, no builtin zeta.
Whole s-panel enclosures compared to independent-parameter direct EM.
No zero-free/whole-contour/Lean assertion.
"""
from fractions import Fraction as F
from math import comb,factorial,prod
from pathlib import Path
import json,time,hashlib,sys
from flint import arb,acb,ctx
import flint
ctx.prec=160
A=16;G=16;K=32;N=512;M=40;ND=640;MD=44;SIG=F(111,200)
PATH=Path(__file__).with_suffix('.json')
def ar(q):
 q=F(q);return arb(str(q.numerator))/q.denominator
def eb(r):
 e=arb(0,r.upper());return acb(e,e)
def bernoulli(n):
 b=[F(1)]
 for j in range(1,n+1):b.append(-sum(F(comb(j+1,k))*b[k] for k in range(j))/F(j+1))
 return b
bb=bernoulli(2*MD)
co=[ar(bb[2*k]/factorial(2*k)) for k in range(1,MD+1)]
def exprel(z):
 assert abs(z)<1
 term=v=acb(1)
 for k in range(1,33):term=term*z/(k+1);v+=term
 return v+eb(abs(z).exp()*abs(z)**33/factorial(34))
def pole_integral(s,lb,deflate):
 if not deflate:return ((1-s)*lb).exp()/(s-1)
 z=(1-s)*lb
 if abs(z)<1:return -lb*exprel(z)
 assert not (s-1).contains(0)
 return (z.exp()-1)/(s-1)

def scalar_em(s,alpha,n,m,sig,deflate=True):
 # Independent direct path: computes its own powers/logs at the target alpha.
 B=ar(n+alpha);lb=B.log();poch=acb(1)
 vals=sum(((-s*ar(j+alpha).log()).exp() for j in range(n)),acb(0))
 bp=(-s*lb).exp();vals+=bp/2
 for j in range(1,2*m+1):
  poch*=s+j-1
  if j%2==1:
   k=(j+1)//2;vals+=co[k-1]*poch*B**(1-2*k)*bp
 err=4*abs(poch)*B**(1-ar(sig)-2*m)/(6**(2*m)*(ar(sig)+2*m-1))
 return vals+pole_integral(s,lb,deflate)+eb(err)

grid_pre=[]
for cell in range(G):
 alpha=F(A)+F(2*cell+1,2*G)
 xs=[ar(j+alpha) for j in range(N)];B=ar(N+alpha)
 grid_pre.append((alpha,[x.log() for x in xs],[1/x for x in xs],B,B.log(),[B**(1-2*k) for k in range(1,M+1)]))

def materialize(s):
 grid=[];max_em=arb(0)
 # Multipliers (-1)^k(s)_k/k! are built once for all alpha centers.
 mul=[acb(1)]
 for k in range(1,K):mul.append(-mul[-1]*(s+k-1)/k)
 for alpha,logs,invs,B,lb,powers in grid_pre:
  terms=[(-s*l).exp() for l in logs];bp=(-s*lb).exp();row=[]
  for k in range(K):
   sk=s+k;poch=acb(1);z=sum(terms,acb(0))+bp/2
   for j in range(1,2*M+1):
    poch*=sk+j-1
    if j%2==1:z+=co[(j-1)//2]*poch*powers[(j-1)//2]*bp
   err=4*abs(poch)*B**(1-ar(SIG)-k-2*M)/(6**(2*M)*(ar(SIG)+k+2*M-1))
   if err.upper()>max_em.upper():max_em=err
   z+=pole_integral(sk,lb,k==0)+eb(err)
   row.append(mul[k]*z)
   if k+1<K:
    terms=[v*w for v,w in zip(terms,invs)];bp/=B
  grid.append(row)
 return grid,max_em
E=F(2*prod(1002+j for j in range(K)),(2*G*A)**K*factorial(K))
assert E<F(1,10**25)
def alpha_eval(s,alpha,grid):
 cell=min(G-1,(G*alpha.numerator)//alpha.denominator)
 delta=ar(alpha-F(2*cell+1,2*G));v=acb(0)
 for c in reversed(grid[cell]):v=v*delta+c
 v+=eb(ar(E))
 v+=sum(((-s*ar(j+alpha).log()).exp() for j in range(A)),acb(0))
 return v

def radius(z):return float(z.real.rad()+z.imag.rad())
cases=[('height100','111/200','100','0','1/512'),('height1000','111/200','1000','0','1/512'),('through_pole','1','0','1/512','1/512'),('height1000_point_diagnostic','111/200','1000','0','0'),('height1000_narrow_diagnostic','111/200','1000','0','1/1048576')]
start=time.perf_counter();out={'scope':'Finite whole-panel evaluator comparison only; no builtin zeta/Hurwitz acceptance or contour assertion.','parameters':{'conductor':101,'A':A,'grid_cells':G,'K':K,'EM_N':N,'EM_M':M,'direct_N':ND,'direct_M':MD,'bits':ctx.prec,'sigma_min':str(SIG),'alpha_error_exact':str(E)},'flint':flint.__FLINT_VERSION__,'runs':[]}
for name,re,im,rr,ri in cases:
 s=acb(arb(ar(re),ar(rr)),arb(ar(im),ar(ri)))
 assert abs(s)<1002
 begun=time.perf_counter();grid,maxem=materialize(s);gridtime=time.perf_counter()-begun
 begun=time.perf_counter();fast=[alpha_eval(s,F(a,101),grid) for a in range(1,101)];evaltime=time.perf_counter()-begun
 begun=time.perf_counter();direct=[scalar_em(s,F(a,101),ND,MD,SIG) for a in range(1,101)];directtime=time.perf_counter()-begun
 overlaps=[v.overlaps(w) for v,w in zip(fast,direct)]
 assert all(v.is_finite() and w.is_finite() for v,w in zip(fast,direct))
 assert all(overlaps)
 out['runs'].append({'name':name,'s_center':[re,im],'s_radii':[rr,ri],'all100_overlap':all(overlaps),'grid_seconds':gridtime,'evaluate100_seconds':evaltime,'direct100_seconds':directtime,'max_input_EM_error':str(maxem),'max_grid_radius':max(map(radius,fast)),'max_direct_radius':max(map(radius,direct)),'min_grid_accuracy_bits':min(v.rel_accuracy_bits() for v in fast),'min_direct_accuracy_bits':min(v.rel_accuracy_bits() for v in direct),'samples':[{'a':a,'grid':str(fast[a-1]),'direct':str(direct[a-1])} for a in [1,25,50,75,100]]})
 if time.perf_counter()-start>90:raise RuntimeError('bounded pilot time limit reached')
out['wall_seconds']=time.perf_counter()-start
out['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
if '--recompute' not in sys.argv: PATH.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({**out,'runs':[{k:v for k,v in r.items() if k!='samples'} for r in out['runs']]},indent=2))


