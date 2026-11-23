"""Rebuild successful proof modules and rerun measurements, without dependencies.

Usage: python reproduce.py unique_label
The label prevents overwriting existing logs/receipts. Project-owned oleans are
rebuilt by direct Lean invocation; no Lake clean/build or cache mutation occurs.
"""
from pathlib import Path
import subprocess,sys
H=Path(__file__).resolve().parent
label=sys.argv[1]
assert label.isidentifier()
def run(module,suffix):
    subprocess.run([sys.executable,str(H/'run_lean.py'),module+'.lean',label+'_'+suffix],check=True)

modules=['StageCheck','StageFast','StageReal','Replay']
for p in [100,343,415]:
    case=f'P{p}N64'
    modules.extend(['Data'+case,'Scalar'+case,'Batch'+case])
modules.extend(v+'P343N64' for v in ['Fast','FastScalar','Chunk8','Chunk16','Chunk32'])
modules.extend(['DataP343N256','TreeDataP343N256','TreeChunk16P343N256','TreeBinding',
                'LegacyP0N4','CondensedP0N4','CertifiedReal','Controls','AxiomAudit'])
for module in modules:
    run(module,'build_'+module)

cases=[v+f'P{p}N64' for p in [100,343,415] for v in ['Scalar','Batch']]
cases += [v+'P343N64' for v in ['Fast','FastScalar','Chunk8','Chunk16','Chunk32']]
cases += ['TreeChunk16P343N256','LegacyP0N4','CondensedP0N4']
for r in range(3):
    for case in (cases if r%2==0 else list(reversed(cases))):
        run('Replay'+case,f'timed_{case}_r{r}')
