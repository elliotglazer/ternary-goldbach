"""Conditional band-1 throughput targets after charging two native reference rows."""

import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
HOL = HERE.parent


def main():
    files = [HOL/"large-kronecker-price/price.json", HOL/"c10000-kronecker-time-price/tiles.json",
             HOL/"c10004-effective-degree/counts.json",HOL/"c10004-lane-horner/throughput.json"]
    files.append(HOL/"c10000-kronecker-time-hol/projection.json")
    large,tiles,degrees,slabs,formal = [json.loads(p.read_bytes()) for p in files]
    hours = large["scenarios"]["0"]
    tile = next(row for row in tiles if row["T"]==65536)
    samples = next(x["residues"] for x in degrees["scenarios"] if x["guards"]==41 and x["extra"]==0)
    small = tile["hour_model"]["cpu_median"]
    if formal["hashes"]["tiles.json"] != hashlib.sha256(files[1].read_bytes()).hexdigest():
        raise ValueError("HOL projection used a different tile count")
    small_hol = formal["totals"]["ratio_scaled_hours"]
    if samples != 44739119112240:
        raise ValueError("band-1 scope changed")
    results = []
    for small_name,small_hours in (("native",small),("HOL paired rate",small_hol)):
        for name,large_hours in (("linear within native bins",hours["linear_in_bin_sensitivity_hours"]),
                                 ("native bin endpoints",hours["edge_panel_native_wall_hours"])):
            for target in (400000,800000):
                remainder = target-small_hours-large_hours
                rate = remainder*3.6e9/samples
                results.append({"small_product_price":small_name, "large_price_convention":name,"target":target,
                    "hypothetical_hours_left_for_band1_and_all_other_work":remainder,
                    "microseconds_per_band1_complex_if_it_gets_whole_remainder":rate,
                    "measured_delayed_kernel_to_allowance_by_height":{
                        row["heights"]:row["kernel_us_per_complex"]/rate
                        for row in slabs if row["mode"]=="delayed"}})
    return {"large_axis_native_single_worker_wall_hours":[hours["linear_in_bin_sensitivity_hours"],
                 hours["edge_panel_native_wall_hours"]],"small_time_products_native_cpu_hours":small,
            "small_time_products_hol_paired_cpu_hours":small_hol,"band1_samples":samples,"scenarios":results,
            "comparison":"Each scenario treats native single-worker large-axis wall time as attainable HOL CPU time. "
            "The small product row uses either native or benchmark-scaled stock HOL rates. Other costs remain open.",
            "sha256":{str(p.relative_to(HOL)):hashlib.sha256(p.read_bytes()).hexdigest() for p in files}}


if __name__=="__main__":
    print(json.dumps(main(),indent=2))
