"""Native runtime only. No proof acceptance is claimed by this experiment."""
from pathlib import Path
import json, subprocess, time, hashlib, statistics
H=Path(__file__).resolve().parent
rows=[]
for reps,bound in [(1000,1024),(10000,1024),(10000,1024),(10000,1024),(1000,0)]:
    cmd=[str(H/'NativeBaseline.exe'),str(reps),str(2**343),str(bound*2**343)]
    start=time.perf_counter()
    p=subprocess.run(cmd,capture_output=True,text=True,timeout=60,creationflags=subprocess.CREATE_NO_WINDOW)
    wall=time.perf_counter()-start
    count,accepted,ns=map(int,p.stdout.strip().split(','))
    assert count==reps and accepted==(reps if bound else 0)
    assert p.returncode==(0 if bound else 1)
    rows.append(dict(repetitions=reps,bound_multiple=bound,accepted=accepted,
                     inner_ns=ns,wall_seconds=wall,ns_per_stage=ns/reps,
                     ns_per_butterfly=ns/reps/64))
pins={name:hashlib.sha256((H/name).read_bytes()).hexdigest()
      for name in ['NativeBaseline.lean','NativeBaseline.c','NativeBaseline.exe']}
report=dict(proof_acceptance=False,rows=rows,artifact_sha256=pins,
 median_ns_per_stage=statistics.median(r['ns_per_stage'] for r in rows if r['repetitions']==10000))
(H/'native_runtime.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))
