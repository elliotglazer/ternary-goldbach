"""Independent fold of frozen structural metadata. No author imports or values."""
from pathlib import Path
from functools import cache
import hashlib,json,math

AG=Path(__file__).resolve().parent.parent
HERE=Path(__file__).resolve().parent
PINS={
 'integration/TRANSFORM_STRUCTURAL_MULTIPLICITY_INVENTORY_2026-11-11.md':'01F1446FF10D2EFD690DF06552F35DAD26C1453A49F4BB4F84D794D997FD55BB',
 'integration/transform_structural_inventory_20261111.py':'584A16F00A905AD68C3FE11F4128FE2205F772FB67916EF312B596518F1ADB55',
 'integration/transform_structural_manifest_20261111.json':'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637',
 'integration/transform_structural_events_20261111.json':'06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B',
 'integration/transform_structural_inventory_20261111.json':'503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0'}
checks=0
def ck(b):
 global checks
 assert b
 checks+=1
def digest(raw):return hashlib.sha256(raw).hexdigest().upper()
def load(path):return json.loads((AG/path).read_text(encoding='utf-8'))
for p,h in PINS.items():ck(digest((AG/p).read_bytes())==h)
M=load('integration/transform_structural_manifest_20261111.json')
E=load('integration/transform_structural_events_20261111.json')
S=load('integration/transform_structural_inventory_20261111.json')
for p,h in M['pins'].items():ck(digest((AG/p).read_bytes())==h)
ck(M['pins']==S['pins'])
ck(E['manifest_sha256']==PINS['integration/transform_structural_manifest_20261111.json'])
KEYS=('general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales')
EX=(0,167,320,640);ENDS=(6400,12800,25600,64000,128000)
ck(M['extras']==list(EX) and M['band_last_indices']==list(ENDS))
ck(len(M['conductors'])==125400 and len(M['requests'])==35190 and len(E['events'])==138126)
ck(len(M['plan'])==37117)
ph=hashlib.sha256(json.dumps(M['plan'],sort_keys=True,separators=(',',':')).encode()).hexdigest()
ck(ph==M['canonical_plan_sha256']==S['canonical_plan_sha256'])
prec=load('zero-sum/mixed_radix_precision_metadata_20261111.json')
ck(ph==prec['plan_sha256'])

# Independent least-divisor table, used only for integer factor/axis metadata.
least=[0]*300001
for n in range(2,len(least)):
 if least[n]==0:
  for k in range(n,len(least),n):
   if least[k]==0:least[k]=n
@cache
def factor(n):
 out=[]
 while n>1:
  p=least[n];e=0
  while n%p==0:n//=p;e+=1
  out.append((p,e))
 return tuple(out)
def divs(n):
 out=[1]
 for p,e in factor(n):out=[a*p**j for a in out for j in range(e+1)]
 return out
def add(*v):return [sum(z) for z in zip(*v)]
def scale(c,v):return [c*x for x in v]
Z=[0]*5
def pad(n):return 2**((2*n-2).bit_length())
def lg(n):return (n-1).bit_length()
def radix(n):
 ans=[0]*5
 for j in range(1,n.bit_length()):
  l=2**j
  ans=add(ans,[n//l*(l//2-1-(j>1)),n,n//l*(j>1),0,0])
 return ans
@cache
def cheap_chirp(n,q):
 d=math.prod(p**((e+1)//2) for p,e in factor(n//math.gcd(n,2)))
 def counts(step):
  ck(n%step==0 and (2*step*step)%n==0)
  count=n//step
  # Even multiples give identity; odd multiples have one fixed quarter class.
  ans=[(count+1)//2,0,0,0]
  ans[(2*step*step//n)%4]+=count//2
  return ans
 c=counts(d)
 if q:
  excluded=counts(math.lcm(d,q));c=[x-y for x,y in zip(c,excluded)]
 total=n if not q else n-n//q
 return [total-sum(c),0,c[1]+c[3],c[2],0]
@cache
def bridge(r,m,q):
 rot=neg=0;n=r*m
 for h in [1,2,3]:
  if (h*n)%4:continue
  target=h*n//4
  for a in divs(target):
   b=target//a
   if a<r and b<m and (not q or b%q):
    if h==2:neg+=1
    else:rot+=1
 count=(r-1)*(m-1 if not q else m-m//q)
 return [count-rot-neg,0,rot,neg,0]
def blue(n):
 p=pad(n)
 return add(scale(2,radix(p)),scale(2,cheap_chirp(n,0)),[p,0,0,0,p])
plan={int(n):v for n,v in M['plan'].items()}
for n,row in sorted(plan.items()):
 c=row['choice'];v=[row['count'][k] for k in KEYS]
 if n&(n-1)==0:ck(c==['radix2'] and v==radix(n))
 elif least[n]==n:
  expected=['direct_prime'] if n<=11 else ['bluestein']
  ck(c==expected)
  ck(v==([(n-1)**2,n*(n-1),0,0,0] if n<=11 else blue(n)))
 else:
  r=least[n];m=n//r
  # Rejected split children need not occur in the active plan. For selected
  # splits inspect every child and exact vector; the canonical frozen hash
  # supplies the original selection identity for rejected alternatives.
  if c[0]=='split':
   ck(c==['split',r,m] and r in plan and m in plan)
   cv=add(scale(r,[plan[m]['count'][k] for k in KEYS]),scale(m,[plan[r]['count'][k] for k in KEYS]),bridge(r,m,0))
   ck(v==cv and v[0]<=blue(n)[0] and v[1]<=blue(n)[1])
  else:ck(c==['bluestein'] and v==blue(n))

requests={}
for row in M['requests']:
 n,q,kind,child,local,total=row
 ck((n,q) not in requests and (q==0 or q>=2 and n%q==0))
 requests[n,q]=(kind,child,local,total)
for (n,q),(kind,ch,local,total) in sorted(requests.items()):
 typ=plan[n]['choice'][0];want=[];loc=Z
 if not q and typ!='split':
  ck(kind==typ);ans=[plan[n]['count'][k] for k in KEYS]
 elif typ=='bluestein':
  p=pad(n);ck(kind==typ)
  ans=add(scale(2,radix(p)),cheap_chirp(n,0),cheap_chirp(n,q),[p,0,0,0,p])
 elif typ=='direct_prime':
  ck(kind==typ and q==n);ans=[(n-1)**2,(n-1)**2,0,0,0]
 elif n==2:
  ck(kind=='pruned_two' and q==2);ans=[0,1,0,0,0]
 else:
  ck(kind=='ct');r,m=(2,n//2) if typ=='radix2' else plan[n]['choice'][1:]
  if not q:want=[[m,0,r,1],[r,0,m,2*m]];loc=bridge(r,m,0)
  elif q==n:want=[[m,0,r,1],[r,0,m-1,2*m],[r,r,1,2*m]];loc=bridge(r,m,0)
  else:
   ck(m%q==0);want=[[m,q,r,1],[r,0,m-m//q,2*m]];loc=bridge(r,m,q)
  ck(all(cn<n and (cn,cq) in requests for cn,cq,_,_ in want))
  ans=add(loc,*(scale(mult,requests[cn,cq][3]) for cn,cq,mult,af in want))
 ck(ch==want and local==loc and total==ans)

contexts={};totals=[[0]*5 for _ in EX];units=[0]*20;labels=[0]*4;heights=[0]*4;axis_lengths=set();active=set()
def bump(d,k,w,m=1):
 if k not in d:d[k]=[0]*20
 for i,a in enumerate(w):d[k][i]+=a*m
def closure(n):
 if n in active:return
 active.add(n)
 if plan[n]['choice'][0]=='split':
  for child in plan[n]['choice'][1:]:closure(child)
def ceildiv(n,d):return -(-n//d)
expected=[c for c in range(10001,265801) if c%4==0 or c%2 and c<=132900]
ck([r[0] for r in M['conductors']]==expected)
for c,phi,primitive,H,J,axes,w in M['conductors']:
 factors=factor(c);dims=[]
 pv=math.prod((p-1)*p**(e-1) for p,e in factors)
 pp=math.prod(p-2 if e==1 else (p-1)**2*p**(e-2) for p,e in factors)
 for p,e in factors:
  if p==2:dims.extend([[2,2]] if e==2 else [[2,0],[2**(e-2),2]])
  else: dims.append([(p-1)*p**(e-1),(p-1)*p**(e-1) if e==1 else p])
 ck(phi==pv and primitive==pp and axes==dims)
 qt=2*c if c%2 else c
 hn=200+max(240 if c%2 else 255,ceildiv((192 if c%2 else 191)*3927*1063200,10*1250*qt))
 ck(H==hn and H>=ceildiv(27000000 if c%2 else 54000000,c) and H>=max(300,ceildiv(704*1063200,343*qt)))
 ck(J==ceildiv(64*H,5)+1)
 ww=[]
 for s,e in enumerate(EX):
  last=-1
  for end in ENDS:ww.append(max(0,min(J+e-1,end)-last));last=end
  ck(sum(ww[5*s:5*s+5])==J+e)
 ck(w==ww)
 for i,a in enumerate(w):units[i]+=phi*a
 suffix=phi;kept=full=1;v=Z
 for n,q in axes:
  suffix//=n;copies=kept*suffix
  v=add(v,scale(copies,requests[n,q][3]))
  bump(contexts,(n,q,2*full),w,copies)
  kept*=n if not q else n-n//q;full*=n
  axis_lengths.add(n);closure(n)
 ck(kept==primitive and full==phi)
 for s,e in enumerate(EX):
  totals[s]=add(totals[s],scale(J+e,v));labels[s]+=primitive*(J+e);heights[s]+=J+e
ck(len(contexts)==S['top_contexts'])
ck(units==S['unit_band'])

# Expand only compressed retained contexts. No occurrence/gate arrays.
pending={};hist={};processed=0
for (n,q,a),w in contexts.items():pending.setdefault(n,{})[q,a]=w
del contexts
def emit(cat,phase,n,j,a,b,d,count,w):
 if count:bump(hist,(cat,phase,n,j,lg(a),b,d),w,count)
def emitvec(v,phase,n,a,w):
 for cat,count in zip(['root','add','quarter','neg','scale'],v):
  ck(cat!='scale' or count==0)
  emit(cat,phase,n,0,a,int(cat=='root'),0,count,w)
def emit_radix(n,a,phase,w):
 for j in range(1,n.bit_length()):
  l=2**j
  emit('root',phase,n,j,l*a,1,0,n//l*(l//2-1-(j>1)),w)
  emit('quarter',phase,n,j,l*a,0,0,n//l*(j>1),w)
  emit('add',phase,n,j,2*l*a,0,0,n,w)
for n in sorted({n for n,q in requests},reverse=True):
 for (q,a),w in pending.pop(n,{}).items():
  processed+=1
  kind,ch,local,total=requests[n,q]
  if kind=='ct':
   r,m=(2,n//2) if plan[n]['choice'][0]=='radix2' else plan[n]['choice'][1:]
   emitvec(local,'ct_bridge',n,2*m*a,w)
   for cn,cq,mult,af in ch:bump(pending.setdefault(cn,{}),(cq,a*af),w,mult)
  elif kind=='radix2':emit_radix(n,a,'radix',w)
  elif kind=='pruned_two':emit('add',kind,n,1,4*a,0,0,1,w)
  elif kind=='direct_prime':emitvec(total,'direct',n,2*n*a,w)
  else:
   ck(kind=='bluestein');p=pad(n);z=2*n*(n+1)+2
   emitvec(cheap_chirp(n,0),'blue_pre_chirp',n,2*a,w)
   emit_radix(p,2*a,'blue_forward',w)
   emit('kernel','blue_point',n,0,(n+2)*a,lg(2*n+1),0,p,w)
   emit_radix(p,z*a,'blue_inverse',w)
   emit('scale','blue_inverse_division',n,0,2*p*z*a,0,lg(p),p,w)
   emitvec(cheap_chirp(n,q),'blue_post_chirp',n,(4*z+4)*a,w)
ck(not pending and processed==S['expanded_contexts'])
ck(len(hist)==S['event_classes'])
saved={}
for row in E['events']:
 k=tuple(row[:7]);w=row[7]
 ck(k not in saved and len(w)==20 and all(type(x)==int and x>=0 for x in w))
 saved[k]=w
 ck(k in hist and w==hist[k])
ck(saved.keys()==hist.keys())
project=[[0]*5 for _ in EX];split=[[0,0] for _ in EX]
for k,w in saved.items():
 cat=k[0];index={'root':0,'kernel':0,'add':1,'quarter':2,'neg':3,'scale':4}[cat]
 for s in range(4):
  count=sum(w[s*5:s*5+5]);project[s][index]+=count
  if cat in ('root','kernel'):split[s][int(cat=='kernel')]+=count
combined=load('major-constants/combined_odd_even_height_inventory_20261111.json')
reconciled=load('major-constants/reconciled_nonprincipal_schedule_20261111.json')
occ=load('prime-estimates/large_residue_bucket_occupancy_20261111.json')
for s,e in enumerate(EX):
 ck(project[s]==totals[s]==[S['scenarios'][s]['operations'][k] for k in KEYS])
 ck(S['scenarios'][s]['operations']==combined['scenarios'][s]['operations']==reconciled['scenarios'][s]['large']['transform_operations'])
 ck(split[s]==[S['scenarios'][s]['root_products'],S['scenarios'][s]['kernel_products']] and split[s][1]==totals[s][4])
 ck(labels[s]==combined['scenarios'][s]['primitive_outputs'] and heights[s]==combined['scenarios'][s]['conductor_height_nodes'])
 for b in range(5):ck(units[5*s+b]==sum(x['unit_outputs'] for x in occ['scenarios'][s]['bands'][b]['cohorts']))
kernels=[n for n in active if plan[n]['choice'][0]=='bluestein']
setup=dict(axis_lengths=len(axis_lengths),active_nodes=len(active),kernel_count=len(kernels),
 kernel_entries=sum(pad(n) for n in kernels),chirp_entries=sum(kernels),max_padded_length=max(map(pad,kernels)),
 kernel_forward_operations=dict(zip(KEYS,add(*(radix(pad(n)) for n in kernels)))),
 CT_full_root_table_entry_upper=sum(n for n in active if plan[n]['choice'][0]=='split'))
ck(setup==M['unchanged_setup']==S['setup']==combined['transform_setup_unchanged'])
out=dict(status='PASS_INDEPENDENT_STATIC_STRUCTURE_FOLD',checks=checks,pins=PINS,upstream_pins=M['pins'],
 plan_nodes=len(plan),requests=len(requests),conductors=len(M['conductors']),contexts=processed,event_classes=len(hist),
 scenarios=S['scenarios'],setup=setup,scope='Saved rows and compressed DAGs only; no author execution, unit enumeration, values, arithmetic admission or timing claim.')
path=HERE/'review_transform_structure_20261111.json'
with path.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=checks,output=str(path))))
