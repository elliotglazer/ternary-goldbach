"""Audit all retained coarse indices against the rounded nonprincipal RH profile."""
from collections import Counter
from hashlib import sha256
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
WORK = HERE.parents[2]
AGENTS = WORK / 'qrh-campaign' / 'agents'
PINS = {}


def read(path):
    raw = path.read_bytes()
    PINS[str(path.relative_to(WORK))] = sha256(raw).hexdigest()
    return raw


def target(c):
    band = sum(c >= cut for cut in (100, 1000, 10000))
    u10 = ((210, 200, 195, 192) if c % 2 else (226, 211, 201, 191))[band]
    num = 31416 * u10 * (531600 if c % 2 else 1063200)
    den = 100000 * c
    return 200 + max(240 if c % 2 else 255, (num + den - 1) // den)


def main():
    read(WORK / 'backend-costs-20261112/forecast-audit-20261113/PRINCIPAL_COMPLETENESS.md')
    small = AGENTS / 'prime-estimates'
    integ = AGENTS / 'integration'
    read(small / 'build_sign_only_minimal_theta_schedule_20261111.py')
    read(integ / 'short_window_guard_ledger_20261111.py')
    schedules = json.loads(read(small / 'sign_only_minimal_theta_nonprincipal_schedule_20261111.json'))['scenarios']
    manifest = json.loads(read(integ / 'transform_structural_manifest_20261111.json'))
    compact = json.loads(read(integ / 'short_window_guard_conductor_rows_20261111.json'))
    assert compact['manifest_sha256'].lower() == PINS[str((integ / 'transform_structural_manifest_20261111.json').relative_to(WORK))]
    costs = json.loads(read(integ / 'short_window_guard_ledger_20261111.json'))
    prim_source = WORK / 'backend-costs-20261112/hol-platt/time-pruning/count_time_fft.py'
    import sys
    read(prim_source)
    sys.path.insert(0, str(prim_source.parent))
    from count_time_fft import primitive_count

    populations = {name: Counter() for name in ('small','large')}
    seen = {name: set() for name in populations}

    def record(name, c, n, T, last, internal):
        assert c not in seen[name] and T == target(c)
        seen[name].add(c)
        j = (64*T + 4)//5
        lift = 5*j-64*T
        assert 0 <= lift < 5 and last == j+640+internal
        p = populations[name]
        p['conductors'] += 1
        p['primitive_labels'] += n
        p['rounded_up_conductors'] += int(lift>0)
        p['rounded_up_labels'] += n*int(lift>0)
        p['requested_grid_nodes'] += j+641
        p['scheduler_grid_nodes'] += last+1
        p['internal_guard_nodes'] += internal

    small_schedules = {s['extra_nodes']:s['small_sign_only_conditional_candidate']['raw_metadata'] for s in schedules}
    for base, guarded in zip(small_schedules[0], small_schedules[640], strict=True):
        c, last = guarded[:2]
        assert base[:2] == [c,last-640]
        record('small', c, primitive_count(c), target(c), last, 0)
    assert manifest['extras'] == compact['extras'] == [0,167,320,640]
    for row, short in zip(manifest['conductors'], compact['rows_data'], strict=True):
        c,phi,n,T,J,_,weights = row
        assert short[:4] == [c,J,phi,n]
        assert n == primitive_count(c)
        consumer = sum(weights[15:20])
        internal = sum(short[-1][15:20])
        assert consumer == J+640 and internal == 41
        record('large', c, n, T, consumer+internal-1, internal)
    for name, lo, hi in [('small',3,10000),('large',10001,265800)]:
        assert seen[name] == {c for c in range(lo,hi+1) if c%4==0 or (c%2 and c<=132900)}
    lg=populations['large']
    cost = next(s for s in costs['scenarios'] if s['extra_nodes']==640)
    assert lg['requested_grid_nodes'] == cost['old_runtime']['conductor_height_nodes']
    assert lg['internal_guard_nodes'] == cost['added_runtime']['conductor_height_nodes']
    return dict(principal=dict(conductor=1,T=100000000,grid_index=1280000000,
                               production_family='separate zeta certificate'),
                maximum_lift='4/64', families=populations,sha256=PINS)


if __name__ == '__main__':
    (HERE/'rounded-coverage.json').write_text(json.dumps(main(),indent=2)+'\n')
