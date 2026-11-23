"""Independent integer-only circuit/height/P27 inventory. No author code imports."""
from pathlib import Path
from fractions import Fraction as F
from functools import cache
from math import prod
import hashlib,json

HERE=Path(__file__).resolve().parent
A=HERE.parent
P=A/'major-constants'
receipt=P/'coupled_plus_height_inventory_20261111.json'
author=json.loads(receipt.read_text())
old=json.loads((A/'zero-sum/reduced_plus_height_inventory_20261111.json').read_text())
oldseed=json.loads((A/'zero-sum/reduced_prefix_selected_p27_20261111.json').read_text())
checks=0
def eq(a,b):
 global checks
 assert a==b,(a,b)
 checks+=1
pins={}
for s,h in author['input_sha256'].items():
 p=Path(s);got=hashlib.sha256(p.read_bytes()).hexdigest().upper();eq(got,h);pins[s]=got
for name,h in [('major-constants/COUPLED_PLUS_HEIGHT_CONDITIONAL_COST_2026-11-11.md','8258CC9F0776FD3F394300F1F5511B69645A8CB71E1170082E8107EBEE1BEED4'),('zero-sum/REVIEW_COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md','A410B45323B9EB77E006E6E47403C6C4A8EC69E2E59E6C66FF44089E80FED6A5')]:
 p=A/name;got=hashlib.sha256(p.read_bytes()).hexdigest().upper();eq(got,h);pins[str(p)]=got

# Euler sieve supplies the arithmetic metadata independently of author factoring.
limit=300000
least=[0]*(limit+1);pr=[];phi=[0]*(limit+1);phi[1]=1
for n in range(2,limit+1):
 if not least[n]:least[n]=n;pr.append(n);phi[n]=n-1
 for p in pr:
  if p>least[n] or p*n>limit:break
  least[p*n]=p
  phi[p*n]=phi[n]*p if p==least[n] else phi[n]*(p-1)
def fac(n):
 out=[]
 while n>1:
  p=least[n];e=0
  while n%p==0:n//=p;e+=1
  out.append((p,e))
 return out
def divisors(n):
 d=[1]
 for p,e in fac(n):d=[x*p**k for x in d for k in range(e+1)]
 return d
Z=(0,0,0,0,0)
keys=('general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales')
def add(*vs):return tuple(map(sum,zip(*vs)))
def scale(k,v):return tuple(k*x for x in v)
def obj(v):return dict(zip(keys,v))
def pow2(n):return not n&(n-1)
@cache
def radix(n):
 g=a=q=0;s=2
 while s<=n:
  copies=n//s;quarter=int(s>=4)
  g+=copies*(s//2-1-quarter);q+=copies*quarter;a+=n;s*=2
 return g,a,q,0,0
def pad(n):return 1<<(2*n-2).bit_length()
@cache
def chirps(n,q=0):
 # Enumerate only the integer positions capable of being a fourth root.
 d=prod(p**((e+1)//2) for p,e in fac(n//(2 if n%2==0 else 1)))
 counts=[0]*4
 for j in range(0,n,d):
  if not q or j%q:counts[(2*j*j//n)%4]+=1
 kept=n if not q else n-n//q
 return kept-sum(counts),0,counts[1]+counts[3],counts[2],0
@cache
def bridge(r,m,q=0):
 n=r*m;rot=neg=0
 for h in (1,2,3):
  if h*n%4:continue
  t=h*n//4
  count=sum(1 for a in divisors(t) if a<r and 1<=t//a<m and (not q or (t//a)%q))
  if h==2:neg+=count
  else:rot+=count
 total=(r-1)*(m-1 if not q else m-m//q)
 return total-rot-neg,0,rot,neg,0
@cache
def blue(n):return add(scale(2,radix(pad(n))),(pad(n),0,0,0,pad(n)),scale(2,chirps(n)))
plans={}
@cache
def full(n):
 if pow2(n):plans[n]=('radix',);return radix(n)
 p=least[n]
 if p==n:
  plans[n]=('direct',) if n<=11 else ('blue',)
  return ((n-1)**2,n*(n-1),0,0,0) if n<=11 else blue(n)
 m=n//p;c=add(scale(p,full(m)),scale(m,full(p)),bridge(p,m))
 b=blue(n)
 if c[0]<=b[0] and c[1]<=b[1]:plans[n]=('split',p,m);return c
 plans[n]=('blue',);return b
@cache
def kept(n,q):
 f=full(n)
 if not q:return f
 typ=plans[n][0]
 if typ=='blue':return add(scale(2,radix(pad(n))),(pad(n),0,0,0,pad(n)),chirps(n),chirps(n,q))
 if typ=='direct':return ((n-1)**2,(n-1)**2,0,0,0)
 if n==2:return (0,1,0,0,0)
 r,m=(2,n//2) if typ=='radix' else plans[n][1:]
 if q==n:return add(scale(r,full(m)),bridge(r,m),scale(m-1,full(r)),kept(r,r))
 assert m%q==0
 return add(scale(r,kept(m,q)),bridge(r,m,q),scale(m-m//q,full(r)))
def axes(c):
 out=[]
 for p,e in fac(c):
  if p==2:out.extend([(2,2)] if e==2 else [(2,0),(2**(e-2),2)])
  else:
   n=(p-1)*p**(e-1);out.append((n,n if e==1 else p))
 return out
def tensor(ax):
 # Explicit line counts: already-transformed output prefixes times input suffixes.
 result=Z
 for j,(n,q) in enumerate(ax):
  lines=prod(v if not t else v-v//t for v,t in ax[:j])*prod(v for v,t in ax[j+1:])
  result=add(result,scale(lines,kept(n,q)))
 return result
def ceiling(a,b=1):return -(-a//b)
def blank():return dict(conductors=0,primitive_labels=0,unit_coefficients=0,conductor_height_nodes=0,residue_inputs=0,primitive_outputs=0,max_nodes=0,max_node_conductors=[],operations=obj(Z))
tot=[blank(),blank()];one=Z;top=set();exceeds={str(d):0 for d in (0,167,320,640)};examples={}
for c in range(3,265801):
 if not (c%4==0 or c%2 and c<=132900):continue
 if c<=10000:continue
 ax=axes(c);top.update(n for n,q in ax);v=phi[c]
 eq(prod(n for n,q in ax),v)
 num=prod((p-2) if e==1 else (p-1)**2*p**(e-2) for p,e in fac(c))
 eq(prod(n if not q else n-n//q for n,q in ax),num)
 cost=tensor(ax);one=add(one,cost)
 qt=c if c%2==0 else 2*c
 # Work with integer numerators instead of nested Fraction expressions.
 old_u=1989 if c%2==0 and c>60000 else 2330
 heights=[200+ceiling(max(260*125000*qt,old_u*3927*1063200),125000*qt),
          200+ceiling(max(255*2500*qt,39*3927*1063200),2500*qt)]
 js=[ceiling(64*h,5)+1 for h in heights]
 assert js[1]<=js[0]
 assert ceiling(27000000 if c%2 else 54000000,c)<=heights[1]
 assert max(300,ceiling(704*1063200,343*qt))<=heights[1]
 checks+=3
 for i,J in enumerate(js):
  b=tot[i]
  for k,x in [('conductors',1),('primitive_labels',num),('unit_coefficients',v),('conductor_height_nodes',J),('residue_inputs',J*v),('primitive_outputs',J*num)]:b[k]+=x
  if J>b['max_nodes']:b['max_nodes']=J;b['max_node_conductors']=[c]
  elif J==b['max_nodes']:b['max_node_conductors'].append(c)
  for k,x in zip(keys,cost):b['operations'][k]+=J*x
 for d in (0,167,320,640):exceeds[str(d)]+=js[1]+d>js[0]
 if str(c) in author['examples']:examples[str(c)]=dict(Hnew=heights[1],Hold=heights[0],Jnew=js[1],Jold=js[0])
eq(tot[0],author['fallback_main']);eq(tot[0],old['main']);eq(tot[1],author['candidate_main'])
eq(obj(one),author['per_added_node_operations']);eq(exceeds,author['aux_conductors_exceeding_own_fallback_main']);eq(examples,author['examples'])

def ledger(J):
 rows=[];lo=0;previous_x=0
 for V,D,N in [(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),(10000,8192,3387)]:
  hi=min(J,64*V//5+1);h=hi-lo
  if h<=0:break
  x=(N+1)*D+1;init=x-previous_x;coeff=27*D+20
  row=dict(V=V,D=D,N=N,heights=h,first_index=lo,last_index=hi-1,
   independent_P27_source_coefficients=h*coeff,head_reciprocal_scales=h*N*(26*D+19),head_accumulator_additions=h*N*coeff,
   E_contracting_complex_stages=h*(153*D+146),Bernoulli_weighted_terms=64*h*coeff,Bernoulli_accumulator_additions=64*h*coeff,
   P27_to_P20_midpoint_shift_updates=330*h*D,P20_fine_anchor_coefficient_deliveries=20*h*(2*D+1),
   shared_height_R_recurrence_steps=26*h,coarse_anchor_instances=h*(D+1),base_height_argument_pairs=h*x,
   initial_B_certificates=init,step_cis_certificates=init,step_grid_conversions=init,fine_state_complex_updates=h*x-init,state_to_EM_grid_conversions=h*x)
  rows.append(row);lo=hi;previous_x=x
 sums={k:sum(row[k] for row in rows) for k in rows[0] if k not in ('V','D','N','heights','first_index','last_index')}
 return dict(bands=rows,totals=sums)
def rat(a,b):return dict(exact=str(F(a,b)),lower_ppm=a*1000000//b,upper_ppm=ceiling(a*1000000,b))
scenarios=[]
for s in author['scenarios']:
 d=s['extra_nodes'];J=tot[1]['max_nodes']+d
 oldr=next(r for r in old['scenarios'] if r['extra_nodes']==d)
 oldp=next(r for r in oldseed['scenarios'] if r['extra_nodes']==d)
 eq(ledger(tot[0]['max_nodes']+d)['totals'],oldp['totals'])
 eq(ledger(J),s['selected_P27']);eq(J,s['global_nodes']);eq(str(F(5*(J-1),64)),s['last_height']);eq(str(F(5*d,64)),s['aux_height'])
 assert J<=tot[0]['max_nodes'] and J<128000
 for k,vkey in [('conductor_height_nodes','conductors'),('residue_inputs','unit_coefficients'),('primitive_outputs','primitive_labels')]:eq(tot[1][k]+d*tot[1][vkey],s[k])
 for k in keys:
  v=tot[1]['operations'][k]+d*obj(one)[k];eq(v,s['operations'][k])
  eq(rat(v,oldr['total_operations'][k]),s['ratios_to_same_aux_fallback'][k]);eq(rat(v,tot[0]['operations'][k]),s['ratios_to_fallback_main'][k])
 for k,v in s['selected_P27']['totals'].items():eq(rat(v,oldp['totals'][k]),s['P27_ratios_to_same_aux_fallback'][k])
 H=19*s['residue_inputs'];H0=19*oldr['total_residue_inputs'];eq(H,s['P20_Horner_stages']);eq(rat(H,H0),s['P20_Horner_ratio_to_same_aux_fallback'])
 g=s['operations'][keys[0]];a=s['operations'][keys[1]];g0=oldr['total_operations'][keys[0]];a0=oldr['total_operations'][keys[1]]
 for method,m,b in [('four',4,2),('fixed_three',3,3),('gauss_three',3,5)]:
  p=m*g+2*H;ad=2*a+b*g+2*H
  eq(dict(products=p,additions=ad,product_ratio=rat(p,m*g0+2*H0),addition_ratio=rat(ad,2*a0+b*g0+2*H0)),s['transform_plus_Horner_real_counts'][method])
 scenarios.append(dict(extra=d,global_nodes=J,ledger=ledger(J)['totals'],operations=s['operations']))

active=set()
def visit(n):
 if n in active:return
 active.add(n);full(n)
 if plans[n][0]=='split':visit(plans[n][1]);visit(plans[n][2])
for n in top:visit(n)
kernels={n for n in active if plans[n][0]=='blue'}
setup=dict(axis_lengths=len(top),active_nodes=len(active),kernel_count=len(kernels),kernel_entries=sum(map(pad,kernels)),chirp_entries=sum(kernels),max_padded_length=max(map(pad,kernels)),kernel_forward_operations=obj(add(Z,*(radix(pad(n)) for n in kernels))),CT_full_root_table_entry_upper=sum(n for n in active if plans[n][0]=='split'))
eq(setup,author['transform_setup_unchanged']);eq(setup,old['transform_setup'])
eq(author['seed_setup_unchanged'],oldseed['unchanged_setup']);eq(author['excluded'],old['excluded']);eq(author['new_setup_at_same_precision'],0)
for p in (receipt,P/'coupled_plus_height_inventory_20261111.py'):
 pins[str(p)]=hashlib.sha256(p.read_bytes()).hexdigest().upper()
out=dict(status='PASS_INDEPENDENT_CONDITIONAL_METADATA',checks=checks,input_sha256=pins,
 scope='Integer/rational metadata only; independent circuit and ledger, no author code imports or function evaluations',
 fallback=tot[0],candidate=tot[1],per_added_node=obj(one),extensions_exceeding_old_main=exceeds,scenarios=scenarios,setup=setup)
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=checks,candidate=tot[1],setup=setup)))
