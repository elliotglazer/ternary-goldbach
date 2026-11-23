"""Independent literal-source final type and axiom probe for the positive sample."""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import time

HERE = Path(__file__).resolve().parent
PILOTS = HERE.parent
ROOT = HERE.parents[2]
CACHE = ROOT / "work/qrh-campaign/agents/integration/artifacts"
LEAN = Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
PACKAGES = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()
expected = {
    "spectral/PositiveHeight.lean": "955866564A49B21DC9B6436B7B830305ED569C167474CB9E592486CB2355309A",
    "spectral/PositiveHeight.olean": "74A15CD89D6B042FDBF6C1A6C2F610941BE0F0F6BBB5DE8B29671545DC9C355B",
    "spectral/SampleBox.lean": "3DF9542AB3DEBB4F2AAB7BF660401757E697E2774BCB396006B82CF3A3A663D6",
    "spectral/CentralChi4.lean": "DADBA753B6475CD5ED9C48F0CC1312709F60DE8FCCF7291C5CC797A844A89D22",
    "spectral-completion/GammaEnclosure.lean": "1CCA415D6FA64E24F052F0426C36BB68A373E30166F9234C61A5C7D11DD7B920",
    "spectral-completion/CompletionFactor.lean": "F1BF6D24853A20EE9524E839907E8B2C8ABCA270148435B9A3A465743E805359",
    "spectral-reality/Chi4Reality.lean": "D1CFC512A3271DF46D961A2E5FAD0FA159CCBC974786CCBDFCEF7D4635555C21",
}
for rel, h in expected.items():
    assert sha(PILOTS / rel) == h
modules = {
    "spectral": ["CentralChi4","Elementary","FiniteInputs","RoundedInputs","Tail","SampleBox","PositiveHeight"],
    "spectral-abel": ["FiniteAbel"],
    "spectral-completion": ["GammaEnclosure","CompletionFactor"],
    "spectral-reality": ["Chi4Reality"],
}
paths = [PILOTS / folder / (name + ext) for folder,names in modules.items()
         for name in names for ext in [".lean", ".olean"]]
paths += [ROOT / "work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean",
          CACHE / "TernaryGoldbach/Explicit/LGrowth.olean"]
pins = {str(p.relative_to(ROOT)).replace('\\','/'): sha(p) for p in paths}
probe_text = """import PositiveHeight

example : SpectralPilot.chi4 = ZMod.χ₄.ringHomComp (Int.castRingHom ℂ) := rfl

example :
    0 < (((4 : ℂ) ^ (((1 / 2 : ℂ) + Complex.I * (5 / 64)) / 2)) *
      DirichletCharacter.completedLFunction
        (ZMod.χ₄.ringHomComp (Int.castRingHom ℂ))
        ((1 / 2 : ℂ) + Complex.I * (5 / 64))).re ∧
    (((4 : ℂ) ^ (((1 / 2 : ℂ) + Complex.I * (5 / 64)) / 2)) *
      DirichletCharacter.completedLFunction
        (ZMod.χ₄.ringHomComp (Int.castRingHom ℂ))
        ((1 / 2 : ℂ) + Complex.I * (5 / 64))).im = 0 :=
  SpectralPilot.positive_height_chi4_certificate

#check SpectralPilot.positive_height_chi4_certificate
#print DirichletCharacter.completedLFunction
#print axioms SpectralPilot.positive_height_chi4_certificate
#print axioms SpectralPilot.actual_sample_box
#print axioms SpectralCompletion.completion_factor_eq
#print axioms SpectralCompletion.gammaPhase_enclosure
#print axioms SpectralRealityPilot.normalized_completed_chi4_real
"""
probe = HERE / "PositiveHeightSemanticProbe.lean"
log = HERE / "positive_height_export_probe.log"
out = HERE / "positive_height_export_probe_receipt.json"
assert not probe.exists() and not log.exists() and not out.exists()
env = dict(os.environ)
env["LEAN_PATH"] = ";".join([str(PILOTS/folder) for folder in modules] + [str(CACHE)] +
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
    assert pins == {str(p.relative_to(ROOT)).replace('\\','/'):sha(p) for p in paths}
    receipt = {
        "scope":"Complete internal positive-height sample exact-source/type/axiom audit; no full-spectrum or throughput claim",
        "command":cmd,"exit_code":result.returncode,"wall_seconds":elapsed,
        "pins":pins,"probe_text":probe_text,
        "probe_sha256":hashlib.sha256(probe_text.encode()).hexdigest().upper(),
        "log_sha256":sha(log),"script_sha256":sha(Path(__file__)),
        "lean_executable_sha256":sha(LEAN),"temporary_probe_deleted":True,
    }
    out.write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
    print(output)
    print(json.dumps({"exit_code":result.returncode,"receipt_sha256":sha(out)}))
finally:
    probe.unlink()
