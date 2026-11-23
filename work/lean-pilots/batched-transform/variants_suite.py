from pathlib import Path
import subprocess,sys
HERE=Path(__file__).resolve().parent
def run(*args): subprocess.run([sys.executable,*map(str,args)],check=True)
for p,n in [(343,64)]:
    run(HERE/'generate_variants.py',p,n)
    for v in ['Fast','FastScalar','Chunk8','Chunk16','Chunk32']:
        case=f'{v}P{p}N{n}'
        run(HERE/'run_lean.py',case+'.lean','build_'+case)
        for r in range(3):
            run(HERE/'run_lean.py','Replay'+case+'.lean',f'timed_{case}_r{r}')
