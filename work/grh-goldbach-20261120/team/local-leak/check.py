"""Check one local leakage module using the existing read-only Lean 4.35 cache."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

directory = Path(__file__).resolve().parent
packages = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
compiler = "C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe"
module = sys.argv[1]
if module not in {"LocalLeak", "ShiftCount", "LeakNumeric", "LeakExchange", "GaussianSource", "LeakBound", "LeakOutside"}:
    raise SystemExit("Unknown leakage module")
env = os.environ.copy()
env["LEAN_PATH"] = os.pathsep.join(
    [str(directory)] + [str(p / ".lake/build/lib/lean") for p in packages.iterdir() if p.is_dir()]
)
source = directory / (module + ".lean")
args = [compiler, "-t0", "-j1", "-M4096", "-o", module + ".olean", source.name]
started = time.monotonic()
with (directory / (module + ".log")).open("wb") as log:
    result = subprocess.run(args, cwd=directory, env=env, timeout=600,
                            stdout=log, stderr=subprocess.STDOUT)
receipt = {
    "exit": result.returncode,
    "elapsed_seconds": time.monotonic() - started,
    "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
    "args": args
}
(directory / (module + ".json")).write_text(json.dumps(receipt, indent=2), encoding="utf-8")
print((directory / (module + ".log")).read_text(encoding="utf-8"))
print(json.dumps(receipt))
sys.exit(result.returncode)
