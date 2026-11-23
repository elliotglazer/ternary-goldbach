"""Independent formal integer identities and metadata; no analytic values."""
from pathlib import Path
from fractions import Fraction as F
from math import comb, factorial
import hashlib, json, sys

BASE = Path(__file__).resolve().parents[1]
paths = sys.argv[1:4]
assert len(paths) == 3
pins = {p: hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper() for p in paths}
data = json.loads((BASE/paths[2]).read_text())
checks = 0
def ck(x):
    global checks
    assert x
    checks += 1
def nu(x):
    assert x > 0
    return (x & -x).bit_length()-1
for p, h in data['pins'].items():
    ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper() == h)

# Closed Stirling expansion, with all coefficient numerators indeterminate.
S = [[0]*20 for _ in range(20)]
S[0][0] = 1
for n in range(1,20):
    for j in range(1,n+1):
        S[n][j] = S[n-1][j-1]+j*S[n-1][j]
def closed(i,j,step,div):
    out = {}
    for ell in range(j,i+1):
        for h in range(j,ell+1):
            a = comb(ell,h)*step**h*factorial(j)*S[h][j]
            ck(a % div == 0)
            if a:
                out[(19-i+ell,ell-h,i-ell)] = a//div
    return out
def add(a,b):
    z = a.copy()
    for k,v in b.items(): z[k] = z.get(k,0)+v
    return {k:v for k,v in z.items() if v}
def scale(a,v): return {k:x*v for k,x in a.items() if x*v}
def qmul(a): return {(n,q+1,v):x for (n,q,v),x in a.items()}
formal_states = 0
for delta in range(15):
    step = 2**delta
    for mode in ('power','factorial'):
        st = [{(19,0,0):1}]
        for i in range(1,20):
            old = st
            st = [{} for _ in range(i+1)]
            coefficient = lambda j: j//2**nu(j) if mode == 'power' else 1
            st[i] = scale(old[-1],coefficient(i))
            for j in range(1,i):
                st[j] = add(add(qmul(old[j]),scale(old[j],j*step)),scale(old[j-1],coefficient(j)))
            st[0] = add(qmul(old[0]),{(19-i,0,i):1})
            for j in range(i+1):
                div = 2**(j*delta+nu(factorial(j))) if mode == 'power' else step**j*factorial(j)
                ck(st[j] == closed(i,j,step,div))
                formal_states += 1
    row = data['width_exponents_above_reduced_Q'][delta]
    for mode in ('power','factorial'):
        for j in range(20):
            div = 2**(j*delta+nu(factorial(j))) if mode == 'power' else step**j*factorial(j)
            ratio = F(2**j,div)
            prefix = 'power_two' if mode == 'power' else 'factorial'
            ck(2**24*ratio <= 2**row[prefix+'_state_exponent'])
            if j < 19:
                ck(3*2**24*ratio < 2**row[prefix+'_traversal_raw_exponent'])
            if 1 <= j <= 18:
                ck(2**24*(F(1,4)+F(3*j,40))*ratio < 2**row[prefix+'_Newton_raw_exponent'])
            if j:
                ck(2**24*F(j,40)*ratio < 2**row[prefix+'_Newton_raw_exponent'])
        ck(65*2**16 < 2**row[prefix+'_Newton_raw_exponent'])

# Reconstruct the structural classes by direct conductor enumeration, rather
# than the author's floor-count/height-cutoff derivation. No primes or units.
starts = (0,6401,12801,25601,64001)
family = list(range(10001,132901,2))+list(range(10004,265801,4))
heights = {}
for c in family:
    odd = bool(c%2)
    A = F(3927,1250)*(F(96,5) if odd else F(191,10))*(531600 if odd else 1063200)
    slope_ceil = (A.numerator+A.denominator*c-1)//(A.denominator*c)
    H = max(440 if odd else 455,200+slope_ceil)
    heights[c] = (64*H+4)//5
summaries = []
for group in data['classes']:
    extra, band = group['extra_nodes'],group['band']
    f = band+9
    grouped = {}
    for c in family:
        if c > 10*2**f and heights[c]+extra >= starts[band-1]:
            grouped.setdefault(nu(c),[]).append(c)
    ck(set(grouped) == {r['s'] for r in group['classes']})
    for row in group['classes']:
        cs = grouped[row['s']]
        ck((len(cs),min(cs),max(cs)) == (row['conductors'],row['first'],row['last']))
        for p in row['parities']:
            even = p['anchor_parity']=='even'
            t = min(f,row['s']+int(even))
            ck(p['t']==t and p['delta']==f-t and p['uniform_state_bits_removed']==19*t)
            ell = ((2*max(cs)//2**t)**19).bit_length()
            ck(p['max_reduced_v19_bits']==ell)
            w = data['width_exponents_above_reduced_Q'][f-t]
            for part in ('state','Newton_raw','traversal_raw'):
                ck(p['b100_power_'+part+'_signed_bits']==101+ell+w['power_two_'+part+'_exponent'])
    odd = len(grouped.get(0,[]))
    total = sum(map(len,grouped.values()))
    summaries.append({'extra_nodes':extra,'band':band,'odd':odd,'four_divisible':total-odd,'total':total})
ck(summaries == data['class_summaries'])

# Exact common factors and the exceptional output-only unit cancellation.
from math import gcd
for f in range(2,7):
    for s in range(8):
        for w in (1,3,5):
            c=2**s*w
            for k in range(6):
                t=min(f,s+int(k%2==0))
                ck(gcd(2*c,gcd(2**f,k*c))==2**t)
                for a in (1,3,5,7):
                    q=2**f*a-k*c
                    actual=nu(gcd(abs(q),2*c))
                    ck(actual==t+int(s==f and k%2==1))
ck(sum((20-j)*(j.bit_count()-1) for j in range(1,20))==167)
ck(sum(j.bit_count()-1 for j in range(1,20))==21)
ck(7*21<167<8*21)
result={'scope':'formal polynomial and exact structural metadata only','checks':checks,
        'pins':pins,'dependency_pins':data['pins'],'closed_stirling_state_checks':formal_states,
        'class_summaries':summaries}
out=Path(__file__).with_suffix('.json')
with out.open('x',encoding='utf8',newline='\n') as f:
    json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'formal_states':formal_states,'receipt_sha256':hashlib.sha256(out.read_bytes()).hexdigest().upper()}))
