"""Sequential bounded processes; stop on any failed proof or replay."""
from pathlib import Path
import subprocess
import sys

home=Path(__file__).resolve().parent
mode=sys.argv[1]

def run(source,label):
    subprocess.run([sys.executable,str(home/'run_lean.py'),source,label],check=True)

if mode=='build':
    for n in [64,512,2048,8192]:
        run(f'BlockP343N{n}.lean',f'build_block_{n}')
    run('DependentControls.lean','controls_build')
    run('AxiomAudit.lean','axiom_audit')
elif mode=='replay':
    for sample in range(3):
        for n in [64,512,2048,8192]:
            run(f'ReplayBlockP343N{n}.lean',f'replay_block_{n}_sample{sample}')
else:
    raise SystemExit('mode must be build or replay')
