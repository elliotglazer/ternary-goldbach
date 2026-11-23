"""Saved-ledger integer/Fraction sensitivity checks only. No evaluator imports."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
AGENTS = ROOT / 'work/qrh-campaign/agents'
assert (ROOT / 'work').is_dir()
ledger_path = AGENTS / 'prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json'
assert hashlib.sha256(ledger_path.read_bytes()).hexdigest().upper() == 'E767EC3B3E14F2A243837DA85C811DE5ED67CE701BDD08998C2329F9C687C24D'
ledger = json.loads(ledger_path.read_text())
main = next(s for s in ledger['scenarios'] if s['extra_nodes'] == 0)
large = main['large']
small = main['small_sign_only_conditional_candidate']['totals']
G = large['transform_operations']['general_complex_products']
R = large['residue_inputs']
H = large['P20_Horner_stages']
head = large['seed_totals']['head_reciprocal_scales']
tf = small['time_butterflies']
sn = small['time_dft_complex_outputs']
sj = small['frequency_conjugate_copies']
assert H == 19 * R
half_fft = F(tf, 2) - F(sn, 4)
assert half_fft.denominator == 1
half = int(half_fft) + sj
saved = tf - half
dense = 7 * (int(half_fft) + 2 * sj)
local = 2439308097734074
assert (G, R, head) == (1004103686197888, 59962061953248, 10962363526720)
assert (half, saved, dense) == (43822509521403, 46035708085765, 315177493507002)
assert 17632 - 15442 == 2190
product_delta = 2190 * R
B = 4 * 10**18
N0 = 989 * 10**24
T = N0 - 1
ceildiv = lambda a, b: (a + b - 1) // b
K = ceildiv(T - B - 3, B - 2)
forced = sum(max(0, ceildiv((2**j+1)**2 - 3, B-2)-1) for j in range(1,45))
square_geom = 44*K - forced
words = ceildiv(B//2 - 1, 64)
assert (K, forced, square_geom, words) == (247250000,103161663,10775838337,31250000000000000)
ratios = {
 'large_complex_products_per_residue': F(G,R),
 'half_saved_products_per_residue': F(saved,R),
 'large_character_price_over_head_price_at_equality': F(head,G),
 'head_price_over_character_price_at_equality': F(G,head),
 'small_character_butterfly_price_over_large_product_at_equality': F(G,small['main_character_butterflies']),
 'residue_net_saving_in_macro_price_units_to_equal_character_product_bill': F(G,R),
 'uniform_to_optimized_product_delta_fraction': F(2190,17632),
 'dense_complex_price_over_local_real_at_product_only_equality': F(local,dense),
 'word_price_over_large_product_at_onepass_equality': F(G,words),
 'modsquare_price_over_large_product_at_geometric_equality': F(G,square_geom),
}
brackets = {
 'large_complex_products_per_residue': ('16.74','16.75'),
 'half_saved_products_per_residue': ('.767','.768'),
 'head_price_over_character_price_at_equality': ('91','92'),
 'small_character_butterfly_price_over_large_product_at_equality': ('7.78','7.79'),
 'uniform_to_optimized_product_delta_fraction': ('.124','.125'),
 'dense_complex_price_over_local_real_at_product_only_equality': ('7.73','7.75'),
 'word_price_over_large_product_at_onepass_equality': ('.0321','.0322'),
 'modsquare_price_over_large_product_at_geometric_equality': ('93181','93182'),
}
for key, (lo,hi) in brackets.items():
 assert F(lo) < ratios[key] < F(hi), (key,ratios[key])

paths = [
 'integration/END_TO_END_COMPUTE_RESEARCH_PRIORITIES_2026-11-11.md',
 'major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md',
 'zero-sum/REVIEW_RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md',
 'prime-estimates/SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md',
 'prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json',
 'zero-sum/REVIEW_SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md',
 'major-constants/RAW_HALF_POLYPHASE_VARIABLE_STENCIL_COST_2026-11-11.md',
 'independent-feasibility/REVIEW_RAW_HALF_POLYPHASE_VARIABLE_STENCIL_COST_2026-11-11.md',
 'audit/RESIDUE_EVALUATOR_BLUEPRINT_V2_2026-11-11.md',
 'audit/REVIEW_MATCHED_NORMALIZED_RESIDUE_COST_COMPARISON_2026-11-11.md',
 'prime-estimates/OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md',
 'independent-feasibility/REVIEW_OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md',
 'audit/ALL_THETA_TIME_LENGTH_FRONTIER_2026-11-11.md',
 'zero-sum/REVIEW_ALL_THETA_TIME_LENGTH_FRONTIER_2026-11-11.md',
 'prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md',
 'independent-feasibility/REVIEW_FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md',
 'moebius/EFFICIENCY_JOINT_BINARY_FRONTIER_2026-11-11.md',
 'prime-estimates/FINITE_LADDER_SIZE_BAND_CERTIFICATES_2026-11-11.md',
 'integration/REVIEW_FINITE_LADDER_SIZE_BAND_CERTIFICATES_2026-11-11.md',
 'prime-estimates/PRINCIPAL_RH_1E8_MINIMAL_CERTIFICATE_COST_2026-11-11.md',
 'audit/REVIEW_PRINCIPAL_RH_1E8_MINIMAL_CERTIFICATE_COST_2026-11-11.md',
 'audit/EFFICIENCY_MM0_SPECTRAL_PROOF_VOLUME_2026-11-11.md',
 'moebius/REVIEW_EFFICIENCY_MM0_SPECTRAL_PROOF_VOLUME_2026-11-11.md',
 'audit/EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md',
 'independent-feasibility/REVIEW_EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md',
]
files = [AGENTS / p for p in paths] + [ROOT / 'work/qrh-blueprint' / p for p in [
 'END_TO_END_EFFICIENCY_MODEL_2026-11-11.md',
 'SIGN_ONLY_SCHEDULE_ADOPTION_2026-11-11.md',
 'HALF_TRANSFORM_FRONTIER_AND_PRIORITY_DECISIONS_2026-11-11.md',
]]
pins = {str(p):hashlib.sha256(p.read_bytes()).hexdigest().upper() for p in files}
out = {
 'scope':'saved metadata, integer arithmetic and symbolic-price sensitivities only',
 'pins':pins,
 'main_counts':{'G':G,'large_add':large['transform_operations']['complex_add_sub'],'residues':R,'old_Horner_stages':H,'head_scales':head,'small_character_butterflies':small['main_character_butterflies'],'small_Gaussian_upper':small['Gaussian_unit_gates_upper'],'small_time_full':tf,'small_time_half_products':half,'half_saved_products':saved,'dense_seven_class_products':dense,'local_full_query_real_products':local},
 'unsigned_product_subtotal_delta_only':product_delta,
 'finite_hypothetical_geometry':{'B':B,'N0':N0,'Kmin':K,'forced_saved_squares_all_fixed_root':forced,'suffix_square_calls_at_maxstep_geometry':square_geom,'one_64bit_word_pass':words},
 'ratios':{k:{'num':v.numerator,'den':v.denominator,'bracket':brackets.get(k)} for k,v in ratios.items()},
 'limits':['No actual prime chain or full binary pass asserted.','No homogeneous gate price assumed.','No author generator or analytic evaluator imported.','No full-cost winner inferred.'],
}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:
 json.dump(out,f,indent=2); f.write('\n')
print('PASS',len(pins),'pins;',len(brackets),'strict ratio brackets')
