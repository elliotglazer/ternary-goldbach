"""Untrusted exact-integer proposals. Lean checks all retained arithmetic and analytic bounds."""
import hashlib
import json
import math
import sys
import time
from pathlib import Path

here = Path(__file__).resolve().parent
start = time.process_time()
started_wall = time.perf_counter()
S = 1 << 137

def nearest(d, r):
    assert d > 0
    return (2 * r + d) // (2 * d)

def log_center(a, b):
    h = 0
    for k in reversed(range(45)):
        denominator = (2 * k + 1) * b * b
        h = nearest(denominator, S * b * b + (2 * k + 1) * a * a * h)
    return nearest(b, 2 * a * h)

log_two = log_center(1, 3)
bases = [1, 2, 3, 41, 61, 10004, 262144, 265800]
count = int(sys.argv[1]) if len(sys.argv) > 1 else 8
assert count in (8, 64)
if count == 64:
    bases = sorted(set(bases + [1 + i * 265799 // 57 for i in range(1, 57)]))
assert len(bases) == count
suffix = "" if count == 8 else str(count)
rows = []
for x in bases:
    k = x.bit_length() - 1
    a, b = x - (1 << k), x + (1 << k)
    assert 0 < x <= 265800 and k <= 18 and 3 * a <= b
    center = nearest(256, k * log_two + log_center(a, b))
    m = math.isqrt((1 << 196) // x)
    assert m * m * x <= 1 << 196 < (m + 1) * (m + 1) * x
    rows.append(dict(x=x, k=k, numerator=a, denominator=b, log_grid129=center, inverse_root_grid98=m))
fixture = dict(log_two_grid137=log_two, rows=rows, producer_cpu_seconds=time.process_time()-start,
    producer_wall_seconds=time.perf_counter()-started_wall,
    timer_note="A zero CPU observation means below the Windows process-timer resolution, not zero work",
    scope=f"{count} actual positive integer logarithm and inverse-root proposals; no transform or sign claim")
(here / f"fixture{suffix}.json").write_text(json.dumps(fixture, indent=2)+"\n", encoding="utf-8")

lines = ["import RawLogAssembly", "import RawInverseRoot", "", "namespace RawLogData", "",
    f"def logTwo137 : ℤ := {log_two}", "end RawLogData", "", "namespace RawLogCases", "open RawLogData", "",
    "theorem logTwo_checked : logTwo137 = RawHead.logCenter (2 ^ 137) 1 3 45 := by decide +kernel", ""]
for row in rows:
    x, k, q, m = (row[key] for key in ("x", "k", "log_grid129", "inverse_root_grid98"))
    lines += [f"theorem center_{x} : RawHead.log129WithLogTwo logTwo137 {k} {x} = {q} := by decide +kernel",
        f"theorem log_{x} : |Real.log ({x} : ℝ) - ({q} : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by",
        f"  have he := RawHead.log129WithLogTwo_eq logTwo_checked {k} {x}",
        f"  have hc : RawHead.log129Center {k} {x} = {q} := he.symm.trans center_{x}",
        f"  have h := RawHead.log129Center_error (x := {x}) (k := {k}) (by decide) (by decide) (by decide) (by decide)",
        ("  simpa only [hc, Nat.cast_one, Int.cast_zero] using h" if x == 1 else
         "  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h"), "",
        f"theorem sqrt_lo_{x} : ({m} : ℤ) * {m} * {x} ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel",
        f"theorem sqrt_hi_{x} : (2 ^ 98 : ℤ) * 2 ^ 98 < ({m} + 1) * ({m} + 1) * {x} := by decide +kernel",
        f"theorem inverse_sqrt_{x} :",
        f"    0 ≤ (Real.sqrt ({x} : ℝ))⁻¹ - ({m} : ℝ) / 2 ^ 98 ∧",
        f"    (Real.sqrt ({x} : ℝ))⁻¹ - ({m} : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by",
        f"  have h := RawHead.inverse_sqrt_sub_div_bounds (x := {x}) (S := 2 ^ 98) (m := {m})",
        f"    (by decide) (by decide) sqrt_lo_{x} sqrt_hi_{x}",
        ("  simpa only [Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one, Int.cast_ofNat] using h" if x == 1 else
         "  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h"), ""]
def conjunction_proof(prefix):
    names = [f"{prefix}_{row['x']}" for row in rows]
    if count == 8:
        return ["  exact ⟨" + ", ".join(names) + "⟩"]
    return [f"  refine And.intro {name} ?_" for name in names[:-1]] + [f"  exact {names[-1]}"]

statements = [f"|Real.log ({row['x']} : ℝ) - ({row['log_grid129']} : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ)" for row in rows]
lines += ["theorem all_logs :", "    " + " ∧\n    ".join(statements) + " := by",
    *conjunction_proof("log"), ""]
inverse_statements = [f"(0 ≤ (Real.sqrt ({row['x']} : ℝ))⁻¹ - ({row['inverse_root_grid98']} : ℝ) / 2 ^ 98 ∧ "
    f"(Real.sqrt ({row['x']} : ℝ))⁻¹ - ({row['inverse_root_grid98']} : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ))" for row in rows]
if count == 64:
    # Resolve each leaf proposition in the header using Lean's builtin
    # type_of%; do not re-elaborate overloaded real arithmetic or leave a
    # header metavariable to be solved by the later proof body.
    names = [f"inverse_sqrt_{row['x']}" for row in rows]
    body = names[-1]
    for name in reversed(names[:-1]):
        body = f"And.intro {name} ({body})"
    header = " ∧\n    ".join(f"(type_of% {name})" for name in names)
    lines += ["theorem all_inverse_roots :", "    " + header + " :=", "  " + body, ""]
else:
    lines += ["theorem all_inverse_roots :", "    " + " ∧\n    ".join(inverse_statements) + " := by",
        *conjunction_proof("inverse_sqrt"), ""]
lines += ["end RawLogCases", ""]
source = "\n".join(lines)
if suffix:
    source = source.replace("RawLogData", "RawLogData" + suffix).replace("RawLogCases", "RawLogCases" + suffix)
(here / f"RawLogCases{suffix}.lean").write_text(source, encoding="utf-8")
chosen = next(row for row in rows if row["x"] == 10004)
x, k, q, m = (chosen[key] for key in ("x", "k", "log_grid129", "inverse_root_grid98"))
controls = ["import RawLogCases", "", "namespace RawSourceControls", "open RawHead RawLogData", "",
    "theorem negative_round : roundDiv 2 (-5) = -2 := by decide +kernel",
    "theorem negative_round_below : roundDiv 4 (-11) = -3 := by decide +kernel",
    f"theorem wrong_log_output : (log129WithLogTwo logTwo137 {k} {x} == ({q} + 8 : ℤ)) = false := by decide +kernel",
    f"theorem wrong_log_input : (log129WithLogTwo logTwo137 {k} ({x} + 1) == ({q} : ℤ)) = false := by decide +kernel",
    f"theorem wrong_log_cache : (log129WithLogTwo (logTwo137 + 2 ^ 16) {k} {x} == ({q} : ℤ)) = false := by decide +kernel",
    f"theorem excessive_inverse_root : decide (({m} + 1 : ℤ) * ({m} + 1) * {x} ≤ (2 ^ 98 : ℤ) * 2 ^ 98) = false := by decide +kernel",
    f"theorem deficient_inverse_root : decide ((2 ^ 98 : ℤ) * 2 ^ 98 < ({m} : ℤ) * {m} * {x}) = false := by decide +kernel",
    "end RawSourceControls", ""]
if not suffix:
    (here / "RawSourceControls.lean").write_text("\n".join(controls), encoding="utf-8")
print(json.dumps(dict(rows=len(rows), producer_cpu_seconds=fixture["producer_cpu_seconds"],
    lean_source_sha256=hashlib.sha256((here / f"RawLogCases{suffix}.lean").read_bytes()).hexdigest())))
