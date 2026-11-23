"""Test the complete +high q10004 midpoint panel from coarse Hardy amplitudes only."""
from collections import Counter
import csv
from fractions import Fraction as Q
from hashlib import sha256
import gzip
import json
from math import prod
from pathlib import Path
from flint import arb, ctx

HERE = Path(__file__).resolve().parent
SRC = HERE.parent/"c10004-grid-repair"
LO, HI = 84184, 84199
STEP = Q(5,64)

def real(x):
    return arb(x.numerator)/x.denominator

def read(name, tick):
    with gzip.open(SRC/name,"rt",newline="") as f:
        result = {}
        for row in csv.DictReader(f,delimiter="\t"):
            key=tuple(int(row[k]) for k in (tick,"k41","k61"))
            value=arb(row["scaled_value"])
            sign=int(row["sign"])
            assert key not in result and sign in (-1,1) and sign*value>0
            result[key]=value,sign
    return result

def stencil(m,j):
    start=min(max(LO,j-(m-2)//2),HI-m+1)
    nodes=range(start,start+m)
    x=Q(2*j+1,2)
    weights=[real(prod((x-k)/(v-k) for k in nodes if k!=v)) for v in nodes]
    error_product=real(abs(prod((x-k)*STEP for k in nodes)))
    return nodes,weights,error_product

def remainder(m,b,a,nodes,error_product):
    rho=Q(2*b-1,2)
    p=Q(b+a-1,2)
    c=real(2*rho*rho).sqrt()
    factor=2*(2*arb.pi()).sqrt()*(arb(10004)/arb.pi())**real(Q(b+a,2))
    def majorant(j):
        d=real(b+2+j*STEP)
        return factor*d**real(p)*(real(p)*c/d).exp()
    return max((majorant(nodes[0]),majorant(nodes[-1])),key=lambda x:x.upper())*error_product/real(rho)**m

def main():
    ctx.prec,ctx.threads=256,1
    files=("high-signs.tsv.gz","high-midpoints.tsv.gz")
    coarse=read(files[0],"j")
    direct=read(files[1],"left_j")
    assert len(direct)==34515 and len(coarse)==36816
    frozen_hidden={key for key,(_,s) in direct.items()
        if coarse[key][1]==coarse[key[0]+1,*key[1:]][1]==-s}
    assert len(frozen_hidden)==13
    counts, hidden, best, best_meta = Counter(),Counter(),{},{}
    remainder_ranges={}
    for j in range(LO,HI):
        for m in range(2,17):
            nodes,ws,product=stencil(m,j)
            rem={(b,a):remainder(m,b,a,nodes,product) for b in range(2,6) for a in range(2)}
            for (b,a),r in rem.items():
                label=f"{m},{b},{a}"
                old=remainder_ranges.setdefault(label,[float(r.lower()),float(r.upper())])
                old[0]=min(old[0],float(r.lower()))
                old[1]=max(old[1],float(r.upper()))
            for k in range(1,40):
                for l in range(1,60):
                    key=j,k,l
                    a=(1+k+l)%2
                    poly=sum((w*coarse[u,k,l][0] for w,u in zip(ws,nodes)),arb(0))
                    target,sgn=direct[key]
                    for b in range(2,6):
                        interval=poly+arb(0,rem[b,a])
                        assert interval.overlaps(target), (key,m,b)
                        resolves=interval>0 or interval<0
                        if resolves:
                            assert sgn*interval>0
                            counts[m,b]+=1
                            hidden[m,b]+=int(key in frozen_hidden)
                        if key not in best or interval.rad()<best[key].rad():
                            best[key]=interval
                            best_meta[key]=(m,b)
    strict={key for key,z in best.items() if z>0 or z<0}
    out=dict(precision=256,scope="Un-tilted Hardy A, q=10004, 16 coarse heights, 15 midpoint intervals. Distinct nearest contiguous stencils clipped to available nodes; odd-order ties go to the right. Radius rho=b-1/2. Signed input balls and exact rational weights are evaluated with outward Arb rounding. Midpoint references only verify outputs. Narrowest adaptive interval selected using its computed radius.",
        input_sha256={name:sha256((SRC/name).read_bytes()).hexdigest() for name in files},
        script_sha256=sha256(Path(__file__).read_bytes()).hexdigest(),
        direct_midpoints=len(direct),overlap_comparisons=len(direct)*15*4,
        direct_hidden=len(frozen_hidden),adaptive_strict=len(strict),adaptive_hidden=len(strict&frozen_hidden),
        unresolved_rows=[dict(j=key[0],k41=key[1],k61=key[2],order_and_b=best_meta[key],
            reference=str(direct[key][0]),interpolation=str(best[key]),
            coarse_signs=[coarse[key][1],coarse[key[0]+1,*key[1:]][1]]) for key in sorted(direct.keys()-strict)],
        adaptive_per_interval=[[j,sum(key[0]==j for key in strict)] for j in range(LO,HI)],
        hidden_rows=[dict(j=key[0],k41=key[1],k61=key[2],strict=key in strict,
            order_and_b=best_meta[key],reference=str(direct[key][0]),interpolation=str(best[key])) for key in sorted(frozen_hidden)],
        per_order_and_b=[dict(m=m,b=b,strict=counts[m,b],hidden=hidden[m,b]) for m in range(2,17) for b in range(2,6)],
        remainder_minimum_and_maximum=remainder_ranges)
    (HERE/"strip-interpolation.json").write_text(json.dumps(out,indent=2)+"\n")
    print(out["adaptive_strict"],out["adaptive_hidden"],out["overlap_comparisons"])
    print([(r["m"],r["b"],r["strict"],r["hidden"]) for r in sorted(out["per_order_and_b"],key=lambda r:-r["strict"])[:5]])

if __name__=="__main__":
    main()
