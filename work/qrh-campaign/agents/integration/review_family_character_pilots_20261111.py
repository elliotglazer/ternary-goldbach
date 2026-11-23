"""Independent exact CRT-lift pilot reconstruction. No producer imports or writes."""
from collections import Counter
from fractions import Fraction
from itertools import product
from math import gcd, prod
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
AUTHOR = HERE.parent / 'zero-sum'
SCRIPT = AUTHOR / 'family_character_manifest_20261111.py'
RECEIPT = AUTHOR / 'family_character_manifest_20261111.json'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
assert sha(SCRIPT) == '570fd7e9636bc9ff0337beb80ae5053b581b6338c44462408bb225df5ebf1f9b'
assert sha(RECEIPT) == 'df040a89b7e2d8856023b9d36169f741b1cd05b3db6c5d8d1d30c27e855b6eb7'
stored = json.loads(RECEIPT.read_text())
summary = []
for pilot in stored['pilots']:
    c = pilot['conductor']
    moduli = [p**k for p,k in pilot['factorization']]
    assert prod(moduli) == c
    assert all(gcd(a,b)==1 for i,a in enumerate(moduli) for b in moduli[i+1:])
    dims = pilot['coordinate_orders']
    lifts = []
    for i, generators in enumerate(pilot['local_generators']):
        q = moduli[i]
        e = (c//q) * pow(c//q,-1,q)
        for g in generators:
            lifts.append((1+(g-1)*e)%c)
    assert len(lifts) == len(dims)
    for g,d in zip(lifts,dims):
        assert pow(g,d,c)==1
        assert all(pow(g,j,c)!=1 for j in range(1,d))
    labels = list(product(*(range(d) for d in dims)))
    powers = {v:prod(pow(g,j,c) for g,j in zip(lifts,v))%c for v in labels}
    units = {u for u in range(c) if gcd(u,c)==1}
    assert len(powers) == len(set(powers.values())) and set(powers.values()) == units
    for v in labels:
        for w in labels:
            vw = tuple((x+y)%d for x,y,d in zip(v,w,dims))
            assert powers[vw] == powers[v]*powers[w]%c
    inverse = {u:v for v,u in powers.items()}
    divisors = [d for d in range(1,c+1) if c%d==0]
    rows = {}
    conductor_hist = Counter()
    rebuilt_primitive = []
    for label in labels:
        phases = {u:sum((Fraction(r*j,d) for r,j,d in zip(label,inverse[u],dims)),Fraction())%1 for u in units}
        row = tuple(phases[u] for u in sorted(units))
        assert row not in rows.values()
        rows[label] = row
        # Determine conductor directly from all divisor kernels, never from a p-adic formula.
        through = [d for d in divisors if all(phases[u]==0 for u in units if u%d==1%d)]
        cond = min(through)
        assert through == [d for d in divisors if d%cond==0]
        conductor_hist[cond] += 1
        assert phases[c-1] in (Fraction(0),Fraction(1,2))
        if cond == c:
            rebuilt_primitive.append(dict(coordinates=list(label),parity=int(phases[c-1]!=0),
                conjugate=[(-r)%d for r,d in zip(label,dims)],
                real=all(x in (Fraction(0),Fraction(1,2)) for x in row)))
    for label,row in rows.items():
        conjugate=tuple((-r)%d for r,d in zip(label,dims))
        assert rows[conjugate] == tuple((-x)%1 for x in row)
    assert rebuilt_primitive == pilot['primitive_labels']
    assert dict(sorted(conductor_hist.items())) == {int(k):v for k,v in pilot['conductor_histogram'].items()}
    summary.append(dict(level=c,global_crt_generators=lifts,all_character_rows=len(rows),
                        primitive=len(rebuilt_primitive),all_divisor_kernels_checked=len(rows)*len(divisors)))
assert sha(SCRIPT) == stored['script_sha256']
assert sha(RECEIPT) == 'df040a89b7e2d8856023b9d36169f741b1cd05b3db6c5d8d1d30c27e855b6eb7'
result=dict(status='PASS: independent exact CRT-lift and rational-phase pilots',
            author_script_sha256=sha(SCRIPT),author_receipt_sha256=sha(RECEIPT),pilots=summary,
            lean_validation=False,spectral_evaluation=False)
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf8')
print(json.dumps(result))
