"""Compose frozen rational/integer metadata only; no transform or function values."""
from pathlib import Path
import hashlib,json
BASE=Path(__file__).resolve().parents[1]
PINS={
 'major-constants/HERMITIAN_HALF_TIME_TRANSFORM_2026-11-11.md':'16BA0E67BF7B674FD29748303DB44CBF0E43808727D053FCC008B3C22886F8A6',
 'major-constants/HERMITIAN_HALF_TRANSFORM_MINIMAL_THETA_APPLICABILITY_2026-11-11.md':'418E1991D01876108ECF804FC4811895722ED418B15E8E0FC03CE3E9D6F8DD82',
 'independent-feasibility/REVIEW_HERMITIAN_HALF_TRANSFORM_MINIMAL_THETA_APPLICABILITY_2026-11-11.md':'CB39B391444ABF131A695188B8B7730A27D83329A0ABBDB30FF70452A080ABC6',
 'prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json':'E767EC3B3E14F2A243837DA85C811DE5ED67CE701BDD08998C2329F9C687C24D',
 'zero-sum/REVIEW_SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md':'1D8FBDA28124B7FEE3CCDF500311809265463ECE38056ACD9E8F2F4053861300',
 'audit/RAW_ADAPTIVE_SMALL_THETA_COMPOSITION_2026-11-11.md':'0FF513632780E8DF9FA544E5B8AA8B919126BA8FD482D862B4761093D0996C81',
 'audit/ERRATUM_RAW_ADAPTIVE_SMALL_THETA_COMPOSITION_2026-11-11.md':'36B98744446E0CC527F69C9B4F1D64A41F5CA0D5266B9ED3FA265121BECABD35',
 'zero-sum/REVIEW_RAW_ADAPTIVE_SMALL_THETA_COMPOSITION_2026-11-11.md':'327E2AE13C5604079976B9A109BAF721A996F3A6C293B370B831215833570A77',
 'audit/raw_adaptive_theta_composition_20261111.json':'B6BC867C1F48648F9012271ACF9EC37F4E771DF9D4CA374016731069A1BA563D',
 'prime-estimates/adaptive_small_theta_interpolation_20261111.json':'3E6F184E7C7D2F13915F925C6687E3970204990035487DAC8BD41D9991C283A2',
 'major-constants/ONLINE_SPARSE_POLYPHASE_SWITCHING_2026-11-11.md':'078A8C9A9DA83888C837F1D13995EF87B2E7D14733587616D793F823AB7C0F52',
 'independent-feasibility/REVIEW_ONLINE_SPARSE_POLYPHASE_SWITCHING_2026-11-11.md':'01D725415C1894F8534A074786F211BC9688569C964D2AE231ABBB4B749F4418'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in PINS.items(): ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
def read(p): return json.loads((BASE/p).read_text())
ledger=read('prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json')
local=read('audit/raw_adaptive_theta_composition_20261111.json')
hist=read('prime-estimates/adaptive_small_theta_interpolation_20261111.json')
local={r['extra_nodes']:r for r in local['scenarios']}; hist={r['extra_nodes']:r for r in hist['scenarios']}
rows=[]
for row in ledger['scenarios']:
 e=row['extra_nodes']; branch=row['small_sign_only_conditional_candidate']
 t=branch['totals']; loc=local[e]; h=hist[e]
 S=t['time_dft_complex_outputs']; F=t['time_butterflies']; J=t['frequency_conjugate_copies']; C=t['primitive_labels']
 half=F//2-S//4
 ck(F%2==0 and S%4==0)
 q=7*(t['primitive_grid_outputs']-C)
 ck(q==loc['new_endpoints']); ck(q==sum(h['order_query_histogram'].values()))
 M=sum(int(r)*n for r,n in h['order_query_histogram'].items())
 ck(M==loc['real_products']); ck(M-q==loc['real_additions']); ck(2*M==loc['rounding_gates'])
 for key in ('omega_complex_scalings','final_Y_real_products','positive_scale_real_updates'): ck(t[key]==0)
 G=7*(half+2*J); A=7*(2*half+2*J); R=7*(3*half+4*J+C)
 models={}
 for mu,alpha in ((3,5),(4,2)):
  rm=mu*G; ra=alpha*G+2*A
  models[str(mu)]={'real_products':rm,'real_additions':ra,
     'product_saving_vs_local':M-rm,'addition_saving_vs_local':M-q-ra,
     'product_ratio_lower_millionths':rm*10**6//M,
     'product_ratio_upper_millionths':rm*10**6//M+1}
  ck(rm<M)
 rows.append({'extra_nodes':e,'labels':C,'base_N_slots_sum':S,'base_full_butterflies':F,'positive_coefficients_sum':J,
 'base_half_butterflies':half,'actual_dense_refinement_requests':q,
 'seven_classes':{'complex_products':G,'complex_additions':A,'complex_rounds':R,
                 'exact_butterfly_half_scales':14*half,'raw_output_shift_and_store_upper':7*S,
                 'packed_conjugations':14*J,'packed_i_rotations':14*J,
                 'C0_rounds':7*C,'real_models':models},
 'all_local':{'real_products':M,'real_additions':M-q,'real_rounds':2*M,'sample_accesses':M}})
ck(rows[0]['seven_classes']['complex_products']==315177493507002)
ck(rows[0]['all_local']['real_products']==2439308097734074)
examples=[]
for k in (18,24,30):
 N=2**k; J=(25*N+191)//192; fm=(N//2)*(k-1)//2; Kmul=fm+2*J
 for r in (182,260):
  for mu in (3,4):
   q0=mu*Kmul//r+1
   ck(q0*r>mu*Kmul); ck((q0-1)*r<=mu*Kmul)
   examples.append({'N':N,'order':r,'real_product_model':mu,
                    'product_only_strict_query_threshold':q0,
                    'scope':'excludes all additions, rounding, setup, data and persistence'})
out={'scope':'current selected N128-length family, fixed selected tilts; off-grid alternative counts only',
 'checks':checks,'pins':PINS,'rows':rows,'product_only_examples':examples,
 'kernel_pool_exact_weights':61880,'new_main_or_global_ledger_adopted':False}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f: json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),'main':rows[0]}))
