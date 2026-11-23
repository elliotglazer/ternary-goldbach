"""Bounded integer circuit metadata only. No upstream imports/writers or values."""
from pathlib import Path
from functools import cache
from math import gcd, prod
import hashlib, json

HERE=Path(__file__).resolve().parent; AG=HERE.parent
PINS={
 'zero-sum/conditional_r132900_pruning_inventory_20261111.py':'074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D',
 'zero-sum/mixed_radix_character_inventory_20261111.json':'2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F',
 'zero-sum/mixed_radix_precision_metadata_20261111.json':'8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E',
 'independent-feasibility/mixed_radix_width_metadata_20261111.json':'364B00C1BA63A06CC5B1C3E0CC777280151BB05E0E5B56063231596B0249B48F',
 'independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md':'5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A',
 'major-constants/combined_odd_even_height_inventory_20261111.py':'4C1B0FA0DA303A5EE475493A8CE66EB3723B3C9DFD9369DF9687069AF3F3E154',
 'major-constants/combined_odd_even_height_inventory_20261111.json':'BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE',
 'major-constants/reconciled_nonprincipal_schedule_20261111.json':'0E83C9AB65725FBD34F0D34FC462E9EC805A040717DA92B1AB262CC7A9345397',
 'prime-estimates/large_residue_bucket_occupancy_20261111.json':'19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB',
 'zero-sum/TRANSFORM_SAVED_MULTIPLICITY_EVIDENCE_MAP_2026-11-11.md':'90A9730692DE696AD7F92A1AA5CAAE7FFAF378ED0822E78AD8F01517B325111F',
}
CHECKS=0
def ck(p):
 global CHECKS
 assert p
 CHECKS+=1
for rel,h in PINS.items():ck(hashlib.sha256((AG/rel).read_bytes()).hexdigest().upper()==h)
def read(rel):return json.loads((AG/rel).read_text(encoding='utf-8'))
full=read('zero-sum/mixed_radix_character_inventory_20261111.json')
prec=read('zero-sum/mixed_radix_precision_metadata_20261111.json')
width=read('independent-feasibility/mixed_radix_width_metadata_20261111.json')
combined=read('major-constants/combined_odd_even_height_inventory_20261111.json')
reconciled=read('major-constants/reconciled_nonprincipal_schedule_20261111.json')
occupancy=read('prime-estimates/large_residue_bucket_occupancy_20261111.json')
KEYS=('general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales')
EXTRAS=(0,167,320,640); ENDS=(6400,12800,25600,64000,128000)
ZERO=(0,0,0,0,0); MAX_CLASSES=1000000; MAX_BYTES=64*1024*1024
LIMIT=300000
spf=list(range(LIMIT+1))
for p in range(2,LIMIT+1):
 if spf[p]==p:
  for j in range(p*p,LIMIT+1,p):
   if spf[j]==j:spf[j]=p
def fac(n):
 a=[]
 while n>1:
  p=spf[n];e=0
  while n%p==0:n//=p;e+=1
  a.append((p,e))
 return a
def divisors(n):
 a=[1]
 for p,e in fac(n):a=[d*p**j for d in a for j in range(e+1)]
 return a
def plus(*xs):return tuple(map(sum,zip(*xs)))
def times(m,x):return tuple(m*v for v in x)
def pow2(n):return n>0 and n&(n-1)==0
def plen(n):return 1<<(2*n-2).bit_length()
def clog(n):return (n-1).bit_length()
def rad(n):
 if n==1:return ZERO
 k=n.bit_length()-1
 return (n*k//2-3*n//2+2,n*k,n//2-1,0,0)
@cache
def chirp(n,q=0):
 # Count only divisibility classes; no chirp/root values or index sweep.
 d=prod(p**((e+1)//2) for p,e in fac(n//(2 if n%2==0 else 1)))
 def cheap(step):
  ck(n%step==0 and (2*step*step)%n==0)
  count=n//step;h=(2*step*step//n)%4
  out=[0]*4;out[0]=(count+1)//2;out[h]+=count//2
  return out
 z=cheap(d)
 if q:
  w=cheap(d*q//gcd(d,q));z=[a-b for a,b in zip(z,w)]
 count=n if q==0 else n-n//q
 return (count-sum(z),0,z[1]+z[3],z[2],0)
@cache
def bridge(r,m,q=0):
 n=r*m;rot=neg=0
 for h in (1,2,3):
  if h*n%4:continue
  target=h*n//4
  for a in divisors(target):
   v=target//a
   if 1<=a<r and 1<=v<m and (q==0 or v%q):
    if h==2:neg+=1
    else:rot+=1
 total=(r-1)*(m-1 if q==0 else m-m//q)
 return (total-rot-neg,0,rot,neg,0)
def blue(n):
 P=plen(n)
 return plus(times(2,rad(P)),times(2,chirp(n)),(P,0,0,0,P))
def baseline(n):return rad(n) if pow2(n) else blue(n)
CHOICES={}
@cache
def selected(n):
 b=baseline(n)
 if pow2(n):CHOICES[n]=('radix2',);return b
 r=spf[n]
 if r==n:
  if n<=11:CHOICES[n]=('direct_prime',);return ((n-1)**2,n*(n-1),0,0,0)
  CHOICES[n]=('bluestein',);return b
 m=n//r;v=plus(times(r,selected(m)),times(m,selected(r)),bridge(r,m))
 if v[0]<=b[0] and v[1]<=b[1]:CHOICES[n]=('split',r,m);return v
 CHOICES[n]=('bluestein',);return b

# Reproduce the original full-plan hash from saved axis lengths, not a family scan.
axes_all={r['n'] for r in prec['axis_rows']}
ck(axes_all=={r['n'] for r in width['axis_rows']})
for n in sorted(axes_all):selected(n)
active=set()
def visit(n,seen):
 if n in seen:return
 seen.add(n)
 if CHOICES[n][0]=='split':
  for d in CHOICES[n][1:]:visit(d,seen)
for n in sorted(axes_all):visit(n,active)
plan={str(n):dict(choice=CHOICES[n],count=dict(zip(KEYS,selected(n)))) for n in sorted(active)}
plan_hash=hashlib.sha256(json.dumps(plan,sort_keys=True,separators=(',',':')).encode()).hexdigest()
ck(plan_hash==prec['plan_sha256']==full['canonical_plan_sha256']==width['plan_sha256'])
ck(len(active)==37117 and len(axes_all)==13943)

DAG={}
@cache
def request(n,q):
 selected(n);typ=CHOICES[n][0];children=[];local=ZERO
 if q==0 and typ!='split':
  ans=selected(n);kind=typ
 elif typ=='bluestein':
  P=plen(n);ans=plus(times(2,rad(P)),chirp(n),chirp(n,q),(P,0,0,0,P));kind=typ
 elif typ=='direct_prime':
  ck(q==n);ans=((n-1)**2,(n-1)**2,0,0,0);kind=typ
 elif n==2:
  ck(q==2);ans=(0,1,0,0,0);kind='pruned_two'
 else:
  r,m=(2,n//2) if typ=='radix2' else CHOICES[n][1:]
  kind='ct'
  if q==0:
   children=[(m,0,r,1),(r,0,m,2*m)];local=bridge(r,m)
  elif q==n:
   children=[(m,0,r,1),(r,0,m-1,2*m),(r,r,1,2*m)];local=bridge(r,m)
  else:
   ck(m%q==0)
   children=[(m,q,r,1),(r,0,m-m//q,2*m)];local=bridge(r,m,q)
  ans=plus(local,*(times(mult,request(cn,cq)) for cn,cq,mult,a in children))
 ck(all(a<=b for a,b in zip(ans,selected(n))))
 DAG[(n,q)]=dict(kind=kind,children=children,local=list(local),counts=list(ans))
 return ans

def axis_data(c):
 out=[]
 for p,e in fac(c):
  if p==2:
   if e==2:out.append((2,2))
   else:out.extend(((2,0),(2**(e-2),2)))
  else:out.append(((p-1)*p**(e-1),(p-1)*p**(e-1) if e==1 else p))
 return out
def retained(n,q):return n if q==0 else n-n//q
def ceildiv(n,d):return (n+d-1)//d
def height(c):
 qt=2*c if c%2 else c
 # u=96/5 odd,191/10 even; pi upper3927/1250.
 un,ud=(96,5) if c%2 else (191,10)
 hp=200+max(240 if c%2 else 255,ceildiv(un*3927*1063200,ud*1250*qt))
 hb=ceildiv(27000000 if c%2 else 54000000,c)
 hs=max(300,ceildiv(704*1063200,343*qt))
 ck(hp>=hb and hp>=hs)
 return hp
def bands(J):
 out=[];lo=0
 for hi in ENDS:out.append(max(0,min(J,hi+1)-lo));lo=hi+1
 ck(sum(out)==J)
 return out
def bump(table,key,weights,mult=1):
 if not mult:return
 if key not in table:
  ck(len(table)<MAX_CLASSES);table[key]=[0]*20
 target=table[key]
 for i,w in enumerate(weights):target[i]+=mult*w

contexts={};conductors=[];top_axes=set();current_active=set()
totals=[[0]*5 for _ in EXTRAS];unit_band=[0]*20;primitive=[0]*4;heights=[0]*4
unit_coeff=labels=0;maxJ=0
for c in range(10001,265801):
 if not ((c%2 and c<=132900) or c%4==0):continue
 axes=axis_data(c);v=prod(n for n,q in axes);nprim=prod(retained(n,q) for n,q in axes)
 H=height(c);J=ceildiv(64*H,5)+1;maxJ=max(maxJ,J)
 ws=[w for d in EXTRAS for w in bands(J+d)]
 conductors.append([c,v,nprim,H,J,axes,ws])
 unit_coeff+=v;labels+=nprim
 for i,w in enumerate(ws):unit_band[i]+=v*w
 for s,d in enumerate(EXTRAS):primitive[s]+=nprim*(J+d);heights[s]+=J+d
 suffix=v;outprefix=fullprefix=1;cost=ZERO
 for n,q in axes:
  top_axes.add((n,q));visit(n,current_active)
  suffix//=n;mult=outprefix*suffix
  cost=plus(cost,times(mult,request(n,q)))
  # Full prefix, NOT retained prefix, governs norm. Retained prefix governs count.
  bump(contexts,(n,q,2*fullprefix),ws,mult)
  outprefix*=retained(n,q);fullprefix*=n
 ck(outprefix==nprim)
 for s,d in enumerate(EXTRAS):
  for k,x in enumerate(cost):totals[s][k]+=(J+d)*x
ck(len(conductors)==125400)
for s,d in enumerate(EXTRAS):
 ref=combined['scenarios'][s];rec=reconciled['scenarios'][s]['large']
 ck(ref['extra_nodes']==d and rec['transform_operations']==ref['operations'])
 ck(totals[s]==[ref['operations'][k] for k in KEYS])
 ck(sum(unit_band[5*s:5*s+5])==ref['residue_inputs']==rec['residue_inputs'])
 ck(primitive[s]==ref['primitive_outputs'] and heights[s]==ref['conductor_height_nodes'])
 ck(maxJ+d==ref['global_nodes'])
 for b in range(5):
  os=occupancy['scenarios'][s];ck(os['extra_nodes']==d)
  ck(unit_band[5*s+b]==sum(row['unit_outputs'] for row in os['bands'][b]['cohorts']))

# Expand cached structural contexts, never an individual gate or residue.
# Event key: category, phase, local_length, radix_stage, data_factor_ceillog2,
# coefficient_magnitude_ceillog2 (roots=1), dyadic_division_bits.
events={};by_n={};context_total=0
for (n,q,a),ws in contexts.items():by_n.setdefault(n,{})[(q,a)]=ws
top_context_count=len(contexts);del contexts
def emit(cat,phase,n,stage,a,b,d,count,ws):
 if count:bump(events,(cat,phase,n,stage,clog(a),b,d),ws,count)
def emitvec(vec,phase,n,a,ws):
 for i,count in enumerate(vec):
  ck(i!=4 or count==0)
  emit(('root','add','quarter','neg','scale')[i],phase,n,0,a,1 if i==0 else 0,0,count,ws)
def stages(P,a,phase,ws):
 k=P.bit_length()-1
 for j in range(1,k+1):
  length=1<<j;copies=P//length;half=length//2;quarter=int(j>=2)
  # Input bound2^j*a*V; after root and add bound2^(j+1)*a*V.
  emit('root',phase,P,j,(1<<j)*a,1,0,copies*(half-1-quarter),ws)
  emit('quarter',phase,P,j,(1<<j)*a,0,0,copies*quarter,ws)
  emit('add',phase,P,j,(1<<(j+1))*a,0,0,P,ws)
for n in sorted({n for n,q in DAG},reverse=True):
 group=by_n.pop(n,{})
 for (q,a),ws in group.items():
  context_total+=1;ck(context_total<=MAX_CLASSES)
  node=DAG[(n,q)];kind=node['kind']
  if kind=='ct':
   r,m=(2,n//2) if CHOICES[n][0]=='radix2' else CHOICES[n][1:]
   emitvec(node['local'],'ct_bridge',n,2*m*a,ws)
   for cn,cq,mult,af in node['children']:
    dest=by_n.setdefault(cn,{})
    if (cq,a*af) not in dest:dest[(cq,a*af)]=[0]*20
    for i,w in enumerate(ws):dest[(cq,a*af)][i]+=mult*w
  elif kind=='radix2':stages(n,a,'radix',ws)
  elif kind=='pruned_two':emit('add','pruned_two',n,1,4*a,0,0,1,ws)
  elif kind=='direct_prime':emitvec(node['counts'],'direct',n,2*n*a,ws)
  elif kind=='bluestein':
   P=plen(n);Z=2*n*(n+1)+2
   emitvec(chirp(n),'blue_pre_chirp',n,2*a,ws)
   stages(P,2*a,'blue_forward',ws)
   emit('kernel','blue_point',n,0,(n+2)*a,clog(2*n+1),0,P,ws)
   stages(P,Z*a,'blue_inverse',ws)
   emit('scale','blue_inverse_division',n,0,2*P*Z*a,0,P.bit_length()-1,P,ws)
   emitvec(chirp(n,q),'blue_post_chirp',n,(4*Z+4)*a,ws)
  else:raise AssertionError(kind)
ck(not by_n)
projection=[[0]*5 for _ in EXTRAS];split=[[0,0] for _ in EXTRAS]
for key,ws in events.items():
 cat=key[0];idx={'root':0,'kernel':0,'add':1,'quarter':2,'neg':3,'scale':4}[cat]
 for s in range(4):
  count=sum(ws[5*s:5*s+5]);projection[s][idx]+=count
  if cat in ('root','kernel'):split[s][cat=='kernel']+=count
for s in range(4):
 ck(projection[s]==totals[s]);ck(split[s][1]==totals[s][4])
 ck(sum(split[s])==totals[s][0])

# Setup is a separately retained full-circuit cache; never charged per height.
kernels=[n for n in current_active if CHOICES[n][0]=='bluestein']
setup=dict(axis_lengths=len({n for n,q in top_axes}),active_nodes=len(current_active),
 kernel_count=len(kernels),kernel_entries=sum(plen(n) for n in kernels),
 chirp_entries=sum(kernels),max_padded_length=max(map(plen,kernels)),
 kernel_forward_operations=dict(zip(KEYS,plus(*(rad(plen(n)) for n in kernels)))),
 CT_full_root_table_entry_upper=sum(n for n in current_active if CHOICES[n][0]=='split'))
ck(setup==combined['transform_setup_unchanged'])

def write(name,value):
 data=(json.dumps(value,separators=(',',':'))+'\n').encode()
 ck(len(data)<=MAX_BYTES)
 path=HERE/name
 with path.open('xb') as f:f.write(data)
 return dict(path=name,bytes=len(data),sha256=hashlib.sha256(data).hexdigest().upper())
manifest=write('transform_structural_manifest_20261111.json',dict(
 schema='selected-transform-structural-manifest-1',pins=PINS,canonical_plan_sha256=plan_hash,
 plan=plan,request_fields=['n','q','kind','children_n_q_multiplicity_normfactor','local_five_counts','five_counts'],
 requests=[[n,q,v['kind'],v['children'],v['local'],v['counts']] for (n,q),v in sorted(DAG.items())],
 conductor_fields=['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'],
 conductors=conductors,extras=EXTRAS,band_last_indices=ENDS,unchanged_setup=setup))
eventfile=write('transform_structural_events_20261111.json',dict(
 schema='selected-transform-structural-events-1',manifest_sha256=manifest['sha256'],
 key_fields=['category','phase','local_length','radix_stage','data_factor_ceillog2','coefficient_ceillog2','dyadic_division_bits'],
 count_order='scenario major [0,167,320,640], band minor [500,1000,2000,5000,10000]',
 data_bound='incoming/stored norm bounded by 2^data_factor_ceillog2 * V; V=input_sup+1; widths require chosen p and V bound',
 events=[list(k)+[v] for k,v in sorted(events.items())]))
summary=dict(scope='Bounded factor/axis/circuit metadata only; no unit residues, coefficients, roots or values.',
 checks=CHECKS,canonical_plan_sha256=plan_hash,full_plan_nodes=len(plan),request_nodes=len(DAG),
 conductors=len(conductors),top_contexts=top_context_count,expanded_contexts=context_total,event_classes=len(events),
 precision_selected=False,setup=setup,unit_band=unit_band,
 scenarios=[dict(extra_nodes=d,operations=dict(zip(KEYS,totals[s])),root_products=split[s][0],kernel_products=split[s][1]) for s,d in enumerate(EXTRAS)],
 artifacts=[manifest,eventfile],pins=PINS)
receipt=write('transform_structural_inventory_20261111.json',summary)
print(json.dumps({k:v for k,v in summary.items() if k not in ('pins','unit_band','scenarios')},indent=2))
print(json.dumps(receipt))
