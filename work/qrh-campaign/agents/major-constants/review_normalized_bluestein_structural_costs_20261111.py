"""Independent saved-row review. No author imports, inventory generation or values."""
from pathlib import Path
from collections import defaultdict, Counter
from fractions import Fraction as Q
import hashlib, json

ROOT=Path(__file__).resolve().parents[4]
AG=ROOT/'work/qrh-campaign/agents'
HERE=Path(__file__).resolve().parent
checks=0
def check(ok):
    global checks
    assert ok
    checks+=1
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def load(p): return json.loads(p.read_text(encoding='utf-8'))
author_dir=AG/'independent-feasibility'
named={
 'NORMALIZED_BLUESTEIN_STRUCTURAL_COST_FOLD_2026-11-11.md':'F673EFE298538627F30DEAFD2C7F5AFF9606BA468D887A76677E14FF5C963B46',
 'normalized_bluestein_structural_costs_20261111.py':'69F73DC72ACAE4646FD665B6B2895B7556EE9E5CA3F090C16E37AF02E54AB625',
 'normalized_bluestein_events_20261111.json':'721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2',
 'normalized_bluestein_structural_costs_20261111.json':'F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3'}
pins={str((author_dir/n).relative_to(ROOT)):h for n,h in named.items()}
target=load(author_dir/'normalized_bluestein_structural_costs_20261111.json')
pins.update(target['pins'])
pins['work/qrh-campaign/agents/moebius/REVIEW_TRANSFORM_STRUCTURAL_MULTIPLICITY_INVENTORY_2026-11-11.md']='2D5CE1CDB699A0026E5B84F51FB2C05F4C09928C0B062B2E95B6DDBE8F8B748D'
for rel,h in pins.items():
    check((ROOT/rel).stat().st_size<64*1024*1024)
    check(sha(ROOT/rel)==h)
manifest=load(AG/'integration/transform_structural_manifest_20261111.json')
old_json=load(AG/'integration/transform_structural_events_20261111.json')
new_json=load(author_dir/'normalized_bluestein_events_20261111.json')
summary=load(AG/'integration/transform_structural_inventory_20261111.json')
local=load(ROOT/'work/qrh-blueprint/local_transform_width_costs_20261111.json')
check(manifest['extras']==[0,167,320,640])
check(manifest['band_last_indices']==[6400,12800,25600,64000,128000])
check(new_json['source_manifest_sha256']==old_json['manifest_sha256'].upper())
check(new_json['kernel_coefficient_exponent_zero_means_grid_p_norm_below_one'] is True)
check(manifest['unchanged_setup']==summary['setup']==target['setup_kernel_fft_unchanged'])

def accumulate(table,key,weights,times=1):
    if times==0:return
    if key not in table:
        check(len(table)<1_000_000)
        table[key]=[0]*20
    for i,w in enumerate(weights): table[key][i]+=times*w

# Axis output multiplicity and norm growth are reconstructed separately.
requests={(row[0],row[1]):row for row in manifest['requests']}
check(len(requests)==len(manifest['requests'])==35190)
contexts=defaultdict(dict)
axes=set(); units=[0]*20
for c,phi,primitive,H,J,ordered,weights in manifest['conductors']:
    check(len(weights)==20 and all(type(w) is int and w>=0 for w in weights))
    size_product=1; output_product=1
    suffixes=[1]*(len(ordered)+1)
    for j in range(len(ordered)-1,-1,-1): suffixes[j]=suffixes[j+1]*ordered[j][0]
    check(suffixes[0]==phi)
    for j,(n,q) in enumerate(ordered):
        check((n,q) in requests and (q==0 or n%q==0))
        axes.add(n)
        accumulate(contexts[n],(q,2*size_product),weights,output_product*suffixes[j+1])
        size_product*=n
        output_product*=n if q==0 else n-n//q
    check(output_product==primitive)
    for i,w in enumerate(weights):units[i]+=phi*w
check(units==summary['unit_band'])
check(sum(map(len,contexts.values()))==summary['top_contexts']==52560)

def ceil_log(x):
    x=Q(x); check(x>=1)
    e=0; bound=x.denominator
    while bound<x.numerator: e+=1;bound*=2
    return e
def P_of(n):return 1<<(2*n-2).bit_length()
changed_phases={'blue_point','blue_inverse','blue_inverse_division','blue_post_chirp'}
old_changed={}; new_changed={}; num_context=0; blue=0; blue_lengths=set()
def event(table,cat,phase,n,stage,factor,ce,div,count,weights):
    check(type(count) is int and count>=0)
    if count:accumulate(table,(cat,phase,n,stage,ceil_log(factor),ce,div),weights,count)
types=['root','add','quarter','neg','scale']
count_names=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
for n in sorted({k[0] for k in requests},reverse=True):
    bucket=contexts.pop(n,{})
    for (q,norm),weights in bucket.items():
        num_context+=1;check(num_context<=1_000_000)
        _,_,kind,children,_,total=requests[(n,q)]
        for cn,cq,multiplicity,normfactor in children:
            check(cn<n and multiplicity>=0 and normfactor>=1)
            accumulate(contexts[cn],(cq,norm*normfactor),weights,multiplicity)
        if kind!='bluestein':continue
        blue+=1;blue_lengths.add(n)
        P=P_of(n);depth=P.bit_length()-1
        check(2*n-1<=P<4*n and depth<=18)
        # Count inverse stages explicitly instead of the closed radix formula.
        stages=[];radix=[0]*5
        for level in range(depth):
            size=2**(level+1); blocks=P//size
            quarter=blocks if level else 0
            root=blocks*(size//2-1)-quarter
            stages.append((level+1,root,quarter))
            radix[0]+=root;radix[1]+=P;radix[2]+=quarter
        fixed=[2*x for x in radix];fixed[0]+=P;fixed[4]+=P
        full=[manifest['plan'][str(n)]['count'][key] for key in count_names]
        pre=[(full[i]-fixed[i])//2 for i in range(5)]
        check(all(full[i]-fixed[i]==2*pre[i] and pre[i]>=0 for i in range(5)))
        post=[total[i]-fixed[i]-pre[i] for i in range(5)]
        check(min(post)>=0 and post[1]==post[4]==0)
        oldZ=2*n*(n+1)+2;newZ=Q(n*(2*n-1),P)+2
        for table,Z,normalized in [(old_changed,oldZ,False),(new_changed,newZ,True)]:
            event(table,'kernel','blue_point',n,0,(n+2)*norm,0 if normalized else ceil_log(2*n+1),0,P,weights)
            for stage,r,t in stages:
                event(table,'root','blue_inverse',P,stage,2**stage*Z*norm,1,0,r,weights)
                event(table,'quarter','blue_inverse',P,stage,2**stage*Z*norm,0,0,t,weights)
                event(table,'add','blue_inverse',P,stage,2**(stage+1)*Z*norm,0,0,P,weights)
            if not normalized:event(table,'scale','blue_inverse_division',n,0,2*P*Z*norm,0,depth,P,weights)
            factor=2*n if normalized else 4*Z+4
            for cat,count in zip(types,post):
                event(table,cat,'blue_post_chirp',n,0,factor*norm,1 if cat=='root' else 0,0,count,weights)
check(not contexts)
check(num_context==target['contexts']==summary['expanded_contexts']==220108)
check(blue==target['blue_contexts']==26064)
def unpack(rows):
    out={tuple(row[:-1]):row[-1] for row in rows}
    check(len(out)==len(rows))
    return out
old=unpack(old_json['events']);claimed=unpack(new_json['events'])
check({k:v for k,v in old.items() if k[1] in changed_phases}==old_changed)
new={k:v for k,v in old.items() if k[1] not in changed_phases}
check(len(new)==target['unchanged_event_classes']==95962)
for k,v in new_changed.items():accumulate(new,k,v)
check(new==claimed)
check(len(new)==target['new_event_classes']==125279)

def widths_and_counts(events):
    widths={};counts=[Counter() for _ in range(20)]
    for (cat,phase,n,stage,de,ce,div),weights in events.items():
        check(0<=de<=54)
        if cat=='kernel':check(ce in (0,ceil_log(2*n+1)))
        elif cat=='root':check(ce==1)
        else:check(ce==0)
        accumulate(widths,(cat,de,ce,div),weights)
        for i,w in enumerate(weights):counts[i][cat]+=w
    return widths,counts
ow,oc=widths_and_counts(old);nw,nc=widths_and_counts(new)
check(len(ow)==400 and len(nw)==133)
check([[*k,v] for k,v in sorted(ow.items())]==local['width_multiplicities'])
for i in range(20):
    check(dict(oc[i])==target['old_band_counts'][i])
    check(dict(nc[i])==target['new_band_counts'][i])
    for cat in ('root','kernel','add','quarter','neg'):check(oc[i][cat]==nc[i][cat])
    check(nc[i]['scale']==0 and nc[i]['kernel']>0)

# Full cache availability is independent of the pruned runtime context.
active=set();pending=list(axes)
while pending:
    n=pending.pop()
    if n in active:continue
    active.add(n);check(len(active)<=1_000_000)
    choice=manifest['plan'][str(n)]['choice']
    if choice[0]=='split':pending.extend(choice[1:])
kernels=sorted(n for n in active if manifest['plan'][str(n)]['choice'][0]=='bluestein')
check(blue_lengths<=set(kernels))
check(kernels==target['kernel_lengths'])
check(len(active)==32942 and len(kernels)==6004)
check(sum(map(P_of,kernels))==337702368)

def add_cost(bits):return 2*((bits+7)//8)+1
def product_cost(x,y):
    bx,by=(x+7)//8,(y+7)//8
    return 5*bx*by+2*min(bx,by)+1
def fold_cost(widths,p,mode):
    out=[Counter() for _ in range(20)]
    for (cat,de,ce,div),weights in widths.items():
        data=p+14+de;coef=p+ce
        fees={}
        if cat in ('root','kernel'):
            pairs=[(data+1,coef),(data,coef+1),(data,coef+1)] if mode=='three' else [(data,coef)]*4
            raw=data+coef+(2 if mode=='three' else 1)
            adders=([data+1] if mode=='three' else [])+[raw]*2
            fees={cat+'_product':sum(product_cost(x,y) for x,y in pairs),
                  cat+'_exact_add':sum(map(add_cost,adders)),
                  cat+'_round_add':sum(add_cost(raw+2) for _ in range(4))}
        if cat=='add':fees={'add_complex_add':2*add_cost(data+1)}
        if cat=='scale':fees={'scale_scale_round_add':4*add_cost(data+2)}
        for i,w in enumerate(weights):
            for label,fee in fees.items():out[i][label]+=w*fee
    return out
records=[];setups=[]
for alloc,base in zip(target['allocations'],local['allocations']):
    p=alloc['p'];check(p==base['p'] and p in (112,134,152))
    scale=sum(P_of(n)*sum(add_cost(p+ceil_log(2*n+1)+2) for _ in range(4)) for n in kernels)
    oldsum=sum(P_of(n)*sum(add_cost(p+ceil_log(2*n+1)+1) for _ in range(2)) for n in kernels)
    newsum=sum(P_of(n)*2*add_cost(p+1) for n in kernels)
    setups.append(dict(p=p,scaled_rounds=337702368,scale_add=scale,old_sum=oldsum,new_sum=newsum,
                       cold_extra=scale+newsum-oldsum,sunk_old_extra=scale+newsum))
    for mode in ('three','four'):
        before=fold_cost(ow,p,mode);after=fold_cost(nw,p,mode)
        profile=alloc['profiles'][mode]
        check(profile['new_scale_setup_add_core']==scale)
        check(profile['old_kernel_sum_add_core']==(oldsum if mode=='three' else 0))
        check(profile['new_kernel_sum_add_core']==(newsum if mode=='three' else 0))
        for s,e in enumerate((0,167,320,640)):
            bp=Counter();ap=Counter()
            for b in range(5):bp.update(before[5*s+b]);ap.update(after[5*s+b])
            ref=profile['scenarios'][s];baseline=base['profiles'][mode]['scenarios'][s]
            check(ref['extra_nodes']==baseline['extra_nodes']==e)
            check(dict(bp)==ref['old_parts']==baseline['parts'])
            check(dict(ap)==ref['new_parts'])
            check([dict(x) for x in before[5*s:5*s+5]]==baseline['bands'])
            check([dict(x) for x in after[5*s:5*s+5]]==ref['new_bands'])
            oldcost=sum(bp.values());newcost=sum(ap.values())
            check(oldcost==ref['old_core']==baseline['local_core'])
            check(newcost==ref['new_core'])
            check(oldcost-newcost==ref['core_saved'])
            check(str(Q(newcost,oldcost))==ref['fraction_of_old'])
            product_saving=sum(v for k,v in bp.items() if k.endswith('_product'))-sum(v for k,v in ap.items() if k.endswith('_product'))
            records.append(dict(p=p,mode=mode,extra=e,old=oldcost,new=newcost,saving=oldcost-newcost,
                                product_saving=product_saving,add_saving=oldcost-newcost-product_saving))
main=next(r for r in records if r['p']==134 and r['mode']=='three' and r['extra']==0)
check(main['product_saving']==151592179696483912)
check(main['add_saving']==28722213508789072)
check(main['new']==6124737322160821530)
check(target['production_adopted'] is False and target['precision_selected'] is False)
receipt=dict(scope='Independent exact saved-data reconstruction; no author execution or inventory generation.',
             pins=pins,checks=checks,contexts=num_context,blue_contexts=blue,new_event_classes=len(new),
             active_full_cache_nodes=len(active),kernels=len(kernels),runtime_blue_lengths=len(blue_lengths),
             widths_old=len(ow),widths_new=len(nw),projections=records,setup=setups,
             no_values=True,no_builds=True,selected_precision=False,runtime_claim=False)
out=HERE/'review_normalized_bluestein_structural_costs_20261111.json'
raw=(json.dumps(receipt,indent=2)+'\n').encode();check(len(raw)<64*1024*1024)
with out.open('xb') as f:f.write(raw)
print(json.dumps({'checks':checks,'receipt_sha256':sha(out),'bytes':len(raw),'main':main},indent=2))
