"""Join pinned conditional budgets; no numerical certificate generation or benchmark."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
PINS = {
    "finite_cost_scenarios.json": "48FC76488941526A4B2CA5B5198B06D6051DA67D78DFBA342C5F8B9374E9363B",
    "FINITE_COST_ESTIMATE.md": "F03C9E49433988ECCEF97D6A10CCA073F7BD024F1B92511285CCD7D65CA1BFCE",
    "spectral_fermi_v6_20261111.json": "B174BE3910505265B12DB95098D6B17EEAD5BE85361F542BC496A5FB980F2682",
    "SPECTRAL_COST_ESTIMATE.md": "48F721494509A7EDF164210C91DA0FDAD8140E05F85E7EA3C01A6E16EA567D43",
    "spectral_source_ledger_v6_20261111.json": "02162B6EDE622B6499B8E5D70B5D2A4FC5C23110B9B56E9C0E479B3AF745EA01",
}

def read_pinned(name):
    raw = (HERE / name).read_bytes()
    assert hashlib.sha256(raw).hexdigest().upper() == PINS[name], name
    return raw

data = {name: read_pinned(name) for name in PINS}
for pin in json.loads(data["spectral_source_ledger_v6_20261111.json"]):
    raw = (ROOT / pin["path"]).read_bytes()
    assert len(raw) == pin["bytes"], pin["path"]
    assert hashlib.sha256(raw).hexdigest().upper() == pin["sha256"], pin["path"]

finite = json.loads(data["finite_cost_scenarios.json"])
spectral = json.loads(data["spectral_fermi_v6_20261111.json"])["scenarios"]
rows = []
for label, s in spectral.items():
    assert sum(r["P"] for r in s["rows"]) == s["P"]
    assert sum(r["A"] for r in s["rows"]) == s["A"]
    reference = F(s["P"], 5000) + F(s["A"], 500)
    assert reference == F(s["reference_gate_equivalents"])
    dispatches = s["P"] * s["mm0_dispatch_expansion"]["P"] + s["A"] * s["mm0_dispatch_expansion"]["A"]
    assert dispatches == s["mm0_dispatches_assumed"]
    for backend, finite_backend in [("Lean", "Lean"), ("MM0_ordinary_conditional", "MM0_stock_conditional")]:
        f = next(r for r in finite["rows"] if r["scenario"] == label and r["backend"] == finite_backend)
        fgen = F(str(f["core_years"]["generation"])) * 8766
        fcheck = F(str(f["core_years"]["checking"])) * 8766
        if backend == "Lean":
            # Includes first kernel acceptance; do not add another spectral check.
            build = F(s["lean_generation_core_hours"])
            independent_replay = F(s["lean_independent_check_core_hours"]) + fcheck
            phases = {
                "spectral_build_including_first_acceptance": build,
                "finite_external_generation": fgen,
                "finite_first_check": fcheck,
            }
        else:
            independent_replay = None
            phases = {
                "spectral_external_generation": F(s["mm0_generation_core_hours"]),
                "spectral_first_check": F(s["mm0_check_core_hours"]),
                "finite_external_generation": fgen,
                "finite_first_check": fcheck,
            }
        total = sum(phases.values())
        rows.append({
            "backend": backend, "scenario": label, "binary_cutoff": f["B"],
            "core_hours_by_phase": {k: str(v) for k, v in phases.items()},
            "primary_core_hours": str(total), "primary_core_years": str(total / 8766),
            "optional_extra_independent_lean_replay_core_hours": str(independent_replay) if independent_replay is not None else None,
            "finite_total_core_years": f["core_years"]["total"],
            "spectral_serialized_bytes_assumed": s["lean_retained_serialized_bytes_assumed"] if backend == "Lean" else str(s["mm0_stream_bytes_assumed"]),
        })

result = {
    "scope": "Provisional current-design Fermi scenarios, not optimized cost predictions, runtime bounds, or proof feasibility",
    "year_hours": 8766, "input_pins": PINS, "spectral_source_pins_verified": 21,
    "phase_policy": "One first acceptance; Lean initial spectral build already checks proofs; optional independent replay excluded",
    "library_policy": "Generic arithmetic/analysis reserves in spectral; finite reserve restricted to finite decoders and assembly",
    "rows": rows,
}
with (HERE / "END_TO_END_ESTIMATE.json").open("x", encoding="utf-8") as f:
    json.dump(result, f, indent=2)
    f.write("\n")
for row in rows:
    print(row["backend"], row["scenario"], "hours", float(F(row["primary_core_hours"])),
          "years", float(F(row["primary_core_years"])))
