"""Saved-plan assignment only. Execution requires clearance of this exact source hash."""
from pathlib import Path
from collections import Counter
from fractions import Fraction
from math import prod
import ctypes
from ctypes import wintypes
import gc
import hashlib
import json
import os

HERE = Path(__file__).resolve().parent
AG = HERE.parent
MIB = 1024**2
CHECKS = 0
PHASE = 'startup'
WRITTEN = []
MEMORY = []
READ_BYTES = 0
READ_PATHS = set()
PINS = {
 'integration/transform_structural_manifest_20261111.json': (25110201,'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'),
 'zero-sum/mixed_radix_precision_metadata_20261111.json': (1911933,'8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E'),
 'major-constants/conductor_local_precision_rows_20261111.json': (21933038,'B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7'),
 'major-constants/conductor_local_precision_caches_20261111.json': (1902325,'95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584'),
 'major-constants/conductor_local_precision_metadata_20261111.json': (2686,'7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978'),
 'integration/short_window_guard_ledger_20261111.json': (41665,'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4'),
 'integration/sharper_conductor_precision_rows_20261111.json': (20920838,'8FD72DC7FD9EACCCF986BE92502AE13491F974744C9E6A6E32BD63ADC27ED085'),
 'integration/sharper_conductor_precision_nodes_20261111.json': (1720100,'29A7C789AD3B5BC34D2177567FECEFB1FBBE7CFF432943150FCF18B868E7C9D6'),
 'integration/sharper_conductor_precision_caches_20261111.json': (1871369,'129ADFCF668378CA94140DB27F3A3D6EF43995E05EB1413D3BE8AC603061D831'),
 'integration/sharper_conductor_precision_metadata_20261111.json': (5188,'8CEA147C264CC963CAE2EBAFE58F32E4CCD53A99378D7403161510993862227F'),
}
SUPPORT = {
 'major-constants/COMBINED_PRECISION_COMPACT_ROW_AMENDMENT_2026-11-11.md':'AACBB5CA78AA460F811FBDF90040741E9A546AC23381F9A9BF8DA9F53DC5A25B',
 'major-constants/COMBINED_PRECISION_FIRST_RUN_STOP_2026-11-11.md':'11FA5B695F37C9A2A0669282CDFC4D8A351D2FBD54E4A55AB240E0FD444938DD',
 'major-constants/COMBINED_CONDUCTOR_PRECISION_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'B563B8CC28DC1F2BCF08390BCF9385AD504432940A0C22D263BC9002037158B2',
 'integration/REVIEW_COMBINED_CONDUCTOR_PRECISION_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'E1DA5A7A4101326B2419EB9367D842405AB9965DC44B8807B33CE8F345C9B2B8',
 'prime-estimates/TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md':'5E3B9FCDC374998149ABBF3262BF925E0D02C6BFBF399462D1C34ABB68218F6F',
 'major-constants/REVIEW_TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md':'E7482930B1A6B57FD6C186AD4612E655379D0978DD6C5EDA9C4D4D6D247920F5',
 'integration/TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md':'DB2E3B9FF269E551901622B844AF579D7FCE12045F71B66D947CA392FD1A928C',
 'zero-sum/REVIEW_TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md':'EC2FD8569DF2D74B758F6FDD9DC58153BD0FF6B662919ECE43B014C0E064BC26',
 'independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266',
 'independent-feasibility/SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md':'39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761',
 'audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD',
 'major-constants/CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md':'2F8F93B81BEA0FB4B133B7FEFC6FEDB2BAD2DEEC52FF07837DFA44F05D680A7D',
 'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md':'01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C',
 'integration/SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'62D619E84704F6A9D9DA949AF769419E4F4110A9F07C6BFC56EBED127B0DEC57',
 'major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'F213CB6BC227DFE0C5A25DD92B3DE6405165E7281678EA9224596EE7704FCF39',
 'zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md':'15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA',
}

def ck(ok, label='check'):
 global CHECKS
 if not ok:
  raise AssertionError((PHASE, label, CHECKS))
 CHECKS += 1

def integer(x):
 ck(type(x) is int and abs(x).bit_length() <= 1024, 'metadata integer capacity')
 return x

def parse_integer(s):
 ck(len(s) <= 310, 'integer literal length')
 return integer(int(s))

def canon(obj):
 return json.dumps(obj,sort_keys=True,separators=(',',':')).encode()

def sha(raw):
 return hashlib.sha256(raw).hexdigest().upper()

class PMC(ctypes.Structure):
 _fields_ = [('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)] + [
  (name,ctypes.c_size_t) for name in ('PeakWorkingSetSize','WorkingSetSize',
   'QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage',
   'QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage','PrivateUsage')]

def memory(label, record=True):
 ck(os.name == 'nt', 'Windows private-memory observer required')
 pm=PMC();pm.cb=ctypes.sizeof(pm)
 get_process=ctypes.windll.kernel32.GetCurrentProcess
 get_process.restype=ctypes.c_void_p
 get_mem=ctypes.windll.psapi.GetProcessMemoryInfo
 get_mem.argtypes=[ctypes.c_void_p,ctypes.POINTER(PMC),wintypes.DWORD]
 get_mem.restype=wintypes.BOOL
 ck(bool(get_mem(get_process(),ctypes.byref(pm),pm.cb)), 'GetProcessMemoryInfo')
 ck(pm.PrivateUsage <= 1024*MIB, 'observed private memory exceeded 1 GiB')
 if record:
  MEMORY.append([label,pm.PrivateUsage])
 else:
  if pm.PrivateUsage > MEMORY[0][1]: MEMORY[0]=['maximum loop observation',pm.PrivateUsage]

def phase(label):
 global PHASE
 PHASE=label
 gc.collect()
 memory(label)
 print(label,flush=True)

def read(rel):
 global READ_BYTES
 ck(rel in PINS and rel not in READ_PATHS, 'allowlisted single read')
 size,pin=PINS[rel];p=AG/rel
 ck(p.stat().st_size==size and size<=32*MIB, 'input file size')
 READ_BYTES+=size;ck(READ_BYTES<=96*MIB, 'aggregate input size')
 memory('before parse '+rel)
 raw=p.read_bytes();ck(len(raw)==size and sha(raw)==pin, 'input hash')
 obj=json.loads(raw,parse_int=parse_integer)
 del raw
 READ_PATHS.add(rel)
 memory('after parse '+rel)
 return obj

def artifact(rel):
 size,pin=PINS[rel]
 return {'path':Path(rel).name,'bytes':size,'sha256':pin}

OLD_CONTRACT = {
 'id':'local-u-rounded-normalized-blue-v1',
 'p_domain':[100,108],
 'coordinate_grid':'2^-p; exact grid100 input embedding',
 'root_chirp_norm_error':'<=u=2^-p from exact coefficient specified by saved full-plan convention',
 'complex_gate_absolute_error':'<=u, exact common-grid additions allowed',
 'original_kernel_error':'<=P*A*u from specified exact chirp FFT; A=1+3*(2*log2(P)+4)',
 'scaled_kernel_error':'<= (A+1)*u from exact K/P; center is Round_u(Khat/P)',
 'rounding_policy':'coordinate nearest, lower-closed upper-open residual; fixed across object',
 'cached_sums':'two exact REAL sums of the actual new scaled complex center',
 'lifetime':'one cold construction retained for this complete pass; rebuilds not credited free',
 'cache_identity':'full plan/hash, n,P,chirp/sign convention,variant,p,rounding,contract,lifetime',
}
OLD_HASH='22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884'
NAMES=[('combined_conductor_precision_rows_20261111.json',32),
 ('combined_conductor_precision_nodes_20261111.json',8),
 ('combined_conductor_precision_caches_20261111.json',4),
 ('combined_conductor_precision_summary_20261111.json',1)]

def main():
 phase('source and destination gate')
 for rel,pin in SUPPORT.items():
  p=AG/rel;ck(p.stat().st_size<MIB);ck(sha(p.read_bytes())==pin,'mathematical support pin')
 for name,cap in NAMES:ck(not (HERE/name).exists(),'exclusive destination already exists')
 ck(sum(s for s,h in PINS.values())==75419343)
 ck(sha(canon(OLD_CONTRACT))==OLD_HASH)
 sources={r:{'bytes':s,'sha256':h} for r,(s,h) in PINS.items()}
 legacy_sources={r:sources[r] for r in list(PINS)[:2]}
 sharp_sources={r:sources[r] for r in list(PINS)[:6]}

 phase('saved manifest and coefficients')
 manifest=read(list(PINS)[0]);af=read(list(PINS)[1])
 ck(manifest['schema']=='selected-transform-structural-manifest-1')
 ck(manifest['conductor_fields']==['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'])
 ck(manifest['request_fields']==['n','q','kind','children_n_q_multiplicity_normfactor','local_five_counts','five_counts'])
 ck(manifest['extras']==[0,167,320,640] and manifest['band_last_indices']==[6400,12800,25600,64000,128000])
 ck(len(manifest['conductors'])==125400 and len(manifest['plan'])==37117 and len(manifest['requests'])==35190)
 ck(af['status']=='PASS_INTEGER_ERROR_COEFFICIENT_COMPARISON' and len(af['axis_rows'])==13943)
 ph=sha(canon(manifest['plan'])).lower()
 ck(ph==manifest['canonical_plan_sha256']==af['plan_sha256']=='fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b')
 ck((af['max_old_sum_C'],af['max_new_sum_C'],af['max_old_D'])==(424706204,202305920,29961461170177))
 plan={int(n):v['choice'] for n,v in manifest['plan'].items()};order=sorted(plan)
 coeff={}
 for idx,n in enumerate(order):
  if idx%1024==0:memory('coefficient loop',False)
  ck(n>=2 and str(n) in manifest['plan']);ch=plan[n]
  if ch[0]=='split':
   ck(len(ch)==3);r,m=ch[1:]
   ck(r*m==n and 1<r<n and 1<m<n and r in coeff and m in coeff)
   out=[]
   for j in (0,2,4):
    cr,dr=coeff[r][j:j+2];cm,dm=coeff[m][j:j+2]
    out.extend([cm+cr+2,max(dm,dr,1,cm+cr*(2*cm+1))])
  else:
   ck(len(ch)==1)
   if ch[0]=='radix2':
    ck(n&(n-1)==0);k=n.bit_length()-1;out=[2*k+4,max(1,2*k)]*3
   elif ch[0]=='direct_prime':
    ck(n in (3,5,7,11));out=[2,1]*3
   else:
    ck(ch[0]=='bluestein')
    P=1<<(2*n-2).bit_length();k=P.bit_length()-1;R=2*k+4;A=1+3*R
    ck(2*n<=P<4*n and P%2==0)
    C=6*P*A+2*R*(2*n+1)+8;D=max(1,2*k,P*A,3*n*P*A+1)
    Cs=9*P*A//2+3*P//2+3*R*n+12*R+14
    E=P*(3*n*A+n+2)+R*(n*(2*n-1)+2*P)
    Ct=(E+n-1)//n+2;out=[C,D,Cs,D,Ct,max(D,2*C)]
   
  for v in out:integer(v)
  ck(out[4]<=out[2]<=out[0] and out[3]<=out[1])
  ck(out[5]<=max(out[1],2*out[0]),'tight D composition')
  coeff[n]=out
 axis={}
 for a in af['axis_rows']:
  ck(set(a)=={'n','old_C','new_C','old_D','new_D'})
  ck(all(type(v) is int and v>=0 for v in a.values()))
  n=a['n'];ck(n not in axis and n in coeff and coeff[n][:2]==[a['new_C'],a['new_D']])
  ck(a['new_C']<=a['old_C'] and min(a['old_D'],a['new_D'])>=1)
  axis[n]=a
 del af
 # Only a fixed saved plan is evaluated. No use of the request DAG as a cache planner.
 del manifest['requests']
 obj=read('integration/sharper_conductor_precision_nodes_20261111.json')
 ck(obj['schema']=='sharper-full-plan-coefficients-1' and obj['inputs']==sharp_sources)
 ck(obj['plan_sha256']==ph and obj['contract_sha256']==OLD_HASH)
 ck(obj['fields']==['n','C_mix','D_mix','C_sharp','D_sharp'] and len(obj['rows'])==37117)
 for n,row in zip(order,obj['rows']):ck(row==[n,*coeff[n][:4]])
 del obj
 
 def close_masks(ps,floor):
  masks={n:0 for n in order};top=set();edges=0
  for rid,(src,p) in enumerate(zip(manifest['conductors'],ps)):
   if rid%1024==0:memory('cache seeds',False)
   ck(floor<=p<=108)
   for n,q in src[5]:masks[n]|=1<<(p-floor);top.add(n)
  ck(len(top)==12496)
  for n in reversed(order):
   mask=masks[n];ck(0<=mask<(1<<(109-floor)))
   if mask and plan[n][0]=='split':
    for child in plan[n][1:]:
     edges+=1;ck(edges<=74234);masks[child]|=mask
  active=[n for n in order if masks[n]]
  kernels=[n for n in active if plan[n][0]=='bluestein']
  ck(len(active)==32942 and len(kernels)==6004)
  ck(sum(1<<(2*n-2).bit_length() for n in kernels)==337702368)
  return masks,kernels,edges

 def cache_stats(masks,kernels,floor):
  states=sum(v.bit_count() for v in masks.values());keys=sum(masks[n].bit_count() for n in kernels)
  entries=sum((1<<(2*n-2).bit_length())*masks[n].bit_count() for n in kernels)
  mult=Counter(masks[n].bit_count() for n in kernels)
  kd={p:sum(bool(masks[n]&(1<<(p-floor))) for n in kernels) for p in range(floor,109)}
  ke={p:sum((1<<(2*n-2).bit_length()) for n in kernels if masks[n]&(1<<(p-floor))) for p in range(floor,109)}
  return states,keys,entries,mult,kd,ke

 def match_cache(obj,masks,kernels,states,keys):
  ck(obj['plan_sha256']==ph and obj['contract_sha256']==OLD_HASH and obj['contract']==OLD_CONTRACT)
  ck(obj['full_node_fields']==['n','p','saved_choice','ordered_child_n_p'] and obj['kernel_fields']==['n','p','P'])
  ck(len(obj['full_nodes'])==states and len(obj['kernels'])==keys)
  it=iter(obj['full_nodes']);kit=iter(obj['kernels']);count=0;kc=0
  for idx,n in enumerate(order):
   if idx%1024==0:memory('cache full-key comparison',False)
   for bit in range(9):
    if not masks[n]&(1<<bit):continue
    p=100+bit;ch=plan[n];children=[] if ch[0]!='split' else [[child,p] for child in ch[1:]]
    ck(next(it,None)==[n,p,ch,children]);count+=1
    if ch[0]=='bluestein':
     ck(next(kit,None)==[n,p,1<<(2*n-2).bit_length()]);kc+=1
  ck(next(it,None) is None and next(kit,None) is None and count==states and kc==keys)

 def population(ps):
  pc=Counter();fc=Counter();rc=Counter()
  for src,p in zip(manifest['conductors'],ps):pc[p]+=1;fc[p]+=src[1];rc[p]+=src[2]
  return pc,fc,rc

 def distribution(ps,stats,floor):
  pc,fc,rc=population(ps);kd,ke=stats[4:]
  return [dict(p=p,conductors=pc[p],phi_total=fc[p],primitive_total=rc[p],kernel_keys=kd[p],kernel_entries=ke[p]) for p in range(floor,109)]

 phase('exact legacy rows and complete cache gate')
 obj=read('major-constants/conductor_local_precision_rows_20261111.json')
 ck(obj['schema']=='conductor-local-precision-rows-1' and obj['inputs']==legacy_sources and obj['contract_sha256']==OLD_HASH)
 ck(obj['fields']==['source_row_id','c','phi','primitive','ordered_axes_n_q','S_mixed','S_old','D_local','p','squared_budget_slack','D_slack','peak_slack'])
 ck(len(obj['rows'])==125400 and not obj['guards_included'] and not obj['prices_included'])
 evidence=[];p_mix=[];seen=set();old_tests=0
 Csmall=(1266*202305920)**2
 for rid,(src,lr) in enumerate(zip(manifest['conductors'],obj['rows'])):
  if rid%1024==0:memory('legacy row loop',False)
  ck(len(src)==7 and len(lr)==12)
  c,phi,primitive,H,J,axes,weights=src
  ck(type(c) is int and c not in seen and 10000<c<=265800 and ((c%2==1 and c<=132900) or c%4==0));seen.add(c)
  ck(1<=len(axes)<=18 and all(len(a)==2 and a[0] in axis and 0<=a[1]<=a[0] and (a[1]==0 or a[0]%a[1]==0) for a in axes))
  ck(prod(n for n,q in axes)==phi and prod(n if q==0 else n-n//q for n,q in axes)==primitive)
  ck(1<=primitive<=phi<=c,'compact row metadata range')
  ck(len(weights)==20 and all(type(w) is int and w>=0 for w in weights))
  Sm=sum(coeff[n][0] for n,q in axes);Ss=sum(coeff[n][2] for n,q in axes);St=sum(coeff[n][4] for n,q in axes)
  Sb=sum(axis[n]['old_C'] for n,q in axes);D=max([1]+[axis[n][key] for n,q in axes for key in ('old_D','new_D')])
  ck(0<=St<=Ss<=Sm<=202305920 and Sb<=424706204 and D<=29961461170177)
  p=lr[8];ck(type(p) is int and 100<=p<=108)
  slack=integer(c*Csmall-(2*phi*Sm)**2*2**(2*(108-p)));old_tests+=1
  expected=[rid,c,phi,primitive,axes,Sm,Sb,D,p,slack,2**p-D,2**p-2*Sb]
  ck(lr==expected and min(expected[9:])>=0)
  if p>100:old_tests+=1;ck(integer(c*Csmall-(2*phi*Sm)**2*2**(2*(109-p)))<0)
  ck(old_tests<=250800)
  evidence.append([Sm,Ss,St,Sb,D]);p_mix.append(p)
 del obj,seen
 mix_masks,kernels,mix_edges=close_masks(p_mix,100);mix_stats=cache_stats(mix_masks,kernels,100)
 ck(mix_stats[:3]==(38147,7606,364355904))
 obj=read('major-constants/conductor_local_precision_caches_20261111.json')
 ck(obj['schema']=='conductor-local-precision-caches-1' and obj['inputs']==legacy_sources)
 ck(not obj['guards_included'] and not obj['prices_included']);match_cache(obj,mix_masks,kernels,38147,7606)
 del obj
 obj=read('major-constants/conductor_local_precision_metadata_20261111.json')
 ck(obj['inputs']==legacy_sources and obj['contract_sha256']==OLD_HASH)
 ck(obj['precision_distribution']==distribution(p_mix,mix_stats,100))
 ck(obj['precision_tests']==sum(p-99 for p in p_mix) and obj['max_tests_per_row']==max(p-99 for p in p_mix))
 for key,value in dict(conductors=125400,full_plan_precision_states=38147,total_output_records=125400+38147+7606,
  baseline_kernel_lengths=6004,baseline_kernel_entries=337702368,local_kernel_keys=7606,local_kernel_entries=364355904,
  extra_kernel_keys=1602,extra_kernel_entries=26653536,scaled_cache_complex_rounds=364355904,exact_real_cache_sums=728711808).items():ck(obj[key]==value,key)
 ck(obj['precision_multiplicity_histogram']=={str(k):v for k,v in sorted(mix_stats[3].items())})
 ck(obj['artifacts']==[artifact('major-constants/conductor_local_precision_rows_20261111.json'),artifact('major-constants/conductor_local_precision_caches_20261111.json')])
 ck(not obj['production_selected'] and not obj['runtime_claim']);del obj

 phase('exact sharp rows and complete cache gate')
 obj=read('integration/sharper_conductor_precision_rows_20261111.json')
 ck(obj['schema']=='sharper-conductor-precision-rows-1' and obj['inputs']==sharp_sources and obj['plan_sha256']==ph and obj['contract_sha256']==OLD_HASH)
 ck(obj['legacy_assignment_sha256']==PINS['major-constants/conductor_local_precision_rows_20261111.json'][1])
 ck(obj['fields']==['source_row_id','c','phi','primitive','S_mix','S_sharp','S_base','D_local_old','p_mix','p_sharp','budget_slack','D_slack','peak_slack','previous_budget_slack_or_null'])
 ck(len(obj['rows'])==125400 and obj['guard_domain_applicable'] and not obj['guard_weights_folded'] and not obj['prices_included'] and not obj['production_selected'])
 p_sharp=[];sharp_tests=0
 for rid,(src,lr,ev,pm) in enumerate(zip(manifest['conductors'],obj['rows'],evidence,p_mix)):
  if rid%1024==0:memory('sharp row loop',False)
  c,phi,primitive=src[:3];Sm,Ss,St,Sb,D=ev;p=lr[9];ck(type(p) is int and 100<=p<=pm)
  slack=integer(c*Csmall-(2*phi*Ss)**2*2**(2*(108-p)));sharp_tests+=1
  previous=None
  if p>100:previous=integer(c*Csmall-(2*phi*Ss)**2*2**(2*(109-p)));sharp_tests+=1;ck(previous<0)
  expected=[rid,c,phi,primitive,Sm,Ss,Sb,D,pm,p,slack,2**p-D,2**p-2*Sb,previous]
  ck(lr==expected and min(expected[10:13])>=0);ck(sharp_tests<=250800);p_sharp.append(p)
 del obj
 sharp_masks,sharp_kernels,sharp_edges=close_masks(p_sharp,100);ck(sharp_kernels==kernels)
 sharp_stats=cache_stats(sharp_masks,kernels,100);ck(sharp_stats[:3]==(37522,7850,369180928))
 def overlaps(left,right,ks):
  # Both masks use the same bit convention when called.
  st=sum((left[n]&right[n]).bit_count() for n in order)
  ke=sum((left[n]&right[n]).bit_count() for n in ks)
  return st,ke
 inter=overlaps(mix_masks,sharp_masks,kernels)
 comparison=dict(state_intersection_with_legacy=inter[0],state_only_sharp=37522-inter[0],state_only_legacy=38147-inter[0],
  kernel_intersection_with_legacy=inter[1],kernel_only_sharp=7850-inter[1],kernel_only_legacy=7606-inter[1])
 obj=read('integration/sharper_conductor_precision_caches_20261111.json')
 ck(obj['schema']=='sharper-conductor-precision-caches-1' and obj['inputs']==sharp_sources)
 ck(obj['sharp_assignment_sha256']==PINS['integration/sharper_conductor_precision_rows_20261111.json'][1])
 ck(obj['legacy_assignment_sha256']==PINS['major-constants/conductor_local_precision_rows_20261111.json'][1])
 match_cache(obj,sharp_masks,kernels,37522,7850)
 for key,value in comparison.items():ck(obj[key]==value)
 del obj
 obj=read('integration/sharper_conductor_precision_metadata_20261111.json')
 ck(obj['inputs']==sharp_sources and obj['plan_sha256']==ph and obj['contract_sha256']==OLD_HASH and obj['legacy_match'])
 ck(obj['precision_distribution']==distribution(p_sharp,sharp_stats,100))
 transition=Counter(zip(p_mix,p_sharp));drop=Counter(a-b for a,b in zip(p_mix,p_sharp))
 ck(obj['transition_rows']==[[a,b,v] for (a,b),v in sorted(transition.items())] and obj['bit_drop_distribution']=={str(k):v for k,v in sorted(drop.items())})
 ck(obj['legacy_selector_tests']==old_tests and obj['sharp_selector_tests']==sum(p-99 for p in p_sharp))
 for key,value in dict(conductors=125400,full_coefficient_nodes=37117,axis_records=13943,changed_conductors=125400-drop[0],
  sharp_full_plan_precision_states=37522,sharp_kernel_keys=7850,sharp_kernel_entries=369180928,scaled_cache_complex_rounds=369180928,
  exact_real_cache_sums=738361856,output_records=37117+125400+37522+7850,**comparison).items():ck(obj[key]==value,key)
 ck(obj['artifacts']==[artifact('integration/sharper_conductor_precision_rows_20261111.json'),artifact('integration/sharper_conductor_precision_nodes_20261111.json'),artifact('integration/sharper_conductor_precision_caches_20261111.json')])
 ck(not obj['guard_weights_folded'] and not obj['prices_included'] and not obj['production_selected']);del obj
 guard=read('integration/short_window_guard_ledger_20261111.json')
 ck([s['extra_nodes'] for s in guard['scenarios']]==[0,167,320,640])
 ck(all(Fraction(s['max_guard_height'])<7000 for s in guard['scenarios']))
 ck(max(Fraction(s['max_guard_height']) for s in guard['scenarios'])==Fraction(26525,4));del guard
 ck(READ_BYTES==75419343 and READ_PATHS==set(PINS))
 ck(old_tests+sharp_tests<=501600)

 phase('combined selector after both exact predecessor gates')
 Q=2**52;Cg=4196258524692480
 ck(Cg==1266*202305920*16384 and 202305920<2**28 and Q*8828<2*16384*(Q-1))
 ck(2**80>max(29961461170177,849412408))
 rows=[];ps=[];tests=0;max_tests=0
 for rid,(src,ev,pm,pq) in enumerate(zip(manifest['conductors'],evidence,p_mix,p_sharp)):
  if rid%1024==0:memory('combined selector loop',False)
  c,phi,primitive=src[:3];Sm,Ss,St,Sb,D=ev;rhs=integer(c*((Q-1)*Cg)**2)
  previous=None;chosen=None;count=0
  for p in range(80,109):
   count+=1;tests+=1;ck(count<=29 and tests<=3636600)
   rho=int(p<100);num=integer(phi*((Q-1)*rho+Q*St*8828))
   slack=integer(rhs-num*num*2**(2*(108-p)));ds=integer(2**p-D);peak=integer(2**p-2*Sb)
   if min(slack,ds,peak)>=0:chosen=[p,rho,slack,ds,peak,previous];break
   previous=slack
  ck(chosen is not None)
  p=chosen[0];ck(p<=pq<=pm and (chosen[-1] is None if p==80 else chosen[-1]<0))
  # Slacks are checked above and deterministically reconstructed by the reviewer.
  # They are omitted only from the serialized schema2 row, never from acceptance.
  rows.append([rid,c,phi,primitive,Sm,Ss,St,Sb,D,pm,pq,p,chosen[1]]);ps.append(p);max_tests=max(max_tests,count)
 ck(len(rows)==125400 and len(rows[0])==13)
 masks,kernel_lengths,new_edges=close_masks(ps,80);ck(kernel_lengths==kernels)
 stats=cache_stats(masks,kernels,80);ck(stats[0]<=1076393 and stats[1]<=174116)
 ck(stats[2]<=29*337702368)
 for n in order:integer(masks[n]);ck(masks[n]<2**29)
 # Compact masks are retained; no expanded node/precision table is constructed.
 comparisons={}
 for label,oldmask,oldstats in [('mixed',mix_masks,mix_stats),('sharp',sharp_masks,sharp_stats)]:
  si=sum(((oldmask[n]<<20)&masks[n]).bit_count() for n in order)
  ki=sum(((oldmask[n]<<20)&masks[n]).bit_count() for n in kernels)
  comparisons[label]=dict(node_projection_intersection=si,node_only_combined=stats[0]-si,node_only_old=oldstats[0]-si,
   kernel_projection_intersection=ki,kernel_only_combined=stats[1]-ki,kernel_only_old=oldstats[1]-ki)

 phase('new representation contracts and bounded serialization')
 input_contract=dict(id='assembled-grid100-single-regrid-p80-v1',p_domain=[80,108],
  original='Exact grid100 sum of admitted full P20 polynomial and separately certified actual grid100 raw head; |sum|<8826.',
  below100='d=100-p; each signed coordinate n+2^(d-1)=Qout*2^d+t with 0<=t<2^d; nearest ties toward positive infinity.',
  at100='Identical coordinate integer; zero error.',above100='Exact coordinate left shift p-100; zero error.',
  complex_radius='rho_p*2^-p, rho_p=1 below100 and zero otherwise; transported once by exact character operator.',
  magnitudes={'V_error':8828,'V_width':16384},
  source_radii='Retain alpha<2^-82, head<=2^-63, pre-existing assembly<=2^-63; no second regrid charge.',
  domain='|t|<=7000 and actual admitted guard samples; c<=265800; saved large primitive nonprincipal family.',
  identity='Conductor, exact height, unit order, original source/head/assembly objects, destination p, tie rule, witnesses, radius, proof contract and lifetime.',
  lifetime='One checked conversion per actual assembled input and distinct sample; no sharing across different values or free rebuild.')
 kernel_contract=dict(OLD_CONTRACT)
 kernel_contract.update(id='local-u-rounded-normalized-blue-p80-v1',p_domain=[80,108],
  coordinate_grid='2^-p; kernel object independent of input producer; assembled inputs use the separately bound regrid contract.')
 # Common-p producer comparison is exact on all mathematical enclosure fields.
 projection_fields=[k for k in OLD_CONTRACT if k not in ('id','p_domain','coordinate_grid')]
 old_projection={k:OLD_CONTRACT[k] for k in projection_fields}
 ck({k:kernel_contract[k] for k in projection_fields}==old_projection)
 input_hash=sha(canon(input_contract));kernel_hash=sha(canon(kernel_contract))
 common=dict(inputs=sources,support=SUPPORT,writer_sha256=sha(Path(__file__).read_bytes()),plan_sha256=ph,input_contract_sha256=input_hash,kernel_contract_sha256=kernel_hash,
  assignment_only=True,guard_domain_applicable=True,guard_weights_folded=False,prices_included=False,values_generated=False,production_selected=False)
 row_obj=dict(schema='combined-conductor-precision-rows-2',**common,
  fields=['source_row_id','c','phi','primitive','S_mix','S_sharp','S_tight','S_base','D_local_old','p_mix','p_sharp','p_comb','rho'],
  rows=rows,axes_and_weights='Referenced by exact source_row_id and pinned manifest; multiplicity checked, weights never folded.')
 ck(all(len(r)==len(row_obj['fields']) for r in rows),'row schema arity')
 row_wrapper=dict(row_obj);row_wrapper['rows']=[]
 ck(len(json.dumps(row_wrapper,separators=(',',':')).encode())+1<=MIB,'row metadata wrapper cap')
 del row_wrapper
 ck(99*125400+MIB<32*MIB,'static compact-row cap')
 node_obj=dict(schema='combined-full-plan-coefficients-masks-1',**common,
  fields=['n','C_mix','D_mix','C_sharp','D_sharp','C_tight','D_tight','combined_mask'],
  mask_semantics='Bit p-80 for p80..108; zero mask permitted; children from pinned full plan.',
  rows=[[n,*coeff[n],masks[n]] for n in order])
 cache_obj=dict(schema='combined-conductor-precision-kernel-masks-1',**common,
  input_contract=input_contract,kernel_contract=kernel_contract,legacy_contract_sha256=OLD_HASH,
  kernel_projection_fields=projection_fields,kernel_projection_sha256=sha(canon(old_projection)),
  fields=['n','P','combined_mask'],rows=[[n,1<<(2*n-2).bit_length(),masks[n]] for n in kernels],
  projected_alternative_comparisons=comparisons,
  sharing='Projected keys concern identical kernel producer fields at common p>=100 plus plan/phase/lifetime identity; no whole-input identity or shared-high/cross-run credit.')
 ck(len(rows)+len(node_obj['rows'])+len(cache_obj['rows'])==168521)
 raw_outputs=[];arts=[]
 for (name,cap),obj in zip(NAMES[:3],[row_obj,node_obj,cache_obj]):
  memory('before serialize '+name)
  if name==NAMES[2][0]:obj['node_output_sha256']=arts[1]['sha256'];obj['row_output_sha256']=arts[0]['sha256']
  raw=(json.dumps(obj,separators=(',',':'))+'\n').encode()
  ck(len(raw)<=cap*MIB,dict(error='encoded artifact cap',artifact=name,encoded_bytes=len(raw),limit_bytes=cap*MIB))
  memory('after serialize '+name)
  raw_outputs.append((name,raw));arts.append(dict(path=name,bytes=len(raw),sha256=sha(raw)))
 pc,fc,rc=population(ps)
 transitions={label:[[a,b,v] for (a,b),v in sorted(Counter(zip(old,ps)).items())] for label,old in [('mixed',p_mix),('sharp',p_sharp)]}
 drops={label:dict(sorted(Counter(a-b for a,b in zip(old,ps)).items())) for label,old in [('mixed',p_mix),('sharp',p_sharp)]}
 # Count substantive table rows plus all finite summary row collections, not nested scalars.
 record_count=168521+29+sum(len(v) for v in transitions.values())+sum(len(v) for v in drops.values())+len(MEMORY)+100
 ck(record_count<=200000)
 summary=dict(schema='combined-conductor-precision-summary-1',**common,
  scope='Assignment and full-plan precision/cache membership only. No runtime/guard weights, prices, numerical values or proof output.',
  input_bytes_read=READ_BYTES,legacy_all_rows_slacks_and_keys_matched=True,sharp_all_rows_slacks_and_keys_matched=True,
  checks_before_final_serialization=CHECKS,legacy_selector_tests=old_tests,sharp_selector_tests=sharp_tests,
  combined_selector_tests=tests,max_combined_tests_per_row=max_tests,
  full_nodes=37117,axis_records=13943,conductors=125400,precision_distribution=distribution(ps,stats,80),
  transitions=transitions,bit_drop_distributions=drops,
  changed_vs_mixed=sum(a!=b for a,b in zip(p_mix,ps)),changed_vs_sharp=sum(a!=b for a,b in zip(p_sharp,ps)),
  node_precision_memberships=stats[0],kernel_precision_memberships=stats[1],kernel_entries=stats[2],
  kernel_precision_multiplicity_histogram=dict(sorted(stats[3].items())),
  scaled_cache_complex_rounds=stats[2],exact_real_cache_sums=2*stats[2],
  projected_alternative_comparisons=comparisons,mask_propagation_edges=dict(mixed=mix_edges,sharp=sharp_edges,combined=new_edges),
  regrid_population_only=dict(conductors=sum(pc[p] for p in range(80,100)),phi_sum=sum(fc[p] for p in range(80,100)),
   warning='Unweighted population only. Actual sample-union conversion occurrences are NOT computed.'),
  artifacts=arts,substantive_records=168521,conservative_record_count=record_count,
  memory_observations=MEMORY,private_memory_policy='Observed checkpoints <=1GiB; no hard or absolute parser peak guarantee.',
  limits=dict(input_bytes=96*MIB,per_input_bytes=32*MIB,output_bytes=48*MIB,records=200000,node_memberships=1076393,
   kernel_memberships=174116,selector_tests=3636600,metadata_integer_bits=1024),
  independent_reconstruction_pending=True)
 memory('before summary serialize')
 raw=(json.dumps(summary,separators=(',',':'))+'\n').encode()
 ck(len(raw)<=MIB,dict(error='encoded artifact cap',artifact=NAMES[3][0],encoded_bytes=len(raw),limit_bytes=MIB))
 raw_outputs.append((NAMES[3][0],raw))
 # Leave two MiB within total cap for this writer, frozen preflight and eventual author note.
 ck(sum(len(r) for n,r in raw_outputs)+2*MIB<=48*MIB)
 ck(Path(__file__).stat().st_size+(HERE/'COMBINED_CONDUCTOR_PRECISION_ASSIGNMENT_PREFLIGHT_2026-11-11.md').stat().st_size<MIB)
 for name,raw in raw_outputs:ck(not (HERE/name).exists(),'publication path exists')
 memory('before exclusive publication')
 for name,raw in raw_outputs:
  with (HERE/name).open('xb') as f:
   # Opening creates the file. Report it even if write or close subsequently fails.
   WRITTEN.append(name)
   f.write(raw)
 print(json.dumps(dict(status='PASS_SAVED_ASSIGNMENT_ONLY',checks=CHECKS,tests=tests,
  distribution=summary['precision_distribution'],states=stats[0],kernels=stats[1],entries=stats[2],
  changed_vs_sharp=summary['changed_vs_sharp'],artifacts=arts+[dict(path=NAMES[3][0],bytes=len(raw_outputs[-1][1]),sha256=sha(raw_outputs[-1][1]))]),indent=2))

if __name__=='__main__':
 try:
  main()
 except BaseException as exc:
  print(json.dumps(dict(status='FAIL_STOP',phase=PHASE,error=repr(exc),checks=CHECKS,partial_artifacts=WRITTEN)),flush=True)
  raise
