"""Independent exact metadata reconstruction; imports no producer/evaluator."""
from pathlib import Path
from fractions import Fraction
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
PINS = {
    'work/qrh-blueprint/COMBINED_PROFILE_RETUNED_SEED_LEDGER_2026-11-11.md': 'C931DC800F91F8D15B36DA91B52C4BFCC7FF7D52E34D3332636B0A50BEE6B093',
    'work/qrh-blueprint/check_combined_retuned_seed_20261111.py': 'FAC97F470207326AD47F699CD4E03B25CF2C5B9DF5D8F1DF9628D6D6D1DA0472',
    'work/qrh-blueprint/combined_retuned_seed_20261111.json': '5924631261D494F377D647DBB3FA4BDB39796BDF5B2F979499A1D56144A86CAC',
    'work/qrh-campaign/agents/major-constants/combined_odd_even_height_inventory_20261111.json': 'BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE',
    'work/qrh-campaign/agents/independent-feasibility/retuned_final_seed_band_20261111.json': '51EF63920A6E298F21FEC3EE228B9DB75302700847D64532ADA76D1240A15B7D',
    'work/qrh-campaign/agents/major-constants/COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md': '6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C',
    'work/qrh-campaign/agents/independent-feasibility/RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md': '8F08560DDB2BDFEBEABA0D4D5A44FCBCC625BFD43D1027AF05BF62233863FD9B',
    'work/qrh-campaign/agents/independent-feasibility/REVIEW_COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md': 'F32FABEF789BEF16B64D16040C1FE48D324F0D84DDBA1FF47F0D30DE2C3A6EAA',
    'work/qrh-campaign/agents/prime-estimates/REVIEW_RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md': '6D5AA23A7050AC5C54E103AFD9C33BBAF5AF84836FCB7DD05FDD50CA9853BCFF',
    'work/qrh-campaign/agents/audit/COMBINED_ODD_EVEN_PROFILE_ASSEMBLY_REVIEW_2026-11-11.md': '2017E3ECC588438907D0A9582D9C351CE201FE11C41EAF68BDA4559F705FA250',
}
checks = 0
def check(b):
    global checks
    checks += 1
    assert b, checks

for path, pin in PINS.items():
    check(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper() == pin)
def read(path):
    return json.loads((ROOT/path).read_text())

C = read('work/qrh-campaign/agents/major-constants/combined_odd_even_height_inventory_20261111.json')
T = read('work/qrh-campaign/agents/independent-feasibility/retuned_final_seed_band_20261111.json')
J = read('work/qrh-blueprint/combined_retuned_seed_20261111.json')

def reconstruct(nodes, cutoff, ceiling):
    # Explicit index intervals, including their two boundary conventions.
    intervals = [(0,6401,500,512,220), (6401,12801,1000,1024,387),
                 (12801,25601,2000,2048,720), (25601,64001,5000,4096,1720),
                 (64001,nodes,ceiling,8192,cutoff)]
    rows=[]
    previous_points=0
    previous_D=1
    previous_endpoint=1
    for start,stop,V,D,N in intervals:
        H=stop-start
        check(H>0 and D%previous_D==0 and N+2>=previous_endpoint)
        check(Fraction(5*(stop-1),64)<=V)
        # D interior P27 coefficient vectors and one endpoint P20 vector.
        degrees=[(D,27),(1,20)]
        slots=sum(m*k for m,k in degrees)
        head_scales=sum(m*(k-1)*N for m,k in degrees)
        e_steps=sum(m*(k+126) for m,k in degrees)
        # Diagonal coefficient initializes each translated output; only the
        # coefficients strictly above it cause multiply-add updates.
        shift_per_anchor=sum(26-k for k in range(20))
        points=(N+2-1)*D+1
        new=points-previous_points
        # Previously present arguments update on every new height; newly
        # introduced ones initialize once and update only H-1 times.
        updates=previous_points*H+new*(H-1)
        count={
            'independent_P27_source_coefficients':H*slots,
            'head_reciprocal_scales':H*head_scales,
            'head_accumulator_additions':H*N*slots,
            'E_contracting_complex_stages':H*e_steps,
            'Bernoulli_weighted_terms':H*slots*64,
            'Bernoulli_accumulator_additions':H*slots*64,
            'P27_to_P20_midpoint_shift_updates':H*D*shift_per_anchor,
            'P20_fine_anchor_coefficient_deliveries':H*(D+1+D)*20,
            'shared_height_R_recurrence_steps':H*26,
            'coarse_anchor_instances':H*(D+1),
            'base_height_argument_pairs':H*points,
            'initial_B_certificates':new,
            'step_cis_certificates':new,
            'step_grid_conversions':new,
            'fine_state_complex_updates':updates,
            'state_to_EM_grid_conversions':H*points,
        }
        rows.append(dict(V=V,D=D,N=N,heights=H,first_index=start,last_index=stop-1,**count))
        previous_points,previous_D,previous_endpoint=points,D,N+2
    return rows,{k:sum(row[k] for row in rows) for k in count}

for data,key,N,V in [(C,'selected_P27',3387,10000),(T,'retuned',2387,7000)]:
    check(len(data['scenarios'])==4)
    for scenario in data['scenarios']:
        rows,total=reconstruct(scenario['global_nodes'],N,V)
        check(rows==scenario[key]['bands'])
        for k,v in total.items(): check(v==scenario[key]['totals'][k])

check(len(J['scenarios'])==4)
summary=[]
for index,(old,earlier,new) in enumerate(zip(C['scenarios'],T['scenarios'],J['scenarios'])):
    extra=[0,167,320,640][index]
    check(old['extra_nodes']==earlier['extra_nodes']==new['extra_nodes']==extra)
    check(old['global_nodes']==new['global_nodes']==84200+extra)
    check(new['global_nodes']<=earlier['global_nodes']<128000)
    height=Fraction(5*(new['global_nodes']-1),64)
    check(height==Fraction(new['last_height'])==Fraction(old['last_height']))
    check(height<=Fraction(earlier['last_height'])<7000)
    rows,total=reconstruct(new['global_nodes'],2387,7000)
    for r,saved in zip(rows,new['selected_P27']['bands']):
        check({k:r[k] for k in ['V','D','N','heights']}=={k:saved[k] for k in ['V','D','N','heights']})
        check({k:r[k] for k in total}==saved['counts'])
    check(total==new['selected_P27']['totals'])
    baseline=old['selected_P27']['totals']
    for k,v in total.items():
        check(Fraction(v,baseline[k])==Fraction(new['ratios_to_same_combined_height_old_seed'][k]))
    check(new['transform_operations']==old['operations'])
    check(new['P20_Horner_stages']==old['P20_Horner_stages']==19*old['residue_inputs'])
    H=new['global_nodes']-64001
    deltas={'head_reciprocal_scales':1000*H*(26*8192+19),
            'head_accumulator_additions':1000*H*(27*8192+20),
            'initial_B_certificates':8192000,'step_cis_certificates':8192000,
            'step_grid_conversions':8192000,'fine_state_complex_updates':8192000*(H-1),
            'base_height_argument_pairs':8192000*H,'state_to_EM_grid_conversions':8192000*H}
    for k,v in total.items(): check(baseline[k]-v==deltas.get(k,0))
    summary.append(dict(extra=extra,nodes=new['global_nodes'],height=str(height),totals=total))

anchors=[]
at=8192
limit=2389*8192
covered=0
while at<=limit:
    anchors.append(at)
    finish=min(limit,at+at//128-1)
    check(0<=Fraction(finish-at,at)<Fraction(1,128))
    covered+=finish-at+1
    at=finish+1
check(at==limit+1 and covered==19562497)
check(anchors==T['setup']['new']['anchor_starts'])
check(anchors==T['setup']['old']['anchor_starts'][:len(anchors)])
setup=dict(points=covered,anchors=len(anchors),log_horner_stages=21*(covered-len(anchors)),raw_state_step_bytes=72*covered)
check(setup==J['setup'])
check(setup['anchors']==1001 and setup['log_horner_stages']==410791416)
check(T['setup']['old']['log_nonanchor_horner_stages']-setup['log_horner_stages']==172031055)
check(T['setup']['old']['raw_dense_state_step_bytes']-setup['raw_state_step_bytes']==589824000)
check(C['V7000_retune_counted'] is False)
transform_setup=C['transform_setup_unchanged']
for k,v in {'axis_lengths':12496,'active_nodes':32942,'kernel_count':6004,'kernel_entries':337702368,'chirp_entries':140276846,'max_padded_length':262144,'CT_full_root_table_entry_upper':1116142487}.items():
    check(transform_setup[k]==v)
check(transform_setup['kernel_forward_operations']['general_complex_products']==2244782056)
check(transform_setup['kernel_forward_operations']['complex_add_sub']==5502647200)
for path,pin in J['pins'].items(): check(PINS[path]==pin)

out=dict(status='PASS exact saved-metadata and paper-domain checks; no analytic values',checks=checks,pins=PINS,scenarios=summary,setup=setup,transform_setup=transform_setup)
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2); f.write('\n')
print(f'PASS {checks} exact checks; eight predecessor and four joined ledgers.')
