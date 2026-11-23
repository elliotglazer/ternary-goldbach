"""Emit the one matched computed recurrence proposal; never invoke Lean.

All output coordinates live in the shared immutable fixture. Each arithmetic
theorem asks the kernel to evaluate the full cached trace, not just its endpoint.
"""
from pathlib import Path
import hashlib

HERE = Path(__file__).resolve().parent
BASES = ((1, 0), (2, 1), (3, 1), (41, 5), (61, 5),
         (10004, 13), (262144, 18), (265800, 18))
DATA_SHA = "BB0388FFA768A4F4CAF9154534C7F7D40CC5F4177F91513A301610FEA1B72CFB"
SOURCE_SHA = "33BF2B31643441ADEE556401DED2303D02990DEE549D45DA6CB27BD978A05C75"

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()

assert sha(HERE / "RawStateFixtureData.lean") == DATA_SHA
assert sha(HERE / "RawStateSources.lean") == SOURCE_SHA

outputs = {}
for x, k in BASES:
    outputs[f"RawStateComputed{x}.lean"] = f'''import RawStateFixtureData
import RawCachedLoop

/-! Computed full-trace arithmetic for the single matched fixture.
Shared literal data SHA256: {DATA_SHA}
No source producer or hidden concrete arithmetic theorem is imported here. -/

namespace RawStateComputed
open RawHead RawStateData

theorem trace_checked_{x} :
    cachedTrace initial_{x} step_{x} 128 = trace_{x} := by
  decide +kernel

end RawStateComputed
'''

lines = ["import RawStateSources", "import RawTraceCertificate"]
lines += [f"import RawStateComputed{x}" for x, _ in BASES]
lines += ["", "/-! Source transport for the same complete eight-by-129 literal trace.",
          "The imported computed arithmetic modules are part of the measured closure. -/",
          "", "namespace RawStateComputed", "open RawHead RawStateData RawStateSources", ""]
for x, k in BASES:
    lines += [f'''theorem certificate_{x} : traceCertificate initial_{x} step_{x} trace_{x} = true := by
  rw [← trace_checked_{x}]
  exact traceCertificate_cachedTrace _ _ _

theorem actual_trace_{x} : rawCachedTrace {k} {x} 128 = trace_{x} := by
  change cachedTrace (rawStateInitial {x}) (rawStepNumerator {k} {x}) 128 = _
  have hi : rawStateInitial {x} = initial_{x} := initial_checked_{x}
  rw [hi, step_checked_{x}]
  exact trace_checked_{x}

theorem actual_error_{x} (j : ℕ) (hj : j < 129) :
    ‖expIntegerValue (2 ^ 120) (trace_{x}[j]'(by rw [trace_length_{x}]; exact hj)) -
      integerPower ({x} : ℝ) ((j : ℝ) * 5 / 64)‖ < 1 / (2 : ℝ) ^ 96 := by
  simpa only [Nat.cast_one, Nat.cast_ofNat] using (traceCertificate_actual_error
    (show initial_{x} = rawStateInitial {x} from initial_checked_{x}.symm)
    step_checked_{x}.symm trace_{x} certificate_{x}
    (by decide) (by decide) (by decide) (by decide) j
    (by rw [trace_length_{x}]; exact hj) (by omega))
''']
actual_list = ", ".join(f"rawCachedTrace {k} {x} 128" for x, k in BASES)
lines += [f"theorem all_traces_checked : [{actual_list}] = allTraces := by",
          "  simp only [allTraces, " + ", ".join(f"actual_trace_{x}" for x, _ in BASES) + "]",
          "", "end RawStateComputed", ""]
outputs["RawStateComputed.lean"] = "\n".join(lines)

# Exclusive publication: a retry must be an explicit owner decision, not overwrite.
for name in outputs:
    assert not (HERE / name).exists(), name
for name, source in outputs.items():
    with (HERE / name).open("x", encoding="utf-8", newline="\n") as stream:
        stream.write(source)
    print(name, sha(HERE / name))
