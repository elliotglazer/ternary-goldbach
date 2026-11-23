"""Exact schoolbook circular convolution and independent analytic direct-DFT comparisons."""
import csv,hashlib,json
from pathlib import Path
from fractions import Fraction as F
from math import ceil
from flint import acb,arb,ctx

HERE=Path(__file__).resolve().parent
n=500
S=1<<307
ctx.prec=448
ctx.threads=1


def nearest(z):
    result=[]
    for x in (z.real,z.imag):
        y=x*S
        v=(y+arb(1)/2).floor().unique_fmpz()
        assert v is not None and abs(y-v)<arb(1)/2
        result.append(int(v))
    return result


def mul(a,b):
    return a[0]*b[0]-a[1]*b[1],a[1]*b[0]+a[0]*b[1]


def round_grid(z,den):
    return tuple((2*x+den)//(2*den) for x in z)


def caps(r):
    pre=n*((1+r)**4-1+r*(1+r)**2)
    return [ceil(pre*S),ceil((pre+r)*S)]


def run():
    r=[1+16*((pow(2,j,625)-1)*pow(16,-1,625)%625) for j in range(n)]
    assert len(set(r))==n and all(x%16==1 and x%625==pow(2,j,625) for j,x in enumerate(r))
    exact=[acb.exp_pi_i(acb(2*x)/10000) for x in r]
    roots=[acb.exp_pi_i(acb(2*j)/n) for j in range(n)]
    p=[nearest(acb.exp_pi_i(acb((j*j)%(2*n))/n)) for j in range(n)]
    prep=[round_grid(mul(nearest(x),c),S) for x,c in zip(exact,p)]
    kernel=[(a,-b) for a,b in p]
    worst=[0,0]
    ids=[None,None]
    path=HERE/"expected.tsv"
    old=list(csv.DictReader((HERE.parent/"c10000-bluestein/outputs.tsv").open(),delimiter="\t"))
    with path.open("w",newline="") as file:
        w=csv.writer(file,delimiter="\t",lineterminator="\n")
        w.writerow(["index","re","im","exact_post_error_grid_ceiling","rounded_post_error_grid_ceiling"])
        for k in range(n):
            a=b=0
            for j,x in enumerate(prep):
                u,v=mul(x,kernel[(k-j)%n])
                a+=u
                b+=v
            post=mul((a,b),p[k])
            rounded=round_grid(post,S*S)
            dft=sum((x*roots[(j*k)%n] for j,x in enumerate(exact)),acb(0))
            errors=[abs(acb(*post)/(S*S)-S*dft),abs(acb(*rounded)-S*dft)]
            entry=[int(e.upper().ceil().unique_fmpz()) for e in errors]
            for t,val in enumerate(entry):
                if val>worst[t]:
                    ids[t],worst[t]=k,val
            prior=old[k]
            assert int(prior["index"])==k
            assert abs(acb(int(prior["re"]),int(prior["im"]))-S*dft)<=int(prior["absolute_error_grid_units"])
            w.writerow((k,*rounded,*entry))
    # 707107/10^6 is an upper rational bound for 1/sqrt(2).
    q=F(707107,10**6)
    assert 2*q*q>1
    output=dict(grid=307,n=n,precision=ctx.prec,threads=ctx.threads,observed=worst,
                observed_indices=ids,uniform_unit_error_caps=caps(F(1,S)),
                nearest_coordinate_caps=caps(q/S),sha256=hashlib.sha256(path.read_bytes()).hexdigest())
    assert all(a<=b for a,b in zip(worst,output["nearest_coordinate_caps"]))
    (HERE/"receipt.json").write_text(json.dumps(output,indent=2)+"\n")


if __name__=="__main__":
    run()
