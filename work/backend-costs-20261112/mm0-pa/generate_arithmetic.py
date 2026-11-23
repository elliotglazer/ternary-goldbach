"""Generate ordinary PA binary multiplication proofs; no trusted computed facts."""
import argparse
import hashlib
import json
import sys
import time
from pathlib import Path

sys.setrecursionlimit(10000)
BASE = Path(__file__).resolve().parent
PA = 'mm0-0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/peano.mm0'
FIXTURE = BASE.parents[1] / 'lean-pilots/batched-transform/P343N64.json'

def numeral(n):
    assert n >= 0
    if not n:
        return '0'
    return '(' + ' '.join('b' + b + ' (' for b in bin(n)[2:][::-1]) + '0' + ')' * (n.bit_length() + 1)

def succ(n):
    if n == 0:
        return 'paSuccZero'
    if n % 2 == 0:
        return 'sucb0'
    return f'(paSuccOdd {succ(n // 2)})'

def add(a, b):
    if a == 0:
        return 'add01'
    if b == 0:
        return 'add0'
    aa, bb = a // 2, b // 2
    p = add(aa, bb)
    bits = f'{a % 2}{b % 2}'
    if bits == '11':
        return f'(paAdd11 {p} {succ(aa + bb)})'
    return f'(paAdd{bits} {p})'

def mul(a, b):
    if a == 0:
        return 'mul01'
    if b == 0:
        return 'mul0'
    if b == 1:
        return 'paMulOne'
    p = mul(a, b // 2)
    if b % 2 == 0:
        return f'(paMulEven {p})'
    return f'(paMulOdd {p} {add(2 * a * (b // 2), a)})'

def generate(name, pairs, library='arithmetic.mm1'):
    start = time.perf_counter()
    mm1 = [f'import "{library}";']
    mm0 = [f'import "{PA}";']
    for i, (a, b) in enumerate(pairs):
        for label, value in [('A', a), ('B', b), ('C', a * b)]:
            decl = f'def {label}{i}: nat = $ {numeral(value)} $;'
            mm0.append(decl)
            mm1.append(decl)
        statement = f'theorem product{i}: $ A{i} * B{i} = C{i} $'
        mm0.append(statement + ';')
        mm1.append('pub ' + statement + " = '" + mul(a, b) + ';')
    if not pairs:
        mm0.append('theorem bootstrap: $ 0 = 0 $;')
        mm1.append("pub theorem bootstrap: $ 0 = 0 $ = 'eqid;")
    for suffix, lines in [('mm0', mm0), ('mm1', mm1)]:
        (BASE / f'{name}.{suffix}').write_text('\n'.join(lines) + '\n', encoding='utf-8', newline='\n')
    data = dict(name=name, library=library, products=len(pairs), generation_seconds=time.perf_counter()-start,
                fixture_sha256=hashlib.sha256(FIXTURE.read_bytes()).hexdigest(),
                pairs=[dict(a=str(a), b=str(b), product=str(a*b)) for a,b in pairs],
                mm1_bytes=(BASE/f'{name}.mm1').stat().st_size,
                mm1_sha256=hashlib.sha256((BASE/f'{name}.mm1').read_bytes()).hexdigest())
    (BASE/f'{name}.json').write_text(json.dumps(data, indent=2)+'\n')
    print(json.dumps({k:v for k,v in data.items() if k != 'pairs'}), flush=True)

if __name__ == '__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('--counts', nargs='*', type=int, default=[])
    parser.add_argument('--smoke', action='store_true')
    args=parser.parse_args()
    if args.smoke:
        generate('smoke', [(0,5),(7,0),(7,1),(2,3),(3,3),(7,7),(17,18),(127,255)])
    rows=json.loads(FIXTURE.read_text())['rows']
    for n in args.counts:
        assert 0 <= n <= len(rows)
        generate(f'products{n}', [(abs(r['input'][2]),abs(r['input'][4])) for r in rows[:n]])
