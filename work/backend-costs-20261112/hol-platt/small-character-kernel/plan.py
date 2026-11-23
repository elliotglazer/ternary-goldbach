"""Stratify the parity-folded small-conductor character transforms by executed FFT length."""
from bisect import bisect_right
from collections import Counter, defaultdict
from hashlib import sha256
from itertools import accumulate
import json
from math import prod
from pathlib import Path
from random import Random
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/"small-character-parity"))
from fold import SOURCE, PRODUCER, budget, layout

SEED = 202611202057


def axis_bound(n):
    if n & (n-1) == 0:
        return 2*(n.bit_length()-1)+4, max(1,2*(n.bit_length()-1))
    m = 1 << (2*n-2).bit_length()
    k = m.bit_length()-1
    r = 2*k+4
    a = 1+3*r
    return 6*m*a+2*r*(2*n+1)+8, max(1,2*k,m*a,3*n*m*a+1)


def inventory(retained=None):
    saved = json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]
    theta = dict(saved["conductor_theta"])
    bins = defaultdict(Counter)
    totals = Counter()
    all_p = []
    for c,_,N,_,_ in saved["raw_metadata"]:
        ds, _, _, keep = layout(c)
        phi = prod(ds)
        R = (25*N+191)//192+1
        scheduled = R if retained is None else retained[c]
        assert 0 <= scheduled <= R
        parities = 1 if c in (3,4,12) else 2
        bounds = [axis_bound(n) for n in ds]
        stability = sum(a for a,b in bounds)
        denominator = (1<<80)*4*3**theta[c]*128*44*(2*3**33)*phi*stability*(8192**2+2)
        p = (max(denominator,2*stability,max(b for a,b in bounds))-1).bit_length()
        all_p.append(p)
        tally, pivot, order = budget(c,N)
        for key,value in tally.items():
            assert value%R==0
            totals[key] += value//R*scheduled
        x = phi//2
        base = 1
        for j in (*order,pivot):
            n = ds[j]//2 if j == pivot else ds[j]
            copies = parities*scheduled*(x//n)
            # Stress input widths. Every bucket before the fold is bounded by
            # the sum of 1..8192. Leave room for the parity pair and earlier axes.
            e = (8*(8192**2+2)*base).bit_length()
            if n & (n-1):
                m = 1 << (2*n-2).bit_length()
                d = m.bit_length()-1
                bins[f"fft-{d:02}"][d,p,e,n,1] += copies
                bins[f"fft-{d:02}"][d,p,e+n.bit_length()+2,m,-1] += copies
                bins["point"][6,p,e,64,1] += copies*2*n
                bins["point"][6,p,e+n.bit_length()+2,64,1] += copies*m
            elif n>1:
                d = n.bit_length()-1
                bins[f"fft-{d:02}"][d,p,e,n,1] += copies
            if j==pivot:
                bins["point"][6,p,e,64,1] += tally["pre_twist_complex_products"]//R*scheduled
            else:
                x = x//n*keep[j]
            base *= n
        bins["add"][6,p,(4*(8192**2+2)).bit_length(),64,1] += tally["pair_adds"]//R*scheduled
    assert len(all_p)==7499 and [min(all_p), max(all_p)]==[279,411]
    if retained is None:
        assert totals==json.loads((HERE.parent/"small-character-parity/fold.json").read_bytes())["totals"]
    butterflies=sum(sum(b.values())*(1<<next(iter(b))[0])*next(iter(b))[0]//2
                    for name,b in bins.items() if name.startswith("fft"))
    assert butterflies==totals["folded_b"]
    assert sum(bins["point"].values())==totals["folded_points"]+totals["pre_twist_complex_products"]
    assert sum(bins["add"].values())==totals["pair_adds"]
    return bins, totals


def main():
    bins, totals = inventory()
    rng=Random(SEED)
    strata={}
    for name,counts in sorted(bins.items()):
        keys=[k for k in sorted(counts) if counts[k]]
        weights=list(accumulate(counts[k] for k in keys))
        draws=[keys[bisect_right(weights,rng.randrange(weights[-1]))]
               for _ in range(4 if name.startswith("fft") else 8)]
        strata[name]=dict(calls_or_scalar_operations=weights[-1],distinct_states=len(keys),draws=draws)
    paths=[SOURCE,PRODUCER,HERE.parent/"small-character-parity/fold.py",Path(__file__)]
    plan=dict(seed=SEED,strata=strata,totals=totals,grid_bits=[279,411],
              sha256={x.name:sha256(x.read_bytes()).hexdigest() for x in paths})
    (HERE/"plan.json").write_text(json.dumps(plan,indent=2)+"\n")
    print([(name,v["calls_or_scalar_operations"]) for name,v in strata.items()])


if __name__=="__main__":
    main()
