from pathlib import Path
import subprocess
import sys

home=Path(__file__).resolve().parent
def run(source,label):
    subprocess.run([sys.executable,str(home/'run_lean.py'),source,label],check=True)

if sys.argv[1]=='build':
    run('PackedLoader.lean','packed_loader_final')
    for n in [8,16,32,64]:
        run(f'LoadedPackedDataN{n}.lean',f'loaded_packed_data_{n}')
        run(f'PackedLoadedP343N{n}.lean',f'loaded_packed_proof_{n}')
    run('NatRowsDataN64.lean','scalar_data_64')
    run('NatScalarP343N64.lean','packed_build_NatScalar_64')
    run('LoadedPackedAudit.lean','loaded_packed_audit')
elif sys.argv[1]=='replay':
    for sample in range(3):
        for n in [8,16,32,64]:
            for variant in ['PackedLoaded','NatScalar']:
                run(f'Replay{variant}P343N{n}.lean',f'packed_replay_{variant}_{n}_sample{sample}')
else:
    raise SystemExit('mode must be build or replay')
