import json,gzip,csv
from collections import Counter
from pathlib import Path
h=Path(__file__).resolve().parent
counts=json.loads((h/'counts.json').read_text())
panel=json.loads((h/'native-panel.json').read_text())
model=json.loads((h.parent.parent/'forecast-audit-20261113/end_to_end_model.json').read_text())
old=model['assumptions']
r=old['core_rate_seconds_per_butterfly']['HOL4']*old['geometry_factor'][1]*old['accepted_refinement_factor'][1]
weights={z['name']:z['butterfly_factors'][1] for z in model['semantic_rows']}
ops=[counts['ops']['packed'][str(i)] for i in range(5)]
opcounts=dict(large_root_product=ops[0]-ops[4],large_kernel_product=ops[4],large_complex_add=ops[1],large_quarter_turn=ops[2],large_negation=ops[3])
hours={k:v*weights[k]*r/3600 for k,v in opcounts.items()}
ks=set()
totals={str(e):Counter() for e in (0,167,320,640)}
with gzip.open(h/'axis-histogram.csv.gz','rt') as f:
    for raw in csv.DictReader(f):
        v={k:int(x) for k,x in raw.items()}
        n=v['n'];p=v['p'];w=v['lane_bytes']
        if n>=32:
            ks.add((n,p,w))
        for e,tot in totals.items():
            rows=v['base_plus_41_slices']+int(e)*v['slices_per_extra_node']
            if n<32:
                tot['short_slices']+=rows
                continue
            b=panel[str((n-1).bit_length())]
            tot['packed_slices']+=rows
            tot['full_length_outputs']+=rows*n
            tot['retained_outputs']+=rows*v['retained_outputs_per_slice']
            tot['packed_products']+=rows*3
            tot['edge_panel_native_wall_hours']+=rows*b['median_wall']/3600
            tot['linear_in_bin_sensitivity_hours']+=rows*b['median_wall']*(n/b['n'])/3600
res=dict(baseline_previous_model_replaced_operation_counts=opcounts,previous_model_replaced_hours=hours,previous_model_total_replaced_hours=sum(hours.values()),scenarios=totals,
         mathematical_cached_kernel_pair_payload_bytes=sum(2*n*w for n,p,w in ks),
         max_packed_one_operand_bytes=counts['maxima']['packed_bytes'][0],
         resident_HOL_hours_per_native_multiple=totals['0']['edge_panel_native_wall_hours'])
(h/'price.json').write_text(json.dumps(res,indent=2))
print(json.dumps(res,indent=2))
