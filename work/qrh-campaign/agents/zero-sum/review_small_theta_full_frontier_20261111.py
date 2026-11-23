"""Exact selector/period reconstruction only; no analytic values."""
from pathlib import Path
from fractions import Fraction as F
from collections import Counter
import json,hashlib
A=Path(__file__).resolve().parents[1]
pins={
'audit/ALL_THETA_TIME_LENGTH_FRONTIER_2026-11-11.md':'BD024EE476AD011DCF47F7BFAA95D984FA061F05AAFFDBBCFC0D215294A657A0',
'audit/small_theta_length_frontier_20261111.py':'10793282DD8C990CCE2C66D987115233EEE86DB7DE4237C62FD6183038E3A91B',
'audit/small_theta_length_frontier_final_20261111.json':'97DB46A0EEA2BFB064433F425D828BA309B85287A312B19BBCEE3D2C516DD78D'}
checks=0
def ck(v):
 global checks
 checks+=1
 assert v,checks
def load(p):return json.loads((A/p).read_text())
def ceil(q):return (q.numerator+q.denominator-1)//q.denominator
def bits(q):
 b=0
 while q.numerator*2**b<q.denominator:b+=1
 return b
f=load('audit/small_theta_length_frontier_final_20261111.json')
pins.update(f['pins'])
for p,h in pins.items():ck(hashlib.sha256((A/p).read_bytes()).hexdigest().upper()==h)
old=load('prime-estimates/small_family_minimal_theta_20261111.json')
base=load('prime-estimates/small_family_theta_inventory_final_20261111.json')
ad=load('prime-estimates/adaptive_small_theta_interpolation_20261111.json')
saved={(r['odd'],r['theta']):r for r in old['selectors']}
orders={(r['odd'],r['theta']):r['order'] for r in ad['parameters']}
pars={};n0=8192;C=44;BP=2*3**33;MC=3**11+1
for odd in [False,True]:
 for theta in range(64,129):
  W=F(80000000 if not odd else 40000000,theta);eps=F(1,2**82*3**theta)
  K=next(k for k in range(1,1000) if 128*W**2*3**k<eps*8**k)
  L=next(k for k in range(1,1000) if 48*W*3**k<eps*8**k)
  ck(F(8,3)**20>=W*(20+L))
  v0=3*n0*n0/W;z0=3*(2*n0+1)/W-F(1,n0)
  ck(v0>=2 and z0>0)
  tail=C*2*n0*(1+1/z0)*F(3,8)**(v0.numerator//v0.denominator)
  ck(tail<eps/8)
  p=bits(eps/(192*C*BP*n0**4));delta=F(1,2**p)
  epref=eps/(64*C*(n0*n0+2));D=min(delta/16,1/W)
  sigma=min(F(1,4),D/(64*MC**4),epref/(16*MC**3),F(1,16*n0))
  ck(6*delta<=eps/(32*C*BP*n0**4))
  ck(15*MC**4*sigma<D and 7*MC**3*sigma<epref and 4*n0*sigma<=F(1,4))
  s=saved[odd,theta]
  ck([K,L,p]==[s['K'],s['L'],s['seed_bits']])
  ck([W,eps,sigma,tail]==[F(s[k]) for k in ['W','eps','sigma','tail']])
  ck(D==delta/16 and sigma==delta/(1024*MC**4))
  pars[odd,theta]=(K,W,eps,delta,sigma)
 for theta in range(64,128):
  _,W,e,d,s=pars[odd,theta];_,W2,e2,d2,s2=pars[odd,theta+1]
  ck(e==3*e2 and d>=2*d2 and s>=2*s2)
  for aa,bb in [(2,1),(2,2),(88,47)]:
   ck(e/(aa*W*W+bb)>2*e2/(aa*W2*W2+bb))
   ck(aa*W*W+bb<2*(aa*W2*W2+bb))
  ck(orders[odd,theta]<=orders[odd,theta+1])

def factor(n):
 out=[];p=2
 while p*p<=n:
  if n%p==0:
   e=0
   while n%p==0:n//=p;e+=1
   out.append((p,e))
  p+=1
 if n>1:out.append((n,1))
 return out
# Primitive cardinalities from divisor subtraction, independent of product rule.
phi=list(range(10001));prim=[0]*10001
for p in range(2,10001):
 if phi[p]==p:
  for n in range(p,10001,p):phi[n]-=phi[n]//p
for n in range(1,10001):
 prim[n]+=phi[n]
 for m in range(2*n,10001,n):prim[m]-=prim[n]
cs=[c for c in range(3,10001) if c%2 or c%4==0]
ck(len(cs)==7499 and sum(prim[c] for c in cs)==18477108)
def grid(c,extra):
 odd=c%2==1;i=sum(c>=a for a in [100,1000,10000])
 u=([F(21),F(20),F(39,2),F(96,5)] if odd else [F(113,5),F(211,10),F(201,10),F(191,10)])[i]
 H=ceil(200+max(F(240 if odd else 255),F(3927,1250)*u*F(531600 if odd else 1063200,c)))
 return (64*H+4)//5+extra
def length(m,K,theta):
 N=8
 while N*theta<2*m*K or 5*N<5*m+128*K or 5*N<384:N*=2
 return N
def delta_counts(c,m,Nold,Nnew,keys):
 n=prim[c];v=phi[c];h=1 if c in [3,4,12] else 2;o=int(c!=12)
 axes=[]
 for p,e in factor(c):
  if p!=2:axes.append((p-1)*p**(e-1))
  elif e==2:axes.append(2)
  else:axes += [2,2**(e-2)]
 g=pp=ss=0
 for a in axes:
  if a&(a-1)==0:g+=v*(a.bit_length()-1)//2
  else:
   P=1
   while P<2*a-1:P*=2
   g+=v//a*P*(P.bit_length()-1);pp+=v//a*(P+2*a);ss+=v//a*P
 def dim(N):
  R=(25*N+191)//192+1
  T=ceil(F(8192)*(1+F(5*N,192))+R)
  return R,T
 ro,to=dim(Nold);rn,tn=dim(Nnew);dr,dt=ro-rn,to-tn
 out=dict.fromkeys(keys,0)
 out.update(Gaussian_terms_upper=dt,Gaussian_unit_gates_upper=2*dt,bucket_additions_upper=h*dt,
  odd_integer_scales_upper=o*dt,outer_complex_exp_upper=dr,Gaussian_seed_unit_contractions_upper=dr,
  main_character_calls=h*dr,main_character_butterflies=h*dr*g,main_character_point_products=h*dr*pp,
  main_character_inverse_dyadic_scales=h*dr*ss,prefactor_contraction_complex_products=n*dr,
  radial_argument_prefactor_real_products=(5+o+2*n)*dr,cutoff_rational_divisions=dr,
  time_root_cis_upper=(Nold-Nnew)//2,time_butterflies=n*(Nold*(Nold.bit_length()-1)-Nnew*(Nnew.bit_length()-1))//2,
  time_dft_complex_outputs=n*(Nold-Nnew),frequency_conjugate_copies=n*dr)
 return out
exceptions=[];enums=0;groups_total=0
for sc in f['scenarios']:
 extra=sc['extra_nodes'];diff=Counter();hist=Counter()
 sv=next(s for s in old['scenarios'] if s['extra_nodes']==extra)
 ck(len(sc['cells'])==len(cs))
 for ix,(c,cell) in enumerate(zip(cs,sc['cells'])):
  m=grid(c,extra);by={}
  for th in range(64,129):
   K,W,eps,_,_=pars[c%2==1,th];N=length(m,K,th);enums+=1
   ck(N*th>=2*m*K and 5*N>=5*m+128*K and 5*N>=384)
   ck(N==8 or (N//2)*th<2*m*K or 5*(N//2)<5*m+128*K or 5*(N//2)<384)
   by.setdefault(N,[]).append(th)
  expected=[c,m,[[N,min(ths)] for N,ths in sorted(by.items())]]
  ck(cell==expected)
  ck(len(by) in [1,2] and min(by[max(by)])==64)
  if len(by)==2:ck(max(by)==2*min(by))
  N64=length(m,pars[c%2==1,64][0],64);N128=length(m,pars[c%2==1,128][0],128)
  ck(min(th for N,ths in by.items() if N<=N128 for th in ths)==sv['choice_in_increasing_active_conductor_order'][ix])
  for N,ths in by.items():
   th=min(ths);K,W,eps,_,_=pars[c%2==1,th];V=F(5*m,64);J=(25*N+191)//192
   ck(V>=2*th and 1<=c*V/th<=W)
   ck(N>=2**18 and J<N//2 and N>orders[c%2==1,th] and m+1<=N)
   ck(F(22*J,7*N)<F(160919,393216) and eps*7*F(5*N,64)/2816<1)
  hist[len(by)]+=1;groups_total+=len(by)
  if min(by)<min(N64,N128):
   exceptions.append((extra,c))
   x=next(x for x in f['non_endpoint_patterns'] if x['extra']==extra and x['c']==c)
   ck(x['length_groups']=={str(N):ths for N,ths in sorted(by.items())})
   ck(by[min(by)]==[127])
  diff.update(delta_counts(c,m,N128,min(by),sc['all_N128_policy_counts']))
 ck({str(k):v for k,v in hist.items()}==sc['option_histogram'])
 ck(sum(k*v for k,v in hist.items())==sc['retained_options'])
 ck(dict(diff)==sc['N128_minus_minimum_N_counts'])
 for key,val in sc['all_N128_policy_counts'].items():ck(val-diff[key]==sc['all_minimum_N_policy_counts'][key])
 for th,key in [(128,'all_N128_policy_counts'),(64,'all_theta64_policy_counts')]:
  bt=next(s['totals'] for s in base['scenarios'] if s['theta']==th and s['extra_nodes']==extra)
  ck(all(bt[k]==v for k,v in sc[key].items()))
ck(len(exceptions)==18==len(f['non_endpoint_patterns']))
ck(enums==1949740==f['theta_rows_enumerated'])
ck(groups_total==44585)
# Verify the actual displayed exception table, not only its JSON source.
note=(A/'audit/ALL_THETA_TIME_LENGTH_FRONTIER_2026-11-11.md').read_text()
table=[]
for line in note.splitlines():
 vals=[v.strip() for v in line.strip().strip('|').split('|')]
 if line.startswith('|') and len(vals)==7 and all(v.lstrip('-').isdigit() for v in vals):
  table.append([int(v) for v in vals])
ck(len(table)==18)
for extra,c,m,N,sl1,sl2,sl128 in table:
 ck((extra,c) in exceptions and m==grid(c,extra))
 ck([sl1,sl2,sl128]==[127*N-462*m,5*N-5*m-29568,128*N-466*m])
 ck(sl1>=0 and sl2>=0 and sl128<0 and 127*(N//2)<462*m)
out={'status':'PASS exact dimension frontier and conditional budget relations','checks':checks,'pins':pins,
 'theta_rows':enums,'retained_groups':groups_total,'interior_exceptions':exceptions,
 'scope':'No analytic values; no runtime, sign success or universal width dominance.'}
with Path(__file__).with_name('review_small_theta_full_frontier_final_20261111.json').open('x',encoding='utf8',newline='\n') as g:json.dump(out,g,indent=2);g.write('\n')
print(json.dumps({'checks':checks,'status':out['status'],'exceptions':len(exceptions)}))
