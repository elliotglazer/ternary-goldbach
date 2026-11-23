"""Quantize a full time grid into shared block-floating intervals for signs and repairs."""
from collections import Counter
from fractions import Fraction
from hashlib import sha256
import json
from math import ceil
from pathlib import Path
import sys
from time import process_time

HERE = Path(__file__).resolve().parent
DATA = HERE.parent/"full-height-count"
sys.path.insert(0,str(DATA))
from grid import GRID_BITS,HALO
from spectrum import LABELS,parameters
from repair import SUB
from stencils import exact

TILE = 64
WIDTHS = (8,12,16,20,24,32)


def inventory():
    lines = iter((DATA/"stencils.txt").read_text().splitlines())
    kernels = []
    for i in range(int(next(lines))):
        k,r,o,d,e = map(int,next(lines).split())
        w = list(map(int,next(lines).split()))
        assert k==i and (d,w)==tuple(exact(r,o))
        kernels.append((r,o,d,e,w))
    jobs = {label:[] for label in LABELS}
    for _ in range(int(next(lines))):
        label,t,k,s = map(int,next(lines).split())
        xs = list(map(int,next(lines).split()))
        jobs[label].append((t,k,s,xs))
    assert next(lines,None) is None
    return kernels,jobs


def quantize(xs,width):
    exponent = max(0,max(abs(x) for x in xs).bit_length()+1-width)
    ys = [x>>exponent for x in xs]
    assert all(-(1<<(width-1))<=y<(1<<(width-1)) for y in ys)
    assert all(0<=x-(y<<exponent)<1<<exponent for x,y in zip(xs,ys))
    return exponent,ys


def assemble(raw,selection):
    return [quantize(raw[j:j+TILE],WIDTHS[selection[j//TILE]]) for j in range(0,len(raw),TILE)]


def failures(tiles,raw,coarse_radius,last,jobs,kernels):
    heads = [(q<<exp,1<<exp) for exp,qs in tiles for q in qs]
    bad = set()
    gridmiss=repairmiss=0
    for i in range(HALO,HALO+last+1):
        v,u = heads[i]
        if abs(v)<=coarse_radius+u:
            bad.add(i//TILE)
            gridmiss+=1
    for t,k,sg,witness in jobs:
        r,offset,d,e,w = kernels[k]
        j,o = divmod(t,SUB)
        start = j+HALO+1-r//2
        assert offset==o and raw[start:start+r]==witness
        values = heads[start:start+r]
        center = sum(wi*v for wi,(v,u) in zip(w,values,strict=True))
        # Uniform propagation of all per-sample errors by the proved l1 bound.
        error = d*(e+5*max(u for v,u in values))
        if (center if sg else -center)<=error:
            bad.update(range(start//TILE,(start+r-1)//TILE+1))
            repairmiss+=1
    return bad,(gridmiss,repairmiss)


def main():
    start=process_time()
    kernels,jobs=inventory()
    main,last,n,J,theta=parameters()
    coarse_radius=ceil(Fraction((1<<GRID_BITS)*5*n,512*4*3**theta*(1<<80)))+2
    meta=json.loads((DATA/"grid.json").read_bytes())
    results=[]
    for row,label in zip(meta["rows"],LABELS,strict=True):
        p=DATA/("grid-%d.txt"%label)
        assert sha256(p.read_bytes()).hexdigest()==row["grid_sha256"]
        raw=list(map(int,p.read_text().splitlines()))
        selection=[0]*ceil(len(raw)/TILE)
        history=[]
        while True:
            tiles=assemble(raw,selection)
            bad,miss=failures(tiles,raw,coarse_radius,last,jobs[label],kernels)
            history.append(miss)
            if not bad: break
            for j in bad:
                selection[j]+=1
                assert selection[j]<len(WIDTHS)
        blocks=[]
        payload=0
        for k,(e,vals) in enumerate(tiles):
            width=WIDTHS[selection[k]]
            bias=1<<(width-1)
            # Four sign/magnitude fields per numeral; the top and bottom fields
            # are treated identically by the HOL decoder.
            words=[sum((v+bias)<<(j*width) for j,v in enumerate(vals[i:i+4])) for i in range(0,len(vals),4)]
            payload+=width*len(vals)
            blocks.append(" ".join(map(str,[width,e,len(vals),*words])))
        f=HERE/("tiles-%d.txt"%label)
        f.write_text("\n".join(blocks)+"\n",newline="\n")
        lines=[]
        for t,k,sg,_ in jobs[label]:
            r,o,d,e,w=kernels[k]
            lines.append(" ".join(map(str,[t,k,r,o,d,e,sg])))
        jobfile=HERE/("jobs-%d.txt"%label)
        jobfile.write_text("\n".join(lines)+"\n",newline="\n")
        results.append(dict(label=label,tiles=len(tiles),samples=len(raw),head_bits=payload,
                            precision_histogram=dict(Counter(WIDTHS[s] for s in selection)),failed=history,
                            input_sha256=row["grid_sha256"],tiles_sha256=sha256(f.read_bytes()).hexdigest(),
                            jobs_sha256=sha256(jobfile.read_bytes()).hexdigest()))
    out=dict(main=main,last=last,halo=HALO,grid_bits=GRID_BITS,coarse_radius=coarse_radius,
             results=results,cpu=process_time()-start,
             sha256={p.name:sha256(p.read_bytes()).hexdigest() for p in (DATA/"grid.json",DATA/"stencils.txt",DATA/"packets.txt")})
    (HERE/"inputs.json").write_text(json.dumps(out,indent=2)+"\n")
    print(results,flush=True)


if __name__=="__main__":
    main()
