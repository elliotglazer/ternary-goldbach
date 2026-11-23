"""Verify inclusive endpoint reuse and translated weights on all short ternary grids."""
from itertools import product


def flips(rows, upper):
    right = [v for (_, left), (v, right) in zip(rows, rows[1:]) if left != right]
    return len(right), sum(upper-v for v in right)


for codes in product((-1, 0, 1), repeat=9):
    # A zero code means missing evidence and is never read as a sign.
    samples = [(t, sign) for t, sign in enumerate(codes) if sign]
    for lo, hi in [(0,4), (4,8)]:
        inclusive = [(t,s) for t,s in samples if lo<=t<=hi]
        n,w = flips(inclusive, hi)
        shifted = [(t+1,s) for t,s in samples if lo<t+1<hi+2]
        ns,ws = flips(shifted, hi+2)
        assert (ns,ws-ns)==(n,w)
        interior = [(t,s) for t,s in inclusive if lo<t<hi]
        old_n,old_w = flips(interior,hi)
        assert old_n <= n <= old_n+2 and old_w <= w <= old_w+hi-lo
        for j in range(len(inclusive)):
            fewer = inclusive[:j]+inclusive[j+1:]
            less_n,less_w = flips(fewer,hi)
            assert less_n<=n and less_w<=w
print("19683 partial sign grids; 39366 interval and translation checks passed")
