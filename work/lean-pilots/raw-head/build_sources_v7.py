"""Rebuild the mechanical cleanups and print the actual-state proof boundary."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
product = run("RawDyadicProduct.lean", "dyadicproduct02")
if product == 0:
    state = run("RawStateProducer.lean", "stateproducer02")
    if state == 0:
        run("AuditRawState.lean", "stateaudit01")
