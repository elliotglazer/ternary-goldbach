"""Independent finite integer ledger. No source/evaluator imports or function values."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
ROOT = AGENTS.parents[2]
PINS = {
    'work/qrh-campaign/agents/zero-sum/REDUCED_PREFIX_SELECTED_P27_SEED_COST_2026-11-11.md': 'A7021F2EB52E7FCE844BB054864689197B212EF174AAF180B87E027ECA30E758',
    'work/qrh-campaign/agents/zero-sum/reduced_prefix_selected_p27_20261111.py': '5399F8E2498E14F5CCD8516F1967F87A0DAEC969F46C6909BA4E24242BD6A23B',
    'work/qrh-campaign/agents/zero-sum/reduced_prefix_selected_p27_20261111.json': 'B8227C3C7A9F46947BB765C8D1B9A70359A3CBE4C7B96CC0A962B7E27560A38A',
    'work/qrh-campaign/agents/zero-sum/reduced_plus_height_inventory_20261111.json': 'E4876ACF3F57D800118D328B56261149BC66B3A15F2272BDD370D88ECD986791',
    'work/qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md': '579AAEC28BD4C1DB8FB83F3CDB1E4782160D3D35FA8AB2B8DC83BFF956ACBCD1',
    'work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md': '8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413',
    'work/qrh-blueprint/scaled_height_recurrence_20261111.json': '10058EA331D8FC143981F3DA1AC5BA92AEEEF03553849A2E4666CA0783462F02',
    'work/qrh-campaign/agents/integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md': '1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E',
}
checks = 0
def check(predicate):
    global checks
    assert predicate
    checks += 1

for name, expected in PINS.items():
    check(sha256((ROOT/name).read_bytes()).hexdigest().upper() == expected)

author = json.loads((AGENTS/'zero-sum/reduced_prefix_selected_p27_20261111.json').read_text())
inventory = json.loads((AGENTS/'zero-sum/reduced_plus_height_inventory_20261111.json').read_text())
old = json.loads((ROOT/'work/qrh-blueprint/scaled_height_recurrence_20261111.json').read_text())
shift = sum(min(20, 26-i) for i in range(26))
check(shift == 330)

def reconstruct(last):
    rows = []
    start = 0
    old_x = 0
    old_d = 1
    for v,d,n in [(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),(10000,8192,3387)]:
        end = min(last, 64*v//5)
        h = end-start+1
        check(h > 0 and d % old_d == 0)
        x = (n+1)*d+1
        introduced = x-old_x
        # Derive counts from the two coefficient-order classes, not K substitutions.
        types = [(d,27),(1,20)]
        coefficients = sum(m*p for m,p in types)
        row = dict(V=v,D=d,N=n,heights=h,first_index=start,last_index=end)
        row.update({
            'independent_P27_source_coefficients': h*coefficients,
            'head_reciprocal_scales': h*sum(m*n*len(range(1,p)) for m,p in types),
            'head_accumulator_additions': h*sum(m*n*len(range(p)) for m,p in types),
            'E_contracting_complex_stages': h*sum(m*(max(k+2*r-1 for k in range(p) for r in range(1,65))) for m,p in types),
            'Bernoulli_weighted_terms': h*sum(m*len(range(p))*len(range(1,65)) for m,p in types),
            'Bernoulli_accumulator_additions': h*sum(m*len(range(p))*len(range(1,65)) for m,p in types),
            'P27_to_P20_midpoint_shift_updates': h*d*shift,
            'P20_fine_anchor_coefficient_deliveries': h*(d+d+1)*20,
            'shared_height_R_recurrence_steps': h*len(range(1,27)),
            'coarse_anchor_instances': h*(d+1),
            'base_height_argument_pairs': h*x,
            'initial_B_certificates': introduced,
            'step_cis_certificates': introduced,
            'step_grid_conversions': introduced,
            'fine_state_complex_updates': (h-1)*x+old_x,
            'state_to_EM_grid_conversions': h*x,
        })
        rows.append(row)
        start=end+1; old_x=x; old_d=d
    check(start == last+1)
    keys=[k for k in rows[0] if k not in ('V','D','N','heights','first_index','last_index')]
    totals={k:sum(row[k] for row in rows) for k in keys}
    check(totals['initial_B_certificates']==27754497)
    check(totals['fine_state_complex_updates']+27754497==totals['base_height_argument_pairs'])
    return dict(bands=rows,totals=totals)

results=[]
baseline=reconstruct(127988)
for idx, extra in enumerate([None,0,167,320,640]):
    own=baseline if extra is None else reconstruct(102144+extra)
    target=author['baseline'] if extra is None else author['scenarios'][idx-1]
    seed=inventory['baseline_seed_prefix'] if extra is None else inventory['scenarios'][idx-1]['seed_prefix']
    for a,b,c in zip(own['bands'],target['bands'],seed['bands']):
        for k,value in a.items(): check(b[k]==value)
        for k,v in [('height_nodes',a['heights']),('first_index',a['first_index']),('last_index',a['last_index']),('D',a['D']),('N',a['N'])]: check(c[k]==v)
    for k,v in own['totals'].items():
        check(target['totals'][k]==v)
        if extra is not None: check(Fraction(target['ratios_to_old_selected_P27'][k])==Fraction(v,baseline['totals'][k]))
    if extra is not None:
        check(target['extra_nodes']==extra)
        check(Fraction(5*(102144+extra),64)<=8030)
    results.append(dict(extra_nodes=extra,**own))
for new,oldkey in [('initial_B_certificates','initializations'),('step_cis_certificates','step_phase_certificates'),('fine_state_complex_updates','recurrence_updates'),('state_to_EM_grid_conversions','em_grid_conversions')]:
    check(baseline['totals'][new]==old[oldkey])
check(27754497*72==1998323784)
setup=author['unchanged_setup']
for k,v in dict(distinct_x_arguments=27754497,log_bits=144,log_nonanchor_Horner_stages=582822471,init_p=120,step_cis_p=138,state_error_bits=140,EM_rounding_error_bits=122,initial_cis_terms_per_argument=74,step_cis_terms_per_argument=83,raw_dense_state_step_bytes=1998323784,exact_Bernoulli_constants=64).items(): check(setup[k]==v)
out=dict(status='PASS_INDEPENDENT_P27_INTEGER_LEDGER',checks=checks,pins=PINS,schedules=results,scope='Integer metadata and inherited fixed-circuit contracts only; no function values or complete cost claim.')
dest=HERE/'review_reduced_prefix_p27_20261111.json'
with dest.open('x',encoding='utf-8') as f: json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'status':out['status'],'checks':checks,'receipt_sha256':sha256(dest.read_bytes()).hexdigest().upper()}))
