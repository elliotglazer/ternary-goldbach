"""Historical comparison driver, stopped at the flat-256 assembly failure.
Its completed Legacy/Condensed runs are valid. The successful final large-stage
configuration uses TreeChunk16, and reproduce.py runs that configuration.
"""
from pathlib import Path
import subprocess,sys
HERE=Path(__file__).resolve().parent
def run(source,label):
    subprocess.run([sys.executable,str(HERE/'run_lean.py'),source,label],check=True)

for r in range(3):
    for v in (['Legacy','Condensed'] if r%2==0 else ['Condensed','Legacy']):
        run(f'Replay{v}P0N4.lean',f'timed_{v}P0N4_r{r}')
for r in range(3):
    run('ReplayChunk16P343N256.lean',f'timed_Chunk16P343N256_r{r}')
run('CertifiedReal.lean','certified_real')
run('AxiomAudit.lean','axioms_final')
