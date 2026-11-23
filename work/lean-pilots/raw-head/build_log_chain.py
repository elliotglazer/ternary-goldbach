"""Sequential checks of the generated-source dependency chain."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
log_status = run("RawLogHorner.lean", "loghorner02")
if log_status == 0:
    log_status = run("RawLogAssembly.lean", "logassembly01")
sqrt_status = run("RawInverseRoot.lean", "invroot02")
if log_status == sqrt_status == 0:
    if run("RawLogCases.lean", "logcases01") == 0:
        run("RawSourceControls.lean", "sourcecontrols01")
run("RawPowerIdentity.lean", "power02")
