"""Audit the completed interval comparison, including exact exported outputs."""
import hashlib
import json
import re
import statistics
from pathlib import Path
H=Path(__file__).resolve().parent
fixture=json.loads((H/'cover_fixture.json').read_text())
assert hashlib.sha256((H/'CoverData.sml').read_bytes()).hexdigest()==fixture['cover_data_sha256']
allowed={'bool.ETA_AX','bool.SELECT_AX','bool.INFINITY_AX','bool.BOOL_CASES_AX'}
labels=('all_primes','prime_tree','input_translation','coverage','interval_assembly','export')
def run(sample):
    text=(H/f'cover_run{sample}.log').read_text()
    assert 'HOL4_FINITE_COVER_BENCHMARK_DONE' in text
    assert re.search(r'ERROR|EXCEPTION|Uncaught exception|error:',text,re.I) is None
    match=re.search(r'^HOL4_COVER_INTERVAL,(\d+),(\d+),(\d+)$',text,re.M)
    assert tuple(map(int,match.groups()))==(fixture['target'],fixture['end_exclusive'],fixture['width'])
    assert re.findall(r'^HOL4_COVER_REJECTED,(.+)$',text,re.M)==[
        'empty_tree','wrong_origin','missing_witness','wrong_endpoint']
    assert set(re.search(r'^HOL4_COVER_AXIOMS,(.+)$',text,re.M)[1].split(';'))==allowed
    times={label:{'cpu_seconds':float(cpu),'wall_seconds':float(wall)}
           for label,cpu,wall in re.findall(r'^HOL4_COVER_TIME,([^,]+),([\d.]+),([\d.]+)$',text,re.M)}
    assert set(times)==set(labels)
    proc=(H/f'cover_run{sample}.time').read_text()
    assert '\tExit status: 0' in proc
    data=(H/f'cover_sample{sample}.dat').read_bytes()
    return dict(sample=sample,times=times,export_bytes=len(data),export_sha256=hashlib.sha256(data).hexdigest(),
                measured_phase_cpu_seconds=sum(v['cpu_seconds'] for v in times.values()),
                process_cpu_seconds=sum(float(re.search(rf'{name} time \(seconds\): ([\d.]+)',proc)[1]) for name in ('User','System')),
                peak_rss_kib=int(re.search(r'Maximum resident set size \(kbytes\): (\d+)',proc)[1]))
balanced=[run(i) for i in ('b1','b2','b3')]
flat=run('2')
assert len({r['export_sha256'] for r in balanced})==1
medians={label:{metric:statistics.median(r['times'][label][metric] for r in balanced)
                for metric in ('cpu_seconds','wall_seconds')}
         for label in labels}
out=dict(passed=True,scope='Complete 1024-even-target binary Goldbach interval',
         interval=[fixture['target'],fixture['end_exclusive']],width=fixture['width'],
         axioms=sorted(allowed),balanced_runs=balanced,corrected_flat_run=flat,
         balanced_medians=medians,
         balanced_median_phase_cpu_seconds=statistics.median(r['measured_phase_cpu_seconds'] for r in balanced),
         balanced_median_process_cpu_seconds=statistics.median(r['process_cpu_seconds'] for r in balanced),
         flat_to_balanced_translation_ratio=flat['times']['input_translation']['cpu_seconds']/medians['input_translation']['cpu_seconds'],
         controls_per_run=4,exports_identical=True,
         source_hashes={name:hashlib.sha256((H/name).read_bytes()).hexdigest() for name in
           ('FiniteCoverScript.sml','coverbench.sml','coverbench_balanced.sml','CoverData.sml','PrimeData.sml')},
         limitations=['HOL4 axioms and evaluator, not stock Lean or ordinary PA MM0',
                      'One flat layout sample; three fresh balanced samples',
                      'Library and executable construction excluded from phase totals',
                      'Existing native witness producer has no proof authority',
                      'No full finite range, prime ladder or spectral result'])
(H/'COVER_RESULTS.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:out[k] for k in ('passed','balanced_medians','balanced_median_phase_cpu_seconds','balanced_median_process_cpu_seconds','flat_to_balanced_translation_ratio')}))
