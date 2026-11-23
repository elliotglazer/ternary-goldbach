import json
import subprocess
import sys
from pathlib import Path
H=Path(__file__).resolve().parent
width=int(sys.argv[1])
parts=json.loads((H/f'parts{width}.json').read_text())
for i,name in enumerate(parts['modules']):
    subprocess.run([sys.executable,str(H/'run_lean.py'),name+'.lean',f'part{width}_{i:02}'],check=True)
subprocess.run([sys.executable,str(H/'run_lean.py'),f'Primes{width}.lean',f'primes{width}_assembled'],check=True)
