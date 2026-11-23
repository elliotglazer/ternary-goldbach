"""Compare observed source costs with time the full historical budget allows."""

import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
pins = {}


def read(path):
    raw = path.read_bytes()
    pins[str(path.relative_to(HOL.parent))] = hashlib.sha256(raw).hexdigest()
    return json.loads(raw)


def main():
    forecast = read(HOL.parent / "forecast-audit-20261113/end_to_end_model.json")
    direct = read(HOL / "c10004-reference/receipt.json")
    batch = read(HOL / "c10004-batched-source/receipt.json")
    high_direct = read(HOL / "c10004-high-reference/receipt.json")
    high_batch = read(HOL / "c10004-batched-high/adaptive.json")
    hol_outputs = read(HOL / "c10004-hol-replay/a02_compare.json")
    character = read(HOL / "small-price-20261120/fold.json")["total"]
    time_fft = read(HOL / "time-pruning/counts.json")
    rows = {row["name"]: row for row in forecast["semantic_rows"]}
    residues = rows["raw_head_product_assembly"]["count"]
    if residues != 60254515577760 or time_fft["conductors"] != 7499:
        raise ValueError("unexpected workload extent")
    h_nodes = [1, 2]
    if [n["h"] for n in batch["heights"]] != h_nodes:
        raise ValueError("unmatched batched heights")
    items = sum(n["matching_rows"] for n in batch["heights"])
    if items != 9600:
        raise ValueError("unmatched source volume")
    for a, b in zip(high_direct["nodes"], high_batch["nodes"], strict=True):
        if a["j"] != b["j"] or a["source_sha256"] != b["reference_sha256"]:
            raise ValueError("high source references disagree")
    if sum(n["rows"] for n in high_batch["nodes"]) != items:
        raise ValueError("unmatched high source volume")
    if any(hol_outputs[str(h)]["outputs"] != 2301 for h in h_nodes):
        raise ValueError("incomplete transform")
    runlog = HOL / "c10004-hol-replay/a02_replay.log"
    logfile = runlog.read_bytes()
    pins[str(runlog.relative_to(HOL.parent))] = hashlib.sha256(logfile).hexdigest()
    stages = [line.split(",") for line in logfile.decode().splitlines()
              if line.startswith("ACTUAL_CPU,")]
    if [int(s[1]) for s in stages] != h_nodes or not all(len(s) == 6 for s in stages):
        raise ValueError("missing HOL CPU phases")
    direct_seconds = sum(n["cpu_seconds"] for n in direct["nodes"] if n["h"] in h_nodes)
    batch_seconds = batch["initialization"]["cpu_seconds"] + sum(
        node[k]["cpu_seconds"] for node in batch["heights"]
        for k in ("coefficient_setup", "residue_evaluation"))
    assumptions = forecast["assumptions"]
    rate = assumptions["core_rate_seconds_per_butterfly"]["HOL4"]
    rate *= assumptions["geometry_factor"][1] * assumptions["accepted_refinement_factor"][1]

    def historical_model_hours(name, count):
        return count * rows[name]["butterfly_factors"][1] * rate / 3600

    before = historical_model_hours("small_character_butterfly", character["dense_b"])
    before += historical_model_hours("small_character_point_product", character["dense_points"])
    after = historical_model_hours("small_character_butterfly", character["original_projected_b"])
    after += historical_model_hours("small_character_point_product", character["original_projected_points"])
    high_seconds = sum(n["source_cpu"] for n in high_direct["nodes"])
    high_batched = high_batch["inclusive"]["cpu"]
    data = {
        "two_low_nodes_cpu_microseconds_per_residue": {
            "direct": direct_seconds/items*1e6, "batch": batch_seconds/items*1e6},
        "two_high_nodes_cpu_microseconds_per_residue": {
            "direct": high_seconds/items*1e6, "batch": high_batched/items*1e6},
        "high_low_direct_cpu_ratio": high_seconds/direct_seconds,
        "high_direct_batched_cpu_ratio": high_seconds/high_batched,
        "two_low_nodes_hol_transform_cpu_seconds": [
            {"height_index": int(s[1]), "encode": float(s[2]), "execute": float(s[3]),
             "decode": float(s[4]), "discharge": float(s[5])} for s in stages],
        "aggregate_ceiling_microseconds_per_residue_if_budget_all_for_source": {
            h: h*3600/residues*1e6 for h in (160000, 400000, 800000)},
        "hours_if_all_residues_cost_exactly_like_two_low_nodes": {
            "direct": direct_seconds/items*residues/3600,
            "batch": batch_seconds/items*residues/3600},
        "small_character_two_rows_at_frozen_planning_unit_prices_hours": {
            "dense": before, "primitive_slice_projection": after, "difference": before-after},
        "scope": "The source scenarios are sensitivity calculations, not an all-height rate. "
                 "Character-row prices are assumed; no formal hour saving is measured.",
        "sha256": pins,
    }
    print(json.dumps(data, indent=2))


if __name__ == "__main__":
    main()
