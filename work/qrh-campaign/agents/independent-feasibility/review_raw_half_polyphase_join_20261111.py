"""Independent saved-integer cost reconstruction; no transform/function calls."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib
import json

BASE = Path(__file__).resolve().parents[1]
PIN = {
 'major-constants/RAW_HALF_POLYPHASE_VARIABLE_STENCIL_COST_2026-11-11.md':'4DF324E244610C99C7944E72DD2D02A7F525640044E80096CE62FB6F22BC5137',
 'major-constants/raw_half_polyphase_cost_join_20261111.py':'E56684624A98E62EF69CACE911781A7293567776F58FA24E87D91539B79CD003',
 'major-constants/raw_half_polyphase_cost_join_20261111.json':'FBFEFBB2D095B7A73E9DA7255135ED75A329E8811FC314086F08BEBEE63915B5',
}
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
def read(p):
 return json.loads((BASE/p).read_text())
for path,pin in PIN.items():
 ck(hashlib.sha256((BASE/path).read_bytes()).hexdigest().upper()==pin)
author=read('major-constants/raw_half_polyphase_cost_join_20261111.json')
ck(len(author['pins'])==12)
for path,pin in author['pins'].items():
 ck(hashlib.sha256((BASE/path).read_bytes()).hexdigest().upper()==pin)
ledger=read('prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json')
hist=read('prime-estimates/adaptive_small_theta_interpolation_20261111.json')
local=read('audit/raw_adaptive_theta_composition_20261111.json')
answer=[]
for item in ledger['scenarios']:
 e=item['extra_nodes']
 t=item['small_sign_only_conditional_candidate']['totals']
 h=next(x for x in hist['scenarios'] if x['extra_nodes']==e)
 l=next(x for x in local['scenarios'] if x['extra_nodes']==e)
 ar=next(x for x in author['rows'] if x['extra_nodes']==e)
 S=t['time_dft_complex_outputs']; F=t['time_butterflies']
 J=t['frequency_conjugate_copies']; C=t['primitive_labels']
 half=Q(2*F-S,4)
 ck(half.denominator==1)
 half=int(half)
 # Sum all seven explicit class schedules rather than use a single multiplier.
 core=dict(products=0,adds=0,rounds=0,halvings=0,raw_slots=0,conj=0,turns=0,c0=0)
 for phase in range(1,8):
  core['products']+=half+J+J
  core['adds']+=half*2+J*2
  core['rounds']+=half*3+J+2*J+J+C
  core['halvings']+=half*2
  core['raw_slots']+=S
  core['conj']+=2*J;core['turns']+=2*J;core['c0']+=C
 count=products=adds=rounds=0
 for order,num in h['order_query_histogram'].items():
  r=int(order)
  ck(182<=r<=260 and r%2==0)
  count+=num;products+=r*num;adds+=(r-1)*num;rounds+=2*r*num
 ck(count==7*(t['primitive_grid_outputs']-C))
 ck((count,products,adds,rounds)==(l['new_endpoints'],l['real_products'],l['real_additions'],l['rounding_gates']))
 for key in ('omega_complex_scalings','final_Y_real_products','positive_scale_real_updates'):
  ck(t[key]==0)
 expected={
  'complex_products':core['products'],'complex_additions':core['adds'],
  'complex_rounds':core['rounds'],'exact_butterfly_half_scales':core['halvings'],
  'raw_output_shift_and_store_upper':core['raw_slots'],
  'packed_conjugations':core['conj'],'packed_i_rotations':core['turns'],'C0_rounds':core['c0']}
 for k,v in expected.items():ck(ar['seven_classes'][k]==v)
 models={}
 for mul,add in [(3,5),(4,2)]:
  real_mul=mul*core['products'];real_add=add*core['products']+2*core['adds']
  got=ar['seven_classes']['real_models'][str(mul)]
  ck(got['real_products']==real_mul);ck(got['real_additions']==real_add)
  ck(got['product_saving_vs_local']==products-real_mul)
  ck(got['addition_saving_vs_local']==adds-real_add)
  ck(Q(got['product_ratio_lower_millionths'],10**6)<Q(real_mul,products))
  ck(Q(real_mul,products)<Q(got['product_ratio_upper_millionths'],10**6))
  models[str(mul)]={'products':real_mul,'additions':real_add,'product_saving':products-real_mul,'addition_saving':adds-real_add}
 ck(ar['all_local']=={'real_products':products,'real_additions':adds,'real_rounds':rounds,'sample_accesses':products})
 ck(ar['labels']==C==18477108)
 ck(ar['base_N_slots_sum']==S and ar['base_full_butterflies']==F and ar['positive_coefficients_sum']==J)
 ck(ar['base_half_butterflies']==half and ar['actual_dense_refinement_requests']==count)
 answer.append({'extra_nodes':e,'requests':count,'core':core,'local':{'products':products,'adds':adds,'rounds':rounds},'models':models})
ck(len(answer)==4)
ck(7*sum(range(182,261,2))==61880==author['kernel_pool_exact_weights'])
ck(author['new_main_or_global_ledger_adopted'] is False)
for ex in author['product_only_examples']:
 n=ex['N'];r=ex['order'];mu=ex['real_product_model'];q=ex['product_only_strict_query_threshold']
 depth=n.bit_length()-1;ck(2**depth==n)
 j=(25*n+191)//192
 demand=mu*((n//2)*(depth-1)//2+2*j)
 ck((q-1)*r<=demand<q*r)
ck(next(x for x in answer if x['extra_nodes']==320)['local']['adds']==2436206631058893)
result={'status':'PASS_SAVED_METADATA','checks':checks,'scope':'saved integer schedules and rational ratios only',
        'author_pins':PIN,'input_pins':author['pins'],'rows':answer}
target=Path(__file__).with_suffix('.json')
with target.open('x',encoding='utf-8') as f:
 json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(target.read_bytes()).hexdigest().upper()}))
