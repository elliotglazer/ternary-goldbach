"""Exact finite inventory and conditional guard algebra only; no spectral values."""
from pathlib import Path
from fractions import Fraction as F
import json,hashlib

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
ROOT=AGENTS.parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()

def run():
    inputs=[
        'zero-sum/CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md',
        'zero-sum/conditional_r132900_pruning_inventory_20261111.json',
        'major-constants/REVIEW_CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md',
        'zero-sum/SELECTED_SIGN_CHECKER_COST_SUPPLEMENT_2026-11-11.md',
        'zero-sum/EFFICIENCY_SPECTRAL_BATCHES_2026-11-11.md',
        'zero-sum/FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md',
        'zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md',
        'zero-sum/FAMILY_CERTIFICATION_TERMINATION_LIMITS_2026-11-11.md',
        'prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md',
        'zero-sum/REVIEW_FINITE_U_HARDY_NORMALIZATION_2026-11-11.md',
        'integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md',
        'mellin/REVIEW_ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md',
        'integration/TURING_AUXILIARY_MARGIN_DESIGN_2026-11-11.md',
        'major-constants/TURING_SPECTRAL_SURPLUS_REDUCTION_2026-11-11.md',
        'integration/REVIEW_SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md',
        'integration/REVIEW_SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md',
    ]
    pins={x:sha(AGENTS/x) for x in inputs}
    for x in ['CURRENT_SPECTRAL_OPERATION_BUDGET_2026-11-11.md','SELECTED_SCALED_SEED_ORDER_2026-11-11.md','SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md']:
        pins['work/qrh-blueprint/'+x]=sha(ROOT/'work/qrh-blueprint'/x)
    Q=66172730256514; n=4333246843; C=125400; SJ=2735223455
    savings={'pruning_complex_products':2607460638032558-1849018578634950,
             'pruning_complex_additions':5400371016768720-3808420069398260,
             'P24_to_P20_scale_and_add_each':4*99513098256768,
             'P28_to_P27_head_scale_and_add_each':2068094728192,
             'P28_to_P27_shift_updates':14350428160}
    conditional=[]
    b=F(8337,50)
    for h,D in [(200,F(1,4)),(250,F(1,2)),(375,F(1)),(500,F(5,4))]:
        rounded_cap=F(128160000)+265800*F(5,64)+265800*h
        assert F(8,3)**18>rounded_cap/6
        surplus=2-D-2*b/h
        assert surplus>0
        conditional.append({'h':h,'future_measured_D_upper':str(D),'b_upper':str(b),'surplus':str(surplus),'dense_extra_outputs':h*64//5*n})
    last=127988; step=F(5,64)
    assert last*step==F(159985,16)
    assert (128000-last)*step==F(15,16)
    V,N,D=10200,3454,8192
    extended=last+2560
    assert extended==130548 and extended*step<V
    assert N==(V+160+2)//3
    assert F(V+32,D)<F(5,4)
    assert F(291*N+433,2**22)<F(1,4)
    assert F(216*(N+2),255*2**128)<F(1,2**116)
    assert V+27<10240 and N+2==3456<4096
    assert F(8,3)**9>N+2
    assert V*F(1,2**17)<F(1,8)
    assert 9*V+1<100000
    recurrence=F(9,16)+F(extended,2**20)
    assert recurrence<F(11,16)
    assert (last+3200)*step>10208
    return {'scope':'Exact metadata and CONDITIONAL auxiliary/domain implications; no signs or success claims',
            'input_pins':pins,'large_conductors':C,'primitive_labels':n,'coarse_outputs':Q,'sum_J':SJ,
            'parity_global_phase_upper':2*127989,'conductor_phase_updates':SJ-C,'parity_conductor_time_products_upper':2*SJ,
            'dense_refined8_outputs':8*Q-7*n,'new_interpolation_outputs':7*(Q-n),
            'savings':{k:{'count':v,'per_nominal_output':str(F(v,Q))} for k,v in savings.items()},
            'conditional_guard_rows':conditional,'h1000_dense_extra_outputs':12800*n,
            'h200_candidate_extension':{'V':V,'N':N,'D':D,'last_j':extended,'last_t':str(extended*step),
              'x_max':N+2,'seed_error_over_eta_upper':str(F(291*N+433,2**22)),
              'recurrence_error_over_delta_upper':str(recurrence),
              'status':'NEW_DOMAIN_ADAPTER_AND_VALUES_REQUIRED'},
            'real_primitive_count':'not supplied by current aggregate manifest; orbit count remains (n+r_real)/2'}

if __name__=='__main__':
    out=run()
    HERE.joinpath('post_transform_certificate_metadata_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    print('Exact metadata and conditional guard checks passed; no values generated')
