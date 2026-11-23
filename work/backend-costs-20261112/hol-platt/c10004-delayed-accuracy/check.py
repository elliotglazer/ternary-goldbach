"""Independent direct positive Fourier sums and phase-fixed sign checks."""
import csv
import hashlib
import json
import sys
from collections import Counter
from fractions import Fraction
from math import ceil,isqrt,prod
from pathlib import Path
from flint import arb,acb,ctx

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
sys.path.insert(0,str(HOL/"c10004-packed-transform"))
sys.path.insert(0,str(HOL/"c10004-real-transform"))
import packed
import completed as cp

S=2**81
Q=10004
ctx.prec=176
ctx.threads=1


def read(path):
    with path.open() as file:
        return list(csv.DictReader(file,delimiter="\t"))


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def normceil(x,y):
    n=x*x+y*y
    a=isqrt(n)
    return a+int(a*a!=n)


def main():
    hs=[1,2,84198,84199]
    sources=[]
    hashes={}
    for h in hs:
        f=(HOL/"c10004-reference"/f"h{h}.tsv" if h<3 else
           HOL/"c10004-high-reference"/f"j{h}-source.tsv")
        rows=read(f)
        hashes[f.name]=digest(f)
        units=[int(r["a"]) for r in rows]
        assert len(units)==4800
        for i,(r,a) in enumerate(zip(rows,units)):
            assert int(r["index"])==i and (a%4,a%41,a%61)==(1+2*(i%2),pow(6,i//2%40,41),pow(2,i//80,61))
        sources.append([(int(r["re"]),int(r["im"])) for r in rows])
    for n,roots in packed.ROOTS.items():
        for j,(x,y) in enumerate(roots):
            assert abs(acb(x,y)-S*acb.exp_pi_i(acb(2*j)/n))<1
    labels=[(k,l) for k in range(1,40) for l in range(1,60)]
    phase={}
    tau=cp.tensor([acb.exp_pi_i(acb(2*a)/Q) for a in units],cp.dft)
    w={p:z/(acb(0,1)**cp.parity(*p)*arb(Q).sqrt()) for p,z in zip(labels,tau)}
    for p,z in w.items():
        if p in phase:
            continue
        partner=(40-p[0],60-p[1])
        assert abs(z).contains(1) and w[partner].overlaps(z.conjugate())
        if z.real>-arb(1)/2:
            r=((1+z.real)/2).sqrt()
            v=acb(r,-z.imag/(2*r))
        else:
            assert z.real<arb(1)/2
            r=((1-z.real)/2).sqrt()
            v=acb(-z.imag/(2*r),r)
        phase[p]=v
        if partner!=p:
            phase[partner]=v.conjugate()
    assert all((phase[p]**2*w[p]).contains(1) for p in labels)
    depth=sum(packed.depth(n) for n in (2,40,60))
    scale=81*depth
    bound=max(abs(v) for xs in sources for z in xs for v in z)*prod(packed.bound_factor(n) for n in (2,40,60))
    layout=packed.Layout(4,bound.bit_length()+scale,0)
    xs=[(layout.pack([z[0] for z in four]),layout.pack([z[1] for z in four])) for four in zip(*sources)]
    outputs=[[] for _ in hs]
    for x,y in packed.tensor(xs,layout,True):
        for block,a,b in zip(outputs,layout.unpack(x),layout.unpack(y)):
            block.append(((a+2**(scale-1))>>scale,(b+2**(scale-1))>>scale))
    report=dict(hashes=hashes,depth=depth,nodes=[])
    for h,xs,ys in zip(hs,sources,outputs):
        start=HOL/("c10004-real-transform" if h<3 else "c10004-high-reference")
        f=start/(f"h{h}-completed.tsv" if h<3 else f"j{h}-completed.tsv")
        prior=read(f)
        hashes[f.name]=digest(f)
        direct=cp.tensor([acb(x,y) for x,y in xs],cp.dft)
        cap=4800+1+ceil(sum(normceil(x,y) for x,y in xs)*(Fraction(S+1,S)**depth-1))
        tight=0
        closest=None
        maxgap=0
        signs=Counter()
        t=arb(5*h)/64
        s=acb(arb(1)/2,t)
        factors=[]
        for par in [0,1]:
            g=(s+par)/2
            v=(acb(Q)/arb.pi())**g*g.gamma()*acb(Q)**(-s)
            factors.append(v if h<3 else v*(arb.pi()*t/4).exp())
        for p,(x,y),z,old in zip(labels,ys,direct,prior,strict=True):
            assert p==(int(old["k41"]),int(old["k61"]))
            gap=abs(acb(x,y)-z)
            radius=int(gap.upper().ceil().unique_fmpz())+4800
            maxgap=max(maxgap,radius-4800)
            assert radius<=cap
            tight=max(tight,radius)
            value=phase[p]*factors[cp.parity(*p)]*acb(arb(x,cap),arb(y,cap))/S
            assert value.imag.contains(0)
            sign=1 if value.real>0 else -1 if value.real<0 else 0
            assert sign!=0 and sign==int(old["sign"])
            signs[sign]+=1
            floor=int((abs(value.real).lower()*10**12).floor().unique_fmpz())
            if closest is None or floor<closest[0]:
                closest=(floor,p)
        report["nodes"].append(dict(h=h,uniform_grid_radius=cap,max_direct_grid_radius=tight,
                                  max_gap_to_exact_dft_of_centers=maxgap,signs=signs,
                                  smallest_abs_lower_floor_1e12=closest))
    report["audited_script_sha256"]=digest(Path(packed.__file__))
    report["root_table_sha256"]=digest(HOL/"c10004-roots/table.json")
    (HERE/"receipt.json").write_text(json.dumps(report,indent=2)+"\n")


if __name__=="__main__":
    main()
