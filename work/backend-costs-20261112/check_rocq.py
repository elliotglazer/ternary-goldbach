"""Independent full dependency check, with a bounded runtime."""
from pathlib import Path
import subprocess,time,json,hashlib
H=Path(__file__).resolve().parent
cmd=['C:/Users/glaze/AppData/Local/RocqPlatform/9.1.0/bin/rocqchk.exe',
     '-silent','-o','-m','-bytecode-compiler','yes','VmP343N64','Controls']
begin=time.perf_counter()
with (H/'rocq_independent.log').open('x') as log:
    p=subprocess.Popen(cmd,cwd=H,stdout=log,stderr=subprocess.STDOUT,
                       creationflags=subprocess.CREATE_NO_WINDOW)
    try:rc=p.wait(timeout=120)
    except subprocess.TimeoutExpired:p.kill();p.wait();rc=-999
result=dict(command=cmd,exit_code=rc,wall_seconds=time.perf_counter()-begin,
            admits=False,log_sha256=hashlib.sha256((H/'rocq_independent.log').read_bytes()).hexdigest())
(H/'rocq_independent.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result))
print((H/'rocq_independent.log').read_text()[-4000:])
