"""Rounded HOL transform and independent separable direct DFT with integer radii."""
import csv
import hashlib
import json
from collections import Counter
from math import isqrt
from pathlib import Path
from time import perf_counter

HERE = Path(__file__).resolve().parent
ROOTFILE = HERE.parent / 'c10004-roots/table.json'
S = 1 << 81
ROOTS = json.loads(ROOTFILE.read_text())['rows']


def upnorm(x, y):
    square = x*x + y*y
    floor = isqrt(square)
    return floor + (floor*floor < square)


def ct(xs, omit, counts):
    n = len(xs)
    def action(n, j, z):
        k = j % n
        a, b = z
        if k == 0:
            return z
        if 2*k == n:
            return -a, -b
        if 4*k == n:
            return -b, a
        if 4*k == 3*n:
            return b, -a
        wr, wi = ROOTS[str(n)][k]
        t = wr*(a+b)
        counts['three_product_actions'] += 1
        return (t-b*(wr+wi)+S//2)//S, (t+a*(wi-wr)+S//2)//S

    def direct(row, k):
        r = len(row)
        a, b = row[0]
        counts['complex_add_or_sub'] += r-1
        if r == 2:
            c, d = row[1]
            return (a-c, b-d) if k%2 else (a+c, b+d)
        for j in range(1,r):
            c, d = action(r,j*k,row[j])
            a, b = a+c, b+d
        return a,b

    if n in (2,3,5):
        return [direct(xs,k) for k in range(omit,n)]
    r = 3 if n == 15 else 2
    m = n//r
    children = [ct(xs[a::r],False,counts) for a in range(r)]
    bridge = [[action(n,a*v,children[a][v]) for a in range(r)] for v in range(m)]
    return [direct(bridge[k%m],k//m) for k in range(omit,n)]


def tensor(xs, transform):
    first = [transform(xs[j:j+2])[0] for j in range(0,4800,2)]
    middle = [transform(first[j:j+40]) for j in range(0,2400,40)]
    return [z for column in zip(*middle) for z in transform(column)]


def direct_balls(xs):
    # Exact integer dot-product numerators, rounded once per complete sum.
    n = len(xs)
    row = ROOTS[str(n)]
    out = []
    for k in range(1,n):
        re = im = rad = 0
        for j,(a,b,e) in enumerate(xs):
            u,v = row[j*k % n]
            re += u*a-v*b
            im += v*a+u*b
            rad += e*S
            if u and v:
                rad += upnorm(a,b)  # Euclidean root error < 1/S.
        out.append(((re+S//2)//S,(im+S//2)//S,(rad+S-1)//S+1))
    return out


def run(h):
    src = HERE.parent / 'c10004-reference' / f'h{h}.tsv'
    with src.open() as f:
        rows = list(csv.DictReader(f,delimiter='\t'))
    assert [int(r['index']) for r in rows] == list(range(4800))
    xs = [(int(r['re']),int(r['im'])) for r in rows]
    assert max(abs(x) for z in xs for x in z) < 2**95
    counts = Counter()
    t = perf_counter()
    ys = tensor(xs,lambda row: ct(row,True,counts))
    ct_time = perf_counter()-t
    assert len(ys) == 2301 and max(abs(x) for z in ys for x in z) < 2**112
    t = perf_counter()
    refs = tensor([(a,b,1) for a,b in xs],direct_balls)
    ref_time = perf_counter()-t
    output = HERE / f'h{h}-spectrum.tsv'
    bounds = []
    gaps = []
    with output.open('w',newline='') as f:
        w = csv.writer(f,delimiter='\t',lineterminator='\n')
        w.writerow(('k41','k61','re','im','abs_error_grid_units'))
        for i,((a,b),(c,d,e)) in enumerate(zip(ys,refs)):
            gap = upnorm(a-c,b-d)
            gaps.append(gap)
            bounds.append(gap+e)
            w.writerow((1+i//59,1+i%59,a,b,gap+e))
    def digest(p):
        return hashlib.sha256(p.read_bytes()).hexdigest()
    return dict(h=h,ct_seconds=ct_time,direct_seconds=ref_time,counts=counts,
                max_gap_grid_units=max(gaps),max_abs_error_grid_units=max(bounds),
                source_sha256=digest(src),root_sha256=digest(ROOTFILE),
                output_sha256=digest(output),output_bytes=output.stat().st_size)


if __name__ == '__main__':
    print(json.dumps([run(h) for h in (1,2)],indent=2))
