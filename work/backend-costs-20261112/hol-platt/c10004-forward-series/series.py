"""Batched exact rational Horner via the integer forward-difference generating function."""
import json,math,sys
from collections import Counter
from functools import lru_cache
from pathlib import Path
from time import perf_counter
from flint import arb,acb,ctx,fmpz

HERE=Path(__file__).resolve().parent
GRIDS=[94,94,94,94,91,89,89,89,83,81,81,81,75,73,73,73,65,65,65,65]
ctx.prec=200
ctx.threads=1


def prepare(c,k,coeff):
    d=max(j for j,z in enumerate(coeff) if any(z))
    a=max(1,(2*c*k-c)//2048+1)
    b=min(c-1,(2*c*k+c)//2048)
    v=2*c
    # A lower-end tie belongs to the previous anchor; an upper tie belongs here.
    assert all((2048*x+c-1)//(2*c)==k for x in (a,b))
    r=1024*a-c*k
    den=v**d
    D=[[z[t]*(1<<(94-GRIDS[j]))*v**(d-j) for j,z in enumerate(coeff[:d+1])] for t in (0,1)]
    R=max(abs(r),abs(1024*b-c*k))
    bound=max(sum(abs(x)*R**j for j,x in enumerate(z)) for z in D)
    w=8*((bound.bit_length()+1+7)//8)
    return a,b,r,den,D,w


def horner(z,r):
    y=z[-1]
    for x in reversed(z[:-1]):
        y=y*r+x
    return y


@lru_cache(None)
def kernel(L,d,w):
    word=w//8
    series=int.from_bytes(b"".join(math.comb(i+d,d).to_bytes(word,"little") for i in range(L)),"little")
    half=1<<(w-1)
    bias=int.from_bytes(half.to_bytes(word,"little")*L,"little")
    return series,bias,(1<<(L*w))-1,half


def scalar(c,k,coeff):
    a,b,r,den,D,_=prepare(c,k,coeff)
    out=[]
    for n in range(a,b+1):
        if math.gcd(n,c)==1:
            out.append((n,*[(2*horner(z,r)+den)//(2*den) for z in D]))
        r+=1024
    return out


def batched(c,k,coeff,times,gmp=False,verify=False):
    t=perf_counter()
    a,b,r,den,D,w=prepare(c,k,coeff)
    L=b-a+1
    d=len(D[0])-1
    assert L>d
    series,bias,mask,half=kernel(L,d,w)
    times["prepare_and_kernel"]+=perf_counter()-t
    raws=[]
    word=w//8
    difference=[(-1)**i*math.comb(d+1,i) for i in range(d+1)]
    for z in D:
        t=perf_counter()
        seeds=[horner(z,r+1024*i) for i in range(d+1)]
        U=[sum(difference[k]*seeds[i-k] for k in range(i+1)) for i in range(d+1)]
        packed=0
        for x in reversed(U):
            packed=(packed<<w)+x
        times["seed_and_difference"]+=perf_counter()-t
        t=perf_counter()
        product=int(fmpz(packed)*fmpz(series)) if gmp else packed*series
        raws.append(((product+bias)&mask).to_bytes(L*word,"little"))
        times["large_integer_and_bytes"]+=perf_counter()-t
    t=perf_counter()
    out=[]
    for i in range(L):
        if verify:
            for z,raw in zip(D,raws):
                off=i*word
                assert int.from_bytes(raw[off:off+word],"little")-half==horner(z,r+i*1024)
        if math.gcd(a+i,c)==1:
            coord=[]
            for raw in raws:
                off=i*word
                y=int.from_bytes(raw[off:off+word],"little")-half
                coord.append((2*y+den)//(2*den))
            out.append((a+i,*coord))
    times["decode_filter_divide"]+=perf_counter()-t
    return out,d,w


def verify_power(c,k,coef,a,re,im):
    A,b,r,den,D,_=prepare(c,k,coef)
    r=1024*a-k*c
    for z,val in zip(D,(re,im)):
        value=sum(v*r**j for j,v in enumerate(z))
        assert (2*value+den)//(2*den)==val


def benchmark(c,h,cells):
    times=Counter()
    kernel.cache_clear()
    t=perf_counter()
    old={k:scalar(c,k,v) for k,v in cells.items()}
    scalar_t=perf_counter()-t
    t=perf_counter()
    data={k:batched(c,k,v,times) for k,v in cells.items()}
    batch_t=perf_counter()-t
    kernel.cache_clear()
    gmp_times=Counter()
    t=perf_counter()
    fast={k:batched(c,k,v,gmp_times,gmp=True) for k,v in cells.items()}
    gmp_t=perf_counter()-t
    total=0
    worst=0.
    s=acb(arb(1)/2,arb(5*h)/64)
    for k,(out,d,w) in data.items():
        assert out==old[k]
        assert fast[k]==data[k]
        assert batched(c,k,cells[k],Counter(),verify=True)[0]==out
        total+=len(out)
        for a,x,y in out[::max(1,len(out)//2)]:
            verify_power(c,k,cells[k],a,x,y)
            err=abs(acb(x,y)/2**94-s.zeta(1+arb(a)/c))
            assert 633*err<arb(1)/2**82
            worst=max(worst,float(err.upper()))
    return dict(c=c,h=h,cells=len(cells),units=total,degrees=sorted(set(z[1] for z in data.values())),
                widths=sorted(set(z[2] for z in data.values())),scalar_wall=scalar_t,series_wall=batch_t,
                phases=times,gmp_wall=gmp_t,gmp_phases=gmp_times,worst_oracle_sample=worst,
                kernel_cache=str(kernel.cache_info()))


def main():
    low=json.loads((HERE.parent/"c10004-p20-source/h1-mixed.json").read_text())
    high=json.loads((HERE.parent/"c10004-exact-horner/edge-slab.json").read_text())
    low={int(k):v for k,v in low.items()}
    results=[benchmark(c,1,low) for c in (131071,265800)]
    for row in [high["rows"][0],high["rows"][-1]]:
        results.append(benchmark(131072,row["h"],{int(k):v for k,v in row["mixed"].items()}))
    (HERE/"receipt.json").write_text(json.dumps(results,indent=2)+"\n")


if __name__=="__main__":
    main()
