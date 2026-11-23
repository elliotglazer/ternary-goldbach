"""Independent changed-row price reconstruction. No author imports or values."""
from pathlib import Path
from collections import Counter,defaultdict
from fractions import Fraction as F
import hashlib,json,re
HERE=Path(__file__).resolve().parent; AG=HERE.parent
CHECKS=0
PREFLIGHT='A1A4DE5F8EDA0599D8133CB8CC1B79B206F01B40ECCD4B24639FF8159018878B'
AUTHOR={
 'sharper_precision_delta_prices_20261111.py':(30569,'404AC3FD2093DF475C7982CE6BC51D336186A909D9E6E0DDC6BF61B3A4445C58'),
 'sharper_precision_delta_widths_20261111.json':(246912,'3F54E2C59D539575C3764B22A56579DFE73F1B31635D81D68E975EDC7E43AE91'),
 'sharper_precision_price_widths_20261111.json':(320815,'61D422B596A8BA77801CA53CE515A6B94FFE923894FDA931C7593827399A17E4'),
 'sharper_precision_delta_prices_20261111.json':(162624,'4599278B2CCC3EA5A06EB0BE168D5245C53ADF0AF83D06B4ECD4C96F708321A1')}
def ck(v,s='check'):
 global CHECKS
 if not v:raise AssertionError(s)
 CHECKS+=1
def canon(v):return json.dumps(v,sort_keys=True,separators=(',',':')).encode()
def digest(b):return hashlib.sha256(b).hexdigest().upper()
def read_artifact(rel,size,pin):
 path=AG/rel;ck(path.stat().st_size==size and size<=32*2**20,'stat '+rel)
 with path.open('rb') as f:b=f.read(size+1)
 ck(len(b)==size and digest(b)==pin,'bytes/hash '+rel)
 return json.loads(b)
pre=(AG/'moebius/SHARPER_PRECISION_DELTA_PRICE_PREFLIGHT_2026-11-11.md').read_bytes()
ck(digest(pre)==PREFLIGHT,'preflight')
allow={rel:(int(size),pin) for rel,size,pin in re.findall(r'^\|([^|]+\.json)\|(\d+)\|([A-F0-9]{64})\|$',pre.decode(),re.M)}
ck(len(allow)==10 and sum(x[0] for x in allow.values())==85036369,'allowlist')
ck(len(AUTHOR)==4,'frozen author source/three output pins required')
obj={rel:read_artifact(rel,*spec) for rel,spec in allow.items()}
def get(tail):
 hits=[v for k,v in obj.items() if k.endswith('/'+tail)];ck(len(hits)==1,tail);return hits[0]
man=get('transform_structural_manifest_20261111.json'); oldrows=get('conductor_local_precision_rows_20261111.json'); newrows=get('sharper_conductor_precision_rows_20261111.json')
oc=get('conductor_local_precision_caches_20261111.json'); nc=get('sharper_conductor_precision_caches_20261111.json')
summary=get('sharper_conductor_precision_metadata_20261111.json'); guard=get('short_window_guard_conductor_rows_20261111.json'); gl=get('short_window_guard_ledger_20261111.json')
ow=get('conductor_local_precision_price_widths_20261111.json'); op=get('conductor_local_precision_prices_20261111.json')
ck(len(man['conductors'])==len(oldrows['rows'])==len(newrows['rows'])==len(guard['rows_data'])==125400,'row counts')
ck(man['extras']==[0,167,320,640] and man['band_last_indices']==[6400,12800,25600,64000,128000],'bands')
ck(len(man['requests'])==35190 and len(man['plan'])==37117,'node caps')
plan={int(n):v for n,v in man['plan'].items()}; dag={(r[0],r[1]):r for r in man['requests']}
ck(len(dag)==35190,'distinct requests')
for n,q,kind,ch,loc,tot in dag.values():
 ck(len(ch)<=3 and all(cn<n and mult>=0 and af>=1 for cn,cq,mult,af in ch),'descending positive request')
KEYS=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']; CATS=['root','kernel','add','quarter','neg','scale']
CAPS={101:20378,102:17621,103:15680,104:11681,105:8485,106:3851,107:3687,108:32}
TOPS={101:3678,102:3232,103:3060,104:2256,105:1905,106:808,107:920,108:8}
TRANS={101:2116,102:2021,103:1720,104:1033,105:578,106:311,107:920,108:8}
parts={p:[] for p in CAPS}; metadata=[{p:[Counter() for i in range(40)] for p in range(100,109)} for side in range(2)]
ops=[Counter() for _ in range(40)]; assignments=[[],[]]; masks=[{n:0 for n in plan} for side in range(2)]
def bands(length):
 edges=[0,6401,12801,25601,64001,128001]
 out=[max(0,min(length,b)-a) for a,b in zip(edges,edges[1:])];ck(sum(out)==length,'bands fit');return out
for rid,(row,old,new,g) in enumerate(zip(man['conductors'],oldrows['rows'],newrows['rows'],guard['rows_data'])):
 c,phi,prim,H,J,axes,weights=row
 ck(len(old)==12 and old[:5]==[rid,c,phi,prim,axes],'old identity')
 ck(len(new)==14 and new[:4]==[rid,c,phi,prim],'sharp identity')
 sm,sb,dd,p,sl,ds,ps=old[5:]
 ck(new[4]==sm and new[6:9]==[sb,dd,p],'same legacy coefficient/guard')
 ss=new[5];pn=new[9]
 ck(all(type(t)is int for t in old[5:]+new[:13]) and 0<=ss<=sm,'typed rows')
 ck(100<=pn<=p<=108 and new[10]==c*(1266*202305920)**2-(2*phi*ss)**2*2**(2*(108-pn))>=0,'sharp budget')
 ck(new[11]==2**pn-dd>=0 and new[12]==2**pn-2*sb>=0,'sharp safety')
 ck(sl==c*(1266*202305920)**2-(2*phi*sm)**2*2**(2*(108-p))>=0 and ds==2**p-dd>=0 and ps==2**p-2*sb>=0,'old slacks')
 if pn>100:ck(new[13]==c*(1266*202305920)**2-(2*phi*ss)**2*2**(2*(109-pn))<0,'sharp predecessor')
 else:ck(new[13] is None,'no predecessor100')
 if pn!=p:ck(pn==p-1 and p in parts,'one-bit transition');parts[p].append(rid)
 ck(g[:4]==[c,J,phi,prim] and len(axes)<=18,'guard identity')
 w=[];gw=[]
 for e in (0,167,320,640):
  v=bands(J+e);v2=bands(J+e+41);extra=[b-a for a,b in zip(v,v2)];ck(sum(extra)==41 and min(extra)>=0,'guard41');w+=v;gw+=extra
 ck(w==weights and gw==g[5] and len(g[4])==5,'exact weights')
 per=[0]*5;full=kept=1;suffix=phi
 for n,q in axes:
  ck((n,q) in dag and n>=2 and suffix%n==0,'axis binding');suffix//=n
  for j,a in enumerate(dag[n,q][5]):per[j]+=kept*suffix*a
  full*=n;kept*=n if q==0 else n-n//q
  masks[0][n]|=1<<(p-100);masks[1][n]|=1<<(pn-100)
 ck(full==phi and kept==prim and suffix==1 and per==g[4],'outer products')
 for side,prec in enumerate((p,pn)):
  assignments[side].append(prec)
  for i,weight in enumerate(w+gw):metadata[side][prec][i].update(conductor_height_nodes=weight,residue_inputs=phi*weight,primitive_outputs=prim*weight)
 for i,weight in enumerate(w+gw):
  for k,a in zip(KEYS,per):ops[i][k]+=weight*a
ck({p:len(ids) for p,ids in parts.items()}==TRANS,'all transitions')
for p in range(100,109):ck([dict(x) for x in metadata[0][p]]==ow['metadata_by_p'][str(p)],'old input metadata')
for si,sc in enumerate(gl['scenarios']):
 for off,label in ((0,'old_runtime'),(20,'added_runtime')):
  mt=sum((metadata[0][p][off+5*si+b] for p in range(100,109) for b in range(5)),Counter())
  ck(all(sc[label][k]==v for k,v in mt.items()),'guard source totals');ck(dict(sum(ops[off+5*si:off+5*si+5],Counter()))==sc[label]['operations'],'guard ops')
 for b,ref in enumerate(sc['added_by_band']):
  mt=sum((metadata[0][p][20+5*si+b] for p in range(100,109)),Counter());ck(all(ref[k]==v for k,v in mt.items()),'guard band inputs');ck(dict(ops[20+5*si+b])==ref['operations'],'guard band ops')
oldwidth={tuple(r[:-1]):r[-1] for r in ow['widths']};ck(len(oldwidth)==len(ow['widths'])==936,'old width count')
unlabelled={k[1:] for k in oldwidth};ck(len(unlabelled)==133,'global width support')
def add(table,key,weights,mult,cap):
 if mult==0:return
 ck(mult>0,'positive propagation')
 if key not in table:ck(len(table)<cap,'table cap');table[key]=[0]*40
 dst=table[key]
 for i,w in enumerate(weights):dst[i]+=mult*w
# Changed-only propagation. No phase dictionaries, historical histograms or per-gate loop.
delta={};stats={};processed_total=0
for p,ids in parts.items():
 pending={};created=0
 def put(n,key,weights,mult):
  global created
  if not mult:return
  tab=pending.setdefault(n,{})
  if key not in tab:ck(created<CAPS[p],'created cap');created+=1
  add(tab,key,weights,mult,CAPS[p])
 for rid in ids:
  c,phi,prim,H,J,axes,w=man['conductors'][rid];weights=w+guard['rows_data'][rid][5];full=kept=1;suffix=phi
  for n,q in axes:
   suffix//=n;put(n,(q,2*full),weights,kept*suffix);full*=n;kept*=n if q==0 else n-n//q
 top=created;ck(top<=TOPS[p],'top cap');processed=blue=0
 def emit(cat,factor,ce,db,count,weights):
  if not count:return
  z=F(factor);ck(z>0,'factor positive');ceil=(z.numerator+z.denominator-1)//z.denominator;de=(ceil-1).bit_length()
  key=(cat,de,ce,db);ck(key in unlabelled and db==0 and 0<=de<=54,'accepted width key')
  add(delta,(p,)+key,weights,count,1064)
 def vec(v,a,weights):
  ck(v[4]==0,'zero scales')
  for cat,count in zip(('root','add','quarter','neg','scale'),v):emit(cat,a,int(cat=='root'),0,count,weights)
 def radix(length,a,weights):
  k=length.bit_length()-1;ck(1<<k==length and k<=18,'radix bound')
  for j in range(1,k+1):
   copies=length//(1<<j);turn=int(j>=2)
   emit('root',(1<<j)*a,1,0,length//2-copies*(1+turn),weights)
   emit('quarter',(1<<j)*a,0,0,copies*turn,weights)
   emit('add',(1<<(j+1))*a,0,0,length,weights)
 for n in sorted({n for n,q in dag},reverse=True):
  bucket=pending.pop(n,{})
  for (q,a),weights in bucket.items():
   processed+=1;processed_total+=1;ck(processed<=CAPS[p] and processed_total<=81415,'processed caps')
   _,_,kind,ch,loc,total=dag[n,q]
   for cn,cq,mult,af in ch:put(cn,(cq,a*af),weights,mult)
   if kind=='ct':
    r,m=(2,n//2) if plan[n]['choice'][0]=='radix2' else plan[n]['choice'][1:];vec(loc,2*m*a,weights)
   elif kind=='radix2':radix(n,a,weights)
   elif kind=='pruned_two':emit('add',4*a,0,0,1,weights)
   elif kind=='direct_prime':vec(total,2*n*a,weights)
   else:
    ck(kind=='bluestein','known leaf');blue+=1;P=1<<(2*n-2).bit_length();k=P.bit_length()-1
    rv=[P*k//2-3*P//2+2,P*k,P//2-1,0,0];fixed=[2*x+(P if j in (0,4) else 0) for j,x in enumerate(rv)]
    full=[plan[n]['count'][key] for key in KEYS];ck(all(x>=y and (x-y)%2==0 for x,y in zip(full,fixed)),'pre chirp parity')
    pre=[(x-y)//2 for x,y in zip(full,fixed)];post=[x-y-z for x,y,z in zip(total,fixed,pre)];ck(min(post)>=0 and post[1]==post[4]==0,'post chirp')
    vec(pre,2*a,weights);radix(P,2*a,weights);emit('kernel',(n+2)*a,0,0,P,weights);radix(P,(F(n*(2*n-1),P)+2)*a,weights);vec(post,2*n*a,weights)
  del bucket
 ck(not pending and created==processed,'drain');stats[p]=dict(rows=len(ids),top=top,processed=processed,blue=blue)
 print('Independently reconstructed delta partition',p,processed,flush=True)
newwidth={k:list(v) for k,v in oldwidth.items()}
for key,weights in delta.items():
 ck(key in oldwidth,'delta subset key')
 for i,w in enumerate(weights):ck(w<=newwidth[key][i],'nonnegative removal');newwidth[key][i]-=w
for (p,*rest),weights in delta.items():add(newwidth,(p-1,*rest),weights,1,1197)
newwidth={k:v for k,v in newwidth.items() if any(v)}
for k in unlabelled:
 for i in range(40):ck(sum(v[i] for key,v in oldwidth.items() if key[1:]==k)==sum(v[i] for key,v in newwidth.items() if key[1:]==k),'all width-weight conservation')
# Pricing and frozen-output comparisons appended after the author schema freezes.
def adder(bits):return 2*((bits+7)//8)+1
def product(a,b):
 x=(a+7)//8;y=(b+7)//8;return 5*x*y+2*min(x,y)+1
def prices(tab,mode,force=None):
 bb=[Counter() for _ in range(40)];rr={k:[] for k in ('data_magnitude_bits','coefficient_magnitude_bits','raw_magnitude_bits','round_witness_magnitude_bits')}
 for (p,cat,de,ce,db),weights in tab.items():
  if force is not None:p=force
  a=p+14+de
  if cat in ('root','kernel'):
   b=p+ce
   if mode=='three':pr=product(a+1,b)+2*product(a,b+1);raw=a+b+2;ea=adder(a+1)+2*adder(raw)
   else:pr=4*product(a,b);raw=a+b+1;ea=2*adder(raw)
   fees={cat+'_product':pr,cat+'_exact_add':ea,cat+'_round_add':4*adder(raw+2)}
   for k,v in zip(rr,(a,b,raw,raw+2)):rr[k].append(v)
  elif cat=='add':fees={'add_complex_add':2*adder(a+1)}
  else:ck(cat in ('quarter','neg','scale') and (cat!='scale' or not any(weights)),'cheap scopes');fees={}
  for i,w in enumerate(weights):
   for k,v in fees.items():bb[i][k]+=w*v
 return bb,{k:[min(v),max(v)] for k,v in rr.items()}
def pack(bb,off,si):
 rows=bb[off+5*si:off+5*si+5];total=+sum(rows,Counter());pr=sum(v for k,v in total.items() if k.endswith('_product'))
 return dict(parts=dict(total),bands=[dict(r) for r in rows],product_core=pr,addition_core=sum(total.values())-pr,core=sum(total.values()))
def views(bb):
 out=[]
 for si,e in enumerate((0,167,320,640)):
  out.append(dict(extra_nodes=e,old=pack(bb,0,si),guard=pack(bb,20,si),joined=pack([bb[i]+bb[i+20] for i in range(20)],0,si)))
 return out
allprices={};ranges={}
for tag,tab,forced in [('old',oldwidth,None),('baseline',oldwidth,108),('sharp',newwidth,None)]:
 allprices[tag]={};ranges[tag]={}
 for mode in ('three','four'):
  bb,rr=prices(tab,mode,forced);allprices[tag][mode]=views(bb);ranges[tag][mode]=rr
  if tag!='sharp':
   ck(allprices[tag][mode]==op['local_prices' if tag=='old' else 'global_p108'][mode],'every predecessor price component')
# Independent cache closure via precision masks, two accepted assignments only.
CONTRACT='22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884'
ck(digest(canon(man['plan'])).lower()==man['canonical_plan_sha256'],'canonical plan')
cache_nodes=[];cache_keys=[]
for side,source in enumerate((oc,nc)):
 ck(digest(canon(source['contract']))==source['contract_sha256']==CONTRACT,'cache contract')
 ck(source['plan_sha256']==man['canonical_plan_sha256'],'cache plan')
 for n in sorted(plan,reverse=True):
  choice=plan[n]['choice']
  if choice[0]=='split':
   ck(len(choice)==3 and choice[1]*choice[2]==n and all(t<n for t in choice[1:]),'full child')
   for child in choice[1:]:masks[side][child]|=masks[side][n]
 nodes=[];keys=[]
 for n in sorted(plan):
  choice=plan[n]['choice']
  for p in range(100,109):
   if masks[side][n]&(1<<(p-100)):
    ch=[[t,p] for t in choice[1:]] if choice[0]=='split' else []
    nodes.append([n,p,choice,ch])
    if choice[0]=='bluestein':keys.append([n,p,1<<(2*n-2).bit_length()])
 ck(nodes==source['full_nodes'] and keys==source['kernels'],'full cache records')
 ck(len(nodes)==(38147 if side==0 else 37522) and len(keys)==(7606 if side==0 else 7850),'cache caps')
 cache_nodes.append(nodes);cache_keys.append(keys)
ck(len({n for n,p,ch,kids in cache_nodes[1]})==32942,'forget p active nodes')
basekeys=sorted({(n,108,P) for n,p,P in cache_keys[1]})
ck(len(basekeys)==6004 and sum(P for n,p,P in basekeys)==337702368,'baseline projection')
ck(set(basekeys)=={(n,108,P) for n,p,P in cache_keys[0]},'same baseline')
ck(sum(P for n,p,P in cache_keys[1])==369180928,'new entries')
def setup(keys,mode):
 groups=defaultdict(list);eh=Counter()
 for n,p,P in keys:groups[p].append((n,P));eh[p,(2*n).bit_length()]+=P
 by={}
 for p in range(100,109):
  vals=groups[p]
  if not vals:by[str(p)]={};continue
  by[str(p)]=dict(kernel_keys=len(vals),kernel_entries=sum(P for n,P in vals),chirp_entries=sum(n for n,P in vals),scaled_cache_complex_rounds=sum(P for n,P in vals),exact_real_cache_sums=sum(2*P for n,P in vals) if mode=='three' else 0,scaled_cache_round_add_core=sum(P*4*adder(p+(2*n).bit_length()+2) for n,P in vals),scaled_cache_sum_add_core=sum(P*2*adder(p+1) for n,P in vals) if mode=='three' else 0,kernel_fft_general_complex_products=sum(P*(P.bit_length()-1)//2-3*P//2+2 for n,P in vals),kernel_fft_complex_add_sub=sum(P*(P.bit_length()-1) for n,P in vals),kernel_fft_quarter_turns=sum(P//2-1 for n,P in vals),kernel_fft_negations=0,kernel_fft_dyadic_scales=0)
 totals={k:sum(row.get(k,0) for row in by.values()) for k in set().union(*(r.keys() for r in by.values()))};totals['total_added_normalized_setup_add_core']=totals['scaled_cache_round_add_core']+totals['scaled_cache_sum_add_core']
 return dict(totals=totals,by_p=by,exponent_entry_histogram=[[p,e,v] for (p,e),v in sorted(eh.items())])
setups={tag:{mode:setup(keys,mode) for mode in ('three','four')} for tag,keys in [('old',cache_keys[0]),('sharp',cache_keys[1]),('baseline',basekeys)]}
for mode in ('three','four'):
 ck(setups['old'][mode]==op['setup_local'][mode],'old setup all fields');ck(setups['baseline'][mode]==op['setup_baseline'][mode],'p108 setup all fields')
# Author output decoding and final comparisons are added after frozen output pins arrive.
# Bind frozen author bytes, without importing the writer.
ck(len(AUTHOR)==4,'author pin completeness')
aout={}
for name,(size,pin) in AUTHOR.items():
 path=AG/'moebius'/name;ck(path.stat().st_size==size and size<=2*2**20,'author size')
 with path.open('rb') as f:raw=f.read(size+1)
 ck(len(raw)==size and digest(raw)==pin,'author frozen hash')
 if name.endswith('.json'):aout[name]=json.loads(raw)
res=aout['sharper_precision_delta_prices_20261111.json'];dw=aout['sharper_precision_delta_widths_20261111.json'];nw=aout['sharper_precision_price_widths_20261111.json']
ck(res['schema']=='sharper-precision-delta-price-receipt-1' and dw['schema']=='sharper-precision-delta-widths-1' and nw['schema']=='sharper-precision-price-widths-1','output schemas')
ck(dw['widths']==[list(k)+[v] for k,v in sorted(delta.items())],'every delta width/weight')
ck(nw['widths']==[list(k)+[v] for k,v in sorted(newwidth.items())],'every new width/weight')
ck(res['old_width_classes']==936 and res['delta_width_classes']==len(delta)<=1064 and res['sharp_width_classes']==len(newwidth)<=1197 and res['global_width_classes']==133,'class counts')
ck(res['changed_rows']==8707 and res['unchanged_rows']==116693,'change count')
transition=Counter(zip(*assignments));tr=[[p,q,v] for (p,q),v in sorted(transition.items())]
ck(res['transition_rows']==summary['transition_rows']==tr,'all transitions')
for pd in summary['precision_distribution']:
 prec=pd['p'];ids=[i for i,p in enumerate(assignments[1]) if p==prec]
 ck((len(ids),sum(man['conductors'][i][1] for i in ids),sum(man['conductors'][i][2] for i in ids))==(pd['conductors'],pd['phi_total'],pd['primitive_total']),'summary population')
for s in res['context_stats']:
 p=s['old_p'];ck({k:s[k] for k in ('rows','top','processed','blue')}==stats[p],'independent context counts')
 ck(stats[p]['top']<=s['peak_retained']<=stats[p]['processed']<=CAPS[p],'peak bound only')
ck(dw['context_stats']==res['context_stats'] and res['total_processed_contexts']==processed_total<=81415,'context records')
for p in range(100,109):
 ck(nw['metadata_by_p'][str(p)]==[dict(x) for x in metadata[1][p]],'sharp source metadata')
 dm=[Counter() for _ in range(40)]
 for rid in parts.get(p,[]):
  row=man['conductors'][rid]
  for i,w in enumerate(row[-1]+guard['rows_data'][rid][5]):dm[i].update(conductor_height_nodes=w,residue_inputs=row[1]*w,primitive_outputs=row[2]*w)
 ck(dw['metadata_by_old_p'][str(p)]==[dict(x) for x in dm],'changed source metadata')
 for side,tab,out in [(0,oldwidth,ow),(1,newwidth,nw)]:
  counts=[dict.fromkeys(CATS,0) for _ in range(40)]
  for key,weights in tab.items():
   if key[0]==p:
    for i,w in enumerate(weights):counts[i][key[1]]+=w
  ck(out['normalized_counts_by_p'][str(p)]==counts,'all category counts')
 for i in range(40):
  ck(all(sum(metadata[0][q][i][k] for q in range(100,109))==sum(metadata[1][q][i][k] for q in range(100,109)) for k in ('conductor_height_nodes','residue_inputs','primitive_outputs')),'source metadata conservation')
for mode in ('three','four'):
 ck(res['global_p108'][mode]==allprices['baseline'][mode],'all global predecessor output')
 ck(res['conservative_local'][mode]==allprices['old'][mode],'all local predecessor output')
 ck(res['sharp_prices'][mode]==allprices['sharp'][mode],'all sharp prices/components/bands')
 bb,_=prices(newwidth,mode,108);ck(views(bb)==allprices['baseline'][mode],'sharp force108 equality')
 for tag,field in [('old','setup_conservative_local'),('baseline','setup_global_p108'),('sharp','setup_sharp')]:ck(res[field][mode]==setups[tag][mode],'all setup '+tag)
node_sets=[{(n,p) for n,p,ch,kids in ns} for ns in cache_nodes];key_sets=[set(map(tuple,ks)) for ks in cache_keys]
inter=dict(state_intersection_with_legacy=len(node_sets[0]&node_sets[1]),state_only_sharp=len(node_sets[1]-node_sets[0]),state_only_legacy=len(node_sets[0]-node_sets[1]),kernel_intersection_with_legacy=len(key_sets[0]&key_sets[1]),kernel_only_sharp=len(key_sets[1]-key_sets[0]),kernel_only_legacy=len(key_sets[0]-key_sets[1]))
ck(res['cache_intersections']==inter,'all cache intersections')
for k,v in inter.items():ck(nc[k]==summary[k]==v,'inherited cache comparison')
full_counts={}
for p in range(100,109):
 ns=[r for r in cache_nodes[1] if r[1]==p];v={}
 if ns:
  v['full_plan_states']=len(ns);cnt=sum(r[0] for r in ns if r[2][0]=='split')
  if cnt:v['CT_full_root_table_entry_upper']=cnt
 full_counts[str(p)]=v
ck(res['sharp_full_cache_nodes_by_p']==full_counts,'all full-root-table bounds')
comparisons=[]
for mode in ('three','four'):
 for label,tag in [('global_p108','baseline'),('conservative_local','old')]:
  for si,e in enumerate((0,167,320,640)):
   for view in ('old','guard','joined'):
    prior=allprices[tag][mode][si][view];new=allprices['sharp'][mode][si][view]
    ps=setups[tag][mode]['totals'];ns=setups['sharp'][mode]['totals']
    dp=prior['product_core']-new['product_core'];da=prior['addition_core']-new['addition_core'];ck(dp>=0 and da>=0,'nonnegative price reserve')
    comparisons.append(dict(mode=mode,comparator=label,extra_nodes=e,view=view,runtime_product_core_reserve=dp,runtime_addition_core_reserve=da,sharp_to_prior_core_ratio=str(F(new['core'],prior['core'])),additional_cold_scale_sum_add_core=ns['total_added_normalized_setup_add_core']-ps['total_added_normalized_setup_add_core'],conservative_sunk_new_scale_sum_add_core=ns['total_added_normalized_setup_add_core'],kernel_fft_deltas={k:ns['kernel_fft_'+k]-ps['kernel_fft_'+k] for k in KEYS}))
ck(res['comparisons']==comparisons and len(comparisons)==48,'all comparisons')
for out in (dw,nw,res):ck(out['input_pins']=={k:list(v) for k,v in allow.items()} and out['contract_sha256']==CONTRACT,'provenance')
ck(res['input_bytes']==85036369 and res['source_sha256']==AUTHOR['sharper_precision_delta_prices_20261111.py'][1],'writer/bytes binding')
ck(res['historical_full_phase_comparison']=='Inherited from A38579F3; not rerun in changed-row successor.','inherited phase scope')
ck(res['old_prices_and_setup_matched'] is True and res['componentwise_removal_nonnegative'] is True and res['global_width_and_category_conservation'] is True,'verified flags')
ck(res['production_selected'] is False and res['numerical_evidence'] is False and res['runtime_claim'] is False,'no production claim')
for item in res['artifacts']:
 size,pin=AUTHOR[item['path']];ck(item['bytes']==size and item['sha256']==pin,'output cross-binding')
receipt=dict(scope='Independent changed-row context, width, price and cache reconstruction; historical full-phase evidence inherited, not rerun. No author imports, new plans/inventories, numerical values/builds/proof emission.',checks_before_serialization=CHECKS,script_sha256=digest(Path(__file__).read_bytes()),preflight_sha256=PREFLIGHT,author_pins=AUTHOR,input_pins=allow,changed_rows=8707,processed_contexts=stats,total_processed_contexts=processed_total,delta_width_classes=len(delta),sharp_width_classes=len(newwidth),all_width_weights_match=True,all_predecessor_and_sharp_prices_match=True,all_cache_objects_and_setup_match=True,historical_full_phase_comparison='Inherited A38579F3, not rerun',peak_scope='Author peak retained bounded by independently reconstructed top/processed counts; exact dictionary-order peak not reproduced',sharp_prices=allprices['sharp'],sharp_setup=setups['sharp'],comparisons=comparisons)
raw=(json.dumps(receipt,separators=(',',':'))+'\n').encode();ck(len(raw)<=2*2**20,'own receipt cap')
out=HERE/'review_sharper_precision_delta_prices_20261111.json'
with out.open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=CHECKS,script_sha256=receipt['script_sha256'],receipt_sha256=digest(raw),bytes=len(raw),contexts=processed_total,delta_classes=len(delta),sharp_classes=len(newwidth),main={mode:allprices['sharp'][mode][0]['joined']['core'] for mode in ('three','four')})),flush=True)
