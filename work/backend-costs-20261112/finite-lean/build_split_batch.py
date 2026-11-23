import subprocess
import sys
from pathlib import Path
H=Path(__file__).resolve().parent
jobs=[('BatchPrime.lean','batchprime02')]
jobs += [(p.name,'batchvalid_'+p.stem[-2:]) for p in sorted(H.glob('BatchValidPart*.lean'))]
jobs += [('BatchBlock1024.lean','batchblock02'),('AuditBatch1024.lean','batchaudit01'),
         ('ReplayBatchFull1024.lean','batchfull_sample1')]
for source,label in jobs:
    subprocess.run([sys.executable,str(H/'run_lean.py'),source,label],check=True)
