"""Finish step sources and audit the inverse-root comparison, sequentially."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
integer = run("RawExpInteger.lean", "expinteger04")
if integer == 0:
    step = run("RawStepProducer.lean", "stepproducer01")
    if step == 0:
        run("AuditRawExtended.lean", "extendedaudit01")
run("AuditRawGenerated.lean", "generatedaudit01")
