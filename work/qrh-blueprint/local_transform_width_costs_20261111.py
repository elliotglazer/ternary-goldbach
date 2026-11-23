"""Fold pinned structural counts into conditional arithmetic templates only."""
from pathlib import Path
from collections import Counter, defaultdict
from fractions import Fraction
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent / 'qrh-campaign' / 'agents'
PINS = {
    'integration/transform_structural_events_20261111.json': '06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B',
    'integration/transform_structural_inventory_20261111.json': '503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0',
    'integration/transform_structural_manifest_20261111.json': 'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637',
    'integration/TRANSFORM_STRUCTURAL_MULTIPLICITY_INVENTORY_2026-11-11.md': '01F1446FF10D2EFD690DF06552F35DAD26C1453A49F4BB4F84D794D997FD55BB',
    'integration/large_transform_pa_templates_20261111.json': 'B13699002FCB232B67FD9F973C8E2497D8984A14179C7D7ABCA6D306890CFFB5',
    'integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md': 'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C',
    'independent-feasibility/REVIEW_LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md': '1A0DE2B920A63B27D7E0AB8E6C0DF38F9DCD56872C290C9333783D99A461004E',
}
checks = 0

def ck(condition):
    global checks
    assert condition
    checks += 1

for rel, expected in PINS.items():
    ck(hashlib.sha256((AGENTS / rel).read_bytes()).hexdigest().upper() == expected)

def read(rel):
    return json.loads((AGENTS / rel).read_text(encoding='utf-8'))

events = read('integration/transform_structural_events_20261111.json')
summary = read('integration/transform_structural_inventory_20261111.json')
baseline = read('integration/large_transform_pa_templates_20261111.json')
ck(events['manifest_sha256'].upper() == PINS['integration/transform_structural_manifest_20261111.json'])
ck(len(events['events']) == 138126)

def adder(bits):
    return 2 * ((bits + 7) // 8) + 1

def product(a, b):
    m, n = sorted(((a + 7) // 8, (b + 7) // 8))
    return 5*m*n + 2*m + 1

def gate(a, b, three):
    raw = a + b + (2 if three else 1)
    return {
        'product': product(a+1, b) + 2*product(a, b+1) if three else 4*product(a, b),
        'exact_add': (adder(a+1) if three else 0) + 2*adder(raw),
        'round_add': 4*adder(raw+2),
    }

# Each compressed class is expanded only into its twenty integer weights.
# No conductor, residue, transform or coefficient is evaluated here.
by_width = defaultdict(lambda: [0]*20)
by_phase = defaultdict(lambda: [0]*20)
counts = [Counter() for _ in range(20)]
for cat, phase, n, stage, data_exp, coef_exp, division_bits, weights in events['events']:
    ck(cat in ('root', 'kernel', 'add', 'quarter', 'neg', 'scale'))
    ck(len(weights) == 20 and all(isinstance(w, int) and w >= 0 for w in weights))
    ck(0 <= data_exp <= 54)
    ck(coef_exp == 1 if cat == 'root' else (0 < coef_exp <= 18 if cat == 'kernel' else coef_exp == 0))
    ck(division_bits > 0 if cat == 'scale' else division_bits == 0)
    key = (cat, data_exp, coef_exp, division_bits)
    for i, w in enumerate(weights):
        by_width[key][i] += w
        by_phase[(cat, phase)][i] += w
        counts[i][cat] += w

for si, sc in enumerate(summary['scenarios']):
    total = sum((counts[5*si+j] for j in range(5)), Counter())
    ops = sc['operations']
    ck(total['root'] == sc['root_products'])
    ck(total['kernel'] == total['scale'] == sc['kernel_products'])
    ck(total['root'] + total['kernel'] == ops['general_complex_products'])
    for cat, old in [('add','complex_add_sub'),('quarter','quarter_turns'),('neg','negations'),('scale','dyadic_scales')]:
        ck(total[cat] == ops[old])

allocations = []
for old in baseline['candidate_allocations']:
    p = old['p']
    ck(p in (112,134,152))
    profiles = {}
    for three in (True, False):
        name = 'three' if three else 'four'
        bands = [Counter() for _ in range(20)]
        capacity_rows = []
        for (cat, de, ce, db), weights in sorted(by_width.items()):
            a = p + 14 + de
            b = p + ce if cat in ('root','kernel') else None
            if b is not None:
                fee = gate(a, b, three)
                raw = a+b+(2 if three else 1)
            elif cat == 'add':
                # The incoming key bounds both operands and result; retaining
                # one extra bit matches the conservative baseline convention.
                fee = {'complex_add': 2*adder(a+1)}
                raw = a+1
            elif cat == 'scale':
                fee = {'scale_round_add': 4*adder(a+2)}
                raw = a+2
            else:
                # Cheap sign/rotation work is retained as typed multiplicity,
                # not asserted free because its natural arithmetic core is zero.
                fee = {}
                raw = a
            capacity_rows.append([cat,a,b,db,raw,weights])
            for bi, weight in enumerate(weights):
                for field, value in fee.items():
                    bands[bi][cat+'_'+field] += weight*value
        scenarios = []
        for si, sc in enumerate(old['scenarios']):
            parts = sum((bands[5*si+j] for j in range(5)), Counter())
            local = sum(parts.values())
            padded = sc['padded_typed_transform_core'][name]
            ck(0 < local <= padded)
            # Independently reconstruct the old padding, with unchanged types.
            full_a = p+68
            old_fee = ((sc['G']-sc['dyadic_scales'])*sum(gate(full_a,p+1,three).values())
                       +sc['dyadic_scales']*sum(gate(full_a,p+18,three).values())
                       +sc['A']*2*adder(full_a+1)
                       +sc['dyadic_scales']*4*adder(full_a+2))
            ck(padded == old_fee)
            scenarios.append({
                'extra_nodes': sc['extra_nodes'], 'local_core': local,
                'padded_core': padded, 'core_difference': padded-local,
                'fraction_of_padded': str(Fraction(local,padded)),
                'parts': dict(parts), 'bands': [dict(x) for x in bands[5*si:5*si+5]],
            })
        profiles[name] = {'scenarios': scenarios, 'capacity_rows': capacity_rows}
    allocations.append({'p': p, 'intrinsic_allowance_bits': old['L_arithmetic_budget_bits'], 'profiles': profiles})

result = {
    'scope': 'Exact fold of frozen structural histogram; conditional padded arithmetic cores only.',
    'pins': PINS, 'checks': checks, 'input_event_classes': len(events['events']),
    'width_classes': len(by_width), 'V_upper_power': 14,
    'width_multiplicities': [[*k,v] for k,v in sorted(by_width.items())],
    'phase_multiplicities': [[*k,v] for k,v in sorted(by_phase.items())],
    'allocations': allocations,
    'setup_changed': False, 'precision_selected': False, 'sign_success_claimed': False,
    'ordinary_templates_implemented': False, 'complete_costs_priced': False,
    'remaining_costs': ['source/setup/root/kernel certification', 'coefficient-sum cache and binding',
        'signed/canonical/range/shift/rotation/negation proofs', 'numeral representation and construction',
        'ordinary arithmetic library', 'proof production/checking/transport/memory',
        'input error and complete downstream sign/completeness evidence'],
}
with (HERE / 'local_transform_width_costs_20261111.json').open('x',encoding='utf-8') as f:
    json.dump(result,f,sort_keys=True,separators=(',',':'))
print(json.dumps({'checks':checks,'width_classes':len(by_width),
    'main':[{ 'p': a['p'], **{n: {k:a['profiles'][n]['scenarios'][0][k] for k in ['local_core','padded_core','core_difference']} for n in ('three','four')}} for a in allocations]}))
