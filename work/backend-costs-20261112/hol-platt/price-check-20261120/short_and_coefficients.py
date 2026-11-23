"""Combine the measured short-axis and table-production rows with the existing partial scenario."""
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
short=HOL/"short-axis/costs.json"
coeff=HOL/"coefficient-panels/costs.json"
prior=HOL/"wide-band-slab/coefficient-costs.json"
read=lambda p:json.loads(p.read_bytes())
inputs=[prior,short,coeff]
s,c=read(short),read(coeff)
base=read(prior)["tiles"]["4x4"]["partial_hours"]["24"]
assert base==s["prior_partial"] and s["original_precision_packets"]==0
extra=s["short_transform_hours"]+c["priced_table_hours"]
totals=[v+extra for v in base]
remaining=[800000-v for v in totals]
result=dict(comparison_core_hours=400000,comparison_twice_core_hours=800000,
    prior=base,short_transform_marginal=s["short_transform_hours"],
    native_coefficient_producer=c["native_generation_hours"],hol_coefficient_blocks=c["standalone_hol_hours"],
    priced_subtotal=totals,ratio_to_historical=[v/400000 for v in totals],
    remaining_to_twice_historical=remaining,
    exclusive_budget_seconds_per_seed_group=[u*3600/c["seed_groups"] for u in remaining],
    exclusive_budget_seconds_per_seed_coefficient=[u*3600/c["certifiable_complex_seeds_required"] for u in remaining],
    subtotal_if_full_short_comparison_loop_charged=[v+c["priced_table_hours"]+s["including_comparison_loop_hours"] for v in base],
    input_sha256={str(p.relative_to(HOL)):hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs})
(HERE/"short-and-coefficients.json").write_text(json.dumps(result,indent=2)+"\n")
print(result)
