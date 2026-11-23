"""Produce exact sparse interpolation checks and their order-dependent error thresholds."""
from collections import Counter
from fractions import Fraction as F
from functools import lru_cache
from hashlib import sha256
import json
from math import comb,lcm,ceil
from time import process_time

from repair import weights,SUB
from grid import HALO,GRID_BITS
from spectrum import HERE,LABELS,parameters


@lru_cache(None)
def exact(order,offset):
    weights_here = weights(order,offset,SUB)
    den = lcm(*(w.denominator for w in weights_here))
    coeffs = [int(w*den) for w in weights_here]
    assert sum(coeffs)==den and sum(map(abs,coeffs)) < 5*den
    return den,coeffs


def run():
    start = process_time()
    last = json.loads((HERE/"counts.json").read_bytes())
    main,final,n,J,theta = parameters()
    bound = (2*J+1)*(2*(80000000//theta)**2+1)
    eps = F(1,4*3**theta*(1<<80))
    analytic = 3*eps*F(5*n,64)/24
    orders = (32,48,64,80,96,112,128,160,192)
    def radius(r):
        rem = bound * F(44*J,7*n)**r/comb(r,r//2)
        return ceil((analytic+rem)*(1<<GRID_BITS)+10)
    keys = {}
    jobs = []
    costs = Counter()
    for label in LABELS:
        raw = list(map(int,(HERE/("grid-%d.txt"%label)).read_text().splitlines()))
        path = HERE/("signs-%d.tsv"%label)
        assert sha256(path.read_bytes()).hexdigest()==last["sha256"][path.name]
        for line in path.read_text().splitlines():
            at,sign = map(int,line.split())
            j,offset = divmod(at,SUB)
            if not offset:
                continue
            for r in orders:
                den,w = exact(r,offset)
                i = j+HALO+1-r//2
                xs = raw[i:i+r]
                num = sum(a*b for a,b in zip(xs,w,strict=True))
                if sign*num>den*radius(r):
                    key = r,offset
                    if key not in keys:
                        keys[key] = len(keys)
                    jobs.append((label,at,keys[key],1 if sign>0 else 0,xs))
                    costs[r]+=1
                    break
            else:
                raise ValueError((label,at))
    lines = [str(len(keys))]
    for (r,offset),k in keys.items():
        den,w = exact(r,offset)
        lines += [" ".join(map(str,[k,r,offset,den,radius(r)]))," ".join(map(str,w))]
    lines.append(str(len(jobs)))
    for label,at,k,s,xs in jobs:
        lines+=[" ".join(map(str,[label,at,k,s]))," ".join(map(str,xs))]
    packet = HERE/"stencils.txt"
    packet.write_text("\n".join(lines)+"\n",newline="\n")
    report = dict(orders=dict(costs),terms=sum(k*v for k,v in costs.items()),kernels=len(keys),jobs=len(jobs),
            fixed_192_terms=192*len(jobs),cpu=process_time()-start,packet_sha256=sha256(packet.read_bytes()).hexdigest())
    (HERE/"stencils.json").write_text(json.dumps(report,indent=2)+"\n")
    print(report)


if __name__=="__main__":
    run()
