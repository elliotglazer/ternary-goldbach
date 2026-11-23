"""Prepare one untrusted exact-integer 8-by-129 raw-head proposal.

Run only on the coordinator's request. This is not a formal correctness check.
No Lean files, proofs, analytic values, or performance projections are produced.
"""

from pathlib import Path
import hashlib
import json
from math import isqrt
import sys
import time


HERE = Path(__file__).resolve().parent
SOURCE = HERE / "fixture.json"
OUTPUT = HERE / "state_fixture.json"
SOURCE_SHA256 = "6B3BFB1F685C50BC4588C499FBAAA27B68763FC18604ED3E74ACFED9B44BE93B"
BASES = (1, 2, 3, 41, 61, 10004, 262144, 265800)
STEPS = 128
INPUT_CAP = 1 << 20
OUTPUT_CAP = 2 << 20


def require(condition, message):
    if not condition:
        raise ValueError(message)


def sha256(data):
    return hashlib.sha256(data).hexdigest().upper()


def round_div(d, r):
    """Mathematical floor division; nearest ties go toward positive infinity."""
    require(type(d) is int and d > 0 and type(r) is int, "invalid round_div operands")
    return (2 * r + d) // (2 * d)


def log_center(a, b):
    """RawHead.logCenter (2^137) a b 45, including its final rounding."""
    h = 0
    for k in range(44, -1, -1):
        odd = 2 * k + 1
        h = round_div(odd * b * b, (1 << 137) * b * b + odd * a * a * h)
    return round_div(b, 2 * a * h)


def step_from_log(q):
    """RawHead.stepInnerFromLog and stepFromLog, with simultaneous updates."""
    scale = 1 << 131
    p = -5 * q
    d = 1 << 135
    u, v = scale, 0
    for k in range(71, -1, -1):
        denominator = d * (k + 1)
        next_u = round_div(denominator, scale * denominator - p * v)
        next_v = round_div(denominator, p * u)
        u, v = next_u, next_v
    return (u, v), (round_div(512, u), round_div(512, v))


def mul_step(state, step):
    """RawHead.mulStep (2^122), with the four-real-product expression."""
    a, b = state
    c, d = step
    return (round_div(1 << 122, a * c - b * d),
            round_div(1 << 122, a * d + b * c))


def main():
    require(len(sys.argv) == 1, "this fixed experiment accepts no arguments")
    require(not OUTPUT.exists(), f"refusing to overwrite {OUTPUT}")
    wall_start = time.perf_counter_ns()
    cpu_start = time.process_time_ns()
    generator_bytes = Path(__file__).read_bytes()
    generator_hash = sha256(generator_bytes)
    with SOURCE.open("rb") as source_file:
        source_bytes = source_file.read(INPUT_CAP + 1)
    require(len(source_bytes) <= INPUT_CAP, "source fixture exceeds 1 MiB cap")
    require(sha256(source_bytes) == SOURCE_SHA256, "source fixture hash mismatch")
    # Old timing decimals are not used. All proposal arithmetic below uses integers.
    source = json.loads(source_bytes, parse_float=str)
    source_rows = source["rows"]
    require(type(source_rows) is list and len(source_rows) == 8, "source row count mismatch")
    require(tuple(row["x"] for row in source_rows) == BASES, "source base order mismatch")
    log_two = log_center(1, 3)
    require(type(source["log_two_grid137"]) is int, "noninteger cached logarithm")
    require(log_two == source["log_two_grid137"], "shared log2 does not match source")

    rows = []
    for index, source_row in enumerate(source_rows):
        for field in ("x", "k", "numerator", "denominator", "log_grid129", "inverse_root_grid98"):
            require(type(source_row[field]) is int, f"row {index}: noninteger {field}")
        x = source_row["x"]
        k = x.bit_length() - 1
        a, b = x - (1 << k), x + (1 << k)
        require(0 < x <= 265800 and k <= 18 and 0 <= 3 * a <= b, "invalid source range")
        require((k, a, b) == (source_row["k"], source_row["numerator"],
                             source_row["denominator"]), "range reduction mismatch")
        q = round_div(256, k * log_two + log_center(a, b))
        require(q == source_row["log_grid129"], f"base {x}: logarithm center mismatch")
        m = isqrt((1 << 196) // x)
        require(m == source_row["inverse_root_grid98"], f"base {x}: inverse-root mismatch")
        require(m * m * x <= (1 << 196) < (m + 1) * (m + 1) * x,
                f"base {x}: inverse-root bracket failed")
        inner, step = step_from_log(q)
        initial = (m << 22, 0)
        trace = [initial]
        for _ in range(STEPS):
            trace.append(mul_step(trace[-1], step))
        require(len(trace) == 129 and trace[0] == initial, "trace shape mismatch")
        rows.append({"base_index": index, "x": x, "k": k,
                     "log_grid129": q, "inverse_root_grid98": m,
                     "phase_numerator": -5 * q, "phase_denominator": 1 << 135,
                     "step_inner_grid131": inner, "step_grid122": step,
                     "initial_grid120": initial, "states_grid120": trace})

    count = len(rows)
    pairs = sum(len(row["states_grid120"]) for row in rows)
    require(count == 8 and pairs == 1032, "complete trace count mismatch")
    counts = {
        "bases": count, "updates_per_base": STEPS, "states_per_base": STEPS + 1,
        "state_pairs": pairs, "state_coordinates": 2 * pairs,
        "complex_state_updates": count * STEPS,
        "state_signed_real_products": 4 * count * STEPS,
        "state_product_combining_additions_subtractions": 2 * count * STEPS,
        "state_coordinate_roundings": 2 * count * STEPS,
        "log_shared_log2_computations": 1,
        "log_horner_affine_updates_including_shared_log2": (count + 1) * 45,
        "log_center_final_roundings_including_shared_log2": count + 1,
        "log_grid129_export_roundings": count,
        "inverse_root_candidate_computations": count,
        "exponential_affine_updates": count * 72,
        "exponential_coordinate_roundings": 2 * count * 72,
        "step_grid122_coordinate_roundings": 2 * count,
    }
    require(counts["complex_state_updates"] == 1024, "update count mismatch")
    require(sha256(Path(__file__).read_bytes()) == generator_hash, "generator changed during run")
    result = {
        "schema": "raw-head-matched-state-fixture-v1",
        "scope": "Untrusted exact-integer proposals only; no formal correctness, analytic, sign, or timing extrapolation claim",
        "source_fixture": {"filename": SOURCE.name, "sha256": SOURCE_SHA256,
                           "bytes": len(source_bytes)},
        "generator": {"filename": Path(__file__).name, "sha256": generator_hash},
        "base_order": BASES,
        "grids": {"log_inner": 137, "log_export": 129, "inverse_root": 98,
                  "initial_embedding_left_shift": 22, "state": 120,
                  "step_inner": 131, "step_export": 122},
        "rounding": "roundDiv(d,r)=(2*r+d)//(2*d), d>0; Python // is mathematical floor; ties toward positive infinity",
        "time_index": {"first": 0, "last_inclusive": 128,
                       "step_numerator": 5, "step_denominator": 64},
        "trace_order": "base-major; states_grid120[j] is the retained pair at time 5*j/64",
        "integer_encoding": "JSON signed integer tokens; consumers must parse exactly, not through binary64",
        "log_two_grid137": log_two,
        "counts": counts,
        "count_scope": "Named arithmetic schedule only; not an exhaustive CPU/proof/serialization operation count",
        "rows": rows,
    }
    result["native_proposal_timing"] = {
        "cpu_ns": time.process_time_ns() - cpu_start,
        "wall_ns": time.perf_counter_ns() - wall_start,
        "scope": "Current-process source/self reads, hash checks, validation, shared setup, integer proposal generation and result construction; excludes startup/imports, final JSON encoding, output write and this timing record",
        "zero_cpu_note": "A zero observation can mean timer resolution, not zero work",
    }
    encoded = (json.dumps(result, indent=2, allow_nan=False) + "\n").encode("utf-8")
    require(len(encoded) <= OUTPUT_CAP,
            f"{OUTPUT.name}: {len(encoded)} bytes exceeds cap {OUTPUT_CAP}")
    # Exclusive publication. A failed write may leave a partial file; preserve it.
    with OUTPUT.open("xb") as output_file:
        output_file.write(encoded)
    print(json.dumps({"output": str(OUTPUT), "bytes": len(encoded),
                      "sha256": sha256(encoded), "formal_certificate": False}))


if __name__ == "__main__":
    main()
