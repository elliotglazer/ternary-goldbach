"""Uniform all-cell certificate for zero tails of the stored band-1 K20/b94 integer jet."""
import hashlib,json
from collections import Counter
from fractions import Fraction as F
from functools import lru_cache
from math import isqrt
from pathlib import Path

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parents[2]/"qrh-campaign/agents"
BASE=AGENTS/"integration"


def pascal(a,inject):
    a=list(a)
    for i in range(25,-1,-1):
        for j in range(i,min(25,i+19)+1):
            a[j]+=a[j+1]/2+inject
    return a[:20]


@lru_cache(None)
def envelope(h):
    fac=F(1)
    # Degree zero is unused in the bound for positive degrees of the triangular shift.
    ideal=[F(0)]
    for j in range(1,27):
        sq=(64*j-32)**2+(5*h)**2
        root=isqrt(sq<<48)+1
        fac*=F(root,2**24*64*512*j)
        ideal.append(fac*(1+F(2,2*j-1)))
    # Include the actual per-slot uncertainty before translating, and account for
    # every rounded update after the scale by one half.
    return pascal([x+F(1,2**102) for x in ideal],F(1,2**110))


def highest(row):
    return max((j for j,z in enumerate(row) if any(z)),default=0)


def recalc(row,a,k,grids,degree):
    v=row[degree]
    for j in range(degree-1,-1,-1):
        fac=(1024*a-k*10004)<<(grids[j]-grids[j+1])
        v=[n+(2*fac*x+20008)//40016 for n,x in zip(row[j],v)]
    return list(v)


def main():
    frontier=json.loads((BASE/"guarded_residue_evaluation_frontier_20261111.json").read_bytes())
    profile=frontier["selected_records"]["band1_K20_b94"]
    grids=profile["grids"]
    limits={}
    for j in range(1,20):
        lo,hi=-1,6401
        while hi-lo>1:
            h=(lo+hi)//2
            if envelope(h)[j]<F(1,2**(1+grids[j])):
                lo=h
            else:
                hi=h
        limits[j]=lo
    degrees=[max([0]+[j for j in limits if h>limits[j]]) for h in range(6401)]
    manifest=BASE/"transform_structural_manifest_20261111.json"
    content=manifest.read_bytes()
    m=json.loads(content)
    totals=[]
    for scenario,extra in enumerate(m["extras"]):
        for guards in (0,41):
            diff=Counter()
            for c,phi,_,_,J,_,heights in m["conductors"]:
                assert heights[scenario*5]==min(6401,J+extra)
                stop=min(6401,J+extra+guards)
                diff[0]+=phi
                diff[stop]-=phi
            freq=Counter()
            weight=0
            for h,d in enumerate(degrees):
                weight+=diff[h]
                freq[d]+=weight
            n=sum(freq.values())
            saved=sum((19-d)*w for d,w in freq.items())
            stageprice={key:sum(w*sum(s[key] for s in profile["stages"] if s["j"]>=d)
                                for d,w in freq.items()) for key in ["product_events","addition_events"]}
            totals.append(dict(extra=extra,guards=guards,weights_by_effective_degree=freq,residues=n,
                               stages_saved=saved,total_stages=19*n,template_savings=stageprice))
    assert totals[0]["residues"]==44637243437690
    assert totals[1]["residues"]==44637243437690+101875674550
    mixed=json.loads((HERE.parent/"c10004-p20-source/h1-mixed.json").read_text())
    h1_counts=Counter(highest(row) for row in mixed.values())
    outputs=json.loads((HERE.parent/"c10004-p20-source/h1-horner.json").read_text())
    for _,a,k,x,y in outputs:
        row=mixed[str(k)]
        assert highest(row)<=degrees[1]
        assert recalc(row,a,k,grids,highest(row))==recalc(row,a,k,grids,degrees[1])==[x,y]
    slab=json.loads((HERE.parent/"c10004-p20-slab/slab.json").read_text())
    slab_counts=Counter()
    slab_by_height=[]
    for r in slab["rows"]:
        actual={}
        for k,row in r["mixed"].items():
            d=highest(row)
            actual[k]=d
            slab_counts[d]+=1
            assert d<=degrees[r["h"]]
            for a,x,y in r["outputs"][k]:
                assert recalc(row,a,int(k),grids,d)==recalc(row,a,int(k),grids,degrees[r["h"]])==[x,y]
        slab_by_height.append([r["h"],actual])
    result=dict(manifest_sha256=hashlib.sha256(content).hexdigest(),degree_zero_through_height_index=limits,
                uniform_height_counts=Counter(degrees),scenarios=totals,h1_all_anchor_actual=h1_counts,
                h1_guaranteed_degree=degrees[1],slab_actual=slab_counts,slab_height_degrees=slab_by_height)
    (HERE/"counts.json").write_text(json.dumps(result,indent=2)+"\n")


if __name__=="__main__":
    main()
