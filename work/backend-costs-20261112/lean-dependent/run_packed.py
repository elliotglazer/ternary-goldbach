from pathlib import Path
import subprocess
import sys

home=Path(__file__).resolve().parent
def run(source,label):
    subprocess.run([sys.executable,str(home/'run_lean.py'),source,label],check=True)

if sys.argv[1]=='build':
    run('PackedProbe.lean','packed_theory')
    for n in [8,16,32,64]:
        run(f'PackedDataN{n}.lean',f'packed_data_{n}')
        for variant in ['Packed','NatScalar']:
            run(f'{variant}P343N{n}.lean',f'packed_build_{variant}_{n}')
    run('PackedAudit.lean','packed_audit')
elif sys.argv[1]=='replay':
    for sample in range(3):
        for n in [8,16,32,64]:
            for variant in ['Packed','NatScalar']:
                run(f'Replay{variant}P343N{n}.lean',f'packed_replay_{variant}_{n}_sample{sample}')
else:
    raise SystemExit('mode must be build or replay')
