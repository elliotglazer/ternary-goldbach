"""Prepare the audited source sample and its CPU replay support sequentially."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
sample_status = run("RawLogCases64.lean", "logcases64_03")
power_status = run("RawPowerIdentity.lean", "power05")
if power_status == 0:
    run("RawInitialization.lean", "initialization01")
if sample_status == power_status == 0:
    run("AuditRawSources.lean", "sourceaudit01")
run("RawReplay.lean", "rawreplay01")
run("RawExpTail.lean", "exptail01")
