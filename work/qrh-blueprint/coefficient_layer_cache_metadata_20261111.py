"""Exact metadata for a proposed full-grid, height-major conversion schedule.

Reads frozen reports/receipts only. Does not evaluate or enumerate any source
coefficient, conductor, unit, prime, transform or analytic function.
"""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib
import json

ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / 'work/qrh-campaign/agents'
PINS = {
    'major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md': '483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716',
    'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md': '9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
    'major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md': '1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
    'prime-estimates/SHORT_OUTPUT_HORNER_PREFIX_COMPOSITION_2026-11-11.md': '716B9E5FFE726D629E97F2CA85CA972D351051A209CB0D5DC0B6CAC21F60C98B',
    'prime-estimates/short_horner_prefix_composition_20261111.json': '99671C5858B20FF3940186D33CCFB19E730C9D364FF3B3EB5B2E6B8641F399FE',
    'integration/REVIEW_SHORT_OUTPUT_HORNER_PREFIX_COMPOSITION_2026-11-11.md': '1F536DA236937B61AAF4E44B995956A06E090CFC91A00B40D9CF5896CC96CB03',
    'moebius/SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md': '531DD23307CED3ED958198C750393D933287809B9E42EF738888370AA4DE4474',
    'independent-feasibility/REVIEW_SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md': '40AE12EEFE142B932820F6462E6DE7CE127679A0CE220010148C698E984BBFF1',
}
checks = 0


def require(value):
    global checks
    assert value
    checks += 1


for rel, wanted in PINS.items():
    require(hashlib.sha256((BASE / rel).read_bytes()).hexdigest().upper() == wanted)
saved = json.loads((BASE / 'prime-estimates/short_horner_prefix_composition_20261111.json').read_text())
u, ut, rem = Q(2) ** -100, Q(2) ** -110, Q(2) ** -116
weighted = 4 * u + 330 * ut
flat = 2 ** 27 * (u / 4 + 330 * ut)
first = [5170 + rem + weighted] + [6 * Q(5, 4) ** j / factorial(j) + min(4 ** j * weighted, flat) for j in range(1, 20)]
final = [Q(4507) + Q(9, 2) + rem + u] + [Q(15, 2) * Q(7, 8) ** j / factorial(j) + u for j in range(1, 20)]
for z in first + final:
    # Even precision zero gives conversion norm error < 3/4.
    require(z + Q(3, 4) < 8192)
require(100 + 13 + 1 <= 128)

F = [1024, 2048, 4096, 8192, 16384]
K_CHOICES = {'full20': [20] * 5, 'constant_prefix': [19, 19, 19, 20, 18]}
scenarios = []
for old in saved['scenarios']:
    extra = old['extra_nodes']
    require(extra in (0, 167, 320, 640))
    heights = [6401, 6400, 12800, 38400, 20199 + extra]
    require(sum(heights) == 84200 + extra)
    require(64000 + heights[-1] == 84199 + extra)
    unit_total = sum(row['unit_residue_height_inputs'] for row in old['bands'])
    require(19 * unit_total == old['old_stages'])
    modes = {}
    for name, ks in K_CHOICES.items():
        rows = []
        for index, (mesh, h, k, oldband) in enumerate(zip(F, heights, ks, old['bands']), 1):
            require(oldband['band'] == index)
            arrays = (mesh + 1) * h
            slots = k * arrays
            coordinates = 2 * slots
            payload = 32 * k * (mesh + 1)
            require(coordinates == 2 * k * (mesh + 1) * h)
            require(payload == 16 * coordinates // h)
            require(payload <= 32 * 20 * 16385)
            rows.append({'band': index, 'F': mesh, 'heights': h, 'K': k,
                         'full_grid_array_admissions': arrays,
                         'complex_coefficient_conversions': slots,
                         'coordinate_conversions': coordinates,
                         'one_layer_converted_payload_bytes': payload,
                         'unit_residue_height_inputs': oldband['unit_residue_height_inputs']})
        array_total = sum(r['full_grid_array_admissions'] for r in rows)
        coord_total = sum(r['coordinate_conversions'] for r in rows)
        modes[name] = {'bands': rows, 'array_admissions': array_total,
                       'coordinate_conversions': coord_total,
                       'complex_conversions': coord_total // 2,
                       'largest_converted_layer_payload_bytes': max(r['one_layer_converted_payload_bytes'] for r in rows),
                       'unit_outputs_per_proposed_array_average': str(Q(unit_total, array_total)),
                       'coordinate_conversions_per_unit_output': str(Q(coord_total, unit_total))}
    require(modes['full20']['array_admissions'] == modes['constant_prefix']['array_admissions'])
    require(modes['constant_prefix']['coordinate_conversions'] < modes['full20']['coordinate_conversions'])
    scenarios.append({'extra_nodes': extra, 'unit_outputs': unit_total, 'modes': modes})

out = {'scope': 'Proposed one-admission full-grid height-major conversion schedule; exact specified counts, not exact used-source union or kernel/cache implementation.',
       'checks': checks, 'pins': PINS, 'scenarios': scenarios,
       'coordinate_encoding': 'signed128 fixed payload, at most114 required bits for direct grids0..100',
       'excluded_memory': ['original source encodings', 'proof objects and checked handles', 'elementary recurrence states', 'character transform state', 'output/transposition storage', 'replicas and decoding overhead'],
       'readmission_rule': 'Replace one admission by actual r_object on every context rebuild or copy. No digest-only proof import.',
       'no_runtime_claim': True}
dest = Path(__file__).with_suffix('.json')
with dest.open('x', encoding='utf-8') as handle:
    json.dump(out, handle, indent=2)
    handle.write('\n')
print(json.dumps({'checks': checks, 'receipt': str(dest), 'main_modes': {k: {t: v[t] for t in ['array_admissions', 'coordinate_conversions', 'largest_converted_layer_payload_bytes']} for k, v in scenarios[0]['modes'].items()}}, indent=2))
