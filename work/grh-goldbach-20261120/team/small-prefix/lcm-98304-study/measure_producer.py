from pathlib import Path
import sys,subprocess,json,time,hashlib
d=Path(__file__).resolve().parent
sys.path.insert(0,str(d.parent.parent/'aws-pilot/wide'))
from run_wide import windows_stats
py=Path.home()/'.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe'
t=time.monotonic()
r=subprocess.Popen([str(py),str(d/'generate_lcm.py'),'8','--width','98304','--halo','2048','--out',str(d/'repeat')],stdout=subprocess.PIPE)
log,_=r.communicate()
stat=dict(exit=r.returncode,wall_seconds=time.monotonic()-t,**windows_stats(r))
assert r.returncode==0 and (d/'repeat/Power8.lean').read_bytes()==(d/'Power8.lean').read_bytes()
(d/'producer-direct.json').write_text(json.dumps(stat,indent=2))
print(stat)

