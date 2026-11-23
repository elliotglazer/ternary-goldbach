"""Independent bounded saved-DAG price reconstruction. No author imports."""
from pathlib import Path
from collections import Counter, defaultdict
from fractions import Fraction
import hashlib
import json
import re

HERE=Path(__file__).resolve().parent
AG=HERE.parent
PREFLIGHT=AG/'moebius/CONDUCTOR_LOCAL_PRECISION_PRICE_PASS_PREFLIGHT_2026-11-11.md'
CHECKS=0
def ck(ok,label):
    global CHECKS
    if not ok: raise AssertionError(label)
    CHECKS+=1
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest().upper()
ck(sha(PREFLIGHT)=='C5AAB690B926EC515E8708B2F3CB2B12C20E0ED6FA9C9313EC89803C7406B76E','frozen preflight')
allow={rel:(int(size),pin) for rel,size,pin in re.findall(r'^\|([^|]+)\|([0-9]+)\|([0-9A-F]{64})\|$',PREFLIGHT.read_text(),re.M)}
ck(len(allow)==11 and sum(size for size,pin in allow.values())<=128*1024**2,'allowlist caps')
def read(rel):
    size,pin=allow[rel]
    ck(size<=32*1024**2,'input size cap')
    raw=(AG/rel).read_bytes()
    ck(len(raw)==size and hashlib.sha256(raw).hexdigest().upper()==pin,'input pin '+rel)
    return json.loads(raw)

manifest=read('integration/transform_structural_manifest_20261111.json')
localrows=read('major-constants/conductor_local_precision_rows_20261111.json')
caches=read('major-constants/conductor_local_precision_caches_20261111.json')
first=read('major-constants/conductor_local_precision_metadata_20261111.json')
guardrows=read('integration/short_window_guard_conductor_rows_20261111.json')
guardref=read('integration/short_window_guard_ledger_20261111.json')
normref=read('independent-feasibility/normalized_bluestein_structural_costs_20261111.json')
priceref=read('moebius/normalized_transform_precision_costs_20261111.json')
guardprice=read('integration/normalized_transform_short_guard_join_20261111.json')
ck(manifest['conductor_fields']==['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'],'source schema')
ck(len(manifest['conductors'])==len(localrows['rows'])==len(guardrows['rows_data'])==125400,'row counts')
ck(len(manifest['requests'])==35190 and len(manifest['plan'])==37117,'plan counts')
ck(manifest['extras']==[0,167,320,640] and manifest['band_last_indices']==[6400,12800,25600,64000,128000],'scenario/band binding')
dag={(r[0],r[1]):r for r in manifest['requests']}
plan={int(n):v for n,v in manifest['plan'].items()}
for n,q,kind,children,local,total in manifest['requests']:
    ck(len(children)<=3,'requested child cap')
    ck(all(child[0]<n and child[2]>=0 and child[3]>=1 for child in children),'descending saved edges')
def band_weights(count):
    edges=[0,6401,12801,25601,64001,128001]
    result=[max(0,min(count,hi)-lo) for lo,hi in zip(edges,edges[1:])]
    ck(sum(result)==count,'prefix fits bands')
    return result
partitions={p:[] for p in range(100,109)}
for rid,(source,lr,gr) in enumerate(zip(manifest['conductors'],localrows['rows'],guardrows['rows_data'])):
    c,phi,primitive,H,J,axes,ws=source
    ck(lr[:5]==[rid,c,phi,primitive,axes],'local row identity')
    ck(gr[:4]==[c,J,phi,primitive],'guard row identity')
    p=lr[8]
    ck(type(p) is int and 100<=p<=108 and all(type(x) is int and x>=0 for x in lr[9:]),'precision/slacks')
    sm,so,dd=lr[5:8]
    ck(lr[9]==c*(1266*202305920)**2-(2*phi*sm)**2*2**(2*(108-p)),'budget slack binding')
    ck(lr[10]==2**p-dd and lr[11]==2**p-2*so,'safety binding')
    expected_old=[];expected_guard=[]
    for extra in (0,167,320,640):
        old=band_weights(J+extra); extended=band_weights(J+extra+41)
        gw=[y-x for x,y in zip(old,extended)]
        ck(sum(gw)==41 and min(gw)>=0,'guard interval')
        expected_old+=old;expected_guard+=gw
    ck(ws==expected_old and gr[5]==expected_guard,'all band weights')
    ck(len(axes)<=18 and all(n>=2 for n,q in axes) and phi<=265800,'axis cap')
    partitions[p].append(rid)

# Context maps are retained for only one precision partition at a time.
global_events={}; local_widths={}; counts_by_p={}; input_by_p={}
context_counts={};top_counts={};blue_counts={};total_contexts=0
def add(table,key,weights,mult,cap):
    if not mult: return
    if key not in table:
        ck(len(table)<cap,'dictionary cap')
        table[key]=[0]*len(weights)
    dest=table[key]
    for i,w in enumerate(weights): dest[i]+=mult*w
def ceiling_exponent(value):
    x=Fraction(value)
    ck(x>0,'positive norm factor')
    ceiling=(x.numerator+x.denominator-1)//x.denominator
    return max(0,(ceiling-1).bit_length())
def emit(p,cat,phase,n,j,factor,coef,division,mult,weights):
    if not mult: return
    de=ceiling_exponent(factor)
    add(global_events,(cat,phase,n,j,de,coef,division),weights,mult,125279)
    add(local_widths,(p,cat,de,coef,division),weights,mult,1197)
def vector(p,values,phase,n,factor,weights):
    ck(values[4]==0,'vector has no division')
    for cat,v in zip(('root','add','quarter','neg','scale'),values):
        emit(p,cat,phase,n,0,factor,int(cat=='root'),0,v,weights)
def radix(p,length,factor,phase,weights):
    k=length.bit_length()-1
    ck(1<<k==length and k<=18,'radix stage bound')
    for j in range(1,k+1):
        copies=length//(1<<j)
        roots=length//2-copies*(1+int(j>=2))
        emit(p,'root',phase,length,j,(1<<j)*factor,1,0,roots,weights)
        emit(p,'quarter',phase,length,j,(1<<j)*factor,0,0,copies*int(j>=2),weights)
        emit(p,'add',phase,length,j,(1<<(j+1))*factor,0,0,length,weights)
KEYS=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
for p,rids in partitions.items():
    pending={}; inputs=[[0]*40 for _ in range(3)]; live=0
    for rid in rids:
        c,phi,primitive,H,J,axes,old=manifest['conductors'][rid]
        gr=guardrows['rows_data'][rid]
        weights=old+gr[5]
        for i,w in enumerate(weights):
            inputs[0][i]+=w;inputs[1][i]+=phi*w;inputs[2][i]+=primitive*w
        full_before=1; kept_before=1; suffix=phi; perheight=[0]*5
        for n,q in axes:
            ck(suffix%n==0 and (n,q) in dag,'axis request')
            suffix//=n
            mult=kept_before*suffix
            group=pending.setdefault(n,{})
            if mult and (q,2*full_before) not in group:
                ck(live<220108,'live insertion cap'); live+=1
            add(group,(q,2*full_before),weights,mult,220108)
            for i,v in enumerate(dag[n,q][5]): perheight[i]+=mult*v
            full_before*=n
            kept_before*=n if q==0 else n-n//q
        ck(full_before==phi and kept_before==primitive and suffix==1,'outer products')
        ck(perheight==gr[4],'per-height operation vector')
    top_counts[p]=live
    ck(top_counts[p]<=52560,'partition top cap')
    processed=0;blue_processed=0
    for n in sorted({n for n,q in dag},reverse=True):
        bucket=pending.pop(n,{})
        live-=len(bucket)
        for (q,a),weights in bucket.items():
            processed+=1;total_contexts+=1
            ck(processed<=220108 and total_contexts<=1980972,'processed context cap')
            _,_,kind,children,local,totals=dag[n,q]
            for cn,cq,mult,norm in children:
                group=pending.setdefault(cn,{})
                if mult and (cq,a*norm) not in group:
                    ck(live+len(bucket)<220108,'live child insertion cap'); live+=1
                add(group,(cq,a*norm),weights,mult,220108)
            if kind=='ct':
                r,m=(2,n//2) if plan[n]['choice'][0]=='radix2' else plan[n]['choice'][1:]
                vector(p,local,'ct_bridge',n,2*m*a,weights)
            elif kind=='radix2': radix(p,n,a,'radix',weights)
            elif kind=='pruned_two': emit(p,'add','pruned_two',n,1,4*a,0,0,1,weights)
            elif kind=='direct_prime': vector(p,totals,'direct',n,2*n*a,weights)
            else:
                ck(kind=='bluestein','request kind')
                blue_processed+=1
                P=1 << (2*n-2).bit_length(); k=P.bit_length()-1
                rv=[P*k//2-3*P//2+2,P*k,P//2-1,0,0]
                fixed=[2*v+(P if i in (0,4) else 0) for i,v in enumerate(rv)]
                full=[plan[n]['count'][key] for key in KEYS]
                ck(all(x>=y and (x-y)%2==0 for x,y in zip(full,fixed)),'prechirp subtraction')
                pre=[(x-y)//2 for x,y in zip(full,fixed)]
                post=[x-y-z for x,y,z in zip(totals,fixed,pre)]
                ck(min(post)>=0 and post[1]==post[4]==0,'postchirp subtraction')
                vector(p,pre,'blue_pre_chirp',n,2*a,weights)
                radix(p,P,2*a,'blue_forward',weights)
                emit(p,'kernel','blue_point',n,0,(n+2)*a,0,0,P,weights)
                radix(p,P,(Fraction(n*(2*n-1),P)+2)*a,'blue_inverse',weights)
                vector(p,post,'blue_post_chirp',n,2*n*a,weights)
        del bucket
        ck(live<=220108,'live context cap')
    ck(not pending and live==0,'partition drained')
    context_counts[p]=processed; blue_counts[p]=blue_processed; input_by_p[p]=inputs
    print('Reconstructed precision '+str(p)+' contexts '+str(processed),flush=True)

# Historical histograms are decoded and discarded sequentially.
for offset,rel in ((0,'independent-feasibility/normalized_bluestein_events_20261111.json'),
                   (20,'integration/normalized_transform_short_guard_events_20261111.json')):
    reference=read(rel)
    ck(len(reference['events'])==len(global_events)==125279,'complete histogram key count')
    seen=set()
    for row in reference['events']:
        key=tuple(row[:-1])
        ck(key not in seen and key in global_events,'unique complete historical key')
        seen.add(key)
        ck(row[-1]==global_events[key][offset:offset+20],'all historical weights')
    del reference,seen
global_widths={}
for (cat,phase,n,j,de,ce,db),weights in global_events.items():
    add(global_widths,(cat,de,ce,db),weights,1,133)
ck(len(global_widths)==133,'global width class count')
for p,cat,de,ce,db in local_widths:
    ck((cat,de,ce,db) in global_widths,'local key belongs to verified baseline')
for key,weights in global_widths.items():
    ck(weights==[sum(local_widths.get((p,)+key,[0]*40)[i] for p in range(100,109)) for i in range(40)],'local partition sum')
del global_events

def adder(bits): return 2*((bits+7)//8)+1
def product(a,b):
    x=(a+7)//8;y=(b+7)//8
    return 5*x*y+2*min(x,y)+1
def prices(width_table,mode,forced_p=None):
    bands=[Counter() for _ in range(40)]
    ranges={key:[] for key in ('data_magnitude_bits','coefficient_magnitude_bits','raw_magnitude_bits','round_witness_magnitude_bits')}
    for key,weights in width_table.items():
        if len(key)==5: assigned,cat,de,ce,db=key
        else: cat,de,ce,db=key; assigned=108
        p=assigned if forced_p is None else forced_p
        a=p+14+de
        if cat in ('root','kernel'):
            b=p+ce
            if mode=='three':
                prod=product(a+1,b)+product(a,b+1)+product(a,b+1)
                raw=a+b+2; adds=adder(a+1)+2*adder(raw)
            else:
                prod=sum(product(a,b) for _ in range(4))
                raw=a+b+1; adds=2*adder(raw)
            fees={cat+'_product':prod,cat+'_exact_add':adds,cat+'_round_add':4*adder(raw+2)}
            for name,v in zip(ranges,(a,b,raw,raw+2)): ranges[name].append(v)
        elif cat=='add': fees={'add_complex_add':2*adder(a+1)}
        else:
            ck(cat in ('quarter','neg','scale') and (cat!='scale' or not any(weights)),'cheap/division category')
            fees={}
        for i,w in enumerate(weights):
            for name,fee in fees.items(): bands[i][name]+=w*fee
    return bands,{name:[min(vals),max(vals)] for name,vals in ranges.items()}
def pack(bands,offset,scenario):
    selected=bands[offset+scenario*5:offset+scenario*5+5]
    total=Counter()
    for row in selected:
        total.update(row)
    # Counter addition in reference removes zero fields from aggregates.
    total=+total
    products=sum(value for key,value in total.items() if key.endswith('_product'))
    return dict(parts=dict(total),bands=[dict(row) for row in selected],product_core=products,
                addition_core=sum(total.values())-products,core=sum(total.values()))
global_counts=[Counter() for _ in range(40)]
for (cat,de,ce,db),weights in global_widths.items():
    for i,w in enumerate(weights): global_counts[i][cat]+=w
for i in range(40): ck(global_counts[i]['scale']==0,'normalized division zero')
old_width_rows=[list(key)+[weights[:20]] for key,weights in sorted(global_widths.items())]
guard_width_rows=[list(key)+[weights[20:]] for key,weights in sorted(global_widths.items())]
ck(old_width_rows==priceref['normalized_width_classes'],'old full width projection')
ck(guard_width_rows==guardprice['guard_width_histogram'],'guard full width projection')
for i in range(20):
    ck(global_counts[i+20]==Counter(guardprice['normalized_guard_band_counts'][i]),'guard normalized category counts')
    sc=guardref['scenarios'][i//5]['added_by_band'][i%5]
    ck(global_counts[i+20]['root']==sc['root_products'] and global_counts[i+20]['kernel']==sc['kernel_products'],'guard root/kernel split')
    for cat,field in (('add','complex_add_sub'),('quarter','quarter_turns'),('neg','negations')):
        ck(global_counts[i+20][cat]==sc['operations'][field],'guard cheap/add categories')
baseline={};local_prices={}
old108=next(row for row in priceref['allocations'] if row['p']==108)
guard108=next(row for row in guardprice['allocations'] if row['p']==108)
for mode in ('three','four'):
    old_bands,old_ranges=prices(global_widths,mode,108)
    forced_bands,forced_ranges=prices(local_widths,mode,108)
    ck(old_bands==forced_bands and old_ranges==forced_ranges,'forced p108 local equality')
    ck(old_ranges==old108['profiles'][mode]['width_ranges'],'p108 width ranges')
    mixed_bands,mixed_ranges=prices(local_widths,mode)
    baseline[mode]={'bands':old_bands,'ranges':old_ranges}
    local_prices[mode]={'bands':mixed_bands,'ranges':mixed_ranges}
    for s,extra in enumerate((0,167,320,640)):
        ref=guard108['profiles'][mode]['scenarios'][s]
        old=pack(old_bands,0,s);guard=pack(old_bands,20,s)
        joined=pack([old_bands[i]+old_bands[i+20] for i in range(20)],0,s)
        for label,obj in (('old',old),('guard',guard),('joined',joined)):
            ck(ref[label]==obj,'all p108 '+label+' bands/components')
        rr=old108['profiles'][mode]['scenarios'][s]
        for key,v in old.items(): ck(rr[key]==v,'lower-price comparator '+key)
        ck(Counter(rr['operation_counts'])==sum(global_counts[s*5:s*5+5],Counter()),'old p108 operation counts')

# Revalidate full-plan cache closure without reconstructing any conductor/factor data.
contract=caches['contract']
contract_hash=hashlib.sha256(json.dumps(contract,sort_keys=True,separators=(',',':')).encode()).hexdigest().upper()
ck(contract_hash==localrows['contract_sha256']==caches['contract_sha256']==first['contract_sha256']=='22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884','cache contract')
canonical=hashlib.sha256(json.dumps(manifest['plan'],sort_keys=True,separators=(',',':')).encode()).hexdigest()
ck(canonical==manifest['canonical_plan_sha256']==caches['plan_sha256'],'cache plan hash')
masks={n:0 for n in plan}
for rid,source in enumerate(manifest['conductors']):
    for n,q in source[5]: masks[n]|=1 << (localrows['rows'][rid][8]-100)
for n in sorted(plan,reverse=True):
    choice=plan[n]['choice']
    if choice[0]=='split':
        ck(len(choice)==3 and choice[1]*choice[2]==n,'full split')
        for child in choice[1:]: masks[child]|=masks[n]
nodes=[];kernel_keys=[]
for n in sorted(plan):
    choice=plan[n]['choice']
    for p in range(100,109):
        if masks[n] & (1 << (p-100)):
            kids=[[child,p] for child in choice[1:]] if choice[0]=='split' else []
            nodes.append([n,p,choice,kids])
            if choice[0]=='bluestein': kernel_keys.append([n,p,1 << (2*n-2).bit_length()])
ck(nodes==caches['full_nodes'] and len(nodes)==38147,'all full cache states')
ck(kernel_keys==caches['kernels'] and len(kernel_keys)==7606,'all kernel records')
base_lengths=sorted({n for n,p,P in kernel_keys})
ck(len(base_lengths)==6004,'baseline kernel lengths')
setup_by_p={p:Counter() for p in range(100,109)}
for n,p,P in kernel_keys:
    e=(2*n).bit_length()
    k=P.bit_length()-1
    setup_by_p[p].update({'keys':1,'entries':P,'scale_add':P*4*adder(p+e+2),'sum_add':P*2*adder(p+1),
                         'fft_root':P*k//2-3*P//2+2,'fft_add':P*k,'fft_quarter':P//2-1,'fft_neg':0,'fft_scale':0})
base_setup=Counter()
for n in base_lengths:
    P=1 << (2*n-2).bit_length(); e=(2*n).bit_length(); k=P.bit_length()-1
    base_setup.update({'keys':1,'entries':P,'scale_add':P*4*adder(108+e+2),'sum_add':P*2*adder(109),
                       'fft_root':P*k//2-3*P//2+2,'fft_add':P*k,'fft_quarter':P//2-1,'fft_neg':0,'fft_scale':0})
ck(base_setup['entries']==337702368 and sum(x['entries'] for x in setup_by_p.values())==364355904,'setup entry totals')
for mode in ('three','four'):
    ref=old108['profiles'][mode]['setup_per_cache_lifetime']
    ck(base_setup['scale_add']==ref['scaled_cache_round_add_core'],'baseline scale setup')
    ck((base_setup['sum_add'] if mode=='three' else 0)==ref['scaled_cache_sum_add_core'],'baseline sum setup')
    ck(base_setup['scale_add']+(base_setup['sum_add'] if mode=='three' else 0)==ref['total_added_normalized_setup_add_core'],'baseline total setup')
    ck(ref==guard108['profiles'][mode]['setup_per_cache_lifetime'],'guard setup unchanged')
ck(base_setup['scale_add']+base_setup['sum_add']==64162618688,'known p108 setup anchor')

def setup_object(keys,mode):
    # Separately structured from the author's additive-record loop.
    groups={p:[] for p in range(100,109)}
    exponent=Counter()
    for n,p,P in keys:
        groups[p].append((n,P))
        exponent[p,(2*n).bit_length()]+=P
    by_p={}
    for p,group in groups.items():
        if not group:
            by_p[str(p)]={}
            continue
        by_p[str(p)]={
            'kernel_keys':len(group),
            'kernel_entries':sum(P for n,P in group),
            'chirp_entries':sum(n for n,P in group),
            'scaled_cache_complex_rounds':sum(P for n,P in group),
            'exact_real_cache_sums':sum(2*P for n,P in group) if mode=='three' else 0,
            'scaled_cache_round_add_core':sum(P*4*adder(p+(2*n).bit_length()+2) for n,P in group),
            'scaled_cache_sum_add_core':sum(P*2*adder(p+1) for n,P in group) if mode=='three' else 0,
            'kernel_fft_general_complex_products':sum(P*(P.bit_length()-1)//2-3*P//2+2 for n,P in group),
            'kernel_fft_complex_add_sub':sum(P*(P.bit_length()-1) for n,P in group),
            'kernel_fft_quarter_turns':sum(P//2-1 for n,P in group),
            'kernel_fft_negations':0,
            'kernel_fft_dyadic_scales':0,
        }
    totals={key:sum(values.get(key,0) for values in by_p.values()) for key in set().union(*(values.keys() for values in by_p.values()))}
    totals['total_added_normalized_setup_add_core']=totals['scaled_cache_round_add_core']+totals['scaled_cache_sum_add_core']
    return {'totals':totals,'by_p':by_p,'exponent_entry_histogram':[[p,e,v] for (p,e),v in sorted(exponent.items())]}

# Frozen author pins are supplied before the first independent execution.
AUTHOR_PINS = {
    'conductor_local_precision_prices_20261111.py':'3F3F3A19521E45EF5D5914DFDBA12C1705F9F2FFA2A080D4DF171D7F3E9C8031',
    'conductor_local_precision_price_widths_20261111.json':'588474ECF8B628607ADC279BC429BC7CBAA3125CC2AEAB5D7F9708E66CDD48FB',
    'conductor_local_precision_prices_20261111.json':'B1684F0328BC70E2B59D88975489D31161081A3082F1AFF176D527E7741E9D53',
}
ck(len(AUTHOR_PINS)==3,'author source/output pins supplied')
def read_author(name):
    pin=AUTHOR_PINS[name]
    path=AG/'moebius'/name
    ck(path.stat().st_size<=2*1024**2,'author output cap')
    raw=path.read_bytes()
    ck(hashlib.sha256(raw).hexdigest().upper()==pin,'frozen author artifact')
    return json.loads(raw)
ck(sha(AG/'moebius/conductor_local_precision_prices_20261111.py')==AUTHOR_PINS['conductor_local_precision_prices_20261111.py'],'frozen author writer pin')
result=read_author('conductor_local_precision_prices_20261111.json')
width_output=read_author('conductor_local_precision_price_widths_20261111.json')
ck(result['schema']=='conductor-local-precision-price-receipt-1','receipt schema')
ck(width_output['schema']=='conductor-local-precision-price-widths-1','width schema')
ck(width_output['fields']==['p','category','data_ceiling_exponent','coefficient_exponent','division_bits','old20_then_guard20_weights'],'width fields')
ck(width_output['weight_order']=={'views':['old','guard'],'extras':[0,167,320,640],'band_last_indices':[6400,12800,25600,64000,128000]},'weight ordering')
expected_widths=[list(key)+[weights] for key,weights in sorted(local_widths.items())]
ck(width_output['widths']==expected_widths,'every local width class and weight')
ck(result['local_width_classes']==len(local_widths)<=1197,'local width cap')
ck(result['global_event_classes']==125279 and result['global_width_classes']==133,'global class counts')
for p in range(100,109):
    fields=['conductor_height_nodes','residue_inputs','primitive_outputs']
    expected=[{field:input_by_p[p][j][i] for j,field in enumerate(fields)} for i in range(40)]
    ck(width_output['metadata_by_p'][str(p)]==expected,'all source/output metadata by p and band')
    cats=['root','kernel','add','quarter','neg','scale']
    per=[{cat:0 for cat in cats} for _ in range(40)]
    for (pp,cat,de,ce,db),weights in local_widths.items():
        if pp==p:
            for i,w in enumerate(weights): per[i][cat]+=w
    ck(width_output['normalized_counts_by_p'][str(p)]==per,'all category counts by p and band')
    stats=result['contexts_by_p'][p-100]
    ck(stats['p']==p and stats['rows']==len(partitions[p]) and stats['top']==top_counts[p],'context input stats')
    ck(stats['processed']==context_counts[p] and stats['blue']==blue_counts[p],'processed context stats')
    ck(top_counts[p]<=stats['peak_retained']<=context_counts[p]<=220108,'source-dependent live peak bound')
ck(result['total_processed_contexts']==total_contexts<=1980972,'all processed contexts')
ck(result['predecessor_full_histograms_matched'] and result['p108_all_components_and_setup_matched'],'claimed matches independently established')
expected_setup={};expected_base_setup={};expected_prices={};expected_baseline={}
basekeys=[(n,108,1 << (2*n-2).bit_length()) for n in base_lengths]
comparisons=[]
for mode in ('three','four'):
    expected_setup[mode]=setup_object(kernel_keys,mode)
    expected_base_setup[mode]=setup_object(basekeys,mode)
    ck(result['setup_local'][mode]==expected_setup[mode],'all local setup fields')
    ck(result['setup_baseline'][mode]==expected_base_setup[mode],'all baseline setup fields')
    expected_prices[mode]=[];expected_baseline[mode]=[]
    for s,extra in enumerate((0,167,320,640)):
        views=[]
        for collection in (baseline,local_prices):
            bb=collection[mode]['bands']
            old=pack(bb,0,s);guard=pack(bb,20,s)
            joined=pack([bb[i]+bb[i+20] for i in range(20)],0,s)
            views.append(dict(extra_nodes=extra,old=old,guard=guard,joined=joined))
        expected_baseline[mode].append(views[0]);expected_prices[mode].append(views[1])
        ck(result['global_p108'][mode][s]==views[0],'full global p108 output')
        ck(result['local_prices'][mode][s]==views[1],'full local price output')
        sb=expected_base_setup[mode]['totals'];sl=expected_setup[mode]['totals']
        for view in ('old','guard','joined'):
            old=views[0][view];new=views[1][view]
            comparisons.append(dict(mode=mode,extra_nodes=extra,view=view,
                runtime_product_core_reserve=old['product_core']-new['product_core'],
                runtime_addition_core_reserve=old['addition_core']-new['addition_core'],
                local_to_global_core_ratio=str(Fraction(new['core'],old['core'])),
                additional_cold_scale_sum_add_core=sl['total_added_normalized_setup_add_core']-sb['total_added_normalized_setup_add_core'],
                conservative_sunk_new_scale_sum_add_core=sl['total_added_normalized_setup_add_core'],
                kernel_fft_deltas={key:sl['kernel_fft_'+key]-sb['kernel_fft_'+key] for key in KEYS}))
ck(result['comparisons']==comparisons,'all reserves/ratios/cold-sunk differences')
full_by_p={}
for p in range(100,109):
    atp=[node for node in nodes if node[1]==p]
    count=sum(node[0] for node in atp if node[2][0]=='split')
    full_by_p[str(p)]={'full_plan_states':len(atp)}
    if count: full_by_p[str(p)]['CT_full_root_table_entry_upper']=count
ck(result['full_cache_nodes_by_p']==full_by_p,'all full-node and CT setup counts')
for field,expected in (('cache_keys',7606),('cache_entries',364355904),('baseline_cache_keys',6004),('baseline_cache_entries',337702368)):
    ck(result[field]==expected,'cache summary')
for obj in (result,width_output):
    ck(obj['contract_sha256']==contract_hash,'contract identity')
    ck(obj['input_pins']=={rel:[size,pin] for rel,(size,pin) in allow.items()},'all input provenance')
ck(result['source_sha256']==AUTHOR_PINS['conductor_local_precision_prices_20261111.py'],'source receipt binding')
ck(result['input_bytes']==95079543,'input bytes')
ck(result['production_selected'] is False and result['numerical_evidence'] is False and result['runtime_claim'] is False,'scope flags')
ck(result['width_artifact']['sha256']==AUTHOR_PINS['conductor_local_precision_price_widths_20261111.json'],'width receipt pin')
ck(result['width_artifact']['bytes']==(AG/'moebius/conductor_local_precision_price_widths_20261111.json').stat().st_size,'width receipt bytes')

receipt={
    'scope':'Independent saved-DAG/price reconstruction; no author imports, new planning, root/value enumeration, builds or proof emission.',
    'checks':CHECKS,'script_sha256':sha(Path(__file__)),
    'preflight_sha256':'C5AAB690B926EC515E8708B2F3CB2B12C20E0ED6FA9C9313EC89803C7406B76E',
    'author_pins':AUTHOR_PINS,'contract_sha256':contract_hash,
    'full_old_and_guard_histograms_match':True,'global_width_classes':133,'local_width_classes':len(local_widths),
    'processed_contexts_by_p':context_counts,'total_processed_contexts':total_contexts,
    'peak_scope':'Author peak values source-reviewed and checked against top/processed caps; dictionary-order-dependent peaks not claimed identical.',
    'p108_both_mode_all_component_setup_match':True,
    'all_local_prices':expected_prices,'all_setup_local':expected_setup,'all_setup_baseline':expected_base_setup,
    'all_comparisons':comparisons,
}
out=HERE/'review_conductor_local_prices_20261111.json'
raw=(json.dumps(receipt,indent=2)+'\n').encode()
ck(len(raw)<=2*1024**2,'own receipt cap')
with out.open('xb') as stream: stream.write(raw)
print(json.dumps({'checks_before_serialization':receipt['checks'],'script_sha256':receipt['script_sha256'],
                  'receipt_sha256':sha(out),'contexts':total_contexts,'local_width_classes':len(local_widths),
                  'main_joined':{mode:expected_prices[mode][0]['joined']['core'] for mode in ('three','four')}}))
