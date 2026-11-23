"""Finish the bounded batch pilot; do not rebuild its data or certificate modules."""
import subprocess
import sys
from pathlib import Path

here = Path(__file__).resolve().parent
jobs = [("BatchControls1024.lean", "batchcontrols01")]
jobs += [("ReplayBatchFull1024.lean", f"batchfull_sample{i}") for i in (2, 3)]
jobs += [(f"ReplayBatch{part}1024.lean", f"batch{part.lower()}_sample{i}")
         for part in ("Primality", "Roots", "Cover") for i in (1, 2, 3)]
for source, label in jobs:
    subprocess.run([sys.executable, str(here / "run_lean.py"), source, label], check=True)
