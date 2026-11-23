"""Approved small saved-receipt fold. No coefficient/circuit/conductor generation."""
from pathlib import Path
from collections import Counter
from fractions import Fraction as F
import json,hashlib
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3]
B='work/qrh-campaign/agents/'
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
pins={
B+'moebius/joint_horner_length_precision_20261111.json':'59EBE87D5E5B2623C8F40A1EADB0F7803106F5005F90826C35F5B08C69284742',
B+'moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63',
B+'independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7',
'work/qrh-blueprint/SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md':'6DF38245BECCD8A35B94F98787C4DEF64EEB9EFCF9FB07E54E1D9EC554C48DF2',
'work/qrh-blueprint/short_guard_horner_admission_20261111.json':'C8EA9BEC79CB00DBDCB3FB14D8C00F142592737D3300267CE29F89F2C5BE01B2',
B+'major-constants/REVIEW_SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md':'4D313FBFEC13EBC9D80490C5CC995228D67E71F211F865113A67969A60BB82E9',
'work/qrh-blueprint/HEIGHT_LAYER_COEFFICIENT_CONVERSION_CACHE_2026-11-11.md':'9471C5D353D459C6C6B22A6DD5C555618C9CFACF9B94950FD5C839FF02771C2B',
'work/qrh-blueprint/coefficient_layer_cache_metadata_20261111.json':'CE161550F3F8E0DB9B9448F9347EBC7747415295873FE62157C8956C20FC3993',
B+'moebius/REVIEW_HEIGHT_LAYER_COEFFICIENT_CONVERSION_CACHE_2026-11-11.md':'F6F513FD353E83AA4D9CF0529D59611234FB0998737657DDC1B30FF01F4FCB71',
B+'integration/transform_structural_inventory_20261111.json':'503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0',
B+'integration/short_window_guard_ledger_20261111.json':'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4',
B+'zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md':'15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA',
B+'integration/normalized_transform_short_guard_join_20261111.json':'4F6F20570E0E1F35C806E173E2FA13B95CCD084B177F38F359E3F3171F5EB66A',
B+'audit/REVIEW_NORMALIZED_TRANSFORM_SHORT_GUARD_JOIN_2026-11-11.md':'47B0B4971E65D79E819DA3717DBEA9058D348CF02411AC6F78F32F4E3CBF489D',
}
data={}
for rel,h in pins.items():
 p=ROOT/rel
 cap=24*1024**2 if rel.endswith('joint_horner_length_precision_20261111.json') else 512*1024
 ck(p.stat().st_size<=cap)
 raw=p.read_bytes() # one bounded read; these same bytes serve hash and parse
 ck(hashlib.sha256(raw).hexdigest().upper()==h)
 if rel.endswith('.json'):data[Path(rel).name]=json.loads(raw)
del raw
joint=data.pop('joint_horner_length_precision_20261111.json')
select=[(f'band{i}',K,94) for i in (1,2,3) for K in (19,20)]
select += [('band4',20,94),('band5_declared',19,93),('band5_declared',20,94),('band5_actual',18,94),('band5_actual',20,94)]
selected={}
for case,K,b0 in select:
 rows=[r for r in joint['results'][case]['profiles']['fixed']['candidates'] if (r['K'],r['b0'])==(K,b0)]
 ck(len(rows)==1)
 r=rows[0];ck(r['admitted'] and F(r['alpha_ratio'])<1)
 selected[f'{case}_K{K}_b{b0}']=r
ck(len(selected)==11)
del joint # no traversal or recreation of unused candidates
def A(w):return 2*((w+7)//8)+1
def M(a,b):
 m,n=(a+7)//8,(b+7)//8
 return 5*m*n+2*min(m,n)+1
stage_checks=0
for key,r in selected.items():
 K=r['K'];ck(len(r['stages'])==K-1 and len(r['grids'])==K)
 for s in r['stages']:
  stage_checks+=1
  j=s['j'];ck(s['grids']==[r['grids'][j+1],r['grids'][j]])
  ck(s['product_events']==2*(M(18,s['Mbits'])+M(20,s['Lbits'])))
  ck(s['addition_events']==2*sum(A(w) for w in s['add_magnitude_bits']))
 ck(r['product_events']==sum(s['product_events'] for s in r['stages']))
 ck(r['addition_events']==sum(s['addition_events'] for s in r['stages']))
 for field,v in {'conversion_coordinate_count':2*K,'signed_add_bridges':6*(K-1),'signed_product_bridges':4*(K-1),
  'range_implications':2*(K-1),'real_add_instances':8*(K-1),'output_reencoding_shift':100-r['b0']}.items():ck(r[field]==v)
 ck(r['alignment_shift_instances']==sum(2 for s in r['stages'] if s['grids'][1]>s['grids'][0]))
 ck(r['alignment_bit_distance']==sum(2*(s['grids'][1]-s['grids'][0]) for s in r['stages']))
 ck(r['reencoded_output_signed_bits']==114)
ck(stage_checks<=11*19)
ra=selected['band5_actual_K20_b94'];rd=selected['band5_declared_K20_b94']
ck({k:v for k,v in ra.items() if k not in ('alpha_ratio','target_ratio')}=={k:v for k,v in rd.items() if k not in ('alpha_ratio','target_ratio')})
guardad=data['short_guard_horner_admission_20261111.json']
for K,b0,case in ((18,94,'band5_actual'),(19,93,'band5_declared')):
 row=next(r for r in guardad['rows'] if (r['K'],r['b0'],F(r['V']))==(K,b0,F(26525,4)))
 ck(row['admitted'] and F(row['alpha_ratio'])<1)
 ck(row['grids']==selected[f'{case}_K{K}_b{b0}']['grids'])
 ck(633*F(row['evaluation'])*2**82==F(selected[f'{case}_K{K}_b{b0}']['evaluation_ratio']))

old=data['transform_structural_inventory_20261111.json']
guard=data['short_window_guard_ledger_20261111.json']
cache=data['coefficient_layer_cache_metadata_20261111.json']
transform=data['normalized_transform_short_guard_join_20261111.json']
tp=next(a for a in transform['allocations'] if a['p']==108)['profiles']
EXTRAS=[0,167,320,640];FS=[1024,2048,4096,8192,16384]
schedule_keys={
 'full20_fixed_b94':[f'band{i}_K20_b94' for i in (1,2,3,4)]+['band5_declared_K20_b94'],
 'short_final18':[f'band{i}_K19_b94' for i in (1,2,3)]+['band4_K20_b94','band5_actual_K18_b94'],
 'short_final19':[f'band{i}_K19_b94' for i in (1,2,3)]+['band4_K20_b94','band5_declared_K19_b93'],
}
def per_output(r):
 k=r['K'];s=k-1
 return dict(product_core=r['product_events'],addition_core=r['addition_events'],complex_stages=s,
  real_product_instances=4*s,real_add_instances=8*s,signed_product_bridges=4*s,signed_add_bridges=6*s,
  nearest_range_implications=2*s,residual_doubling_shifts=2*s,alignment_shift_instances=r['alignment_shift_instances'],
  alignment_bit_distance=r['alignment_bit_distance'],grid100_export_coordinate_shifts=2,
  grid100_export_shift_bit_distance=2*(100-r['b0']),grid108_embedding_coordinate_shifts=2,grid108_embedding_shift_bit_distance=16,
  top_coordinate_copies=2,coefficient_coordinate_lookups=2*k)
def scaled(values,n):return {k:v*n for k,v in values.items()}
scenarios=[]
for si,extra in enumerate(EXTRAS):
 g=guard['scenarios'][si];c=cache['scenarios'][si]
 ck(g['extra_nodes']==c['extra_nodes']==extra)
 oldR=old['unit_band'][5*si:5*si+5]
 guardR=[r['residue_inputs'] for r in g['added_by_band']]
 ck(sum(oldR)==c['unit_outputs']==g['old_runtime']['residue_inputs'])
 ck(sum(guardR)==g['added_runtime']['residue_inputs'])
 layers=[6401,6400,12800,38400,20199+extra]
 ck(sum(layers)==g['global_old_count'])
 ck(g['global_new_count']==sum(layers)+41)
 schedules={}
 for name,keys in schedule_keys.items():
  bands=[];totals={q:Counter() for q in ('old','guard','joined')};conversions=Counter()
  for bi,key in enumerate(keys):
   r=selected[key];unit=per_output(r);O=oldR[bi];G=guardR[bi]
   cc=c['modes']['full20']['bands'][bi]
   ck((cc['F'],cc['heights'],cc['unit_residue_height_inputs'])==(FS[bi],layers[bi],O))
   conv={}
   for part,H in (('old',layers[bi]),('guard',41 if bi==4 else 0),('joined',layers[bi]+(41 if bi==4 else 0))):
    arrays=(FS[bi]+1)*H
    conv[part]=dict(height_layers=H,array_admissions=arrays,complex_conversions=r['K']*arrays,
     coordinate_conversions=2*r['K']*arrays,per_degree_coordinate_conversion_instances=[2*arrays]*r['K'])
    conversions[part+'_arrays']+=arrays
    conversions[part+'_coordinate_conversions']+=2*r['K']*arrays
   weighted={part:scaled(unit,N) for part,N in (('old',O),('guard',G))}
   weighted['joined']={k:weighted['old'][k]+weighted['guard'][k] for k in unit}
   for part,v in weighted.items():totals[part].update(v)
   bands.append(dict(band=bi+1,profile_key=key,old_residue_inputs=O,guard_residue_inputs=G,joined_residue_inputs=O+G,
    per_output=unit,weighted=weighted,converted_layers=conv,
    one_layer_numerator_payload_bytes=32*r['K']*(FS[bi]+1),
    source_slots_produced_per_anchor=20,source_slots_consumed_per_anchor=r['K']))
  for part in totals:
   totals[part]['template_core']=totals[part]['product_core']+totals[part]['addition_core']
  ck(conversions['old_arrays']==c['modes']['full20']['array_admissions'])
  if name in ('full20_fixed_b94','short_final18'):
   mode='full20' if name=='full20_fixed_b94' else 'constant_prefix'
   ck(conversions['old_coordinate_conversions']==c['modes'][mode]['coordinate_conversions'])
  components={}
  for mode in ('three','four'):
   ts=tp[mode]['scenarios'][si];ck(ts['extra_nodes']==extra)
   components[mode]={}
   for part in ('old','guard','joined'):
    P=totals[part]['product_core']+ts[part]['product_core']
    Acore=totals[part]['addition_core']+ts[part]['addition_core']
    components[mode][part]=dict(residue_product_core=totals[part]['product_core'],residue_addition_core=totals[part]['addition_core'],
      transform_product_core=ts[part]['product_core'],transform_addition_core=ts[part]['addition_core'],
      combined_product_core=P,combined_addition_core=Acore,combined_template_core=P+Acore)
  schedules[name]=dict(bands=bands,totals={k:dict(v) for k,v in totals.items()},shared_conversion_totals=dict(conversions),
   peak_converted_numerator_payload_bytes=max(x['one_layer_numerator_payload_bytes'] for x in bands),
   optional_p108_transform_component=components)
 comparisons=[]
 for target in ('short_final18','short_final19'):
  x=schedules['full20_fixed_b94'];y=schedules[target]
  comparisons.append(dict(old_schedule='full20_fixed_b94',new_schedule=target,
   component_reserves={part:{k:x['totals'][part][k]-y['totals'][part][k] for k in ('product_core','addition_core','complex_stages',
    'signed_product_bridges','signed_add_bridges','nearest_range_implications','alignment_shift_instances','alignment_bit_distance')}
    for part in ('old','guard','joined')},
   coordinate_conversion_count_difference=y['shared_conversion_totals']['joined_coordinate_conversions']-x['shared_conversion_totals']['joined_coordinate_conversions']))
 x=schedules['short_final18'];y=schedules['short_final19']
 finalU=oldR[4]+guardR[4]
 ck(x['totals']['joined']['product_core']-y['totals']['joined']['product_core']==74*finalU)
 ck(y['totals']['joined']['addition_core']-x['totals']['joined']['addition_core']==28*finalU)
 final_compare=dict(final_unit_outputs=finalU,product_core_saved_by19=74*finalU,addition_core_added_by19=28*finalU,
  coordinate_conversions_added_by19=y['shared_conversion_totals']['joined_coordinate_conversions']-x['shared_conversion_totals']['joined_coordinate_conversions'],
  extra_signed_add_bridges=6*finalU,extra_signed_product_bridges=4*finalU,extra_nearest_range_implications=2*finalU,
  extra_export_shift_bits=2*finalU)
 scenarios.append(dict(extra_nodes=extra,old_residue_inputs_by_band=oldR,guard_residue_inputs_by_band=guardR,
  schedules=schedules,baseline_comparisons=comparisons,final18_vs19=final_compare))

result=dict(scope='Three fixed admitted evaluator schedules on saved original/+41 band weights; no production choice.',
 pins=pins,checks=checks,selected_records=selected,selected_count=len(selected),validated_stages=stage_checks,
 extra_equivalence_record='band5_actual_K20_b94',schedule_keys=schedule_keys,
 guard_final_admissions=[r for r in guardad['rows'] if F(r['V'])==F(26525,4)],scenarios=scenarios,
 source_production='All20 finite output centers, source P27/P28 and complete translations remain. No source work deduction.',
 conversion_schedule='Full F+1 anchor layer, one chosen profile per band, direct ORIGINAL-center conversions; retain through all active conductors. Additional admissions use actual multiplicities.',
 setup_p108={m:tp[m]['setup_per_cache_lifetime'] for m in ('three','four')},
 unpriced=['original-encoding conversion witnesses and per-object binding/admission','coefficient/source and result lookup, numeral/reference/representation and cache traffic',
 'signed/range/shift/zero proof instances and exact output embedding','seed/head/finite corrections and source production',
 'kernel/root/setup generation and proof checking; precision-specific lifetimes','completion, negative adapters,83-term queries and actual sign/completeness repairs',
 'principal and small-conductor certificates; finite coverage and ladder; analytic library'],
 production_selected=False,independent_review_pending=True,
 limits=dict(joint_input_bytes=24*1024**2,selected_records=11,max_stage_validations=209,output_bytes=512*1024))
raw=(json.dumps(result,separators=(',',':'))+'\n').encode();ck(len(raw)<512*1024)
dest=HERE/'guarded_residue_evaluation_frontier_20261111.json'
with dest.open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=checks,stages=stage_checks,bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest().upper(),
 per_output={key:[r['product_events'],r['addition_events']] for key,r in selected.items()},
 main={name:dict(P=s['totals']['joined']['product_core'],A=s['totals']['joined']['addition_core'],
 conversions=s['shared_conversion_totals']['joined_coordinate_conversions'],
 with_transform=s['optional_p108_transform_component']['three']['joined']['combined_template_core']) for name,s in scenarios[0]['schedules'].items()}),indent=2))
