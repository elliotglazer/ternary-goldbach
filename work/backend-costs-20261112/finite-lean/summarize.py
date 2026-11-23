"""Audit completed finite-coverage runs before reporting measured components."""
import hashlib
import json
import re
import statistics
from pathlib import Path
H = Path(__file__).resolve().parent
def read(name):
    return json.loads((H / name).read_text())
def successful(name):
    result = read(name + '.json')
    assert result['exit_code'] == 0 and result['stop'] is None, name
    # Logs and source files are immutable evidence. Output oleans may have
    # been replaced by later identical-source runs and are recorded per run.
    for a in result['artifacts']:
        if a['path'].endswith(('.log', '.lean')):
            assert hashlib.sha256((H/a['path']).read_bytes()).hexdigest().upper() == a['sha256'], a['path']
    return result
fixture = read('fixture1024.json')
assert fixture['width'] == 1024
controls = successful('controls1024_01')
control_lines = (H/'controls1024_01.log').read_text().splitlines()
assert len(control_lines) == 6
assert all(re.search(r'accepted=(true|false),expected=\1$', l) for l in control_lines)
audit = successful('audit1024_01')
audit_log = (H/'audit1024_01.log').read_text()
assert 'sorryAx' not in audit_log
assert audit_log.count('[propext, Classical.choice, Quot.sound]') == 2
assert str(fixture['target']) in audit_log and str(fixture['end_exclusive']) in audit_log
phases = {}
for phase in ('full','source','anchors','cover'):
    runs = [successful(f'{phase}1024_sample{i}') for i in (1,2,3)]
    rows = [r['rows'][0] for r in runs]
    assert all(len(r['rows']) == 1 for r in runs)
    assert all(r['limits_lines'] == ['LIMITS,trust=0,heartbeats=0,recdepth=65536'] for r in runs)
    assert all(x['width'] == 1024 and x['repetitions'] == 1 for x in rows)
    assert len({x['declarations'] for x in rows}) == 1
    samples = [x['kernel_bundle_wall_ns'] / 1e9 for x in rows]
    phases[phase] = dict(kernel_elapsed_seconds=samples,
                        median_kernel_elapsed_seconds=statistics.median(samples),
                        declarations=rows[0]['declarations'],
                        median_process_cpu_seconds=statistics.median(r['cpu_seconds'] for r in runs),
                        median_process_wall_seconds=statistics.median(r['wall_seconds'] for r in runs),
                        peak_working_set_bytes=max(r['peak_working_set_bytes'] for r in runs),
                        observed_peak_private_bytes=max(r['observed_peak_private_bytes'] for r in runs))
build_labels = ['bridge02','data1024_01'] + [f'part1024_{i:02}' for i in range(13)] + ['primes1024_assembled','block1024_01']
builds = {name:successful(name) for name in build_labels}
assert successful('block1024_01')['exit_code'] == 0
source_files = [p for p in H.glob('*.lean') if not p.name.startswith(('Replay','Controls','Audit'))]
assert all(not re.search(r'\b(?:sorry|axiom|native_decide)\b', p.read_text(encoding='utf-8')) for p in source_files)
out = dict(passed=True, scope='Closed binary Goldbach interval, 1024 even targets near 4e18',
           interval=[fixture['target'], fixture['end_exclusive']],
           axioms=['propext','Classical.choice','Quot.sound'],
           source_positive_bits=fixture['source_positive_bits'], anchors=fixture['anchors'],
           prime_roots=fixture['prime_roots'], prime_nodes=fixture['prime_nodes'],
           producer_cpu_seconds=fixture['producer_cpu_seconds'],
           phases=phases, corruption_controls=5,
           project_build_cpu_seconds=sum(r['cpu_seconds'] for r in builds.values()),
           project_build_wall_seconds=sum(r['wall_seconds'] for r in builds.values()),
           build_components={n:{k:r[k] for k in ('cpu_seconds','wall_seconds')} for n,r in builds.items()},
           limitations=['No extrapolation per target without source and anchor reuse model',
                        'Generic support and input definitions imported, not timed in certificate replay',
                        'Timed kernel loops report elapsed time, not direct thread CPU',
                        'Split-module build cost includes repeated imports; dependencies are prebuilt',
                        'No full ternary Goldbach theorem or end-to-end compute estimate'],
           fixture_sha256=hashlib.sha256((H/'fixture1024.json').read_bytes()).hexdigest())
(H/'RESULTS.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:out[k] for k in ('passed','interval','phases','project_build_cpu_seconds')}))
