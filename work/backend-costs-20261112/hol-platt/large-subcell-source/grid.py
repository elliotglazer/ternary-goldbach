"""Price subcell counts and bound the error against the exact stored polynomial."""
import hashlib
import json
import sys
from fractions import Fraction as F
from math import comb
from pathlib import Path

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
sys.path.insert(0, str(HOL/"c10004-effective-degree"))
from count import envelope

GRIDS = (94,94,94,94,91,89,89,89,83,81,81,81,75,73,73,73,65,65,65,65)
WORLD = HOL.parents[1]/"qrh-campaign/agents/integration/transform_structural_manifest_20261111.json"
SCALE = 1<<94
GUARD = 8


def cap_at(h):
    # GRID94 integers, one coordinate. The input bound includes the coarse
    # error and midpoint updates. Then round once to the assigned integer grid.
    return [F(0)]+[val*SCALE + F(1 << (94-b),2)
                    for b,val in zip(GRIDS[1:],envelope(h)[1:],strict=True)]


def degree_loss(caps, subdivision):
    # Translate around u in [-1/4,1/4]. The independent local variable s
    # is in [-1/2,1/2] and z = u+s/(2*subdivision).
    size = len(caps)
    values = [sum(comb(j,l)*caps[j]*F(1,4)**(j-l) for j in range(l,size)) *
              F(1,4*subdivision)**l for l in range(1,size)]
    for d in range(0,size):
        tail = sum(values[d:],F(0))
        if tail < F(1,64):
            return d,tail
    raise AssertionError


def rnd(a,b):
    return (2*a+b)//(2*b)


def build(coeffs,cell_num,K,d):
    # coeffs are original grid94 integers. New integer coefficients use
    # eight guard bits. Translate exactly, then round once per coefficient.
    v=2*K
    old_d=len(coeffs)-1
    den=v**old_d
    return [rnd((1<<GUARD)*sum(comb(j,l)*coeffs[j]*cell_num**(j-l)*
                               v**(old_d-j) for j in range(l,old_d+1)),den)
            for l in range(d+1)]


def trial(c,k,mix,K,d):
    from math import gcd
    cols=[[x<<(94-b) for x in pair] for b,pair in zip(GRIDS,mix,strict=True)]
    coords=list(zip(*cols))
    units=range(max(1,(c*(2*k-1))//2048+1),min(c-1,(c*(2*k+1))//2048)+1)
    used={}
    max_err=F(0)
    differing=total=0
    for a in units:
        if gcd(a,c)>1:
            continue
        z=F(1024*a-c*k,2*c)
        off=rnd((2*K)*z.numerator,z.denominator)
        s=2*K*z-off
        assert abs(s)<=F(1,2) and abs(F(off,2*K))<=F(1,4)
        if off not in used:
            used[off]=[build(cs,off,K,d) for cs in coords]
        for xs,ys in zip(coords,used[off],strict=True):
            before=sum(y*z**j for j,y in enumerate(xs))
            after=sum(y*s**j for j,y in enumerate(ys))/(1<<GUARD)
            max_err=max(max_err,abs(before-after))
            differing += rnd(before.numerator,before.denominator)!=rnd(after.numerator,after.denominator)
        total+=1
    return dict(c=c,cell=k,complex=total,prefinal_max_delta_grid94=float(max_err),
                rounded_coordinate_differences=differing)


def main():
    manifest=json.loads(WORLD.read_bytes())
    low=json.loads((HOL/"c10004-p20-source/h1-mixed.json").read_bytes())
    edge=json.loads((HOL/"c10004-exact-horner/edge-slab.json").read_bytes())
    weights=[0]*6402
    for c,phi,_,_,last,_,_ in manifest["conductors"]:
        weights[0]+=phi
        weights[min(6401,last+41)]-=phi
    for i in range(1,len(weights)):
        weights[i]+=weights[i-1]
    assert sum(weights)==44739119112240
    # Degree chosen for the largest h in its stratum. Uniform stored bounds
    # increase with h. At actual zero tails the bound can improve further.
    ends=[1,64,256,1024,2048,4096,6400]
    caps={last:cap_at(last) for last in ends}
    data={}
    for K in (16,64,256,1024,4096,16384,65536):
        by_height=[]
        start=0
        stages=0
        pairs=0
        for end in ends:
            d,err=degree_loss(caps[end],K)
            w=sum(weights[start:end+1])
            by_height.append([start,end,d,float(err),w])
            stages+=w*d
            # At coarse boundaries the shifted approximants on either side
            # may differ. Preserve distinct owners per original cell.
            # First and last cells each cover half the usual interval.
            # Interior cells need K+1 nodes including the two boundary nodes.
            nodes=1024*K+1025
            pairs+=(end-start+1)*(d+1)*nodes
            start=end+1
        data[K]=dict(degrees=by_height,stages=stages,mean_degree=stages/sum(weights),
                     precomputed_complex_coefficients=pairs,
                     mean_uses_per_coefficient=sum(weights)/pairs)
    samples=[]
    for c,h,k,source in [(131071,1,512,low),(265800,1,512,low),
                         (131068,6400,1,edge["rows"][-1]["mixed"])]:
        for K in (256,1024,4096):
            d,_=degree_loss(caps[h],K)
            samples.append(dict(h=h,K=K,degree=d,**trial(c,k,source[str(k)],K,d)))
    return dict(grid=GRIDS,guard_bits=GUARD,strict_uniform_error_before_final_round_grid94="1/64+1/256",
                band1_complex=sum(weights),designs=data,spot_checks=samples,
                input_hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in
                              [WORLD,HOL/"c10004-effective-degree/count.py",Path(__file__)]})


if __name__=="__main__":
    result=main()
    (HERE/"grid.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:[round(v["mean_degree"],2),round(v["mean_uses_per_coefficient"],1)]
                      for k,v in result["designs"].items()}))
