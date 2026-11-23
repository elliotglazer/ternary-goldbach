"""Validate the complete graph, root theorems, interval and replicated exports."""
import hashlib
import json
import re
import statistics
from pathlib import Path
H=Path(__file__).resolve().parent
fixture=json.loads((H/'batch_fixture.json').read_text())
original=json.loads((H.parent/'finite-lean/fixture1024.json').read_text())
coverage=json.loads((H/'cover_fixture.json').read_text())
data=(H/'BatchData.sml').read_text()
assert hashlib.sha256(data.encode()).hexdigest()==fixture['batch_data_sha256']
body=data.split('val certificates = [\n')[1].split('];\nval all_roots')[0]
parsed=[]
for line in body.splitlines():
    m=re.fullmatch(r'\("(\d+)","(\d+)",\[([\d",]*)\]\),?',line)
    assert m,line
    parsed.append((int(m[1]),int(m[2]),list(map(int,re.findall(r'"(\d+)"',m[3])))))
expected=[(c['prime'],c['base'] or 0,[q for q,e in c['factors'] for _ in range(e)])
          for c in sorted(original['certificates'],key=lambda c:c['prime'])]
assert parsed==expected
assert len(parsed)==1537 and sum(len(fs) for _,_,fs in parsed)==7614
roots=list(map(int,re.findall(r'"(\d+)"',data.split('val all_roots = ')[1])))
assert roots==original['roots']==fixture['roots']
allowed={'bool.ETA_AX','bool.SELECT_AX','bool.INFINITY_AX','bool.BOOL_CASES_AX'}
controls=['empty_tree','wrong_origin','missing_witness','wrong_endpoint',
          'certificate_bad_base','certificate_wrong_product','certificate_missing_factor',
          'certificate_self_reference','certificate_composite']
def read_run(label):
    text=(H/f'batch_cover_run{label}.log').read_text(encoding='utf-8')
    assert 'HOL4_BATCH_COVER_BENCHMARK_DONE' in text
    assert re.search(r'Exception-|error:|Uncaught exception',text,re.I) is None
    assert list(map(int,re.findall(r'^HOL4_BATCH_ROOT,(\d+)$',text,re.M)))==roots
    assert re.findall(r'^HOL4_COVER_REJECTED,(.+)$',text,re.M)==controls
    assert set(re.search(r'^HOL4_COVER_AXIOMS,(.+)$',text,re.M)[1].split(';'))==allowed
    assert tuple(map(int,re.search(r'^HOL4_COVER_INTERVAL,(\d+),(\d+),(\d+)$',text,re.M).groups()))==(
        coverage['target'],coverage['end_exclusive'],coverage['width'])
    times={name:dict(cpu_seconds=float(cpu),wall_seconds=float(wall))
           for name,cpu,wall in re.findall(r'^HOL4_COVER_TIME,([^,]+),([\d.]+),([\d.]+)$',text,re.M)}
    proc=(H/f'batch_cover_run{label}.time').read_text()
    assert '\tExit status: 0' in proc
    artifact=(H/f'batch_cover_sample{label}.dat').read_bytes()
    return dict(sample=label,times=times,
                phase_cpu_seconds=sum(x['cpu_seconds'] for x in times.values()),
                process_cpu_seconds=sum(float(re.search(rf'{n} time \(seconds\): ([\d.]+)',proc)[1]) for n in ('User','System')),
                peak_rss_kib=int(re.search(r'Maximum resident set size \(kbytes\): (\d+)',proc)[1]),
                export_bytes=len(artifact),export_sha256=hashlib.sha256(artifact).hexdigest())
initial=read_run('1')
runs=[read_run(f'r{i}') for i in (1,2,3)]
assert len({r['export_sha256'] for r in runs})==1
expected_phases={'certificate_translation','batch_primality','prime_tree','root_translation',
                 'root_claims','root_projection','input_translation','coverage','interval_assembly','export'}
assert all(set(r['times'])==expected_phases for r in runs)
medians={phase:{metric:statistics.median(r['times'][phase][metric] for r in runs)
                for metric in ('cpu_seconds','wall_seconds')}
         for phase in runs[0]['times']}
baseline=json.loads((H/'COVER_RESULTS.json').read_text())
out=dict(passed=True,scope='Full 1537-node certificate graph, all 393 individual root theorems, closed 1024-target interval',
         interval=[coverage['target'],coverage['end_exclusive']],
         nodes=1537,expanded_factors=7614,root_primes=393,controls_per_run=len(controls),
         axioms=sorted(allowed),exports_identical=True,runs=runs,
         medians=medians,initial_separate_root_run=initial,
         median_phase_cpu_seconds=statistics.median(r['phase_cpu_seconds'] for r in runs),
         median_process_cpu_seconds=statistics.median(r['process_cpu_seconds'] for r in runs),
         baseline_primality_cpu_seconds=baseline['balanced_medians']['all_primes']['cpu_seconds'],
         primality_phase_speed_ratio=baseline['balanced_medians']['all_primes']['cpu_seconds']/medians['batch_primality']['cpu_seconds'],
         source_hashes={name:hashlib.sha256((H/name).read_bytes()).hexdigest() for name in
             ('BatchPrimeScript.sml','BatchRootsScript.sml','batchrootscoverbench.sml','BatchData.sml','CoverData.sml')},
         limitations=['HOL4 acceptance; no stock-Lean or ordinary-PA-MM0 transfer demonstrated',
                      'The primality phase ratio excludes input translation and semantic assembly',
                      'No full finite range, dense prime ladder or spectral certificate',
                      'Small interval costs cannot be extrapolated per target without sharing and block-size models'])
(H/'BATCH_RESULTS.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:out[k] for k in ('passed','medians','median_phase_cpu_seconds','median_process_cpu_seconds','primality_phase_speed_ratio')}))
