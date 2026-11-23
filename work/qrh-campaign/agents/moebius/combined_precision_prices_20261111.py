"""Bounded saved combined40 price fold. No evaluators or other writers imported."""
from pathlib import Path
from collections import Counter
from fractions import Fraction as F
import ctypes
from ctypes import wintypes
import gc
import hashlib
import json
import os

HERE=Path(__file__).resolve().parent
AG=HERE.parent
MIB=1024**2
PINS={
 'integration/transform_structural_manifest_20261111.json':(25110201,'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'),
 'integration/sharper_conductor_precision_rows_20261111.json':(20920838,'8FD72DC7FD9EACCCF986BE92502AE13491F974744C9E6A6E32BD63ADC27ED085'),
 'integration/sharper_conductor_precision_caches_20261111.json':(1871369,'129ADFCF668378CA94140DB27F3A3D6EF43995E05EB1413D3BE8AC603061D831'),
 'integration/sharper_conductor_precision_metadata_20261111.json':(5188,'8CEA147C264CC963CAE2EBAFE58F32E4CCD53A99378D7403161510993862227F'),
 'integration/short_window_guard_conductor_rows_20261111.json':(12794207,'A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA'),
 'integration/short_window_guard_ledger_20261111.json':(41665,'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4'),
 'moebius/sharper_precision_price_widths_20261111.json':(320815,'61D422B596A8BA77801CA53CE515A6B94FFE923894FDA931C7593827399A17E4'),
 'moebius/sharper_precision_delta_prices_20261111.json':(162624,'4599278B2CCC3EA5A06EB0BE168D5245C53ADF0AF83D06B4ECD4C96F708321A1'),
 'major-constants/combined_conductor_precision_rows_20261111.json':(9568390,'2B9C245DCA582C93BFFCB022CEE858D09B07637D1D1D1F37D5C1FE5BDF94DBCB'),
 'major-constants/combined_conductor_precision_nodes_20261111.json':(2672728,'D3F0280F22D0D79EA8B99B46FF679F4BBFE2DED0C64B809C0322B75D3EC975C9'),
 'major-constants/combined_conductor_precision_caches_20261111.json':(137719,'6D992A88D3018394731B62387053C9E2A8C03EAFD95BDA750FC9E72FDDC54778'),
 'major-constants/combined_conductor_precision_summary_20261111.json':(13957,'493FAB7C41A216839CDA318DE0A80BB55C3CE9E5D4D6B8F4E47B44930A06C95B'),
}
SUPPORT={
 'moebius/COMBINED_PRECISION_PRICE_PREFLIGHT_2026-11-11.md':'369F28970D508C5179524F9B5D5019E587BA87B39F2959515029A198F4EF379C',
 'prime-estimates/REVIEW_COMBINED_PRECISION_PRICE_PREFLIGHT_2026-11-11.md':'4F1C347CF6D1AAECD631E21CE7D6F5228446DF239D49D59FD443D8F4F1B24A98',
 'major-constants/COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'EBA33B23C531312243495B9B0321597FC26D8AEBA8E1CF24626457474EA3A997',
 'integration/REVIEW_COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'8745235D810A1F06E8661961A05EF93C8DB24574121700DF6D924AE6EC2615C4',
 'prime-estimates/REVIEW_SHARPER_PRECISION_DELTA_PRICES_2026-11-11.md':'402537CDCA633BD94D4AA2F23FB6334FB0B317541929F30D1B6DD787DAB5F470',
 'audit/REVIEW_SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md':'56B27935FF994E3F25F735825196076DF72C8DBC33D2A61D4787B61E3BBDD5F0',
 'zero-sum/SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md':'E2457D3CA0E4436575DBAEA81413D91601312033AC6086233CFB7977D790225D',
 'moebius/COMBINED_PRICE_BASE_GUARD_PROVENANCE_CLARIFICATION_2026-11-11.md':'7A0C501723B0DC96F5D59877BAA44692117E62DF8C97D550D3E6086847EC67CC',
 'prime-estimates/REVIEW_COMBINED_PRICE_BASE_GUARD_PROVENANCE_2026-11-11.md':'7C57EA3599394E4924296A32BF18E28970B4AEC8A2FFDCF6403D687136F960D6',
}
OLD_CONTRACT='22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884'
INPUT_CONTRACT='376BBDC2EAC98F5AC3C28AEBFD5D6FAA80DD9989B081E4DA8A8AC79B3F270F91'
KERNEL_CONTRACT='F40998CB9F4C41271BDD69EAB97FEF5B89D3B3800A72C9525AC4EA393B3628C6'
KEYS=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
CATS=['root','kernel','add','quarter','neg','scale']
META=['conductor_height_nodes','residue_inputs','primitive_outputs']
EXTRAS=[0,167,320,640];ENDS=[6400,12800,25600,64000,128000]
NAMES=['combined_precision_price_widths_20261111.json','combined_precision_prices_20261111.json']
CHECKS=0;READ_BYTES=0;READ_NAMES=set();WRITTEN=[];PHASE='not started';MEMORY=[];MAX_PRIVATE=0

def ck(ok,label='check'):
 global CHECKS
 if not ok:raise AssertionError(label)
 CHECKS+=1

def integer(x):
 ck(type(x) is int and abs(x).bit_length()<=1024,'integer capacity')
 return x

def parse_int(s):
 ck(len(s)<=310,'literal capacity');return integer(int(s))

def reject_number(s):raise AssertionError('non-integer JSON number '+s)

def canon(x):return json.dumps(x,sort_keys=True,separators=(',',':')).encode()
def sha(x):return hashlib.sha256(x).hexdigest().upper()

class PMC(ctypes.Structure):
 _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[(n,ctypes.c_size_t) for n in
 ('PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage','PrivateUsage')]

def memory(label,record=True):
 global MAX_PRIVATE
 ck(os.name=='nt','Windows memory observer required')
 pm=PMC();pm.cb=ctypes.sizeof(pm)
 gp=ctypes.windll.kernel32.GetCurrentProcess;gp.restype=ctypes.c_void_p
 gm=ctypes.windll.psapi.GetProcessMemoryInfo;gm.argtypes=[ctypes.c_void_p,ctypes.POINTER(PMC),wintypes.DWORD];gm.restype=wintypes.BOOL
 ck(bool(gm(gp(),ctypes.byref(pm),pm.cb)),'memory query failed')
 MAX_PRIVATE=max(MAX_PRIVATE,pm.PrivateUsage)
 ck(pm.PrivateUsage<=2*1024*MIB,'observed private memory exceeds 2 GiB')
 if record:MEMORY.append([label,pm.PrivateUsage])

def phase(label):
 global PHASE
 PHASE=label;gc.collect();memory(label);print(label,flush=True)

def read(rel):
 global READ_BYTES
 ck(rel in PINS and rel not in READ_NAMES,'allowlist/single read')
 size,pin=PINS[rel];path=AG/rel
 ck(size<=32*MIB and path.stat().st_size==size,'input size '+rel)
 ck(READ_BYTES+size<=128*MIB,'aggregate bytes')
 memory('before read '+rel)
 with path.open('rb') as f:raw=f.read(size+1)
 ck(len(raw)==size and sha(raw)==pin,'input hash '+rel)
 out=json.loads(raw,parse_int=parse_int,parse_float=reject_number,parse_constant=reject_number)
 del raw;READ_BYTES+=size;READ_NAMES.add(rel);memory('after parse '+rel)
 return out

def bump(table,key,weights,mult,cap):
 if not mult:return
 if key not in table:ck(len(table)<cap,'table cap');table[key]=[0]*40
 dst=table[key]
 for i,w in enumerate(weights):dst[i]=integer(dst[i]+mult*w)

def fresh_meta(lo=80):return {p:[Counter() for _ in range(40)] for p in range(lo,109)}
def add_meta(table,p,weights,phi,primitive):
 for i,w in enumerate(weights):
  for k,v in zip(META,[w,w*phi,w*primitive]):table[p][i][k]=integer(table[p][i][k]+v)
def bands(count):
 out=[];lo=0
 for hi in ENDS:out.append(max(0,min(count,hi+1)-lo));lo=hi+1
 ck(sum(out)==count);return out
def clog(x):
 x=F(x);ck(x>0);return ((x.numerator+x.denominator-1)//x.denominator-1).bit_length()
def A(w):return 2*((w+7)//8)+1
def M(a,b):
 x,y=(a+7)//8,(b+7)//8;return 5*x*y+2*min(x,y)+1

def price(widths,mode,forced_p=None):
 out=[Counter() for _ in range(40)]
 for (p,cat,de,ce,db),weights in widths.items():
  p=p if forced_p is None else forced_p;a=p+14+de;b=p+ce
  if cat in ('root','kernel'):
   r=a+b+(2 if mode=='three' else 1)
   fee={cat+'_product':M(a+1,b)+2*M(a,b+1) if mode=='three' else 4*M(a,b),
        cat+'_exact_add':(A(a+1) if mode=='three' else 0)+2*A(r),cat+'_round_add':4*A(r+2)}
  elif cat=='add':fee={'add_complex_add':2*A(a+1)}
  else:fee={}
  for i,w in enumerate(weights):
   for k,v in fee.items():out[i][k]=integer(out[i][k]+w*v)
 return out

def packed(rows,si):
 subset=rows[5*si:5*si+5];parts=sum(subset,Counter());prod=sum(v for k,v in parts.items() if k.endswith('_product'))
 return dict(parts=dict(parts),bands=[dict(x) for x in subset],product_core=prod,addition_core=sum(parts.values())-prod,core=sum(parts.values()))
def all_views(rows):
 joint=[x+y for x,y in zip(rows[:20],rows[20:])]
 return [dict(extra_nodes=e,old=packed(rows[:20],i),guard=packed(rows[20:],i),joined=packed(joint,i)) for i,e in enumerate(EXTRAS)]
def category_counts(widths,lo):
 out={p:[Counter() for _ in range(40)] for p in range(lo,109)}
 for (p,cat,de,ce,db),ws in widths.items():
  for i,w in enumerate(ws):out[p][i][cat]=integer(out[p][i][cat]+w)
 return {str(p):[{cat:x[cat] for cat in CATS} for x in rows] for p,rows in out.items()}

def setup(keys,mode,lo):
 total=Counter();by_p={p:Counter() for p in range(lo,109)};hist=Counter()
 for n,p,P in sorted(keys):
  k=P.bit_length()-1;ck(k<=18 and P==1<<(2*n-2).bit_length())
  ell=(2*n).bit_length();hist[p,ell]+=P
  vals=dict(kernel_keys=1,kernel_entries=P,chirp_entries=n,scaled_cache_complex_rounds=P,
   exact_real_cache_sums=2*P if mode=='three' else 0,scaled_cache_round_add_core=P*4*A(p+ell+2),
   scaled_cache_sum_add_core=P*2*A(p+1) if mode=='three' else 0,
   kernel_fft_general_complex_products=P*k//2-3*P//2+2,kernel_fft_complex_add_sub=P*k,
   kernel_fft_quarter_turns=P//2-1,kernel_fft_negations=0,kernel_fft_dyadic_scales=0)
  for name,v in vals.items():total[name]=integer(total[name]+v);by_p[p][name]=integer(by_p[p][name]+v)
 total['total_added_normalized_setup_add_core']=total['scaled_cache_round_add_core']+total['scaled_cache_sum_add_core']
 return dict(totals=dict(total),by_p={str(p):dict(x) for p,x in by_p.items()},exponent_entry_histogram=[[p,e,v] for (p,e),v in sorted(hist.items())])

def main():
 phase('exclusive destinations and pinned inputs')
 for name in NAMES:ck(not (HERE/name).exists(),'destination exists '+name)
 support_bytes=0
 for rel,pin in SUPPORT.items():
  path=AG/rel;size=path.stat().st_size;support_bytes+=size;ck(support_bytes<=MIB,'support cap')
  with path.open('rb') as f:raw=f.read(size+1)
  ck(len(raw)==size and sha(raw)==pin,'support hash '+rel)
 ck(sum(s for s,h in PINS.values())==73619701)
 manifest=read('integration/transform_structural_manifest_20261111.json')
 sharp_rows=read('integration/sharper_conductor_precision_rows_20261111.json')
 sharp_cache=read('integration/sharper_conductor_precision_caches_20261111.json')
 sharp_summary=read('integration/sharper_conductor_precision_metadata_20261111.json')
 guard_rows=read('integration/short_window_guard_conductor_rows_20261111.json')
 guard=read('integration/short_window_guard_ledger_20261111.json')
 swf=read('moebius/sharper_precision_price_widths_20261111.json')
 prior=read('moebius/sharper_precision_delta_prices_20261111.json')
 rows=read('major-constants/combined_conductor_precision_rows_20261111.json')
 nodes=read('major-constants/combined_conductor_precision_nodes_20261111.json')
 cache=read('major-constants/combined_conductor_precision_caches_20261111.json')
 summary=read('major-constants/combined_conductor_precision_summary_20261111.json')
 ck(READ_NAMES==set(PINS) and READ_BYTES==73619701)
 plan=manifest['plan'];plan_hash=sha(canon(plan)).lower();order=sorted(map(int,plan))
 ck(plan_hash==manifest['canonical_plan_sha256']=='fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b')
 ck(manifest['schema']=='selected-transform-structural-manifest-1')
 ck(manifest['conductor_fields']==['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'])
 ck(manifest['request_fields']==['n','q','kind','children_n_q_multiplicity_normfactor','local_five_counts','five_counts'])
 ck(len(order)==37117 and len(manifest['requests'])==35190)
 ck(manifest['extras']==guard_rows['extras']==EXTRAS and manifest['band_last_indices']==guard_rows['band_last_indices']==ENDS)
 ck(len(manifest['conductors'])==len(rows['rows'])==len(sharp_rows['rows'])==len(guard_rows['rows_data'])==125400)
 ck(rows['schema']=='combined-conductor-precision-rows-2')
 ck(rows['fields']==['source_row_id','c','phi','primitive','S_mix','S_sharp','S_tight','S_base','D_local_old','p_mix','p_sharp','p_comb','rho'])
 ck(nodes['schema']=='combined-full-plan-coefficients-masks-1' and nodes['fields']==['n','C_mix','D_mix','C_sharp','D_sharp','C_tight','D_tight','combined_mask'])
 ck(cache['schema']=='combined-conductor-precision-kernel-masks-1' and cache['fields']==['n','P','combined_mask'])
 ck(summary['schema']=='combined-conductor-precision-summary-1')
 for obj in (rows,nodes,cache,summary):
  ck(obj['plan_sha256']==plan_hash and obj['input_contract_sha256']==INPUT_CONTRACT and obj['kernel_contract_sha256']==KERNEL_CONTRACT)
  ck(obj['assignment_only'] is True and obj['guard_domain_applicable'] is True)
  ck(obj['guard_weights_folded'] is False and obj['prices_included'] is False and obj['values_generated'] is False and obj['production_selected'] is False)
  ck(obj['inputs']['integration/transform_structural_manifest_20261111.json']==dict(bytes=PINS['integration/transform_structural_manifest_20261111.json'][0],sha256=PINS['integration/transform_structural_manifest_20261111.json'][1]))
 ck(sha(canon(cache['input_contract']))==INPUT_CONTRACT and sha(canon(cache['kernel_contract']))==KERNEL_CONTRACT)
 ck(cache['node_output_sha256']==PINS['major-constants/combined_conductor_precision_nodes_20261111.json'][1])
 ck(cache['row_output_sha256']==PINS['major-constants/combined_conductor_precision_rows_20261111.json'][1])
 ck(cache['legacy_contract_sha256']==OLD_CONTRACT and sha(canon(sharp_cache['contract']))==OLD_CONTRACT)
 projection=cache['kernel_projection_fields']
 ck(set(projection)==set(sharp_cache['contract'])-{'id','p_domain','coordinate_grid'})
 oldproj={k:sharp_cache['contract'][k] for k in projection}
 ck({k:cache['kernel_contract'][k] for k in projection}==oldproj and sha(canon(oldproj))==cache['kernel_projection_sha256'])
 for obj in (sharp_rows,sharp_cache,sharp_summary,swf,prior):ck(obj['contract_sha256']==OLD_CONTRACT)
 ck(sharp_rows['schema']=='sharper-conductor-precision-rows-1')
 ck(sharp_rows['fields']==['source_row_id','c','phi','primitive','S_mix','S_sharp','S_base','D_local_old','p_mix','p_sharp','budget_slack','D_slack','peak_slack','previous_budget_slack_or_null'])
 ck(sharp_cache['sharp_assignment_sha256']==PINS['integration/sharper_conductor_precision_rows_20261111.json'][1])
 ck(guard_rows['manifest_sha256']==PINS['integration/transform_structural_manifest_20261111.json'][1] and guard_rows['categories']==KEYS)
 ck(swf['schema']=='sharper-precision-price-widths-1' and prior['schema']=='sharper-precision-delta-price-receipt-1')
 ck(swf['fields']==['p','category','data_ceiling_exponent','coefficient_exponent','division_bits','old20_then_guard20_weights'])
 ck(swf['weight_order']==dict(views=['old','guard'],extras=EXTRAS,band_last_indices=ENDS) and swf['metadata_fields']==META)
 ck(any(a['sha256']==PINS['moebius/sharper_precision_price_widths_20261111.json'][1] for a in prior['artifacts']))
 ck(prior['old_prices_and_setup_matched'] is True and prior['global_width_and_category_conservation'] is True)

 phase('saved DAG, source row and comparator binding')
 dag={}
 for r in manifest['requests']:
  ck(len(r)==6);n,q,kind,children,local,total=r
  ck(type(n) is int and n>=2 and type(q) is int and q>=0 and (n,q) not in dag)
  ck(len(children)<=3 and len(local)==len(total)==5 and all(type(v) is int and v>=0 for v in local+total))
  for ch in children:
   ck(len(ch)==4 and all(type(v) is int for v in ch));cn,cq,mult,af=ch
   ck(2<=cn<n and cq>=0 and mult>=0 and af>=1)
  dag[n,q]=r
 for r in dag.values():ck(all((cn,cq) in dag for cn,cq,mult,af in r[3]))
 ordered_n=sorted({n for n,q in dag},reverse=True)
 coeff={};saved_masks={}
 ck(len(nodes['rows'])==37117)
 for n,row in zip(order,nodes['rows']):
  ck(len(row)==8 and row[0]==n and all(type(x) is int and x>=0 for x in row))
  coeff[n]=row[1:7];saved_masks[n]=row[7];ck(row[7]<1<<29)
  ch=plan[str(n)]['choice']
  if ch[0]=='split':ck(len(ch)==3 and ch[1]*ch[2]==n and all(2<=x<n and str(x) in plan for x in ch[1:]))
  else:ck(len(ch)==1 and ch[0] in ('radix2','direct_prime','bluestein'))
 del nodes
 sharp_widths={};global_widths={}
 for p,cat,de,ce,db,ws in swf['widths']:
  key=(p,cat,de,ce,db);ck(all(type(x) is int for x in (p,de,ce,db)) and 100<=p<=108 and 0<=de<=54 and db==0)
  ck(cat in CATS and ce==(1 if cat=='root' else 0) and key not in sharp_widths)
  ck(len(ws)==40 and all(type(w) is int and w>=0 for w in ws));sharp_widths[key]=ws
  bump(global_widths,key[1:],ws,1,133)
 ck(len(sharp_widths)==840 and len(global_widths)==133)
 sharp_meta=fresh_meta(100);combined_meta=fresh_meta();by_p={p:[] for p in range(80,109)}
 sharp_top=set();combined_seed_masks={n:0 for n in order};population=Counter();phi_tot=Counter();primitive_tot=Counter()
 perheight=[Counter() for _ in range(40)];Q=1<<52;Cg=4196258524692480;transitions=Counter();raw_seed_count=0
 for rid,(src,sr,cr,gr) in enumerate(zip(manifest['conductors'],sharp_rows['rows'],rows['rows'],guard_rows['rows_data'])):
  if rid%1024==0:memory('row join',False)
  ck(len(src)==7 and len(sr)==14 and len(cr)==13 and len(gr)==6)
  ck(all(type(x) is int for x in cr) and all(type(x) is int for x in sr[:13]))
  c,phi,primitive,H,J,axes,ws=src
  ck(cr[:4]==sr[:4]==[rid,c,phi,primitive])
  Sm,Ss,St,Sb,D,pm,ps,p,rho=cr[4:]
  ck([Sm,Ss,Sb,D,pm,ps]==sr[4:10])
  ck(10000<c<=265800 and ((c%2==1 and c<=132900) or c%4==0))
  ck(80<=p<ps<=pm<=108 and 100<=ps and rho==int(p<100))
  ck(0<=St<=Ss<=Sm<=202305920 and 0<=Sb<=424706204 and 1<=D<=29961461170177)
  ck(1<=len(axes)<=18 and phi>0 and primitive>=0)
  ck(Sm==sum(coeff[n][0] for n,q in axes) and Ss==sum(coeff[n][2] for n,q in axes) and St==sum(coeff[n][4] for n,q in axes))
  # Old_C/old_D are not in these node tuples: bind Sb/D exactly to the accepted sharp row.
  ck(max([1]+[coeff[n][1] for n,q in axes])<=D)
  rhs=c*(1266*202305920)**2
  ck(sr[10]==rhs-(2*phi*Ss)**2*2**(2*(108-ps))>=0 and sr[11]==2**ps-D>=0 and sr[12]==2**ps-2*Sb>=0)
  if ps==100:ck(sr[13] is None)
  else:ck(sr[13]==rhs-(2*phi*Ss)**2*2**(2*(109-ps))<0)
  rhs=integer(c*((Q-1)*Cg)**2)
  def budget(t):return integer(rhs-phi**2*((Q-1)*int(t<100)+Q*St*8828)**2*2**(2*(108-t)))
  ck(budget(p)>=0 and integer(2**p-D)>=0 and integer(2**p-2*Sb)>=0)
  if p>80:ck(budget(p-1)<0)
  gc_,gj,gphi,gprim,ops,gws=gr;ck([gc_,gj,gphi,gprim]==[c,J,phi,primitive])
  ck(len(ws)==len(gws)==20 and len(ops)==5 and all(type(x) is int and x>=0 for x in ws+gws+ops))
  old=[];guardw=[]
  for e in EXTRAS:
   pre=bands(J+e);post=bands(J+e+41);diff=[b-a for a,b in zip(pre,post)]
   ck(min(diff)>=0 and sum(diff)==41);old+=pre;guardw+=diff
  ck(old==ws and guardw==gws)
  suffix=phi;full=kept=1;op=[0]*5
  for n,q in axes:
   raw_seed_count+=1;ck(raw_seed_count<=2257200)
   ck((n,q) in dag and suffix%n==0 and (q==0 or (q>0 and n%q==0)))
   suffix//=n
   for j,v in enumerate(dag[n,q][5]):op[j]+=kept*suffix*v
   kept*=n if q==0 else n-n//q;full*=n
   sharp_top.add((n,ps));combined_seed_masks[n]|=1<<(p-80)
  ck(full==phi and kept==primitive and suffix==1 and op==ops)
  both=ws+gws;add_meta(sharp_meta,ps,both,phi,primitive);add_meta(combined_meta,p,both,phi,primitive)
  by_p[p].append(rid);population[p]+=1;phi_tot[p]+=phi;primitive_tot[p]+=primitive;transitions[ps,p]+=1
  for i,w in enumerate(both):
   for k,v in zip(KEYS,ops):perheight[i][k]=integer(perheight[i][k]+w*v)
 for p in range(100,109):ck([dict(x) for x in sharp_meta[p]]==swf['metadata_by_p'][str(p)])
 for i in range(40):
  for k in META:ck(sum(sharp_meta[p][i][k] for p in sharp_meta)==sum(combined_meta[p][i][k] for p in combined_meta))
 for si,sc in enumerate(guard['scenarios']):
  for offset,label in ((0,'old_runtime'),(20,'added_runtime')):
   totals=sum((combined_meta[p][offset+5*si+b] for p in combined_meta for b in range(5)),Counter())
   for k,v in totals.items():ck(v==sc[label][k])
   ck(dict(sum(perheight[offset+5*si:offset+5*si+5],Counter()))==sc[label]['operations'])
  ck(F(sc['max_guard_height'])<=F(26525,4)<7000)
 ck([[a,b,v] for (a,b),v in sorted(transitions.items())]==summary['transitions']['sharp'])
 ck(sum(population[p] for p in range(80,100))==summary['regrid_population_only']['conductors']==115340)
 ck(sum(phi_tot[p] for p in range(80,100))==summary['regrid_population_only']['phi_sum']==6268332948)
 del rows,sharp_rows,coeff

 sharp_prices={mode:all_views(price(sharp_widths,mode)) for mode in ('three','four')}
 global_prices={mode:all_views(price(sharp_widths,mode,108)) for mode in ('three','four')}
 ck(sharp_prices==prior['sharp_prices'] and global_prices==prior['global_p108'],'all sharp/global price components')
 ck(category_counts(sharp_widths,100)==swf['normalized_counts_by_p'])
 ck(sharp_cache['schema']=='sharper-conductor-precision-caches-1' and sharp_cache['plan_sha256']==plan_hash)
 ck(sharp_cache['full_node_fields']==['n','p','saved_choice','ordered_child_n_p'] and sharp_cache['kernel_fields']==['n','p','P'])
 sharp_states=set();child_seen=set();sharp_nodes_by_p={p:Counter() for p in range(100,109)}
 for n,p,ch,children in sharp_cache['full_nodes']:
  ck(100<=p<=108 and (n,p) not in sharp_states and ch==plan[str(n)]['choice'])
  ck(children==([] if ch[0]!='split' else [[d,p] for d in ch[1:]]))
  sharp_states.add((n,p));child_seen.update(map(tuple,children));sharp_nodes_by_p[p]['full_plan_states']+=1
  if ch[0]=='split':sharp_nodes_by_p[p]['CT_full_root_table_entry_upper']+=n
 ck(len(sharp_states)==37522 and sharp_states==sharp_top|child_seen and sharp_top<=sharp_states and child_seen<=sharp_states)
 sharp_keys={(n,p,1<<(2*n-2).bit_length()) for n,p in sharp_states if plan[str(n)]['choice'][0]=='bluestein'}
 ck(len(sharp_keys)==7850 and len(sharp_cache['kernels'])==7850 and sharp_keys==set(map(tuple,sharp_cache['kernels'])))
 ck(sum(P for n,p,P in sharp_keys)==369180928 and len({n for n,p in sharp_states})==32942)
 ck({str(p):dict(x) for p,x in sharp_nodes_by_p.items()}==prior['sharp_full_cache_nodes_by_p'])
 base_keys={(n,108,P) for n,p,P in sharp_keys};ck(len(base_keys)==6004 and sum(P for n,p,P in base_keys)==337702368)
 sharp_setup={mode:setup(sharp_keys,mode,100) for mode in ('three','four')}
 global_setup={mode:setup(base_keys,mode,100) for mode in ('three','four')}
 ck(sharp_setup==prior['setup_sharp'] and global_setup==prior['setup_global_p108'],'complete setup comparators')
 for pd in sharp_summary['precision_distribution']:
  p=pd['p'];x=sharp_setup['three']['by_p'][str(p)]
  ck(x.get('kernel_keys',0)==pd['kernel_keys'] and x.get('kernel_entries',0)==pd['kernel_entries'])
 del swf,sharp_cache,sharp_summary
 phase('all sharp/global comparator gates passed; combined40 propagation')
 widths={};context_stats=[];processed_total=0
 for p,ids in by_p.items():
  buckets={};created=processed=live=peak=blue=0
  def context(n,key,ws,mult):
   nonlocal created,live,peak
   if not mult:return
   tab=buckets.setdefault(n,{})
   if key not in tab:
    ck(created<220108 and live<220108,'partition context cap');tab[key]=[0]*40;created+=1;live+=1;peak=max(peak,live)
   dst=tab[key]
   for i,w in enumerate(ws):dst[i]=integer(dst[i]+mult*w)
  for rid in ids:
   c,phi,primitive,H,J,axes,ws=manifest['conductors'][rid]
   both=ws+guard_rows['rows_data'][rid][-1];suffix=phi;kept=full=1
   for n,q in axes:
    suffix//=n;context(n,(q,2*full),both,kept*suffix)
    kept*=n if q==0 else n-n//q;full*=n
  top=created;ck(top<=52560);memory('p'+str(p)+' seeded')
  def emit(cat,a,ce,count,ws):
   if not count:return
   de=clog(a);key=(cat,de,ce,0);ck(key in global_widths and 0<=de<=54)
   bump(widths,(p,*key),ws,count,3857)
  def vec(v,a,ws):
   for j,count in enumerate(v):
    ck(j!=4 or count==0);emit(('root','add','quarter','neg','scale')[j],a,1 if j==0 else 0,count,ws)
  def stages(P,a,ws):
   k=P.bit_length()-1;ck(k<=18)
   for j in range(1,k+1):
    copies=P//(1<<j);quarter=int(j>=2)
    emit('root',(1<<j)*a,1,copies*((1<<(j-1))-1-quarter),ws)
    emit('quarter',(1<<j)*a,0,copies*quarter,ws);emit('add',(1<<(j+1))*a,0,P,ws)
  for n in ordered_n:
   bucket=buckets.pop(n,{})
   while bucket:
    (q,a),ws=bucket.popitem();live-=1;processed+=1;processed_total+=1
    ck(processed<=220108 and processed_total<=6383132)
    if processed%1024==0:memory('context loop',False)
    _,_,kind,children,local,total=dag[n,q]
    for cn,cq,mult,af in children:context(cn,(cq,integer(a*af)),ws,mult)
    if kind=='bluestein':
     blue+=1;P=1<<(2*n-2).bit_length();k=P.bit_length()-1;ck(k<=18)
     rad=[P*k//2-3*P//2+2,P*k,P//2-1,0,0];base=[2*x+(P if j in (0,4) else 0) for j,x in enumerate(rad)]
     full=[plan[str(n)]['count'][key] for key in KEYS]
     ck(all(x>=y and (x-y)%2==0 for x,y in zip(full,base)))
     pre=[(x-y)//2 for x,y in zip(full,base)];post=[x-y-z for x,y,z in zip(total,base,pre)]
     ck(min(post)>=0 and post[1]==post[4]==0)
     vec(pre,2*a,ws);stages(P,2*a,ws);emit('kernel',(n+2)*a,0,P,ws)
     stages(P,(F(n*(2*n-1),P)+2)*a,ws);vec(post,2*n*a,ws)
    elif kind=='ct':
     r,mm=(2,n//2) if plan[str(n)]['choice'][0]=='radix2' else plan[str(n)]['choice'][1:]
     vec(local,2*mm*a,ws)
    elif kind=='radix2':stages(n,a,ws)
    elif kind=='pruned_two':emit('add',4*a,0,1,ws)
    elif kind=='direct_prime':vec(total,2*n*a,ws)
    else:raise AssertionError('unknown saved request kind')
  ck(not buckets and live==0 and processed==created)
  context_stats.append(dict(p=p,rows=len(ids),top=top,processed=processed,peak_retained=peak,blue=blue))
  print('p='+str(p)+' contexts='+str(processed),flush=True);gc.collect();memory('p'+str(p)+' complete')
 new_global={}
 for (p,cat,de,ce,db),ws in widths.items():
  ck(all(0<=w<=g for w,g in zip(ws,global_widths[cat,de,ce,db])))
  bump(new_global,(cat,de,ce,db),ws,1,133)
 ck(new_global==global_widths,'every global133 key and40 weights conserved')
 combined_counts=category_counts(widths,80);sharp_counts=category_counts(sharp_widths,100)
 for i in range(40):
  for cat in CATS:ck(sum(combined_counts[str(p)][i][cat] for p in by_p)==sum(sharp_counts[str(p)][i][cat] for p in sharp_meta))
  ck(sum(combined_counts[str(p)][i]['scale'] for p in by_p)==0)
 phase('global conservation passed; complete cache mask and input costs')
 masks=dict(combined_seed_masks);edge_count=0
 for n in reversed(order):
  ch=plan[str(n)]['choice']
  if masks[n] and ch[0]=='split':
   for child in ch[1:]:edge_count+=1;ck(edge_count<=74234);masks[child]|=masks[n]
 ck(masks==saved_masks and sum(bool(v) for v in masks.values())==32942)
 kernel_lengths=[n for n in order if masks[n] and plan[str(n)]['choice'][0]=='bluestein']
 ck(len(kernel_lengths)==6004 and cache['rows']==[[n,1<<(2*n-2).bit_length(),masks[n]] for n in kernel_lengths])
 combined_keys=set();combined_states=set();cache_nodes={p:Counter() for p in by_p};members=0;kmembers=0
 for index,n in enumerate(order):
  if index%1024==0:memory('mask membership loop',False)
  for bit in range(29):
   members+=1;ck(members<=1076393)
   if not masks[n]&(1<<bit):continue
   p=80+bit;combined_states.add((n,p));cache_nodes[p]['full_plan_states']+=1
   ch=plan[str(n)]['choice']
   if ch[0]=='split':cache_nodes[p]['CT_full_root_table_entry_upper']+=n
   elif ch[0]=='bluestein':combined_keys.add((n,p,1<<(2*n-2).bit_length()))
 for n in kernel_lengths:
  for bit in range(29):kmembers+=1;ck(kmembers<=174116)
 ck(len(combined_states)==summary['node_precision_memberships']==49899)
 ck(len(combined_keys)==summary['kernel_precision_memberships']==8467)
 ck(sum(P for n,p,P in combined_keys)==summary['kernel_entries']==363202368)
 ck({(n,108,P) for n,p,P in combined_keys}==base_keys)
 ck(summary['scaled_cache_complex_rounds']==363202368 and summary['exact_real_cache_sums']==726404736)
 ck(summary['mask_propagation_edges']['combined']==edge_count)
 ck(dict(sorted(Counter(masks[n].bit_count() for n in kernel_lengths).items()))==
    {int(k):v for k,v in summary['kernel_precision_multiplicity_histogram'].items()})
 common_states=len(combined_states&sharp_states);common_keys=len(combined_keys&sharp_keys)
 overlap=dict(node_projection_intersection=common_states,node_only_combined=len(combined_states)-common_states,node_only_old=len(sharp_states)-common_states,
  kernel_projection_intersection=common_keys,kernel_only_combined=len(combined_keys)-common_keys,kernel_only_old=len(sharp_keys)-common_keys)
 ck(overlap==cache['projected_alternative_comparisons']['sharp']==summary['projected_alternative_comparisons']['sharp'])
 combined_setup={mode:setup(combined_keys,mode,80) for mode in ('three','four')}
 for pd in summary['precision_distribution']:
  p=pd['p'];ss=combined_setup['three']['by_p'][str(p)]
  ck((population[p],phi_tot[p],primitive_tot[p])==(pd['conductors'],pd['phi_total'],pd['primitive_total']))
  ck(ss.get('kernel_keys',0)==pd['kernel_keys'] and ss.get('kernel_entries',0)==pd['kernel_entries'])
 combined_prices={mode:all_views(price(widths,mode)) for mode in ('three','four')}
 for mode in ('three','four'):ck(all_views(price(widths,mode,108))==global_prices[mode])
 conversion={};input_cost_rows=[Counter() for _ in range(40)]
 for p,metas in combined_meta.items():
  out=[]
  for i,meta in enumerate(metas):
   N=meta['residue_inputs']
   counts=dict(complex_inputs=N,regrid_complex=N if p<100 else 0,coordinate_witnesses=2*N if p<100 else 0,
    signed_witness_additions=4*N if p<100 else 0,unsigned_addition_core=124*N if p<100 else 0,
    coordinate_value_shifts=2*N if p!=100 else 0,identity_complex=N if p==100 else 0,
    exact_embedding_complex=N if p>100 else 0,remainder_range_witnesses=2*N if p<100 else 0)
   for v in counts.values():integer(v)
   out.append(counts)
   for key,value in counts.items():input_cost_rows[i][key]+=value
  conversion[str(p)]=dict(branch='regrid' if p<100 else ('identity' if p==100 else 'exact_embedding'),
   shift_bits=abs(p-100),source_signed_bits=115,destination_signed_bits=p+15,
   raw_witness_signed_bits=116 if p<100 else None,remainder_bits=100-p if p<100 else None,weights40=out)
 input_views=[]
 for si,e in enumerate(EXTRAS):
  record={'extra_nodes':e}
  for view,offsets in [('old',[0]),('guard',[20]),('joined',[0,20])]:
   totals=sum((input_cost_rows[o+5*si+b] for o in offsets for b in range(5)),Counter());record[view]=dict(totals)
   ck(totals['regrid_complex']<=totals['complex_inputs'])
  ck(record['joined']['complex_inputs']==60254515577760+e*7133015232)
  input_views.append(record)
 comparisons=[]
 for mode in ('three','four'):
  for target,prices,prior_setup in [('global_p108',global_prices,global_setup),('sharp_local',sharp_prices,sharp_setup)]:
   for si,e in enumerate(EXTRAS):
    for view in ('old','guard','joined'):
     old=prices[mode][si][view];new=combined_prices[mode][si][view];ps=prior_setup[mode]['totals'];ns=combined_setup[mode]['totals']
     dp=old['product_core']-new['product_core'];da=old['addition_core']-new['addition_core'];ck(dp>=0 and da>=0)
     comparisons.append(dict(mode=mode,comparator=target,extra_nodes=e,view=view,runtime_product_core_reserve=dp,
      runtime_addition_core_reserve=da,combined_to_prior_core_ratio=str(F(new['core'],old['core'])),
      new_regrid_unsigned_addition_core=input_views[si][view]['unsigned_addition_core'],
      additional_cold_scale_sum_add_core=ns['total_added_normalized_setup_add_core']-ps['total_added_normalized_setup_add_core'],
      conservative_sunk_new_scale_sum_add_core=ns['total_added_normalized_setup_add_core'],
      kernel_fft_deltas={k:ns['kernel_fft_'+k]-ps['kernel_fft_'+k] for k in KEYS}))
 phase('exclusive bounded serialization')
 common=dict(input_pins=PINS,support_pins=SUPPORT,input_contract_sha256=INPUT_CONTRACT,kernel_contract_sha256=KERNEL_CONTRACT,
  weight_order=dict(views=['old','guard'],extras=EXTRAS,band_last_indices=ENDS),V_error=8828,V_width=16384,full_P20=True)
 width_obj=dict(schema='combined-precision-price-widths-1',**common,
  fields=['p','category','data_ceiling_exponent','coefficient_exponent','division_bits','old20_then_guard20_weights'],
  widths=[list(k)+[v] for k,v in sorted(widths.items())],metadata_fields=META,
  metadata_by_p={str(p):[dict(x) for x in metas] for p,metas in combined_meta.items()},normalized_counts_by_p=combined_counts)
 # A p-labelled nonnegative component never exceeds its precision-forgotten component.
 # This is an encoded row bound based on actual accepted global weights, not1024-bit padding.
 row_cap=sum(29*(len(json.dumps([108,*key,ws],separators=(',',':')).encode())+1) for key,ws in global_widths.items())
 wrapper=dict(width_obj);wrapper['widths']=[]
 width_static_cap=len(json.dumps(wrapper,separators=(',',':')).encode())+row_cap+1
 ck(width_static_cap<=8*MIB,'static width encoding bound');del wrapper
 output=[]
 def encode(name,obj,cap):
  memory('before serialize '+name);raw=json.dumps(obj,separators=(',',':')).encode()+b'\n'
  ck(len(raw)<=cap,dict(error='encoded artifact cap',filename=name,actual_bytes=len(raw),cap_bytes=cap))
  memory('after serialize '+name);output.append((name,raw))
  return dict(path=name,bytes=len(raw),sha256=sha(raw))
 wa=encode(NAMES[0],width_obj,8*MIB)
 ck(wa['bytes']<=width_static_cap,'actual exceeds static width bound')
 receipt=dict(schema='combined-precision-price-receipt-1',**common,source_sha256=sha(Path(__file__).read_bytes()),
  checks_before_receipt=CHECKS,input_bytes=READ_BYTES,source_rows=125400,precision_distribution=summary['precision_distribution'],
  context_stats=context_stats,total_processed_contexts=processed_total,width_classes=len(widths),global_width_classes=133,
  historical_phase_validation='Inherited from accepted sharp840/predecessor reports; not rerun.',
  sharp_and_global_all_price_components_matched=True,sharp_and_global_all_setup_components_matched=True,
  every_global_width_weight_conserved=True,all_input_output_metadata_conserved=True,
  artifacts=[wa],static_width_encoded_upper_bound=width_static_cap,
  global_p108=global_prices,sharp_prices=sharp_prices,combined_prices=combined_prices,
  setup_global_p108=global_setup,setup_sharp=sharp_setup,setup_combined=combined_setup,
  combined_full_cache_nodes_by_p={str(p):dict(v) for p,v in cache_nodes.items()},cache_projection_overlap_with_sharp=overlap,
  full_cache_states=len(combined_states),full_kernel_keys=len(combined_keys),kernel_entries=363202368,
  conversion_by_p=conversion,conversion_views=input_views,comparisons=comparisons,
  sharp_input_metadata_by_p={str(p):[dict(x) for x in metas] for p,metas in sharp_meta.items()},
  new_input_costs_excluded_from_runtime_subtotal=True,
  regrid_roles_not_priced=['four signed wrappers per complex regrid','two value shifts and powers','partial-bit remainder and source/destination ranges',
   'source, output, grid and complex-norm proof bindings','quotient/remainder and magnitude-difference generation','representation and cache/transport/lifetime work'],
  remaining_costs=['source grid100 polynomial/head/assembly and exports','p100 identity and p>100 embedding',
   'kernel FFT arithmetic widths and root/chirp generation/enclosure/checking','quarter/negation/scale/permutation costs',
   'ordinary proof/header/range/sign/term checking','cache import/storage/lifetime rebuilds','actual signs, repairs and Turing completion',
   'principal/binary/ladder and analytic/MM0 foundations'],
  exclusions=['width8828 or smaller-magnitude successor','shared-high caches','portfolios','Gauss/wider-radix/named-digit arithmetic',
   'numerical values or gate/unit enumeration'],
  caps=dict(inputs=128*MIB,individual_input=32*MIB,support=MIB,precisions=29,weights=40,top_per_p=52560,
   contexts_per_p=220108,total_contexts=6383132,width_classes=3857,radix_stages=18,integer_bits=1024,
   width_output=8*MIB,summary_output=2*MIB,all_owned=12*MIB,observed_private_bytes=2*1024*MIB),
  observed_memory=MEMORY,maximum_observed_private_bytes=MAX_PRIVATE,memory_scope='Checkpoints only, not an absolute peak bound.',
  attempt=1,production_selected=False,numerical_evidence=False,runtime_claim=False,independent_review_pending=True)
 ra=encode(NAMES[1],receipt,2*MIB)
 owned=sum(len(raw) for name,raw in output)+Path(__file__).stat().st_size+(HERE/'COMBINED_PRECISION_PRICE_PREFLIGHT_2026-11-11.md').stat().st_size+MIB
 ck(owned<=12*MIB,dict(error='owned bytes cap',actual_bytes=owned,cap_bytes=12*MIB))
 for name,raw in output:ck(not (HERE/name).exists(),'exclusive final gate '+name)
 memory('before publication')
 for name,raw in output:
  with (HERE/name).open('xb') as f:
   WRITTEN.append(name)
   ck(f.write(raw)==len(raw),'short write '+name)
 memory('after publication')
 print(json.dumps(dict(status='PASS_SAVED_PRICE_ONLY',checks=CHECKS,contexts=processed_total,width_classes=len(widths),
  artifacts=[wa,ra],maximum_observed_private_bytes=MAX_PRIVATE,main={mode:combined_prices[mode][0]['joined'] for mode in ('three','four')},
  main_inputs=input_views[0]['joined'])),flush=True)

if __name__=='__main__':
 try:main()
 except BaseException as exc:
  print(json.dumps(dict(status='FAIL_STOP',phase=PHASE,error=repr(exc),checks=CHECKS,partial_created_paths=WRITTEN)),flush=True)
  raise
