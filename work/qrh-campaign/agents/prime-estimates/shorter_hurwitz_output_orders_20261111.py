"""Finite rational parameter admission only. No function or coefficient values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PINS = {
    'work/qrh-campaign/agents/zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md': 'B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC',
    'work/qrh-campaign/agents/integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md': '861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895',
    'work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md': '251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
    'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md': 'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
    'work/qrh-campaign/agents/zero-sum/QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md': 'A0CD531E1FD20280E49B1EC0AE95E32809C7965222C40916BD4712F7F3A5EA19',
    'work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md': 'E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9',
    'work/qrh-campaign/agents/major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md': '483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716',
}
checks = 0

def check(p):
    global checks
    assert p
    checks += 1

def frac(x):
    x = F(x)
    return {'num': str(x.numerator), 'den': str(x.denominator)}

for path, pin in PINS.items():
    check(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper() == pin)

ETA = F(1, 2**100)
UT = F(1, 2**110)
BUDGET = F(1, 2**82)
S_FIRST = 1266 * F(15,16)**27 / factorial(27)
N_FIRST = 2532*ETA + 633*330*UT + 1688*ETA
S_FINAL = 1266 * F(5*(7000+28),8*4096)**28 / factorial(28)
N_FINAL = 844*ETA + 1688*ETA

def target(t, K, D):
    assert 2 <= K <= 20 and t >= 0
    return 1266 * ((F(t)+K)/(4*D))**K / factorial(K)

band_defs = [
    (500,512,0,6400), (1000,1024,6401,12800),
    (2000,2048,12801,25600), (5000,4096,25601,64000),
    (7000,8192,64001,84839),
]
bands=[]
for number,(V,D,first,last) in enumerate(band_defs,1):
    shift, numeric = (S_FIRST,N_FIRST) if number <= 4 else (S_FINAL,N_FINAL)
    fixed = shift + numeric
    check(0 < fixed < BUDGET)
    check(F(5*last,64) <= V)
    top_records=[]
    for K in range(2,21):
        value=target(V,K,D)+fixed
        top_records.append({'K':K,'target':frac(target(V,K,D)),
                            'total_over_budget':frac(value/BUDGET),'admitted':value<BUDGET})
    Ktop=next(z['K'] for z in top_records if z['admitted'])
    check(all(not z['admitted'] for z in top_records if z['K']<Ktop))
    check(target(V,Ktop,D)+fixed < BUDGET)
    # Thresholds on the entire grid through V, found by monotone binary search.
    # Each stored finite threshold includes exact admission and next-point failure.
    maxj=64*V//5
    thresholds=[]
    for K in range(2,21):
        lo,hi=-1,maxj+1
        while hi-lo>1:
            mid=(lo+hi)//2
            if target(F(5*mid,64),K,D)+fixed < BUDGET:
                lo=mid
            else:
                hi=mid
        check(lo == -1 or target(F(5*lo,64),K,D)+fixed < BUDGET)
        check(hi == maxj+1 or target(F(5*hi,64),K,D)+fixed >= BUDGET)
        thresholds.append({'K':K,'last_admitted_index':lo,
            'last_total_over_budget':None if lo<0 else frac((target(F(5*lo,64),K,D)+fixed)/BUDGET),
            'next_total_over_budget':None if hi>maxj else frac((target(F(5*hi,64),K,D)+fixed)/BUDGET)})
    check(all(a['last_admitted_index']<=b['last_admitted_index'] for a,b in zip(thresholds,thresholds[1:])))
    ranges=[]
    cursor=first
    for th in thresholds:
        end=min(last,th['last_admitted_index'])
        if end < cursor:
            continue
        K=th['K']
        check(target(F(5*end,64),K,D)+fixed < BUDGET)
        # Every smaller K fails at the start; monotonicity then proves minimality throughout.
        check(all(target(F(5*cursor,64),k,D)+fixed >= BUDGET for k in range(2,K)))
        ranges.append({'K':K,'first_index':cursor,'last_index':end,
            'first_height':frac(F(5*cursor,64)),'last_height':frac(F(5*end,64))})
        cursor=end+1
    check(cursor == last+1)
    check(sum(z['last_index']-z['first_index']+1 for z in ranges)==last-first+1)
    bands.append({'band':number,'V':V,'D_output':D,'source_P':27 if number<=4 else 28,
        'selected_first_index':first,'selected_last_index':last,
        'shift_bound':frac(shift),'numerical_bound':frac(numeric),
        'fixed_over_budget':frac(fixed/BUDGET),'band_top_min_K':Ktop,
        'band_top_tests':top_records,'grid_thresholds':thresholds,'selected_grid_ranges':ranges})

scenarios=[]
for extra in [0,167,320,640]:
    last=84199+extra
    rows=[]
    for band in bands:
        upper=min(last,band['selected_last_index'])
        kept=[]
        for row in band['selected_grid_ranges']:
            if row['first_index']<=upper:
                kept.append({'K':row['K'],'first_index':row['first_index'],
                    'last_index':min(row['last_index'],upper)})
        rows.append({'band':band['band'],'ranges':kept})
    check(sum(r['last_index']-r['first_index']+1 for b in rows for r in b['ranges'])==last+1)
    scenarios.append({'extra_nodes':extra,'last_index':last,'bands':rows})

# Exact monotonicity witness for dropping positive weighted error terms.
# The complete original shift and numerical constants are retained, not repriced.
for K in range(2,21):
    check(sum(F(1,4)**k for k in range(K)) <= F(4,3))
    check(2*sum(F(1,4)**k for k in range(K-1)) < F(8,3))
    check(all(sum(F(1,4)**k * __import__('math').comb(j,k) * F(1,2)**(j-k)
                  for k in range(min(K,j+1))) <= F(3,4)**j for j in range(27)))

out={'scope':'Exact parameter admission only; no analytic or coefficient values, no aggregate work saving.',
     'pins':PINS,'budget':frac(BUDGET),'target_formula':'1266*((abs(t)+K)/(4*D_output))^K/K!',
     'strict_admission':True,'K_domain':[2,20],'fixed_source_and_shift_schedule':True,
     'bands':bands,'scenarios':scenarios,'checks':checks}
path=HERE/'shorter_hurwitz_output_orders_20261111.json'
path.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'checks':checks,'top_K':[b['band_top_min_K'] for b in bands],
    'ranges':[[[r['K'],r['first_index'],r['last_index']] for r in b['selected_grid_ranges']] for b in bands],
    'receipt_sha256':hashlib.sha256(path.read_bytes()).hexdigest().upper()},indent=2))
