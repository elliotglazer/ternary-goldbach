"""Saved-manifest fold only. No plan/factor generation, unit or value enumeration."""
from pathlib import Path
from collections import defaultdict,Counter
from fractions import Fraction as F
import hashlib,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PREFIX='work/qrh-campaign/agents/'
MAX_CLASSES=1_000_000
MAX_BYTES=64*1024*1024
checks=0
def ck(p):
    global checks
    assert p
    checks+=1
pins={
 PREFIX+'integration/transform_structural_manifest_20261111.json':'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637',
 PREFIX+'integration/transform_structural_events_20261111.json':'06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B',
 PREFIX+'integration/transform_structural_inventory_20261111.json':'503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0',
 PREFIX+'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md':'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
 PREFIX+'independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md':'412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7',
 PREFIX+'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md':'09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
 PREFIX+'major-constants/REVIEW_LOCAL_TRANSFORM_WIDTH_COSTS_2026-11-11.md':'AB802176B2AA36DA1ACE341663B4DB0A97BB924112140F0241E80437B93D464F',
 'work/qrh-blueprint/LOCAL_TRANSFORM_WIDTH_COSTS_2026-11-11.md':'1A3DC2D8A7593ADD30DCBCE77FAAA3C93A902AC8FE2D98D73F3905DE4A13AF3B',
 'work/qrh-blueprint/local_transform_width_costs_20261111.json':'5D4C79F0958F69577D250B35F7FF5C81B7C25E4AC755C8CB3517D699F2891DA1',
}
for rel,h in pins.items():
    path=ROOT/rel
    ck(path.stat().st_size<=MAX_BYTES)
    ck(hashlib.sha256(path.read_bytes()).hexdigest().upper()==h)
def read(rel):return json.loads((ROOT/rel).read_text(encoding='utf-8'))
manifest=read(PREFIX+'integration/transform_structural_manifest_20261111.json')
saved_events=read(PREFIX+'integration/transform_structural_events_20261111.json')
summary=read(PREFIX+'integration/transform_structural_inventory_20261111.json')
priced=read('work/qrh-blueprint/local_transform_width_costs_20261111.json')
ck(manifest['schema']=='selected-transform-structural-manifest-1')
ck(saved_events['manifest_sha256'].upper()==pins[PREFIX+'integration/transform_structural_manifest_20261111.json'])
ck(len(manifest['conductors'])==125400)
ck(len(manifest['requests'])==35190)
ck(len(saved_events['events'])==138126)
dag={(r[0],r[1]):r for r in manifest['requests']}
ck(len(dag)==len(manifest['requests']))
plan=manifest['plan']
def plen(n):return 1<<(2*n-2).bit_length()
def clog(x):
    x=F(x)
    k=max(0,x.numerator.bit_length()-x.denominator.bit_length())
    while 2**k*x.denominator<x.numerator:k+=1
    while k and 2**(k-1)*x.denominator>=x.numerator:k-=1
    return k
def bump(table,key,ws,mult=1):
    if not mult:return
    if key not in table:
        ck(len(table)<MAX_CLASSES)
        table[key]=[0]*20
    target=table[key]
    for i,w in enumerate(ws):target[i]+=w*mult

# Iterate saved rows. No arithmetic height/factor/axis reconstruction is performed.
by_n={};top_axes=set();unit=[0]*20
for row in manifest['conductors']:
    c,v,np,H,J,axes,ws=row
    ck(len(ws)==20 and all(type(w) is int and w>=0 for w in ws))
    suffix=v;kept=full=1
    for i,w in enumerate(ws):unit[i]+=v*w
    for n,q in axes:
        ck((n,q) in dag and suffix%n==0)
        top_axes.add(n);suffix//=n
        group=by_n.setdefault(n,{})
        bump(group,(q,2*full),ws,kept*suffix)
        kept*=n if q==0 else n-n//q
        full*=n
    ck(full==v and kept==np and suffix==1)
ck(unit==summary['unit_band'])
ck(sum(map(len,by_n.values()))==summary['top_contexts'])

phase_set={'blue_point','blue_inverse','blue_inverse_division','blue_post_chirp'}
old_changed={}
new_changed={}
blue_contexts=0;contexts=0
def emit(table,cat,phase,n,stage,a,ce,db,count,ws):
    if count:bump(table,(cat,phase,n,stage,clog(a),ce,db),ws,count)
def radix_events(table,P,a,ws):
    for j in range(1,P.bit_length()):
        copies=P//2**j
        emit(table,'root','blue_inverse',P,j,2**j*a,1,0,copies*(2**(j-1)-1-int(j>=2)),ws)
        emit(table,'quarter','blue_inverse',P,j,2**j*a,0,0,copies*int(j>=2),ws)
        emit(table,'add','blue_inverse',P,j,2**(j+1)*a,0,0,P,ws)
def radix_counts(P):
    k=P.bit_length()-1
    return [P*k//2-3*P//2+2,P*k,P//2-1,0,0]
keys=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
for n in sorted({n for n,q in dag},reverse=True):
    group=by_n.pop(n,{})
    for (q,a),ws in group.items():
        contexts+=1;ck(contexts<=MAX_CLASSES)
        _,_,kind,children,local,counts=dag[(n,q)]
        for cn,cq,mult,af in children:
            ck(cn<n and mult>=0 and af>=1)
            bump(by_n.setdefault(cn,{}),(cq,a*af),ws,mult)
        if kind!='bluestein':continue
        blue_contexts+=1
        P=plen(n);k=P.bit_length()-1;ck(k<=18)
        rad=radix_counts(P)
        base=[2*x+(P if i in (0,4) else 0) for i,x in enumerate(rad)]
        fullcounts=[plan[str(n)]['count'][key] for key in keys]
        pre=[]
        for x,y in zip(fullcounts,base):
            ck(x>=y and (x-y)%2==0)
            pre.append((x-y)//2)
        post=[x-y-z for x,y,z in zip(counts,base,pre)]
        ck(all(x>=0 for x in post) and post[1]==post[4]==0)
        Zo=2*n*(n+1)+2
        Zn=F(n*(2*n-1),P)+2
        emit(old_changed,'kernel','blue_point',n,0,(n+2)*a,clog(2*n+1),0,P,ws)
        emit(new_changed,'kernel','blue_point',n,0,(n+2)*a,0,0,P,ws)
        radix_events(old_changed,P,Zo*a,ws)
        radix_events(new_changed,P,Zn*a,ws)
        emit(old_changed,'scale','blue_inverse_division',n,0,2*P*Zo*a,0,k,P,ws)
        for i,count in enumerate(post):
            cat=['root','add','quarter','neg','scale'][i]
            emit(old_changed,cat,'blue_post_chirp',n,0,(4*Zo+4)*a,1 if i==0 else 0,0,count,ws)
            emit(new_changed,cat,'blue_post_chirp',n,0,2*n*a,1 if i==0 else 0,0,count,ws)
ck(not by_n and contexts==summary['expanded_contexts'])
selected_old={tuple(r[:-1]):r[-1] for r in saved_events['events'] if r[1] in phase_set}
ck(selected_old==old_changed)
unchanged={tuple(r[:-1]):r[-1] for r in saved_events['events'] if r[1] not in phase_set}
combined=dict(unchanged)
for key,ws in new_changed.items():bump(combined,key,ws)
ck(len(combined)<=MAX_CLASSES)

def folded(events):
    widths={};counts=[Counter() for _ in range(20)]
    for (cat,phase,n,stage,de,ce,db),ws in events.items():
        ck(len(ws)==20 and 0<=de<=54)
        bump(widths,(cat,de,ce,db),ws)
        for i,w in enumerate(ws):counts[i][cat]+=w
    return widths,counts
old_all={tuple(r[:-1]):r[-1] for r in saved_events['events']}
old_width,old_counts=folded(old_all)
new_width,new_counts=folded(combined)
for i in range(20):
    for cat in ['root','kernel','add','quarter','neg']:ck(old_counts[i][cat]==new_counts[i][cat])
    ck(new_counts[i]['scale']==0)
for si,sc in enumerate(summary['scenarios']):
    counts=sum((old_counts[si*5+j] for j in range(5)),Counter())
    ck(counts['root']==sc['root_products'] and counts['kernel']==sc['kernel_products'])
    for cat,key in [('add','complex_add_sub'),('quarter','quarter_turns'),('neg','negations'),('scale','dyadic_scales')]:
        ck(counts[cat]==sc['operations'][key])

# Cache set is obtained by following saved full-plan choices from saved axes.
# Pruning does not remove the retained full-cache construction.
active=set();todo=list(top_axes)
while todo:
    n=todo.pop()
    if n in active:continue
    active.add(n);ck(len(active)<=MAX_CLASSES)
    choice=plan[str(n)]['choice']
    if choice[0]=='split':todo.extend(choice[1:])
kernels=sorted(n for n in active if plan[str(n)]['choice'][0]=='bluestein')
ck(len(kernels)==summary['setup']['kernel_count']==6004)
ck(sum(plen(n) for n in kernels)==summary['setup']['kernel_entries']==337702368)

def add(w):return 2*((w+7)//8)+1
def mul(a,b):
    m,n=(a+7)//8,(b+7)//8
    return 5*m*n+2*min(m,n)+1
def price(widths,p,three):
    bands=[Counter() for _ in range(20)]
    for (cat,de,ce,db),ws in widths.items():
        a=p+14+de
        if cat in ('root','kernel'):
            b=p+ce;r=a+b+(2 if three else 1)
            fee=dict(product=mul(a+1,b)+2*mul(a,b+1) if three else 4*mul(a,b),
                exact_add=(add(a+1) if three else 0)+2*add(r),round_add=4*add(r+2))
        elif cat=='add':fee=dict(complex_add=2*add(a+1))
        elif cat=='scale':fee=dict(scale_round_add=4*add(a+2))
        else:fee={}
        for i,w in enumerate(ws):
            for key,value in fee.items():bands[i][cat+'_'+key]+=w*value
    return bands
allocations=[]
for reference in priced['allocations']:
    p=reference['p'];ck(p in [112,134,152]);out={}
    setup_scale=sum(plen(n)*4*add(p+clog(2*n+1)+2) for n in kernels)
    old_sum=sum(plen(n)*2*add(p+clog(2*n+1)+1) for n in kernels)
    new_sum=sum(plen(n)*2*add(p+1) for n in kernels)
    for three in [True,False]:
        name='three' if three else 'four'
        ob=price(old_width,p,three);nb=price(new_width,p,three)
        scenarios=[]
        for si,ref in enumerate(reference['profiles'][name]['scenarios']):
            op=sum((ob[si*5+j] for j in range(5)),Counter())
            np=sum((nb[si*5+j] for j in range(5)),Counter())
            ck(dict(op)==ref['parts'])
            ck(sum(op.values())==ref['local_core'])
            ck(all(dict(ob[si*5+j])==ref['bands'][j] for j in range(5)))
            ck(sum(np.values())<=sum(op.values()))
            scenarios.append(dict(extra_nodes=ref['extra_nodes'],old_core=sum(op.values()),new_core=sum(np.values()),
                core_saved=sum(op.values())-sum(np.values()),fraction_of_old=str(F(sum(np.values()),sum(op.values()))),
                old_parts=dict(op),new_parts=dict(np),new_bands=[dict(x) for x in nb[si*5:si*5+5]]))
        out[name]=dict(scenarios=scenarios,new_scale_setup_add_core=setup_scale,
            old_kernel_sum_add_core=old_sum if three else 0,new_kernel_sum_add_core=new_sum if three else 0)
    allocations.append(dict(p=p,profiles=out))

def write(name,data):
    raw=(json.dumps(data,separators=(',',':'))+'\n').encode()
    ck(len(raw)<=MAX_BYTES)
    path=HERE/name
    with path.open('xb') as f:f.write(raw)
    return dict(path=name,bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest().upper())
artifact=write('normalized_bluestein_events_20261111.json',dict(
    schema='normalized-bluestein-event-histogram-1',source_manifest_sha256=pins[PREFIX+'integration/transform_structural_manifest_20261111.json'],
    proof=pins[PREFIX+'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md'],
    key_fields=saved_events['key_fields'],kernel_coefficient_exponent_zero_means_grid_p_norm_below_one=True,
    events=[list(k)+[v] for k,v in sorted(combined.items())]))
result=dict(scope='Conditional changed-circuit fold of saved rows/DAG only. No new conductor/plan enumeration or values.',
    pins=pins,checks=checks,contexts=contexts,blue_contexts=blue_contexts,old_event_classes=len(old_all),new_event_classes=len(combined),
    unchanged_event_classes=len(unchanged),old_width_classes=len(old_width),new_width_classes=len(new_width),
    setup_kernel_fft_unchanged=summary['setup'],kernel_lengths=kernels,allocations=allocations,artifact=artifact,
    old_band_counts=[dict(x) for x in old_counts],new_band_counts=[dict(x) for x in new_counts],
    mathematical_review_pending=False,structural_cost_review_pending=True,production_adopted=False,precision_selected=False,
    remaining_prices=['scaled-cache enclosures/binding','signed/canonical/range/shift proofs','cache lifetimes/rebuilds/storage',
                      'root/kernel/input certification','numerals/proof production/checking','new output signs and complete radii'])
receipt=write('normalized_bluestein_structural_costs_20261111.json',result)
print(json.dumps({'checks':checks,'contexts':contexts,'blue_contexts':blue_contexts,'event_classes':len(combined),
    'artifact':artifact,'receipt':receipt,'main':[{ 'p':a['p'],**{name:a['profiles'][name]['scenarios'][0]['new_core'] for name in ['three','four']},
      'setup_add':a['profiles']['three']['new_scale_setup_add_core']} for a in allocations]},indent=2))
