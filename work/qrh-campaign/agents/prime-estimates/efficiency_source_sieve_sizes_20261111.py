"""Scalar wheel/representation counts only; no prime test, sieve or evaluator.

The gcd loop visits one fixed residue period, not source integers or candidates
for primality. Counts of units are upper bounds for base-prime counts.
"""
from fractions import Fraction as F
from math import gcd, isqrt
import json
from pathlib import Path

W = 3 * 5 * 7 * 11 * 13
T = 2**18
D = 2**19
prefix = [0]
for k in range(W):
    prefix.append(prefix[-1] + (gcd(2*k+1, W) == 1))
phi = prefix[-1]
assert (W, phi) == (15015, 5760)
discrepancies = [W*prefix[k] - phi*k for k in range(W+1)]
disc = F(max(discrepancies)-min(discrepancies), W)
rho = F(phi,W)

def units_count_indices(n):
    q,r = divmod(n,W)
    return q*phi+prefix[r]

def odd_units_le(y):
    return units_count_indices((y+1)//2)

def ceilq(q):
    return -((-q.numerator)//q.denominator)

def rat(q):
    return [q.numerator,q.denominator]

rows=[]
for power in (32,34,36):
    J=2**power+D
    U=2*J-1
    Y=isqrt(U)
    Q=J//T
    assert J%T == 0 and Y*Y<=U<(Y+1)**2
    pbar=(Y-1)//2
    wheel_base_bound=odd_units_le(Y)-1  # removes 1; leaves composites
    plans=[]
    for cutoff in (256,1024,4096):
        small_bound=odd_units_le(cutoff)-1
        large_bound=odd_units_le(Y)-odd_units_le(cutoff)
        recip=F(0)
        bins=[]
        lo=cutoff
        while lo<Y:
            hi=min(2*lo,Y)
            count=odd_units_le(hi)-odd_units_le(lo)
            recip+=F(count,lo)  # every member lies strictly above lo
            bins.append([lo,hi,count])
            lo=hi
        # For each odd prime p>cutoff, wheel-admissible cofactor indices
        # in a finite interval of length <= J/p+1 number <=rho*(J/p+1)+disc.
        events=ceilq(rho*J*recip+(rho+disc)*large_bound)
        plans.append(dict(cutoff=cutoff,small_prime_upper=small_bound,
            large_prime_upper=large_bound,reciprocal_upper=rat(recip),
            dyadic_bins=bins,dense_medium_pairs_upper=Q*small_bound,
            wheel_sparse_events_upper=events,
            cached_patterns_bytes_upper=small_bound*((T+cutoff+7)//8),
            local_word_tree_depth=12))
    rows.append(dict(L_power=power,J=J,U=U,Y=Y,chunks=Q,
        original_dense_pairs_upper=Q*pbar,
        wheel_remaining_prime_upper=wheel_base_bound,
        wheel_dense_pairs_upper=Q*wheel_base_bound,
        source_words_64=J//64,plans=plans))

result=dict(scope="scalar wheel residue and size arithmetic only; no prime enumeration",
    wheel_modulus=W,wheel_phi=phi,wheel_density=rat(rho),
    cyclic_interval_discrepancy=rat(disc),
    period_bitmap_bytes=(W+7)//8,
    expanded_wheel_bytes=(T+W-1+7)//8,
    rows=rows)
if __name__ == '__main__':
    out=Path(__file__).with_suffix('.json')
    out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result,indent=2))
