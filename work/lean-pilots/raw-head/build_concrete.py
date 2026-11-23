"""Validate the concrete analytic exports before replay measurements."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
if run("RawLogCases.lean", "logcases02") == 0:
    run("RawSourceControls.lean", "sourcecontrols01")
    run("RawLogCases64.lean", "logcases64_01")
run("RawPowerIdentity.lean", "power03")
run("RawRecurrence.lean", "recur03")
