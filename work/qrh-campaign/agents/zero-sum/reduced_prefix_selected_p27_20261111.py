"""Small exact selected-P27 seed ledger; no analytic or spectral evaluations."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
import json

here=Path(__file__).resolve().parent
workspace=here.parents[2]
root=workspace/'qrh-blueprint'
meta=here/'reduced_plus_height_inventory_20261111.json'
assert sha256(meta.read_bytes()).hexdigest().upper()=='E4876ACF3F57D800118D328B56261149BC66B3A15F2272BDD370D88ECD986791'
parent=json.loads(meta.read_text())
selected=root/'SELECTED_SCALED_SEED_ORDER_2026-11-11.md'
height=root/'SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md'
assert sha256(selected.read_bytes()).hexdigest().upper()=='579AAEC28BD4C1DB8FB83F3CDB1E4782160D3D35FA8AB2B8DC83BFF956ACBCD1'
assert sha256(height.read_bytes()).hexdigest().upper()=='8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413'
old_receipt=root/'scaled_height_recurrence_20261111.json'
assert sha256(old_receipt.read_bytes()).hexdigest().upper()=='10058EA331D8FC143981F3DA1AC5BA92AEEEF03553849A2E4666CA0783462F02'
old_height=json.loads(old_receipt.read_text())

def ledger(seed):
    rows=[]
    previous_X=0
    for b in seed['bands']:
        H,D,N=b['height_nodes'],b['D'],b['N']
        X=(N+1)*D+1
        K=27*D+20
        introduced=X-previous_X
        assert introduced>=0
        if previous_X:assert D%previous_D==0
        row={'V':b['V'],'D':D,'N':N,'heights':H,
             'first_index':b['first_index'],'last_index':b['last_index'],
             'independent_P27_source_coefficients':H*K,
             'head_reciprocal_scales':H*N*(26*D+19),
             'head_accumulator_additions':H*N*K,
             'E_contracting_complex_stages':H*(153*D+146),
             'Bernoulli_weighted_terms':H*64*K,
             'Bernoulli_accumulator_additions':H*64*K,
             'P27_to_P20_midpoint_shift_updates':H*330*D,
             'P20_fine_anchor_coefficient_deliveries':H*20*(2*D+1),
             'shared_height_R_recurrence_steps':H*26,
             'coarse_anchor_instances':H*(D+1),
             'base_height_argument_pairs':H*X,
             'initial_B_certificates':introduced,
             'step_cis_certificates':introduced,
             'step_grid_conversions':introduced,
             'fine_state_complex_updates':H*X-introduced,
             'state_to_EM_grid_conversions':H*X}
        rows.append(row);previous_X=X;previous_D=D
    cats=[k for k in rows[0] if k not in ('V','D','N','heights','first_index','last_index')]
    total={k:sum(r[k] for r in rows) for k in cats}
    assert total['initial_B_certificates']==27754497
    assert total['base_height_argument_pairs']==seed['global_height_argument_pairs']
    assert total['independent_P27_source_coefficients']==seed['P27_shifted_source_slots']
    assert total['P27_to_P20_midpoint_shift_updates']==seed['P27_midpoint_shift_updates']
    assert total['fine_state_complex_updates']+total['initial_B_certificates']==total['base_height_argument_pairs']
    assert rows[-1]['last_index']<128000
    return {'bands':rows,'totals':total}

baseline=ledger(parent['baseline_seed_prefix'])
expected={'independent_P27_source_coefficients':19375637796,
 'head_reciprocal_scales':53776084584136,'head_accumulator_additions':55844475188704,
 'E_contracting_complex_stages':109799461818,'Bernoulli_weighted_terms':1240040818944,
 'P27_to_P20_midpoint_shift_updates':236782064640,
 'base_height_argument_pairs':2068812377589,'fine_state_complex_updates':2068784623092}
for k,v in expected.items():assert baseline['totals'][k]==v
for k,oldkey in [('initial_B_certificates','initializations'),('step_cis_certificates','step_phase_certificates'),
                 ('fine_state_complex_updates','recurrence_updates'),('state_to_EM_grid_conversions','em_grid_conversions')]:
    assert baseline['totals'][k]==old_height[oldkey]
rows=[]
for scenario in parent['scenarios']:
    r=ledger(scenario['seed_prefix']);r['extra_nodes']=scenario['extra_nodes']
    r['ratios_to_old_selected_P27']={k:str(F(v,baseline['totals'][k])) for k,v in r['totals'].items()}
    rows.append(r)
out={'status':'PASS_EXACT_SELECTED_P27_PREFIX_LEDGER','baseline':baseline,'scenarios':rows,
 'unchanged_setup':{'distinct_x_arguments':27754497,'log_bits':144,'log_nonanchor_Horner_stages':582822471,
                   'init_p':120,'step_cis_p':138,'state_error_bits':140,'EM_rounding_error_bits':122,
                   'initial_cis_terms_per_argument':74,'step_cis_terms_per_argument':83,
                   'raw_dense_state_step_bytes':1998323784,'exact_Bernoulli_constants':64},
 'scope':'Selected P27, final P20, five unchanged N/D bands. Exact arithmetic inventory; no function values or closure claims.'}
dest=Path(__file__).with_suffix('.json')
if dest.exists():raise SystemExit('Refusing to overwrite receipt')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8',newline='\n')
print(json.dumps({'baseline':baseline['totals'],'scenarios':[{'extra_nodes':r['extra_nodes'],'totals':r['totals']} for r in rows]},indent=2))
