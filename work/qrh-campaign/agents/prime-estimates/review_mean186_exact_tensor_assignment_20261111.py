"""Independent bounded saved-assignment replay; no author import or pricing."""
import json, hashlib, ctypes, gc, os
from pathlib import Path
from collections import Counter
from fractions import Fraction
from math import prod
from ctypes import wintypes

HERE=Path(__file__).resolve().parent
AG=HERE.parent
MIB=1024**2
PINS={
'integration/transform_structural_manifest_20261111.json':(25110201,'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'),
'zero-sum/mixed_radix_precision_metadata_20261111.json':(1911933,'8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E'),
'major-constants/combined_conductor_precision_rows_20261111.json':(9568390,'2B9C245DCA582C93BFFCB022CEE858D09B07637D1D1D1F37D5C1FE5BDF94DBCB'),
'major-constants/combined_conductor_precision_nodes_20261111.json':(2672728,'D3F0280F22D0D79EA8B99B46FF679F4BBFE2DED0C64B809C0322B75D3EC975C9'),
'major-constants/combined_conductor_precision_caches_20261111.json':(137719,'6D992A88D3018394731B62387053C9E2A8C03EAFD95BDA750FC9E72FDDC54778'),
'major-constants/combined_conductor_precision_summary_20261111.json':(13957,'493FAB7C41A216839CDA318DE0A80BB55C3CE9E5D4D6B8F4E47B44930A06C95B'),
'integration/short_window_guard_ledger_20261111.json':(41665,'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4'),
}
OUT={
'mean186_exact_tensor_rows_20261111.json':(1398171,'D48BD451730EC4A506A136F63715E9A88352968CFAD27293122A9D10240E2132'),
'mean186_exact_tensor_node_masks_20261111.json':(775486,'831A1024B061467A8993938F22D49A79D09E6D21E1BE480CDBDE81109E488083'),
'mean186_exact_tensor_kernel_masks_20261111.json':(142776,'6CFD36D5C13528C5A76F42A878D49D4E297CAFA77DECE623107952B861AA82B7'),
'mean186_exact_tensor_summary_20261111.json':(17344,'92BEB95531D79A9541378EB90C42894144E7D29CE95B8D456D879BD5CF767C09')}
WRITER='CCDAA894518AD2FFFA73F8B1504C09B6DDE9F422F92831D5BD19C10F1D7D057D'
IC='376BBDC2EAC98F5AC3C28AEBFD5D6FAA80DD9989B081E4DA8A8AC79B3F270F91'
KC='F40998CB9F4C41271BDD69EAB97FEF5B89D3B3800A72C9525AC4EA393B3628C6'
CG=4196258524692480
CHECKS=0
PHASE='initial'
READ=set()
MEM=[]
CREATED=[]
def ck(v,label='check'):
 global CHECKS
 if not v: raise AssertionError((PHASE,label,CHECKS))
 CHECKS+=1
def sha(b):return hashlib.sha256(b).hexdigest().upper()
def canon(o):return json.dumps(o,sort_keys=True,separators=(',',':')).encode()
def integer(s):
 ck(len(s)<=310,'literal size');v=int(s);ck(v.bit_length()<=1024,'integer bits');return v
def bad(s):raise AssertionError('Noninteger numeric field '+s)
class Memory(ctypes.Structure):
 _fields_=[('cb',wintypes.DWORD),('faults',wintypes.DWORD)]+[(n,ctypes.c_size_t) for n in ['peakws','ws','peakpaged','paged','peaknonpaged','nonpaged','pagefile','peakpagefile','private']]
def memory(label):
 ck(os.name=='nt');m=Memory();m.cb=ctypes.sizeof(m)
 gp=ctypes.windll.kernel32.GetCurrentProcess;gp.restype=ctypes.c_void_p
 gm=ctypes.windll.psapi.GetProcessMemoryInfo;gm.argtypes=[ctypes.c_void_p,ctypes.POINTER(Memory),wintypes.DWORD]
 ck(gm(gp(),ctypes.byref(m),m.cb));ck(m.private<=1024*MIB,'1GiB observed cap');MEM.append([label,m.private])
def phase(s):
 global PHASE
 PHASE=s;gc.collect();memory(s);print(s,flush=True)
def read(rel,spec,cap):
 ck(rel not in READ);p=AG/rel;size,pin=spec
 ck(p.stat().st_size==size and size<=cap);memory('before '+rel)
 raw=p.read_bytes();ck(sha(raw)==pin);o=json.loads(raw,parse_int=integer,parse_float=bad,parse_constant=bad)
 del raw;READ.add(rel);memory('after '+rel);return o
def load(i):
 rel=list(PINS)[i];return read(rel,PINS[rel],32*MIB)
def eqfields(o,expected,label):
 for k,v in expected.items():ck(o[k]==v,label+':'+k)
def cntdict(it):return {str(k):v for k,v in sorted(Counter(it).items())}
def main():
 dest=HERE/'review_mean186_exact_tensor_assignment_20261111.json';ck(not dest.exists())
 ck(sum(x[0] for x in PINS.values())==39456593<64*MIB)
 ck(sum(x[0] for x in OUT.values())<12*MIB)
 ck(sha((AG/'major-constants/mean186_exact_tensor_assignment_20261111_v2.py').read_bytes())==WRITER)
 phase('Read saved plans and reconstruct all three coefficient pairs')
 man=load(0);axesdata=load(1)
 ck(man['schema']=='selected-transform-structural-manifest-1')
 ck(man['conductor_fields']==['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'])
 ck(man['request_fields']==['n','q','kind','children_n_q_multiplicity_normfactor','local_five_counts','five_counts'])
 ck(man['extras']==[0,167,320,640] and man['band_last_indices']==[6400,12800,25600,64000,128000])
 ck(len(man['conductors'])==125400 and len(man['plan'])==37117 and len(man['requests'])==35190)
 planhash=sha(canon(man['plan'])).lower();ck(planhash==man['canonical_plan_sha256']==axesdata['plan_sha256']=='fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b')
 del man['requests']
 ck(axesdata['status']=='PASS_INTEGER_ERROR_COEFFICIENT_COMPARISON')
 eqfields(axesdata,dict(max_old_sum_C=424706204,max_new_sum_C=202305920,max_old_D=29961461170177),'axis global caps')
 choices={int(n):row['choice'] for n,row in man['plan'].items()};order=sorted(choices);coeff={}
 for idx,n in enumerate(order):
  if idx%4096==0:memory('coefficient checkpoint')
  ch=choices[n];ck(n>=2)
  if ch[0]=='split':
   ck(len(ch)==3);r,m=ch[1:];ck(r*m==n and 1<r<n and 1<m<n)
   vals=[]
   for z in range(3):
    cm,dm=coeff[m][2*z:2*z+2];cr,dr=coeff[r][2*z:2*z+2]
    vals.extend((cm+cr+2,max(1,dm,dr,cm+cr+2*cm*cr)))
  else:
   ck(len(ch)==1)
   if ch[0]=='direct_prime':ck(n in (3,5,7,11));vals=[2,1]*3
   elif ch[0]=='radix2':
    ck(n&(n-1)==0);k=n.bit_length()-1;vals=[2*k+4,max(1,2*k)]*3
   else:
    ck(ch[0]=='bluestein');P=1<<((2*n-1)-1).bit_length();k=P.bit_length()-1;R=2*k+4;A=1+3*R
    ck(2*n<=P<4*n)
    C=6*P*A+2*R*(2*n+1)+8;D=max(1,2*k,P*A,3*n*P*A+1)
    sharp=Fraction(9*P*A+3*P,2)+3*R*n+12*R+14;ck(sharp.denominator==1)
    X=Fraction(P*(3*n*A+n+2)+R*(2*n*n-n+2*P),n)
    tight=-((-X.numerator)//X.denominator)+2
    vals=[C,D,int(sharp),D,tight,max(D,2*C)]
  ck(all(type(v)is int and v>=0 and v.bit_length()<=1024 for v in vals))
  ck(vals[4]<=vals[2]<=vals[0] and vals[3]<=vals[1] and vals[5]<=max(vals[1],2*vals[0]));coeff[n]=vals
 axis={}
 for row in axesdata['axis_rows']:
  ck(set(row)=={'n','old_C','new_C','old_D','new_D'} and all(type(v)is int and v>=0 for v in row.values()))
  n=row['n'];ck(n not in axis and coeff[n][:2]==[row['new_C'],row['new_D']])
  ck(row['new_C']<=row['old_C'] and min(row['new_D'],row['old_D'])>=1);axis[n]=row
 ck(len(axis)==13943);del axesdata
 phase('Reconstruct predecessor identities and exact selector boundaries')
 oldr=load(2);oldn=load(3)
 ck(oldr['fields']==['source_row_id','c','phi','primitive','S_mix','S_sharp','S_tight','S_base','D_local_old','p_mix','p_sharp','p_comb','rho'])
 ck(oldn['fields']==['n','C_mix','D_mix','C_sharp','D_sharp','C_tight','D_tight','combined_mask'])
 ck(oldr['schema']=='combined-conductor-precision-rows-2' and oldn['schema']=='combined-full-plan-coefficients-masks-1')
 ck(len(oldr['rows'])==125400 and len(oldn['rows'])==37117)
 for n,row in zip(order,oldn['rows']):ck(len(row)==8 and row[:7]==[n]+coeff[n])
 ps={k:[] for k in ['mixed','sharp','combined8828','mean186']};ev=[];seen=set();legacy_checks=0
 Q=2**52;small=(1266*202305920)**2
 for rid,(src,row) in enumerate(zip(man['conductors'],oldr['rows'])):
  if rid%4096==0:memory('row checkpoint')
  ck(len(src)==7 and len(row)==13);c,phi,pr,H,J,ax,weights=src
  ck(c not in seen and 10000<c<=265800 and ((c%2==1 and c<=132900)or c%4==0));seen.add(c)
  ck(1<=len(ax)<=18 and all(len(a)==2 and a[0]in axis and 0<=a[1]<=a[0] and(a[1]==0 or a[0]%a[1]==0) for a in ax))
  ck(prod(n for n,q in ax)==phi and prod(n if q==0 else n-n//q for n,q in ax)==pr)
  ck(1<=pr<=phi<=c and len(weights)==20 and all(type(w)is int and w>=0 for w in weights))
  sm,ss,st=(sum(coeff[n][j] for n,q in ax)for j in (0,2,4));sb=sum(axis[n]['old_C']for n,q in ax)
  den=max([1]+[axis[n][key]for n,q in ax for key in ['new_D','old_D']])
  ck(0<=st<=ss<=sm<=202305920 and sb<=424706204 and den<=29961461170177)
  pm,pz,po=row[9:12];ck(100<=pz<=pm<=108 and 80<=po<=105 and po<=pz)
  ck(row==[rid,c,phi,pr,sm,ss,st,sb,den,pm,pz,po,int(po<100)])
  for S,p in [(sm,pm),(ss,pz)]:
   slack=c*small-(phi*S)**2*2**(2*(109-p));ck(slack>=0 and 2**p>=max(den,2*sb));legacy_checks+=1
   if p>100:ck(c*small-(phi*S)**2*2**(2*(110-p))<0);legacy_checks+=1
  def olderr(p):return c*((Q-1)*CG)**2-(phi*((Q-1)*int(p<100)+Q*st*8828))**2*2**(2*(108-p))
  ck(olderr(po)>=0 and 2**po>=max(den,2*sb));legacy_checks+=1
  if po>80:ck(olderr(po-1)<0);legacy_checks+=1
  ps['mixed'].append(pm);ps['sharp'].append(pz);ps['combined8828'].append(po);ev.append((c,phi,st,sb,den))
 ck(legacy_checks<=752400);del seen
 phase('Independent explicit node/precision closure of all predecessor alternatives')
 def closure(precisions):
  states=set();stack=[];top=set()
  for src,p in zip(man['conductors'],precisions):
   for n,q in src[5]:top.add(n);stack.append((n,p))
  ck(len(top)==12496);ck(len(stack)<=2257200)
  while stack:
   n,p=stack.pop()
   if (n,p)in states:continue
   states.add((n,p));ck(50<=p<=108 and len(states)<=2189903)
   if choices[n][0]=='split':stack.extend((k,p)for k in choices[n][1:])
  active={n for n,p in states};klens=sorted(n for n in active if choices[n][0]=='bluestein')
  ck(len(active)==32942 and len(klens)==6004 and sum(1<<(2*n-2).bit_length()for n in klens)==337702368)
  keys={(n,p)for n,p in states if choices[n][0]=='bluestein'}
  edges=2*sum(choices[n][0]=='split'for n in active);ck(edges<=74234)
  return states,keys,klens,edges
 def masks(states,floor):
  z=dict.fromkeys(order,0)
  for n,p in states:z[n]|=1<<(p-floor)
  return z
 def stats(pair):
  states,keys,ks,edges=pair
  return (len(states),len(keys),sum(1<<(2*n-2).bit_length()for n,p in keys))
 def comparisons(pair,alts):
  s,k,_,_=pair;out={}
  for label,other in alts.items():
   os,ok,_,_=other
   out[label]=dict(node_projection_intersection=len(s&os),node_only_combined=len(s-os),node_only_old=len(os-s),kernel_projection_intersection=len(k&ok),kernel_only_combined=len(k-ok),kernel_only_old=len(ok-k))
  return out
 def dist(prec,pair,lo):
  counts=Counter(prec);ph=Counter();pr=Counter();kc=Counter();ke=Counter()
  for src,p in zip(man['conductors'],prec):ph[p]+=src[1];pr[p]+=src[2]
  for n,p in pair[1]:kc[p]+=1;ke[p]+=1<<(2*n-2).bit_length()
  return [dict(p=p,conductors=counts[p],phi_total=ph[p],primitive_total=pr[p],kernel_keys=kc[p],kernel_entries=ke[p])for p in range(lo,109)]
 def mult(pair):return cntdict(Counter(n for n,p in pair[1]).values())
 def transitions(target,names):return {k:[[a,b,v]for(a,b),v in sorted(Counter(zip(ps[k],target)).items())]for k in names}
 def drops(target,names):return {k:cntdict(a-b for a,b in zip(ps[k],target))for k in names}
 caches={}
 for label in ['mixed','sharp','combined8828']:
  caches[label]=closure(ps[label]);memory('closure '+label)
 ck(stats(caches['mixed'])==(38147,7606,364355904));ck(stats(caches['sharp'])==(37522,7850,369180928));ck(stats(caches['combined8828'])==(49899,8467,363202368))
 oldmask=masks(caches['combined8828'][0],80);ks=caches['combined8828'][2]
 for n,row in zip(order,oldn['rows']):ck(row[-1]==oldmask[n])
 oldc=load(4);olds=load(5)
 for obj in [oldr,oldn,oldc,olds]:
  eqfields(obj,dict(plan_sha256=planhash,input_contract_sha256=IC,kernel_contract_sha256=KC,assignment_only=True,guard_domain_applicable=True,guard_weights_folded=False,prices_included=False,values_generated=False,production_selected=False),'predecessor scope')
 ck(oldc['schema']=='combined-conductor-precision-kernel-masks-1' and oldc['fields']==['n','P','combined_mask'])
 ck(oldc['rows']==[[n,1<<(2*n-2).bit_length(),oldmask[n]]for n in ks])
 ck(oldc['row_output_sha256']==list(PINS.values())[2][1] and oldc['node_output_sha256']==list(PINS.values())[3][1])
 ck(sha(canon(oldc['input_contract']))==IC and sha(canon(oldc['kernel_contract']))==KC)
 projection=oldc['kernel_projection_fields'];ck(set(projection)==set(oldc['kernel_contract'])-{'id','p_domain','coordinate_grid'})
 projected={k:oldc['kernel_contract'][k]for k in projection};ck(sha(canon(projected))==oldc['kernel_projection_sha256'])
 ck(oldc['legacy_contract_sha256']=='22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884')
 oldcomp=comparisons(caches['combined8828'],{k:caches[k]for k in ['mixed','sharp']})
 ck(oldc['projected_alternative_comparisons']==oldcomp)
 eqfields(olds,dict(schema='combined-conductor-precision-summary-1',precision_distribution=dist(ps['combined8828'],caches['combined8828'],80),transitions=transitions(ps['combined8828'],['mixed','sharp']),bit_drop_distributions=drops(ps['combined8828'],['mixed','sharp']),projected_alternative_comparisons=oldcomp,kernel_precision_multiplicity_histogram=mult(caches['combined8828']),mask_propagation_edges={'mixed':caches['mixed'][3],'sharp':caches['sharp'][3],'combined':caches['combined8828'][3]}),'old summary')
 eqfields(olds,dict(full_nodes=37117,axis_records=13943,conductors=125400,node_precision_memberships=49899,kernel_precision_memberships=8467,kernel_entries=363202368,scaled_cache_complex_rounds=363202368,exact_real_cache_sums=726404736,combined_selector_tests=sum(p-79 for p in ps['combined8828']),max_combined_tests_per_row=max(p-79 for p in ps['combined8828']),legacy_selector_tests=125400+sum(p>100 for p in ps['mixed']),sharp_selector_tests=125400+sum(p>100 for p in ps['sharp']),changed_vs_mixed=sum(a!=b for a,b in zip(ps['mixed'],ps['combined8828'])),changed_vs_sharp=sum(a!=b for a,b in zip(ps['sharp'],ps['combined8828'])),substantive_records=168521,legacy_all_rows_slacks_and_keys_matched=True,sharp_all_rows_slacks_and_keys_matched=True),'old statistics')
 ck(olds['regrid_population_only']['conductors']==sum(p<100 for p in ps['combined8828']))
 ck(olds['regrid_population_only']['phi_sum']==sum(src[1]for src,p in zip(man['conductors'],ps['combined8828'])if p<100))
 ck(olds['artifacts']==[dict(path=Path(rel).name,bytes=PINS[rel][0],sha256=PINS[rel][1])for rel in list(PINS)[2:5]])
 del oldr,oldn,olds
 guard=load(6);ck([s['extra_nodes']for s in guard['scenarios']]==[0,167,320,640]);ck(max(Fraction(s['max_guard_height'])for s in guard['scenarios'])==Fraction(26525,4)<7000);del guard
 phase('Independently locate exact mean186 thresholds by binary search')
 binary_tests=0
 for rid,((c,phi,S,sb,D),po)in enumerate(zip(ev,ps['combined8828'])):
  if rid%4096==0:memory('binary selector checkpoint')
  ck(max(D,2*sb,S)<2**50)
  def slack(p):
   nonlocal binary_tests
   binary_tests+=1;T=1<<p;gap=T-S;ck(gap>0)
   w=(gap if p<100 else 0)+186*S*T
   z=c*(CG*gap)**2-(phi*w)**2*2**(2*(108-p));ck(z.bit_length()<=1024);return z
  lo,hi=50,po-5;ck(slack(hi)>=0)
  while lo<hi:
   mid=(lo+hi)//2
   if slack(mid)>=0:hi=mid
   else:lo=mid+1
  ck(slack(lo)>=0 and (lo==50 or slack(lo-1)<0));ck(lo<=po-5<=100)
  ps['mean186'].append(lo)
 caches['mean186']=closure(ps['mean186']);newmask=masks(caches['mean186'][0],50);newstats=stats(caches['mean186'])
 ck(all(0<=v<2**51 for v in newmask.values()));ck(newstats[0]<=2189903 and newstats[1]<=354236 and newstats[2]<=59*337702368)
 ck(sum(stats(v)[0]for v in caches.values())<=3934402 and sum(stats(v)[1]for v in caches.values())<=636424)
 phase('Bind all four frozen outputs and producer contracts')
 outputs={}
 for (name,spec),cap in zip(OUT.items(),[3,3,2,1]):outputs[name]=read('major-constants/'+name,spec,cap*MIB)
 nr,nn,nc,ns=outputs.values();newI=nc['input_contract'];newK=nc['kernel_contract']
 ih=sha(canon(newI));kh=sha(canon(newK))
 ck(ih=='A8D9ACE2A6375D19DA4C59A996D58D9A88BCE899F5DA619F7B5196EA1E7B593E' and kh=='0EEC8A8EF03B762019B25DE2805FDB9F2184134E3D10CEF2147FA2E4C461E013')
 # A contract digest is checked only after its actual fields are inspected.
 eqfields(newI,dict(id='mean186-full-P20-grid94-assembled-grid100-single-regrid-p50-v1',p_domain=[50,108],original='Exact grid100 sum of admitted full K20 fixed-shape b94/min65 polynomial and separately certified actual grid100 raw head; pointwise |sum|<690.',below100='d=100-p; each signed coordinate n+2^(d-1)=Qout*2^d+t with 0<=t<2^d; nearest ties toward positive infinity.',at100='Identical coordinate integer; zero error.',above100='Exact coordinate left shift p-100; zero error.',complex_radius='rho_p*2^-p, rho_p=1 below100 and zero otherwise; transported once by exact character operator.',magnitudes={'V_error_mean':186,'V_width_pointwise':692},source_radii='Retain complete alpha<2^-82. Actual nonnegative conductor-scaled sums H and J0 each <=2^-63; J0 excludes this new regrid. No cancellation-based substitute.',mean_contract='Actual full input mean+1<175+2c/phi(c)<186, using exact head sum<2c and c/phi<=1001/192. Mean/tight ordered CT and original-fiber exact tensor proof required.',converter_capacities='Conservative signed source115/destination(p+15)/raw116; d<=50, longer remainder/range proof paid. No narrower converter adopted.',domain='|t|<=7000 and actual admitted guard samples; c<=265800; saved large primitive nonprincipal family.',identity='Conductor, exact height, unit order, original source/head/assembly objects, destination p, tie rule, witnesses, radius, proof contract and lifetime.',lifetime='One checked conversion per actual assembled input and distinct sample; no sharing across different values or free rebuild.'),'new input contract')
 ck(set(newI)=={'id','p_domain','original','below100','at100','above100','complex_radius','magnitudes','source_radii','mean_contract','source_proof_pins','converter_capacities','domain','identity','lifetime'})
 ck(newK['id']=='local-u-rounded-normalized-blue-p50-mean186-v1' and newK['p_domain']==[50,108] and newK['coordinate_grid']=='2^-p; kernel object independent of input producer; assembled inputs use the separately bound regrid contract.')
 ck({k:newK[k]for k in projection}==projected and set(newK)==set(oldc['kernel_contract']))
 expectedinputs={k:dict(bytes=v[0],sha256=v[1])for k,v in PINS.items()}
 for o in outputs.values():
  eqfields(o,dict(inputs=expectedinputs,writer_sha256=WRITER,plan_sha256=planhash,predecessor_rows_sha256=list(PINS.values())[2][1],predecessor_nodes_sha256=list(PINS.values())[3][1],predecessor_cache_sha256=list(PINS.values())[4][1],input_contract_sha256=ih,kernel_contract_sha256=kh,assignment_only=True,guard_domain_applicable=True,guard_weights_folded=False,prices_included=False,values_generated=False,production_selected=False,intermediate692_assignment=False,shared_high_adapter=False,narrower_input_converter=False,full_P20_retained=True),'output binding')
  ck(o['support']==ns['support'])
 for rel,pin in ns['support'].items():
  path=AG/rel;ck(path.suffix=='.md' and path.stat().st_size<MIB);ck(sha(path.read_bytes())==pin,'paper pin')
 ck(newI['source_proof_pins']=={k:v for k,v in ns['support'].items()if any(s in k for s in ['MEAN_INPUT_TIGHT','FINITE_EM','FULL_P20','FUTURE_P50'])})
 ck(nr['schema']=='mean186-exact-tensor-rows-1' and nr['fields']==['source_row_id','p_new'])
 ck(nr['rows']==[[i,p]for i,p in enumerate(ps['mean186'])])
 ck(nn['schema']=='mean186-exact-tensor-node-masks-1' and nn['fields']==['predecessor_node_row_id','mask'])
 ck(nn['rows']==[[i,newmask[n]]for i,n in enumerate(order)])
 ck(nc['schema']=='mean186-exact-tensor-kernel-masks-1' and nc['fields']==['predecessor_kernel_row_id','mask'])
 ck(nc['rows']==[[i,newmask[n]]for i,n in enumerate(ks)])
 ck(nc['row_output_sha256']==list(OUT.values())[0][1] and nc['node_output_sha256']==list(OUT.values())[1][1])
 eqfields(nc,dict(predecessor_input_contract_sha256=IC,predecessor_kernel_contract_sha256=KC,kernel_projection_fields=projection,kernel_projection_sha256=sha(canon(projected))),'cache provenance')
 comp=comparisons(caches['mean186'],{k:v for k,v in caches.items()if k!='mean186'})
 ck(nc['projected_alternative_comparisons']==comp)
 allnames=['mixed','sharp','combined8828'];prec=ps['mean186'];distribution=dist(prec,caches['mean186'],50)
 eqfields(ns,dict(schema='mean186-exact-tensor-summary-1',Cg=CG,declared_precision_range=[50,108],input_bytes_read=39456593,all_predecessor_rows_slacks_and_minimality_matched=True,all_predecessor_coefficients_masks_contracts_summary_matched=True,inherited_selector_checks=legacy_checks,selector_tests=sum(p-49 for p in prec),max_tests_per_row=max(p-49 for p in prec),full_nodes=37117,axis_records=13943,conductors=125400,precision_distribution=distribution,transitions=transitions(prec,allnames),bit_drop_distributions=drops(prec,allnames),node_precision_memberships=newstats[0],kernel_precision_memberships=newstats[1],kernel_entries=newstats[2],kernel_precision_multiplicity_histogram=mult(caches['mean186']),baseline_kernel_lengths=6004,baseline_kernel_entries=337702368,extra_kernel_keys=newstats[1]-6004,extra_kernel_entries=newstats[2]-337702368,scaled_cache_complex_rounds=newstats[2],exact_real_cache_sums=2*newstats[2],projected_alternative_comparisons=comp,mask_propagation_edges={k:v[3]for k,v in caches.items()},substantive_records=168521,independent_reconstruction_pending=True),'new summary')
 ck(ns['regrid_population_only']['conductors']==sum(p<100 for p in prec) and ns['regrid_population_only']['phi_sum']==sum(src[1]for src,p in zip(man['conductors'],prec)if p<100))
 ck(ns['artifacts']==[dict(path=k,bytes=v[0],sha256=v[1])for k,v in list(OUT.items())[:3]])
 ck(ns['limits']==dict(input_bytes=64*MIB,per_input_bytes=32*MIB,output_bytes=12*MIB,records=200000,node_memberships=2189903,kernel_memberships=354236,selector_tests=6395400,metadata_integer_bits=1024))
 ck(ns['conservative_record_count']<=200000 and sum(p-49 for p in prec)<=6395400)
 ck(all(0<=v<=1024*MIB for k,v in ns['memory_observations']))
 ck(READ==set(PINS)|{'major-constants/'+k for k in OUT})
 # Per-record and wrapper bounds, without generating a second assignment.
 for o,limit,count in [(nr,13,125400),(nn,27,37117),(nc,26,6004)]:
  ck(len(o['rows'])==count)
  for row in o['rows']:ck(len(json.dumps(row,separators=(',',':')))+1<=limit)
  wrapper={k:v for k,v in o.items()if k!='rows'};wrapper['rows']=[];ck(len(canon(wrapper))+1<=MIB)
 phase('Publish one independent bounded receipt')
 receipt=dict(status='PASS_INDEPENDENT_MEAN186_ASSIGNMENT_RECONSTRUCTION',checks_before_publication=CHECKS,inputs=PINS,author_outputs=OUT,author_writer_sha256=WRITER,own_script_sha256=sha(Path(__file__).read_bytes()),independent_method='Fresh coefficient formulas; exact squared-budget boundary checks; binary search for new minimum; explicit visited node/precision sets for all four cache closures. No author import.',binary_search_slack_tests=binary_tests,author_linear_tests_reconstructed=sum(p-49 for p in prec),precision_range=[min(prec),max(prec)],precision_distribution=distribution,drop_from_combined=drops(prec,['combined8828']),cache_statistics={k:stats(v)for k,v in caches.items()},comparisons=comp,input_contract_sha256=ih,kernel_contract_sha256=kh,conservative_converter_retained=True,prices=False,values=False,builds=False,metadata_inputs_bytes=sum(v[0]for v in PINS.values()),author_output_bytes=sum(v[0]for v in OUT.values()),memory_observations=MEM,source_history='Original author source not executed; diagnostic-only v2 independently cleared, then first authorized run passed. Independent replay is separately recorded.',historical_limits='Original family/analytic and source-proof semantics remain inherited. No guard workload weights, arithmetic price or narrow converter adopted.')
 raw=(json.dumps(receipt,indent=2)+'\n').encode();ck(len(raw)<=MIB);ck(not dest.exists())
 with dest.open('xb')as f:CREATED.append(str(dest));ck(f.write(raw)==len(raw))
 print(json.dumps(dict(status='PASS',checks=CHECKS,receipt_bytes=len(raw),receipt_sha256=sha(raw),range=receipt['precision_range'],states=newstats[0],kernels=newstats[1],entries=newstats[2],binary_tests=binary_tests)),flush=True)
if __name__=='__main__':
 try:main()
 except BaseException as e:
  print(json.dumps(dict(status='FAIL_STOP',phase=PHASE,error=repr(e),checks=CHECKS,created=CREATED)),flush=True)
  raise
