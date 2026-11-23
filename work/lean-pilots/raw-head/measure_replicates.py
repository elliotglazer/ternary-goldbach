"""Fresh-process repetitions of the fixed 64-input source certificates."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
jobs = [("CpuRawLogs64.lean", "cpu_logs64_03"),
        ("CpuRawLogs64.lean", "cpu_logs64_04"),
        ("CpuRawInverseRoots64.lean", "cpu_inverse64_01"),
        ("CpuRawInverseRoots64.lean", "cpu_inverse64_02"),
        ("CpuRawInverseRoots64.lean", "cpu_inverse64_03")]
for source, label in jobs:
    status = subprocess.run([sys.executable, str(here / "run_replay.py"), source, label]).returncode
    if status:
        sys.exit(status)
