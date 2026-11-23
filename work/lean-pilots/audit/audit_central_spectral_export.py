"""Independent actual-L type/definition/axiom check; central milestone only."""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
SPECTRAL = HERE.parent / "spectral"
CACHE = ROOT / "work/qrh-campaign/agents/integration/artifacts"
LEAN = Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
PACKAGES = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()
expected = {
    SPECTRAL / "CentralChi4.lean": "DADBA753B6475CD5ED9C48F0CC1312709F60DE8FCCF7291C5CC797A844A89D22",
    SPECTRAL / "CentralChi4.olean": "B7FB59F14A902F4E4712DF2485EE9760D417CCAFFCB118252321FD38CC480607",
    ROOT / "work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean": "5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341",
    CACHE / "TernaryGoldbach/Explicit/LGrowth.olean": "1F4140842770D4B6A8B9CFE93D724FF5C1B55111A2CAA57C5350BAEBE9EBB7FC",
}
for p, h in expected.items():
    assert sha(p) == h
probe_text = """import CentralChi4

example : SpectralPilot.chi4 = ZMod.χ₄.ringHomComp (Int.castRingHom ℂ) := rfl

example :
    (1 / 4 : ℝ) < (DirichletCharacter.LFunction
      (ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)) (1 / 2)).re ∧
    (DirichletCharacter.LFunction
      (ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)) (1 / 2)).re ≤ 1 ∧
    (DirichletCharacter.LFunction
      (ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)) (1 / 2)).im = 0 :=
  SpectralPilot.central_chi4_certificate

#check SpectralPilot.central_chi4_certificate
#print DirichletCharacter.LFunction
#print ZMod.LFunction
#print axioms SpectralPilot.central_chi4_certificate
#print axioms SpectralPilot.actual_central_finite_approximation
#print axioms SpectralPilot.central_tail_le
#print axioms TernaryGoldbach.Explicit.LFunction_eq_mul_Iint
"""
probe = HERE / "CentralSpectralSemanticProbe.lean"
log = HERE / "central_spectral_export_probe.log"
out = HERE / "central_spectral_export_probe_receipt.json"
assert not probe.exists() and not log.exists() and not out.exists()
env = dict(os.environ)
env["LEAN_PATH"] = ";".join([str(SPECTRAL), str(CACHE)] +
    [str(p / ".lake/build/lib/lean") for p in PACKAGES.iterdir() if p.is_dir()])
cmd = [str(LEAN), "-j", "1", "-t", "0", str(probe)]
probe.write_text(probe_text, encoding="utf-8")
start = time.monotonic()
try:
    result = subprocess.run(cmd, cwd=HERE, env=env, text=True,
                            capture_output=True, timeout=240)
    elapsed = time.monotonic() - start
    output = result.stdout + result.stderr
    log.write_text(output, encoding="utf-8")
    for p, h in expected.items():
        assert sha(p) == h
    receipt = {
        "scope": "Internal actual central L-value milestone only; no positive-height pipeline verdict",
        "command": cmd, "exit_code": result.returncode, "wall_seconds": elapsed,
        "pins": {str(p.relative_to(ROOT)).replace('\\', '/'): h for p,h in expected.items()},
        "probe_text": probe_text,
        "probe_sha256": hashlib.sha256(probe_text.encode()).hexdigest().upper(),
        "log_sha256": sha(log), "script_sha256": sha(Path(__file__)),
        "lean_executable_sha256": sha(LEAN), "temporary_probe_deleted": True,
    }
    out.write_text(json.dumps(receipt, indent=2) + "\n", encoding="utf-8")
    print(output)
    print(json.dumps({"exit_code": result.returncode, "receipt_sha256": sha(out)}))
finally:
    probe.unlink()
