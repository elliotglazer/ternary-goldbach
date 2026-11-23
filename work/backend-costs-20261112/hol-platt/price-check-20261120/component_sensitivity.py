"""Add disjoint measured or modeled components, and report the unpriced remainder."""
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
def read(path): return json.loads(path.read_bytes())
axis=read(HOL/"large-axis-sample/estimate.json")
assert axis["covered_positions"]==axis["total_positions"]
prior=read(HERE/"remaining_budget.json")
grouped=read(HOL/"small-time-diagonal/fold.json")
source=next(r for r in read(HOL/"large-weighted-slab/schedule.json")["schedules"]
            if r["conductors_per_group"]==32 and r["heights_per_block"]==8)
parity=read(HOL/"small-character-parity/fold.json")["totals"]
legacy=read(HOL.parent/"forecast-audit-20261113/end_to_end_model.json")
old=legacy["backends"]["HOL4"]["planning"]["categories_core_years"]
per={r["name"]:old[r["name"]]*8766/r["count"] for r in legacy["semantic_rows"] if r["count"] and r["name"] in old}
parity_price=(parity["folded_b"]*per["small_character_butterfly"]+
              (parity["folded_points"]+parity["pre_twist_complex_products"])*per["small_character_point_product"]+
              parity["pair_adds"]*per["small_bucket_add"])
parts=dict(large_axis_arithmetic=[axis["weighted_estimate_hours_covered_strata"]]*2,
    small_time_tile_products=[prior["small_time_products_hol_paired_cpu_hours"]]*2,
    small_time_grouped_split_sensitivity=grouped["same_synthetic_split_hours"]["grouped_splits"],
    band1_large_source_kernel_sensitivity=[r["productive_kernel_hours"]+r["fixed_kernel_hours"]
                                        for r in source["band1_kernel_sensitivities"]],
    small_character_arithmetic_at_old_operation_prices=[parity_price]*2)
partial=[sum(v[i] for v in parts.values()) for i in (0,1)]
result=dict(parts=parts,partial_sensitivity_hours=partial,
            ratio_to_historical_400000=[v/400000 for v in partial],
            room_to_800000_hours_before_other_work=[800000-v for v in partial],
            large_axis_between_draw_SE_hours=axis["between_draw_SE_hours_covered_strata"],
            scope="Partial scenario. The two columns vary just the grouped split and band-1 source rates. Unpriced are short axes in the large family, later source bands, Gaussian and raw heads, sign/count/repair, proof representation, and other setup. Independent subset uncertainties do not define a campaign confidence interval.")
(HERE/"component-sensitivity.json").write_text(json.dumps(result,indent=2)+"\n")
print(json.dumps(result,indent=2))
