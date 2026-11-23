"""Conductor101 Cauchy/alpha model: explicit EM only, no builtin zeta.
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
A=16;G=16;K=32;N=512;M=40;ND=640;MD=44;SIG=F(61,200)
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

# Fixed target: all99 primitive chi, sigma=.555, t in[999.875,1000.125].
C=101;ORDER=100;SAMPLES=64;R=F(1,2);RHO=F(1,4);RAD=F(1,8);OUTER=1856502
assert all(C%d for d in range(2,11))
residues=[pow(2,j,C) for j in range(ORDER)]
assert len(set(residues))==100 and sorted(residues)==list(range(1,101))
assert pow(2,50,C)==100
assert F(102)*F(200211,200)/F(11,200)==OUTER
assert F(16)/(SIG+31)<1 and SIG>0
center=acb(ar(F(111,200)),1000)
roots_char=[acb(0,2*arb.pi()*j/ORDER).exp() for j in range(ORDER)]
roots_sample=[acb(0,2*arb.pi()*j/SAMPLES).exp() for j in range(SAMPLES)]
def transform(s,inputs):
 scale=(-s*arb(C).log()).exp()
 return [scale*sum((inputs[j]*roots_char[(k*j)%ORDER] for j in range(ORDER)),acb(0)) for k in range(1,ORDER)]
start=time.perf_counter();sampling_start=start;samples=[];max_error=arb(0)
for j,w in enumerate(roots_sample):
 s=center+ar(RHO)*w
 assert abs(s)<1002
 grid,err=materialize(s)
 if err.upper()>max_error.upper():max_error=err
 inputs=[alpha_eval(s,F(a,C),grid) for a in residues]
 outputs=transform(s,inputs)
 assert all(v.is_finite() for v in outputs)
 samples.append(outputs)
 if time.perf_counter()-start>90:raise RuntimeError('bounded sample time exceeded; target not certified')
sampling_seconds=time.perf_counter()-sampling_start
begun=time.perf_counter()
coeffs=[[sum((samples[j][k]*roots_sample[(-j*n)%SAMPLES] for j in range(SAMPLES)),acb(0))/SAMPLES for n in range(SAMPLES)] for k in range(99)]
dft_seconds=time.perf_counter()-begun
alias=F(OUTER)/(1-RAD/R)*((RAD/R)**SAMPLES+(RHO/R)**SAMPLES/(1-(RHO/R)**SAMPLES))
assert alias<F(14,10**14)
def model(k,lo,hi):
 z=acb(0,arb(ar((lo+hi)/2),ar((hi-lo)/2)))/ar(RHO);v=acb(0)
 for a in reversed(coeffs[k-1]):v=v*z+a
 return v+eb(ar(alias))
def halfplane(v):
 for axis,iv in enumerate((v.real,v.imag)):
  for sign in(1,-1):
   if sign*iv>0:return [axis,sign]
 return None
begun=time.perf_counter();char_results=[];total_calls=0
for k in range(1,100):
 leaves=[];stack=[(-RAD,RAD,0)];maxdepth=0
 while stack:
  lo,hi,depth=stack.pop();v=model(k,lo,hi);total_calls+=1;h=halfplane(v)
  if h is not None:
   leaves.append({'lo':str(lo),'hi':str(hi),'witness':h,'image_diagnostic':str(v)})
   maxdepth=max(maxdepth,depth)
  else:
   if depth>=20 or total_calls>=100000:raise RuntimeError('bounded panel limit exceeded; target not certified')
   mid=(lo+hi)/2;stack.extend([(mid,hi,depth+1),(lo,mid,depth+1)])
 assert F(leaves[0]['lo'])==-RAD and F(leaves[-1]['hi'])==RAD
 assert all(a['hi']==b['lo'] for a,b in zip(leaves,leaves[1:]))
 char_results.append({'k':k,'parity':'odd' if k%2 else 'even','panels':leaves,'maxdepth':maxdepth})
 if time.perf_counter()-start>120:raise RuntimeError('bounded total time exceeded')
panel_seconds=time.perf_counter()-begun
# Independent-parameter direct EM at three actual points. No builtin calls.
begun=time.perf_counter();checks=[]
for offset in [-RAD,F(0),RAD]:
 s=center+acb(0,ar(offset))
 vals=[scalar_em(s,F(a,C),ND,MD,F(111,200)) for a in residues]
 direct=transform(s,vals)
 assert all(model(k,offset,offset).overlaps(direct[k-1]) for k in range(1,100))
 checks.append({'t_offset':str(offset),'all99_overlap_direct_EM':True})
direct_seconds=time.perf_counter()-begun
out={'status':'LOCAL_ALL99_PRIMITIVE_BLOCK_NONVANISHING_EXTERNAL_ONLY','parameters':{'c':101,'generator':2,'character_indices':list(range(1,100)),'center':['111/200','1000'],'target_offsets':['-1/8','1/8'],'sampling_sigma_floor':str(SIG),'outer_sigma_floor':'11/200','R':str(R),'rho':str(RHO),'r':str(RAD),'samples':SAMPLES,'outer_M':OUTER,'alpha_A':A,'alpha_cells':G,'alpha_K':K,'EM_N':N,'EM_M':M,'direct_N':ND,'direct_M':MD,'bits':ctx.prec},'alpha_error_exact':str(E),'cauchy_error_exact':str(alias),'cauchy_error_float_diagnostic':float(alias),'max_unmultiplied_EM_input_error':str(max_error),'max_sample_radius_L1_diagnostic':max(radius(v) for row in samples for v in row),'min_sample_relative_accuracy_bits':min(v.rel_accuracy_bits() for row in samples for v in row),'max_Cauchy_coefficient_radius_L1_diagnostic':max(radius(v) for row in coeffs for v in row),'sampling_seconds':sampling_seconds,'cauchy_DFT_seconds':dft_seconds,'panels_seconds':panel_seconds,'direct_comparison_seconds':direct_seconds,'total_seconds':time.perf_counter()-start,'total_panel_calls':total_calls,'total_accepted_panels':sum(len(v['panels']) for v in char_results),'max_panels_per_character':max(len(v['panels']) for v in char_results),'maxdepth':max(v['maxdepth'] for v in char_results),'direct_checks':checks,'flint_version':flint.__FLINT_VERSION__,'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'characters':char_results,'scope':'Only stated vertical block, no full contour or winding or Hcert. Elementary interval operations external; analytic contracts require proof bridge.'}
if '--recompute' not in sys.argv:PATH.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='characters'},indent=2))

