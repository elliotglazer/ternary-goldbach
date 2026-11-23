"""Finish the source component chain after bounded local proof corrections."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
if run("RawLogHorner.lean", "loghorner03") == 0:
    if run("RawLogAssembly.lean", "logassembly02") == 0:
        if run("RawLogCases.lean", "logcases01") == 0:
            run("RawSourceControls.lean", "sourcecontrols01")
run("RawRecurrence.lean", "recur02")
