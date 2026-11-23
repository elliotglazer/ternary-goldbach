"""Exact interpolation kernels and schedule metadata; no function values."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
from collections import Counter
import hashlib, json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'prime-estimates/MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md':'73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A',
 'prime-estimates/CLARIFICATION_MINIMAL_THETA_BUCKET_ROUNDING_2026-11-11.md':'4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41',
 'prime-estimates/small_family_minimal_theta_20261111.json':'25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422',
 'audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md':'58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B',
 'integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md':'19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081',
 'moebius/REVIEW_SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md':'B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F',
 'integration/MINIMAL_THETA_INTERPOLATION_APPLICABILITY_2026-11-11.md':'BEE442CFF66187EAEEC930441D0AE414725A198A72B394A47701DB27E1D6B8FC',
}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def ceil(x):return -(-x.numerator//x.denominator)
def minimum_even(M,q,eps):
 r=2
 while M*q**r>=eps/16:r+=2
 ck(M*q**r<eps/16)
 ck(r==2 or M*q**(r-2)>=eps/16)
 return r
def factors(n):
 out=[];p=2
 while p*p<=n:
  if n%p==0:
   e=0
   while n%p==0:n//=p;e+=1
   out.append((p,e))
  p+=1
 if n>1:out.append((n,1))
 return out
def primitive(c):
 n=1
 for p,e in factors(c):n*=p-2 if e==1 else (p-1)**2*p**(e-2)
 return n
def height(c):
 band=0 if c<100 else 1 if c<1000 else 2 if c<10000 else 3
 us=([Q(21),Q(20),Q(39,2),Q(96,5)] if c%2 else [Q(113,5),Q(211,10),Q(201,10),Q(191,10)])
 return ceil(200+max(Q(240 if c%2 else 255),Q(3927,1250)*us[band]*Q(531600 if c%2 else 1063200,c)))
def nfft(m,K,theta):
 v=max(ceil(Q(2*m*K,theta)),ceil(Q(5*m+128*K,5)),ceil(Q(384,5)))
 return max(8,1<<(v-1).bit_length())

for name,h in PINS.items():ck(hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper()==h)
previous=json.loads((HERE/'small_family_minimal_theta_20261111.json').read_text())
oldq=Q(605,1344)
q=Q(22,7)*(Q(25,192)+Q(1,2**18))
ck(0<q<oldq<Q(1,2))
parameters={}
for p in previous['selectors']:
 theta,odd=p['theta'],p['odd'];W=Q(p['W']);eps=Q(p['eps']);M=44*(2*W*W+1)
 ck(W==Q(40000000 if odd else 80000000,theta))
 ck(eps==Q(1,2**82*3**theta))
 r=minimum_even(M,q,eps);rold=minimum_even(M,oldq,eps)
 ck(r<=rold<=340)
 parameters[odd,theta]=dict(theta=theta,odd=odd,W=str(W),M=str(M),epsilon=str(eps),order=r,
  old_bandwidth_order=rold,remainder_over_epsilon=str(M*q**r/eps),K=p['K'])

# Exact kernel generation by the closed denominator formula.
orders=sorted({p['order'] for p in parameters.values()})
kernels=[]
for r in orders:
 m=r//2;nodes=list(range(1-m,m+1));facts=[factorial(j) for j in range(r)]
 rows=[]
 for ell in range(1,8):
  prod=1
  for j in nodes:prod*=ell-8*j
  weights=[]
  for j in nodes:
   den=(ell-8*j)*8**(r-1)*(-1)**(m-j)*facts[j+m-1]*facts[m-j]
   weights.append(Q(prod,den))
  lam=sum(map(abs,weights))
  ck(lam<4)
  for d in range(3):ck(sum(w*j**d for w,j in zip(weights,nodes))==Q(ell,8)**d)
  digest=hashlib.sha256('\n'.join(str(w) for w in weights).encode()).hexdigest().upper()
  rows.append(dict(offset=f'{ell}/8',Lebesgue=str(lam),upper_thousandths=ceil(1000*lam),weight_digest=digest))
 for i in range(3):ck(rows[i]['Lebesgue']==rows[6-i]['Lebesgue'])
 kernels.append(dict(order=r,nodes=[nodes[0],nodes[-1]],offsets=rows))

family=[(c,primitive(c),height(c)) for c in range(3,10001) if c%2 or c%4==0]
ck(len(family)==7499 and sum(n for c,n,h in family)==18477108)
scenarios=[];used=set();rowhash=hashlib.sha256()
for scen in previous['scenarios']:
 e=scen['extra_nodes'];hist=Counter();query_hist=Counter();terms=oldterms=queries=0;oldqterms=0
 for (c,n,H),theta in zip(family,scen['choice_in_increasing_active_conductor_order'],strict=True):
  p=parameters[c%2==1,theta];m=ceil(Q(64*H,5))+e;N=nfft(m,p['K'],theta)
  p128=parameters[c%2==1,128]
  ck(N==nfft(m,p128['K'],128))
  ck(N>=2**18 and N>p['order'] and m+1<=N)
  J=ceil(Q(25*N,192))
  ck(Q(22*J,7*N)<=q)
  r=p['order'];used.add(r);hist[r]+=1
  nquery=7*n*m
  queries+=nquery;terms+=nquery*r;oldterms+=340*nquery;oldqterms+=nquery*p['old_bandwidth_order'];query_hist[r]+=nquery
  # Per-query allocation if all weight/product/sum rounding has real error v.
  M=Q(p['M']);eps=Q(p['epsilon']);v=eps/(16*r*(M+3))
  ck(r*(M+1)*v+(2*r)*v==eps/16)
  rowhash.update(json.dumps([e,c,theta,N,r,nquery],separators=(',',':')).encode())
 ck(queries==7*(scen['counts_identical_to_theta128']['primitive_grid_outputs']-18477108))
 ck(sum(hist.values())==7499 and sum(query_hist.values())==queries)
 scenarios.append(dict(extra_nodes=e,order_conductor_histogram=dict(sorted(hist.items())),
  order_query_histogram=dict(sorted(query_hist.items())),new_endpoints=queries,real_products=terms,
  real_additions=terms-queries,rounding_gates=2*terms,sample_accesses=terms,
  fixed340_products=oldterms,old_bandwidth_adaptive_products=oldqterms,
  saved_products=oldterms-terms,remaining_fraction=str(Q(terms,oldterms))))
ck(used==set(orders))
out=dict(status='PASS_EXACT_ADAPTIVE_ORDERS_LEBESGUE_AND_FULL_RANGE_SCHEDULE',checks=checks,
 pins=PINS,bandwidth_halfstep_bound=str(q),old_bound=str(oldq),min_N=2**18,
 parameters=list(parameters.values()),kernels=kernels,distinct_orders=orders,
 shared_exact_weights=7*sum(orders),scenarios=scenarios,row_digest=rowhash.hexdigest().upper(),
 scope='Exact rational kernels/parameter metadata only; no function values, FFT, prime/zero data or builds.')
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({k:out[k] for k in ['status','checks','bandwidth_halfstep_bound','distinct_orders','shared_exact_weights','scenarios']},indent=2))
