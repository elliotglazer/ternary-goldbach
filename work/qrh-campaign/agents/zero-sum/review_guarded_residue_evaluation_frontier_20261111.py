"""Independent saved-record review; no candidate or workload generation."""
from pathlib import Path
from fractions import Fraction
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
AUTHOR = ROOT / 'work/qrh-campaign/agents/integration'
EXPECTED = {
    'GUARDED_RESIDUE_EVALUATION_FRONTIER_2026-11-11.md': 'C24D4CB1338EDDFD46398C5B6D2BB1CA80CA61500B648B1A41039BFEECB6CA8D',
    'guarded_residue_evaluation_frontier_20261111.py': '646543B1D2CB2C69B08396DC78847CA0223096DE54B1A4AED4DC4D82BF8D829F',
    'guarded_residue_evaluation_frontier_20261111.json': 'DA5B4B1C09A5D6F10D8B1133AF5F2BD95E9711BDB309DD1F1FEAB4E8E7E1A5F7',
}
checks = []


def ck(name, condition):
    if not condition:
        raise AssertionError(name)
    checks.append(name)


def sha(raw):
    return hashlib.sha256(raw).hexdigest().upper()


def read_once(path, limit, expected):
    ck('size ' + path.name, path.stat().st_size <= limit)
    raw = path.read_bytes()
    ck('pin ' + path.name, sha(raw) == expected)
    return raw


def equal(name, actual, expected):
    ck(name, actual == expected)


def add_cost(bits):
    return 1 + 2 * ((bits + 7) // 8)


def mul_cost(x, y):
    a, b = sorted(((x + 7) // 8, (y + 7) // 8))
    return 5 * a * b + 2 * a + 1


ck('three frozen author pins supplied', len(EXPECTED) == 3)
author_objects = {}
for name, digest in EXPECTED.items():
    raw = read_once(AUTHOR / name, 512 * 1024, digest)
    if name.endswith('.json'):
        packet = json.loads(raw)
    author_objects[name] = digest

inputs = {}
for rel, digest in packet['pins'].items():
    limit = 24 * 1024**2 if rel.endswith('joint_horner_length_precision_20261111.json') else 512 * 1024
    raw = read_once(ROOT / rel, limit, digest)
    if rel.endswith('.json'):
        inputs[Path(rel).name] = json.loads(raw)

joint = inputs.pop('joint_horner_length_precision_20261111.json')
wanted = [(f'band{i}', k, 94) for i in (1, 2, 3) for k in (19, 20)]
wanted += [('band4', 20, 94), ('band5_declared', 19, 93),
           ('band5_declared', 20, 94), ('band5_actual', 18, 94), ('band5_actual', 20, 94)]
selected = {}
for case, k, b in wanted:
    found = [r for r in joint['results'][case]['profiles']['fixed']['candidates'] if r['K'] == k and r['b0'] == b]
    equal('unique fixed record ' + case + str(k), len(found), 1)
    key = f'{case}_K{k}_b{b}'
    selected[key] = found[0]
    ck('admitted ' + key, found[0]['admitted'] and Fraction(found[0]['alpha_ratio']) < 1)
equal('eleven exact selected records', packet['selected_records'], selected)
equal('selected count', packet['selected_count'], 11)
equal('unused equivalence record', packet['extra_equivalence_record'], 'band5_actual_K20_b94')
del joint

expected_schedules = {
    'full20_fixed_b94': [f'band{i}_K20_b94' for i in range(1, 5)] + ['band5_declared_K20_b94'],
    'short_final18': [f'band{i}_K19_b94' for i in range(1, 4)] + ['band4_K20_b94', 'band5_actual_K18_b94'],
    'short_final19': [f'band{i}_K19_b94' for i in range(1, 4)] + ['band4_K20_b94', 'band5_declared_K19_b93'],
}
equal('three fixed schedules', packet['schedule_keys'], expected_schedules)
profiles = {}
stage_count = 0
for key, rec in selected.items():
    k = rec['K']; stages = rec['stages']; grids = rec['grids']
    equal('stages ' + key, sorted(s['j'] for s in stages), list(range(k - 1)))
    equal('grids length ' + key, len(grids), k)
    products = additions = shifts = distances = 0
    for s in stages:
        stage_count += 1
        j = s['j']
        equal('stage grids ' + key + str(j), s['grids'], [grids[j+1], grids[j]])
        p = 2 * mul_cost(s['Mbits'], 18) + 2 * mul_cost(s['Lbits'], 20)
        a = sum(2 * add_cost(w) for w in s['add_magnitude_bits'])
        equal('stage products ' + key + str(j), s['product_events'], p)
        equal('stage additions ' + key + str(j), s['addition_events'], a)
        products += p; additions += a
        ck('nonnegative exact alignment ' + key + str(j), grids[j] >= grids[j+1])
        shifts += 2 * (grids[j] != grids[j+1])
        distances += 2 * (grids[j] - grids[j+1])
    equal('profile products ' + key, rec['product_events'], products)
    equal('profile additions ' + key, rec['addition_events'], additions)
    equal('profile alignment ' + key, [rec['alignment_shift_instances'], rec['alignment_bit_distance']], [shifts, distances])
    equal('output capacity ' + key, rec['reencoded_output_signed_bits'], 114)
    n = k - 1
    profiles[key] = dict(product_core=products, addition_core=additions, complex_stages=n,
        real_product_instances=4*n, real_add_instances=8*n, signed_product_bridges=4*n,
        signed_add_bridges=6*n, nearest_range_implications=2*n, residual_doubling_shifts=2*n,
        alignment_shift_instances=shifts, alignment_bit_distance=distances,
        grid100_export_coordinate_shifts=2, grid100_export_shift_bit_distance=2*(100-rec['b0']),
        grid108_embedding_coordinate_shifts=2, grid108_embedding_shift_bit_distance=16,
        top_coordinate_copies=2, coefficient_coordinate_lookups=2*k)
equal('stage total', packet['validated_stages'], stage_count)
ck('bounded stage work', stage_count <= 209)
for field in selected['band5_actual_K20_b94']:
    if field not in ('target_ratio', 'alpha_ratio'):
        equal('same actual/declared20 arithmetic ' + field, selected['band5_actual_K20_b94'][field], selected['band5_declared_K20_b94'][field])

guard_domain = inputs['short_guard_horner_admission_20261111.json']
guard_rows = [r for r in guard_domain['rows'] if Fraction(r['V']) == Fraction(26525, 4)]
equal('fresh guard admissions', packet['guard_final_admissions'], guard_rows)
for row in guard_rows:
    ck('guard admitted ' + str(row['K']), row['admitted'] and Fraction(row['alpha_ratio']) < 1)
    case = 'band5_actual' if row['K'] == 18 else 'band5_declared'
    rec = selected[f"{case}_K{row['K']}_b{row['b0']}"]
    equal('guard exact grids ' + str(row['K']), row['grids'], rec['grids'])
    equal('guard evaluation charge ' + str(row['K']), 633*Fraction(row['evaluation'])*2**82, Fraction(rec['evaluation_ratio']))

old = inputs['transform_structural_inventory_20261111.json']
guards = inputs['short_window_guard_ledger_20261111.json']
cache = inputs['coefficient_layer_cache_metadata_20261111.json']
norm = inputs['normalized_transform_short_guard_join_20261111.json']
transform = next(a for a in norm['allocations'] if a['p'] == 108)['profiles']
extras = [0, 167, 320, 640]
fine = [1024, 2048, 4096, 8192, 16384]
equal('four alternatives', [s['extra_nodes'] for s in packet['scenarios']], extras)
for si, sc in enumerate(packet['scenarios']):
    e = extras[si]; old_units = old['unit_band'][5*si:5*si+5]
    new_units = [b['residue_inputs'] for b in guards['scenarios'][si]['added_by_band']]
    equal('old units ' + str(e), sc['old_residue_inputs_by_band'], old_units)
    equal('guard units ' + str(e), sc['guard_residue_inputs_by_band'], new_units)
    equal('old cache units ' + str(e), sum(old_units), cache['scenarios'][si]['unit_outputs'])
    heights = [6401, 6400, 12800, 38400, 20199+e]
    for schedule, keys in expected_schedules.items():
        target = sc['schedules'][schedule]; prefix = f'{e}/{schedule}'
        arrays = {p: 0 for p in ('old', 'guard', 'joined')}
        coords = dict(arrays); peaks = []
        for bi, key in enumerate(keys):
            band = target['bands'][bi]; rec = selected[key]; per = profiles[key]
            equal(prefix+' key '+str(bi), band['profile_key'], key)
            equal(prefix+' per output '+str(bi), band['per_output'], per)
            equal(prefix+' units '+str(bi), [band['old_residue_inputs'],band['guard_residue_inputs'],band['joined_residue_inputs']], [old_units[bi],new_units[bi],old_units[bi]+new_units[bi]])
            equal(prefix+' source20 '+str(bi), [band['source_slots_produced_per_anchor'],band['source_slots_consumed_per_anchor']], [20,rec['K']])
            for part, units, layer_count in [('old',old_units[bi],heights[bi]),('guard',new_units[bi],41*(bi==4)),('joined',old_units[bi]+new_units[bi],heights[bi]+41*(bi==4))]:
                equal(prefix+' weighted '+part+str(bi), band['weighted'][part], {k:v*units for k,v in per.items()})
                a = (fine[bi]+1)*layer_count
                equal(prefix+' converted '+part+str(bi), band['converted_layers'][part], dict(height_layers=layer_count,array_admissions=a,complex_conversions=rec['K']*a,coordinate_conversions=2*rec['K']*a,per_degree_coordinate_conversion_instances=[2*a]*rec['K']))
                arrays[part] += a; coords[part] += 2*rec['K']*a
            payload = 32*rec['K']*(fine[bi]+1); peaks.append(payload)
            equal(prefix+' payload '+str(bi), band['one_layer_numerator_payload_bytes'], payload)
        equal(prefix+' peak payload',target['peak_converted_numerator_payload_bytes'],max(peaks))
        equal(prefix+' shared conversions',target['shared_conversion_totals'],{**{p+'_arrays':v for p,v in arrays.items()},**{p+'_coordinate_conversions':v for p,v in coords.items()}})
        equal(prefix+' old shared arrays',arrays['old'],cache['scenarios'][si]['modes']['full20']['array_admissions'])
        if schedule != 'short_final19':
            mode = 'full20' if schedule == 'full20_fixed_b94' else 'constant_prefix'
            equal(prefix+' old conversions',coords['old'],cache['scenarios'][si]['modes'][mode]['coordinate_conversions'])
        for part in ('old','guard','joined'):
            total = {field:sum(band['weighted'][part][field] for band in target['bands']) for field in profiles[key]}
            total['template_core'] = total['product_core']+total['addition_core']
            equal(prefix+' totals '+part,target['totals'][part],total)
            for mode in ('three','four'):
                tr = transform[mode]['scenarios'][si][part]
                combined = target['optional_p108_transform_component'][mode][part]
                equal(prefix+' optional transform '+mode+part,combined,dict(residue_product_core=total['product_core'],residue_addition_core=total['addition_core'],transform_product_core=tr['product_core'],transform_addition_core=tr['addition_core'],combined_product_core=total['product_core']+tr['product_core'],combined_addition_core=total['addition_core']+tr['addition_core'],combined_template_core=total['product_core']+tr['product_core']+total['addition_core']+tr['addition_core']))
    for comp in sc['baseline_comparisons']:
        x = sc['schedules'][comp['old_schedule']]; y = sc['schedules'][comp['new_schedule']]
        for part, fields in comp['component_reserves'].items():
            for field, val in fields.items():
                equal(f'comparison {e}/{comp["new_schedule"]}/{part}/{field}',val,x['totals'][part][field]-y['totals'][part][field])
        equal('conversion difference '+str(e)+comp['new_schedule'],comp['coordinate_conversion_count_difference'],y['shared_conversion_totals']['joined_coordinate_conversions']-x['shared_conversion_totals']['joined_coordinate_conversions'])
    u = old_units[4]+new_units[4]; h = heights[4]+41
    expected = dict(final_unit_outputs=u,product_core_saved_by19=74*u,addition_core_added_by19=28*u,coordinate_conversions_added_by19=2*16385*h,extra_signed_add_bridges=6*u,extra_signed_product_bridges=4*u,extra_nearest_range_implications=2*u,extra_export_shift_bits=2*u)
    equal('18 versus19 '+str(e),sc['final18_vs19'],expected)
equal('setup copied separately',packet['setup_p108'],{mode:transform[mode]['setup_per_cache_lifetime'] for mode in ('three','four')})
ck('no selection',packet['production_selected'] is False)

out = dict(scope='Independent saved-record arithmetic and source-binding review; no candidate regeneration or values.',author_pins=author_objects,input_pins=packet['pins'],checks=len(checks),check_names=checks,selected_records=11,stage_records=stage_count,scenario_count=4,schedule_count=3,source_slots_unchanged=20,production_selected=False)
dest = HERE / 'review_guarded_residue_evaluation_frontier_20261111.json'
with dest.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':len(checks),'bytes':dest.stat().st_size,'sha256':sha(dest.read_bytes())}))
