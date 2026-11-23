"""Independent saved combined40 reconstruction. No author imports or values."""
from pathlib import Path
from collections import Counter, defaultdict
from fractions import Fraction as F
import ctypes
from ctypes import wintypes
import gc, hashlib, json, os, re

HERE=Path(__file__).resolve().parent; AG=HERE.parent; MIB=2**20
PREFLIGHT='369F28970D508C5179524F9B5D5019E587BA87B39F2959515029A198F4EF379C'
WRITER='24741DA819AB887FE81A124E66CE2D32C38D868D1987518450D3B47440D1A14B'
OUTPUT_PINS={
 'combined_precision_price_widths_20261111.json':(918045,'51844D5768117F3AA21E9FC8C84FD918D92008E9C51DB41AE742B565FF6F4A2B'),
 'combined_precision_prices_20261111.json':(534809,'17930450145D8507AE4883D923C76E9F3A0FE3C6ABAD28F4BD700AB5ABFCDA7F')}
CHECKS=0;READ_BYTES=0;PEAK=0;MEMORY=[]
def ck(p,s='check'):
 global CHECKS
 if not p:raise AssertionError(s)
 CHECKS+=1
def sha(b):return hashlib.sha256(b).hexdigest().upper()
def canon(o):return json.dumps(o,sort_keys=True,separators=(',',':')).encode()
def integer(s):
 ck(len(s)<=310,'literal length');n=int(s);ck(abs(n).bit_length()<=1024,'integer capacity');return n
def badnum(s):raise AssertionError('noninteger JSON '+s)
class PM(ctypes.Structure):
 _fields_=[('cb',wintypes.DWORD),('faults',wintypes.DWORD)]+[(k,ctypes.c_size_t) for k in ('peakws','ws','peakpaged','paged','peaknonpaged','nonpaged','pagefile','peakpagefile','private')]
def memory(label):
 global PEAK
 ck(os.name=='nt','memory observer');p=PM();p.cb=ctypes.sizeof(p)
 gp=ctypes.windll.kernel32.GetCurrentProcess;gp.restype=ctypes.c_void_p
 f=ctypes.windll.psapi.GetProcessMemoryInfo;f.argtypes=[ctypes.c_void_p,ctypes.POINTER(PM),wintypes.DWORD];f.restype=wintypes.BOOL
 ck(bool(f(gp(),ctypes.byref(p),p.cb)),'memory API');ck(p.private<=2*1024*MIB,'2GiB observed stop')
 PEAK=max(PEAK,p.private);MEMORY.append([label,p.private])
def read(rel,spec,cap=32*MIB):
 global READ_BYTES
 size,pin=spec;path=AG/rel
 ck(path.stat().st_size==size and size<=cap,'input size '+rel);memory('before '+rel)
 with path.open('rb') as f:b=f.read(size+1)
 ck(len(b)==size and sha(b)==pin,'hash '+rel)
 obj=json.loads(b,parse_int=integer,parse_float=badnum,parse_constant=badnum);del b
 READ_BYTES+=size;ck(READ_BYTES<=128*MIB+10*MIB,'input plus outputs cap');memory('after '+rel);return obj

ck(len(OUTPUT_PINS)==2,'frozen author outputs required before execution')
pre=(AG/'moebius/COMBINED_PRECISION_PRICE_PREFLIGHT_2026-11-11.md').read_bytes();ck(sha(pre)==PREFLIGHT)
allow={}
for rel,size,pin in re.findall(r'^\|\s*([^|]+\.json)\s*\|\s*(\d+)\s*\|\s*([A-F0-9]{64})\s*\|$',pre.decode(),re.M):
 rel=rel.strip();rel=rel if '/' in rel else 'major-constants/'+rel;allow[rel]=(int(size),pin)
ck(len(allow)==12 and sum(v[0] for v in allow.values())==73619701)
loaded={}
for rel,spec in allow.items():loaded[rel.rsplit('/',1)[-1]]=read(rel,spec)
man=loaded.pop('transform_structural_manifest_20261111.json');sr=loaded.pop('sharper_conductor_precision_rows_20261111.json')
sc=loaded.pop('sharper_conductor_precision_caches_20261111.json');ss=loaded.pop('sharper_conductor_precision_metadata_20261111.json')
gr=loaded.pop('short_window_guard_conductor_rows_20261111.json');gl=loaded.pop('short_window_guard_ledger_20261111.json')
sw=loaded.pop('sharper_precision_price_widths_20261111.json');sp=loaded.pop('sharper_precision_delta_prices_20261111.json')
cr=loaded.pop('combined_conductor_precision_rows_20261111.json');cn=loaded.pop('combined_conductor_precision_nodes_20261111.json')
cc=loaded.pop('combined_conductor_precision_caches_20261111.json');cs=loaded.pop('combined_conductor_precision_summary_20261111.json');ck(not loaded);del loaded
KEYS=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
CATS=['root','kernel','add','quarter','neg','scale'];META=['conductor_height_nodes','residue_inputs','primitive_outputs'];EXTRAS=[0,167,320,640]
OLD='22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884'
IC='376BBDC2EAC98F5AC3C28AEBFD5D6FAA80DD9989B081E4DA8A8AC79B3F270F91';KC='F40998CB9F4C41271BDD69EAB97FEF5B89D3B3800A72C9525AC4EA393B3628C6'
ck(sha(canon(man['plan'])).lower()==man['canonical_plan_sha256']=='fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b')
ck(len(man['conductors'])==len(sr['rows'])==len(cr['rows'])==len(gr['rows_data'])==125400)
ck(cr['schema']=='combined-conductor-precision-rows-2' and len(cr['fields'])==13)
ck(cr['fields']==['source_row_id','c','phi','primitive','S_mix','S_sharp','S_tight','S_base','D_local_old','p_mix','p_sharp','p_comb','rho'])
ck(cn['fields']==['n','C_mix','D_mix','C_sharp','D_sharp','C_tight','D_tight','combined_mask'])
for obj in (cr,cn,cc,cs):
 ck(obj['plan_sha256']==man['canonical_plan_sha256'] and obj['input_contract_sha256']==IC and obj['kernel_contract_sha256']==KC)
 ck(obj['assignment_only'] is True and obj['guard_domain_applicable'] is True and obj['guard_weights_folded'] is False and obj['prices_included'] is False and obj['values_generated'] is False and obj['production_selected'] is False)
ck(sha(canon(cc['input_contract']))==IC and sha(canon(cc['kernel_contract']))==KC)
ck(sha(canon(sc['contract']))==OLD and cc['legacy_contract_sha256']==OLD)
proj=cc['kernel_projection_fields'];ck(set(proj)==set(sc['contract'])-{'id','p_domain','coordinate_grid'})
oldproj={k:sc['contract'][k] for k in proj};ck({k:cc['kernel_contract'][k] for k in proj}==oldproj and sha(canon(oldproj))==cc['kernel_projection_sha256'])
ck(cc['node_output_sha256']==allow['major-constants/combined_conductor_precision_nodes_20261111.json'][1] and cc['row_output_sha256']==allow['major-constants/combined_conductor_precision_rows_20261111.json'][1])
plan={int(n):v for n,v in man['plan'].items()};dag={(r[0],r[1]):r for r in man['requests']};coeff={r[0]:r for r in cn['rows']}
ck(len(plan)==len(coeff)==37117 and len(dag)==35190)
for n,q,kind,ch,loc,tot in dag.values():
 ck(len(ch)<=3 and len(loc)==len(tot)==5 and all(type(v)is int and v>=0 for v in loc+tot))
 ck(all(cn<n and (cn,cq) in dag and mult>=0 and af>=1 for cn,cq,mult,af in ch))
def bands(N):
 edge=[0,6401,12801,25601,64001,128001];v=[max(0,min(N,b)-a) for a,b in zip(edge,edge[1:])];ck(sum(v)==N);return v
metadata=[{p:[Counter() for i in range(40)] for p in range(lo,109)} for lo in (100,80)]
parts={p:[] for p in range(80,109)};tops=[set(),set()];ops=[Counter() for _ in range(40)];pop=Counter();phis=Counter();prims=Counter();trans=Counter();seeds=0
for rid,(src,sharp,new,g) in enumerate(zip(man['conductors'],sr['rows'],cr['rows'],gr['rows_data'])):
 if rid%2048==0:memory('row'+str(rid))
 c,phi,primitive,H,J,axes,ws=src
 ck(len(sharp)==14 and len(new)==13 and sharp[:4]==new[:4]==[rid,c,phi,primitive])
 sm,sh,st,sb,D,pm,ps,p,rho=new[4:];ck([sm,sh,sb,D,pm,ps]==sharp[4:10])
 ck(10000<c<=265800 and ((c%2==1 and c<=132900) or c%4==0) and 80<=p<ps<=pm<=108 and ps>=100)
 ck(sm==sum(coeff[n][1] for n,q in axes) and sh==sum(coeff[n][3] for n,q in axes) and st==sum(coeff[n][5] for n,q in axes))
 ck(max([1]+[coeff[n][2] for n,q in axes])<=D<=29961461170177 and 0<=st<=sh<=sm<=202305920 and 0<=sb<=424706204)
 rhs=c*(1266*202305920)**2
 ck(sharp[10]==rhs-(2*phi*sh)**2*2**(2*(108-ps))>=0 and sharp[11]==2**ps-D>=0 and sharp[12]==2**ps-2*sb>=0)
 ck(sharp[13] is None if ps==100 else sharp[13]==rhs-(2*phi*sh)**2*2**(2*(109-ps))<0)
 Q=2**52;target=c*((Q-1)*4196258524692480)**2
 def budget(t):return target-phi**2*((Q-1)*int(t<100)+Q*st*8828)**2*2**(2*(108-t))
 ck(rho==int(p<100) and budget(p)>=0 and 2**p>=D and 2**p>=2*sb)
 if p>80:ck(budget(p-1)<0)
 ck(g[:4]==[c,J,phi,primitive] and len(axes)<=18)
 w=[];extra=[]
 for e in EXTRAS:
  a,b=bands(J+e),bands(J+e+41);d=[y-x for x,y in zip(a,b)];ck(sum(d)==41 and min(d)>=0);w+=a;extra+=d
 ck(w==ws and extra==g[5]);both=w+extra;full=kept=1;remaining=phi;per=[0]*5
 for n,q in axes:
  seeds+=1;ck(seeds<=2257200 and remaining%n==0 and (n,q) in dag);remaining//=n
  for j,v in enumerate(dag[n,q][5]):per[j]+=kept*remaining*v
  full*=n;kept*=n if q==0 else n-n//q;tops[0].add((n,ps));tops[1].add((n,p))
 ck(full==phi and kept==primitive and remaining==1 and per==g[4])
 for side,prec in enumerate((ps,p)):
  for i,w in enumerate(both):metadata[side][prec][i].update(conductor_height_nodes=w,residue_inputs=phi*w,primitive_outputs=primitive*w)
 for i,w in enumerate(both):
  for k,v in zip(KEYS,per):ops[i][k]+=v*w
 parts[p].append(rid);pop[p]+=1;phis[p]+=phi;prims[p]+=primitive;trans[ps,p]+=1
ck([[a,b,v] for (a,b),v in sorted(trans.items())]==cs['transitions']['sharp'])
for p in metadata[0]:ck([dict(v) for v in metadata[0][p]]==sw['metadata_by_p'][str(p)])
for i in range(40):
 for k in META:ck(sum(v[i][k] for v in metadata[0].values())==sum(v[i][k] for v in metadata[1].values()))
for si,scenario in enumerate(gl['scenarios']):
 for off,label in ((0,'old_runtime'),(20,'added_runtime')):
  met=sum((v[off+5*si+b] for v in metadata[1].values() for b in range(5)),Counter())
  ck(all(scenario[label][k]==v for k,v in met.items()));ck(dict(sum(ops[off+5*si:off+5*si+5],Counter()))==scenario[label]['operations'])
 for b,ref in enumerate(scenario['added_by_band']):
  met=sum((v[20+5*si+b] for v in metadata[1].values()),Counter());ck(all(ref[k]==v for k,v in met.items()) and dict(ops[20+5*si+b])==ref['operations'])
 ck(F(scenario['max_guard_height'])<=F(26525,4)<7000)
del sr,cr;gc.collect();memory('rows released')

def adder(bits):return 2*((bits+7)//8)+1
def product(a,b):
 x,y=sorted(((a+7)//8,(b+7)//8));return 5*x*y+2*x+1
def prices(tab,mode,forced=None):
 out=[Counter() for _ in range(40)]
 for (p,cat,de,ce,db),ws in tab.items():
  if forced is not None:p=forced
  a=p+14+de;b=p+ce;fee={}
  if cat in ('root','kernel'):
   if mode=='three':raw=a+b+2;mp=product(a+1,b)+2*product(a,b+1);ea=adder(a+1)+2*adder(raw)
   else:raw=a+b+1;mp=4*product(a,b);ea=2*adder(raw)
   fee={cat+'_product':mp,cat+'_exact_add':ea,cat+'_round_add':4*adder(raw+2)}
  elif cat=='add':fee={'add_complex_add':2*adder(a+1)}
  else:ck(cat in ('quarter','neg','scale'))
  for i,w in enumerate(ws):
   for k,v in fee.items():out[i][k]+=w*v
 return out
def pack(rows):
 v=sum(rows,Counter());pr=sum(x for k,x in v.items() if k.endswith('_product'))
 return dict(parts=dict(v),bands=[dict(x) for x in rows],product_core=pr,addition_core=sum(v.values())-pr,core=sum(v.values()))
def views(out):
 result=[]
 for si,e in enumerate(EXTRAS):
  a=out[5*si:5*si+5];b=out[20+5*si:20+5*si+5]
  result.append(dict(extra_nodes=e,old=pack(a),guard=pack(b),joined=pack([x+y for x,y in zip(a,b)])))
 return result
def setup(keys,mode,lo):
 by={str(p):{} for p in range(lo,109)};groups=defaultdict(list);hist=Counter()
 for n,p,P in keys:groups[p].append((n,P));hist[p,(2*n).bit_length()]+=P
 for p,vals in groups.items():
  ck(all(P==1<<(2*n-2).bit_length() and P.bit_length()-1<=18 for n,P in vals))
  entries=sum(P for n,P in vals)
  by[str(p)]=dict(kernel_keys=len(vals),kernel_entries=entries,chirp_entries=sum(n for n,P in vals),scaled_cache_complex_rounds=entries,
   exact_real_cache_sums=2*entries if mode=='three' else 0,
   scaled_cache_round_add_core=sum(4*P*adder(p+(2*n).bit_length()+2) for n,P in vals),scaled_cache_sum_add_core=sum(2*P*adder(p+1) for n,P in vals) if mode=='three' else 0,
   kernel_fft_general_complex_products=sum(P*(P.bit_length()-1)//2-3*P//2+2 for n,P in vals),kernel_fft_complex_add_sub=sum(P*(P.bit_length()-1) for n,P in vals),
   kernel_fft_quarter_turns=sum(P//2-1 for n,P in vals),kernel_fft_negations=0,kernel_fft_dyadic_scales=0)
 totals={k:sum(x.get(k,0) for x in by.values()) for k in set().union(*(x.keys() for x in by.values()))}
 totals['total_added_normalized_setup_add_core']=totals['scaled_cache_round_add_core']+totals['scaled_cache_sum_add_core']
 return dict(totals=totals,by_p=by,exponent_entry_histogram=[[p,e,v] for (p,e),v in sorted(hist.items())])
def expand_cache(seeded,lo):
 # A stack of concrete (node,p) states, independent of the author's downward mask loop.
 done=set();pending=list(seeded)
 while pending:
  n,p=pending.pop()
  if (n,p) in done:continue
  ck(n in plan and lo<=p<=108);done.add((n,p));choice=plan[n]['choice']
  if choice[0]=='split':
   ck(len(choice)==3 and choice[1]*choice[2]==n and all(x<n for x in choice[1:]));pending.extend((x,p) for x in choice[1:])
  ck(len(done)<=1076393)
 masks={n:0 for n in plan};keys=set();records=[];counts={str(p):Counter() for p in range(lo,109)}
 for n,p in sorted(done):
  ch=plan[n]['choice'];kids=[[x,p] for x in ch[1:]] if ch[0]=='split' else [];records.append([n,p,ch,kids])
  masks[n]|=1<<(p-lo);counts[str(p)]['full_plan_states']+=1
  if ch[0]=='split':counts[str(p)]['CT_full_root_table_entry_upper']+=n
  if ch[0]=='bluestein':keys.add((n,p,1<<(2*n-2).bit_length()))
 return done,masks,keys,records,{p:dict(v) for p,v in counts.items()}
sharpstates,sharpmasks,sharpkeys,records,sharpnodes=expand_cache(tops[0],100)
ck(records==sc['full_nodes'] and sorted(map(list,sharpkeys))==sc['kernels'] and len(sharpstates)==37522 and len(sharpkeys)==7850)
ck(sum(P for n,p,P in sharpkeys)==369180928 and sharpnodes==sp['sharp_full_cache_nodes_by_p'])
basekeys={(n,108,P) for n,p,P in sharpkeys};ck(len(basekeys)==6004 and sum(P for n,p,P in basekeys)==337702368)
states,masks,keys,unused,cachenodes=expand_cache(tops[1],80);del unused
ck(len(states)==cs['node_precision_memberships']==49899 and len(keys)==cs['kernel_precision_memberships']==8467 and sum(P for n,p,P in keys)==cs['kernel_entries']==363202368)
ck(all(masks[n]==coeff[n][7] for n in plan) and sum(bool(v) for v in masks.values())==32942)
klens=sorted({n for n,p,P in keys});ck(len(klens)==6004 and cc['rows']==[[n,1<<(2*n-2).bit_length(),masks[n]] for n in klens])
ck({(n,108,P) for n,p,P in keys}==basekeys)
ck({str(k):v for k,v in sorted(Counter(masks[n].bit_count() for n in klens).items())}==cs['kernel_precision_multiplicity_histogram'])
overlap=dict(node_projection_intersection=len(states&sharpstates),node_only_combined=len(states-sharpstates),node_only_old=len(sharpstates-states),kernel_projection_intersection=len(keys&sharpkeys),kernel_only_combined=len(keys-sharpkeys),kernel_only_old=len(sharpkeys-keys))
ck(overlap==cc['projected_alternative_comparisons']['sharp']==cs['projected_alternative_comparisons']['sharp'])
ck(sum(2 for n in plan if masks[n] and plan[n]['choice'][0]=='split')==cs['mask_propagation_edges']['combined'])
setups={tag:{mode:setup(ks,mode,lo) for mode in ('three','four')} for tag,ks,lo in [('sharp',sharpkeys,100),('global',basekeys,100),('combined',keys,80)]}
for mode in ('three','four'):ck(setups['sharp'][mode]==sp['setup_sharp'][mode] and setups['global'][mode]==sp['setup_global_p108'][mode])
for pd in cs['precision_distribution']:
 p=pd['p'];v=setups['combined']['three']['by_p'][str(p)]
 ck((pop[p],phis[p],prims[p])==(pd['conductors'],pd['phi_total'],pd['primitive_total']))
 ck(v.get('kernel_keys',0)==pd['kernel_keys'] and v.get('kernel_entries',0)==pd['kernel_entries'])
for pd in ss['precision_distribution']:
 v=setups['sharp']['three']['by_p'][str(pd['p'])];ck(v.get('kernel_keys',0)==pd['kernel_keys'] and v.get('kernel_entries',0)==pd['kernel_entries'])
sharpwidth={tuple(r[:-1]):r[-1] for r in sw['widths']};ck(len(sharpwidth)==len(sw['widths'])==840)
globalwidth={}
def add(table,key,ws,mult,cap):
 if not mult:return
 ck(mult>0)
 if key not in table:ck(len(table)<cap,'histogram cap');table[key]=[0]*40
 for i,w in enumerate(ws):table[key][i]+=mult*w;ck(abs(table[key][i]).bit_length()<=1024)
for k,w in sharpwidth.items():
 ck(100<=k[0]<=108 and k[1] in CATS and k[3]==int(k[1]=='root') and k[4]==0 and len(w)==40 and min(w)>=0)
 add(globalwidth,k[1:],w,1,133)
ck(len(globalwidth)==133)
allprices={tag:{mode:views(prices(sharpwidth,mode,force)) for mode in ('three','four')} for tag,force in [('sharp',None),('global',108)]}
ck(allprices['sharp']==sp['sharp_prices'] and allprices['global']==sp['global_p108'])
del sc,ss,cn,coeff;gc.collect();memory('comparators passed/released')
print('Independent row, sample, full-cache and sharper/global price gates passed.',flush=True)

# One40 propagation, no author imports or historical phase histograms.
widths={};stats={};processed_total=0
for p,ids in parts.items():
 pending={};created=0
 def put(n,key,ws,mult):
  global created
  if not mult:return
  tab=pending.setdefault(n,{})
  if key not in tab:created+=1;ck(created<=220108,'per-p contexts')
  add(tab,key,ws,mult,220108)
 for rid in ids:
  c,phi,primitive,H,J,axes,w=man['conductors'][rid];ws=w+gr['rows_data'][rid][5];remaining=phi;kept=full=1
  for n,q in axes:
   remaining//=n;put(n,(q,2*full),ws,kept*remaining);full*=n;kept*=n if q==0 else n-n//q
 top=created;ck(top<=52560);memory('seed p'+str(p));processed=blue=0
 def emit(cat,factor,ce,count,ws):
  if not count:return
  f=F(factor);ck(f>0);ceil=(f.numerator+f.denominator-1)//f.denominator;de=(ceil-1).bit_length();key=(cat,de,ce,0)
  ck(key in globalwidth and 0<=de<=54);add(widths,(p,)+key,ws,count,3857)
 def vec(v,factor,ws):
  ck(v[4]==0)
  for cat,count in zip(('root','add','quarter','neg','scale'),v):emit(cat,factor,int(cat=='root'),count,ws)
 def radix(P,factor,ws):
  k=P.bit_length()-1;ck(P==1<<k and k<=18)
  for j in range(1,k+1):
   groups=P//(1<<j);turn=int(j>=2)
   emit('root',(1<<j)*factor,1,P//2-groups*(1+turn),ws);emit('quarter',(1<<j)*factor,0,groups*turn,ws);emit('add',(1<<(j+1))*factor,0,P,ws)
 for n in sorted({n for n,q in dag},reverse=True):
  bucket=pending.pop(n,{})
  for (q,factor),ws in bucket.items():
   processed+=1;processed_total+=1;ck(processed<=220108 and processed_total<=6383132)
   if processed%2048==0:memory('p'+str(p)+' node'+str(processed))
   _,_,kind,ch,local,total=dag[n,q]
   for child,cq,mult,af in ch:put(child,(cq,factor*af),ws,mult)
   if kind=='ct':
    a,b=(2,n//2) if plan[n]['choice'][0]=='radix2' else plan[n]['choice'][1:];vec(local,2*b*factor,ws)
   elif kind=='radix2':radix(n,factor,ws)
   elif kind=='pruned_two':emit('add',4*factor,0,1,ws)
   elif kind=='direct_prime':vec(total,2*n*factor,ws)
   else:
    ck(kind=='bluestein');blue+=1;P=1<<(2*n-2).bit_length();k=P.bit_length()-1
    rad=[P*k//2-3*P//2+2,P*k,P//2-1,0,0];fixed=[2*x+(P if j in (0,4) else 0) for j,x in enumerate(rad)]
    full=[plan[n]['count'][key] for key in KEYS];ck(all(x>=y and (x-y)%2==0 for x,y in zip(full,fixed)))
    pre=[(x-y)//2 for x,y in zip(full,fixed)];post=[x-y-z for x,y,z in zip(total,fixed,pre)];ck(min(post)>=0 and post[1]==post[4]==0)
    vec(pre,2*factor,ws);radix(P,2*factor,ws);emit('kernel',(n+2)*factor,0,P,ws);radix(P,(F(n*(2*n-1),P)+2)*factor,ws);vec(post,2*n*factor,ws)
  del bucket
 ck(not pending and processed==created);stats[p]=dict(rows=len(ids),top=top,processed=processed,blue=blue)
 print('Independent combined partition',p,processed,flush=True);gc.collect();memory('p'+str(p)+' complete')
forget={}
for k,ws in widths.items():add(forget,k[1:],ws,1,133)
ck(forget==globalwidth,'all global133 forty-vectors')
allprices['combined']={mode:views(prices(widths,mode)) for mode in ('three','four')}
for mode in ('three','four'):ck(views(prices(widths,mode,108))==allprices['global'][mode])

nw=read('moebius/combined_precision_price_widths_20261111.json',OUTPUT_PINS['combined_precision_price_widths_20261111.json'],8*MIB)
out=read('moebius/combined_precision_prices_20261111.json',OUTPUT_PINS['combined_precision_prices_20261111.json'],2*MIB)
ck(nw['schema']=='combined-precision-price-widths-1' and out['schema']=='combined-precision-price-receipt-1')
ck(out['source_sha256']==WRITER and out['input_bytes']==73619701)
ck(out['full_cache_states']==49899 and out['full_kernel_keys']==8467 and out['kernel_entries']==363202368)
ck(nw['widths']==[list(k)+[ws] for k,ws in sorted(widths.items())],'all new width40 records')
ck(out['width_classes']==len(widths)<=3857 and out['global_width_classes']==133 and out['total_processed_contexts']==processed_total)
for rec in out['context_stats']:
 p=rec['p'];ck({k:rec[k] for k in ('rows','top','processed','blue')}==stats[p]);ck(stats[p]['top']<=rec['peak_retained']<=stats[p]['processed'])
for p in metadata[1]:ck(nw['metadata_by_p'][str(p)]==[dict(x) for x in metadata[1][p]])
ck(out['sharp_input_metadata_by_p']=={str(p):[dict(x) for x in v] for p,v in metadata[0].items()})
def categories(tab,lo):
 result={str(p):[dict.fromkeys(CATS,0) for _ in range(40)] for p in range(lo,109)}
 for (p,cat,de,ce,db),ws in tab.items():
  for i,w in enumerate(ws):result[str(p)][i][cat]+=w
 return result
newcats=categories(widths,80);oldcats=categories(sharpwidth,100)
ck(nw['normalized_counts_by_p']==newcats and sw['normalized_counts_by_p']==oldcats)
for i in range(40):
 for cat in CATS:ck(sum(v[i][cat] for v in newcats.values())==sum(v[i][cat] for v in oldcats.values()))
 ck(sum(v[i]['scale'] for v in newcats.values())==0)
for tag,field in [('combined','combined_prices'),('sharp','sharp_prices'),('global','global_p108')]:ck(out[field]==allprices[tag],'price '+tag)
for tag,field in [('combined','setup_combined'),('sharp','setup_sharp'),('global','setup_global_p108')]:ck(out[field]==setups[tag],'setup '+tag)
ck(out['combined_full_cache_nodes_by_p']==cachenodes and out['cache_projection_overlap_with_sharp']==overlap)
ck(out['precision_distribution']==cs['precision_distribution'])
conversion={};costs=[Counter() for _ in range(40)]
for p,met in metadata[1].items():
 cells=[]
 for i,m in enumerate(met):
  N=m['residue_inputs'];is_round=int(p<100);is_copy=int(p==100);is_embed=int(p>100)
  v=dict(complex_inputs=N,regrid_complex=is_round*N,coordinate_witnesses=2*is_round*N,signed_witness_additions=4*is_round*N,
   unsigned_addition_core=124*is_round*N,coordinate_value_shifts=2*(1-is_copy)*N,identity_complex=is_copy*N,exact_embedding_complex=is_embed*N,remainder_range_witnesses=2*is_round*N)
  cells.append(v);costs[i].update(v)
 conversion[str(p)]=dict(branch='regrid' if p<100 else ('identity' if p==100 else 'exact_embedding'),shift_bits=abs(100-p),
  source_signed_bits=115,destination_signed_bits=p+15,raw_witness_signed_bits=116 if p<100 else None,remainder_bits=100-p if p<100 else None,weights40=cells)
ck(out['conversion_by_p']==conversion,'all conversion branches and40 counts')
convviews=[]
for si,e in enumerate(EXTRAS):
 item={'extra_nodes':e}
 for view,offsets in [('old',[0]),('guard',[20]),('joined',[0,20])]:
  # Preserve all role keys, including exact zero roles, just as each branch declares them.
  v=Counter()
  for off in offsets:
   for b in range(5):
    for k,x in costs[off+5*si+b].items():v[k]+=x
  item[view]=dict(+v)  # Counter sum in the author also removes zero totals.
  ck(v['regrid_complex']<=v['complex_inputs'])
 ck(item['joined']['complex_inputs']==60254515577760+e*7133015232)
 convviews.append(item)
ck(out['conversion_views']==convviews)
comparisons=[]
for mode in ('three','four'):
 for label,tag in [('global_p108','global'),('sharp_local','sharp')]:
  for si,e in enumerate(EXTRAS):
   for view in ('old','guard','joined'):
    before=allprices[tag][mode][si][view];after=allprices['combined'][mode][si][view];oldset=setups[tag][mode]['totals'];newset=setups['combined'][mode]['totals']
    dp=before['product_core']-after['product_core'];da=before['addition_core']-after['addition_core'];ck(dp>=0 and da>=0)
    comparisons.append(dict(mode=mode,comparator=label,extra_nodes=e,view=view,runtime_product_core_reserve=dp,runtime_addition_core_reserve=da,
     combined_to_prior_core_ratio=str(F(after['core'],before['core'])),new_regrid_unsigned_addition_core=convviews[si][view]['unsigned_addition_core'],
     additional_cold_scale_sum_add_core=newset['total_added_normalized_setup_add_core']-oldset['total_added_normalized_setup_add_core'],
     conservative_sunk_new_scale_sum_add_core=newset['total_added_normalized_setup_add_core'],kernel_fft_deltas={k:newset['kernel_fft_'+k]-oldset['kernel_fft_'+k] for k in KEYS}))
ck(len(comparisons)==48 and out['comparisons']==comparisons)
supportsize=0
for rel,pin in out['support_pins'].items():
 raw=(AG/rel).read_bytes();supportsize+=len(raw);ck(supportsize<=MIB and sha(raw)==pin)
for obj in (nw,out):
 ck(obj['input_pins']=={k:list(v) for k,v in allow.items()} and obj['input_contract_sha256']==IC and obj['kernel_contract_sha256']==KC)
 ck(obj['V_error']==8828 and obj['V_width']==16384 and obj['full_P20'] is True)
 ck(obj['support_pins']==out['support_pins'])
ck(out['historical_phase_validation']=='Inherited from accepted sharp840/predecessor reports; not rerun.')
for field in ('sharp_and_global_all_price_components_matched','sharp_and_global_all_setup_components_matched','every_global_width_weight_conserved','all_input_output_metadata_conserved','new_input_costs_excluded_from_runtime_subtotal'):ck(out[field] is True)
for field in ('production_selected','numerical_evidence','runtime_claim'):ck(out[field] is False)
ck(out['attempt']==1 and out['independent_review_pending'] is True)
for a in out['artifacts']:
 ck((a['bytes'],a['sha256'])==OUTPUT_PINS[a['path']])
rowmax=sum(29*(len(json.dumps([108,*k,ws],separators=(',',':')).encode())+1) for k,ws in globalwidth.items())
wrapper=dict(nw);wrapper['widths']=[];staticcap=len(json.dumps(wrapper,separators=(',',':')).encode())+rowmax+1
ck(out['static_width_encoded_upper_bound']==staticcap and OUTPUT_PINS['combined_precision_price_widths_20261111.json'][0]<=staticcap<=8*MIB)
ck(out['maximum_observed_private_bytes']<=2*1024*MIB)
memory('independent complete')
receipt=dict(scope='Independent full combined40 reconstruction from12 inputs plus two frozen outputs; no author imports, values, new inventories or builds',
 author_source_sha256=WRITER,author_output_pins=OUTPUT_PINS,preflight_sha256=PREFLIGHT,
 input_pins=allow,checks_before_serialization=CHECKS,script_sha256=sha(Path(__file__).read_bytes()),
 context_stats=stats,total_contexts=processed_total,width_classes=len(widths),global_width_classes=133,
 all_global40_weights_match=True,all_price_setup_components_match=True,all_converter_counts_match=True,
 original_guard_provenance='Every-row accepted sharp equality plus recomputed slacks; original-axis derivation inherited from assignment reviews',
 historical_phase_evidence='Inherited accepted chain, not reread or rerun',
 combined_prices=allprices['combined'],combined_setup=setups['combined'],conversion_views=convviews,comparisons=comparisons,
 maximum_observed_private_bytes=PEAK,memory_checkpoints=MEMORY,peak_scope='Observed checkpoints only; retained context order may differ from author',
 author_attempt=1,independent_attempt=1)
raw=(json.dumps(receipt,separators=(',',':'))+'\n').encode();ck(len(raw)<=2*MIB)
dest=HERE/'review_combined_precision_prices_20261111.json'
ck(not dest.exists(),'exclusive review receipt')
with dest.open('xb') as f:ck(f.write(raw)==len(raw),'write')
print(json.dumps(dict(status='INDEPENDENT_PASS',checks=CHECKS,script_sha256=receipt['script_sha256'],receipt_sha256=sha(raw),receipt_bytes=len(raw),
 contexts=processed_total,width_classes=len(widths),maximum_observed_private_bytes=PEAK,main_regrid=convviews[0]['joined'],
 main={mode:allprices['combined'][mode][0]['joined']['core'] for mode in ('three','four')})),flush=True)
