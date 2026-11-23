"""Exact variable-radius interpolation on selective p24/p28 character transforms."""
import csv
from fractions import Fraction as F
from hashlib import sha256
import json
from math import prod
import sys
from pathlib import Path
from flint import acb,arb,ctx
from strip_interpolation import HERE,SRC,LO,HI,STEP,real,remainder,read

sys.path.insert(0,str(SRC))
from complete import phases, factors

def nearest(z,scale):
    rounded=int((z*scale+arb(1)/2).floor().unique_fmpz())
    assert abs(z*scale-rounded)<1
    return rounded

def dot_ball(rows,roots,pr,fa,p):
    # One unit coordinate error for either input, so the product error in
    # either component is at most |x|+|y|+|u|+|v|+2 in grid-squared units.
    scale=1<<p
    re=im=error=0
    for (x,y),(u,v) in zip(rows,roots,strict=True):
        re+=x*u-y*v
        im+=x*v+y*u
        error+=abs(x)+abs(y)+abs(u)+abs(v)+2
    r,i=(re+scale//2)//scale,(im+scale//2)//scale
    e=(error+scale-1)//scale+1
    x,y=pr
    f,g=fa
    a,b=x*f-y*g,x*g+y*f
    center=a*r-b*i
    radius=(abs(a)+abs(b))*e+(abs(x)+abs(y)+abs(f)+abs(g)+2)*(abs(r)+abs(i)+2*e)
    return F(center,scale**3),F(radius,scale**3)

def main():
    ctx.prec,ctx.threads=256,1
    saved=json.loads((HERE/"strip-interpolation.json").read_bytes())
    tests=[(r["j"],r["k41"],r["k61"]) for r in saved["hidden_rows"]+saved["unresolved_rows"]]
    pairs={t[1:] for t in tests}
    _,phases_by_pair=phases()
    phase={};roots={};balls={};pins={}
    for p in [24,28]:
        s=1<<p
        for pair in pairs:
            w=phases_by_pair[pair]
            phase[p,pair]=tuple(nearest(z,s) for z in (w.real,w.imag))
            k,l=pair
            tab=[]
            circle=[acb.exp_pi_i(acb(2*t)/120) for t in range(120)]
            fixed=[(nearest(z.real,s),nearest(z.imag,s)) for z in circle]
            for i in range(4800):
                tab.append(fixed[(60*(i%2)+3*k*(i//2%40)+2*l*(i//80))%120])
            roots[p,pair]=tab
    high=read("high-signs.tsv.gz","j")
    mid=read("high-midpoints.tsv.gz","left_j")
    archive=json.loads((SRC/"adaptive.json").read_bytes())
    source_hash={r["j"]:r["reference_sha256"] for r in archive["nodes"]}
    for j in range(LO,HI+1):
        path=SRC/f"j{j}-source.tsv"
        pins[path.name]=sha256(path.read_bytes()).hexdigest()
        assert pins[path.name]==source_hash[j]
        with path.open() as stream:
            source=[(int(r["re"]),int(r["im"])) for r in csv.DictReader(stream,delimiter="\t")]
        t=real(j*STEP)
        v=acb(arb(1)/2,t)
        part=[z*acb(10004)**(-v) for z in factors(t)]
        for p in [24,28]:
            s=1<<p
            d=1<<(81-p)
            # Original p81 samples were within 1/2 unit, so re-rounding to
            # the p grid incurs at most 1/2 + 2^(p-82) < one unit.
            rows=[((r+d//2)//d,(i+d//2)//d) for r,i in source]
            fa=[(nearest(z.real,s),nearest(z.imag,s)) for z in part]
            for pair in pairs:
                a=(1+sum(pair))%2
                val,rad=dot_ball(rows,roots[p,pair],phase[p,pair],fa[a],p)
                balls[j,pair,p]=val,rad
                assert (real(val)+arb(0,real(rad))).overlaps(high[j,*pair][0])
    results=[]
    for j,k,l in tests:
        pair=k,l
        nodes=range(LO,HI+1)
        x=F(2*j+1,2)
        w=[prod((x-u)/(n-u) for u in nodes if u!=n) for n in nodes]
        rem=remainder(16,2,(1+k+l)%2,nodes,real(abs(prod((x-n)*STEP for n in nodes))))
        bits=[24]*16
        def estimate():
            z=sum(a*balls[n,pair,p][0] for n,a,p in zip(nodes,w,bits))
            r=sum(abs(a)*balls[n,pair,p][1] for n,a,p in zip(nodes,w,bits))
            iv=real(z)+arb(0,rem+real(r))
            return iv,int(iv>0)-int(iv<0),real(abs(z)+r)<=rem.lower()
        corrections=[]
        initial=estimate()[1]
        while True:
            iv,sg,saturated=estimate()
            assert iv.overlaps(mid[j,k,l][0])
            if sg or saturated or len(corrections)==16: break
            n=max((n for n in nodes if bits[n-LO]==24),key=lambda n: abs(w[n-LO])*balls[n,pair,24][1])
            bits[n-LO]=28
            corrections.append(n)
        assert not sg or sg==mid[j,k,l][1]
        results.append(dict(j=j,pair=pair,initial_sign=initial,final_sign=sg,corrected_ticks=corrections,
                            proved_sample_refinement_useless=saturated,
                            lower=iv.lower().str(18),upper=iv.upper().str(18)))
    out=dict(scope="15 reference-selected stress windows (13 hidden/2 edge); exact rational center and weighted node radii; m16 b2; direct p24 and p28 sums over every actual Hurwitz residue for just the selected labels. This is a new valid lower-precision direct projection, not the packed cyclic p24 transform's tighter or looser radius; same q131071 re-computation prices are separate.",
             coarse_crosschecks=len(balls),rows=results,source_sha256=pins,script_sha256=sha256(Path(__file__).read_bytes()).hexdigest())
    (HERE/"variable-radius-retry.json").write_text(json.dumps(out,indent=2)+"\n")
    print([(r["j"],r["pair"],r["initial_sign"],r["final_sign"],len(r["corrected_ticks"])) for r in results])

if __name__=="__main__":
    main()
