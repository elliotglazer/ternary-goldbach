from pathlib import Path
import hashlib
import json
import re
import statistics

home = Path(__file__).resolve().parent

def timing(name):
    text = (home / (name + '.time')).read_text()
    assert re.search(r'Exit status:\s+0\s*$', text)
    def value(label):
        return float(re.search(re.escape(label) + r':\s+([0-9.]+)', text)[1])
    elapsed = re.search(r'Elapsed \(wall clock\) time .*:\s+(.+)', text)[1].strip()
    fields = re.findall(r'([0-9.]+)(h|m|s)', elapsed)
    if fields:
        wall = sum(float(n) * {'h': 3600, 'm': 60, 's': 1}[unit]
                   for n, unit in fields)
    else:
        wall = 0
        for field in elapsed.split(':'):
            wall = 60 * wall + float(field)
    return {'cpu_seconds_including_children': value('User time (seconds)') +
                value('System time (seconds)'),
            'wall_seconds': wall, 'peak_rss_kib': value('Maximum resident set size (kbytes)')}

def sample(variant, number):
    name = f'{variant}_sample_{number}'
    log = (home / (name + '.log')).read_text()
    assert 'Closed under the global context' in log
    assert not re.search(r'falling back|Error:|Anomaly:', log, re.I)
    transactions = re.findall(r'Finished transaction in ([0-9.]+) secs '
        r'\(([0-9.]+)u,([0-9.]+)s\) \(successful\)', log)
    assert len(transactions) == 2, transactions
    result = timing(name)
    result['transactions'] = [{'wall_seconds': float(w),
        'parent_cpu_seconds': float(u) + float(s)} for w, u, s in transactions]
    if variant == 'native':
        phases = re.findall(r'native_compute: (.+?) done in ([0-9.]+)', log)
        assert len(phases) == 4
        result['native_phase_wall_seconds'] = {phase: float(seconds) for phase, seconds in phases}
    return result

result = {'rocq_version': '9.0.0', 'ocaml_version': '4.14.2',
    'fixture': 'P343N64', 'native_enabled': 'ondemand',
    'native': [sample('native', i) for i in range(1, 4)],
    'vm': [sample('vm', i) for i in range(1, 4)],
    'data_build': timing('data_p343'), 'theory_build': timing('theory'),
    'negative_controls': timing('native_controls')}
controls = (home / 'native_controls.log').read_text()
assert controls.count('Closed under the global context') == 5
assert not re.search(r'Error:|Anomaly:|falling back', controls, re.I)
result['controls'] = ['valid', 'rounding', 'missing', 'reordered', 'coefficient']
result['medians'] = {}
for variant in ['native', 'vm']:
    samples = result[variant]
    result['medians'][variant] = {
        key: statistics.median(s[key] for s in samples)
        for key in ['cpu_seconds_including_children', 'wall_seconds', 'peak_rss_kib']}
    result['medians'][variant]['qed_parent_cpu_seconds'] = statistics.median(
        s['transactions'][1]['parent_cpu_seconds'] for s in samples)
result['medians']['native']['evaluation_wall_seconds'] = statistics.median(
    s['native_phase_wall_seconds']['Evaluation'] for s in result['native'])
result['medians']['native']['compilation_wall_seconds'] = statistics.median(
    s['native_phase_wall_seconds']['Compilation'] for s in result['native'])
result['independent_check_complete'] = False
if (home / 'independent.time').exists() and re.search(
        r'Exit status:\s+0\s*$', (home / 'independent.time').read_text()):
    independent = (home / 'independent.time').read_text()
    for marker in ['Axioms: <none>', 'type-in-type: <none>',
                   'unsafe (co)fixpoints: <none>', 'positivity is assumed: <none>']:
        assert marker in independent, marker
    result['independent_check'] = timing('independent')
    result['independent_check_complete'] = True
names = ['StageCheck.v', 'DataP343N64.v', 'NativeP343N64.v', 'NativeP343N64.vo',
    'VmP343N64.v', 'VmP343N64.vo', 'NativeControls.v', 'NativeControls.vo',
    'run_measurements.sh', 'native_manifest.json']
result['artifacts'] = {name: {'bytes': (home / name).stat().st_size,
    'sha256': hashlib.sha256((home / name).read_bytes()).hexdigest()} for name in names}
result['measurement_files'] = {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
    for p in sorted(home.glob('*sample_*.*')) if p.suffix in ['.log', '.time']}
for name in ['independent.log', 'independent.time', 'native_controls.log', 'native_controls.time']:
    result['measurement_files'][name] = hashlib.sha256((home / name).read_bytes()).hexdigest()
(home / 'RESULTS.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({'medians': result['medians'],
    'independent_check_complete': result['independent_check_complete']}, indent=2))
