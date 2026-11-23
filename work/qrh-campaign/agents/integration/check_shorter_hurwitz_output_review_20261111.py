"""Independent rational metadata review. No author imports or function values."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial, comb
import json
import hashlib

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
AG = ROOT / 'work/qrh-campaign/agents'
AUTHOR = AG / 'prime-estimates'
EXPECTED = {
 'SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md':'0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A',
 'shorter_hurwitz_output_orders_20261111.py':'11230A0BFE930FC1578E737A28C68C35B2BC4F6058A47767E07FE62CEB039E31',
 'shorter_hurwitz_output_orders_20261111.json':'4385975F56DE8CA2E4B42319DA3B0A2F5F1EB38C4520772F0E8BFC9602692B38',
}
checks = 0
pins = {}
def ck(test):
    global checks
    assert test
    checks += 1
def pin(path, expected=None):
    digest = hashlib.sha256(path.read_bytes()).hexdigest().upper()
    if expected is not None: ck(digest == expected)
    pins[path.relative_to(ROOT).as_posix()] = digest
def fq(obj): return Q(int(obj['num']), int(obj['den']))
def outq(q): return {'num':str(q.numerator),'den':str(q.denominator)}
for name, digest in EXPECTED.items(): pin(AUTHOR/name, digest)
data = json.loads((AUTHOR/'shorter_hurwitz_output_orders_20261111.json').read_text())
for path, digest in data['pins'].items(): pin(ROOT/path, digest)
extra = [
 'major-constants/COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md',
 'integration/R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md',
 'zero-sum/SELECTED_SIGN_CHECKER_COST_SUPPLEMENT_2026-11-11.md',
 'zero-sum/EFFICIENCY_SPECTRAL_BATCHES_2026-11-11.md',
 'integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md',
 'audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md',
 'zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md',
 'zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md',
]
for path in extra: pin(AG/path)
pin(ROOT/'work/qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md')
pin(ROOT/'work/qrh-blueprint/SEED_159_AND_SMALL_FAMILY_DECISIONS_2026-11-11.md')
budget = Q(1,2**82)
eta = Q(1,2**100)
first_shift = Q(1266)*Q(15,16)**27/factorial(27)
first_numeric = (2532+1688)*eta + Q(633*330,2**110)
last_shift = Q(1266)*Q(5*7028,8*4096)**28/factorial(28)
last_numeric = (844+1688)*eta
ck(fq(data['budget']) == budget)

def floor_root(n,k):
    """Integer Newton root; independent of author's grid binary search."""
    if n == 0:
        ck(0**k <= n < 1**k)
        return 0
    x = 1 << ((n.bit_length()+k-1)//k)
    while True:
        y = ((k-1)*x + n//x**(k-1))//k
        if y >= x: break
        x = y
    while x**k > n: x -= 1
    while (x+1)**k <= n: x += 1
    ck(x**k <= n < (x+1)**k)
    return x
def target(j,k,d):
    return Q(1266*(5*j+64*k)**k,(256*d)**k*factorial(k))

definitions = [(500,512,0,6400),(1000,1024,6401,12800),
 (2000,2048,12801,25600),(5000,4096,25601,64000),(7000,8192,64001,84839)]
results = []
for idx,(v,d,begin,end) in enumerate(definitions):
    b = data['bands'][idx]
    shift,numeric = (first_shift,first_numeric) if idx<4 else (last_shift,last_numeric)
    fixed=shift+numeric
    ck((b['V'],b['D_output'],b['selected_first_index'],b['selected_last_index']) == (v,d,begin,end))
    ck(b['source_P'] == (27 if idx<4 else 28))
    ck(fq(b['shift_bound'])==shift and fq(b['numerical_bound'])==numeric)
    ck(fq(b['fixed_over_budget'])==fixed/budget)
    slack=budget-fixed
    ck(slack>0)
    maximum=64*v//5
    thresholds={}
    top=[]
    for k in range(2,21):
        # Strict rational inequality becomes (5j+64k)^k <= integer C.
        cap=(slack.numerator*(256*d)**k*factorial(k)-1)//(1266*slack.denominator)
        z=floor_root(cap,k)
        last=max(-1,min(maximum,(z-64*k)//5))
        thresholds[k]=last
        tr=b['grid_thresholds'][k-2]
        ck(tr['K']==k and tr['last_admitted_index']==last)
        if last>=0:
            ck(target(last,k,d)+fixed<budget)
            ck(fq(tr['last_total_over_budget'])==(target(last,k,d)+fixed)/budget)
        else: ck(tr['last_total_over_budget'] is None)
        if last<maximum:
            ck(target(last+1,k,d)+fixed>=budget)
            ck(fq(tr['next_total_over_budget'])==(target(last+1,k,d)+fixed)/budget)
        else: ck(tr['next_total_over_budget'] is None)
        t=target(maximum,k,d)
        record=b['band_top_tests'][k-2]
        ck(record['K']==k and fq(record['target'])==t)
        ck(fq(record['total_over_budget'])==(t+fixed)/budget)
        ck(record['admitted']==(t+fixed<budget))
        if t+fixed<budget: top.append(k)
    ck(min(top)==b['band_top_min_K']==[19,19,19,20,19][idx])
    # Partition at every threshold; independently select minimum order on each cell.
    cuts=sorted({begin,end+1}|{j+1 for j in thresholds.values() if begin<=j<end})
    ranges=[]
    for left,right in zip(cuts,cuts[1:]):
        k=min(k for k,j in thresholds.items() if j>=right-1)
        ck(all(target(left,h,d)+fixed>=budget for h in range(2,k)))
        ck(target(right-1,k,d)+fixed<budget)
        if ranges and ranges[-1]['K']==k: ranges[-1]['last_index']=right-1
        else: ranges.append({'K':k,'first_index':left,'last_index':right-1})
    expected=[{z:r[z] for z in ('K','first_index','last_index')} for r in b['selected_grid_ranges']]
    ck(ranges==expected)
    for r in b['selected_grid_ranges']:
        ck(fq(r['first_height'])==Q(5*r['first_index'],64))
        ck(fq(r['last_height'])==Q(5*r['last_index'],64))
    ratio=(target(maximum,min(top),d)+fixed)/budget
    ck(ratio<Q([352287,282137,254939,249105,161478][idx],1000000))
    results.append({'band':idx+1,'thresholds':thresholds,'ranges':ranges,'top_ratio':outq(ratio)})

# No conductor scan: monotonicity in c reduces the global maximum to two minima.
def ceilq(q): return -(-q.numerator//q.denominator)
ho=ceilq(200+max(Q(240),Q(96,5)*Q(3927,1250)*Q(531600,10001)))
he=ceilq(200+max(Q(255),Q(191,10)*Q(3927,1250)*Q(1063200,10004)))
ck(max(ho,he)==he==6578)
main_last=ceilq(Q(64*he,5))
ck(main_last==84199)
scenarios=[]
for extra,s in zip((0,167,320,640),data['scenarios']):
    last=main_last+extra
    ck(s['extra_nodes']==extra and s['last_index']==last)
    ck(Q(5*last,64)<7000)
    total=0
    for band,entry in zip(results,s['bands']):
        expected=[dict(r,last_index=min(last,r['last_index'])) for r in band['ranges'] if r['first_index']<=last]
        ck(entry['band']==band['band'] and entry['ranges']==expected)
        total+=sum(r['last_index']-r['first_index']+1 for r in expected)
    ck(total==last+1)
    scenarios.append({'extra':extra,'nodes':total,'last_height':outq(Q(5*last,64))})
ck(results[-1]['thresholds'][18]==89533)
ck(84839<89533<89600)

# Positive coefficient-error rows and both source shift prefix projections.
for k in range(2,21):
    ck(sum(Q(1,4)**i for i in range(k))<Q(4,3))
    ck(2*sum(Q(1,4)**i for i in range(k-1))<Q(8,3))
    for j in range(28):
        for a,w in ((Q(1,2),Q(1,4)),(Q(1,2),Q(1,8)),(Q(1,4),Q(1,8))):
            prefix=sum(Q(comb(j,i))*a**(j-i)*w**i for i in range(min(k,j+1)))
            ck(prefix<=(a+w)**j)
ck(Q(633)*Q(4,3)==844 and Q(633)*Q(8,3)==1688)
# The new cap is genuinely weaker: do not retain the old .16 envelope.
ck(fq(data['bands'][-1]['band_top_tests'][17]['total_over_budget'])>Q(4,25))

receipt={'scope':'Independent exact rational metadata and paper-interface review; no author code import/run, no function values.',
 'pins':pins,'checks':checks,'threshold_method':'integer Newton kth roots after clearing strict rational inequalities',
 'bands':results,'scenarios':scenarios,'main_height_minimal_odd':ho,'main_height_minimal_even':he,
 'source_work_unchanged':True,'export_alpha_radius':outq(budget),
 'old_final_fraction_preserved':False,'successful_signs_or_count_claimed':False}
dest=HERE/'shorter_hurwitz_output_review_20261111.json'
dest.write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'checks':checks,'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),'top_orders':[19,19,19,20,19],'final_selected_orders':[17,18]}))
