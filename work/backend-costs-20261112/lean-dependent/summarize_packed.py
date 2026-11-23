"""Audit completed loaded-literal and ordinary-kernel arithmetic probes.

This does not certify the unimplemented positional-digit bridge. It verifies
that the measured theorem, exact imported data and recorded samples agree.
"""
from pathlib import Path
import hashlib
import json
import re
import statistics

home = Path(__file__).resolve().parent
artifacts = set()


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(label):
    rec = json.loads((home / (label + '.json')).read_text())
    log = (home / (label + '.log')).read_text(encoding='utf-8')
    assert rec['exit_code'] == 0 and rec['stop'] is None, label
    assert rec['no_native_decide'] and not rec['dependency_builds'], label
    assert not re.search(r'error:|declaration uses .sorry.|failed', log), label
    for entry in rec['artifacts']:
        path = home / entry['path']
        if path.suffix != '.olean':
            assert digest(path) == entry['sha256'].lower(), (label, path.name)
        artifacts.add(path.name)
    artifacts.update([label + '.json', label + '.log'])
    return rec, log


pin = json.loads((home / 'packed_fixture_pin.json').read_text())
source = home.parents[1] / 'lean-pilots/batched-transform/P343N64.json'
assert digest(source) == pin['source_sha256']
original = json.loads(source.read_text())['rows']
theory, _ = read('packed_theory')
loader, _ = read('packed_loader_auditfix')
audit, audit_log = read('loaded_packed_audit02')
assert audit_log.count('Dumped the actual imported Nat declaration values.') == 4
assert 'CONTROL,loadedPackedBad,accepted=false,expected=false' in audit_log
axioms = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]", audit_log)
assert len(axioms) == 8
assert {name for name, _ in axioms} == {
    f'{v}P343N{n}.certified' for v in ['PackedLoaded', 'NatScalar']
    for n in [8, 16, 32, 64]}
assert all(ax == 'propext' for _, ax in axioms)

cases = []
processes = []
for case in pin['cases']:
    n = case['n']
    w = case['digit_width']
    a = [abs(row['input'][2]) for row in original[:n]]
    b = [abs(row['input'][4]) for row in original[:n]]
    assert max(a) * max(b) < 2**w
    expected = {
        'left': sum(x << (w*n*i) for i, x in enumerate(a)),
        'right': sum(x << (w*i) for i, x in enumerate(b)),
        'mask': sum(((1 << w)-1) << (w*(n+1)*i) for i in range(n)),
        'expected': sum((x*y) << (w*(n+1)*i) for i, (x, y) in enumerate(zip(a, b)))}
    path = home / f'packed_literals_{n}.json'
    payload = json.loads(path.read_text())
    assert set(payload) == set(expected)
    for key, value in expected.items():
        assert int(payload[key], 16) == value
        for suffix in ['bin', 'imported.bin']:
            dump = home / f'{path.name}.{key}.{suffix}'
            assert int.from_bytes(dump.read_bytes(), 'little') == value
            artifacts.add(dump.name)
    artifacts.add(path.name)
    assert (expected['left']*expected['right']) & expected['mask'] == expected['expected']
    assert expected['expected'] != (expected['expected'] ^ 1)
    data_build, _ = read(f'loaded_packed_data_{n}')
    packed_build, _ = read(f'loaded_packed_proof_{n}')
    scalar_build, _ = read(f'packed_build_NatScalar_{n}')
    entry = dict(case, input_values_match=True, data_build=data_build,
                 packed_build=packed_build, scalar_build=scalar_build)
    for variant in ['PackedLoaded', 'NatScalar']:
        samples = []
        for sample in range(3):
            rec, log = read(f'packed_replay_{variant}_{n}_sample{sample}')
            assert 'LIMITS,trust=0,heartbeats=0,recdepth=65536' in log
            assert len(rec['rows']) == 1
            row = rec['rows'][0]
            assert (row['variant'], row['precision'], row['butterflies'],
                    row['repetitions'], row['declarations']) == (variant, 343, n, 1, 3)
            samples.append(row['kernel_wall_ns'] / 1e9)
            processes.append(rec)
        entry[variant] = {'kernel_elapsed_samples_seconds': samples,
                          'kernel_elapsed_median_seconds': statistics.median(samples)}
    entry['scalar_over_packed_median_ratio'] = (
        entry['NatScalar']['kernel_elapsed_median_seconds'] /
        entry['PackedLoaded']['kernel_elapsed_median_seconds'])
    cases.append(entry)

raw_failure = json.loads((home / 'packed_data_64.json').read_text())
assert raw_failure['exit_code'] != 0 and raw_failure['stop'] is not None
artifacts.update(['packed_fixture_pin.json', 'PackedProbe.lean', 'PackedProbe.olean',
                  'PackedLoader.lean', 'PackedLoader.olean', 'generate_packed.py',
                  'generate_loaded_packed.py', 'run_loaded_packed.py', 'run_lean.py',
                  'summarize_packed.py', 'packed_data_64.json', 'packed_data_64.log'])
result = {
    'passed': True, 'toolchain': 'Stock Lean 4.35.0, Windows, one thread, trust zero',
    'source_fixture_sha256': pin['source_sha256'], 'cases': cases,
    'axiom_audit': axioms, 'theory_build': theory, 'loader_build': loader,
    'audit_process': audit, 'replay_processes': processes,
    'raw_literal_64_timeout_not_a_valid_timing_sample': raw_failure,
    'limitations': [
        'Packed and scalar claims have different formal conclusions. The generic packing bridge is unproved.',
        'Only nonnegative products; no signed arithmetic, rounding, network, FFT or TG claim.',
        'Three fresh processes per case, each one warmup and one timed replay.',
        'Kernel-loop measurements exclude imported literal preparation and generic theory.',
        'Loading constructs literal definitions, never arithmetic theorems; computations use decide +kernel.',
        'Exact Python payload comparisons are benchmark provenance, not a generic Lean packing proof.',
        'Sparse diagonal layout has quadratic payload growth. No optimal-packing claim.'],
    'artifacts': {name: {'bytes': (home/name).stat().st_size, 'sha256': digest(home/name)}
                  for name in sorted(artifacts)}}
(home/'PACKED_RESULTS.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps({'passed': True, 'cases': [
    {k: c[k] for k in ['n', 'PackedLoaded', 'NatScalar', 'scalar_over_packed_median_ratio']}
    for c in cases]}, indent=2))
