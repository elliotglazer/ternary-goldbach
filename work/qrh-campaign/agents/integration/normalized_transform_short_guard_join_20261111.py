"""Approved saved-context/stage fold; no planner, factors, units, gates, or values."""
from pathlib import Path
from collections import Counter
from fractions import Fraction as F
import hashlib,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
BASE='work/qrh-campaign/agents/'
CAP_CONTEXT=220108
CAP_BYTES=64*1024**2
checks=0
def ck(p):
    global checks
    assert p
    checks+=1
pins={
BASE+'integration/transform_structural_manifest_20261111.json':'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637',
BASE+'integration/transform_structural_events_20261111.json':'06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B',
BASE+'integration/transform_structural_inventory_20261111.json':'503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0',
BASE+'independent-feasibility/normalized_bluestein_events_20261111.json':'721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2',
BASE+'independent-feasibility/normalized_bluestein_structural_costs_20261111.json':'F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3',
BASE+'moebius/normalized_transform_precision_costs_20261111.json':'C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4',
BASE+'integration/short_window_guard_conductor_rows_20261111.json':'A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA',
BASE+'integration/short_window_guard_ledger_20261111.json':'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4',
BASE+'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md':'09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
BASE+'major-constants/REVIEW_NORMALIZED_BLUESTEIN_STRUCTURAL_COST_FOLD_2026-11-11.md':'49D7AA3C7D292C9A6018B178480BE8E0213C2A0725D6042D8EDC0A8C65F3B86C',
BASE+'prime-estimates/REVIEW_NORMALIZED_TRANSFORM_LOWER_PRECISION_COSTS_2026-11-11.md':'B2C3D637D9983156620A6940B2C32B65146FAED681DEB2CB36F7D3A2C4D7F4E8',
BASE+'zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md':'15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA',
}
for rel,h in pins.items():
    p=ROOT/rel
    ck(p.stat().st_size<=CAP_BYTES)
    ck(hashlib.sha256(p.read_bytes()).hexdigest().upper()==h)
def read(rel):return json.loads((ROOT/(BASE+rel)).read_bytes())
manifest=read('integration/transform_structural_manifest_20261111.json')
oldfile=read('integration/transform_structural_events_20261111.json')
oldsummary=read('integration/transform_structural_inventory_20261111.json')
normfile=read('independent-feasibility/normalized_bluestein_events_20261111.json')
normcost=read('independent-feasibility/normalized_bluestein_structural_costs_20261111.json')
price_ref=read('moebius/normalized_transform_precision_costs_20261111.json')
guards=read('integration/short_window_guard_conductor_rows_20261111.json')
guard_ref=read('integration/short_window_guard_ledger_20261111.json')
KEYS=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
EXTRAS=[0,167,320,640]
ENDS=manifest['band_last_indices']
ck(EXTRAS==manifest['extras']==guards['extras'])
ck(ENDS==guards['band_last_indices'])
ck(len(manifest['conductors'])==len(guards['rows_data'])==125400)
ck(manifest['unchanged_setup']==oldsummary['setup']==normcost['setup_kernel_fft_unchanged']==price_ref['unchanged_setup_operation_counts'])
dag={(r[0],r[1]):r for r in manifest['requests']}
plan=manifest['plan']
ck(len(dag)==35190)
def clog(x):
    x=F(x);k=max(0,x.numerator.bit_length()-x.denominator.bit_length())
    while (1<<k)*x.denominator<x.numerator:k+=1
    while k and (1<<(k-1))*x.denominator>=x.numerator:k-=1
    return k
def bump(table,key,ws,mult=1):
    if not mult:return
    if key not in table:
        ck(len(table)<CAP_CONTEXT)
        table[key]=[0]*len(ws)
    for i,w in enumerate(ws):table[key][i]+=mult*w
def prefix_weights(count):
    out=[];lo=0
    for hi in ENDS:
        out.append(max(0,min(count,hi+1)-lo));lo=hi+1
    ck(sum(out)==count)
    return out

# Read-only join. Recompute only bounded prefix intersections, not conductor data.
by_n={};metadata=[Counter() for _ in range(20)]
for row,gr in zip(manifest['conductors'],guards['rows_data']):
    c,phi,primitive,H,J,axes,ws=row
    gc,gJ,gphi,gprimitive,ops,gws=gr
    ck((c,J,phi,primitive)==(gc,gJ,gphi,gprimitive))
    ck(len(ws)==len(gws)==20)
    expected=[];old_expected=[]
    for extra in EXTRAS:
        base=prefix_weights(J+extra);extended=prefix_weights(J+extra+41)
        old_expected+=base
        expected += [v-u for u,v in zip(base,extended)]
    ck(ws==old_expected and gws==expected)
    for i,w in enumerate(gws):
        metadata[i]['conductor_height_nodes']+=w
        metadata[i]['residue_inputs']+=phi*w
        metadata[i]['primitive_outputs']+=primitive*w
        for key,v in zip(KEYS,ops):metadata[i][key]+=v*w
    suffix=phi;kept=full=1;perheight=[0]*5
    both=ws+gws
    for n,q in axes:
        ck((n,q) in dag and suffix%n==0)
        suffix//=n;mult=kept*suffix
        bump(by_n.setdefault(n,{}),(q,2*full),both,mult)
        for i,v in enumerate(dag[n,q][5]):perheight[i]+=mult*v
        kept*=n if q==0 else n-n//q
        full*=n
    ck(full==phi and kept==primitive and suffix==1 and perheight==ops)
ck(sum(map(len,by_n.values()))==oldsummary['top_contexts']==52560)
for si,sc in enumerate(guard_ref['scenarios']):
    for bi,band in enumerate(sc['added_by_band']):
        m=metadata[5*si+bi]
        for key in ('conductor_height_nodes','residue_inputs','primitive_outputs'):ck(m[key]==band[key])
        ck({k:m[k] for k in KEYS}==band['operations'])
print('Saved row joins and all guard band weights matched.',flush=True)

original={};normalized={};contexts=0;blue_contexts=0
def emit(table,cat,phase,n,stage,a,ce,db,count,ws):
    if count:bump(table,(cat,phase,n,stage,clog(a),ce,db),ws,count)
def emitvec(table,vec,phase,n,a,ws):
    for i,count in enumerate(vec):
        ck(i!=4 or count==0)
        emit(table,('root','add','quarter','neg','scale')[i],phase,n,0,a,1 if i==0 else 0,0,count,ws)
def stages(table,P,a,phase,ws):
    k=P.bit_length()-1;ck(k<=18)
    for j in range(1,k+1):
        copies=P//(1<<j);quarter=int(j>=2)
        emit(table,'root',phase,P,j,(1<<j)*a,1,0,copies*((1<<(j-1))-1-quarter),ws)
        emit(table,'quarter',phase,P,j,(1<<j)*a,0,0,copies*quarter,ws)
        emit(table,'add',phase,P,j,(1<<(j+1))*a,0,0,P,ws)
for n in sorted({n for n,q in dag},reverse=True):
    for (q,a),ws in by_n.pop(n,{}).items():
        contexts+=1;ck(contexts<=CAP_CONTEXT)
        _,_,kind,children,local,total=dag[n,q]
        for cn,cq,mult,af in children:
            ck(cn<n and mult>=0 and af>=1)
            bump(by_n.setdefault(cn,{}),(cq,a*af),ws,mult)
        if kind=='bluestein':
            blue_contexts+=1
            P=1<<(2*n-2).bit_length();k=P.bit_length()-1;ck(k<=18)
            rad=[P*k//2-3*P//2+2,P*k,P//2-1,0,0]
            base=[2*v+(P if i in (0,4) else 0) for i,v in enumerate(rad)]
            full=[plan[str(n)]['count'][key] for key in KEYS]
            ck(all(x>=y and (x-y)%2==0 for x,y in zip(full,base)))
            pre=[(x-y)//2 for x,y in zip(full,base)]
            post=[x-y-z for x,y,z in zip(total,base,pre)]
            ck(all(x>=0 for x in post) and post[1]==post[4]==0)
            for table,new in ((original,False),(normalized,True)):
                Z=F(n*(2*n-1),P)+2 if new else 2*n*(n+1)+2
                emitvec(table,pre,'blue_pre_chirp',n,2*a,ws)
                stages(table,P,2*a,'blue_forward',ws)
                emit(table,'kernel','blue_point',n,0,(n+2)*a,0 if new else clog(2*n+1),0,P,ws)
                stages(table,P,Z*a,'blue_inverse',ws)
                if not new:emit(table,'scale','blue_inverse_division',n,0,2*P*Z*a,0,k,P,ws)
                emitvec(table,post,'blue_post_chirp',n,(2*n if new else 4*Z+4)*a,ws)
        else:
            for table in (original,normalized):
                if kind=='ct':
                    r,m=(2,n//2) if plan[str(n)]['choice'][0]=='radix2' else plan[str(n)]['choice'][1:]
                    emitvec(table,local,'ct_bridge',n,2*m*a,ws)
                elif kind=='radix2':stages(table,n,a,'radix',ws)
                elif kind=='pruned_two':emit(table,'add','pruned_two',n,1,4*a,0,0,1,ws)
                elif kind=='direct_prime':emitvec(table,total,'direct',n,2*n*a,ws)
                else:raise AssertionError(kind)
ck(not by_n and contexts==oldsummary['expanded_contexts']==CAP_CONTEXT)
ck(blue_contexts==normcost['blue_contexts'])
# Both full historical histograms must match before any successor output is written.
for generated,saved in ((original,oldfile),(normalized,normfile)):
    ck({k:v[:20] for k,v in generated.items()}=={tuple(r[:-1]):r[-1] for r in saved['events']})
print('Both complete predecessor histograms matched; contexts='+str(contexts),flush=True)

def fold(table,offset):
    widths={};counts=[Counter() for _ in range(20)]
    for (cat,phase,n,j,de,ce,db),v in table.items():
        ws=v[offset:offset+20]
        ck(len(ws)==20 and 0<=de<=54)
        if not any(ws):continue
        bump(widths,(cat,de,ce,db),ws)
        for i,w in enumerate(ws):counts[i][cat]+=w
    return widths,counts
oldwidth,oldcounts=fold(normalized,0)
guardwidth,guardcounts=fold(normalized,20)
_,original_guard_counts=fold(original,20)
ck([list(k)+[v] for k,v in sorted(oldwidth.items())]==price_ref['normalized_width_classes'])
for i in range(20):
    for cat in ('root','kernel','add','quarter','neg'):ck(guardcounts[i][cat]==original_guard_counts[i][cat])
    ck(guardcounts[i]['scale']==0)
    sc=guard_ref['scenarios'][i//5]['added_by_band'][i%5]
    g=original_guard_counts[i]
    ck(g['root']==sc['root_products'] and g['kernel']==sc['kernel_products']==g['scale'])
    ck(dict(zip(KEYS,[g['root']+g['kernel'],g['add'],g['quarter'],g['neg'],g['scale']]))==sc['operations'])

def A(bits):return 2*((bits+7)//8)+1
def M(a,b):
    m,n=(a+7)//8,(b+7)//8
    return 5*m*n+2*min(m,n)+1
def price(widths,p,mode):
    bands=[Counter() for _ in range(20)]
    for (cat,de,ce,db),ws in widths.items():
        a=p+14+de
        if cat in ('root','kernel'):
            b=p+ce;r=a+b+(2 if mode=='three' else 1)
            fees={cat+'_product':M(a+1,b)+2*M(a,b+1) if mode=='three' else 4*M(a,b),
                cat+'_exact_add':(A(a+1) if mode=='three' else 0)+2*A(r),cat+'_round_add':4*A(r+2)}
        elif cat=='add':fees={'add_complex_add':2*A(a+1)}
        else:fees={}
        for i,w in enumerate(ws):
            for key,v in fees.items():bands[i][key]+=w*v
    return bands
def packed(bands,si):
    subset=bands[5*si:5*si+5];parts=sum(subset,Counter())
    prod=sum(v for k,v in parts.items() if k.endswith('_product'))
    return dict(parts=dict(parts),bands=[dict(x) for x in subset],product_core=prod,addition_core=sum(parts.values())-prod,core=sum(parts.values()))
allocations=[]
for p in (106,108,112):
    ref=next(x for x in price_ref['allocations'] if x['p']==p)
    profiles={}
    for mode in ('three','four'):
        oldbands=price(oldwidth,p,mode);gbands=price(guardwidth,p,mode)
        joined=[x+y for x,y in zip(oldbands,gbands)];scenarios=[]
        for si,extra in enumerate(EXTRAS):
            old=packed(oldbands,si);guard=packed(gbands,si);joint=packed(joined,si)
            rr=ref['profiles'][mode]['scenarios'][si]
            for key in old:ck(old[key]==rr[key])
            ck(joint['core']==old['core']+guard['core'])
            scenarios.append(dict(extra_nodes=extra,old=old,guard=guard,joined=joint,
                guard_to_old_core_ratio=str(F(guard['core'],old['core'])),
                guard_operation_counts=dict(sum(guardcounts[5*si:5*si+5],Counter()))))
        setup=ref['profiles'][mode]['setup_per_cache_lifetime']
        hist=price_ref['setup_exponent_entry_histogram']
        ck(setup['scaled_cache_round_add_core']==sum(x['entries']*4*A(p+x['exponent']+2) for x in hist))
        ck(setup['scaled_cache_sum_add_core']==(sum(x['entries'] for x in hist)*2*A(p+1) if mode=='three' else 0))
        profiles[mode]=dict(scenarios=scenarios,setup_per_cache_lifetime=setup,extra_setup_due_to_guards=0)
    allocations.append(dict(p=p,profiles=profiles))

new_events=[list(k)+[v[20:]] for k,v in sorted(normalized.items()) if any(v[20:])]
artifact_data=dict(schema='normalized-transform-short-guard-events-1',pins=pins,
    key_fields=oldfile['key_fields'],count_order='scenario [0,167,320,640], band [500,1000,2000,5000,10000]',
    phase_context_reconstruction='Saved DAG only; exact rational normalized Z before ceiling.',events=new_events)
raw=(json.dumps(artifact_data,separators=(',',':'))+'\n').encode()
artifact=dict(path='normalized_transform_short_guard_events_20261111.json',bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest().upper())
result=dict(scope='Conditional normalized circuit on conservative +41 guard superset. No new values or precision selection.',
    pins=pins,checks=checks,contexts=contexts,blue_contexts=blue_contexts,
    original_histogram_match=True,normalized_histogram_match=True,
    original_event_classes=len(original),normalized_event_classes=len(normalized),guard_event_classes=len(new_events),
    old_width_classes=len(oldwidth),guard_width_classes=len(guardwidth),
    guard_width_histogram=[list(k)+[v] for k,v in sorted(guardwidth.items())],
    original_guard_band_counts=[dict(x) for x in original_guard_counts],normalized_guard_band_counts=[dict(x) for x in guardcounts],
    guard_metadata_by_band=[dict(x) for x in metadata],allocations=allocations,
    unchanged_setup=manifest['unchanged_setup'],guard_source_reference_sha256=pins[BASE+'integration/short_window_guard_ledger_20261111.json'],
    source_and_evaluator_baseline='All guard source work and full P20 baseline remain separately charged; no actual-height K18 extension adopted.',
    negative_and_query_work='Same 41 inverse-character negative adapters and 83-term query kernels from guard receipt; no free overlap or successful signs.',
    remaining_prices=['signed/range/encoding/binding and proof generation/checking','quarter turns, negations, permutation, memory and cache traffic',
        'precision-specific root/kernel/cache production and imports','all guard seed, contraction, completion, negative-adapter and interpolation work',
        'actual input uncertainty, total sign margins, adaptive repairs and completeness'],
    artifact=artifact,precision_selected=False,production_adopted=False,independent_review_pending=True,
    caps=dict(contexts=CAP_CONTEXT,stage_levels_per_radix=18,combined_new_bytes=CAP_BYTES,summary_bytes=1024**2))
summary_raw=(json.dumps(result,separators=(',',':'))+'\n').encode()
ck(len(summary_raw)<=1024**2 and len(raw)+len(summary_raw)<=CAP_BYTES)
for filename,data in ((artifact['path'],raw),('normalized_transform_short_guard_join_20261111.json',summary_raw)):
    with (HERE/filename).open('xb') as out:out.write(data)
print(json.dumps(dict(checks=checks,contexts=contexts,guard_classes=len(new_events),artifact=artifact,
    receipt_bytes=len(summary_raw),receipt_sha256=hashlib.sha256(summary_raw).hexdigest().upper(),
    main=[dict(p=a['p'],**{mode:{k:a['profiles'][mode]['scenarios'][0][k]['core'] for k in ('old','guard','joined')} for mode in ('three','four')}) for a in allocations]),indent=2))
