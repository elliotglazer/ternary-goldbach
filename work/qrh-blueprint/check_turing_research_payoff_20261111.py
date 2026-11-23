"""Exact conditional operation comparisons; no analytic evaluation or timing."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parent
SOURCE = ROOT.parent / 'qrh-campaign/agents/zero-sum/auxiliary_fixed_order_inventory_20261111.json'
EXPECTED = '8BEAD899428DE523323FCA7D833ECE6F4C5443213D32D4F32B964B18B218F7F9'
assert hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper() == EXPECTED
data = json.loads(SOURCE.read_text())
main = data['main_operations']
step = data['per_extra_height_operations']

def encode(q):
    q = F(q)
    return {'numerator': q.numerator, 'denominator': q.denominator}

def extra(h, key):
    assert (64*h) % 5 == 0
    return (64*h//5) * step[key]

for row in data['rows']:
    for key in main:
        assert extra(row['h'], key) == row['added_operations'][key]

comparisons = []
for old, new in [(200, 50), (50, 45), (50, 30), (50, 25), (50, 15), (50, 0)]:
    savings = {key: F(extra(old, key)-extra(new, key), main[key]+extra(old, key)) for key in main}
    comparisons.append({'old_h': old, 'new_h': new,
        'component_saving_fractions': {key: encode(val) for key, val in savings.items()},
        'minimum': encode(min(savings.values())), 'maximum': encode(max(savings.values()))})
    if old == 50 and new == 0:
        assert all(F(39, 1000) < x < F(42, 1000) for x in savings.values())
    if old == 200 and new == 50:
        assert all(F(106, 1000) < x < F(110, 1000) for x in savings.values())

frontier = []
for b, h in [(F(121,4), 45), (F(18),25), (F(9),15)]:
    reserve = 2-F(1,2)-2*b/h
    previous = 2-F(1,2)-2*b/(h-5)
    assert reserve > 0 and previous <= 0
    frontier.append({'b':encode(b), 'conditional_D_cap':encode(F(1,2)),
        'first_multiple_of_5_h':h, 'reserve':encode(reserve), 'previous_reserve':encode(previous)})

receipt = {'status':'PASS_EXACT_CONDITIONAL_TRANSFORM_PAYOFF',
    'source_sha256':EXPECTED,
    'scope':'Fixed large-conductor transform operations only; unchanged per-category prices; no numerical success or runtime conclusion',
    'comparisons':comparisons, 'conditional_width_frontier':frontier}
out = ROOT / 'turing_research_payoff_20261111.json'
out.write_text(json.dumps(receipt, indent=2)+'\n', encoding='utf-8')
print(receipt['status'])
for row in comparisons:
    print(row['old_h'], row['new_h'], row['minimum'], row['maximum'])
