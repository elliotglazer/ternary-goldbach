"""Compose reviewed operation templates; no arithmetic certificates evaluated."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction
import json

BLUE = Path(__file__).resolve().parent
AGENTS = BLUE.parent / 'qrh-campaign/agents'
sources = {
    'arithmetic': ('prime-estimates/mm0_square_karatsuba_sizes_20261111.json',
                   'D2E5F35DB7D75C44F8DDD9405D60D78D475A123676CAC036D0CF0F6FFA47D073'),
    'grouped': ('major-constants/grouped_cyclotomic_schedules_20261111.json',
                'FC21AE178DD49F9923244B3D2CA6547CB31797AE695F8D4F683C8A78519E7585'),
}
data = {}
for key, (rel, expected) in sources.items():
    payload = (AGENTS / rel).read_bytes()
    assert sha256(payload).hexdigest().upper() == expected
    data[key] = json.loads(payload)

arith = {}
for width in [90, 718, 2871]:
    row = next(r for r in data['arithmetic']['rows'] if r['b'] == 8 and r['width'] == width)
    scheme = next(r for r in row['schemes'] if r['threshold'] == 3 and r['adaptive'])
    arith[width] = {'square': scheme['modular_square'], 'product': scheme['modular_general']}

def fraction_record(n, d):
    f = Fraction(n, d)
    return {'numerator': f.numerator, 'denominator': f.denominator}

batch = []
direct = 44 * arith[90]['square']
for count, width in [(1,90), (8,718), (32,2871)]:
    cost = 44 * arith[width]['square']
    batch.append({'candidates': count, 'modulus_bits': width,
                  'modular_chain_template_events': cost,
                  'events_per_candidate': fraction_record(cost, count),
                  'ratio_to_same_number_of_direct_chains': fraction_record(cost, count*direct)})

m160 = next(r for r in data['grouped']['rows'] if r['multiplier'] == 160)
projection = next(r for r in m160['price_projections']
                  if r['square_price'] == 1 and r['product_price'] == 1)
manual = next(r for r in projection['rows'] if r['roots'] == 4 and r['inverse_coordinates'] == 1)
assert (manual['squares'],manual['products'],manual['additions']) == (40,37,14)
circuits = [
    ('Proth',44,0,0,1),
    ('old_m160_four_roots_plus_inverse',43,49,10,5),
    ('new_m160_four_roots_plus_inverse',40,37,14,5),
    ('m160_atomic_cyclotomic',33,22,52,11),
]
composed = []
for name,s,p,a,coordinates in circuits:
    composed.append({'name': name, 'squares': s, 'products': p,
                     'separate_additions_or_subtractions': a, 'witness_coordinates': coordinates,
                     'modular_arithmetic_template_subtotal': s*arith[90]['square']+p*arith[90]['product']})

result = {
    'scope': 'conditional byte-radix template subtotals; not opcodes, timings, or full costs',
    'omissions': ['representation and lemma instantiation', 'explicit additions/subtractions and normalization',
                  'table/library setup', 'prime search and witness production', 'CRT and product binding',
                  'metadata, coverage, imports and final assembly'],
    'source_pins': sources, 'arithmetic_templates': arith,
    'proth_batch_comparison': batch, 'direct_candidate_circuit_comparison': composed,
}
out = BLUE / 'compose_certificate_costs_20261111.json'
out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'batch':batch,'circuits':composed,
                  'receipt_sha256':sha256(out.read_bytes()).hexdigest().upper()},indent=2))
