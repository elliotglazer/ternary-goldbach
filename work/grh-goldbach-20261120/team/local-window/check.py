"""Check the Mathlib-only window weight and audit its public theorems in one Lean process."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
LEAN = Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
PACKAGES = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")

def main():
    extensions = sys.argv[1:] == ["--extensions"]
    density = sys.argv[1:] == ["--density"]
    if sys.argv[1:] and not (extensions or density):
        raise SystemExit("Use check.py, check.py --extensions or check.py --density")
    sources = [HERE / "LocalWeight.lean"]
    audit = HERE / ("AuditExtensions.lean" if extensions else "AuditWeight.lean")
    declarations = [
        "weight_continuous", "weight_nonneg", "weight_antitone", "weight_le_width",
        "integral_weight_le", "line_coefficient_lt",
    ]
    imports = ""
    if extensions:
        sources = [HERE / "ShiftedWeight.lean", HERE / "LocalMellin.lean"]
        declarations = ["shifted_weight_integral", "localized_mellin_integral_le", "multiplicity_sum_lt"]
        imports = "import AuditWeight\n"
    if density:
        sources = [HERE / "DensityBound.lean"]
        audit = HERE / "AuditDensity.lean"
        declarations = ["density_le"]
    snapshots = {p.name: p.read_bytes() for p in sources}
    source_text = imports + "\n".join(blob.decode("utf-8").replace("\r\n", "\n").replace("import LocalWeight\n", "")
                                      for blob in snapshots.values())
    audit.write_text(source_text + "\n" + "".join(
        f"#print axioms GrhGoldbach.LocalWindow.{name}\n" for name in declarations
    ), encoding="utf-8")
    env = os.environ.copy()
    env["LEAN_PATH"] = os.pathsep.join([str(HERE)] +
        [str(p / ".lake/build/lib/lean") for p in PACKAGES.iterdir() if p.is_dir()])
    command = [str(LEAN), "-t0", "-j1", "-M4096", "-o", audit.with_suffix(".olean").name, audit.name]
    start = time.monotonic()
    log = HERE / ("Density.log" if density else "Extensions.log" if extensions else "LocalWeight.log")
    with log.open("w", encoding="utf-8") as out:
        run = subprocess.run(command, cwd=HERE, env=env, stdin=subprocess.DEVNULL,
                             stdout=out, stderr=subprocess.STDOUT, timeout=1500)
    result = {
        "exit": run.returncode, "seconds": time.monotonic()-start, "command": command,
        "source_sha256": {name: hashlib.sha256(blob).hexdigest() for name, blob in snapshots.items()},
        "audit_sha256": hashlib.sha256(audit.read_bytes()).hexdigest(),
        "scope": "Mathlib-only source. The project-dependent zero sum is checked separately.",
    }
    if extensions:
        result["import_sha256"] = hashlib.sha256((HERE / "AuditWeight.olean").read_bytes()).hexdigest()
    receipt = HERE / ("density-receipt.json" if density else "extensions-receipt.json" if extensions else "receipt.json")
    receipt.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(log.read_text(encoding="utf-8"))
    return run.returncode

if __name__ == "__main__":
    raise SystemExit(main())
