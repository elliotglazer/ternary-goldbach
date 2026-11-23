"""Add a measurement-only FFI branch; keep the compiled prover assembly intact."""
from pathlib import Path
import json,subprocess,hashlib,time
H=Path(__file__).resolve().parent
base=json.loads((H/'build.json').read_text())
cmd=base['command'].copy()
source=next(Path(x) for x in cmd if x.endswith('basis_ffi.c'))
text=source.read_text().replace('#include <stdio.h>','#include <stdio.h>\n#include <time.h>')
old='  if (strcmp(c, "chdir") == 0) {'
new='''  if (strcmp((char *)c, "bench_time") == 0) {
    struct timespec cpu, wall;
    assert(alen > 0 && memchr(a, 0, alen) != NULL);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &cpu);
    clock_gettime(CLOCK_MONOTONIC, &wall);
    fprintf(stderr, "CANDLE_TIME,%s,%.9f,%.9f\\n", a,
            cpu.tv_sec + cpu.tv_nsec*1e-9, wall.tv_sec + wall.tv_nsec*1e-9);
    fflush(stderr);
  } else if (strcmp(c, "chdir") == 0) {'''
assert text.count(old)==1
target=source.with_name('basis_ffi_timed.c');target.write_text(text.replace(old,new))
cmd[cmd.index(str(source))]=str(target)
cmd[-1]=str(source.parent/'cake-timed')
start=time.perf_counter();p=subprocess.run(cmd,capture_output=True,text=True)
(H/'build_timed.log').write_text(p.stdout+p.stderr)
record=dict(command=cmd,exit_code=p.returncode,wall_seconds=time.perf_counter()-start,
            instrumentation='clock timestamps only, no theorem or checker modifications')
if not p.returncode:record['binary_sha256']=hashlib.sha256(Path(cmd[-1]).read_bytes()).hexdigest()
(H/'build_timed.json').write_text(json.dumps(record,indent=2)+'\n')
print(json.dumps(record));p.check_returncode()
