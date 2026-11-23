"""Emit literal matched-workload data and the separate common-source closure.

This emitter does not run Lean, certify the trace, or change imported sources.
The coordinator compiles the ordinary Lean proof proposals separately.
"""

import hashlib
import json
from pathlib import Path
import sys


HERE = Path(__file__).resolve().parent
FIXTURE_SHA = "01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9"
LOG_CASES_SHA = "6CC1E45D4E8C33BFD52D3E8A752D2A08F34682399F31E8F92EC27F3C02157AEA"
BASES = (1, 2, 3, 41, 61, 10004, 262144, 265800)
OUTPUTS = ("RawStateFixtureData.lean", "RawStateSources.lean")


def require(ok, message):
    if not ok:
        raise ValueError(message)


def digest(raw):
    return hashlib.sha256(raw).hexdigest().upper()


def pair_text(value):
    require(type(value) is list and len(value) == 2, "pair shape")
    require(all(type(v) is int for v in value), "noninteger coordinate")
    return f"({value[0]}, {value[1]})"


def main():
    require(len(sys.argv) == 1, "fixed generator takes no arguments")
    for name in OUTPUTS:
        require(not (HERE / name).exists(), f"refusing to overwrite {name}")
    with (HERE / "state_fixture.json").open("rb") as stream:
        raw = stream.read((2 << 20) + 1)
    require(len(raw) <= 2 << 20, "fixture cap")
    require(digest(raw) == FIXTURE_SHA, "fixture hash mismatch")
    require(digest((HERE / "RawLogCases.lean").read_bytes()) == LOG_CASES_SHA,
            "checked common logarithm source changed")
    fixture = json.loads(raw)
    require(fixture["schema"] == "raw-head-matched-state-fixture-v1", "schema")
    require(tuple(fixture["base_order"]) == BASES, "base order")
    require(fixture["grids"] == {
        "log_inner": 137, "log_export": 129, "inverse_root": 98,
        "initial_embedding_left_shift": 22, "state": 120,
        "step_inner": 131, "step_export": 122}, "grid mismatch")
    require(fixture["counts"]["state_pairs"] == 1032, "pair count")
    rows = fixture["rows"]
    require(len(rows) == 8, "row count")
    self_sha = digest(Path(__file__).read_bytes())
    provenance = [
        "/-! Generated proof proposal for the fixed matched raw-head experiment.",
        f"Fixture SHA256: {FIXTURE_SHA}",
        f"Emitter SHA256: {self_sha}",
        "All stored integers are literal data. Compilation is separate.",
        "-/", ""]
    data = ["import Mathlib.Data.Int.Basic", "", *provenance,
            "namespace RawStateData", "",
            "def stateScale : ℕ := 2 ^ 120",
            "def stepScale : ℕ := 2 ^ 122",
            "def baseOrder : List ℕ := [" + ", ".join(map(str, BASES)) + "]", ""]
    source = ["import RawStateFixtureData", "import RawLogCases",
              "import RawStepProducer", "import RawInverseRootWitness", "import RawStateProducer", "", *provenance,
              "/-! Common setup only. Existing RawLogCases is a charged dependency.",
              "No whole-trace recurrence or approximation is asserted by this module.",
              "Each source equality below has no certificate or error hypothesis.",
              "-/", "", "namespace RawStateSources", "open RawStateData", ""]
    for index, row in enumerate(rows):
        x = BASES[index]
        require(row["base_index"] == index and row["x"] == x, "row binding")
        k, q, m = (row[key] for key in ("k", "log_grid129", "inverse_root_grid98"))
        require(all(type(v) is int for v in (k, q, m)), "integer source fields")
        require(0 <= k <= 18 and (1 << k) <= x <= 2 * (1 << k), "range reduction")
        require(row["phase_numerator"] == -5 * q and
                row["phase_denominator"] == 1 << 135, "phase binding")
        require(row["initial_grid120"] == [m << 22, 0], "initial binding")
        trace = row["states_grid120"]
        require(len(trace) == 129 and trace[0] == row["initial_grid120"], "trace shape/head")
        data += [f"def rangeExponent_{x} : ℕ := {k}",
                 f"def logNumerator_{x} : ℤ := {q}",
                 f"def rootNumerator_{x} : ℕ := {m}",
                 f"def innerStep_{x} : ℤ × ℤ := {pair_text(row['step_inner_grid131'])}",
                 f"def step_{x} : ℤ × ℤ := {pair_text(row['step_grid122'])}",
                 f"def initial_{x} : ℤ × ℤ := {pair_text(row['initial_grid120'])}",
                 f"def trace_{x} : List (ℤ × ℤ) := [",
                 ",\n".join("  " + pair_text(pair) for pair in trace), "]", ""]
        source += [
            f"theorem range_checked_{x} : 0 < ({x} : ℕ) ∧ {k} ≤ (18 : ℕ) ∧",
            f"    2 ^ {k} ≤ ({x} : ℕ) ∧ ({x} : ℕ) ≤ 2 * 2 ^ {k} := by decide",
            "",
            f"theorem log_checked_{x} : RawHead.log129Center {k} {x} = logNumerator_{x} := by",
            f"  exact (RawHead.log129WithLogTwo_eq RawLogCases.logTwo_checked {k} {x}).symm.trans",
            f"    RawLogCases.center_{x}", "",
            f"theorem root_checked_{x} :",
            f"    RawHead.inverseRootCandidate {x} (2 ^ 98) = rootNumerator_{x} := by",
            "  apply RawHead.inverseRootCandidate_eq_of_square_bounds (by decide)",
            f"  · change ({m} : ℕ) * {m} * {x} ≤ (2 ^ 98 : ℕ) * 2 ^ 98",
            f"    exact_mod_cast RawLogCases.sqrt_lo_{x}",
            f"  · change (2 ^ 98 : ℕ) * 2 ^ 98 < ({m} + 1) * ({m} + 1) * {x}",
            f"    exact_mod_cast RawLogCases.sqrt_hi_{x}", "",
            f"theorem initial_checked_{x} :",
            f"    ((RawHead.inverseRootCandidate {x} (2 ^ 98) : ℤ) * 2 ^ 22, 0) =",
            f"      initial_{x} := by",
            f"  rw [root_checked_{x}]",
            "  decide +kernel", "",
            f"theorem inner_step_checked_{x} :",
            f"    RawHead.stepInnerFromLog logNumerator_{x} = innerStep_{x} := by decide +kernel", "",
            f"theorem step_from_log_checked_{x} :",
            f"    RawHead.stepFromLog logNumerator_{x} = step_{x} := by",
            f"  rw [RawHead.stepFromLog, inner_step_checked_{x}]",
            "  decide +kernel", "",
            f"theorem step_checked_{x} : RawHead.rawStepNumerator {k} {x} = step_{x} := by",
            f"  rw [RawHead.rawStepNumerator, log_checked_{x}]",
            f"  exact step_from_log_checked_{x}", "",
            f"theorem step_error_{x} :",
            f"    ‖RawHead.expIntegerValue (2 ^ 122) step_{x} -",
            f"      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log ({x} : ℝ)))‖ <",
            "      1 / (2 : ℝ) ^ 120 := by",
            f"  have h := RawHead.rawStepValue_error (x := {x}) (k := {k})",
            "    (by decide) (by decide) (by decide) (by decide)",
            f"  simpa only [RawHead.rawStepValue, step_checked_{x}, Nat.cast_ofNat, Nat.cast_one] using h", "",
            f"theorem initial_error_{x} :",
            f"    ‖RawHead.expIntegerValue (2 ^ 120) initial_{x} -",
            f"      RawHead.integerPower ({x} : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by",
            f"  have h := RawHead.rawStateValue_zero_error (x := {x}) (by decide) {k}",
            "  simpa only [RawHead.rawStateValue, RawHead.rawStateNumerator,",
            f"    RawHead.rawStateInitial, initial_checked_{x}, Nat.cast_ofNat, Nat.cast_one] using h", "",
            f"theorem trace_length_{x} : trace_{x}.length = 129 := by decide +kernel",
            f"theorem trace_head_{x} : trace_{x}.head? = some initial_{x} := by",
            f"  change some {pair_text(row['initial_grid120'])} = some initial_{x}",
            "  rfl", ""]
    data += ["def allTraces : List (List (ℤ × ℤ)) := [" +
             ", ".join(f"trace_{x}" for x in BASES) + "]", "", "end RawStateData", ""]
    source += ["theorem base_count : baseOrder.length = 8 := by decide",
               "theorem trace_count : allTraces.length = 8 := by decide", "",
               "end RawStateSources", ""]
    contents = ["\n".join(data).encode("utf-8"), "\n".join(source).encode("utf-8")]
    for name, content in zip(OUTPUTS, contents):
        require(len(content) <= 1 << 20, f"{name}: {len(content)} exceeds 1 MiB")
    require(digest(Path(__file__).read_bytes()) == self_sha, "emitter changed")
    published = []
    for name, content in zip(OUTPUTS, contents):
        # A failed publication preserves any created file for coordinator review.
        with (HERE / name).open("xb") as stream:
            published.append(name)
            stream.write(content)
        print(json.dumps({"file": name, "bytes": len(content), "sha256": digest(content),
                          "fixture_sha256": FIXTURE_SHA, "lean_checked": False}))


if __name__ == "__main__":
    main()
