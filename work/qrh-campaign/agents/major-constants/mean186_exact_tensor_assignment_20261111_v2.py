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
CURRENT_ARTIFACT = None
CURRENT_CAP = None
CURRENT_ENCODED_BYTES = None
CURRENT_SERIALIZATION_STAGE = None
CURRENT_STAGE_CAP = None
PINS = {
 'integration/transform_structural_manifest_20261111.json': (25110201,'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'),
 'zero-sum/mixed_radix_precision_metadata_20261111.json': (1911933,'8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E'),
 'major-constants/combined_conductor_precision_rows_20261111.json': (9568390,'2B9C245DCA582C93BFFCB022CEE858D09B07637D1D1D1F37D5C1FE5BDF94DBCB'),
 'major-constants/combined_conductor_precision_nodes_20261111.json': (2672728,'D3F0280F22D0D79EA8B99B46FF679F4BBFE2DED0C64B809C0322B75D3EC975C9'),
 'major-constants/combined_conductor_precision_caches_20261111.json': (137719,'6D992A88D3018394731B62387053C9E2A8C03EAFD95BDA750FC9E72FDDC54778'),
 'major-constants/combined_conductor_precision_summary_20261111.json': (13957,'493FAB7C41A216839CDA318DE0A80BB55C3CE9E5D4D6B8F4E47B44930A06C95B'),
 'integration/short_window_guard_ledger_20261111.json': (41665,'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4'),
}
SUPPORT = {
 'major-constants/MEAN186_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'D804D1A6CEBBDB812A35132CC05A79B9FA8A6B3D510CCF49A9ACCFCC588F1A64',
 'zero-sum/REVIEW_MEAN186_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'4BCA651C7D6914243BF3F8D6BA21172B0C0E7FA8C5C750D7FB25F703A9DAAD25',
 'major-constants/EM692_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'01BC1696B7AF781D5638968A18E551014658B86986823B2C65F7AAE15433292A',
 'zero-sum/REVIEW_EM692_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'C5B6F6AF34AC536624DF5B1FAF0AE32FC22CEB670F248F007ACAE7D2AF9F09C2',
 'independent-feasibility/MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md':'4A7EB4A925A84F70F882A2AC4A1D44B5EB6132B5C6066C12FB4DC4159EF1CDED',
 'integration/REVIEW_MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md':'A4B204E9EADBB29F51BA56CCC2FBCD417E1AF90254605E9877524970DC2C5021',
 'audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md':'03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904',
 'prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md':'1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328',
 'independent-feasibility/FULL_P20_GRID60_MAGNITUDE_SCOPE_COMPANION_2026-11-11.md':'FE52146FBF51009631A9E232492A141053B9936AA90EB1B4017FE7A8D0021A5E',
 'major-constants/REVIEW_FULL_P20_GRID60_MAGNITUDE_SCOPE_2026-11-11.md':'5140949742F0BF54941815DCFC8C34DEB96133A89517FE7EBC874380A03B2EBE',
 'zero-sum/FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md':'F0B7399E638A7EBD43FE37F9EAAD8DCFB0583FEA785F7425D9DAFF096D464DE6',
 'integration/REVIEW_FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md':'372F685F72449A11C970ADD855EB5CB64D52E4512B669DB1AD2FC6102FB6DD37',
 'prime-estimates/TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md':'5E3B9FCDC374998149ABBF3262BF925E0D02C6BFBF399462D1C34ABB68218F6F',
 'major-constants/REVIEW_TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md':'E7482930B1A6B57FD6C186AD4612E655379D0978DD6C5EDA9C4D4D6D247920F5',
 'major-constants/COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'EBA33B23C531312243495B9B0321597FC26D8AEBA8E1CF24626457474EA3A997',
 'integration/REVIEW_COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'8745235D810A1F06E8661961A05EF93C8DB24574121700DF6D924AE6EC2615C4',
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
 READ_BYTES+=size;ck(READ_BYTES<=64*MIB, 'aggregate input size')
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
NAMES=[('mean186_exact_tensor_rows_20261111.json',3),
 ('mean186_exact_tensor_node_masks_20261111.json',3),
 ('mean186_exact_tensor_kernel_masks_20261111.json',2),
 ('mean186_exact_tensor_summary_20261111.json',1)]
INPUT_OLD_HASH='376BBDC2EAC98F5AC3C28AEBFD5D6FAA80DD9989B081E4DA8A8AC79B3F270F91'
KERNEL_OLD_HASH='F40998CB9F4C41271BDD69EAB97FEF5B89D3B3800A72C9525AC4EA393B3628C6'
CG=4196258524692480

def main():
 global CURRENT_ARTIFACT, CURRENT_CAP, CURRENT_ENCODED_BYTES, CURRENT_SERIALIZATION_STAGE, CURRENT_STAGE_CAP
 phase('support and exclusive destination gate')
 ck(any('REVIEW_MEAN186' in r for r in SUPPORT),'final preflight review not bound')
 for rel,pin in SUPPORT.items():
  p=AG/rel;ck(p.stat().st_size<MIB);ck(sha(p.read_bytes())==pin,'support hash')
 for name,cap in NAMES:ck(not (HERE/name).exists(),'preexisting output')
 ck(sum(s for s,h in PINS.values())==39456593)
 ck(sha(canon(OLD_CONTRACT))==OLD_HASH)
 ck(Fraction(32*186*64,8828*63)<Fraction(3,4) and 4*633*2**33<CG)
 ck(Fraction(202305920,2**75)<Fraction(1,64))
 ck(2**50>max(29961461170177,849412408,202305920))
 sources={r:{'bytes':s,'sha256':h} for r,(s,h) in PINS.items()}
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
 phase('predecessor node identity')
 node_old=read(list(PINS)[3]);rows_old=read(list(PINS)[2])
 for obj in (node_old,rows_old):
  ck(obj['plan_sha256']==ph and obj['input_contract_sha256']==INPUT_OLD_HASH and obj['kernel_contract_sha256']==KERNEL_OLD_HASH)
  ck(obj['assignment_only'] and obj['guard_domain_applicable'] and not obj['guard_weights_folded'] and not obj['prices_included'] and not obj['values_generated'] and not obj['production_selected'])
 ck(node_old['schema']=='combined-full-plan-coefficients-masks-1')
 ck(node_old['fields']==['n','C_mix','D_mix','C_sharp','D_sharp','C_tight','D_tight','combined_mask'])
 ck(len(node_old['rows'])==37117)
 for n,row in zip(order,node_old['rows']):ck(row[:7]==[n,*coeff[n]] and len(row)==8)
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

 def population(ps):
  pc=Counter();fc=Counter();rc=Counter()
  for src,p in zip(manifest['conductors'],ps):pc[p]+=1;fc[p]+=src[1];rc[p]+=src[2]
  return pc,fc,rc

 def distribution(ps,stats,floor):
  pc,fc,rc=population(ps);kd,ke=stats[4:]
  return [dict(p=p,conductors=pc[p],phi_total=fc[p],primitive_total=rc[p],kernel_keys=kd[p],kernel_entries=ke[p]) for p in range(floor,109)]

 phase('all predecessor row identities and reconstructed slacks')
 ck(rows_old['schema']=='combined-conductor-precision-rows-2')
 ck(rows_old['fields']==['source_row_id','c','phi','primitive','S_mix','S_sharp','S_tight','S_base','D_local_old','p_mix','p_sharp','p_comb','rho'])
 ck(len(rows_old['rows'])==125400)
 evidence=[];pmix=[];psharp=[];pold=[];seen=set();legacy_tests=0
 Csmall=(1266*202305920)**2;Q=2**52
 for rid,(src,lr) in enumerate(zip(manifest['conductors'],rows_old['rows'])):
  if rid%1024==0:memory('predecessor row loop',False)
  ck(len(src)==7 and len(lr)==13)
  c,phi,primitive,H,J,axes,weights=src
  ck(c not in seen and 10000<c<=265800 and ((c%2==1 and c<=132900) or c%4==0));seen.add(c)
  ck(1<=len(axes)<=18 and all(len(a)==2 and a[0] in axis and 0<=a[1]<=a[0] and (a[1]==0 or a[0]%a[1]==0) for a in axes))
  ck(prod(n for n,q in axes)==phi and prod(n if q==0 else n-n//q for n,q in axes)==primitive)
  ck(1<=primitive<=phi<=c and len(weights)==20 and all(type(w) is int and w>=0 for w in weights))
  Sm=sum(coeff[n][0] for n,q in axes);Ss=sum(coeff[n][2] for n,q in axes);St=sum(coeff[n][4] for n,q in axes)
  Sb=sum(axis[n]['old_C'] for n,q in axes);D=max([1]+[axis[n][key] for n,q in axes for key in ('old_D','new_D')])
  ck(0<=St<=Ss<=Sm<=202305920 and Sb<=424706204 and D<=29961461170177)
  pm,pq,pc=lr[9:12];ck(100<=pq<=pm<=108 and 80<=pc<=105 and pc<=pq)
  ck(lr==[rid,c,phi,primitive,Sm,Ss,St,Sb,D,pm,pq,pc,int(pc<100)])
  for S,p in ((Sm,pm),(Ss,pq)):
   rhs=integer(c*Csmall);lhs=integer((2*phi*S)**2*2**(2*(108-p)))
   ck(integer(rhs-lhs)>=0 and integer(2**p-D)>=0 and integer(2**p-2*Sb)>=0);legacy_tests+=1
   if p>100:ck(integer(rhs-4*lhs)<0);legacy_tests+=1
  rhs=integer(c*((Q-1)*CG)**2)
  def old_slack(p):
   num=integer(phi*((Q-1)*int(p<100)+Q*St*8828))
   return integer(rhs-num*num*2**(2*(108-p)))
  ck(old_slack(pc)>=0 and integer(2**pc-D)>=0 and integer(2**pc-2*Sb)>=0);legacy_tests+=1
  if pc>80:ck(old_slack(pc-1)<0);legacy_tests+=1
  ck(legacy_tests<=752400)
  evidence.append([Sm,Ss,St,Sb,D]);pmix.append(pm);psharp.append(pq);pold.append(pc)
 del seen,rows_old
 phase('all predecessor masks keys contracts and summary')
 mix_masks,kernels,mix_edges=close_masks(pmix,100);mix_stats=cache_stats(mix_masks,kernels,100)
 sharp_masks,ks,sharp_edges=close_masks(psharp,100);ck(ks==kernels);sharp_stats=cache_stats(sharp_masks,kernels,100)
 old_masks,ks,old_edges=close_masks(pold,80);ck(ks==kernels);old_stats=cache_stats(old_masks,kernels,80)
 ck(mix_stats[:3]==(38147,7606,364355904) and sharp_stats[:3]==(37522,7850,369180928))
 ck(old_stats[:3]==(49899,8467,363202368))
 for n,row in zip(order,node_old['rows']):ck(row==[n,*coeff[n],old_masks[n]])
 del node_old
 cache_old=read(list(PINS)[4]);summary_old=read(list(PINS)[5])
 for obj in (cache_old,summary_old):
  ck(obj['plan_sha256']==ph and obj['input_contract_sha256']==INPUT_OLD_HASH and obj['kernel_contract_sha256']==KERNEL_OLD_HASH)
  ck(obj['assignment_only'] and obj['guard_domain_applicable'] and not obj['guard_weights_folded'] and not obj['prices_included'] and not obj['values_generated'] and not obj['production_selected'])
 ck(cache_old['schema']=='combined-conductor-precision-kernel-masks-1' and cache_old['fields']==['n','P','combined_mask'])
 ck(cache_old['row_output_sha256']==PINS[list(PINS)[2]][1] and cache_old['node_output_sha256']==PINS[list(PINS)[3]][1])
 ck(cache_old['legacy_contract_sha256']==OLD_HASH and len(cache_old['rows'])==6004)
 for n,row in zip(kernels,cache_old['rows']):ck(row==[n,1<<(2*n-2).bit_length(),old_masks[n]])
 projection_fields=[k for k in OLD_CONTRACT if k not in ('id','p_domain','coordinate_grid')]
 old_projection={k:OLD_CONTRACT[k] for k in projection_fields}
 ck(cache_old['kernel_projection_fields']==projection_fields and cache_old['kernel_projection_sha256']==sha(canon(old_projection)))
 ck(sha(canon(cache_old['input_contract']))==INPUT_OLD_HASH and sha(canon(cache_old['kernel_contract']))==KERNEL_OLD_HASH)
 ck({k:cache_old['kernel_contract'][k] for k in projection_fields}==old_projection)
 predecessor_input_contract=cache_old['input_contract'];predecessor_kernel_contract=cache_old['kernel_contract']
 def comparisons_to(masks,stats,floor,alternatives):
  result={}
  for label,om,ost,ofloor in alternatives:
   ck(ofloor>=floor)
   si=sum(((om[n]<<(ofloor-floor))&masks[n]).bit_count() for n in order)
   ki=sum(((om[n]<<(ofloor-floor))&masks[n]).bit_count() for n in kernels)
   result[label]=dict(node_projection_intersection=si,node_only_combined=stats[0]-si,node_only_old=ost[0]-si,
    kernel_projection_intersection=ki,kernel_only_combined=stats[1]-ki,kernel_only_old=ost[1]-ki)
  return result
 old_comparisons=comparisons_to(old_masks,old_stats,80,[('mixed',mix_masks,mix_stats,100),('sharp',sharp_masks,sharp_stats,100)])
 ck(cache_old['projected_alternative_comparisons']==old_comparisons)
 ck(summary_old['schema']=='combined-conductor-precision-summary-1')
 ck(summary_old['precision_distribution']==distribution(pold,old_stats,80))
 expected_transitions={label:[[a,b,v] for (a,b),v in sorted(Counter(zip(ps,pold)).items())] for label,ps in [('mixed',pmix),('sharp',psharp)]}
 expected_drops={label:{str(k):v for k,v in sorted(Counter(a-b for a,b in zip(ps,pold)).items())} for label,ps in [('mixed',pmix),('sharp',psharp)]}
 ck(summary_old['transitions']==expected_transitions and summary_old['bit_drop_distributions']==expected_drops)
 ck(summary_old['projected_alternative_comparisons']==old_comparisons)
 ck(summary_old['kernel_precision_multiplicity_histogram']=={str(k):v for k,v in sorted(old_stats[3].items())})
 ck(summary_old['mask_propagation_edges']==dict(mixed=mix_edges,sharp=sharp_edges,combined=old_edges))
 for key,value in dict(full_nodes=37117,axis_records=13943,conductors=125400,node_precision_memberships=49899,
  kernel_precision_memberships=8467,kernel_entries=363202368,scaled_cache_complex_rounds=363202368,
  exact_real_cache_sums=726404736,combined_selector_tests=sum(p-79 for p in pold),max_combined_tests_per_row=max(p-79 for p in pold),
  legacy_selector_tests=125400+sum(p>100 for p in pmix),sharp_selector_tests=125400+sum(p>100 for p in psharp),
  changed_vs_mixed=sum(a!=b for a,b in zip(pmix,pold)),changed_vs_sharp=sum(a!=b for a,b in zip(psharp,pold)),
  substantive_records=168521).items():ck(summary_old[key]==value,key)
 ck(summary_old['legacy_all_rows_slacks_and_keys_matched'] and summary_old['sharp_all_rows_slacks_and_keys_matched'])
 pc,fc,rc=population(pold)
 ck(summary_old['regrid_population_only']['conductors']==sum(pc[p] for p in range(80,100)))
 ck(summary_old['regrid_population_only']['phi_sum']==sum(fc[p] for p in range(80,100)))
 ck(summary_old['artifacts']==[artifact(list(PINS)[i]) for i in (2,3,4)])
 del cache_old,summary_old
 guard=read(list(PINS)[6])
 ck([s['extra_nodes'] for s in guard['scenarios']]==[0,167,320,640])
 ck(all(Fraction(s['max_guard_height'])<7000 for s in guard['scenarios']))
 ck(max(Fraction(s['max_guard_height']) for s in guard['scenarios'])==Fraction(26525,4));del guard
 ck(READ_BYTES==39456593 and READ_PATHS==set(PINS))

 phase('mean186 exact tensor selector after all predecessor gates')
 rows=[];ps=[];tests=0;max_tests=0
 for rid,(src,ev,po) in enumerate(zip(manifest['conductors'],evidence,pold)):
  if rid%1024==0:memory('new selector loop',False)
  c,phi=src[:2];Sm,Ss,St,Sb,D=ev;previous=None;chosen=None;count=0
  for p in range(50,po-4):
   count+=1;tests+=1;ck(count<=51 and tests<=6395400)
   T=2**p;gap=integer(T-St);ck(gap>0);rho=int(p<100)
   W=integer(rho*gap+186*St*T)
   slack=integer(c*CG**2*gap**2-phi**2*W**2*2**(2*(108-p)))
   ds=integer(T-D);peak=integer(T-2*Sb)
   if min(slack,ds,peak)>=0:chosen=p;break
   previous=slack
  ck(chosen is not None and chosen<=po-5<=100)
  ck(previous is None if chosen==50 else previous<0)
  rows.append([rid,chosen]);ps.append(chosen);max_tests=max(max_tests,count)
 masks,ks,new_edges=close_masks(ps,50);ck(ks==kernels)
 stats=cache_stats(masks,kernels,50)
 ck(stats[0]<=2189903 and stats[1]<=354236 and stats[2]<=59*337702368)
 ck(sum(x[0] for x in (mix_stats,sharp_stats,old_stats,stats))<=3934402)
 ck(sum(x[1] for x in (mix_stats,sharp_stats,old_stats,stats))<=636424)
 for n in order:integer(masks[n]);ck(masks[n]<2**59 and masks[n]>>51==0)
 comparisons=comparisons_to(masks,stats,50,[('mixed',mix_masks,mix_stats,100),('sharp',sharp_masks,sharp_stats,100),('combined8828',old_masks,old_stats,80)])

 phase('producer contracts and bounded output assembly')
 input_contract=dict(id='mean186-full-P20-grid94-assembled-grid100-single-regrid-p50-v1',p_domain=[50,108],
  original='Exact grid100 sum of admitted full K20 fixed-shape b94/min65 polynomial and separately certified actual grid100 raw head; pointwise |sum|<690.',
  below100='d=100-p; each signed coordinate n+2^(d-1)=Qout*2^d+t with 0<=t<2^d; nearest ties toward positive infinity.',
  at100='Identical coordinate integer; zero error.',above100='Exact coordinate left shift p-100; zero error.',
  complex_radius='rho_p*2^-p, rho_p=1 below100 and zero otherwise; transported once by exact character operator.',
  magnitudes={'V_error_mean':186,'V_width_pointwise':692},
  source_radii='Retain complete alpha<2^-82. Actual nonnegative conductor-scaled sums H and J0 each <=2^-63; J0 excludes this new regrid. No cancellation-based substitute.',
  mean_contract='Actual full input mean+1<175+2c/phi(c)<186, using exact head sum<2c and c/phi<=1001/192. Mean/tight ordered CT and original-fiber exact tensor proof required.',
  source_proof_pins={k:v for k,v in SUPPORT.items() if any(t in k for t in ('MEAN_INPUT_TIGHT','FINITE_EM','FULL_P20','FUTURE_P50'))},
  converter_capacities='Conservative signed source115/destination(p+15)/raw116; d<=50, longer remainder/range proof paid. No narrower converter adopted.',
  domain='|t|<=7000 and actual admitted guard samples; c<=265800; saved large primitive nonprincipal family.',
  identity='Conductor, exact height, unit order, original source/head/assembly objects, destination p, tie rule, witnesses, radius, proof contract and lifetime.',
  lifetime='One checked conversion per actual assembled input and distinct sample; no sharing across different values or free rebuild.')
 kernel_contract=dict(OLD_CONTRACT)
 kernel_contract.update(id='local-u-rounded-normalized-blue-p50-mean186-v1',p_domain=[50,108],
  coordinate_grid='2^-p; kernel object independent of input producer; assembled inputs use the separately bound regrid contract.')
 # Common-p producer comparison is exact on all mathematical enclosure fields.
 projection_fields=[k for k in OLD_CONTRACT if k not in ('id','p_domain','coordinate_grid')]
 old_projection={k:OLD_CONTRACT[k] for k in projection_fields}
 ck({k:kernel_contract[k] for k in projection_fields}==old_projection)
 input_hash=sha(canon(input_contract));kernel_hash=sha(canon(kernel_contract))
 ck(input_hash!=INPUT_OLD_HASH and kernel_hash!=KERNEL_OLD_HASH)
 common=dict(inputs=sources,support=SUPPORT,writer_sha256=sha(Path(__file__).read_bytes()),plan_sha256=ph,
  predecessor_rows_sha256=PINS[list(PINS)[2]][1],predecessor_nodes_sha256=PINS[list(PINS)[3]][1],predecessor_cache_sha256=PINS[list(PINS)[4]][1],
  input_contract_sha256=input_hash,kernel_contract_sha256=kernel_hash,
  assignment_only=True,guard_domain_applicable=True,guard_weights_folded=False,prices_included=False,
  values_generated=False,production_selected=False,intermediate692_assignment=False,shared_high_adapter=False,
  narrower_input_converter=False,full_P20_retained=True)
 row_obj=dict(schema='mean186-exact-tensor-rows-1',**common,fields=['source_row_id','p_new'],rows=rows,
  inherited_fields='All thirteen fields, axes and multiplicities from the checked pinned predecessor/source row ID; omitted slacks checked and reconstructible.')
 node_obj=dict(schema='mean186-exact-tensor-node-masks-1',**common,
  fields=['predecessor_node_row_id','mask'],rows=[[i,masks[n]] for i,n in enumerate(order)],
  mask_semantics='Bit p-50 in declared50..108; actual bits51..58 zero; all full-plan nodes retained including zero masks.')
 cache_obj=dict(schema='mean186-exact-tensor-kernel-masks-1',**common,
  fields=['predecessor_kernel_row_id','mask'],rows=[[i,masks[n]] for i,n in enumerate(kernels)],
  input_contract=input_contract,kernel_contract=kernel_contract,
  predecessor_input_contract_sha256=INPUT_OLD_HASH,predecessor_kernel_contract_sha256=KERNEL_OLD_HASH,
  kernel_projection_fields=projection_fields,kernel_projection_sha256=sha(canon(old_projection)),
  projected_alternative_comparisons=comparisons,
  sharing='Only projected membership comparisons. DIRECT separate-per-p producers; exact coefficient/enclosure/sum/phase/plan/lifetime bindings required; no free cross-run or shared-high reuse.')
 ck(sum(len(o['rows']) for o in (row_obj,node_obj,cache_obj))==168521)
 raw_outputs=[];arts=[]
 for (name,cap),obj,width,nrecords in zip(NAMES[:3],(row_obj,node_obj,cache_obj),(13,27,26),(125400,37117,6004)):
  CURRENT_ARTIFACT=name;CURRENT_CAP=cap*MIB;CURRENT_ENCODED_BYTES=None;CURRENT_SERIALIZATION_STAGE='wrapper'
  CURRENT_STAGE_CAP=MIB
  ck(len(obj['rows'])==nrecords)
  if name==NAMES[2][0]:obj.update(row_output_sha256=arts[0]['sha256'],node_output_sha256=arts[1]['sha256'])
  wrapper=dict(obj);wrapper['rows']=[]
  CURRENT_ENCODED_BYTES=len(json.dumps(wrapper,separators=(',',':')).encode())+1
  ck(CURRENT_ENCODED_BYTES<=MIB,'metadata wrapper cap');del wrapper
  ck(nrecords*width+MIB<cap*MIB,'static encoded table cap')
  # Check the actual primitive records before serializing the enclosing object.
  for rr in obj['rows']:
   CURRENT_ENCODED_BYTES=None;CURRENT_SERIALIZATION_STAGE='record with separator'
   CURRENT_STAGE_CAP=width
   ck(len(rr)==2 and all(type(v) is int and v>=0 for v in rr))
   CURRENT_ENCODED_BYTES=len(json.dumps(rr,separators=(',',':')).encode())+1
   ck(CURRENT_ENCODED_BYTES<=width,'per-record encoded cap')
  CURRENT_ENCODED_BYTES=None;CURRENT_SERIALIZATION_STAGE='complete artifact'
  CURRENT_STAGE_CAP=CURRENT_CAP
  memory('before serialize '+name)
  raw=(json.dumps(obj,separators=(',',':'))+'\n').encode()
  CURRENT_ENCODED_BYTES=len(raw)
  ck(len(raw)<=cap*MIB,dict(error='encoded artifact cap',artifact=name,encoded_bytes=len(raw),limit_bytes=cap*MIB))
  memory('after serialize '+name)
  raw_outputs.append((name,raw));arts.append(dict(path=name,bytes=len(raw),sha256=sha(raw)))
 pc,fc,rc=population(ps)
 alternatives=[('mixed',pmix),('sharp',psharp),('combined8828',pold)]
 transitions={label:[[a,b,v] for (a,b),v in sorted(Counter(zip(old,ps)).items())] for label,old in alternatives}
 drops={label:dict(sorted(Counter(a-b for a,b in zip(old,ps)).items())) for label,old in alternatives}
 ck(min(a-b for a,b in zip(pold,ps))>=5)
 record_count=168521+59+sum(len(v) for v in transitions.values())+sum(len(v) for v in drops.values())+len(MEMORY)+100
 ck(record_count<=200000)
 summary=dict(schema='mean186-exact-tensor-summary-1',**common,
  scope='Saved assignment and full-plan precision/cache membership only; no workload weights, price, actual coefficient/transform/sign values or proof output.',
  selector='phi^2*(rho*(T-S_t)+186*S_t*T)^2*2^(2*(108-p)) <= c*Cg^2*(T-S_t)^2; old D and 2*S_base guards retained.',
  Cg=CG,declared_precision_range=[50,108],proved_upper_limit='p_new <= p_combined8828-5 <=100',
  input_bytes_read=READ_BYTES,all_predecessor_rows_slacks_and_minimality_matched=True,
  all_predecessor_coefficients_masks_contracts_summary_matched=True,
  inherited_selector_checks=legacy_tests,selector_tests=tests,max_tests_per_row=max_tests,
  full_nodes=37117,axis_records=13943,conductors=125400,precision_distribution=distribution(ps,stats,50),
  transitions=transitions,bit_drop_distributions=drops,
  node_precision_memberships=stats[0],kernel_precision_memberships=stats[1],kernel_entries=stats[2],
  kernel_precision_multiplicity_histogram=dict(sorted(stats[3].items())),
  baseline_kernel_lengths=6004,baseline_kernel_entries=337702368,
  extra_kernel_keys=stats[1]-6004,extra_kernel_entries=stats[2]-337702368,
  scaled_cache_complex_rounds=stats[2],exact_real_cache_sums=2*stats[2],
  projected_alternative_comparisons=comparisons,
  mask_propagation_edges=dict(mixed=mix_edges,sharp=sharp_edges,combined8828=old_edges,mean186=new_edges),
  regrid_population_only=dict(conductors=sum(pc[p] for p in range(50,100)),phi_sum=sum(fc[p] for p in range(50,100)),
   warning='Unweighted population only; actual distinct sample conversions, source and cache production remain unpriced.'),
  artifacts=arts,substantive_records=168521,conservative_record_count=record_count,
  memory_observations=MEMORY,private_memory_policy='Observed checkpoints <=1GiB; no absolute parser peak or hard OS cap guarantee.',
  limits=dict(input_bytes=64*MIB,per_input_bytes=32*MIB,output_bytes=12*MIB,records=200000,
   node_memberships=2189903,kernel_memberships=354236,selector_tests=6395400,metadata_integer_bits=1024),
  independent_reconstruction_pending=True,checks_before_final_serialization=CHECKS)
 CURRENT_ARTIFACT=NAMES[3][0];CURRENT_CAP=MIB;CURRENT_ENCODED_BYTES=None;CURRENT_SERIALIZATION_STAGE='complete artifact'
 CURRENT_STAGE_CAP=MIB
 memory('before summary serialize')
 raw=(json.dumps(summary,separators=(',',':'))+'\n').encode()
 CURRENT_ENCODED_BYTES=len(raw)
 ck(len(raw)<=MIB,dict(error='encoded artifact cap',artifact=NAMES[3][0],encoded_bytes=len(raw),limit_bytes=MIB))
 raw_outputs.append((NAMES[3][0],raw))
 ck(sum(len(r) for n,r in raw_outputs)+3*MIB<=12*MIB,'total cap with source/report reserve')
 ck(Path(__file__).stat().st_size+(HERE/'MEAN186_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md').stat().st_size<MIB)
 for name,raw in raw_outputs:ck(not (HERE/name).exists(),'publication path exists')
 memory('before exclusive publication')
 for name,raw in raw_outputs:
  CURRENT_ARTIFACT=name;CURRENT_CAP=dict(NAMES)[name]*MIB;CURRENT_ENCODED_BYTES=len(raw);CURRENT_SERIALIZATION_STAGE='publication'
  CURRENT_STAGE_CAP=CURRENT_CAP
  with (HERE/name).open('xb') as f:
   WRITTEN.append(name)
   ck(f.write(raw)==len(raw),'short write')
 print(json.dumps(dict(status='PASS_SAVED_ASSIGNMENT_ONLY',checks=CHECKS,tests=tests,
  distribution=summary['precision_distribution'],states=stats[0],kernels=stats[1],entries=stats[2],
  artifacts=arts+[dict(path=NAMES[3][0],bytes=len(raw_outputs[-1][1]),sha256=sha(raw_outputs[-1][1]))]),indent=2))
if __name__=='__main__':
 try:
  main()
 except BaseException as exc:
  print(json.dumps(dict(status='FAIL_STOP',phase=PHASE,error=repr(exc),checks=CHECKS,partial_artifacts=WRITTEN,
   current_artifact=CURRENT_ARTIFACT,current_artifact_cap_bytes=CURRENT_CAP,
   current_encoded_bytes=CURRENT_ENCODED_BYTES,encoded_bytes_scope=CURRENT_SERIALIZATION_STAGE,
   current_stage_cap_bytes=CURRENT_STAGE_CAP)),flush=True)
  raise
