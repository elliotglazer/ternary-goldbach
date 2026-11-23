import hashlib
import json
import re
import statistics
from pathlib import Path
H=Path(__file__).resolve().parent
fixture=json.loads((H/'fixture.json').read_text())
assert hashlib.sha256((H/'PrimeData.sml').read_bytes()).hexdigest()==fixture['prime_data_sha256']
allowed={'bool.ETA_AX','bool.SELECT_AX','bool.INFINITY_AX','bool.BOOL_CASES_AX'}
runs=[]
for i in (1,2,3):
    text=(H/f'prime_run{i}.log').read_text()
    assert 'HOL4_PRIME_BENCHMARK_DONE' in text
    accepted=[int(x) for x in re.findall(r'^HOL4_PRIME_ACCEPTED,(\d+)$',text,re.M)]
    assert accepted==fixture['roots']
    rejected=re.findall(r'^HOL4_PRIME_REJECTED,(.+)$',text,re.M)
    assert rejected==['bad_base','bad_factors','composite']
    axioms=set(re.search(r'^HOL4_PRIME_AXIOMS,(.+)$',text,re.M)[1].split(';'))
    assert axioms==allowed
    times={}
    for label,cpu,wall in re.findall(r'^HOL4_PRIME_TIME,([^,]+),([\d.]+),([\d.]+)$',text,re.M):
        times[label]={'cpu_seconds':float(cpu),'wall_seconds':float(wall)}
    assert set(times)=={'all_roots','source_roots','anchor_roots','export'}
    proc=(H/f'prime_run{i}.time').read_text()
    assert '\tExit status: 0' in proc
    data=(H/f'prime_sample{i}.dat').read_bytes()
    runs.append(dict(sample=i,times=times,export_bytes=len(data),export_sha256=hashlib.sha256(data).hexdigest(),
                     process_cpu_seconds=sum(float(re.search(rf'{name} time \(seconds\): ([\d.]+)',proc)[1]) for name in ('User','System')),
                     peak_rss_kib=int(re.search(r'Maximum resident set size \(kbytes\): (\d+)',proc)[1])))
out=dict(passed=True,scope='393 matching Lucas prime roots only; no coverage theorem in this benchmark',
         roots=393,source_roots=283,anchor_roots=110,certificate_nodes=fixture['certificate_nodes'],
         axioms=sorted(allowed),runs=runs,
         medians={label:{metric:statistics.median(r['times'][label][metric] for r in runs)
                         for metric in ('cpu_seconds','wall_seconds')}
                  for label in ('all_roots','source_roots','anchor_roots','export')},
         exports_identical=len({r['export_sha256'] for r in runs})==1,
         controls_per_run=3)
assert out['exports_identical']
(H/'PRIMALITY_RESULTS.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:out[k] for k in ('passed','medians','exports_identical')}))
