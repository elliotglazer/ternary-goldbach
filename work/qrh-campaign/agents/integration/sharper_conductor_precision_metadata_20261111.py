"""Authorized sharper assignment only. Saved full plan; no planner or value production."""
from pathlib import Path
from collections import Counter
from fractions import Fraction
from math import prod
import hashlib,json
HERE=Path(__file__).resolve().parent;AG=HERE.parent
MAX_BYTES=64*1024**2;MAX_STATES=334053;MAX_KERNELS=54036
CHECKS=0
def ck(x):
 global CHECKS
 assert x
 CHECKS+=1
def canon(x):return json.dumps(x,sort_keys=True,separators=(',',':')).encode()
def sha(raw):return hashlib.sha256(raw).hexdigest().upper()
PINS={
 'integration/transform_structural_manifest_20261111.json':(25110201,'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'),
 'zero-sum/mixed_radix_precision_metadata_20261111.json':(1911933,'8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E'),
 'major-constants/conductor_local_precision_rows_20261111.json':(21933038,'B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7'),
 'major-constants/conductor_local_precision_caches_20261111.json':(1902325,'95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584'),
 'major-constants/conductor_local_precision_metadata_20261111.json':(2686,'7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978'),
 'integration/short_window_guard_ledger_20261111.json':(41665,'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4'),
}
SUPPORT={
 'integration/SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_PREFLIGHT_2026-11-11.md':'2FDA2DDB0D8B0519377D026D1C88B70FD815BECD1C5C9A6E2EA826A75B335610',
 'major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_PREFLIGHT_2026-11-11.md':'2D21AF2BE4ADE3F8C58F066F1332C66C8A31D933BC5CD838F8D08C51ECE1E171',
 'audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md':'08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F',
 'prime-estimates/REVIEW_SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md':'3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3',
 'major-constants/CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md':'2F8F93B81BEA0FB4B133B7FEFC6FEDB2BAD2DEEC52FF07837DFA44F05D680A7D',
 'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md':'01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C',
 'zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md':'15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA',
}
for rel,h in SUPPORT.items():
 p=AG/rel;ck(p.stat().st_size<1024**2);ck(sha(p.read_bytes())==h)
inputs={};total_input=0
for rel,(size,h) in PINS.items():
 p=AG/rel;ck(p.stat().st_size==size and size<=32*1024**2)
 total_input+=size;ck(total_input<=MAX_BYTES)
 raw=p.read_bytes();ck(len(raw)==size and sha(raw)==h)
 inputs[rel]=json.loads(raw)
del raw
ck(total_input==50901848)
manifest,axisfile,legacy_rows,legacy_cache,legacy_summary,guard=[inputs[k] for k in PINS]
ck(manifest['schema']=='selected-transform-structural-manifest-1')
ck(manifest['conductor_fields']==['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'])
ck(manifest['extras']==[0,167,320,640] and manifest['band_last_indices']==[6400,12800,25600,64000,128000])
ck(len(manifest['conductors'])==125400 and len(manifest['plan'])==37117 and len(axisfile['axis_rows'])==13943)
plan={int(n):v for n,v in manifest['plan'].items()};order=sorted(plan)
plan_hash=hashlib.sha256(canon(manifest['plan'])).hexdigest()
ck(plan_hash==manifest['canonical_plan_sha256']==axisfile['plan_sha256']==legacy_cache['plan_sha256'])
ck(axisfile['max_old_sum_C']==424706204 and axisfile['max_new_sum_C']==202305920 and axisfile['max_old_D']==29961461170177)
source_binding={r:{'bytes':s,'sha256':h} for r,(s,h) in PINS.items()}
legacy_sources={r:source_binding[r] for r in list(PINS)[:2]}
for obj in (legacy_rows,legacy_cache,legacy_summary):ck(obj['inputs']==legacy_sources)
CONTRACT='22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884'
ck(sha(canon(legacy_cache['contract']))==CONTRACT)
for obj in (legacy_rows,legacy_cache,legacy_summary):ck(obj['contract_sha256']==CONTRACT)
ck(legacy_rows['fields']==['source_row_id','c','phi','primitive','ordered_axes_n_q','S_mixed','S_old','D_local','p','squared_budget_slack','D_slack','peak_slack'])
ck(len(legacy_rows['rows'])==125400)
ck(not legacy_rows['guards_included'] and not legacy_rows['prices_included'])
ck(not legacy_cache['guards_included'] and not legacy_cache['prices_included'])

def blue(n):
 P=1<<(2*n-2).bit_length();k=P.bit_length()-1;R=2*k+4;A=1+3*R
 ck(n>=2 and 2*n<=P<4*n and P%2==0)
 C=6*P*A+2*R*(2*n+1)+8
 sharp=9*P*A//2+3*P//2+3*R*n+12*R+14
 D=max(1,2*k,P*A,3*n*P*A+1)
 return C,D,sharp,D
coeff={}
for n in order:
 ck(n>=2 and str(n) in manifest['plan']);ch=plan[n]['choice']
 ck(ch[0] in ('radix2','direct_prime','bluestein','split'))
 if ch[0]=='split':
  ck(len(ch)==3);r,m=ch[1:];ck(r*m==n and 1<r<n and 1<m<n and r in coeff and m in coeff)
  cr,dr,sr,tr=coeff[r];cm,dm,sm,tm=coeff[m]
  pair=(cm+cr+2,max(1,dm,dr,cm+cr*(2*cm+1)),sm+sr+2,max(1,tm,tr,sm+sr*(2*sm+1)))
 else:
  ck(len(ch)==1)
  if ch[0]=='radix2':
   ck(n&(n-1)==0);k=n.bit_length()-1;C,D=2*k+4,max(1,2*k);pair=C,D,C,D
  elif ch[0]=='direct_prime':ck(n in (3,5,7,11));pair=(2,1,2,1)
  else:pair=blue(n)
 ck(pair[2]<=pair[0] and pair[3]<=pair[1]);coeff[n]=pair
axis={}
for a in axisfile['axis_rows']:
 ck(set(a)=={'n','old_C','new_C','old_D','new_D'})
 ck(all(type(v) is int and v>=0 for v in a.values()))
 n=a['n'];ck(n not in axis and n in coeff)
 ck(coeff[n][:2]==(a['new_C'],a['new_D']))
 ck(a['new_C']<=a['old_C'] and a['old_D']>=1 and a['new_D']>=1)
 axis[n]=a
ck(2**100>max(29961461170177,2*424706204))

constant=(1266*202305920)**2
legacy_tests=0;legacy_top=set();axis_lengths=set();seen=set();legacy_dist=Counter();phi_dist=Counter();prim_dist=Counter()
row_evidence=[]
for rid,(row,lr) in enumerate(zip(manifest['conductors'],legacy_rows['rows'])):
 ck(len(row)==7 and len(lr)==12)
 c,phi,primitive,H,J,axes,weights=row
 ck(type(c) is int and c not in seen and 10000<c<=265800 and ((c%2 and c<=132900) or c%4==0));seen.add(c)
 ck(1<=len(axes)<=18 and all(len(x)==2 and x[0] in axis and (x[1]==0 or (0<x[1]<=x[0] and x[0]%x[1]==0)) for x in axes))
 ck(prod(n for n,q in axes)==phi and prod(n if q==0 else n-n//q for n,q in axes)==primitive)
 ck(len(weights)==20 and all(type(w) is int and w>=0 for w in weights))
 S=sum(coeff[n][0] for n,q in axes);Sb=sum(axis[n]['old_C'] for n,q in axes)
 D=max([1]+[axis[n][key] for n,q in axes for key in ('old_D','new_D')])
 ck(S<=202305920 and Sb<=424706204 and D<=29961461170177)
 p=lr[8];ck(type(p) is int and 100<=p<=108)
 rhs=c*constant;slack=rhs-(2*phi*S)**2*2**(2*(108-p));legacy_tests+=1
 expected=[rid,c,phi,primitive,axes,S,Sb,D,p,slack,2**p-D,2**p-2*Sb]
 ck(lr==expected and min(expected[9:])>=0)
 if p>100:
  previous=rhs-(2*phi*S)**2*2**(2*(109-p));legacy_tests+=1;ck(previous<0)
 ck(legacy_tests<=250800)
 legacy_dist[p]+=1;phi_dist[p]+=phi;prim_dist[p]+=primitive
 row_evidence.append((S,Sb,D,p))
 for n,q in axes:legacy_top.add((n,p));axis_lengths.add(n)
ck(len(axis_lengths)==12496)

def closure(top,state_cap,kernel_cap):
 masks={}
 for n,p in top:ck(n in plan and 100<=p<=108);masks[n]=masks.get(n,0)|(1<<(p-100))
 for n in reversed(order):
  mask=masks.get(n,0);ck(0<=mask<512)
  if mask and plan[n]['choice'][0]=='split':
   for child in plan[n]['choice'][1:]:masks[child]=masks.get(child,0)|mask
 full=[];kernels=[];state_set=set();kernel_set=set();nodes=set()
 for n in order:
  mask=masks.get(n,0)
  for bit in range(9):
   if not (mask>>bit)&1:continue
   p=bit+100;ch=plan[n]['choice'];children=[] if ch[0]!='split' else [[d,p] for d in ch[1:]]
   ck(len(full)<state_cap);full.append([n,p,ch,children]);state_set.add((n,p));nodes.add(n)
   if ch[0]=='bluestein':
    P=1<<(2*n-2).bit_length();ck(len(kernels)<kernel_cap)
    kernels.append([n,p,P]);kernel_set.add((n,p,P))
 lengths={n for n,p,P in kernels};entries=sum(1<<(2*n-2).bit_length() for n in lengths)
 ck(len(nodes)==32942 and len(lengths)==6004 and entries==337702368)
 return full,kernels,state_set,kernel_set
old_full,old_kernels,old_states,old_keys=closure(legacy_top,38147,7606)
ck(old_full==legacy_cache['full_nodes'] and old_kernels==legacy_cache['kernels'])
ck(len(old_full)==38147==legacy_summary['full_plan_precision_states'])
ck(len(old_kernels)==7606==legacy_summary['local_kernel_keys'])
ck(sum(P for n,p,P in old_kernels)==364355904==legacy_summary['local_kernel_entries'])
for d in legacy_summary['precision_distribution']:
 p=d['p'];ks=[x for x in old_kernels if x[1]==p]
 ck((d['conductors'],d['phi_total'],d['primitive_total'],d['kernel_keys'],d['kernel_entries'])==
    (legacy_dist[p],phi_dist[p],prim_dist[p],len(ks),sum(x[2] for x in ks)))
ck(legacy_summary['scaled_cache_complex_rounds']==364355904 and legacy_summary['exact_real_cache_sums']==2*364355904)
print('Complete legacy coefficients, rows, slacks and full-cache closure matched.',flush=True)
del old_full,old_kernels

# New selector starts only after the complete legacy gate above.
new_rows=[];top=set();new_tests=0;distribution=Counter();transition=Counter();drops=Counter();nphi=Counter();nprim=Counter()
for rid,(row,evidence) in enumerate(zip(manifest['conductors'],row_evidence)):
 c,phi,primitive,H,J,axes,weights=row;Sm,Sb,D,pold=evidence
 Ss=sum(coeff[n][2] for n,q in axes);ck(Ss<=Sm)
 rhs=c*constant;previous=None;chosen=None
 for p in range(100,109):
  new_tests+=1;ck(new_tests<=1128600)
  budget=rhs-(2*phi*Ss)**2*2**(2*(108-p));ds=2**p-D;peak=2**p-2*Sb
  if budget>=0 and ds>=0 and peak>=0:
   chosen=(p,budget,ds,peak,previous);break
  previous=budget
 ck(chosen is not None);p,budget,ds,peak,previous=chosen
 ck(p<=pold and (previous is None if p==100 else previous<0))
 ck(len(new_rows)<125400)
 new_rows.append([rid,c,phi,primitive,Sm,Ss,Sb,D,pold,p,budget,ds,peak,previous])
 distribution[p]+=1;transition[pold,p]+=1;drops[pold-p]+=1;nphi[p]+=phi;nprim[p]+=primitive
 for n,q in axes:top.add((n,p))
new_full,new_kernels,new_states,new_keys=closure(top,MAX_STATES,MAX_KERNELS)
changed=sum(v for (p,q),v in transition.items() if p!=q)
ck(sum(distribution.values())==125400 and sum(transition.values())==125400 and changed==125400-drops[0])
ck(len(coeff)+len(new_rows)+len(new_full)+len(new_kernels)<=550606<1000000)
newdist=[]
for p in range(100,109):
 ks=[x for x in new_kernels if x[1]==p]
 newdist.append(dict(p=p,conductors=distribution[p],phi_total=nphi[p],primitive_total=nprim[p],kernel_keys=len(ks),kernel_entries=sum(x[2] for x in ks)))
entries=sum(P for n,p,P in new_kernels)
for sc in guard['scenarios']:
 ck(sc['extra_nodes'] in (0,167,320,640) and Fraction(sc['max_guard_height'])<7000)
ck(max(Fraction(sc['max_guard_height']) for sc in guard['scenarios'])==Fraction(26525,4))

common=dict(inputs=source_binding,support=SUPPORT,plan_sha256=plan_hash,contract_sha256=CONTRACT,
 guard_domain_applicable=True,guard_weights_folded=False,prices_included=False,production_selected=False)
def encode(obj):return (json.dumps(obj,separators=(',',':'))+'\n').encode()
def artifact(name,raw):return dict(path=name,bytes=len(raw),sha256=sha(raw))
row_name='sharper_conductor_precision_rows_20261111.json'
row_raw=encode(dict(schema='sharper-conductor-precision-rows-1',**common,
 legacy_assignment_sha256=PINS['major-constants/conductor_local_precision_rows_20261111.json'][1],
 fields=['source_row_id','c','phi','primitive','S_mix','S_sharp','S_base','D_local_old','p_mix','p_sharp',
 'budget_slack','D_slack','peak_slack','previous_budget_slack_or_null'],rows=new_rows,
 axes_and_weights='Exact source_row_id in pinned manifest, compared before output; no runtime weights folded.'))
row_art=artifact(row_name,row_raw)
node_name='sharper_conductor_precision_nodes_20261111.json'
node_raw=encode(dict(schema='sharper-full-plan-coefficients-1',**common,
 fields=['n','C_mix','D_mix','C_sharp','D_sharp'],rows=[[n,*coeff[n]] for n in order]))
node_art=artifact(node_name,node_raw)
cache_name='sharper_conductor_precision_caches_20261111.json'
cache_raw=encode(dict(schema='sharper-conductor-precision-caches-1',**common,
 legacy_assignment_sha256=PINS['major-constants/conductor_local_precision_rows_20261111.json'][1],
 sharp_assignment_sha256=row_art['sha256'],contract=legacy_cache['contract'],
 full_node_fields=legacy_cache['full_node_fields'],full_nodes=new_full,kernel_fields=['n','p','P'],kernels=new_kernels,
 state_intersection_with_legacy=len(new_states&old_states),state_only_sharp=len(new_states-old_states),state_only_legacy=len(old_states-new_states),
 kernel_intersection_with_legacy=len(new_keys&old_keys),kernel_only_sharp=len(new_keys-old_keys),kernel_only_legacy=len(old_keys-new_keys),
 sharing='Possible identical producer only at full contract/plan/key/lifetime equality; no cross-run or shared-high credit.'))
cache_art=artifact(cache_name,cache_raw)
summary_name='sharper_conductor_precision_metadata_20261111.json'
summary=dict(scope='Sharper assignment/full-cache closure only; no runtime, guard-weight, price or shared-high producer fold.',**common,
 checks_before_final_caps=CHECKS,legacy_match=True,legacy_selector_tests=legacy_tests,sharp_selector_tests=new_tests,
 conductors=125400,full_coefficient_nodes=37117,axis_records=13943,changed_conductors=changed,
 precision_distribution=newdist,transition_rows=[[p,q,v] for (p,q),v in sorted(transition.items())],
 bit_drop_distribution=dict(sorted(drops.items())),sharp_full_plan_precision_states=len(new_full),sharp_kernel_keys=len(new_kernels),
 sharp_kernel_entries=entries,scaled_cache_complex_rounds=entries,exact_real_cache_sums=2*entries,
 state_intersection_with_legacy=len(new_states&old_states),state_only_sharp=len(new_states-old_states),state_only_legacy=len(old_states-new_states),
 kernel_intersection_with_legacy=len(new_keys&old_keys),kernel_only_sharp=len(new_keys-old_keys),kernel_only_legacy=len(old_keys-new_keys),
 output_records=len(coeff)+len(new_rows)+len(new_full)+len(new_kernels),artifacts=[row_art,node_art,cache_art],
 limits=dict(input_bytes=MAX_BYTES,row_bytes=32*1024**2,node_bytes=8*1024**2,cache_bytes=20*1024**2,summary_bytes=1024**2,
  sharp_states=MAX_STATES,sharp_kernel_keys=MAX_KERNELS,total_records=1000000,total_new_bytes=MAX_BYTES),
 independent_reconstruction_pending=True,remaining='Actual per-p producers/roots/enclosures, ordinary proofs, full sample signs/completeness, setup/lifetimes and workload pricing.')
summary_raw=encode(summary)
raws=[(row_name,row_raw,32),(node_name,node_raw,8),(cache_name,cache_raw,20),(summary_name,summary_raw,1)]
for name,raw,mib in raws:ck(len(raw)<mib*1024**2 and not (HERE/name).exists())
# Reserve one MiB for the writer and final prose in addition to all JSON files.
ck(sum(len(raw) for name,raw,mib in raws)+1024**2<MAX_BYTES)
for name,raw,mib in raws:
 with (HERE/name).open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=CHECKS,legacy_tests=legacy_tests,sharp_tests=new_tests,p_changed=changed,
 distribution=newdist,states=len(new_full),kernel_keys=len(new_kernels),kernel_entries=entries,
 artifacts=[row_art,node_art,cache_art,artifact(summary_name,summary_raw)]),indent=2))
