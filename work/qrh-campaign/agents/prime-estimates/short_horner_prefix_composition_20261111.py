"""Fixed-profile prefixes and saved band totals only. No values or population scan."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PINS={
 'work/qrh-campaign/agents/prime-estimates/SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md':'0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A',
 'work/qrh-campaign/agents/prime-estimates/shorter_hurwitz_output_orders_20261111.json':'4385975F56DE8CA2E4B42319DA3B0A2F5F1EB38C4520772F0E8BFC9602692B38',
 'work/qrh-campaign/agents/prime-estimates/stored_hurwitz_degree_bounds_20261111.json':'E947C32ED8EA30BA14ED64A7DFF83AA1C8E3F3F222AAD1AD8DAA8484013781BE',
 'work/qrh-campaign/agents/major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
 'work/qrh-campaign/agents/prime-estimates/optimize_degree_horner_grids_20261111.json':'9BA037D7AAFB7A0F053C109ABD9751112B586805236A14D9467EFD29B32871CE',
 'work/qrh-campaign/agents/moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md':'96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3',
 'work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.json':'4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9',
 'work/qrh-campaign/agents/independent-feasibility/REVIEW_FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md':'57D7DEDBA4D5497861DD641F4CC68416CA89EEAD0358F2151DA005ABCE319468',
 'work/qrh-campaign/agents/prime-estimates/large_residue_bucket_occupancy_20261111.json':'19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB',
 'work/qrh-campaign/agents/moebius/REVIEW_LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md':'C6096D0C677E09F850065EDD2103B0348E28392D482CCEE568136B387768C86E',
}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def read(rel):return json.loads((ROOT/rel).read_text(encoding='utf-8'))
source=read('work/qrh-campaign/agents/prime-estimates/stored_hurwitz_degree_bounds_20261111.json')
grids=read('work/qrh-campaign/agents/prime-estimates/optimize_degree_horner_grids_20261111.json')
old=read('work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.json')
orders=read('work/qrh-campaign/agents/prime-estimates/shorter_hurwitz_output_orders_20261111.json')
occupancy=read('work/qrh-campaign/agents/prime-estimates/large_residue_bucket_occupancy_20261111.json')
profiles={'uniform100':grids['comparisons']['uniform100']['grid'],
 'root_linear':grids['comparisons']['root_linear_profile']['grid'],
 'fixed_15442':grids['pareto_profiles'][0]['grid']}
u=F(1,2**100)
def width(x):
 ck(x>0)
 e=x.numerator.bit_length()-x.denominator.bit_length()
 while F(2)**e<=x:e+=1
 while F(2)**(e-1)>x:e-=1
 ck(F(2)**(e-1)<=x<F(2)**e)
 return e
def digits(w):return max(1,(w+7)//8)
def mul(a,b):
 m,n=sorted([digits(a),digits(b)],reverse=True)
 return 5*m*n+2*n+1

results={}
for cohort in ['first_four','final']:
 Z=[F(row['stored_center_norm_bound']) for row in source['cohorts'][cohort]]
 results[cohort]={}
 for name,full in profiles.items():
  base=old['results'][cohort][name]
  ck(full==base['grids'])
  rows=[]
  for K in range(10,21):
   b=full[:K];e=[F(3,4)*F(2)**(-x) for x in b]
   ck(all(b[j]>=b[j+1]>=70 for j in range(K-1)))
   converted=[Z[j]+e[j] for j in range(K)]
   acc=[F(0)]*K; product=[F(0)]*(K-1)
   acc[-1]=converted[-1]
   for j in range(K-2,-1,-1):
    product[j]=acc[j+1]/4+e[j]
    acc[j]=converted[j]+product[j]
   err=sum(e[j]*F(1,4)**j for j in range(K))+sum(e[j]*F(1,4)**j for j in range(K-1))
   ck(err/u<=F(base['error_factor'])<F(8,3))
   stages=[]
   for j in range(K-2,-1,-1):
    M=acc[j+1]*2**b[j+1];L=product[j]*2**b[j]
    wM,wL=width(M),width(L);delta=b[j]-b[j+1]
    X=132900*M*2**delta;LV=531600*L
    cost=2*(mul(18,wM)+mul(20,wL))
    original=next(r for r in base['stages'] if r['stage']==j)
    ck(acc[j+1]<=F(original['input_accumulator_norm_cap']))
    ck(cost<=original['product_variants']['uncancelled']['complex_product_template_events'])
    stages.append(dict(stage=j,first_stage=j==K-2,input_grid=b[j+1],output_grid=b[j],
     alignment_bits=delta,input_norm_cap=str(acc[j+1]),rounded_product_norm_cap=str(product[j]),
     output_norm_cap=str(acc[j]),input_magnitude_bits=wM,rounded_magnitude_bits=wL,
     input_bytes=digits(wM),rounded_bytes=digits(wL),product_template_events=cost,
     raw_product_signed_bits=width(132900*M)+1,shifted_product_signed_bits=width(X)+1,
     witness_product_signed_bits=width(LV)+1,raw_residual_signed_bits=width(X+LV)+1,
     double_raw_residual_signed_bits=width(2*(X+LV))+1,
     exact_add_output_signed_bits=width(acc[j]*2**b[j])+1))
   subtotal=sum(s['product_template_events'] for s in stages)
   deleted=sum(s['product_variants']['uncancelled']['complex_product_template_events']
               for s in base['stages'] if s['stage']>=K-1)
   discount=base['product_template_events']-deleted-subtotal
   ck(discount>=0)
   if K==20:
    ck(subtotal==base['product_template_events'] and err/u==F(base['error_factor']))
   else:
    lost=F(3,4)*F(2)**(-full[K-1])*F(1,4)**(K-1)
    lost+=sum((2 if j<19 else 1)*F(3,4)*F(2)**(-full[j])*F(1,4)**j for j in range(K,20))
    ck(F(base['error_factor'])*u-err==lost)
   rows.append(dict(K=K,degree=K-1,grid=b,complex_stages=K-1,real_product_proofs=4*(K-1),
    error_in_u=str(err/u),reserve_in_u=str(F(8,3)-err/u),
    highest_coefficient_single_error_in_u=str(e[-1]*F(1,4)**(K-1)/u),
    initial_converted_norm_cap=str(converted[-1]),initial_signed_bits=width(converted[-1]*2**b[-1])+1,
    product_template_events=subtotal,full20_product_template_events=base['product_template_events'],
    deleted_high_stage_events=deleted,remaining_stage_width_discount=discount,
    nonzero_shifts=sum(s['alignment_bits']>0 for s in stages),
    total_shift_bits=sum(s['alignment_bits'] for s in stages),stages=stages))
  results[cohort][name]=rows

maxima=[19,19,19,20,18]
for i,(band,K) in enumerate(zip(orders['bands'],maxima)):
 ck(max(r['K'] for r in band['selected_grid_ranges'])==K)
scenarios=[]
for scenario in occupancy['scenarios']:
 bands=[]
 for i,band in enumerate(scenario['bands']):
  U=sum(c['unit_outputs'] for c in band['cohorts']);K=maxima[i]
  bands.append(dict(band=i+1,K=K,unit_residue_height_inputs=U,
   old_stages=19*U,new_stages=(K-1)*U,removed_stages=(20-K)*U,
   real_product_proofs=4*(K-1)*U))
 ck(sum(b['old_stages'] for b in bands)==scenario['old_Horner_stages'])
 ck(sum(b['unit_residue_height_inputs'] for b in bands)==scenario['unit_residue_height_inputs'])
 before=sum(b['old_stages'] for b in bands);after=sum(b['new_stages'] for b in bands)
 ck(before-after==sum(b['removed_stages'] for b in bands))
 scenarios.append(dict(extra_nodes=scenario['extra_nodes'],bands=bands,old_stages=before,
   new_stages=after,removed_stages=before-after,stage_fraction_removed=str(F(before-after,before))))

out=dict(scope='Fixed profile prefixes; exact saved-total stage counts, not full costs or runtime.',
 checks=checks,pins=PINS,profiles=profiles,results=results,bandwise_maximum_K=maxima,scenarios=scenarios,
 within_band_unit_weighted_variable_orders='not reconstructed; saved band totals alone do not determine them',
 final_K18_gate='requires independent review of shorter-output endpoint admission before adoption')
dest=HERE/'short_horner_prefix_composition_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'selected_subtotals':{c:{n:{r['K']:r['product_template_events'] for r in rows if r['K']>=18} for n,rows in tab.items()} for c,tab in results.items()},
 'scenarios':[{k:s[k] for k in ['extra_nodes','old_stages','new_stages','removed_stages']} for s in scenarios]},indent=2))
