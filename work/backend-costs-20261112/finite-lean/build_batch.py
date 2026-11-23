import subprocess
import sys
from pathlib import Path
H=Path(__file__).resolve().parent
for source,label in [('BatchData1024.lean','batchdata02'),('BatchBlock1024.lean','batchblock01'),
                     ('AuditBatch1024.lean','batchaudit01'),('ReplayBatchFull1024.lean','batchfull_sample1')]:
    subprocess.run([sys.executable,str(H/'run_lean.py'),source,label],check=True)
