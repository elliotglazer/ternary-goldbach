"""Finish the current helper joins; all builds remain sequential."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
run("AuditRawSources.lean", "sourceaudit04")
integer = run("RawExpInteger.lean", "expinteger03")
if integer == 0:
    step = run("RawStepProducer.lean", "stepproducer01")
    if step == 0:
        run("AuditRawExtended.lean", "extendedaudit01")
run("RawInverseRootGenerated64.lean", "invgenerated01")
