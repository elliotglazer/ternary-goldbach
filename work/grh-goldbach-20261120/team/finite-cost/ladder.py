"""Optimize the conditional Saouter-type ladder and binary coverage to 10^27."""

import json
import math

import model


HERE = model.HERE
H = 10**27  # even. Highest odd finite case is H - 1.
MILLISECONDS = [0.1, 1, 10]
FIXED_BOUNDS = [251 * 10**13, 10**16, 11 * 10**15]
STRIDE = 2 * 2**30
WINDOW = 2047
calibration = json.loads(model.SOURCE_FILES[0].read_text(encoding="utf-8-sig"))
planning = json.loads((HERE / "results.json").read_text())["scenarios"]["planning"]["assumptions"]


def row(b, span, ms, geometry):
    binary = model.workload(span, planning, calibration, b)
    required_hops = max(0, model.ceil_div(H - 1 - (b + 3), b - 2))
    if geometry == "saouter":
        # p_i(t)=(2*(S*i-t)+1)*F+1. Maximum gap between adjacent successful
        # windows is 2F*(S+2047). Provision the full terminal grid index.
        pitch = STRIDE * ((b - 2) // STRIDE - WINDOW)
        rungs = model.ceil_div(H, pitch)
    else:
        # Historic generic assumption: average successful gap is 5/6 of maximum.
        rungs = model.ceil_div(6 * required_hops, 5)
    ladder_hours = rungs * ms / 3600000
    return dict(bound=b, integer_span=span, binary_hours=binary["total_cpu_hours"],
                minimum_new_rungs=required_hops, modeled_new_rungs=rungs,
                ladder_hours=ladder_hours, combined_hours=ladder_hours + binary["total_cpu_hours"])


def approximate_optimum(span, ms, geometry):
    # For x = B-2, replacing integer ceilings by their real arguments gives
    # a lower bound a*x + fixed + d/x - u. Its minimum is attained at sqrt(d/a).
    multiplier = 1 + planning["overhead_fraction"]
    width = calibration["lean"]["width"]
    tile_price = (calibration["lean"]["kernel_seconds_per_chunk"] * planning["tile_factor"] +
                  calibration["native_shift_or"]["seconds_per_chunk"] * planning["search_factor"])
    root_price = (calibration["lean"]["prime_seconds_per_root"] * planning["prime_factor"] +
                  planning["generation_seconds_per_root"])
    a = multiplier * (tile_price / (2 * width) + model.RESERVED_ANCHORS * root_price / span) / 3600
    fixed = multiplier * model.source_count(span) * root_price / 3600
    if geometry == "saouter":
        d = ms * H / 3600000
        shift = STRIDE * WINDOW
        lower_constant = fixed + a * shift
        x = math.sqrt(d / a) + shift
    else:
        u = 1.2 * ms / 3600000
        d = u * (H - 6)
        lower_constant = fixed - u
        x = math.sqrt(d / a)
    # Check nearby tile boundaries and potential jumps in the anchor block count.
    candidates = set()
    for quantum in [2, 2 * width, span, STRIDE]:
        base = int(x) // quantum * quantum
        for k in [-1, 0, 1, 2]:
            for offset in [-2, 0, 2]:
                candidates.add(base + k * quantum + offset + 2)
    candidate = min((row(b, span, ms, geometry) for b in candidates), key=lambda r: r["combined_hours"])
    relaxed_minimum = 2 * math.sqrt(a*d) + lower_constant
    return candidate, relaxed_minimum


def comparison(geometry):
    spans = [2**n for n in model.SPAN_EXPONENTS]
    output = dict(upper_bound=H, geometry=geometry,
                  first_prime=3, permitted_max_gap="B-2",
                  scope="Binary production/first acceptance and new ladder rungs after checker readiness.",
                  assumption="Millisecond price includes each rung's search, proof, gap checking, storage and assembly.",
                  fixed_cutoffs={}, optimized=[])
    for b in FIXED_BOUNDS:
        output["fixed_cutoffs"][str(b)] = [
            dict(rung_ms=ms, **min((row(b,span,ms,geometry) for span in spans), key=lambda r:r["combined_hours"]))
            for ms in MILLISECONDS]
    for ms in MILLISECONDS:
        pairs = [approximate_optimum(span, ms, geometry) for span in spans]
        best = min((r for r, _ in pairs), key=lambda r:r["combined_hours"])
        lower = min(cost for _, cost in pairs)
        gap = best["combined_hours"] - lower
        assert -1e-8 <= gap < 0.1
        output["optimized"].append(dict(rung_ms=ms, **best, model_lower_bound_hours=lower,
                                        optimality_gap_hours=gap))
    return output


def main():
    outputs = {geometry:comparison(geometry) for geometry in ["saouter", "historic_1p2"]}
    (HERE / "ladder.json").write_text(json.dumps(outputs, indent=2) + "\n", encoding="utf-8")
    output = outputs["saouter"]
    for r in output["optimized"]:
        print(r["rung_ms"], f'{r["bound"]:.4e}', r["integer_span"],
              round(r["binary_hours"]), round(r["ladder_hours"]), round(r["combined_hours"]))
    for b, rows in output["fixed_cutoffs"].items():
        print(b, round(rows[0]["binary_hours"]), [round(r["combined_hours"]) for r in rows])


if __name__ == "__main__":
    main()
