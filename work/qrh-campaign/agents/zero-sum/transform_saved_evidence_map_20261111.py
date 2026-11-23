"""Read frozen JSON and source bytes only; no inventory/evaluator imports."""
from pathlib import Path
import json,hashlib
HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
paths={
 'full':'zero-sum/mixed_radix_character_inventory_20261111.json',
 'pruned':'zero-sum/conditional_r132900_pruning_inventory_20261111.json',
 'precision':'zero-sum/mixed_radix_precision_metadata_20261111.json',
 'width':'independent-feasibility/mixed_radix_width_metadata_20261111.json',
 'combined':'major-constants/combined_odd_even_height_inventory_20261111.json',
 'reconciled':'major-constants/reconciled_nonprincipal_schedule_20261111.json',
 'full_source':'zero-sum/mixed_radix_character_inventory_20261111.py',
 'pruned_source':'zero-sum/primitive_output_pruning_inventory_20261111.py',
 'r132900_source':'zero-sum/conditional_r132900_pruning_inventory_20261111.py',
 'combined_source':'major-constants/combined_odd_even_height_inventory_20261111.py',
 'precision_source':'zero-sum/mixed_radix_precision_metadata_20261111.py',
 'width_source':'independent-feasibility/mixed_radix_width_metadata_20261111.py',
 'full_note':'zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md',
 'pruned_note':'zero-sum/PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md',
 'full_review':'independent-feasibility/REVIEW_MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md',
 'precision_review':'audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md',
 'width_review':'major-constants/REVIEW_MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md',
 'reconciled_review':'zero-sum/REVIEW_RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md',
}
pins={key:dict(path=rel,sha256=hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper()) for key,rel in paths.items()}
d={key:json.loads((AGENTS/rel).read_text()) for key,rel in paths.items() if rel.endswith('.json')}
checks=0
def check(x):
 global checks
 assert x
 checks+=1
check(d['full']['canonical_plan_sha256']==d['precision']['plan_sha256']==d['width']['plan_sha256'])
pr={r['n']:r for r in d['precision']['axis_rows']}
wr={r['n']:r for r in d['width']['axis_rows']}
check(set(pr)==set(wr))
check(len(pr)==13943)

# This subtraction is licensed by the frozen circuit's D=kernel-product invariant.
def split(ops):
 g=ops['general_complex_products']; k=ops['dyadic_scales']
 check(0<=k<=g)
 return dict(all_general_products=g,cached_kernel_products=k,unit_root_products=g-k,
             complex_add_sub=ops['complex_add_sub'],quarter_turns=ops['quarter_turns'],
             negations=ops['negations'],inverse_dyadic_scales=k)
current=[]
for row in d['reconciled']['scenarios']:
 a=row['extra_nodes']; large=row['large']
 other=next(x for x in d['combined']['scenarios'] if x['extra_nodes']==a)
 check(large['transform_operations']==other['operations'])
 current.append(dict(extra_nodes=a,operations=split(large['transform_operations']),
                     residue_inputs=large['residue_inputs'],primitive_outputs=large['primitive_outputs']))
extra=split(d['combined']['per_extra_node_operations'])
for row in current:
 for k in ('all_general_products','cached_kernel_products','unit_root_products'):
  check(row['operations'][k]==current[0]['operations'][k]+row['extra_nodes']*extra[k])

result=dict(scope='Frozen JSON/source inspection and aggregate subtraction only; no conductor/axis schedule regeneration',
 checks=checks,pins=pins,plan_sha256=d['full']['canonical_plan_sha256'],
 current_scenarios=current,per_extra_node=extra,
 precision_width_join=dict(key='axis_rows[].n',matched_rows=len(pr),
   precision_fields=list(d['precision']['axis_rows'][0]),width_fields=list(d['width']['axis_rows'][0]),
   occurrence_weights_saved=False,actual_bit_precision_saved=False),
 manifest_status=dict(full_plan_saved=False,full_plan_hash_saved=True,
   full_plan_node_count=d['full']['active_plan_count'],
   pruned_requests_saved=False,pruned_request_count=d['pruned']['all_recursive_request_count'],
   pruned_top_restrictions_saved=False,pruned_top_restriction_count=d['pruned']['top_axis_restriction_count'],
   current_conductor_height_table_saved=False,current_examples=len(d['combined']['examples'])),
 setup=d['reconciled']['setup']['large_transform_unchanged'],
 missing_correlations=['conductor and scenario height multiplicity by node request',
 'actual CT tree and primitive restriction per invocation',
 'outer original-order prefix magnitude by axis occurrence',
 'Bluestein padded length and FFT stage by kernel/root gate count',
 'input bound B, fractional precision and coefficient radius by occurrence',
 'distinct cache entries by precision and checked lifetime'])
HERE.joinpath('transform_saved_evidence_map_20261111.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps({k:result[k] for k in ('checks','current_scenarios','per_extra_node','manifest_status','setup')},indent=2))
