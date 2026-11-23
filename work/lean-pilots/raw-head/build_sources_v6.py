"""Build the repaired stored step and the next actual-state helper, in order."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
step = run("RawStepProducer.lean", "stepproducer02")
if step == 0:
    run("AuditRawExtended.lean", "extendedaudit01")
product = run("RawDyadicProduct.lean", "dyadicproduct01")
if step == 0 and product == 0:
    run("RawStateProducer.lean", "stateproducer01")
