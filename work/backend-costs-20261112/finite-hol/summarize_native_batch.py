import hashlib
import json
import re
import statistics
from pathlib import Path
H=Path(__file__).resolve().parent
original=json.loads((H.parent/'finite-lean/fixture1024.json').read_text())
coverage=json.loads((H/'cover_fixture.json').read_text())
tokens=list(map(int,(H/'native_batch_data.txt').read_text().split()));pos=0
def take():
    global pos
    x=tokens[pos];pos+=1;return x
count=take();assert count==1537
parsed=[]
for _ in range(count):
    p,a,n=take(),take(),take();parsed.append((p,a,[take() for _ in range(n)]))
expected=[(c['prime'],c['base'] or 0,[q for q,e in c['factors'] for _ in range(e)])
          for c in sorted(original['certificates'],key=lambda c:c['prime'])]
assert parsed==expected
n=take();assert [take() for _ in range(n)]==original['roots']
assert (take(),take(),take())==(coverage['target'],coverage['end_exclusive'],coverage['width'])
assert [[take(),take()] for _ in range(coverage['width'])]==coverage['witnesses']
assert pos==len(tokens)
assert '\tExit status: 0' in (H/'native_batch_build.time').read_text()
runs=[]
for i in (1,2,3):
    log=(H/f'native_batch_run{i}.log').read_text()
    assert 'NATIVE_BATCH_DONE' in log and 'NATIVE_BATCH_CONTROLS_PASSED' in log
    assert '\tExit status: 0' in (H/f'native_batch_run{i}.time').read_text()
    rows={phase:dict(repetitions=int(reps),cpu_seconds=float(cpu),wall_seconds=float(wall))
          for phase,reps,cpu,wall in re.findall(r'^NATIVE_BATCH_TIME,([^,]+),(\d+),([\d.]+),([\d.]+)$',log,re.M)}
    assert set(rows)=={'primality','coverage'} and all(x['repetitions']==500 for x in rows.values())
    runs.append(dict(sample=i,times=rows,input_cpu_seconds=float(re.search(r'NATIVE_BATCH_INPUT_CPU,([\d.]+)',log)[1])))
medians={phase:{metric:statistics.median(r['times'][phase][metric] for r in runs)
                for metric in ('cpu_seconds','wall_seconds')} for phase in ('primality','coverage')}
hol=json.loads((H/'BATCH_RESULTS.json').read_text())
out=dict(passed=True,scope='Untrusted native reference; no theorem acceptance',runs=runs,medians=medians,
         hol_primality_over_native_ratio=hol['medians']['batch_primality']['cpu_seconds']/medians['primality']['cpu_seconds'],
         input_identities_checked=True,
         artifacts={name:hashlib.sha256((H/name).read_bytes()).hexdigest() for name in
                    ('native_batch_data.txt','native_batch.cpp','native_batch')})
(H/'NATIVE_BATCH_RESULTS.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:out[k] for k in ('passed','medians','hol_primality_over_native_ratio')}))
