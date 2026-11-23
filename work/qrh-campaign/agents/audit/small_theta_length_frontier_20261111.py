"""All admitted theta lengths and sufficient-budget dominance. No values."""
from pathlib import Path
from fractions import Fraction as F
from collections import Counter
from functools import lru_cache
import hashlib,json
A=Path(__file__).resolve().parents[1];P=A/'prime-estimates'
pins={
'prime-estimates/small_family_minimal_theta_20261111.json':'25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422',
'audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md':'58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B',
'prime-estimates/small_family_theta_inventory_final_20261111.json':'26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69',
'prime-estimates/adaptive_small_theta_interpolation_20261111.json':'3E6F184E7C7D2F13915F925C6687E3970204990035487DAC8BD41D9991C283A2'}
checks=0
def ck(b):
 global checks
 checks+=1
 assert b,checks
def ceil(x):return -(-x.numerator//x.denominator)
def p2(n):return 1<<(n-1).bit_length()
def bits(x):return ((x.denominator-1)//x.numerator).bit_length()
for f,h in pins.items():ck(hashlib.sha256((A/f).read_bytes()).hexdigest().upper()==h)
d=json.loads((P/'small_family_minimal_theta_20261111.json').read_text())
base=json.loads((P/'small_family_theta_inventory_final_20261111.json').read_text())
ad=json.loads((P/'adaptive_small_theta_interpolation_20261111.json').read_text())
pars={(x['odd'],x['theta']):x for x in d['selectors']}
ar={(x['odd'],x['theta']):x['order'] for x in ad['parameters']}
M=3**11+1
for odd in [True,False]:
 for theta in range(64,129):
  t=pars[odd,theta];delta=F(1,2**t['seed_bits']);W=F(t['W']);eps=F(t['eps'])
  ck(delta/16<1/W)
  ck(F(t['sigma'])==delta/(1024*M**4))
  if theta==128:continue
  b=pars[odd,theta+1];W2=F(b['W']);eps2=F(b['eps']);sig2=F(b['sigma'])
  ck(eps==3*eps2 and delta>=2*F(1,2**b['seed_bits']) and F(t['sigma'])>=2*sig2)
  for aa,bb in [(2,1),(2,2),(88,47)]:
   ck(eps/(aa*W*W+bb)>2*eps2/(aa*W2*W2+bb))
   ck((aa*W*W+bb)<2*(aa*W2*W2+bb))
  ck(ar[odd,theta]<=ar[odd,theta+1])
  # Both strict error ratio and a one-bit width tradeoff follow uniformly.
  ck(3*F(theta,theta+1)**2>2)

def factor(n):
 p=2;out=[]
 while p*p<=n:
  if n%p==0:
   e=0
   while n%p==0:e+=1;n//=p
   out.append((p,e))
  p+=1
 if n>1:out.append((n,1))
 return out
@lru_cache(None)
def axis(n):
 if n&(n-1)==0:
  k=n.bit_length()-1
  return dict(g=n*k//2,p=0,s=0,roots=n,kb=0,ke=0)
 L=p2(2*n-1);k=L.bit_length()-1
 return dict(g=L*k,p=L+2*n,s=L,roots=L+2*n,kb=L*k//2,ke=L)
fam=[]
for c in range(3,10001):
 if not(c%2 or c%4==0):continue
 v=n=1;axes=[]
 for p,e in factor(c):
  v*=p**(e-1)*(p-1);n*=p-2 if e==1 else (p-1)**2*p**(e-2)
  if p>2:axes.append(p**(e-1)*(p-1))
  elif e==2:axes.append(2)
  else:axes.extend([2,2**(e-2)])
 h=1 if c in [3,4,12] else 2;o=int(c!=12)
 band=sum(c>=x for x in [100,1000,10000])
 u=([F(21),F(20),F(39,2),F(96,5)] if c%2 else [F(113,5),F(211,10),F(201,10),F(191,10)])[band]
 H=200+ceil(max(F(240 if c%2 else 255),F(3927,1250)*u*F(531600 if c%2 else 1063200,c)))
 fam.append((c,v,n,h,o,axes,H))
ck(len(fam)==7499 and sum(x[2] for x in fam)==18477108)
def length(top,theta,odd):
 K=pars[odd,theta]['K']
 need=max(ceil(F(2*top*K,theta)),ceil(F(5*top+128*K,5)),77)
 return max(8,p2(need))
def costs(row,top,N):
 c,v,n,h,o,axes,H=row;R=ceil(F(25*N,192))+1;J=R-1;T=ceil(8192*(1+F(5*N,192))+R)
 g=sum(v//a*axis(a)['g'] for a in axes);p=sum(v//a*axis(a)['p'] for a in axes);sc=sum(v//a*axis(a)['s'] for a in axes);ds=set(axes)
 return dict(conductors=1,primitive_labels=n,unit_residues=v,conductor_grid_nodes=top+1,primitive_grid_outputs=n*(top+1),Gaussian_terms_upper=T,Gaussian_unit_gates_upper=2*T,bucket_additions_upper=h*T,odd_integer_scales_upper=o*T,outer_complex_exp_upper=R,Gaussian_seed_unit_contractions_upper=R,real_exp_seed_certificates=2,main_character_calls=h*R,main_character_butterflies=h*R*g,main_character_point_products=h*R*p,main_character_inverse_dyadic_scales=h*R*sc,prefactor_contraction_complex_products=n*R,radial_argument_prefactor_real_products=J+(4+o+2*n)*R,cutoff_rational_divisions=R,tilt_cis_certificates=1+h,conductor_positive_roots=2,phase_positive_roots=n,phase_divisions=n,K_complex_products=n,eighth_root_undo_complex_products_upper=n,fixed_setup_arithmetic_upper=16+12*n,gauss_character_calls=1,gauss_character_butterflies=g,gauss_character_point_products=p,gauss_character_inverse_dyadic_scales=sc,additive_root_cis=v,character_root_cis_upper=sum(axis(a)['roots'] for a in ds),eighth_root_cis_upper=8,time_root_cis_upper=N//2,blue_kernel_builds=sum(bool(a&(a-1)) for a in ds),blue_kernel_butterflies=sum(axis(a)['kb'] for a in ds),blue_kernel_entries=sum(axis(a)['ke'] for a in ds),time_butterflies=n*N//2*(N.bit_length()-1),time_dft_complex_outputs=n*N,omega_complex_scalings=n*(top+1),positive_scale_real_updates=top,final_Y_real_products=n*(top+1),frequency_conjugate_copies=n*J,zero_imaginary_projections=n)
scenarios=[];all_seen=set();enum=0;non_endpoint_patterns=[]
for extra in [0,167,320,640]:
 cells=[];num=Counter();sumshort=Counter();sumlong=Counter();summin=Counter();example=None
 saved=next(x for x in d['scenarios'] if x['extra_nodes']==extra)
 for ix,row in enumerate(fam):
  c,v,n,h,o,axes,H=row;top=(64*H+4)//5+extra;odd=bool(c%2);by={}
  for theta in range(64,129):
   N=length(top,theta,odd);enum+=1
   by.setdefault(N,[]).append(theta)
  lo=length(top,128,odd);hi=length(top,64,odd)
  if set(by)!=({lo} if lo==hi else {lo,2*lo}) or hi not in [lo,2*lo]:
   non_endpoint_patterns.append(dict(extra=extra,c=c,top=top,N128=lo,N64=hi,length_groups={str(N):ts for N,ts in sorted(by.items())}))
  admitted=[t for N,ts in by.items() if N<=lo for t in ts]
  ck(min(admitted)==saved['choice_in_increasing_active_conductor_order'][ix])
  ck(min(by[hi])==64)
  ck(min(by)>=2**18)
  front=[[N,min(thetas)] for N,thetas in sorted(by.items())]
  for N,theta in front:
   t=pars[odd,theta];K=t['K'];eps=F(t['eps']);V=F(5*top,64);P0=F(5*N,64)
   J=ceil(F(25*N,192));order=ar[odd,theta]
   ck(V>=2*theta and 1<=c*V/theta<=F(t['W']))
   ck(N*theta>=2*top*K and 5*N>=5*top+128*K and P0>=6)
   ck(J<N//2 and N>order and top+1<=N)
   ck(F(22,7)*F(J,N)<F(160919,393216))
   ck(eps*7*P0/2816<1)
  if min(by)<lo:
   e=non_endpoint_patterns[-1];Nmin=min(by);th=min(by[Nmin]);K=pars[odd,th]['K']
   e['short_order']=ar[odd,th]
   e['short_period_checks']=dict(theta=th,K=K,N=Nmin,first_slack=Nmin*th-2*top*K,second_slack=5*Nmin-5*top-128*K,third_slack=5*Nmin-384,previous_power_first_slack=(Nmin//2)*th-2*top*K,theta128_first_slack=Nmin*128-2*top*pars[odd,128]['K'])
  cells.append([c,top,front]);num[len(front)]+=1
  all_seen.update(theta for N,theta in front)
  cs=costs(row,top,lo);cl=costs(row,top,hi)
  ck(all(cs[k]<=cl[k] for k in cs))
  sumshort.update(cs);sumlong.update(cl);summin.update(costs(row,top,min(by)))
  if len(front)==2 and example is None:example=dict(c=c,top=top,frontier=front,short=cs,long=cl)
 for theta,actual in [(128,sumshort),(64,sumlong)]:
  bt=next(x['totals'] for x in base['scenarios'] if x['theta']==theta and x['extra_nodes']==extra)
  for key,value in actual.items():ck(bt[key]==value)
 scenarios.append(dict(extra_nodes=extra,one_option=num[1],two_options=num[2],option_histogram=dict(num),retained_options=sum(k*v for k,v in num.items()),cells=cells,all_N128_policy_counts=dict(sumshort),all_theta64_policy_counts=dict(sumlong),all_minimum_N_policy_counts=dict(summin),N128_minus_minimum_N_counts={k:sumshort[k]-summin[k] for k in sumshort},first_two_option_example=example))
out=dict(status='PASS exact dimension frontier; cost dominance conditional on stated model',checks=checks,theta_rows_enumerated=enum,pins=pins,cell_schema=['conductor','closed_top_index','candidate_pairs_N_then_smallest_theta'],all_retained_thetas=sorted(all_seen),non_endpoint_patterns=non_endpoint_patterns,scenarios=scenarios,scope='No actual values or unconditional runtime/proof-size Pareto claim. Full pricing retains tolerances, magnitudes, setup and cache dependencies.')
with Path(__file__).with_name('small_theta_length_frontier_final_20261111.json').open('x',encoding='utf8') as f:json.dump(out,f,separators=(',',':'));f.write('\n')
print(json.dumps(dict(checks=checks,enumerated=enum,non_endpoint_patterns=len(non_endpoint_patterns),first_pattern=non_endpoint_patterns[:1],scenarios=[{k:v for k,v in s.items() if k in ['extra_nodes','one_option','two_options','retained_options','option_histogram']} for s in scenarios]),indent=2))
