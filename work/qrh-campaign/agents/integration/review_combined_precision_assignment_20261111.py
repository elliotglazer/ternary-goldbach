"""Independent saved-plan reconstruction. No author imports, planning or numerical values."""
from pathlib import Path
from functools import lru_cache
from collections import Counter
from math import prod
from fractions import Fraction
import hashlib,json,re,gc,ctypes,os
from ctypes import wintypes

HERE=Path(__file__).resolve().parent; AG=HERE.parent
AUTHOR=AG/'major-constants/COMBINED_CONDUCTOR_PRECISION_ASSIGNMENT_PREFLIGHT_2026-11-11.md'
PREFLIGHT='B563B8CC28DC1F2BCF08390BCF9385AD504432940A0C22D263BC9002037158B2'
WRITER='F67CF569467ED444A0BB8ED0F576166F4B289B8E5710CB769F08D3F22AF78408'
OUTPUTS={
 'major-constants/combined_conductor_precision_rows_20261111.json':(9568390,'2B9C245DCA582C93BFFCB022CEE858D09B07637D1D1D1F37D5C1FE5BDF94DBCB'),
 'major-constants/combined_conductor_precision_nodes_20261111.json':(2672728,'D3F0280F22D0D79EA8B99B46FF679F4BBFE2DED0C64B809C0322B75D3EC975C9'),
 'major-constants/combined_conductor_precision_caches_20261111.json':(137719,'6D992A88D3018394731B62387053C9E2A8C03EAFD95BDA750FC9E72FDDC54778'),
 'major-constants/combined_conductor_precision_summary_20261111.json':(13957,'493FAB7C41A216839CDA318DE0A80BB55C3CE9E5D4D6B8F4E47B44930A06C95B'),
}
CHECKS=0; PHASE='setup'; SEEN=set(); BYTES=0; PEAK=0; OBS=[]
def ck(x,label='check'):
 global CHECKS
 if not x:raise AssertionError((PHASE,label,CHECKS))
 CHECKS+=1
def sha(b):return hashlib.sha256(b).hexdigest().upper()
def canonical(x):return json.dumps(x,sort_keys=True,separators=(',',':')).encode()
class Counters(ctypes.Structure):
 _fields_=[('cb',wintypes.DWORD),('faults',wintypes.DWORD)]+[(n,ctypes.c_size_t) for n in ('peakws','ws','peakpaged','paged','peaknonpaged','nonpaged','pagefile','peakpagefile','private')]
def mem(label,save=False):
 global PEAK
 ck(os.name=='nt');c=Counters();c.cb=ctypes.sizeof(c)
 handle=ctypes.windll.kernel32.GetCurrentProcess;handle.restype=ctypes.c_void_p
 f=ctypes.windll.psapi.GetProcessMemoryInfo;f.argtypes=[ctypes.c_void_p,ctypes.POINTER(Counters),wintypes.DWORD];f.restype=wintypes.BOOL
 ck(f(handle(),ctypes.byref(c),c.cb));ck(c.private<=1024**3,'memory stop')
 PEAK=max(PEAK,c.private)
 if save:OBS.append([label,c.private])
def phase(s):
 global PHASE
 PHASE=s;gc.collect();mem(s,True);print(s,flush=True)
def pint(s):
 ck(len(s)<=310);v=int(s);ck(abs(v).bit_length()<=1024);return v
raw=AUTHOR.read_bytes();ck(sha(raw)==PREFLIGHT)
PINS={p:(int(n),h) for p,n,h in re.findall(r'^\|`([^`]+\.json)`\|(\d+)\|`([A-F0-9]{64})`\|$',raw.decode(),re.M)}
ck(len(PINS)==10 and sum(v[0] for v in PINS.values())==75419343)
ck(sha((AG/'major-constants/combined_conductor_precision_assignment_20261111.py').read_bytes())==WRITER)
del raw
ck(len(OUTPUTS)==4,'four frozen output pins required')
ALL={**PINS,**OUTPUTS}
def read(path):
 global BYTES
 ck(path in ALL and path not in SEEN);size,h=ALL[path]
 ck((AG/path).stat().st_size==size and size<=32*2**20)
 mem('before read');b=(AG/path).read_bytes();ck(sha(b)==h)
 obj=json.loads(b,parse_int=pint);del b
 SEEN.add(path);BYTES+=size;mem('after read');return obj
phase('saved source plan and independent recursive coefficients')
mf=read('integration/transform_structural_manifest_20261111.json')
af=read('zero-sum/mixed_radix_precision_metadata_20261111.json')
ck(mf['schema']=='selected-transform-structural-manifest-1')
ck(len(mf['conductors'])==125400 and len(mf['plan'])==37117)
planhash=sha(canonical(mf['plan'])).lower()
ck(planhash==mf['canonical_plan_sha256']==af['plan_sha256']=='fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b')
plan={int(n):tuple(x['choice']) for n,x in mf['plan'].items()};order=sorted(plan)
src=mf['conductors'];del mf
parents={n:[] for n in order};edge_count=0
for n,ch in plan.items():
 if ch[0]=='split':
  ck(len(ch)==3 and ch[1]*ch[2]==n)
  for child in ch[1:]:ck(1<child<n and child in plan);parents[child].append(n);edge_count+=1
 else:ck(len(ch)==1 and ch[0] in ('radix2','direct_prime','bluestein'))
ck(edge_count<=74234)
@lru_cache(None)
def coeff(n):
 ch=plan[n]
 if ch[0]=='split':
  r,m=ch[1:];a,b=coeff(m),coeff(r);out=[]
  for j in (0,2,4):out.extend((a[j]+b[j]+2,max(a[j+1],b[j+1],a[j]+b[j]*(2*a[j]+1),1)))
  ans=tuple(out)
 elif ch[0]=='radix2':
  ck(n>=2 and n&(n-1)==0);k=n.bit_length()-1;ans=(2*k+4,max(1,2*k))*3
 elif ch[0]=='direct_prime':ck(n in (3,5,7,11));ans=(2,1)*3
 else:
  P=2**((2*n-2).bit_length());k=P.bit_length()-1;R=2*k+4;A=1+3*R
  old=6*P*A+2*R*(2*n+1)+8;D=max(1,2*k,P*A,3*n*P*A+1)
  sharp=old-(R*(9*P//2+n-10)-6)
  E=P*(3*n*A+n+2)+R*(n*(2*n-1)+2*P);quo,rem=divmod(E,n)
  ans=(old,D,sharp,D,quo+int(rem!=0)+2,max(D,2*old))
 ck(ans[4]<=ans[2]<=ans[0] and ans[3]<=ans[1] and ans[5]<=max(ans[1],2*ans[0]))
 ck(all(0<=v and v.bit_length()<=1024 for v in ans));return ans
for n in order:coeff(n)
axis={x['n']:x for x in af['axis_rows']};ck(len(axis)==13943)
for n,a in axis.items():ck(coeff(n)[:2]==(a['new_C'],a['new_D']) and a['new_C']<=a['old_C'])
ck((af['max_old_sum_C'],af['max_new_sum_C'],af['max_old_D'])==(424706204,202305920,29961461170177));del af
obj=read('integration/sharper_conductor_precision_nodes_20261111.json')
ck(len(obj['rows'])==37117)
for n,row in zip(order,obj['rows']):ck(row==[n,*coeff(n)[:4]])
del obj

def solve(num2,rhs,lo,hi):
 if num2==0:return lo
 quotient=rhs//num2
 if quotient==0:return None
 # 2^(2*(108-p)) <= quotient, without a candidate loop.
 p=max(lo,108-(quotient.bit_length()-1)//2)
 return p if p<=hi else None

phase('source binding and independent quotient selectors')
Q=2**52;Cg=4196258524692480;small=(1266*202305920)**2
ev=[];pm=[];ps=[];pc=[];seen=set()
for rid,row in enumerate(src):
 if rid%1024==0:mem('row selectors')
 c,phi,primitive,H,J,axes,weights=row
 ck(c not in seen and 10000<c<=265800 and (c%4==0 or c%2==1 and c<=132900));seen.add(c)
 ck(1<=len(axes)<=18 and len(weights)==20)
 ck(all(n in axis and (q==0 or 0<q<=n and n%q==0) for n,q in axes))
 ck(prod(n for n,q in axes)==phi and prod(n if q==0 else n-n//q for n,q in axes)==primitive)
 sums=[sum(coeff(n)[j] for n,q in axes) for j in (0,2,4)]
 base=sum(axis[n]['old_C'] for n,q in axes);D=max([1]+[axis[n][v] for n,q in axes for v in ('old_D','new_D')])
 Sm,Ss,St=sums;ck(0<=St<=Ss<=Sm<=202305920 and base<=424706204 and D<=29961461170177)
 ck(2**80>=max(D,2*base))
 old=solve((2*phi*Sm)**2,c*small,100,108);sharp=solve((2*phi*Ss)**2,c*small,100,108)
 rhs=c*((Q-1)*Cg)**2
 low=solve((phi*(Q*St*8828+Q-1))**2,rhs,80,99)
 chosen=low if low is not None else solve((phi*Q*St*8828)**2,rhs,100,108)
 ck(chosen is not None and chosen<=sharp<=old)
 ev.append((Sm,Ss,St,base,D));pm.append(old);ps.append(sharp);pc.append(chosen)
del seen

phase('exact predecessor rows')
obj=read('major-constants/conductor_local_precision_rows_20261111.json');ck(len(obj['rows'])==125400)
for i,(s,r,e,p) in enumerate(zip(src,obj['rows'],ev,pm)):
 c,phi,prim=s[:3];Sm,Ss,St,Sb,D=e;budget=c*small-(2*phi*Sm)**2*2**(2*(108-p))
 ck(r==[i,c,phi,prim,s[5],Sm,Sb,D,p,budget,2**p-D,2**p-2*Sb] and budget>=0)
 ck(p==100 or c*small-(2*phi*Sm)**2*2**(2*(109-p))<0)
 if i%1024==0:mem('old row comparison')
old_contract_hash=obj['contract_sha256'];del obj
obj=read('integration/sharper_conductor_precision_rows_20261111.json');ck(len(obj['rows'])==125400)
for i,(s,r,e,p) in enumerate(zip(src,obj['rows'],ev,ps)):
 c,phi,prim=s[:3];Sm,Ss,St,Sb,D=e;budget=c*small-(2*phi*Ss)**2*2**(2*(108-p))
 prev=None if p==100 else c*small-(2*phi*Ss)**2*2**(2*(109-p))
 ck(r==[i,c,phi,prim,Sm,Ss,Sb,D,pm[i],p,budget,2**p-D,2**p-2*Sb,prev] and budget>=0)
 ck(prev is None or prev<0)
 if i%1024==0:mem('sharp row comparison')
del obj

def closure(precisions):
 seed={n:set() for n in order};top=set()
 for i,(s,p) in enumerate(zip(src,precisions)):
  for n,q in s[5]:seed[n].add(p);top.add(n)
  if i%1024==0:mem('reverse closure seeds')
 ck(len(top)==12496)
 @lru_cache(None)
 def above(n):
  # Reverse DAG: all precisions arriving from parents, each node evaluated once.
  out=set(seed[n])
  for parent in parents[n]:out.update(above(parent))
  ck(all(80<=p<=108 for p in out));return frozenset(out)
 masks={}
 for i,n in enumerate(order):
  masks[n]=sum(1<<(p-80) for p in above(n))
  if i%1024==0:mem('reverse closure')
 ck(sum(bool(x) for x in masks.values())==32942)
 ks=[n for n in order if masks[n] and plan[n][0]=='bluestein']
 ck(len(ks)==6004 and sum(1<<(2*n-2).bit_length() for n in ks)==337702368)
 above.cache_clear();return masks,ks

phase('independent reverse-DAG full closures')
mm,ks=closure(pm);ms,ks2=closure(ps);mc,ks3=closure(pc);ck(ks==ks2==ks3)
def stats(m):return (sum(v.bit_count() for v in m.values()),sum(m[n].bit_count() for n in ks),sum((1<<(2*n-2).bit_length())*m[n].bit_count() for n in ks))
ck(stats(mm)==(38147,7606,364355904));ck(stats(ms)==(37522,7850,369180928))
ck(stats(mc)[0]<=1076393 and stats(mc)[1]<=174116)
def cache_match(path,m):
 obj=read(path);ck(obj['plan_sha256']==planhash and obj['contract_sha256']==old_contract_hash)
 ck(sha(canonical(obj['contract']))==old_contract_hash)
 nodes=iter(obj['full_nodes']);kernels=iter(obj['kernels']);nc=kc=0
 for n in order:
  for p in range(100,109):
   if (m[n]>>(p-80))&1:
    ch=list(plan[n]);children=[[x,p] for x in ch[1:]] if ch[0]=='split' else []
    ck(next(nodes,None)==[n,p,ch,children]);nc+=1
    if ch[0]=='bluestein':ck(next(kernels,None)==[n,p,1<<(2*n-2).bit_length()]);kc+=1
 ck(next(nodes,None) is None and next(kernels,None) is None and (nc,kc)==stats(m)[:2])
 contract=obj['contract'];del obj;gc.collect();return contract
old_contract=cache_match('major-constants/conductor_local_precision_caches_20261111.json',mm)
ck(cache_match('integration/sharper_conductor_precision_caches_20261111.json',ms)==old_contract)
def dist(pv,m,lo):
 d=Counter(pv);fc=Counter();rc=Counter()
 for row,p in zip(src,pv):fc[p]+=row[1];rc[p]+=row[2]
 return [dict(p=p,conductors=d[p],phi_total=fc[p],primitive_total=rc[p],kernel_keys=sum(bool(m[n]&(1<<(p-80))) for n in ks),kernel_entries=sum((1<<(2*n-2).bit_length()) for n in ks if m[n]&(1<<(p-80)))) for p in range(lo,109)]
obj=read('major-constants/conductor_local_precision_metadata_20261111.json')
ck(obj['precision_distribution']==dist(pm,mm,100));ck(obj['local_kernel_entries']==stats(mm)[2]);del obj
obj=read('integration/sharper_conductor_precision_metadata_20261111.json')
ck(obj['precision_distribution']==dist(ps,ms,100));ck(obj['sharp_kernel_entries']==stats(ms)[2]);del obj
obj=read('integration/short_window_guard_ledger_20261111.json')
ck([x['extra_nodes'] for x in obj['scenarios']]==[0,167,320,640])
ck(max(Fraction(x['max_guard_height']) for x in obj['scenarios'])==Fraction(26525,4)<7000);del obj
ck(SEEN==set(PINS),'all ten predecessors read before outputs')

phase('frozen combined rows nodes and contracts')
obj=read('major-constants/combined_conductor_precision_rows_20261111.json');ck(len(obj['rows'])==125400 and obj['schema']=='combined-conductor-precision-rows-2')
common={k:obj[k] for k in ('plan_sha256','input_contract_sha256','kernel_contract_sha256','writer_sha256')}
ck(common['writer_sha256']==WRITER and common['plan_sha256']==planhash)
for i,(s,r,e,p) in enumerate(zip(src,obj['rows'],ev,pc)):
 c,phi,prim=s[:3];Sm,Ss,St,Sb,D=e;rho=int(p<100);rhs=c*((Q-1)*Cg)**2
 def slack(t):return rhs-(phi*((Q-1)*int(t<100)+Q*St*8828))**2*2**(2*(108-t))
 budget=slack(p);previous=None if p==80 else slack(p-1)
 ck(r==[i,c,phi,prim,Sm,Ss,St,Sb,D,pm[i],ps[i],p,rho])
 ck(budget>=0 and 2**p>=D and 2**p>=2*Sb and (previous is None or previous<0))
 if i%1024==0:mem('combined output rows')
del obj
obj=read('major-constants/combined_conductor_precision_nodes_20261111.json');ck(len(obj['rows'])==37117)
ck(all(obj[k]==v for k,v in common.items()))
for n,row in zip(order,obj['rows']):ck(row==[n,*coeff(n),mc[n]])
del obj
obj=read('major-constants/combined_conductor_precision_caches_20261111.json')
ck(all(obj[k]==v for k,v in common.items()))
ck(obj['rows']==[[n,1<<(2*n-2).bit_length(),mc[n]] for n in ks])
ck(sha(canonical(obj['input_contract']))==common['input_contract_sha256'])
ck(sha(canonical(obj['kernel_contract']))==common['kernel_contract_sha256'])
ck(obj['input_contract']['p_domain']==[80,108] and obj['input_contract']['magnitudes']=={'V_error':8828,'V_width':16384})
ck(obj['kernel_contract']['p_domain']==[80,108])
fields=[k for k in old_contract if k not in ('id','p_domain','coordinate_grid')]
ck(obj['kernel_projection_fields']==fields)
ck({k:obj['kernel_contract'][k] for k in fields}=={k:old_contract[k] for k in fields})
ck(obj['kernel_projection_sha256']==sha(canonical({k:old_contract[k] for k in fields})))
for label,m in [('mixed',mm),('sharp',ms)]:
 si=sum((m[n]&mc[n]).bit_count() for n in order);ki=sum((m[n]&mc[n]).bit_count() for n in ks)
 expected=dict(node_projection_intersection=si,node_only_combined=stats(mc)[0]-si,node_only_old=stats(m)[0]-si,kernel_projection_intersection=ki,kernel_only_combined=stats(mc)[1]-ki,kernel_only_old=stats(m)[1]-ki)
 ck(obj['projected_alternative_comparisons'][label]==expected)
cachecomparisons=obj['projected_alternative_comparisons'];del obj

phase('complete summary projection')
obj=read('major-constants/combined_conductor_precision_summary_20261111.json')
ck(all(obj[k]==v for k,v in common.items()))
ck(obj['precision_distribution']==dist(pc,mc,80))
ck((obj['node_precision_memberships'],obj['kernel_precision_memberships'],obj['kernel_entries'])==stats(mc))
ck(obj['scaled_cache_complex_rounds']==stats(mc)[2] and obj['exact_real_cache_sums']==2*stats(mc)[2])
ck(obj['projected_alternative_comparisons']==cachecomparisons)
for label,pv in [('mixed',pm),('sharp',ps)]:
 tr=Counter(zip(pv,pc));drops=Counter(a-b for a,b in zip(pv,pc))
 ck(obj['transitions'][label]==[[a,b,v] for (a,b),v in sorted(tr.items())])
 ck(obj['bit_drop_distributions'][label]=={str(k):v for k,v in sorted(drops.items())})
 ck(obj['changed_vs_'+label]==sum(a!=b for a,b in zip(pv,pc)))
ck(obj['combined_selector_tests']==sum(p-79 for p in pc) and obj['max_combined_tests_per_row']==max(p-79 for p in pc))
ck(obj['legacy_selector_tests']==sum(1+(p>100) for p in pm) and obj['sharp_selector_tests']==sum(1+(p>100) for p in ps))
ck(obj['kernel_precision_multiplicity_histogram']=={str(k):v for k,v in sorted(Counter(mc[n].bit_count() for n in ks).items())})
ck(obj['regrid_population_only']['conductors']==sum(p<100 for p in pc))
ck(obj['regrid_population_only']['phi_sum']==sum(s[1] for s,p in zip(src,pc) if p<100))
ck(obj['input_bytes_read']==75419343 and obj['substantive_records']==168521 and obj['conservative_record_count']<=200000)
ck(obj['legacy_all_rows_slacks_and_keys_matched'] and obj['sharp_all_rows_slacks_and_keys_matched'])
for k in ('assignment_only','guard_domain_applicable'):ck(obj[k])
for k in ('guard_weights_folded','prices_included','values_generated','production_selected'):ck(not obj[k])
ck(all(v<=1024**3 for label,v in obj['memory_observations']))
ck(SEEN==set(ALL) and sum(v[0] for v in OUTPUTS.values())<48*2**20)
result=dict(author_preflight=PREFLIGHT,writer_sha256=WRITER,checks=CHECKS,input_pins=PINS,output_pins=OUTPUTS,
 method='Recursive coefficient/gap arithmetic; quotient bit-length selectors; reverse-parent memoized closure; no author imports.',
 distribution=obj['precision_distribution'],memberships=list(stats(mc)),changed_vs_sharp=obj['changed_vs_sharp'],
 observed_private_peak=PEAK,memory_observations=OBS,metadata_only=True,scope='Independent saved assignment reconstruction, no numerical producers or price fold.')
del obj
phase('exclusive review receipt')
raw=(json.dumps(result,indent=2,sort_keys=True)+'\n').encode();ck(len(raw)<2**20)
out=HERE/'review_combined_precision_assignment_20261111.json'
with out.open('xb') as f:f.write(raw)
print(json.dumps({'checks':CHECKS,'bytes':len(raw),'sha256':sha(raw),'observed_private_peak':PEAK}))
