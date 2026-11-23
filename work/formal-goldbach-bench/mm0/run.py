import argparse,json,re,subprocess,sys,time
from pathlib import Path
ROOT=Path(__file__).resolve().parent
WIN='/mnt/host/c'+ROOT.as_posix()[2:]
TMP='/dev/shm/goldbach-mm0-bench'
def shell(s):
    p=subprocess.run(['wsl','-d','docker-desktop','--','sh','-c',s],capture_output=True,text=True)
    return p
def run_case(bits,width,n,op,repeats,reuse=False,reset=0,sparse=1):
    name=f'{op}-{bits}-{width}-{n}'+(f'-r{reset}-s{sparse}' if reset or sparse!=1 else '')
    if not reuse:
        out=subprocess.run([sys.executable,str(ROOT/'generate.py'),'--digit-bits',str(bits),'--width',str(width),'--updates',str(n),'--op',op,'--reset-every',str(reset),'--sparse-level',str(sparse),'--name',name],capture_output=True,text=True,check=True)
    meta=json.loads((ROOT/(name+'.json')).read_text())
    p=shell(f'mkdir -p {TMP} && cp {WIN}/mm0-timed {WIN}/mm0-profile {WIN}/{name}.mm0 {WIN}/{name}.mmb {TMP}/')
    assert p.returncode==0,p.stderr
    p=shell(f'cd {TMP} && for i in '+ ' '.join(map(str,range(repeats)))+f'; do ./mm0-timed {name}.mmb < {name}.mm0 || exit $?; done')
    (ROOT/(name+'.timing.log')).write_text(p.stdout+p.stderr)
    assert p.returncode==0,p.stderr
    cpu=list(map(float,re.findall(r'BENCH_CPU_SECONDS=([0-9.]+)',p.stderr)))
    p=shell(f'cd {TMP} && ./mm0-profile {name}.mmb < {name}.mm0')
    assert p.returncode==0,p.stderr
    (ROOT/(name+'.profile.log')).write_text(p.stdout+p.stderr)
    count=re.search(r'proof=(\d+) unify=(\d+)',p.stderr)
    meta['cpu_seconds']=cpu;meta['proof_ops']=int(count[1]);meta['unify_ops']=int(count[2])
    if n:
        p=shell(f'cp {WIN}/{name}-bad.mmb {TMP}/ && cd {TMP} && ./mm0-timed {name}-bad.mmb < {name}.mm0')
        meta['corrupted_exit']=p.returncode;meta['corrupted_diagnostic']=p.stderr.strip()
        assert p.returncode!=0
    (ROOT/(name+'.result.json')).write_text(json.dumps(meta,indent=2)+'\n')
    print(json.dumps({k:meta[k] for k in ['name','bytes_per_update','cpu_seconds','proof_ops','unify_ops']}),flush=True)
    return meta
if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--bits',type=int,default=8);p.add_argument('--width',type=int,default=64)
    p.add_argument('--updates',type=int,default=10000);p.add_argument('--op',default='slice-or');p.add_argument('--repeats',type=int,default=5);p.add_argument('--reuse',action='store_true');p.add_argument('--reset-every',type=int,default=0);p.add_argument('--sparse-level',type=int,default=1);a=p.parse_args()
    for n in (0,a.updates):run_case(a.bits,a.width,n,a.op,a.repeats,a.reuse,a.reset_every,a.sparse_level)
