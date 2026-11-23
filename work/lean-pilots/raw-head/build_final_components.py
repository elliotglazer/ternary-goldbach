"""Finish source aggregation and the exact analytic initialization join."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
run("RawLogCases64.lean", "logcases64_02")
if run("RawPowerIdentity.lean", "power04") == 0:
    run("RawInitialization.lean", "initialization01")
