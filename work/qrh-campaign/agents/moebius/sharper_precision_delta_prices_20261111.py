"""Approved changed-row integer price fold; no evaluator or author imports."""
from pathlib import Path
from collections import Counter
from fractions import Fraction as F
import hashlib
import json

HERE=Path(__file__).resolve().parent
AG=HERE.parent
PINS={
 'integration/transform_structural_manifest_20261111.json':(25110201,'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'),
 'major-constants/conductor_local_precision_rows_20261111.json':(21933038,'B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7'),
 'major-constants/conductor_local_precision_caches_20261111.json':(1902325,'95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584'),
 'integration/sharper_conductor_precision_rows_20261111.json':(20920838,'8FD72DC7FD9EACCCF986BE92502AE13491F974744C9E6A6E32BD63ADC27ED085'),
 'integration/sharper_conductor_precision_caches_20261111.json':(1871369,'129ADFCF668378CA94140DB27F3A3D6EF43995E05EB1413D3BE8AC603061D831'),
 'integration/sharper_conductor_precision_metadata_20261111.json':(5188,'8CEA147C264CC963CAE2EBAFE58F32E4CCD53A99378D7403161510993862227F'),
 'integration/short_window_guard_conductor_rows_20261111.json':(12794207,'A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA'),
 'integration/short_window_guard_ledger_20261111.json':(41665,'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4'),
 'moebius/conductor_local_precision_price_widths_20261111.json':(353684,'588474ECF8B628607ADC279BC429BC7CBAA3125CC2AEAB5D7F9708E66CDD48FB'),
 'moebius/conductor_local_precision_prices_20261111.json':(103854,'B1684F0328BC70E2B59D88975489D31161081A3082F1AFF176D527E7741E9D53'),
}
SUPPORT={
 'moebius/SHARPER_PRECISION_DELTA_PRICE_PREFLIGHT_2026-11-11.md':'A1A4DE5F8EDA0599D8133CB8CC1B79B206F01B40ECCD4B24639FF8159018878B',
 'prime-estimates/REVIEW_SHARPER_PRECISION_DELTA_PRICE_PREFLIGHT_2026-11-11.md':'BC617929EA84F98AB20C61E866E605B238C848E66EDCBB4997E9034F21501B3D',
 'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_PRICE_PASS_2026-11-11.md':'A38579F31FB684517AE4CAA83256E70C9A4CB862D7CE17750FE7A4F5898F15D1',
 'major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'F213CB6BC227DFE0C5A25DD92B3DE6405165E7281678EA9224596EE7704FCF39',
}
NAMES=['sharper_precision_delta_widths_20261111.json','sharper_precision_price_widths_20261111.json','sharper_precision_delta_prices_20261111.json']
CONTRACT='22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884'
KEYS=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
CATS=['root','kernel','add','quarter','neg','scale']
META=['conductor_height_nodes','residue_inputs','primitive_outputs']
EXTRAS=[0,167,320,640];ENDS=[6400,12800,25600,64000,128000]
ROW_CAPS=dict(zip(range(101,109),[2116,2021,1720,1033,578,311,920,8]))
TOP_CAPS=dict(zip(range(101,109),[3678,3232,3060,2256,1905,808,920,8]))
CTX_CAPS=dict(zip(range(101,109),[20378,17621,15680,11681,8485,3851,3687,32]))
CHECKS=0;READ_BYTES=0;READ_NAMES=set()

def ck(ok,label='check'):
    global CHECKS
    if not ok:raise AssertionError(label)
    CHECKS+=1
def canonical(x):return json.dumps(x,sort_keys=True,separators=(',',':')).encode()
def read(rel):
    global READ_BYTES
    ck(rel in PINS and rel not in READ_NAMES,'allowlisted single read')
    size,pin=PINS[rel];path=AG/rel
    ck(size<=32*1024**2 and path.stat().st_size==size,'input size')
    ck(READ_BYTES+size<=128*1024**2,'aggregate input size')
    with path.open('rb') as f:raw=f.read(size+1)
    ck(len(raw)==size and hashlib.sha256(raw).hexdigest().upper()==pin,'input hash')
    READ_BYTES+=size;READ_NAMES.add(rel)
    return json.loads(raw)
def bump(table,key,weights,mult,cap):
    if not mult:return
    if key not in table:
        ck(len(table)<cap,'record cap');table[key]=[0]*40
    target=table[key]
    for i,w in enumerate(weights):target[i]+=mult*w
def fresh_meta():return {p:[Counter() for _ in range(40)] for p in range(100,109)}
def add_meta(table,p,weights,phi,primitive):
    for i,w in enumerate(weights):
        for k,v in zip(META,[w,w*phi,w*primitive]):table[p][i][k]+=v
def bands(count):
    out=[];lo=0
    for hi in ENDS:out.append(max(0,min(count,hi+1)-lo));lo=hi+1
    ck(sum(out)==count);return out
def clog(x):
    x=F(x);ck(x>0)
    return ((x.numerator+x.denominator-1)//x.denominator-1).bit_length()
def A(a):return 2*((a+7)//8)+1
def M(a,b):
    x,y=(a+7)//8,(b+7)//8
    return 5*x*y+2*min(x,y)+1

for name in NAMES:ck(not (HERE/name).exists(),'exclusive output precheck')
for rel,pin in SUPPORT.items():
    ck((AG/rel).stat().st_size<=128*1024)
    ck(hashlib.sha256((AG/rel).read_bytes()).hexdigest().upper()==pin)
ck(sum(s for s,h in PINS.values())==85036369)
m=read('integration/transform_structural_manifest_20261111.json')
old_rows=read('major-constants/conductor_local_precision_rows_20261111.json')
old_cache=read('major-constants/conductor_local_precision_caches_20261111.json')
new_rows=read('integration/sharper_conductor_precision_rows_20261111.json')
new_cache=read('integration/sharper_conductor_precision_caches_20261111.json')
new_summary=read('integration/sharper_conductor_precision_metadata_20261111.json')
guard_rows=read('integration/short_window_guard_conductor_rows_20261111.json')
guard=read('integration/short_window_guard_ledger_20261111.json')
old_width_file=read('moebius/conductor_local_precision_price_widths_20261111.json')
old_price=read('moebius/conductor_local_precision_prices_20261111.json')
ck(READ_NAMES==set(PINS) and READ_BYTES==85036369)
ck(m['schema']=='selected-transform-structural-manifest-1')
ck(m['conductor_fields']==['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'])
ck(m['request_fields']==['n','q','kind','children_n_q_multiplicity_normfactor','local_five_counts','five_counts'])
ck(m['extras']==guard_rows['extras']==EXTRAS and m['band_last_indices']==guard_rows['band_last_indices']==ENDS)
ck(len(m['conductors'])==len(old_rows['rows'])==len(new_rows['rows'])==len(guard_rows['rows_data'])==125400)
ck(len(m['requests'])==35190 and len(m['plan'])==37117)
ck(old_rows['schema']=='conductor-local-precision-rows-1')
ck(old_rows['fields']==['source_row_id','c','phi','primitive','ordered_axes_n_q','S_mixed','S_old','D_local','p','squared_budget_slack','D_slack','peak_slack'])
ck(new_rows['schema']=='sharper-conductor-precision-rows-1')
ck(new_rows['fields']==['source_row_id','c','phi','primitive','S_mix','S_sharp','S_base','D_local_old','p_mix','p_sharp','budget_slack','D_slack','peak_slack','previous_budget_slack_or_null'])
ck(old_width_file['schema']=='conductor-local-precision-price-widths-1' and old_price['schema']=='conductor-local-precision-price-receipt-1')
ck(old_width_file['fields']==['p','category','data_ceiling_exponent','coefficient_exponent','division_bits','old20_then_guard20_weights'])
ck(old_width_file['weight_order']==dict(views=['old','guard'],extras=EXTRAS,band_last_indices=ENDS))
ck(old_width_file['metadata_fields']==META)
ck(old_price['width_artifact']['sha256']==PINS['moebius/conductor_local_precision_price_widths_20261111.json'][1])
ck(old_price['predecessor_full_histograms_matched'] is True and old_price['p108_all_components_and_setup_matched'] is True)
plan=m['plan'];plan_hash=hashlib.sha256(canonical(plan)).hexdigest()
ck(plan_hash==m['canonical_plan_sha256'])
for obj in (old_rows,old_cache,new_rows,new_cache,new_summary,old_width_file,old_price):ck(obj['contract_sha256']==CONTRACT)
for obj in (old_rows,old_cache,new_rows,new_cache):
    ck(obj['inputs']['integration/transform_structural_manifest_20261111.json']==dict(bytes=PINS['integration/transform_structural_manifest_20261111.json'][0],sha256=PINS['integration/transform_structural_manifest_20261111.json'][1]))
for obj in (new_rows,new_cache,new_summary):
    ck(obj['plan_sha256']==plan_hash and obj['guard_domain_applicable'] is True)
    ck(obj['guard_weights_folded'] is False and obj['prices_included'] is False)
ck(new_rows['legacy_assignment_sha256']==new_cache['legacy_assignment_sha256']==PINS['major-constants/conductor_local_precision_rows_20261111.json'][1])
ck(new_cache['sharp_assignment_sha256']==PINS['integration/sharper_conductor_precision_rows_20261111.json'][1])
ck(old_cache['contract']==new_cache['contract'] and hashlib.sha256(canonical(old_cache['contract'])).hexdigest().upper()==CONTRACT)
ck(guard_rows['manifest_sha256']==PINS['integration/transform_structural_manifest_20261111.json'][1] and guard_rows['categories']==KEYS)
dag={}
for r in m['requests']:
    ck(len(r)==6)
    n,q,kind,children,local,total=r
    ck(type(n) is int and n>=2 and type(q) is int and q>=0 and (n,q) not in dag)
    ck(len(children)<=3 and len(local)==len(total)==5)
    ck(all(type(v) is int and v>=0 for v in local+total))
    for ch in children:
        ck(len(ch)==4 and all(type(v) is int for v in ch))
        cn,cq,mult,af=ch;ck(2<=cn<n and cq>=0 and mult>=0 and af>=1)
    dag[n,q]=r
for r in dag.values():ck(all((cn,cq) in dag for cn,cq,mult,af in r[3]))
ordered_n=sorted({n for n,q in dag},reverse=True)
old_widths={};global_widths={}
for p,cat,de,ce,db,weights in old_width_file['widths']:
    key=(p,cat,de,ce,db)
    ck(all(type(x) is int for x in [p,de,ce,db]) and 100<=p<=108 and 0<=de<=54 and db==0)
    ck(cat in CATS and (cat!='root' or ce==1) and (cat!='kernel' or ce==0))
    ck(len(weights)==40 and all(type(x) is int and x>=0 for x in weights) and key not in old_widths)
    old_widths[key]=weights
    bump(global_widths,key[1:],weights,1,133)
ck(len(old_widths)==old_price['local_width_classes']==936 and len(global_widths)==133)

old_meta=fresh_meta();sharp_meta=fresh_meta();delta_meta=fresh_meta()
changed={p:[] for p in ROW_CAPS};transition=Counter();old_top=set();sharp_top=set()
old_perheight_ops=[Counter() for _ in range(40)]
new_pop=Counter();new_phi=Counter();new_primitive=Counter()
for rid,(row,orr,nrr,grr) in enumerate(zip(m['conductors'],old_rows['rows'],new_rows['rows'],guard_rows['rows_data'])):
    c,phi,primitive,H,J,axes,weights=row
    ck(len(orr)==12 and orr[:5]==[rid,c,phi,primitive,axes])
    ck(len(nrr)==14 and nrr[:4]==[rid,c,phi,primitive])
    Sm,Ss,Sb,D,po,pn,budget,ds,peak,prev=nrr[4:]
    ck(all(type(v) is int for v in [c,phi,primitive,H,J,Sm,Ss,Sb,D,po,pn,budget,ds,peak]))
    ck(Sm==orr[5] and [Sb,D,po]==orr[6:9])
    ck(10000<c<=265800 and ((c%2==1 and c<=132900) or c%4==0))
    ck(1<=phi<=265800 and 1<=len(axes)<=18 and 100<=pn<=po<=108)
    ck(0<=Ss<=Sm<=202305920 and 0<=Sb<=424706204 and 1<=D<=29961461170177)
    rhs=c*(1266*202305920)**2
    ck(orr[9]==rhs-(2*phi*Sm)**2*2**(2*(108-po))>=0)
    ck(orr[10]==2**po-D>=0 and orr[11]==2**po-2*Sb>=0)
    ck(budget==rhs-(2*phi*Ss)**2*2**(2*(108-pn))>=0)
    ck(ds==2**pn-D>=0 and peak==2**pn-2*Sb>=0)
    if pn==100:ck(prev is None)
    else:ck(type(prev) is int and prev==rhs-(2*phi*Ss)**2*2**(2*(109-pn))<0)
    ck(po-pn in (0,1),'one-bit method scope')
    transition[po,pn]+=1;new_pop[pn]+=1;new_phi[pn]+=phi;new_primitive[pn]+=primitive
    gc,gJ,gphi,gprim,ops,gws=grr
    ck([gc,gJ,gphi,gprim]==[c,J,phi,primitive])
    ck(len(weights)==len(gws)==20 and len(ops)==5)
    ck(all(type(x) is int and x>=0 for x in weights+gws+ops))
    before_all=[];delta_all=[]
    for e in EXTRAS:
        before=bands(J+e);after=bands(J+e+41);delta=[v-u for u,v in zip(before,after)]
        ck(sum(delta)==41 and min(delta)>=0)
        before_all+=before;delta_all+=delta
    ck(before_all==weights and delta_all==gws)
    suffix=phi;kept=full=1;ph=[0]*5
    for n,q in axes:
        ck(type(n) is int and type(q) is int and n>=2 and (n,q) in dag)
        ck(suffix%n==0 and (q==0 or (q>0 and n%q==0)))
        suffix//=n
        for i,v in enumerate(dag[n,q][5]):ph[i]+=kept*suffix*v
        kept*=n if q==0 else n-n//q;full*=n
        old_top.add((n,po));sharp_top.add((n,pn))
    ck(full==phi and kept==primitive and suffix==1 and ph==ops)
    both=weights+gws
    add_meta(old_meta,po,both,phi,primitive);add_meta(sharp_meta,pn,both,phi,primitive)
    if po!=pn:
        ck(po in changed and len(changed[po])<ROW_CAPS[po]);changed[po].append(rid)
        add_meta(delta_meta,po,both,phi,primitive)
    for i,w in enumerate(both):
        for k,v in zip(KEYS,ops):old_perheight_ops[i][k]+=w*v
ck(sum(map(len,changed.values()))==8707 and sum(transition[p,p] for p in range(100,109))==116693)
ck([[p,q,v] for (p,q),v in sorted(transition.items())]==new_summary['transition_rows'])
for p,ids in changed.items():ck(len(ids)==ROW_CAPS[p])
for p in range(100,109):
    ck([dict(x) for x in old_meta[p]]==old_width_file['metadata_by_p'][str(p)])
    for i in range(40):
        for k in META:
            retained=old_meta[p][i][k]-delta_meta[p][i][k];ck(retained>=0)
            incoming=delta_meta[p+1][i][k] if p<108 else 0
            ck(retained+incoming==sharp_meta[p][i][k])
for i in range(40):
    for k in META:ck(sum(old_meta[p][i][k] for p in old_meta)==sum(sharp_meta[p][i][k] for p in sharp_meta))
for pd in new_summary['precision_distribution']:
    p=pd['p'];ck((new_pop[p],new_phi[p],new_primitive[p])==(pd['conductors'],pd['phi_total'],pd['primitive_total']))
for si,sc in enumerate(guard['scenarios']):
    for offset,label in ((0,'old_runtime'),(20,'added_runtime')):
        meta=sum((old_meta[p][offset+5*si+b] for p in old_meta for b in range(5)),Counter())
        for k,v in meta.items():ck(v==sc[label][k])
        ck(dict(sum(old_perheight_ops[offset+5*si:offset+5*si+5],Counter()))==sc[label]['operations'])
    ck(F(sc['max_guard_height'])<=F(26525,4)<7000)
del old_rows,new_rows
print('Full row/guard join and exact 8707 one-bit transition gate passed.',flush=True)

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
            for k,v in fee.items():out[i][k]+=w*v
    return out
def packed(bands,si):
    subset=bands[5*si:5*si+5];parts=sum(subset,Counter())
    prod=sum(v for k,v in parts.items() if k.endswith('_product'))
    return dict(parts=dict(parts),bands=[dict(x) for x in subset],product_core=prod,
                addition_core=sum(parts.values())-prod,core=sum(parts.values()))
def all_views(bands):
    joint=[x+y for x,y in zip(bands[:20],bands[20:])]
    return [dict(extra_nodes=e,old=packed(bands[:20],i),guard=packed(bands[20:],i),joined=packed(joint,i)) for i,e in enumerate(EXTRAS)]
old_prices={};global_prices={}
for mode in ('three','four'):
    old_prices[mode]=all_views(price(old_widths,mode))
    global_prices[mode]=all_views(price(old_widths,mode,108))
    ck(old_prices[mode]==old_price['local_prices'][mode],'complete old local components')
    ck(global_prices[mode]==old_price['global_p108'][mode],'complete p108 components')

def validate_cache(obj,top,states_count,keys_count,expected_schema):
    ck(obj['schema']==expected_schema and obj['plan_sha256']==plan_hash)
    ck(obj['full_node_fields']==['n','p','saved_choice','ordered_child_n_p'] and obj['kernel_fields']==['n','p','P'])
    ck(len(obj['full_nodes'])==states_count and len(obj['kernels'])==keys_count)
    states={};children_seen=set();by_p={p:Counter() for p in range(100,109)}
    for n,p,choice,children in obj['full_nodes']:
        ck(type(n) is int and type(p) is int and 100<=p<=108 and (n,p) not in states)
        ck(choice==plan[str(n)]['choice'])
        expected=[] if choice[0]!='split' else [[d,p] for d in choice[1:]]
        ck(children==expected and len(children)<=2 and all(2<=d<n for d,pp in children))
        states[n,p]=choice;children_seen.update(tuple(x) for x in children)
        by_p[p]['full_plan_states']+=1
        if choice[0]=='split':by_p[p]['CT_full_root_table_entry_upper']+=n
    ck(top<=set(states) and children_seen<=set(states) and set(states)==top|children_seen)
    keys={(n,p,1<<(2*n-2).bit_length()) for (n,p),ch in states.items() if ch[0]=='bluestein'}
    ck(len(keys)==keys_count and keys==set(map(tuple,obj['kernels'])))
    ck(len({n for n,p in states})==32942 and len({n for n,p,P in keys})==6004)
    return states,keys,{str(p):dict(x) for p,x in by_p.items()}
old_states,old_keys,old_cache_nodes=validate_cache(old_cache,old_top,38147,7606,'conductor-local-precision-caches-1')
ck(old_cache_nodes==old_price['full_cache_nodes_by_p'])
base_keys={(n,108,P) for n,p,P in old_keys}
ck(len(base_keys)==6004 and sum(P for n,p,P in base_keys)==337702368)
def setup(keys,mode):
    total=Counter();by_p={p:Counter() for p in range(100,109)};hist=Counter()
    for n,p,P in sorted(keys):
        k=P.bit_length()-1;ck(k<=18 and P==1<<(2*n-2).bit_length())
        e=(2*n).bit_length();hist[p,e]+=P
        values=dict(kernel_keys=1,kernel_entries=P,chirp_entries=n,scaled_cache_complex_rounds=P,
          exact_real_cache_sums=2*P if mode=='three' else 0,scaled_cache_round_add_core=P*4*A(p+e+2),
          scaled_cache_sum_add_core=P*2*A(p+1) if mode=='three' else 0,
          kernel_fft_general_complex_products=P*k//2-3*P//2+2,kernel_fft_complex_add_sub=P*k,
          kernel_fft_quarter_turns=P//2-1,kernel_fft_negations=0,kernel_fft_dyadic_scales=0)
        for key,value in values.items():total[key]+=value;by_p[p][key]+=value
    total['total_added_normalized_setup_add_core']=total['scaled_cache_round_add_core']+total['scaled_cache_sum_add_core']
    return dict(totals=dict(total),by_p={str(p):dict(x) for p,x in by_p.items()},exponent_entry_histogram=[[p,e,v] for (p,e),v in sorted(hist.items())])
old_setup={};global_setup={}
for mode in ('three','four'):
    old_setup[mode]=setup(old_keys,mode);global_setup[mode]=setup(base_keys,mode)
    ck(old_setup[mode]==old_price['setup_local'][mode],'full old cache setup')
    ck(global_setup[mode]==old_price['setup_baseline'][mode],'full p108 cache setup')
print('All accepted 936-class local and p108 component/setup comparisons matched.',flush=True)

delta_widths={};context_stats=[];processed_total=0
for po,ids in changed.items():
    by_n={};created=processed=live=peak=blue=0
    def context(n,key,weights,mult):
        global created,live,peak
        if not mult:return
        tab=by_n.setdefault(n,{})
        if key not in tab:
            ck(created<CTX_CAPS[po],'per-old-p context cap')
            tab[key]=[0]*40;created+=1;live+=1;peak=max(peak,live)
        dst=tab[key]
        for i,w in enumerate(weights):dst[i]+=mult*w
    for rid in ids:
        c,phi,primitive,H,J,axes,weights=m['conductors'][rid]
        both=weights+guard_rows['rows_data'][rid][-1];suffix=phi;kept=full=1
        for n,q in axes:
            suffix//=n;context(n,(q,2*full),both,kept*suffix)
            kept*=n if q==0 else n-n//q;full*=n
    top_count=created;ck(top_count<=TOP_CAPS[po])
    def emit(cat,phase,n,j,a,ce,db,count,weights):
        if not count:return
        de=clog(a);ck(0<=de<=54 and db==0 and (cat,de,ce,db) in global_widths)
        bump(delta_widths,(po,cat,de,ce,db),weights,count,1064)
    def emitvec(vec,phase,n,a,weights):
        for i,count in enumerate(vec):
            ck(i!=4 or count==0)
            emit(('root','add','quarter','neg','scale')[i],phase,n,0,a,1 if i==0 else 0,0,count,weights)
    def stages(P,a,phase,weights):
        k=P.bit_length()-1;ck(k<=18)
        for j in range(1,k+1):
            copies=P//(1<<j);quarter=int(j>=2)
            emit('root',phase,P,j,(1<<j)*a,1,0,copies*((1<<(j-1))-1-quarter),weights)
            emit('quarter',phase,P,j,(1<<j)*a,0,0,copies*quarter,weights)
            emit('add',phase,P,j,(1<<(j+1))*a,0,0,P,weights)
    for n in ordered_n:
        bucket=by_n.pop(n,{})
        while bucket:
            (q,a),weights=bucket.popitem();live-=1;processed+=1;processed_total+=1
            ck(processed<=CTX_CAPS[po] and processed_total<=81415)
            _,_,kind,children,local,total=dag[n,q]
            for cn,cq,mult,af in children:context(cn,(cq,a*af),weights,mult)
            if kind=='bluestein':
                blue+=1;P=1<<(2*n-2).bit_length();k=P.bit_length()-1;ck(k<=18)
                rad=[P*k//2-3*P//2+2,P*k,P//2-1,0,0]
                base=[2*x+(P if i in (0,4) else 0) for i,x in enumerate(rad)]
                full=[plan[str(n)]['count'][key] for key in KEYS]
                ck(all(x>=y and (x-y)%2==0 for x,y in zip(full,base)))
                pre=[(x-y)//2 for x,y in zip(full,base)]
                post=[x-y-z for x,y,z in zip(total,base,pre)]
                ck(all(x>=0 for x in post) and post[1]==post[4]==0)
                emitvec(pre,'blue_pre_chirp',n,2*a,weights);stages(P,2*a,'blue_forward',weights)
                emit('kernel','blue_point',n,0,(n+2)*a,0,0,P,weights)
                stages(P,(F(n*(2*n-1),P)+2)*a,'blue_inverse',weights)
                emitvec(post,'blue_post_chirp',n,2*n*a,weights)
            elif kind=='ct':
                r,mm=(2,n//2) if plan[str(n)]['choice'][0]=='radix2' else plan[str(n)]['choice'][1:]
                emitvec(local,'ct_bridge',n,2*mm*a,weights)
            elif kind=='radix2':stages(n,a,'radix',weights)
            elif kind=='pruned_two':emit('add','pruned_two',n,1,4*a,0,0,1,weights)
            elif kind=='direct_prime':emitvec(total,'direct',n,2*n*a,weights)
            else:raise AssertionError('unknown saved request kind')
    ck(not by_n and live==0 and processed==created)
    context_stats.append(dict(old_p=po,rows=len(ids),top=top_count,processed=processed,peak_retained=peak,blue=blue))
    print('Changed p='+str(po)+' contexts='+str(processed),flush=True)

# Removal is checked against the untouched predecessor, before any reinsertion.
for key,weights in delta_widths.items():
    old=old_widths.get(key,[0]*40)
    ck(all(d<=v for d,v in zip(weights,old)),'componentwise subset before insertion')
retained={}
for key,old in old_widths.items():
    removed=delta_widths.get(key,[0]*40);values=[v-d for v,d in zip(old,removed)]
    ck(min(values)>=0)
    if any(values):retained[key]=values
sharp_widths={k:list(v) for k,v in retained.items()}
for (po,cat,de,ce,db),weights in delta_widths.items():bump(sharp_widths,(po-1,cat,de,ce,db),weights,1,1197)
sharp_global={}
for (p,cat,de,ce,db),weights in sharp_widths.items():
    ck(100<=p<=108 and len(weights)==40 and min(weights)>=0)
    bump(sharp_global,(cat,de,ce,db),weights,1,133)
ck(sharp_global==global_widths,'complete unlabelled width conservation')
def category_counts(widths):
    out={p:[Counter() for _ in range(40)] for p in range(100,109)}
    for (p,cat,de,ce,db),weights in widths.items():
        for i,w in enumerate(weights):out[p][i][cat]+=w
    return {str(p):[{cat:x[cat] for cat in CATS} for x in rows] for p,rows in out.items()}
old_counts=category_counts(old_widths);sharp_counts=category_counts(sharp_widths)
ck(old_counts==old_width_file['normalized_counts_by_p'])
for i in range(40):
    for cat in CATS:ck(sum(old_counts[str(p)][i][cat] for p in range(100,109))==sum(sharp_counts[str(p)][i][cat] for p in range(100,109)))
    ck(sum(sharp_counts[str(p)][i]['scale'] for p in range(100,109))==0)
print('Nonnegative removal, reinsertion and all global width/category weights conserved.',flush=True)

sharp_states,sharp_keys,sharp_cache_nodes=validate_cache(new_cache,sharp_top,37522,7850,'sharper-conductor-precision-caches-1')
ck(sum(P for n,p,P in sharp_keys)==new_summary['sharp_kernel_entries']==369180928)
ck({(n,108,P) for n,p,P in sharp_keys}==base_keys)
intersection=dict(state_intersection_with_legacy=len(set(sharp_states)&set(old_states)),
    state_only_sharp=len(set(sharp_states)-set(old_states)),state_only_legacy=len(set(old_states)-set(sharp_states)),
    kernel_intersection_with_legacy=len(sharp_keys&old_keys),kernel_only_sharp=len(sharp_keys-old_keys),kernel_only_legacy=len(old_keys-sharp_keys))
for k,v in intersection.items():ck(v==new_cache[k]==new_summary[k])
sharp_setup={mode:setup(sharp_keys,mode) for mode in ('three','four')}
for pd in new_summary['precision_distribution']:
    x=sharp_setup['three']['by_p'][str(pd['p'])]
    ck(x.get('kernel_keys',0)==pd['kernel_keys'] and x.get('kernel_entries',0)==pd['kernel_entries'])
ck(sharp_setup['three']['totals']['exact_real_cache_sums']==new_summary['exact_real_cache_sums']==738361856)
sharp_prices={mode:all_views(price(sharp_widths,mode)) for mode in ('three','four')}
for mode in ('three','four'):ck(all_views(price(sharp_widths,mode,108))==global_prices[mode])
comparisons=[]
for mode in ('three','four'):
    for target,prices,prior_setup in [('global_p108',global_prices,global_setup),('conservative_local',old_prices,old_setup)]:
        for si,e in enumerate(EXTRAS):
            for view in ('old','guard','joined'):
                prior=prices[mode][si][view];new=sharp_prices[mode][si][view]
                dp=prior['product_core']-new['product_core'];da=prior['addition_core']-new['addition_core'];ck(dp>=0 and da>=0)
                ps=prior_setup[mode]['totals'];ns=sharp_setup[mode]['totals']
                comparisons.append(dict(mode=mode,comparator=target,extra_nodes=e,view=view,
                    runtime_product_core_reserve=dp,runtime_addition_core_reserve=da,
                    sharp_to_prior_core_ratio=str(F(new['core'],prior['core'])),
                    additional_cold_scale_sum_add_core=ns['total_added_normalized_setup_add_core']-ps['total_added_normalized_setup_add_core'],
                    conservative_sunk_new_scale_sum_add_core=ns['total_added_normalized_setup_add_core'],
                    kernel_fft_deltas={k:ns['kernel_fft_'+k]-ps['kernel_fft_'+k] for k in KEYS}))

OUTPUT=[]
def encode(name,obj):
    raw=json.dumps(obj,separators=(',',':')).encode()+b'\n';ck(len(raw)<=2*1024**2,'output file cap')
    OUTPUT.append((name,raw))
    return dict(path=name,bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest().upper())
common=dict(input_pins=PINS,support_pins=SUPPORT,contract_sha256=CONTRACT,
    weight_order=dict(views=['old','guard'],extras=EXTRAS,band_last_indices=ENDS),
    fields=['p','category','data_ceiling_exponent','coefficient_exponent','division_bits','old20_then_guard20_weights'])
da=encode(NAMES[0],dict(schema='sharper-precision-delta-widths-1',**common,p_means='old precision of changed rows',
    widths=[list(k)+[v] for k,v in sorted(delta_widths.items())],context_stats=context_stats,
    metadata_by_old_p={str(p):[dict(x) for x in rows] for p,rows in delta_meta.items()},metadata_fields=META))
wa=encode(NAMES[1],dict(schema='sharper-precision-price-widths-1',**common,
    widths=[list(k)+[v] for k,v in sorted(sharp_widths.items())],
    metadata_by_p={str(p):[dict(x) for x in rows] for p,rows in sharp_meta.items()},metadata_fields=META,
    normalized_counts_by_p=sharp_counts,predecessor_width_sha256=PINS['moebius/conductor_local_precision_price_widths_20261111.json'][1]))
receipt=dict(schema='sharper-precision-delta-price-receipt-1',input_pins=PINS,support_pins=SUPPORT,
    contract_sha256=CONTRACT,source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
    checks_before_receipt=CHECKS,input_bytes=READ_BYTES,context_stats=context_stats,total_processed_contexts=processed_total,
    changed_rows=8707,unchanged_rows=116693,transition_rows=[[p,q,v] for (p,q),v in sorted(transition.items())],
    old_width_classes=len(old_widths),delta_width_classes=len(delta_widths),sharp_width_classes=len(sharp_widths),global_width_classes=133,
    historical_full_phase_comparison='Inherited from A38579F3; not rerun in changed-row successor.',
    old_prices_and_setup_matched=True,componentwise_removal_nonnegative=True,global_width_and_category_conservation=True,
    artifacts=[da,wa],global_p108=global_prices,conservative_local=old_prices,sharp_prices=sharp_prices,
    setup_global_p108=global_setup,setup_conservative_local=old_setup,setup_sharp=sharp_setup,
    sharp_full_cache_nodes_by_p=sharp_cache_nodes,cache_intersections=intersection,comparisons=comparisons,
    cache_membership_sha256=PINS['integration/sharper_conductor_precision_caches_20261111.json'][1],
    caps=dict(input_bytes=128*1024**2,per_input_bytes=32*1024**2,changed_rows=8707,
        context_caps=CTX_CAPS,top_caps=TOP_CAPS,total_contexts=81415,weights=40,delta_classes=1064,sharp_classes=1197,
        radix_stages=18,per_output_bytes=2*1024**2,all_owned_bytes=8*1024**2),
    extensions_excluded=['80-weight full dual pass','shared-high kernel producer','precision portfolios','sub-grid100 inputs',
        'tighter tensor envelopes','adaptive Gauss/wider radix/named digit or new numeral arithmetic'],
    remaining_costs=['actual source and all per-p root/kernel enclosures','kernel FFT arithmetic and root/chirp generation/checking',
        'signed/range/encoding/source bindings','grid100 embeddings, output contracts and transport',
        'cache imports, storage and actual lifetimes','quarter/negation/permutation and full ordinary proof work',
        'all guard source/residue/completion/interpolation/negative-adapter work',
        'actual signs, repairs and closed count coverage','principal/small-family/finite arithmetic and analytic foundations'],
    attempt=dict(number=1,prior_failures=0),production_selected=False,numerical_evidence=False,runtime_claim=False,independent_review_pending=True)
ra=encode(NAMES[2],receipt)
# Reserve one MiB for the final report, in addition to the current preflight/source.
owned=sum(len(raw) for name,raw in OUTPUT)+Path(__file__).stat().st_size+(HERE/'SHARPER_PRECISION_DELTA_PRICE_PREFLIGHT_2026-11-11.md').stat().st_size+1024**2
ck(owned<=8*1024**2,'all-owned reserve cap')
for name,raw in OUTPUT:ck(not (HERE/name).exists(),'exclusive final gate')
for name,raw in OUTPUT:
    with (HERE/name).open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=CHECKS,contexts=context_stats,total_contexts=processed_total,
    delta_width_classes=len(delta_widths),sharp_width_classes=len(sharp_widths),artifacts=[da,wa,ra],
    main={mode:dict(old=old_prices[mode][0]['joined']['core'],sharp=sharp_prices[mode][0]['joined']['core'],
        setup_old=old_setup[mode]['totals']['total_added_normalized_setup_add_core'],
        setup_sharp=sharp_setup[mode]['totals']['total_added_normalized_setup_add_core']) for mode in ('three','four')})),flush=True)
