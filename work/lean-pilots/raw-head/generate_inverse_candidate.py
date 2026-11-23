"""Emit the fixed 64-case computed-candidate comparison; no Lean execution.

The saved fixture is untrusted input. Each emitted candidate equality must be
proved by Lean's ordinary kernel computation before its error theorem is used.
No inverse square roots or other analytic values are evaluated by this script.
"""
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
FIXTURE_SHA256 = "BB725A50AB0EC32A07F3516542E2FC3CE59081E75598E7283B686D0AFDBB12C3"


def main():
    raw = (HERE / "fixture64.json").read_bytes()
    assert hashlib.sha256(raw).hexdigest().upper() == FIXTURE_SHA256
    rows = json.loads(raw)["rows"]
    assert len(rows) == 64
    assert len({row["x"] for row in rows}) == 64
    lines = [
        "import RawInverseRootProducer",
        "",
        "/-! Fixed saved-fixture comparison using checked Nat.sqrt computation.",
        "No supplied-witness proof module is imported.",
        f"Fixture SHA256: {FIXTURE_SHA256}",
        "-/",
        "",
        "namespace RawInverseRootGenerated64",
        "",
    ]
    for row in rows:
        x, m = row["x"], row["inverse_root_grid98"]
        assert type(x) is int and x > 0
        assert type(m) is int and m >= 0
        lines.extend([
            f"theorem candidate_{x} : RawHead.inverseRootCandidate {x} (2 ^ 98) = {m} := by",
            "  decide +kernel",
            "",
            f"theorem inverse_sqrt_{x} :",
            f"    0 ≤ (Real.sqrt ({x} : ℝ))⁻¹ - ({m} : ℝ) / 2 ^ 98 ∧",
            f"    (Real.sqrt ({x} : ℝ))⁻¹ - ({m} : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by",
            f"  have h := RawHead.inverseRootCandidate_error (x := {x}) (S := 2 ^ 98)",
            "    (by decide) (by decide)",
            f"  simpa only [candidate_{x}, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h",
            "",
        ])
    names = [f"inverse_sqrt_{row['x']}" for row in rows]
    lines.append("theorem all_inverse_roots :")
    lines.append("    " + " ∧\n    ".join(f"(type_of% {name})" for name in names) + " :=")
    proof = names[-1]
    for name in reversed(names[:-1]):
        proof = f"And.intro {name} ({proof})"
    lines.extend(["  " + proof, "", "end RawInverseRootGenerated64", ""])
    data = "\n".join(lines).encode("utf-8")
    target = HERE / "RawInverseRootGenerated64.lean"
    with target.open("xb") as handle:
        handle.write(data)
    print(json.dumps({"source": target.name, "rows": len(rows),
                      "bytes": len(data),
                      "sha256": hashlib.sha256(data).hexdigest().upper(),
                      "scope": "source generation only; no Lean build or timing claim"}))


if __name__ == "__main__":
    main()
