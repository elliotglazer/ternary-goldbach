"""Sequential default-budget aggregation and concrete step validation."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
def run(source, label):
    return subprocess.run([sys.executable, str(here / "run_lean.py"), source, label]).returncode
sample = run("RawLogCases64.lean", "logcases64_06")
integer = run("RawExpInteger.lean", "expinteger02")
if integer == 0 and (here / "stepassembly02.json").exists():
    import json
    if json.loads((here / "stepassembly02.json").read_text())["exit_code"] == 0:
        run("RawStepProducer.lean", "stepproducer01")
if sample == 0:
    run("AuditRawSources.lean", "sourceaudit03")
