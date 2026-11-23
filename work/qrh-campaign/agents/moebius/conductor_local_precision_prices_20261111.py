"""Authorized saved-context price fold. No planner, evaluator, or author imports."""
from pathlib import Path
from collections import Counter
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
AG = HERE.parent
PINS = {
 'integration/transform_structural_manifest_20261111.json': (25110201,'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'),
 'major-constants/conductor_local_precision_rows_20261111.json': (21933038,'B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7'),
 'major-constants/conductor_local_precision_caches_20261111.json': (1902325,'95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584'),
 'major-constants/conductor_local_precision_metadata_20261111.json': (2686,'7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978'),
 'independent-feasibility/normalized_bluestein_events_20261111.json': (18684197,'721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2'),
 'independent-feasibility/normalized_bluestein_structural_costs_20261111.json': (89710,'F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3'),
 'moebius/normalized_transform_precision_costs_20261111.json': (107410,'C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4'),
 'integration/short_window_guard_conductor_rows_20261111.json': (12794207,'A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA'),
 'integration/short_window_guard_ledger_20261111.json': (41665,'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4'),
 'integration/normalized_transform_short_guard_events_20261111.json': (14254909,'F26896C955B06006AEBA260FB6605EDE21DDD3EA9CED984E0DD46BADAA855897'),
 'integration/normalized_transform_short_guard_join_20261111.json': (159195,'4F6F20570E0E1F35C806E173E2FA13B95CCD084B177F38F359E3F3171F5EB66A'),
}
SUPPORT = {
 'moebius/CONDUCTOR_LOCAL_PRECISION_PRICE_PASS_PREFLIGHT_2026-11-11.md':'C5AAB690B926EC515E8708B2F3CB2B12C20E0ED6FA9C9313EC89803C7406B76E',
 'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_PRICE_PREFLIGHT_2026-11-11.md':'A121B36F23EFCDC5AC72C7B04AAC45C959A1477B0D6BCD5BBD2B2A0DE7CE6B81',
 'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md':'01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C',
}
CHECKS = 0
READ_BYTES = 0
READ_NAMES = set()
OUT_NAMES = ['conductor_local_precision_price_widths_20261111.json',
             'conductor_local_precision_prices_20261111.json']
CAP_CONTEXT = 220108
CAP_TOTAL_CONTEXT = 1980972
CAP_OUTPUT = 2*1024**2
KEYS = ['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
CATS = ['root','kernel','add','quarter','neg','scale']
EXTRAS = [0,167,320,640]
ENDS = [6400,12800,25600,64000,128000]
CONTRACT = '22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884'

def ck(ok, label='check'):
    global CHECKS
    if not ok:
        raise AssertionError(label)
    CHECKS += 1

def canonical(x):
    return json.dumps(x,sort_keys=True,separators=(',',':')).encode()

def read(rel):
    global READ_BYTES
    ck(rel in PINS and rel not in READ_NAMES, 'input allowlist/single read')
    size,pin = PINS[rel]
    path = AG/rel
    ck(size <= 32*1024**2 and path.stat().st_size == size, 'input size')
    ck(READ_BYTES+size <= 128*1024**2, 'aggregate input cap')
    with path.open('rb') as f:
        raw = f.read(size+1)
    ck(len(raw)==size and hashlib.sha256(raw).hexdigest().upper()==pin, 'input hash')
    READ_BYTES += size
    READ_NAMES.add(rel)
    return json.loads(raw)

for name in OUT_NAMES:
    ck(not (HERE/name).exists(), 'exclusive output precheck')
for rel,h in SUPPORT.items():
    ck((AG/rel).stat().st_size <= 128*1024, 'support size')
    ck(hashlib.sha256((AG/rel).read_bytes()).hexdigest().upper()==h, 'support hash')
ck(sum(s for s,h in PINS.values())==95079543, 'approved input total')

m = read('integration/transform_structural_manifest_20261111.json')
rows_file = read('major-constants/conductor_local_precision_rows_20261111.json')
caches = read('major-constants/conductor_local_precision_caches_20261111.json')
first = read('major-constants/conductor_local_precision_metadata_20261111.json')
norm = read('independent-feasibility/normalized_bluestein_structural_costs_20261111.json')
priced = read('moebius/normalized_transform_precision_costs_20261111.json')
gr = read('integration/short_window_guard_conductor_rows_20261111.json')
guard_ref = read('integration/short_window_guard_ledger_20261111.json')
guard_cost = read('integration/normalized_transform_short_guard_join_20261111.json')
ck(m['schema']=='selected-transform-structural-manifest-1')
ck(m['conductor_fields']==['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'])
ck(m['request_fields']==['n','q','kind','children_n_q_multiplicity_normfactor','local_five_counts','five_counts'])
ck(m['extras']==gr['extras']==EXTRAS and m['band_last_indices']==gr['band_last_indices']==ENDS)
ck(gr['categories']==KEYS and gr['manifest_sha256']==PINS['integration/transform_structural_manifest_20261111.json'][1])
ck(rows_file['schema']=='conductor-local-precision-rows-1')
ck(rows_file['fields']==['source_row_id','c','phi','primitive','ordered_axes_n_q','S_mixed','S_old','D_local','p','squared_budget_slack','D_slack','peak_slack'])
ck(caches['schema']=='conductor-local-precision-caches-1')
ck(caches['full_node_fields']==['n','p','saved_choice','ordered_child_n_p'])
ck(caches['kernel_fields']==['n','p','P'])
for obj in (rows_file,caches):
    ck(obj['guards_included'] is False and obj['prices_included'] is False)
    ck(obj['contract_sha256']==CONTRACT)
    ck(obj['inputs']['integration/transform_structural_manifest_20261111.json']==dict(bytes=PINS['integration/transform_structural_manifest_20261111.json'][0],sha256=PINS['integration/transform_structural_manifest_20261111.json'][1]))
ck(first['contract_sha256']==CONTRACT and hashlib.sha256(canonical(caches['contract'])).hexdigest().upper()==CONTRACT)
ck(caches['plan_sha256']==m['canonical_plan_sha256']==hashlib.sha256(canonical(m['plan'])).hexdigest())
ck(len(m['conductors'])==len(rows_file['rows'])==len(gr['rows_data'])==125400)
ck(len(m['plan'])==37117 and len(m['requests'])==35190)
ck(m['unchanged_setup']==norm['setup_kernel_fft_unchanged']==priced['unchanged_setup_operation_counts']==guard_cost['unchanged_setup'])
plan=m['plan']
dag={}
for r in m['requests']:
    ck(len(r)==6 and (r[0],r[1]) not in dag)
    n,q,kind,children,local,total=r
    ck(type(n) is int and n>=2 and type(q) is int and q>=0)
    ck(len(children)<=3 and len(local)==len(total)==5)
    ck(all(type(v) is int and v>=0 for v in local+total))
    for child in children:
        ck(len(child)==4 and all(type(x) is int for x in child))
        cn,cq,mult,af=child
        ck(2<=cn<n and cq>=0 and mult>=0 and af>=1)
    dag[n,q]=r
for r in dag.values():
    ck(all((cn,cq) in dag for cn,cq,mult,af in r[3]))
ordered_n=sorted({n for n,q in dag},reverse=True)

def bands(count):
    out=[];lo=0
    for hi in ENDS:
        out.append(max(0,min(count,hi+1)-lo));lo=hi+1
    ck(sum(out)==count)
    return out

partitions={p:[] for p in range(100,109)}
metadata={p:[Counter() for _ in range(40)] for p in partitions}
original_ops=[Counter() for _ in range(40)]
expected_top=set()
for rid,(row,pr,grow) in enumerate(zip(m['conductors'],rows_file['rows'],gr['rows_data'])):
    c,phi,primitive,H,J,axes,ws=row
    ck(len(pr)==12 and pr[:5]==[rid,c,phi,primitive,axes], 'precision row identity')
    S,Sold,D,p,slack,ds,ss=pr[5:]
    ck(all(type(x) is int for x in [c,phi,primitive,H,J,S,Sold,D,p,slack,ds,ss]))
    ck(10000<c<=265800 and ((c%2==1 and c<=132900) or c%4==0))
    ck(1<=phi<=265800 and 1<=len(axes)<=18 and 100<=p<=108)
    ck(0<=S<=202305920 and 0<=Sold<=424706204 and 1<=D<=29961461170177)
    ck(slack==c*(1266*202305920)**2-(2*phi*S)**2*2**(2*(108-p)) and slack>=0)
    ck(ds==2**p-D>=0 and ss==2**p-2*Sold>=0)
    if p>100:
        ck(c*(1266*202305920)**2-(2*phi*S)**2*2**(2*(109-p))<0)
    gc,gJ,gphi,gprim,ops,gws=grow
    ck([gc,gJ,gphi,gprim]==[c,J,phi,primitive])
    ck(len(ws)==len(gws)==20 and len(ops)==5)
    ck(all(type(x) is int and x>=0 for x in ws+gws+ops))
    old=[];extra=[]
    for e in EXTRAS:
        before=bands(J+e);after=bands(J+e+41)
        inc=[v-u for u,v in zip(before,after)]
        ck(sum(inc)==41 and min(inc)>=0)
        old+=before;extra+=inc
    ck(ws==old and gws==extra, 'both exact height vectors')
    suffix=phi;kept=full=1;perheight=[0]*5
    for n,q in axes:
        ck(type(n) is int and type(q) is int and n>=2 and (n,q) in dag)
        ck(suffix%n==0 and (q==0 or (q>0 and n%q==0)))
        suffix//=n;mult=kept*suffix
        for i,v in enumerate(dag[n,q][5]):perheight[i]+=mult*v
        kept*=n if q==0 else n-n//q;full*=n
        expected_top.add((n,p))
    ck(full==phi and kept==primitive and suffix==1 and perheight==ops)
    partitions[p].append(rid)
    for i,w in enumerate(ws+gws):
        metadata[p][i]['conductor_height_nodes']+=w
        metadata[p][i]['residue_inputs']+=phi*w
        metadata[p][i]['primitive_outputs']+=primitive*w
        for key,v in zip(KEYS,ops):original_ops[i][key]+=w*v
for pd in first['precision_distribution']:
    ck(len(partitions[pd['p']])==pd['conductors'])
for si,sc in enumerate(guard_ref['scenarios']):
    for offset,label in ((0,'old_runtime'),(20,'added_runtime')):
        merged=sum((metadata[p][offset+5*si+b] for p in partitions for b in range(5)),Counter())
        for k,v in merged.items():ck(v==sc[label][k])
        ck(dict(sum(original_ops[offset+5*si:offset+5*si+5],Counter()))==sc[label]['operations'])
    for b,ref in enumerate(sc['added_by_band']):
        merged=sum((metadata[p][20+5*si+b] for p in partitions),Counter())
        for k,v in merged.items():ck(v==ref[k])
        ck(dict(original_ops[20+5*si+b])==ref['operations'])
print('All saved row identities, assigned slacks and old/guard weights matched.',flush=True)
del rows_file

global_events={}
local_widths={}
context_stats=[]
processed_total=0
def bump(table,key,weights,mult,cap):
    if not mult:return
    if key not in table:
        ck(len(table)<cap, 'histogram cap')
        table[key]=[0]*40
    dest=table[key]
    for i,w in enumerate(weights):dest[i]+=mult*w

def clog(x):
    x=F(x);ck(x>0)
    ceil=(x.numerator+x.denominator-1)//x.denominator
    return (ceil-1).bit_length()

for p,ids in partitions.items():
    by_n={};created=live=peak=processed=blue=0
    def context(n,key,weights,mult):
        global created,live,peak
        if not mult:return
        table=by_n.setdefault(n,{})
        if key not in table:
            ck(created<CAP_CONTEXT, 'per-partition created-context cap')
            table[key]=[0]*40;created+=1;live+=1;peak=max(peak,live)
        dest=table[key]
        for i,w in enumerate(weights):dest[i]+=mult*w
    for rid in ids:
        c,phi,primitive,H,J,axes,ws=m['conductors'][rid]
        both=ws+gr['rows_data'][rid][-1]
        suffix=phi;kept=full=1
        for n,q in axes:
            suffix//=n
            context(n,(q,2*full),both,kept*suffix)
            kept*=n if q==0 else n-n//q;full*=n
    top=created;ck(top<=52560)
    def emit(cat,phase,n,j,a,ce,db,count,weights):
        if not count:return
        de=clog(a);ck(0<=de<=54 and db==0)
        bump(global_events,(cat,phase,n,j,de,ce,db),weights,count,125279)
        bump(local_widths,(p,cat,de,ce,db),weights,count,1197)
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
            ck(processed<=CAP_CONTEXT and processed_total<=CAP_TOTAL_CONTEXT)
            _,_,kind,children,local,total=dag[n,q]
            for cn,cq,mult,af in children:context(cn,(cq,a*af),weights,mult)
            if kind=='bluestein':
                blue+=1;P=1<<(2*n-2).bit_length();k=P.bit_length()-1;ck(k<=18)
                rad=[P*k//2-3*P//2+2,P*k,P//2-1,0,0]
                base=[2*v+(P if i in (0,4) else 0) for i,v in enumerate(rad)]
                full=[plan[str(n)]['count'][key] for key in KEYS]
                ck(all(x>=y and (x-y)%2==0 for x,y in zip(full,base)))
                pre=[(x-y)//2 for x,y in zip(full,base)]
                post=[x-y-z for x,y,z in zip(total,base,pre)]
                ck(all(x>=0 for x in post) and post[1]==post[4]==0)
                emitvec(pre,'blue_pre_chirp',n,2*a,weights)
                stages(P,2*a,'blue_forward',weights)
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
    ck(not by_n and live==0 and created==processed)
    context_stats.append(dict(p=p,rows=len(ids),top=top,processed=processed,peak_retained=peak,blue=blue))
    print('Completed p='+str(p)+' contexts='+str(processed),flush=True)
del gr,partitions
ck(len(global_events)==125279)

# Sequential comparisons avoid retaining both decoded reference event files.
for rel,offset,schema in [
 ('independent-feasibility/normalized_bluestein_events_20261111.json',0,'normalized-bluestein-event-histogram-1'),
 ('integration/normalized_transform_short_guard_events_20261111.json',20,'normalized-transform-short-guard-events-1')]:
    saved=read(rel);ck(saved['schema']==schema and len(saved['events'])==125279)
    seen=set()
    for row in saved['events']:
        ck(len(row)==8 and len(row[-1])==20)
        key=tuple(row[:-1]);ck(key not in seen and key in global_events)
        ck(row[-1]==global_events[key][offset:offset+20], 'complete normalized histogram')
        seen.add(key)
    ck(len(seen)==len(global_events))
    del saved,seen
ck(READ_NAMES==set(PINS) and READ_BYTES==95079543)
width_global={};counts=[Counter() for _ in range(40)]
for (cat,phase,n,j,de,ce,db),weights in global_events.items():
    ck(cat in CATS and db==0 and (cat!='root' or ce==1) and (cat!='kernel' or ce==0))
    bump(width_global,(cat,de,ce,db),weights,1,133)
    for i,w in enumerate(weights):counts[i][cat]+=w
ck(len(width_global)==133)
ck([list(k)+[v[:20]] for k,v in sorted(width_global.items())]==priced['normalized_width_classes'])
ck([list(k)+[v[20:]] for k,v in sorted(width_global.items())]==guard_cost['guard_width_histogram'])
rebuilt={}
local_counts={p:[Counter() for _ in range(40)] for p in range(100,109)}
for (p,cat,de,ce,db),weights in local_widths.items():
    ck((cat,de,ce,db) in width_global and len(weights)==40)
    bump(rebuilt,(cat,de,ce,db),weights,1,133)
    for i,w in enumerate(weights):local_counts[p][i][cat]+=w
ck(rebuilt==width_global)
for i,cc in enumerate(counts):
    ck(cc['scale']==0)
    ck(cc['root']+cc['kernel']==original_ops[i][KEYS[0]])
    ck(cc['add']==original_ops[i][KEYS[1]] and cc['quarter']==original_ops[i][KEYS[2]] and cc['neg']==original_ops[i][KEYS[3]])
    ck(cc['kernel']==original_ops[i][KEYS[4]])
    ref=norm['new_band_counts'][i] if i<20 else guard_cost['normalized_guard_band_counts'][i-20]
    ck(cc==Counter(ref))
del global_events,rebuilt
print('Both full normalized histograms and all width/category projections matched.',flush=True)

def A(a):return 2*((a+7)//8)+1
def M(a,b):
    x,y=(a+7)//8,(b+7)//8
    return 5*x*y+2*min(x,y)+1
def fees(p,cat,de,ce):
    a=p+14+de;b=p+ce
    return a,b
def price(mode,force=None):
    out=[Counter() for _ in range(40)]
    for (p,cat,de,ce,db),weights in local_widths.items():
        pp=p if force is None else force
        a,b=fees(pp,cat,de,ce)
        if cat in ('root','kernel'):
            r=a+b+(2 if mode=='three' else 1)
            fee={cat+'_product':M(a+1,b)+2*M(a,b+1) if mode=='three' else 4*M(a,b),
                 cat+'_exact_add':(A(a+1) if mode=='three' else 0)+2*A(r),cat+'_round_add':4*A(r+2)}
        elif cat=='add':fee={'add_complex_add':2*A(a+1)}
        else:fee={}
        for i,w in enumerate(weights):
            for key,v in fee.items():out[i][key]+=w*v
    return out
def packed(bands,si):
    subset=bands[5*si:5*si+5];parts=sum(subset,Counter())
    product=sum(v for k,v in parts.items() if k.endswith('_product'))
    return dict(parts=dict(parts),bands=[dict(x) for x in subset],product_core=product,
                addition_core=sum(parts.values())-product,core=sum(parts.values()))
def views(bands,si):
    old=packed(bands[:20],si);guard=packed(bands[20:],si)
    joint=packed([a+b for a,b in zip(bands[:20],bands[20:])],si)
    ck(joint['core']==old['core']+guard['core'])
    return dict(old=old,guard=guard,joined=joint)
baseline={}
rp=next(x for x in priced['allocations'] if x['p']==108)
gp=next(x for x in guard_cost['allocations'] if x['p']==108)
for mode in ('three','four'):
    bs=price(mode,108);baseline[mode]=[]
    for si,e in enumerate(EXTRAS):
        v=views(bs,si)
        for k in v['old']:ck(v['old'][k]==rp['profiles'][mode]['scenarios'][si][k])
        for name in ('old','guard','joined'):ck(v[name]==gp['profiles'][mode]['scenarios'][si][name], 'full p108 components')
        baseline[mode].append(dict(extra_nodes=e,**v))

# Full-plan state validation uses saved edges, without replacement planning.
ck(len(caches['full_nodes'])==38147 and len(caches['kernels'])==7606)
states={};children_seen=set()
for n,p,choice,children in caches['full_nodes']:
    ck(type(n) is int and type(p) is int and 100<=p<=108 and (n,p) not in states)
    ck(choice==plan[str(n)]['choice'])
    expected=[] if choice[0]!='split' else [[d,p] for d in choice[1:]]
    ck(children==expected and len(children)<=2)
    ck(all(2<=d<n for d,pp in children))
    states[n,p]=choice;children_seen.update(tuple(x) for x in children)
ck(expected_top<=set(states) and children_seen<=set(states))
ck(set(states)==expected_top|children_seen, 'no extra cache states')
expected_kernels=set()
for (n,p),choice in states.items():
    if choice[0]=='bluestein':expected_kernels.add((n,p,1<<(2*n-2).bit_length()))
ck(len(expected_kernels)==7606 and expected_kernels==set(map(tuple,caches['kernels'])))
base_lengths=sorted({n for n,p,P in expected_kernels})
ck(base_lengths==norm['kernel_lengths'] and len(base_lengths)==6004)
ck(sum(P for n,p,P in expected_kernels)==first['local_kernel_entries']==364355904)
basekeys=[(n,108,1<<(2*n-2).bit_length()) for n in base_lengths]
ck(sum(P for n,p,P in basekeys)==337702368)

def setup(keys,mode):
    result=Counter();by_p={p:Counter() for p in range(100,109)}
    hist=Counter()
    for n,p,P in sorted(keys):
        k=P.bit_length()-1;ck(k<=18 and P==1<<(2*n-2).bit_length())
        e=(2*n).bit_length();hist[p,e]+=P
        record=dict(kernel_keys=1,kernel_entries=P,chirp_entries=n,
            scaled_cache_complex_rounds=P,exact_real_cache_sums=2*P if mode=='three' else 0,
            scaled_cache_round_add_core=P*4*A(p+e+2),
            scaled_cache_sum_add_core=P*2*A(p+1) if mode=='three' else 0,
            kernel_fft_general_complex_products=P*k//2-3*P//2+2,
            kernel_fft_complex_add_sub=P*k,kernel_fft_quarter_turns=P//2-1,
            kernel_fft_negations=0,kernel_fft_dyadic_scales=0)
        for key,value in record.items():result[key]+=value;by_p[p][key]+=value
    result['total_added_normalized_setup_add_core']=result['scaled_cache_round_add_core']+result['scaled_cache_sum_add_core']
    return dict(totals=dict(result),by_p={str(p):dict(v) for p,v in by_p.items()},
                exponent_entry_histogram=[[p,e,w] for (p,e),w in sorted(hist.items())])
setup_baseline={};setup_local={}
for mode in ('three','four'):
    sb=setup(basekeys,mode);sl=setup(expected_kernels,mode)
    for key in ('scaled_cache_round_add_core','scaled_cache_sum_add_core','total_added_normalized_setup_add_core'):
        ck(sb['totals'][key]==rp['profiles'][mode]['setup_per_cache_lifetime'][key]==gp['profiles'][mode]['setup_per_cache_lifetime'][key], 'matched p108 setup')
    for cat in KEYS:
        ck(sb['totals']['kernel_fft_'+cat]==m['unchanged_setup']['kernel_forward_operations'][cat])
    ck(sb['totals']['chirp_entries']==m['unchanged_setup']['chirp_entries'])
    for pd in first['precision_distribution']:
        ck(sl['by_p'][str(pd['p'])]['kernel_keys']==pd['kernel_keys'])
        ck(sl['by_p'][str(pd['p'])]['kernel_entries']==pd['kernel_entries'])
    setup_baseline[mode]=sb;setup_local[mode]=sl
print('Both p108 modes, all bands/components and normalized setup matched.',flush=True)

# Only after all baseline checks, form and publish local price comparisons.
local_prices={};comparisons=[]
for mode in ('three','four'):
    bands_local=price(mode);local_prices[mode]=[]
    for si,e in enumerate(EXTRAS):
        v=views(bands_local,si);local_prices[mode].append(dict(extra_nodes=e,**v))
        for view in ('old','guard','joined'):
            old=baseline[mode][si][view];new=v[view]
            dp=old['product_core']-new['product_core'];da=old['addition_core']-new['addition_core']
            ck(dp>=0 and da>=0)
            sb=setup_baseline[mode]['totals'];sl=setup_local[mode]['totals']
            comparisons.append(dict(mode=mode,extra_nodes=e,view=view,
                runtime_product_core_reserve=dp,runtime_addition_core_reserve=da,
                local_to_global_core_ratio=str(F(new['core'],old['core'])),
                additional_cold_scale_sum_add_core=sl['total_added_normalized_setup_add_core']-sb['total_added_normalized_setup_add_core'],
                conservative_sunk_new_scale_sum_add_core=sl['total_added_normalized_setup_add_core'],
                kernel_fft_deltas={k:sl['kernel_fft_'+k]-sb['kernel_fft_'+k] for k in KEYS}))
cache_nodes_by_p={p:Counter() for p in range(100,109)}
for (n,p),choice in states.items():
    cache_nodes_by_p[p]['full_plan_states']+=1
    if choice[0]=='split':cache_nodes_by_p[p]['CT_full_root_table_entry_upper']+=n
ck(sum(v['CT_full_root_table_entry_upper'] for v in cache_nodes_by_p.values())>=m['unchanged_setup']['CT_full_root_table_entry_upper'])
ck(len({n for n,p in states})==32942)
raw_outputs=[]
def encode_output(name,obj):
    raw=json.dumps(obj,separators=(',',':')).encode()+b'\n'
    ck(len(raw)<=CAP_OUTPUT, 'data output cap')
    raw_outputs.append((name,raw))
    return dict(path=name,bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest().upper())
width_artifact=encode_output(OUT_NAMES[0],dict(schema='conductor-local-precision-price-widths-1',
    input_pins=PINS,support_pins=SUPPORT,contract_sha256=CONTRACT,
    fields=['p','category','data_ceiling_exponent','coefficient_exponent','division_bits','old20_then_guard20_weights'],
    weight_order=dict(views=['old','guard'],extras=EXTRAS,band_last_indices=ENDS),
    widths=[list(k)+[v] for k,v in sorted(local_widths.items())],
    metadata_by_p={str(p):[dict(x) for x in rows] for p,rows in metadata.items()},
    metadata_fields=['conductor_height_nodes','residue_inputs','primitive_outputs'],
    normalized_counts_by_p={str(p):[{cat:x[cat] for cat in CATS} for x in rows] for p,rows in local_counts.items()}))
summary=dict(schema='conductor-local-precision-price-receipt-1',input_pins=PINS,support_pins=SUPPORT,
    scope='Approved conservative independent-per-p normalized caches, original byte core, saved contexts only.',
    contract_sha256=CONTRACT,checks_before_receipt=CHECKS,input_bytes=READ_BYTES,
    source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
    contexts_by_p=context_stats,total_processed_contexts=processed_total,global_event_classes=125279,
    global_width_classes=133,local_width_classes=len(local_widths),width_artifact=width_artifact,
    predecessor_full_histograms_matched=True,p108_all_components_and_setup_matched=True,
    global_p108=baseline,local_prices=local_prices,comparisons=comparisons,
    setup_baseline=setup_baseline,setup_local=setup_local,full_cache_nodes_by_p={str(p):dict(x) for p,x in cache_nodes_by_p.items()},
    cache_keys=7606,cache_entries=364355904,baseline_cache_keys=6004,baseline_cache_entries=337702368,
    first_pass_receipt_sha256=PINS['major-constants/conductor_local_precision_metadata_20261111.json'][1],
    cache_membership_sha256=PINS['major-constants/conductor_local_precision_caches_20261111.json'][1],
    caps=dict(per_input_bytes=32*1024**2,aggregate_input_bytes=128*1024**2,
      live_or_processed_contexts_per_partition=CAP_CONTEXT,total_processed_contexts=CAP_TOTAL_CONTEXT,
      local_width_classes=1197,weights=40,radix_stages=18,data_file_bytes=CAP_OUTPUT,all_owned_bytes=8*1024**2),
    remaining_costs=['original kernel FFT, root/chirp generation and proof at each precision key',
      'signed/range/numeral/representation and source bindings',
      'source grid100 embedding and actual output contracts/transport',
      'cache memory, loads, retention, rebuilds and exact enclosing proof identities',
      'quarter turns, negations, permutations and all ordinary-rule proof costs',
      'all guard source/residue/completion/query/negative-adapter work',
      'actual enclosures, signs, repairs and closed count coverage',
      'small-family/principal and binary/ladder work, full analytic foundations'],
    omitted_extensions=['sharper coefficient selector','upward portfolios','shared-high kernel adapter','adaptive Gauss/wider radix/named digit arithmetic'],
    production_selected=False,numerical_evidence=False,runtime_claim=False,independent_review_pending=True,
    attempt=dict(number=1,prior_fold_failures=0))
receipt_artifact=encode_output(OUT_NAMES[1],summary)
ck(sum(len(raw) for name,raw in raw_outputs)+Path(__file__).stat().st_size<=8*1024**2)
for name,raw in raw_outputs:
    with (HERE/name).open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=CHECKS,context_stats=context_stats,local_width_classes=len(local_widths),
    artifacts=[width_artifact,receipt_artifact],main={mode:dict(global_p108=baseline[mode][0]['joined']['core'],
      local=local_prices[mode][0]['joined']['core'],setup_global=setup_baseline[mode]['totals']['total_added_normalized_setup_add_core'],
      setup_local=setup_local[mode]['totals']['total_added_normalized_setup_add_core']) for mode in ('three','four')})),flush=True)
