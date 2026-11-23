"""Fresh-process computed-inverse-root comparison."""
import subprocess
import sys
from pathlib import Path
here = Path(__file__).resolve().parent
for index in range(1, 4):
    label = f"cpu_generated_inverse64_{index:02}"
    status = subprocess.run([sys.executable, str(here / "run_replay.py"),
        "CpuRawGeneratedInverseRoots64.lean", label]).returncode
    if status:
        sys.exit(status)
