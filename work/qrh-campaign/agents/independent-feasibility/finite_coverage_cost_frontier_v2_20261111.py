"""Exact geometry and symbolic-cost metadata; no primality or residue evaluations."""
from pathlib import Path
from fractions import Fraction
from itertools import combinations
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
OUT = Path(__file__).with_suffix('.json')
N = 989 * 10**24
T = N - 1
checks = 0

def check(v):
    global checks
    assert v
    checks += 1

def ceildiv(a, b):
    return -(-a // b)

def order(p):
    return next(m for m in range(45) if p < (2**(m+1)+1)**2)

def histogram(top, step, count):
    # Union of exact bit-length and strict order thresholds.
    cuts = sorted({5, top+1} | {2**j for j in range(2, 91) if 5 < 2**j <= top}
                  | {(2**j+1)**2 for j in range(1, 45) if 5 < (2**j+1)**2 <= top})
    def ge(z):
        return min(count, max(0, (top-z)//step+1))
    result = []
    for lo, hi in zip(cuts, cuts[1:]):
        n = ge(lo)-ge(hi)
        if n:
            result.append(dict(lo=lo, hi_exclusive=hi, count=n,
                               width=lo.bit_length(), squares=order(lo)))
    check(sum(r['count'] for r in result) == count)
    return result

rows = []
for B in [10**15, 2*10**15, 10**16, 2*10**16, 10**17, 2*10**17, 4*10**18]:
    D = B-2
    K = ceildiv(T-B-3, D)
    hs = histogram(T-B, D, K)
    check(T-B-(K-1)*D >= 5)
    check(3+K*D+B >= T)
    check(3+(K-1)*D+B < T)
    rows.append(dict(B=B, K_min=K, binary_word_count=ceildiv(D,128), bands=hs,
        reverse_squares=sum(r['count']*r['squares'] for r in hs),
        reverse_width_capacity=sum(r['count']*r['width'] for r in hs),
        reverse_square_times_width_squared=sum(r['count']*r['squares']*r['width']**2 for r in hs)))

# Compare the compressed histogram to literal small integer geometries.
for top in range(5, 250, 2):
    for step in [2, 4, 6, 12, 18]:
        n = (top-5)//step+1
        hs = histogram(top, step, n)
        vals = [top-j*step for j in range(n)]
        check(sum(order(p) for p in vals) == sum(r['count']*r['squares'] for r in hs))
        check(sum(order(p)*p.bit_length()**2 for p in vals) ==
              sum(r['count']*r['squares']*r['width']**2 for r in hs))

# Synthetic odd labels only. They are deliberately not certified as primes.
pool = [3, 9, 17, 23, 35, 47, 59]
target = 71
g = [0, 13, 2, 21, 4, 19, 5]
v = [0] + [order(p)*p.bit_length()**2+p.bit_length() for p in pool[1:]]

def prune(labels):
    labels = sorted(set(labels))
    return [x for x in labels if not any(y != x and all(a<=b for a,b in zip(y,x)) for y in labels)]

dp = [[(4,0,0)]]
all_paths = []
for j in range(1,len(pool)):
    dp.append(prune([(max(b,pool[j]-pool[i]+2), cg+g[j], cv+v[j])
                     for i in range(j) for b,cg,cv in dp[i]]))
terminal_dp = prune([(max(b,target-pool[j]),cg,cv)
                     for j,labels in enumerate(dp) for b,cg,cv in labels])
for size in range(len(pool)):
    for subset in combinations(range(1,len(pool)),size):
        ids = (0,)+subset
        b = max([4,target-pool[ids[-1]]] + [pool[j]-pool[i]+2 for i,j in zip(ids,ids[1:])])
        cg,cv = sum(g[i] for i in ids),sum(v[i] for i in ids)
        all_paths.append((b,cg,cv))
        D=b-2
        K=max(0,ceildiv(target-b-3,D))
        check(len(ids)-1 >= K)
        for j in range(K):
            check(pool[ids[-1-j]] >= target-b-j*D)
check(terminal_dp == prune(all_paths))
for ag in [0,1,3,11]:
    for av in [0,1,2,7]:
        for binary_price in [1,5,20]:
            check(min(binary_price*b+ag*cg+av*cv for b,cg,cv in terminal_dp) ==
                  min(binary_price*b+ag*cg+av*cv for b,cg,cv in all_paths))

# Exact rounding envelope in the explicitly equal-price idealized model.
for target in [71,101,1001]:
    A=target-5
    for B in range(4,target-2,2):
        x=B-2
        for a,c in [(1,1),(3,17),(17,3)]:
            exact = a*ceildiv(x,128)+c*(ceildiv(A,x)-1)
            low = Fraction(a*x,128)+Fraction(c*A,x)-c
            check(0 <= exact-low < a+c)

paths = [
 'work/ternary-goldbach/TernaryGoldbach/Statement.lean',
 'work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean',
 'work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean',
 'work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md',
 'work/qrh-campaign/agents/prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md',
 'work/qrh-campaign/agents/prime-estimates/FINITE_LADDER_SIZE_BAND_CERTIFICATES_2026-11-11.md',
 'work/qrh-campaign/agents/integration/REVIEW_FINITE_LADDER_SIZE_BAND_CERTIFICATES_2026-11-11.md',
 'work/qrh-campaign/agents/prime-estimates/SUPPLIED_ROOT_PRODUCTION_PAYLOAD_2026-11-11.md',
 'work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_ADAPTIVE_JOINT_SELECTION_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/ERRATUM_BINARY_ADAPTIVE_PRUNING_2026-11-11.md',
]
pins = {p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}
obj = dict(scope='Exact integer geometry and symbolic cost only; synthetic labels are not prime evidence',
           N0=N, T=T, rows=rows, synthetic_pool=pool, synthetic_pareto=terminal_dp,
           checks=checks, pins=pins)
with OUT.open('x',encoding='utf-8') as f:
    json.dump(obj,f,indent=2)
    f.write('\n')
print(json.dumps(dict(checks=checks,output=str(OUT),sha256=hashlib.sha256(OUT.read_bytes()).hexdigest().upper())))
