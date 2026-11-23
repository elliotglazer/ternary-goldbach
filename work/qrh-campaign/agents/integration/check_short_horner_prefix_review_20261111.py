"""Independent finite rational widths/count review; no author code execution."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import json, hashlib

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AG=ROOT/'work/qrh-campaign/agents'
checks=0
pins={}
def ck(p):
    global checks
    assert p
    checks+=1
def pin(path, expected=None):
    h=hashlib.sha256(path.read_bytes()).hexdigest().upper()
    if expected is not None: ck(h==expected)
    pins[path.relative_to(ROOT).as_posix()]=h
def read(path): return json.loads(path.read_text(encoding='utf-8'))
for name,h in {
 'SHORT_OUTPUT_HORNER_PREFIX_COMPOSITION_2026-11-11.md':'716B9E5FFE726D629E97F2CA85CA972D351051A209CB0D5DC0B6CAC21F60C98B',
 'short_horner_prefix_composition_20261111.py':'B7625DA3DD556966A009FFD2E884D952F93B288F0157B049FFDDD6E784F26969',
 'short_horner_prefix_composition_20261111.json':'99671C5858B20FF3940186D33CCFB19E730C9D364FF3B3EB5B2E6B8641F399FE',
}.items(): pin(AG/'prime-estimates'/name,h)
author=read(AG/'prime-estimates/short_horner_prefix_composition_20261111.json')
for path,h in author['pins'].items(): pin(ROOT/path,h)
pin(HERE/'REVIEW_SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md','B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E')
pin(AG/'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md','9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2')
source=read(AG/'prime-estimates/stored_hurwitz_degree_bounds_20261111.json')
old=read(AG/'moebius/fixed_horner_degree_envelope_costs_20261111.json')
occ=read(AG/'prime-estimates/large_residue_bucket_occupancy_20261111.json')
orders=read(AG/'prime-estimates/shorter_hurwitz_output_orders_20261111.json')
profiles={
 'uniform100':[100]*20,
 'root_linear':[100,100]+list(range(98,80,-1)),
 'fixed_15442':[100,100,100,100,97,95,95,95,89,87,87,87,81,79,79,79,71,71,71,71],
}
ck(profiles==author['profiles'])
u=Q(1,2**100)
W=4*u+Q(330,2**110)
flat=2**27*(u/4+Q(330,2**110))
Z={
 'first_four':[5170+Q(1,2**116)+W]+[6*Q(5,4)**j/factorial(j)+min(4**j*W,flat) for j in range(1,20)],
 'final':[Q(4507)+Q(9,2)+Q(1,2**116)+u]+[Q(15,2)*Q(7,8)**j/factorial(j)+u for j in range(1,20)],
}
def power_width(x):
    # Independent nonnegative integer cap search; all queried scaled caps exceed1.
    ck(x>1)
    w=0
    while (1<<w)*x.denominator<=x.numerator: w+=1
    ck(Q(2)**(w-1)<=x<Q(2)**w)
    return w
def macro(a,b):
    m,n=sorted(((a+7)//8,(b+7)//8))
    return 5*m*n+2*m+1
def accumulator(z,e,K,j):
    # Closed finite sum, not the producer's backwards loop.
    return sum((z[k]+e[k])*Q(1,4)**(k-j) for k in range(j,K))+sum(e[k]*Q(1,4)**(k-j) for k in range(j,K-1))

summaries=[]
for cohort,z in Z.items():
    for j,val in enumerate(z): ck(val==Q(source['cohorts'][cohort][j]['stored_center_norm_bound']))
    for name,full in profiles.items():
        e=[Q(3,4)*Q(1,2**b) for b in full]
        E20=sum((2 if j<19 else 1)*e[j]*Q(1,4)**j for j in range(20))
        ck(E20/u==Q(old['results'][cohort][name]['error_factor'])<Q(8,3))
        for row in author['results'][cohort][name]:
            K=row['K'];b=full[:K]
            ck(10<=K<=20 and row['grid']==b and row['degree']==K-1)
            err=sum((2 if j<K-1 else 1)*e[j]*Q(1,4)**j for j in range(K))
            ck(Q(row['error_in_u'])==err/u and err<Q(8,3)*u)
            ck(Q(row['reserve_in_u'])==Q(8,3)-err/u)
            ck(Q(row['highest_coefficient_single_error_in_u'])==e[K-1]*Q(1,4)**(K-1)/u)
            if K<20:
                lost=e[K-1]*Q(1,4)**(K-1)+sum((2 if j<19 else 1)*e[j]*Q(1,4)**j for j in range(K,20))
                ck(E20-err==lost>0)
            top=z[K-1]+e[K-1]
            ck(Q(row['initial_converted_norm_cap'])==top)
            ck(row['initial_signed_bits']==power_width(top*2**b[-1])+1)
            ck(row['complex_stages']==K-1 and row['real_product_proofs']==4*(K-1))
            ck([s['stage'] for s in row['stages']]==list(range(K-2,-1,-1)))
            subtotal=0
            for s in row['stages']:
                j=s['stage'];ain=accumulator(z,e,K,j+1);aout=accumulator(z,e,K,j)
                prod=ain/4+e[j]
                ck(aout==z[j]+e[j]+prod)
                ck(ain<=accumulator(z,e,20,j+1))
                M=ain*2**b[j+1];L=prod*2**b[j];delta=b[j]-b[j+1]
                wm=power_width(M);wl=power_width(L)
                X=132900*M*2**delta;LV=531600*L
                ints={
                 'input_grid':b[j+1],'output_grid':b[j],'alignment_bits':delta,
                 'input_magnitude_bits':wm,'rounded_magnitude_bits':wl,
                 'input_bytes':(wm+7)//8,'rounded_bytes':(wl+7)//8,
                 'product_template_events':2*(macro(18,wm)+macro(20,wl)),
                 'raw_product_signed_bits':power_width(132900*M)+1,
                 'shifted_product_signed_bits':power_width(X)+1,
                 'witness_product_signed_bits':power_width(LV)+1,
                 'raw_residual_signed_bits':power_width(X+LV)+1,
                 'double_raw_residual_signed_bits':power_width(2*(X+LV))+1,
                 'exact_add_output_signed_bits':power_width(aout*2**b[j])+1,
                }
                for key,val in ints.items(): ck(s[key]==val)
                for key,val in [('input_norm_cap',ain),('rounded_product_norm_cap',prod),('output_norm_cap',aout)]: ck(Q(s[key])==val)
                ck(s['first_stage']==(j==K-2))
                subtotal+=ints['product_template_events']
            ck(row['product_template_events']==subtotal)
            baseline=old['results'][cohort][name]
            deleted=sum(s['product_variants']['uncancelled']['complex_product_template_events'] for s in baseline['stages'] if s['stage']>=K-1)
            ck(row['full20_product_template_events']==baseline['product_template_events'])
            ck(row['deleted_high_stage_events']==deleted)
            ck(row['remaining_stage_width_discount']==baseline['product_template_events']-deleted-subtotal>=0)
            ck(row['nonzero_shifts']==sum(b[j]>b[j+1] for j in range(K-1)))
            ck(row['total_shift_bits']==sum(b[j]-b[j+1] for j in range(K-1)))
            if K in (18,19,20): summaries.append({'cohort':cohort,'profile':name,'K':K,'products':subtotal,'initial_signed_bits':row['initial_signed_bits'],'error_in_u':str(err/u)})
            if (cohort,K) in [('first_four',19),('final',18)]: ck(row['remaining_stage_width_discount']==0)

maxima=[19,19,19,20,18]
ck(author['bandwise_maximum_K']==maxima)
for i,b in enumerate(orders['bands']): ck(max(r['K'] for r in b['selected_grid_ranges'])==maxima[i])
counts=[]
for src,dst in zip(occ['scenarios'],author['scenarios']):
    ck(src['extra_nodes']==dst['extra_nodes'])
    units=[]
    for i,(sb,db) in enumerate(zip(src['bands'],dst['bands'])):
        ck({c['conductor_parity'] for c in sb['cohorts']}=={'odd','even'} and len(sb['cohorts'])==2)
        U=sum(c['unit_outputs'] for c in sb['cohorts']);K=maxima[i];units.append(U)
        fields={'band':i+1,'K':K,'unit_residue_height_inputs':U,'old_stages':19*U,'new_stages':(K-1)*U,'removed_stages':(20-K)*U,'real_product_proofs':4*(K-1)*U}
        ck(db==fields)
    before=19*sum(units);removed=sum(units[:3])+2*units[4];after=before-removed
    ck(before==src['old_Horner_stages']==dst['old_stages'])
    ck(sum(units)==src['unit_residue_height_inputs'])
    ck(after==dst['new_stages'] and removed==dst['removed_stages'])
    ck(Q(dst['stage_fraction_removed'])==Q(removed,before))
    counts.append({'extra':src['extra_nodes'],'units':units,'old':before,'new':after,'removed':removed})
ck(counts[0]['removed']==58988187467256)
receipt={'scope':'Independent exact source-envelope, prefix-width and saved-count review; no function values, author imports or population scans.',
 'checks':checks,'pins':pins,'cases':66,'selected_summaries':summaries,'scenarios':counts,
 'within_band_weighting':False,'source_work_reduced':False,'FD_counts_reused':False,'runtime_claim':False}
dest=HERE/'short_horner_prefix_review_20261111.json'
with dest.open('x',encoding='utf-8') as f: json.dump(receipt,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),'main_removed':counts[0]['removed']}))
