"""Take a predeclared, length-stratified probability sample from the new grids."""
import hashlib
import json
import random
import sys
from bisect import bisect_right
from collections import Counter,defaultdict
from itertools import accumulate
from pathlib import Path

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
sys.path.insert(0,str(HOL/"large-kronecker-precision"))
from precision import AGENTS,admissible
SEED=202611201624
DRAWS=4


def sample():
    paths=[AGENTS/"integration/transform_structural_manifest_20261111.json",
           AGENTS/"major-constants/combined_conductor_precision_rows_20261111.json",
           AGENTS/"major-constants/combined_conductor_precision_nodes_20261111.json"]
    raw,prices,nodes=[json.loads(p.read_bytes()) for p in paths]
    local={r[0]:r[5] for r in nodes["rows"]}
    bins=defaultdict(Counter)
    for row,pr in zip(raw["conductors"],prices["rows"],strict=True):
        c,phi,prim,_,J,axes,_=row
        assert pr[1:4]==[c,phi,prim]
        s=sum(4 if n>=32 else local[n] for n,_ in axes)
        p=next(p for p in range(80,pr[-2]+1) if admissible(c,phi,s,pr[8],pr[7],p))
        full,kept,suffix=1,1,phi
        for n,q in axes:
            suffix//=n
            if n>=32:
                assert n%2==0
                cap=2*full*16384
                S=1<<p
                w=((2*n*(2*cap*S+2)*S).bit_length()+8)//8
                bins[(n-1).bit_length()][n,p,cap,w]+=(J+41)*kept*suffix
            full*=n
            kept*=n if q==0 else n-n//q
        assert kept==prim and full==phi
    rng=random.Random(SEED)
    strata={}
    weighted_bytes=0
    for b,states in sorted(bins.items()):
        keys=sorted(states)
        # Size-biased sampling with replacement. Each draw has probability
        # n*count/positions, so positions*mean(time_per_slice/n) estimates
        # the stratum total; duplicate draws retain their statistical weight.
        cumulative=list(accumulate(k[0]*states[k] for k in keys))
        positions=cumulative[-1]
        draws=[keys[bisect_right(cumulative,rng.randrange(positions))] for _ in range(DRAWS)]
        weighted_bytes+=sum(n*w*cnt for (n,p,cap,w),cnt in states.items())
        strata[b]=dict(states=len(keys),slices=sum(states.values()),positions=positions,draws=draws)
    assert sum(s["positions"] for s in strata.values())==47891544124008
    assert sum(s["slices"] for s in strata.values())==269921342390
    assert weighted_bytes==1185011667808558
    result=dict(seed=SEED,draws_per_stratum=DRAWS,input_hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest()
            for p in paths+[Path(__file__),HOL/"large-kronecker-precision/precision.py"]},strata=strata)
    (HERE/"sample.json").write_text(json.dumps(result,indent=2)+"\n")
    print([(b,s["positions"],[k[0] for k in s["draws"]]) for b,s in strata.items()])


if __name__=="__main__":
    sample()
