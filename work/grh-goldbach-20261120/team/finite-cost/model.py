"""Forecast production and first Lean acceptance of binary Goldbach through 10^16.

Run with Python 3. The source files are read-only. The only output is results.json
beside this script. Quantities marked "assumption" require a production pilot.
"""

import hashlib
import json
import math
from pathlib import Path


HERE = Path(__file__).resolve().parent
WORK = HERE.parents[2]
BENCH = WORK / "formal-goldbach-bench"
SOURCE_FILES = [
    BENCH / "forecast_inputs.json",
    BENCH / "lean/PackedBench.strict.json",
    BENCH / "prime-cert/results.json",
    BENCH / "prime-cover/packed_large_timings.json",
    WORK / "backend-costs-20261112/finite-lean/BATCH_REPORT.md",
]
BOUND = 10**16
TARGETS = BOUND // 2 - 1  # evens 4 .. B, both endpoints included
RESERVED_ANCHORS = 512
HALO = 65536  # an assumed allowance in integers for anchors below each block
SPAN_EXPONENTS = range(26, 38)  # block length in integers, not even targets
FLEETS = [2048, 4096, 8192, 16384]
DEADLINES = [6, 12, 24]  # hours once checker and inputs are ready
UTILIZATION = 0.70
SECONDS_PER_HOUR = 3600


def ceil_div(numerator, denominator):
    return (numerator + denominator - 1) // denominator


def source_count(span):
    upper = span + HALO
    # Prime-number-theorem budgeting proxy only. All actual positive bits
    # need primality proofs. The reserve is 1% over x / (log x - 1).
    return math.ceil(1.01 * upper / (math.log(upper) - 1.0))


def workload(span, assumptions, calibration, bound=BOUND):
    targets = bound // 2 - 1
    blocks = ceil_div(targets, span // 2)
    tiles = ceil_div(targets, calibration["lean"]["width"])
    root_seconds = calibration["lean"]["prime_seconds_per_root"]
    coverage_seconds = calibration["lean"]["kernel_seconds_per_chunk"]
    native_seconds = calibration["native_shift_or"]["seconds_per_chunk"]
    source = source_count(span)
    anchors = blocks * RESERVED_ANCHORS
    # The packed kernel check is the Lean arithmetic benchmark. Native shift/OR
    # models untrusted prefix/coverage search on the same size tile. They have
    # different roles. Never sum a separate per-word greedy-mask search here.
    cpu_hours = {
        "lean_tile_first_acceptance": tiles * coverage_seconds * assumptions["tile_factor"] / SECONDS_PER_HOUR,
        "native_tile_search": tiles * native_seconds * assumptions["search_factor"] / SECONDS_PER_HOUR,
        "source_prime_first_acceptance_once": source * root_seconds * assumptions["prime_factor"] / SECONDS_PER_HOUR,
        "anchor_prime_first_acceptance": anchors * root_seconds * assumptions["prime_factor"] / SECONDS_PER_HOUR,
        "source_and_anchor_certificate_generation": (source + anchors) * assumptions["generation_seconds_per_root"] / SECONDS_PER_HOUR,
    }
    cpu_hours["initial_range_seams_io_and_assembly"] = sum(cpu_hours.values()) * assumptions["overhead_fraction"]
    total_hours = sum(cpu_hours.values())
    return {
        "integer_span": span, "even_targets": targets, "blocks": blocks, "tiles": tiles,
        "source_roots_estimate": source, "anchor_roots_reserved": anchors,
        "raw_source_bytes": ceil_div(span + HALO, 16),  # odd-only bit table
        "cpu_hours": cpu_hours, "total_cpu_hours": total_hours,
    }


def main():
    calibration = json.loads(SOURCE_FILES[0].read_text(encoding="utf-8-sig"))
    # Prices are explicit multiples of the warmed measured arithmetic/root
    # kernels, to allow semantic assembly, marshaling, production and imports.
    # The separate percentage covers bootstrap, exceptions and final reduction.
    scenario_settings = {
        "favorable": dict(tile_factor=1.5, search_factor=1.5, prime_factor=1, generation_seconds_per_root=.002, overhead_fraction=.10),
        "planning": dict(tile_factor=2, search_factor=3, prime_factor=2, generation_seconds_per_root=.02, overhead_fraction=.25),
        "stress": dict(tile_factor=8, search_factor=10, prime_factor=8, generation_seconds_per_root=.2, overhead_fraction=1),
    }
    results = {}
    for name, settings in scenario_settings.items():
        rows = [workload(2**j, settings, calibration) for j in SPAN_EXPONENTS]
        best = min(rows, key=lambda row: row["total_cpu_hours"])
        results[name] = {"assumptions": settings, "best_in_grid": best}
        if name == "planning":
            results[name]["span_grid"] = [
                {key: row[key] for key in ("integer_span", "raw_source_bytes", "source_roots_estimate",
                                           "anchor_roots_reserved", "total_cpu_hours")}
                for row in rows
            ]
    planning = results["planning"]["best_in_grid"]
    rows = planning["cpu_hours"]
    # Charge shared prime table once and list its critical path separately.
    shared_cpu_hours = rows["source_prime_first_acceptance_once"] + (
        planning["source_roots_estimate"] * scenario_settings["planning"]["generation_seconds_per_root"] / SECONDS_PER_HOUR
    )
    hours = planning["total_cpu_hours"]
    fleet = [
        {"physical_cores": n, "ideal_wall_hours": hours / n,
         "wall_hours_at_70_percent": hours / (n * UTILIZATION)}
        for n in FLEETS
    ]
    thresholds = []
    for duration in DEADLINES:
        for cores in FLEETS:
            capacity = cores * UTILIZATION * duration
            # A measured recurring block must include the block's own generation,
            # root proofs, tiles, imports, seams, export and retry allowance.
            # Deduct the one-time table; its parallel production and the final
            # merge must also meet the wall deadline independently.
            remaining = capacity - shared_cpu_hours
            thresholds.append({
                "hours_available": duration, "physical_cores": cores,
                "max_recurring_cpu_seconds_per_block": max(0, remaining * SECONDS_PER_HOUR / planning["blocks"]),
                "passes_planning_cpu_total": capacity >= hours,
            })
    report = {
        "target": "BinaryGoldbachUpTo (10^16), Lean 4.35.0",
        "scope": "Certificate generation and first kernel acceptance after checker development and cached Mathlib",
        "baseline_hardware": "AMD Ryzen 9 8945HS physical core equivalent, Windows Lean 4.35.0",
        "calibration": {key: calibration[key] for key in ["lean", "native_shift_or"]},
        "calibration_files": {str(p.relative_to(WORK)): hashlib.sha256(p.read_bytes()).hexdigest() for p in SOURCE_FILES},
        "tile_width_even_targets": calibration["lean"]["width"],
        "anchors_per_block_assumption": RESERVED_ANCHORS, "source_halo_integers_assumption": HALO,
        "scenarios": results, "shared_cpu_hours_planning": shared_cpu_hours,
        "planning_recurring_cpu_seconds_per_block": (hours - shared_cpu_hours) * SECONDS_PER_HOUR / planning["blocks"],
        "planning_fleet": fleet, "fleet_utilization_assumption": UTILIZATION,
        "cpu_thresholds": thresholds,
        "scenario_core_counts_at_70_percent": {
            name: {str(duration): math.ceil(s["best_in_grid"]["total_cpu_hours"] / (duration * UTILIZATION))
                   for duration in DEADLINES}
            for name, s in results.items()
        },
    }
    (HERE / "results.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    for name, s in results.items():
        print(name, s["best_in_grid"]["integer_span"], round(s["best_in_grid"]["total_cpu_hours"]))
    print(json.dumps({key: report[key] for key in ("shared_cpu_hours_planning", "planning_recurring_cpu_seconds_per_block",
                                                   "planning_fleet", "scenario_core_counts_at_70_percent")}, indent=2))


if __name__ == "__main__":
    main()
