"""Run both polynomial evaluators across the final 64 heights of source band 1."""

import hashlib
import json
import sys
from math import factorial
from pathlib import Path
from time import process_time

from flint import acb, arb, fmpq

from exact import C, V, accumulate, finish, median_us, prepare


HERE = Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent / "c10004-p20-slab"))
from slab import coefficients as em_source
from produce import D, GRIDS, P, UNIT, nearest, pair_times, plus, shifted, to_ball


def main():
    start = process_time()
    lambdas = [UNIT]
    for k in range(P-1):
        lambdas.append(nearest(-6*lambdas[-1],D*(k+1)))
    gammas = []
    for r in range(1,65):
        g = fmpq.bernoulli(2*r)*6**(2*r)/factorial(2*r)
        gammas.append(nearest(int(g.p)*UNIT,int(g.q)))
    cells = {"0":[1,3], "1":[5,7,9,11,13]}
    rows, truth = [], []
    seed_max = arb(0)
    worst_old = arb(0)
    old = {}
    for h in range(6337,6401):
        s = acb(arb(1)/2, arb(5*h)/64)
        seed = em_source(h,s,gammas,lambdas)
        factor = acb(1)
        for k,val in enumerate(seed):
            err = abs(factor*(s+k).zeta()-to_ball(val,122))
            if not err < arb(1)/2**102:
                raise ValueError(f"coarse coefficient {h},{k} outside budget")
            if err.upper() > seed_max:
                seed_max = err.upper()
            factor = -factor*(s+k)/(D*(k+1))
        row = {"h":h, "mixed":{}, "outputs":{}}
        reference = {}
        for cell, src in zip(cells,(seed[:20],shifted(seed)),strict=True):
            col = [[nearest(x,1<<(122-g)) for x in pair] for g,pair in zip(GRIDS,src,strict=True)]
            row["mixed"][cell] = col
            out = []
            for a in cells[cell]:
                r = 1024*a-int(cell)*C
                v = col[-1]
                for j in range(18,-1,-1):
                    v = plus(col[j],pair_times(v,r<<(GRIDS[j]-GRIDS[j+1]),0,V))
                target = s.zeta(1+arb(a)/C)
                reference[a] = target
                err = abs(to_ball(v,94)-target)
                if not 633*err < arb(1)/2**82:
                    raise ValueError(f"original endpoint {h},{a} outside budget")
                if err.upper() > worst_old:
                    worst_old = err.upper()
                old[h,a] = v
                out.append([a,*v])
            row["outputs"][cell] = out
        truth.append(reference)
        rows.append(row)
    tables = {k:prepare(rows,k,GRIDS) for k in cells}
    worst = arb(0)
    max_delta = 0
    def run():
        return {a:finish(tables[k],accumulate(tables[k],1024*a-int(k)*C))
                for k,units in cells.items() for a in units}
    for a, result in run().items():
        for j, ref in enumerate(truth):
            v = result[2*j:2*j+2]
            err = abs(to_ball(v,94)-ref[a])
            if not 633*err < arb(1)/2**82:
                raise ValueError(f"terminal-rounding endpoint {rows[j]['h']},{a} outside budget")
            max_delta = max(max_delta,max(abs(x-y) for x,y in zip(v,old[rows[j]["h"],a])))
            if err.upper() > worst:
                worst = err.upper()
    saved = HERE/"edge-slab.json"
    saved.write_bytes((json.dumps(dict(grids=GRIDS,cells=cells,rows=rows),separators=(",",":"))+"\n").encode())
    print(json.dumps(dict(first=6337,last=6400,complex_outputs=len(rows)*7,
                          degrees={k:len(t["columns"])-1 for k,t in tables.items()},
                          width_bytes={k:t["width"] for k,t in tables.items()},
                          max_coordinate_delta=max_delta,
                          largest_error_upper_balls=list(map(str,(seed_max,worst_old,worst))),
                          warm_complete_median_us=median_us(run),cpu_seconds=process_time()-start,
                          slab_sha256=hashlib.sha256(saved.read_bytes()).hexdigest()),indent=2))


if __name__=="__main__":
    main()
