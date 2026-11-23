"""Independent integer-only recurrence audit. No candidate arithmetic or imports."""
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
PINS = {
    'work/qrh-campaign/agents/prime-estimates/EFFICIENCY_MM0_SQUARE_KARATSUBA_2026-11-11.md': '4ADB3C676ABA3A82128A8F27CBB91221B414689F94CDC5D60BA0FA75A8421FFA',
    'work/qrh-campaign/agents/prime-estimates/mm0_square_karatsuba_sizes_20261111.py': '64C11ADCA0ABAB02A95F617AD326F051A3B871F97CF2D4458DFEF4825607039C',
    'work/qrh-campaign/agents/prime-estimates/mm0_square_karatsuba_sizes_20261111.json': 'D2E5F35DB7D75C44F8DDD9405D60D78D475A123676CAC036D0CF0F6FFA47D073',
    'work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md': '3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227',
    'work/qrh-campaign/agents/prime-estimates/EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md': 'DAA7F4625A1CCF8D9307AF59D1FA0C74416CCF38F9B87BBC8547C0F0D74836F3',
    'work/qrh-campaign/agents/integration/REVIEW_EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md': '1D4C6FADEC317AF21A3442D7D748405D5CD827173BF298231F871853DF9AEE1B',
    'work/mm0-efficient/toolchain-sources/examples__peano.mm1': '13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079',
    'work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1': '76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94',
}
for name, expected in PINS.items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest().upper() == expected, name

saved = json.loads((ROOT / 'work/qrh-campaign/agents/prime-estimates/mm0_square_karatsuba_sizes_20261111.json').read_text())

def add(width):
    return width * 2 + 1

def mul_base(width):
    return sum(5 * width + 2 for _ in range(width)) + 1

def tri_raw(width):
    rows = sum(5 * i + 2 for i in range(1, width)) + 1
    diagonal = 2 * width + 1
    return rows + diagonal + add(2 * width) * 2 + 1

def table(limit, threshold, adaptive, square):
    out = {}
    for width in range(1, limit + 1):
        base = mul_base(width)
        if square:
            base = min(base, tri_raw(width))
        row = dict(cost=base, internal_nodes=0, leaves=1, node_width_sum=0, depth=0)
        if width > threshold:
            high = width // 2
            low = width - high
            sizes = [low, high, low + 1]
            assert all(0 < k < width for k in sizes)
            children = [out[k] for k in sizes]
            inputs = add(low + 1) * (1 if square else 2)
            overhead = inputs + 2 * add(2 * low + 2) + 2 * add(2 * width) + 3
            split = dict(cost=sum(c['cost'] for c in children) + overhead,
                         internal_nodes=1 + sum(c['internal_nodes'] for c in children),
                         leaves=sum(c['leaves'] for c in children),
                         node_width_sum=width + sum(c['node_width_sum'] for c in children),
                         depth=1 + max(c['depth'] for c in children))
            if not adaptive or split['cost'] < base:
                row = split
        assert row['leaves'] == 2 * row['internal_nodes'] + 1
        out[width] = row
    return out

assert len(saved['rows']) == 15
assert {(r['b'], r['width']) for r in saved['rows']} == {(b, w) for b in [4,8,10,12,16] for w in [90,718,2871]}
checked = 0
highlights = []
for row in saved['rows']:
    b, width, n = row['b'], row['width'], row['n']
    assert n == (width + b - 1) // b
    m = mul_base(n)
    c = min(m, tri_raw(n))
    remainder = add(2*n) + add(n) + 1
    assert row['general_schoolbook'] == m
    assert row['triangular_square_raw'] == tri_raw(n)
    assert row['square_base'] == c
    assert row['old_modular_square'] == 2*m + remainder
    assert row['triangular_modular_square'] == m+c + remainder
    assert row['old_44_squares'] == 44*(2*m + remainder)
    assert row['triangular_44_squares'] == 44*(m+c + remainder)
    assert len(row['schemes']) == 8
    assert {(s['threshold'],s['adaptive']) for s in row['schemes']} == {(t,a) for t in [3,8,16,32] for a in [False,True]}
    for scheme in row['schemes']:
        t, a = scheme['threshold'], scheme['adaptive']
        general = table(n,t,a,False)[n]
        square = table(n,t,a,True)[n]
        assert general == scheme['general']
        assert square == scheme['square']
        assert scheme['modular_square'] == general['cost'] + square['cost'] + remainder
        assert scheme['modular_general'] == 2*general['cost'] + remainder
        checked += 1
        if b == 8 and t == 3 and a:
            highlights.append(dict(bits=width,n=n,modular_square=scheme['modular_square'],
                                   internal_nodes=general['internal_nodes']+square['internal_nodes'],
                                   node_width_sum=general['node_width_sum']+square['node_width_sum']))

# Reproduce only the explicitly INVALID no-growth diagnostic, never as an accepted schedule.
wrong = {}
for n in range(1,360):
    wrong[n] = min(mul_base(n),tri_raw(n))
    if n > 8:
        h=(n+1)//2
        wrong[n] = 2*wrong[h]+wrong[n//2]+add(h+1)+2*add(2*h+2)+2*add(2*n)+3
assert saved['unsafe_no_growth_example'] == dict(n=359,actual=table(359,8,False,True)[359]['cost'],unsafe=wrong[359])
result = dict(status='PASS',scope='Integer recurrence and saved-table consistency only; no emitted proof or runtime claim',
              pins=PINS,rows=15,schemes=checked,component_tree_records=2*checked,
              byte_adaptive=highlights,unsafe_diagnostic=saved['unsafe_no_growth_example'])
target = Path(__file__).with_suffix('.json')
with target.open('x',encoding='utf-8',newline='\n') as stream:
    json.dump(result,stream,indent=2)
    stream.write('\n')
print('PASS: 15 rows, 120 schemes, 240 tree records; integer-only audit.')
