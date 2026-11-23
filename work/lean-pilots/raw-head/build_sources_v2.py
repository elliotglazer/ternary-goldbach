"""Bounded sequential source builds after protocol and aggregation repairs."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
sample = run("RawLogCases64.lean", "logcases64_05")
run("RawReplay.lean", "rawreplay02")
run("RawInverseRootProducer.lean", "invproducer01")
horner = run("RawExpHorner.lean", "exphorner02")
run("RawStepAssembly.lean", "stepassembly01")
if horner == 0:
    run("RawExpInteger.lean", "expinteger01")
if sample == 0:
    run("AuditRawSources.lean", "sourceaudit02")
