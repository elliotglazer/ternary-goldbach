#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
sha256sum --check wide/SHA256SUMS
python3 run.py --smoke
lake exe cache get Mathlib.NumberTheory.LucasPrimality Mathlib.Data.ZMod.Basic Mathlib.Data.Nat.Bitwise Mathlib.Data.List.Prime Mathlib.Data.Nat.Prime.Factorial
python3 - <<'PY'
import json, subprocess
from pathlib import Path
for dep in json.loads(Path("lake-manifest.json").read_text())["packages"]:
    cwd=Path(".lake/packages")/dep["name"]
    def git(*args):
        return subprocess.check_output(["git",*args],cwd=cwd,text=True).strip()
    if git("rev-parse","HEAD")!=dep["rev"] or git("status","--short","--untracked-files=no"):
        raise SystemExit("dependency differs from lock: "+dep["name"])
PY
