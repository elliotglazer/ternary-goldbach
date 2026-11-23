"""Uniform rational arithmetic for the shifted-Hurwitz residue-source envelope."""
from fractions import Fraction as F
from functools import lru_cache
from pathlib import Path
from time import process_time
import hashlib
import json
import sys

HERE=Path(__file__).resolve().parent
WIDE=HERE.parent/"wide-band-slab"
S,Q=1<<94,1<<112
WIDTH=1<<119
AMPLIFY=633*(1<<82)

@lru_cache(maxsize=None)
def bounds(j,grid,d):
    h=(5*j+63)//64+1
    first=F(2)
    coeff=F(1)
    norm=F(0)
    for m in range(d):
        first*=F(h+m,2*grid*(m+1))
        if m+1<d:
            coeff*=F(2*(h+m),grid*(m+1))
            # |zeta(1/2+m+1+it,a)| <= 1+1/(m+1/2) <= 3, 1<=a<=2.
            # Final rounding plus the optional grouped-seed translation (< 2^-110)
            # can change the l1 bound by fewer than two grid94 units.
            norm+=6*S*coeff+2
    ratio=F(h+d,2*grid*(d+1))
    if ratio>=1: return None
    rem=first/(1-ratio)
    magnitude=2*S*(3+2*h)+2+norm
    bound=rem+(F(4,3)+F(3,4)+F(2,3)*norm/Q)/S
    return bound*AMPLIFY,magnitude,rem*AMPLIFY

def last_admitted(grid,degree,jmax):
    lo,hi=-1,jmax+1
    while hi-lo>1:
        mid=(lo+hi)//2
        r=bounds(mid,grid,degree)
        if r is not None and r[0]<1 and r[1]<WIDTH-2:
            lo=mid
        else:
            hi=mid
    return lo

def main():
    from flint import arb,acb,ctx
    sys.path.insert(0,str(WIDE))
    from prepare import coefficients
    ctx.prec,ctx.threads=256,1
    jmax=84880
    result={}
    for grid in [512,1024,2048,4096,8192,16384]:
        result[grid]={d:last_admitted(grid,d,jmax) for d in (16,18,20,22,24,26,28,32)}
    full=bounds(jmax,16384,20)
    assert full[0]<1 and full[1]<WIDTH-2
    samples=[]
    # Grid nodes 0, 1/2 and 1 exercise extreme Hurwitz shifts at the new ceiling.
    # The dyadic displacement is chosen inward at each endpoint, keeping a+shift>=1.
    start=process_time()
    for j in (84241,84880):
        for k,offset in ((0,1),(8192,-1),(16384,-1)):
            grid=16384
            s,row,local=coefficients(grid,k,j)
            assert local*AMPLIFY<=bounds(j,grid,20)[0]
            w=[Q]
            for m in range(1,20):
                w.append((2*w[-1]*offset+4)//8)
            target=arb(1)+arb(k)/grid+arb(offset)/(2*grid)
            centers=[(2*sum(v[i]*a for v,a in zip(row,w,strict=True))+Q)//(2*Q) for i in (0,1)]
            direct=s.zeta(target)
            delta=abs(direct-acb(*centers)/S)
            assert delta<arb(local.numerator)/local.denominator
            samples.append(dict(index=j,anchor=k,offset_sign=offset,radius_fraction=float(local*AMPLIFY),
                                true_difference_upper=str(delta),centers=centers))
    r=dict(highest_height_index=jmax,grid=16384,terms=20,amplification=AMPLIFY,
           uniform_fraction=float(full[0]),uniform_fraction_exact=str(full[0]),
           tail_fraction=float(full[2]),normalized_total_l1_upper=float(full[1]/WIDTH),
           tested_sites=samples,native_cpu_seconds=process_time()-start,
           last_admitted_height_indices_by_grid_and_terms=result,
           source_sha256=hashlib.sha256((WIDE/"prepare.py").read_bytes()).hexdigest())
    (HERE/"bounds.json").write_text(json.dumps(r,indent=2)+"\n")
    print("worst fraction",r["uniform_fraction"],"l1 width use",r["normalized_total_l1_upper"])
    print("term cutoff by grid",result,flush=True)

if __name__=="__main__": main()
