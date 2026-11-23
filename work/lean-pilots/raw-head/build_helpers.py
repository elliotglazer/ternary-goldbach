"""Sequential initial helper checks; failures remain recorded for owner repair."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
if run("RawLogTail.lean", "logtail02") == 0:
    run("RawLogHorner.lean", "loghorner01")
run("RawPowerIdentity.lean", "power01")
run("RawRecurrence.lean", "recur01")
