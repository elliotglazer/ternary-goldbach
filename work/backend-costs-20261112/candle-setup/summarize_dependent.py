"""Require three clean mathematical runs, exact coordinates and valid exports.

The S-expression audit is structural, not a second logical checker. Logical
acceptance is Candle's kernel-controlled export under its execution contract.
"""
from collections import Counter
from pathlib import Path
import csv
import gzip
import hashlib
import json
import re
import shutil
import statistics
import time

home = Path(__file__).resolve().parent
source = home.parent/'hol4-setup/dependent_fixture.json'
data = json.loads(source.read_text())
pin = json.loads((home/'dependent_fixture_pin.json').read_text())


def digest(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


assert digest(source) == pin['sha256']
assert digest(home/'dependent_fixture.ml') == pin['generated_sha256']
expected = {'inputs': data['inputs'], 'coefficients': data['coefficients']}
expected.update({str(case['butterflies']): case['output'] for case in data['cases']})
required = ['ENCODING_SOUND_DONE', 'DEPENDENT_ARITHMETIC_SOUND_DONE',
            'DEPENDENT_NETWORK_DEFINITIONS_DONE', 'DEPENDENT_NETWORK_SOUND_DONE',
            'DEPENDENT_MATHEMATICAL_RESULTS_DONE', 'COMPACT_PROOF_DONE',
            'COMPACT_EXPORT_DONE', 'DEPENDENT_EXPORT_DONE', 'DEPENDENT_REPRODUCTION_DONE']
required += ['DEPENDENT_REJECTED,'+name for name in data['controls']]
required += [f'DEPENDENT_ACCEPTED,{case["butterflies"]},{sample}'
             for case in data['cases'] for sample in range(3)]
artifacts = set()
processes = []


def resource(profile, key):
    match = re.search(r'^\s*'+re.escape(key)+r':\s*(.+)$', profile, re.M)
    assert match, key
    return match.group(1)


for fresh in range(3):
    prefix = f'dependent_sample_{fresh}'
    status = int((home/(prefix+'.exit')).read_text())
    assert status == 0, (fresh, status)
    log = (home/(prefix+'.log')).read_text(encoding='utf-8', errors='strict')
    assert not re.search(r'^(ERROR:|EXCEPTION:)|Program exited with nonzero', log, re.M)
    assert all(marker in log for marker in required), fresh
    profile = (home/(prefix+'.time')).read_text()
    assert resource(profile, 'Exit status') == '0'
    events = {}
    for label, cpu, wall in re.findall(r'CANDLE_TIME,([^,\r\n]+),([0-9.]+),([0-9.]+)', log):
        assert label not in events
        events[label] = (float(cpu), float(wall))
    intervals = {}
    labels = ['dependent_inputs', 'compact_conclusion', 'compact_export']
    labels += [f'dependent_{case["butterflies"]}_sample{sample}'
               for case in data['cases'] for sample in range(3)]
    for label in labels:
        start, end = events[label+'_start'], events[label+'_end']
        assert end[0] > start[0] and end[1] > start[1]
        intervals[label] = {'cpu_seconds': end[0]-start[0], 'wall_seconds': end[1]-start[1]}

    actual = {key: [] for key in expected}
    with (home/(prefix+'.coordinates.csv')).open(newline='') as stream:
        for label, index, rp, rn, ip, inn in csv.reader(stream):
            assert label in actual and int(index) == len(actual[label])
            values = [int(rp), int(rn), int(ip), int(inn)]
            assert min(values) >= 0
            actual[label].append([values[0]-values[1], values[2]-values[3]])
    assert actual == expected, fresh
    export = home/(prefix+'.sexp')
    with export.open('rb') as stream:
        header = stream.read(100)
    assert header.startswith(b'# The following is a theorem of higher-order logic')
    assert b'(Sequent ()' in header
    processes.append({'fresh_process': fresh, 'exit_status': status,
                      'all_markers_present': True, 'exact_coordinate_comparison': True,
                      'user_cpu_seconds': float(resource(profile, 'User time (seconds)')),
                      'system_cpu_seconds': float(resource(profile, 'System time (seconds)')),
                      'whole_wall_display': resource(profile, 'Elapsed (wall clock) time (h:mm:ss or m:ss)'),
                      'peak_rss_kib': int(resource(profile, 'Maximum resident set size (kbytes)')),
                      'intervals': intervals, 'export_bytes': export.stat().st_size,
                      'export_sha256': digest(export)})
    artifacts.update(prefix+'.'+ext for ext in ['exit','time','log','sexp','coordinates.csv'])

assert len({p['export_sha256'] for p in processes}) == 1
export = home/'dependent_sample_0.sexp'
tokens = re.compile(rb'"(?:\\.|[^"\\])*"|[()]|[^\s()]+')
depth = 0
maximum_depth = 0
expect_kind = False
kinds = Counter()
allowed = {b'Sequent',b'ConstSpec',b'TypeDefn',b'NewType',b'NewConst',b'NewAxiom'}
start = time.process_time()
with export.open('rb') as stream:
    for line in stream:
        if line.lstrip().startswith(b'#'):
            continue
        for match in tokens.finditer(line):
            token = match.group()
            if token == b'(':
                if depth == 0:
                    expect_kind = True
                depth += 1
                maximum_depth = max(maximum_depth, depth)
            elif token == b')':
                assert depth > 0 and not expect_kind
                depth -= 1
            else:
                assert depth > 0
                if expect_kind:
                    assert token in allowed
                    kinds[token.decode()] += 1
                    expect_kind = False
assert depth == 0 and not expect_kind
assert kinds['Sequent'] == 1 and kinds['NewAxiom'] == 3
structure_cpu = time.process_time()-start
compressed = export.with_suffix('.sexp.gz')
start = time.process_time()
with export.open('rb') as inp, compressed.open('wb') as out:
    with gzip.GzipFile(filename='', mode='wb', fileobj=out, mtime=0) as zipped:
        shutil.copyfileobj(inp, zipped, length=1024*1024)
compression_cpu = time.process_time()-start
with gzip.open(compressed, 'rb') as stream:
    assert hashlib.file_digest(stream, 'sha256').hexdigest() == processes[0]['export_sha256']
artifacts.add(compressed.name)

hol = json.loads((home.parent/'hol4-setup/DEPENDENT_RESULTS.json').read_text())
lean = json.loads((home.parent/'lean-dependent/RESULTS.json').read_text())
assert hol['passed'] and lean['passed']
cases = []
for case in data['cases']:
    n = case['butterflies']
    samples = [p['intervals'][f'dependent_{n}_sample{k}']['cpu_seconds']
               for p in processes for k in range(3)]
    median = statistics.median(samples)
    h = next(c for c in hol['cases'] if c['butterflies'] == n)
    l = next(c for c in lean['cases'] if c['butterflies'] == n)
    cases.append({'depth': case['depth'], 'butterflies': n,
                  'candle_acceptance_cpu_samples_seconds': samples,
                  'candle_acceptance_cpu_median_seconds': median,
                  'native_cpu_median_seconds': h['native_cpu_median'],
                  'hol_cpu_median_seconds': h['hol_cpu_median'],
                  'lean_kernel_elapsed_median_seconds': l['lean_kernel_wall_median_seconds'],
                  'candle_native_ratio': median/h['native_cpu_median'],
                  'lean_candle_approximate_ratio_mixed_clocks': l['lean_kernel_wall_median_seconds']/median})

artifacts.update(['dependent_arithmetic.ml','dependent_network.ml','dependent_sound.ml',
                  'dependent_numeral_presentation.ml','dependent_fixture.ml','dependent_fixture_pin.json',
                  'dependent_export.ml','generate_dependent.py','reproduce_dependent.ml',
                  'run_dependent.sh','summarize_dependent.py','compact_export.ml',
                  'checker.ml','arithmetic_sound.ml','encoding_sound.ml','build_export.json'])
result = {
    'passed': True, 'fresh_processes': 3, 'source_fixture_sha256': pin['sha256'],
    'cases': cases, 'processes': processes, 'exports_identical': True,
    'export_audit': {'structural_only': True, 'logical_recheck': False,
                     'top_level_forms': dict(kinds), 'maximum_depth': maximum_depth,
                     'structural_cpu_seconds': structure_cpu,
                     'gzip_bytes': compressed.stat().st_size,
                     'compression_cpu_seconds': compression_cpu, 'round_trip_sha256_matches': True},
    'contract': pin['contract'],
    'limitations': [
        'Candle/HOL foundation, not a stock Lean theorem or ordinary MM0 proof.',
        'Integer decoded local residuals, length, final bound and checksum; no FFT roots, analytic source, global error or zero count.',
        'Each process times three calls per size on reused literal data; data presentation and well-formedness are separate setup.',
        'The timing includes compute, the integer soundness conclusion and an empty-hypothesis check, excluding final export.',
        'Native GMP and Candle use CPU time; Lean uses kernel-loop elapsed time on Windows.',
        'Released CakeML compiler/binary provenance and host/FFI assumptions are as documented in STATUS.md.',
        'The development export failed on unbalanced input definitions; fresh runs use proved balanced presentations.',
        'Structural and gzip audits do not logically replay the exported theorem.'],
    'artifacts': {name: {'bytes': (home/name).stat().st_size, 'sha256': digest(home/name)}
                  for name in sorted(artifacts)}}
(home/'DEPENDENT_RESULTS.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps({'passed': True, 'cases': cases, 'export_audit': result['export_audit'],
                  'setup_cpu_seconds': [p['intervals']['dependent_inputs']['cpu_seconds'] for p in processes]}, indent=2))
