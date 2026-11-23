"""Capacity thresholds for the Saturday deadline. No fleet is provisioned."""

import datetime as dt
import json
import math

import model


def main():
    deadline = dt.datetime.fromisoformat("2026-11-21T15:00:00-08:00")
    duty = 0.70
    cal = json.loads(model.SOURCE_FILES[0].read_text())
    settings = json.loads((model.HERE / "results.json").read_text())["scenarios"]["planning"]["assumptions"]
    output = dict(deadline=deadline.isoformat(), utilization=duty, binary_only={},
                  timing_scope="Available window starts after validated checker and data path are ready.")
    for b in [4*10**15, 10**16]:
        best = min((model.workload(2**j, settings, cal, b) for j in model.SPAN_EXPONENTS),
                   key=lambda x:x["total_cpu_hours"])
        hours = best["total_cpu_hours"]
        table = best["cpu_hours"]["source_prime_first_acceptance_once"] + (
            best["source_roots_estimate"] * settings["generation_seconds_per_root"] / 3600
        )
        bounds = {}
        for cores in [2048,4096,8192,10000]:
            wall = hours/(cores*duty)
            bounds[str(cores)] = dict(wall_hours=wall,
                latest_start=(deadline-dt.timedelta(hours=wall)).isoformat(timespec="minutes"))
        output["binary_only"][str(b)] = dict(
            best_span=best["integer_span"], total_core_hours=hours, table_core_hours=table,
            blocks=best["blocks"], assembly_allowance_hours=best["cpu_hours"]["initial_range_seams_io_and_assembly"],
            planning_cpu_seconds_per_block_after_table=(hours-table)*3600/best["blocks"],
            allowed_seconds_per_block_10h_10000cores=(10000*10*duty-table)*3600/best["blocks"],
            min_cores={str(h):math.ceil(hours/(h*duty)) for h in [10,18,24,29]},
            max_all_in_price_per_allocated_core_hour_for_10000_USD=(10000*duty/hours),
            conditional_fleet_start_times=bounds)
    (model.HERE/"deadline.json").write_text(json.dumps(output,indent=2)+"\n",encoding="utf-8")
    for b, r in output["binary_only"].items():
        print(b, round(r["total_core_hours"]), round(r["table_core_hours"]), r["min_cores"],
              r["conditional_fleet_start_times"]["4096"],r["conditional_fleet_start_times"]["8192"],
              r["max_all_in_price_per_allocated_core_hour_for_10000_USD"])


if __name__ == "__main__":
    main()
