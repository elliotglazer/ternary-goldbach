"""Saved-data and exact sensitivity review; no producer/evaluator imports."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
BASE=Path(__file__).resolve().parents[1]
PINS={
'audit/END_TO_END_COST_INVENTORY_AND_PRIORITIES_2026-11-11.md':'756DC55EF39C35597C17939339BA4C2CCC5E40A701DFB5073D4DDA31FE23E69C',
'audit/ERRATUM_END_TO_END_COST_PRINCIPAL_HEAD_2026-11-11.md':'3A190899E4CC87A1D50A451CD19FF55698A7FE2A0845F92C76CFBE1F9A4154F9',
'audit/end_to_end_cost_sensitivities_20261111.py':'E7955C2A86F0CDE55503F5107CD9465A346A85F004E8375F0BDC6F15D426C25F',
'audit/end_to_end_cost_sensitivities_20261111.json':'D41386C480F1C74717EE6DE877F7B305D34BC3475A3D3905443A1FFAD8695908',
'major-constants/raw_half_polyphase_cost_join_20261111.json':'FBFEFBB2D095B7A73E9DA7255135ED75A329E8811FC314086F08BEBEE63915B5'}
checks=0
def ck(x):
    global checks
    assert x
    checks+=1
for p,h in PINS.items():ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
a=json.loads((BASE/'audit/end_to_end_cost_sensitivities_20261111.json').read_text())
ck(len(a['pins'])==28)
for p,h in a['pins'].items():ck(hashlib.sha256(Path(p).read_bytes()).hexdigest().upper()==h)
ledger=json.loads((BASE/'prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json').read_text())
main=[s for s in ledger['scenarios'] if s['extra_nodes']==0]
ck(len(main)==1)
large=main[0]['large'];small=main[0]['small_sign_only_conditional_candidate']['totals']
poly=json.loads((BASE/'major-constants/raw_half_polyphase_cost_join_20261111.json').read_text())['rows'][0]
ck(poly['extra_nodes']==0)
G=large['transform_operations']['general_complex_products'];R=large['residue_inputs']
head=large['seed_totals']['head_reciprocal_scales']
full=small['time_butterflies'];N=small['time_dft_complex_outputs'];J=small['frequency_conjugate_copies']
ck((2*full-N)%4==0)
half_fft=(2*full-N)//4
half=half_fft+J
dense=7*half_fft+14*J
dense_add=14*half_fft+14*J
local=poly['all_local']['real_products']
counts={'G':G,'large_add':large['transform_operations']['complex_add_sub'],
'residues':R,'old_Horner_stages':19*R,'head_scales':head,
'small_character_butterflies':small['main_character_butterflies'],
'small_Gaussian_upper':small['Gaussian_unit_gates_upper'],'small_time_full':full,
'small_time_half_products':half,'half_saved_products':full-half,
'dense_seven_class_products':dense,'local_full_query_real_products':local}
ck(counts==a['main_counts'])
ck(large['P20_Horner_stages']==19*R)
ck(poly['base_half_butterflies']==half_fft)
ck(poly['seven_classes']['complex_products']==dense)
ck(poly['seven_classes']['complex_additions']==dense_add)
ck(3*dense==945532480521006)
ck(5*dense+2*dense_add-poly['all_local']['real_additions']==376037530158283)
ck(small['primitive_grid_outputs']==1775431871117)
ck(N==9237783904256)
ck(large['seed_totals']['head_accumulator_additions']==11379239858080)
ck(large['seed_totals']['Bernoulli_weighted_terms']==702585728572)
ck(large['seed_totals']['Bernoulli_accumulator_additions']==702585728572)
ck(ledger['setup']['large_seed']['distinct_arguments_union']==7049217)
ck(ledger['setup']['large_transform_unchanged']['kernel_count']==6004)
ck(ledger['setup']['large_transform_unchanged']['kernel_entries']==337702368)
ck((17632-15442)*R==a['unsigned_product_subtotal_delta_only'])
ck(17632-16252==1380 and 16252-15442==810)

# Derive finite geometry independently by integer strict-inequality counts.
B=4*10**18;N0=989*10**24;T=N0-1;D=B-2
target=T-B-3
K=target//D+int(target%D!=0)
ck((K-1)*D<target<=K*D)
saved=0
for j in range(1,45):
    A=(2**j+1)**2
    n=max(0,(A-4)//D)
    ck(n<=K)
    if n:ck(3+n*D<A)
    ck(3+(n+1)*D>=A)
    saved+=n
squares=44*K-saved
words=(B+125)//128
ck(64*(words-1)<B//2-1<=64*words)
finite=dict(B=B,N0=N0,Kmin=K,forced_saved_squares_all_fixed_root=saved,
            suffix_square_calls_at_maxstep_geometry=squares,one_64bit_word_pass=words)
ck(finite==a['finite_hypothetical_geometry'])
ck(squares==10775838337 and squares-10775838307==30)
ratios={
'large_complex_products_per_residue':F(G,R),
'half_saved_products_per_residue':F(full-half,R),
'large_character_price_over_head_price_at_equality':F(head,G),
'head_price_over_character_price_at_equality':F(G,head),
'small_character_butterfly_price_over_large_product_at_equality':F(G,small['main_character_butterflies']),
'residue_net_saving_in_macro_price_units_to_equal_character_product_bill':F(G,R),
'uniform_to_optimized_product_delta_fraction':F(2190,17632),
'dense_complex_price_over_local_real_at_product_only_equality':F(local,dense),
'word_price_over_large_product_at_onepass_equality':F(G,words),
'modsquare_price_over_large_product_at_geometric_equality':F(G,squares)}
brackets=0
for key,r in ratios.items():
    row=a['ratios'][key];ck(r==F(row['num'],row['den']))
    if row['bracket']:
        lo,hi=map(F,row['bracket'])
        ck(lo.numerator*r.denominator<r.numerator*lo.denominator)
        ck(r.numerator*hi.denominator<hi.numerator*r.denominator)
        brackets+=1
ck(brackets==8)
result={'scope':'saved-data exact arithmetic and source-scope review only',
        'checks':checks,'pins':PINS,'input_pins':a['pins'],'main_counts':counts,
        'finite_hypothetical_geometry':finite,'strict_brackets_checked':brackets,
        'mandatory_clarification':'No separate N1500/Q1500 selected-consumer obligation; charge only actual producer or alternative-route use.'}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8',newline='\n') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'brackets':brackets,'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
