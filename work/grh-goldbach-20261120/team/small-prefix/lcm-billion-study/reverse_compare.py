from pathlib import Path
import sys,time,subprocess,json
d=Path(__file__).resolve().parent
p=d.parent
sys.path.insert(0,str(p.parent/'aws-pilot/wide'))
from run_wide import windows_stats
def metered(cmd,env,query=None,cwd=None):
    t=time.monotonic()
    pr=subprocess.Popen(cmd,env=env,cwd=cwd,stdin=subprocess.PIPE if query is not None else None,
        stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    out,_=pr.communicate(None if query is None else query.encode())
    stats=windows_stats(pr)
    if pr.returncode:raise RuntimeError(out.decode(errors='replace'))
    return dict(cpu_seconds=stats['user_seconds']+stats['system_seconds'],wall_seconds=time.monotonic()-t,output=out.decode().replace('\r\n','\n'),**stats)
s=(d/'compare.py').read_text(encoding='utf-8-sig')
s=s.replace("base=st.sources","st.run_lean=metered\nbase=st.sources").replace("('lcm','control')","('control','lcm')").replace('out=d/mode','out=d/("reverse-"+mode)')
exec(compile(s,'reverse_compare.py','exec'))
