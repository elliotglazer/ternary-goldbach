"""Integer-only peak-width inventory. No roots, transforms, or source values."""
from pathlib import Path
from functools import cache
from math import prod
import hashlib, json

A = Path(__file__).resolve().parents[1]
PINS = {
    'zero-sum/mixed_radix_precision_metadata_20261111.json':
    '8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E',
    'zero-sum/mixed_radix_character_inventory_20261111.json':
    '2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F',
    'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':
    '4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
    'audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':
    '1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537',
}
for path, sha in PINS.items():
    assert hashlib.sha256((A/path).read_bytes()).hexdigest().upper() == sha
prior = json.loads((A/'zero-sum/mixed_radix_precision_metadata_20261111.json').read_text())
axes = {row['n'] for row in prior['axis_rows']}
LIMIT = 300000
spf = list(range(LIMIT+1))
for p in range(2, LIMIT+1):
    if spf[p] == p:
        for j in range(p*p, LIMIT+1, p):
            if spf[j] == j: spf[j] = p

def factors(n):
    result = []
    while n > 1:
        p, e = spf[n], 0
        while n % p == 0: n //= p; e += 1
        result.append((p, e))
    return result

def power2(n): return n > 0 and n & (n-1) == 0
def plen(n): return 1 << (2*n-2).bit_length()
def add(*vs): return tuple(map(sum, zip(*vs)))
def scale(a, v): return tuple(a*x for x in v)
def cbits(n): return (n-1).bit_length()

@cache
def rad(n):
    g = a = q = 0
    s = 2
    while s <= n:
        copies, half, quarter = n//s, s//2, int(s >= 4)
        g += copies*(half-1-quarter); q += copies*quarter; a += n; s *= 2
    return g, a, q, 0, 0

@cache
def blue(n):
    d = prod(p**((e+1)//2) for p,e in factors(n//(2 if n%2 == 0 else 1)))
    count = n//d; h = (2*d*d//n) % 4; odd = count//2
    q = odd if h in (1,3) else 0
    neg = odd if h == 2 else 0
    P = plen(n)
    return add(scale(2, rad(P)), (P+2*(n-count), 0, 2*q, 2*neg, P))

def old(n): return rad(n) if power2(n) else blue(n)

def bridge(r,m):
    n = r*m; q = neg = 0
    for h in (1,2,3):
        if h*n % 4: continue
        target = h*n//4
        for a in range(1,r):
            if target % a == 0 and 1 <= target//a < m:
                if h == 2: neg += 1
                else: q += 1
    return (r-1)*(m-1)-q-neg, 0, q, neg, 0

choices = {}
@cache
def selected(n):
    if power2(n): choices[n] = ('radix2',); return rad(n)
    r = spf[n]
    if r == n:
        if n <= 11:
            choices[n] = ('direct_prime',); return (n-1)**2, n*(n-1), 0, 0, 0
        choices[n] = ('bluestein',); return blue(n)
    m = n//r
    v = add(scale(r,selected(m)), scale(m,selected(r)), bridge(r,m))
    if v[0] <= old(n)[0] and v[1] <= old(n)[1]:
        choices[n] = ('split',r,m); return v
    choices[n] = ('bluestein',); return old(n)

for n in axes: selected(n)
active = set()
def visit(n):
    if n in active: return
    active.add(n)
    if choices[n][0] == 'split':
        _,r,m = choices[n]; visit(r); visit(m)
for n in axes: visit(n)
keys = ('general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales')
plan = {str(n):dict(choice=choices[n],count=dict(zip(keys,selected(n)))) for n in sorted(active)}
plan_sha = hashlib.sha256(json.dumps(plan,sort_keys=True,separators=(',',':')).encode()).hexdigest()
assert plan_sha == prior['plan_sha256']

def blue_peak(n): return 4*plen(n)*(n*n+n+1)
def old_peak(n): return (1 if n == 1 else 2*n) if power2(n) else blue_peak(n)
@cache
def new_peak(n):
    t = choices[n]
    if t[0] == 'radix2': return 1 if n == 1 else 2*n
    if t[0] == 'direct_prime': return 2*n
    if t[0] == 'bluestein': return blue_peak(n)
    _,r,m = t
    # Finite specialization of the general comparison in the paper proof.
    assert plen(r)*2 <= plen(n)
    assert m*(r*r+r+1) <= n*n+n+1
    return max(new_peak(m), 2*m*new_peak(r))

rows = []
for n in sorted(axes):
    o, m = old_peak(n), new_peak(n)
    assert m <= o
    rows.append(dict(n=n,old_peak=o,mixed_peak=m,old_bits=cbits(o),mixed_bits=cbits(m)))
hist = {}
for row in rows:
    saving = row['old_bits']-row['mixed_bits']
    hist[saving] = hist.get(saving,0)+1

examples = {}; conductor_count = 0; seen_axes = set(); full_hist = {}
max_old = (0,0); max_new = (0,0)
for c in range(3,LIMIT+1):
    if not ((c%2 and c<=150000) or c%4==0): continue
    ds = []
    for p,e in factors(c):
        if p == 2:
            if e == 2: ds.append(2)
            elif e >= 3: ds.extend((2,2**(e-2)))
        else: ds.append((p-1)*p**(e-1))
    seen_axes.update(ds); prefix = 1; o = m = 1
    for n in ds:
        # The common normalized outer-stage envelope is 2*prefix*(B+1).
        o = max(o,2*prefix*old_peak(n)); m = max(m,2*prefix*new_peak(n)); prefix *= n
    assert m <= o
    conductor_count += 1
    saving = cbits(o)-cbits(m); full_hist[saving] = full_hist.get(saving,0)+1
    max_old = max(max_old,(o,c)); max_new = max(max_new,(m,c))
    if c in (10007,100003,150000,262144,300000):
        examples[c] = dict(axes=ds,old_peak=o,mixed_peak=m,old_bits=cbits(o),mixed_bits=cbits(m))
assert seen_axes == axes and conductor_count == 149999 and len(active) == 37117
out = dict(status='PASS_INTEGER_PEAK_WIDTH_COMPARISON',pins=PINS,plan_sha256=plan_sha,
           assumptions='Accepted common-u safety and S_old*u<=1/2; exact stored input norm <= B; V=B+1.',
           scope='Conservative peak allocation, not actual stage-minimal widths, root generation or runtime.',
           axis_count=len(axes),active_nodes=len(active),conductor_count=conductor_count,
           axis_bit_saving_histogram=hist,conductor_bit_saving_histogram=full_hist,
           max_old_conductor_peak=dict(coefficient=max_old[0],conductor=max_old[1],bits=cbits(max_old[0])),
           max_mixed_conductor_peak=dict(coefficient=max_new[0],conductor=max_new[1],bits=cbits(max_new[0])),
           examples=examples,axis_rows=rows)
dest = Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8',newline='\n') as f: json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({k:v for k,v in out.items() if k!='axis_rows'},indent=2))
