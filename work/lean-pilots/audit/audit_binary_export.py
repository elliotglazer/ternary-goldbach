"""Independent transient exact-type/axiom probe for the completed internal pilot."""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
BINARY = HERE.parent / "binary"
LEAN = Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
PACKAGES = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()
expected = {
    "BinaryPilot.lean": "FF3C1F408E1E83C368DEF8788686731BD9A5323AFB0E6A40CE98837946FABEFD",
    "BinarySupport.lean": "690E5341CA663D37B93DDD3FAF37C115B80D0666A610D6D593AB3A629918F669",
    "PilotPrimes.lean": "6575142C02AFC8158631D43EB3C1CECB56AA8F690A13964A9A6338CBE7D7DE79",
}
for name, h in expected.items():
    assert sha(BINARY / name) == h
probe_text = """import BinaryPilot

example : ∀ n : Nat,
    3999999997356523524 ≤ n → n ≤ 3999999997356523650 →
    Even n → ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ n = p + q :=
  BinaryPilot.binary_interval

#check BinaryPilot.binary_interval
#print axioms BinaryPilot.binary_interval
#print axioms BinaryPilot.lucasNat
#print axioms BinaryPilot.source_0_sound
#print axioms BinaryPilot.prime_3999999988766605261
"""
probe = HERE / "BinarySemanticProbe.lean"
log = HERE / "binary_export_probe.log"
receipt_path = HERE / "binary_export_probe_receipt.json"
assert not probe.exists() and not log.exists() and not receipt_path.exists()
env = dict(os.environ)
env["LEAN_PATH"] = ";".join([str(BINARY)] +
    [str(p / ".lake/build/lib/lean") for p in PACKAGES.iterdir() if p.is_dir()])
cmd = [str(LEAN), "-j", "1", "-t", "0", str(probe)]
pins_before = {name: sha(BINARY / name) for name in expected}
oleans = {name.replace(".lean", ".olean"): sha(BINARY / name.replace(".lean", ".olean"))
          for name in expected}
probe.write_text(probe_text, encoding="utf-8")
start = time.monotonic()
try:
    result = subprocess.run(cmd, cwd=HERE, env=env, text=True,
                            capture_output=True, timeout=240)
    elapsed = time.monotonic() - start
    output = result.stdout + result.stderr
    log.write_text(output, encoding="utf-8")
    assert pins_before == {name: sha(BINARY / name) for name in expected}
    receipt = {
        "scope": "Independent internal exact-type and transitive axiom probe; not public-anchor adoption",
        "command": cmd, "exit_code": result.returncode, "wall_seconds": elapsed,
        "source_pins": pins_before, "olean_pins": oleans,
        "probe_text": probe_text,
        "probe_sha256": hashlib.sha256(probe_text.encode()).hexdigest().upper(),
        "log_sha256": sha(log), "script_sha256": sha(Path(__file__)),
        "lean_executable_sha256": sha(LEAN),
        "temporary_probe_deleted": True,
    }
    receipt_path.write_text(json.dumps(receipt, indent=2) + "\n", encoding="utf-8")
    print(output)
    print(json.dumps({"exit_code": result.returncode, "receipt_sha256": sha(receipt_path)}))
finally:
    probe.unlink()
