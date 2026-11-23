"""Price a 24-bit first pass with original precision in unsampled tail strata.

The retry fraction below is weighted by original Fourier CPU cost. A fraction
of unresolved individual signs cannot be substituted for it.
"""
import json
import argparse
from pathlib import Path

HERE = Path(__file__).resolve().parent
DATA = HERE.parent / "large-axis-sample"


def read(path):
    return json.loads(path.read_bytes())


def calculate(bits=24):
    original = read(DATA / "estimate.json")
    coarse = read(DATA / f"estimate-p{bits}.json")
    plan = read(DATA / "sample.json")
    assert original["plan_sha256"] == coarse["plan_sha256"]
    assert original["covered_positions"] == original["total_positions"]
    base = original["completed_sampling_strata"]
    low = coarse["completed_sampling_strata"]
    assert set(low) <= set(base) == set(plan["strata"])
    assert sum(plan["strata"][s]["positions"] for s in low) == coarse["covered_positions"]
    unsampled = sorted(set(base) - set(low), key=int)
    full_covered = sum(base[s]["hours"] for s in low)
    tail = sum(base[s]["hours"] for s in unsampled)
    cheap = sum(row["hours"] for row in low.values())
    assert abs(tail + full_covered - original["weighted_estimate_hours_covered_strata"]) < 1e-6
    five = read(HERE / "component-sensitivity.json")
    others = [total - axis for total, axis in
              zip(five["partial_sensitivity_hours"], five["parts"]["large_axis_arithmetic"], strict=True)]
    first = [other + cheap + tail for other in others]

    return {
        "strata_using_original_precision_immediately": unsampled,
        "original_hours_in_those_strata": tail,
        "coarse_first_pass_hours_in_measured_strata": cheap,
        "original_hours_in_measured_strata": full_covered,
        "retry_fraction_break_even_against_original_transform": 1 - cheap / full_covered,
        "five_component_hours_by_original_cost_weighted_retry_fraction": {
            str(r): [h + r * full_covered for h in first] for r in (0, .01, .1, .25, .5, 1)
        },
        "room_to_800000_at_zero_retries_before_unpriced_work": [800000 - h for h in first],
        "scope": "Size-weighted benchmark extrapolation for five components. Unpriced stages and generation of precision-specific inputs are excluded. A full-price retry redoes the affected covered work. Retrying individual Fourier modes directly is a different schedule."
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('bits', type=int, choices=(24, 28), default=24, nargs='?')
    bits = parser.parse_args().bits
    result = calculate(bits)
    name = "precision-fallback.json" if bits == 24 else f"precision-fallback-p{bits}.json"
    (HERE / name).write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))
