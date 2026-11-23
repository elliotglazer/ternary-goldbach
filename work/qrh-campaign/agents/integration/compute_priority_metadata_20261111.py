"""Exact arithmetic on frozen ledgers; no numerical evaluator imports."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
OWN = Path(__file__).resolve().parent
paths = [
    'work/qrh-blueprint/MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md',
    'work/qrh-blueprint/minimal_theta_nonprincipal_schedule_20261111.json',
    'work/qrh-blueprint/SELECTED_RAW_SIGN_COMPOSITION_DECISIONS_2026-11-11.md',
    'work/qrh-blueprint/WIDTH_ARITHMETIC_AND_STREAMING_DECISIONS_2026-11-11.md',
    'work/qrh-campaign/agents/major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md',
    'work/qrh-campaign/agents/zero-sum/REVIEW_RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md',
    'work/qrh-campaign/agents/major-constants/HERMITIAN_HALF_TIME_TRANSFORM_2026-11-11.md',
    'work/qrh-campaign/agents/prime-estimates/SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md',
    'work/qrh-campaign/agents/prime-estimates/ADAPTIVE_SMALL_THETA_INTERPOLATION_ORDER_2026-11-11.md',
    'work/qrh-campaign/agents/integration/REVIEW_ADAPTIVE_SMALL_THETA_INTERPOLATION_ORDER_2026-11-11.md',
    'work/qrh-campaign/agents/major-constants/SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md',
    'work/qrh-campaign/agents/major-constants/ONLINE_SPARSE_POLYPHASE_SWITCHING_2026-11-11.md',
    'work/qrh-campaign/agents/independent-feasibility/MODULUS_WEIGHTED_PLUS_STAR_RESEARCH_2026-11-11.md',
    'work/qrh-campaign/agents/major-constants/EFFICIENCY_GLOBAL_SPECTRAL_BOTTLENECK_2026-11-11.md',
    'work/qrh-campaign/agents/integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md',
    'work/qrh-campaign/agents/prime-estimates/PRINCIPAL_RH_1E8_MINIMAL_CERTIFICATE_COST_2026-11-11.md',
    'work/qrh-campaign/agents/audit/REVIEW_PRINCIPAL_RH_1E8_MINIMAL_CERTIFICATE_COST_2026-11-11.md',
    'work/qrh-campaign/agents/independent-feasibility/FINITE_COVERAGE_COST_FRONTIER_V2_2026-11-11.md',
    'work/qrh-campaign/agents/prime-estimates/REVIEW_FINITE_COVERAGE_COST_FRONTIER_V2_2026-11-11.md',
]
pins = {p: hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}
assert pins[paths[1]] == '96483C8A5E47888AC9208A8B95CA1BD8261CBC9D42AFBCBAEE1A1ABF10AC9265'
assert pins[paths[6]] == '16BA0E67BF7B674FD29748303DB44CBF0E43808727D053FCC008B3C22886F8A6'
x = json.loads((ROOT/paths[1]).read_text())['scenarios'][0]
s = x['small_minimal_theta_candidate']['totals']
g = x['large']['transform_operations']['general_complex_products']
h = x['large']['P20_Horner_stages']
f, n, j = s['time_butterflies'], s['time_dft_complex_outputs'], s['frequency_conjugate_copies']
half = f//2-n//4
saved = f-half-j
assert half == 42619662827520 and saved == 46035708085765
real_large = 3*g+2*h
local = 2439308097734074
full_poly = 7*(f+j)
half_poly = 7*(half+2*j)
out = {
 'scope':'Metadata sensitivity only; half circuit pending independent review; no timing or sign data',
 'pins': pins,
 'main': {'small_F':f,'sum_N':n,'sum_J':j,'half_F':half,'half_packing_products':j,
          'saved_complex_products':saved,'saved_complex_additions':2*saved,
          'saved_complex_rounds':3*saved-s['primitive_labels'],
          'large_G':g,'large_Horner':h,'large_three_product_real_subtotal':real_large,
          'seven_full_poly_complex_products':full_poly,'seven_half_poly_complex_products':half_poly,
          'adaptive_full_local_real_products':local,
          'local_minus_three_product_full_poly_products':local-3*full_poly,
          'local_minus_three_product_half_poly_products':local-3*half_poly},
 'exact_thresholds': {'small_complex_price_over_large_complex_for_G_equality':str(Q(g,saved)),
                      'small_product_price_over_large_product_for_combined_product_equality':str(Q(real_large,3*saved)),
                      'dense_full_complex_price_over_local_real_product':str(Q(local,full_poly)),
                      'dense_half_complex_price_over_local_real_product':str(Q(local,half_poly))},
 'schoolbook_width_sensitivity': [
     {'width_ratio':str(r),'small_saving_over_large_G':str(Q(saved,g)*r*r),
      'small_three_product_saving_over_large_product_subtotal':str(Q(3*saved,real_large)*r*r)}
     for r in (Q(1),Q(3,2),Q(2),Q(3))],
 'finite_fixed_B4e18': {'mandatory_new_rungs':247250000,
      'mandatory_supplied_root_square_calls':10775838307,
      'single_64bit_target_word_pass':(4*10**18-2+127)//128},
}
with (OWN/'compute_priority_metadata_20261111.json').open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({k:v for k,v in out.items() if k!='pins'},indent=2))
