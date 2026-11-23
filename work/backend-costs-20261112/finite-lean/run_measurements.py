"""Run independent processes sequentially; any failure stops the experiment."""
import subprocess
import sys
from pathlib import Path
H=Path(__file__).resolve().parent
jobs=[('Controls1024.lean','controls1024_01')]
jobs += [('ReplayFull1024.lean',f'full1024_sample{i}') for i in (2,3)]
jobs += [(f'Replay{part.capitalize()}1024.lean',f'{part}1024_sample{i}') for part in ('source','anchors','cover') for i in (1,2,3)]
for source,label in jobs:
    subprocess.run([sys.executable,str(H/'run_lean.py'),source,label],check=True)
