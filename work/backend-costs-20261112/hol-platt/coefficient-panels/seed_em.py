"""Produce 128-cell Taylor seeds with finite sums and explicit Euler–Maclaurin errors."""
from fractions import Fraction
from math import comb,factorial,prod
from pathlib import Path
from statistics import mean
import json

from flint import arb,acb,ctx
from panel import HERE,ORDER,OUTPUT_BITS,nearest,seed,timed
from normalize import supplied,translated

ORDERS=(8,16,24,32,48,64,96)


def bernoulli_coeffs(last):
    b=[Fraction(1)]
    for n in range(1,2*last+1):
        b.append(-sum(comb(n+1,j)*v for j,v in enumerate(b))/(n+1))
    return [arb(v.numerator)/(v.denominator*factorial(2*i)) for i,v in enumerate(b[::2])]


def first(limit,ok):
    if not ok(limit):
        return None
    lo,hi=-1,limit
    while hi-lo>1:
        mid=(lo+hi)//2
        if ok(mid): hi=mid
        else: lo=mid
    return hi


def schedule(f,hi,D,p,r):
    h=1+(5*(hi-1)+63)//64
    factor=Fraction(1)
    tasks=[]
    for m in range(D+1):
        top=factor.numerator<<(p+5)
        bot=factor.denominator
        candidates=[]
        if m:
            # At x = a+N the absolute series tail is <= x^-m + 2*x^(1-m)/(2m-1).
            N=first(20000,lambda n:top*(2*m-1+2*(1+n)) < bot*(2*m-1)*(1+n)**m)
            if N is not None:
                candidates.append((N,N,0))
        for L in ORDERS:
            numer=4*top*prod(range(h+m,h+m+2*L))
            denom=bot*6**(2*L)
            N=first(20000,lambda n:numer < denom*(1+n)**(m+2*L-1))
            if N is not None:
                candidates.append((N+4*L,N,L))
        _,N,L=min(candidates)
        tasks.append((N,L))
        factor*=Fraction(r*(h+m),f*(m+1))
    return tasks


def calculate(f,center,j,r,p,tasks,bern):
    s=acb(arb(1)/2,arb(j*5)/64)
    a=1+arb(center)/f
    pool=max(n for n,l in tasks)+1
    X=[a+n for n in range(pool)]
    inv=[1/x for x in X]
    phases=[(-s*x.log()).exp() for x in X]
    cs=[]
    fac=acb(1)
    for m,(n,L) in enumerate(tasks):
        z=s+m
        head=sum((phases[k]*inv[k]**m for k in range(n)),acb(0))
        if L:
            step=z*inv[n]
            tail=X[n]/(z-1)+arb(1)/2
            for ell in range(1,L+1):
                tail+=bern[ell]*step
                if ell<L:
                    step*=(z+2*ell-1)*(z+2*ell)*inv[n]**2
            head+=phases[n]*inv[n]**m*tail
        value=fac*head
        x,y=nearest(value.real,p),nearest(value.imag,p)
        # The uniform analytic remainder is < 1/32 seed-grid unit.
        assert abs(value*(1<<p)-acb(x,y))+arb(1)/32 < 1
        cs.append((x,y))
        fac*=-(s+m)*r/(f*(m+1))
    return cs


def main():
    ctx.prec,ctx.threads=440,1
    original=json.loads((HERE/"panels.json").read_bytes())["bands"]
    variant=next(z for z in json.loads((HERE/"normalized.json").read_bytes()) if z["group_width"]==128)
    bern=bernoulli_coeffs(max(ORDERS))
    rows=[]
    for b,v in zip(original,variant["bands"],strict=True):
        f,D,p=b["f"],v["degree"],v["seed_fraction_bits"]
        r=64
        ops=schedule(f,b["hi"],D,p,r)
        panels=[]
        for panel in b["panels"]:
            center=panel["first_cell"]//128*128+r
            j=panel["j"]
            cs,cpu,wall,reps=timed(lambda:calculate(f,center,j,r,p,ops,bern))
            ref=supplied(f,center,j,r,D,p)
            delta=max(abs(u-v) for x,y in zip(cs,ref,strict=True) for u,v in zip(x,y,strict=True))
            assert delta<=1
            output_delta = 0
            for ix in (0,42,85,127):
                got = translated(cs,r,ix-r,p)
                direct = seed(f,center-r+ix,j,ORDER-1,OUTPUT_BITS)
                output_delta = max(output_delta, max(abs(u-v) for a,b in zip(got,direct,strict=True)
                                                     for u,v in zip(a,b,strict=True)))
            assert output_delta <= 1
            panels.append(dict(center=center,j=j,cpu_seconds=cpu,elapsed_seconds=wall,reps=reps,
                               max_coordinate_delta=delta,max_output_delta=output_delta))
        groups=v["groups"]
        row=dict(band=b["band"],degree=D,p=p,groups=groups,panels=panels,tasks=ops,
            head_terms_per_group=sum(n for n,l in ops),distinct_phases_per_group=1+max(n for n,l in ops),
            em_corrections_per_group=sum(l for n,l in ops),zero_terms=sum((n,l)==(0,0) for n,l in ops),
            native_hours=groups*mean(q["cpu_seconds"] for q in panels)/3600)
        rows.append(row)
        print(row["band"],row["distinct_phases_per_group"],row["head_terms_per_group"],round(row["native_hours"]),flush=True)
    out=dict(group_width=128,bands=rows,native_hours=sum(z["native_hours"] for z in rows),
        head_terms=sum(z["groups"]*z["head_terms_per_group"] for z in rows),
        phase_values=sum(z["groups"]*z["distinct_phases_per_group"] for z in rows),
        em_corrections=sum(z["groups"]*z["em_corrections_per_group"] for z in rows))
    (HERE/"seed-em.json").write_text(json.dumps(out,indent=2)+"\n")


if __name__=="__main__":
    main()
