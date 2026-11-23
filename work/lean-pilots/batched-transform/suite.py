"""Historical exploration, including the expected flat-256 recursion failure.
Use reproduce.py for the successful final configuration and fresh log labels.
"""
from pathlib import Path
import subprocess, sys

HERE=Path(__file__).resolve().parent
def run(*args):
    subprocess.run([sys.executable,*map(str,args)],check=True)

for p,n in [(100,64),(343,64),(415,64),(343,256)]:
    run(HERE/'generate.py',p,n)
    name=f'P{p}N{n}'
    for v in ['Data','Scalar','Batch']:
        run(HERE/'run_lean.py',f'{v}{name}.lean',f'build_{v}{name}')
    for repeat in range(3):
        # Alternate A/B order to reduce systematic warm-cache bias.
        for v in (['Scalar','Batch'] if repeat%2==0 else ['Batch','Scalar']):
            run(HERE/'run_lean.py',f'Replay{v}{name}.lean',f'timed_{v}{name}_r{repeat}')
