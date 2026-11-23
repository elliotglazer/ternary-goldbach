"""Count parity-specific quotient transforms and check a finite-field Fourier model."""
import hashlib
import json
from collections import Counter
from fractions import Fraction
from itertools import permutations,product
from math import gcd,lcm,prod
from pathlib import Path

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parents[2]/"qrh-campaign/agents/prime-estimates"
PRODUCER=AGENTS/"small_family_minimal_theta_20261111.py"
SOURCE=AGENTS/"sign_only_minimal_theta_nonprincipal_schedule_20261111.json"


def factors(n):
    out=[]
    p=2
    while p*p<=n:
        e=0
        while n%p==0:
            n//=p
            e+=1
        if e:
            out.append((p,e))
        p+=1
    if n>1:
        out.append((n,1))
    return out


def layout(c):
    ds,omit,active=[],[],[]
    for p,e in factors(c):
        if p!=2:
            d=(p-1)*p**(e-1)
            ds.append(d)
            omit.append(d if e==1 else p)
            active.append(True)
        elif e==2:
            ds.append(2);omit.append(2);active.append(True)
        elif e>2:
            ds.extend([2,2**(e-2)])
            omit.extend([0,2])
            active.extend([True,False])
        else:
            raise ValueError("excluded conductor")
    keep=[n-n//q if q else n for n,q in zip(ds,omit,strict=True)]
    return ds,omit,active,keep


def cost(d):
    if d&(d-1)==0:
        return (d*(d.bit_length()-1)//2,0)
    P=1<<(2*d-2).bit_length()
    return P*(P.bit_length()-1),P+2*d


def pivot_candidates(ds,active):
    v=min((d&-d) for d,a in zip(ds,active,strict=True) if a)
    return [i for i,n in enumerate(ds) if active[i] and n&-n==v]


def budget(c,N):
    ds,omit,active,keep=layout(c)
    phi=prod(ds)
    J=(25*N+191)//192
    parities=[1] if c in (3,4) else [0] if c==12 else [0,1]
    P=len(parities)
    best=None
    for i in pivot_candidates(ds,active):
        dim=ds[i]//2
        for order in permutations(j for j in range(len(ds)) if j!=i):
            x=phi//2
            b=p=0
            for j in order:
                a,t=cost(ds[j])
                b+=x//ds[j]*a
                p+=x//ds[j]*t
                x=x//ds[j]*keep[j]
            a,t=cost(dim)
            b+=x//dim*a
            p+=x//dim*t
            twists=(x//dim)*(dim-1)*int(1 in parities)
            # Comparison uses lexicographic operation counts, then odd twists.
            key=(P*b,P*p,twists,i,order)
            if best is None or key<best:
                best=key
    b,p,twists,i,order=best
    baseline_b=baseline_p=0
    x=phi
    for j,n in enumerate(ds):
        a,t=cost(n)
        baseline_b+=P*x//n*a
        baseline_p+=P*x//n*t
        x=x//n*keep[j]
    return (Counter({k:v*(J+1) for k,v in dict(original_projected_b=baseline_b,
            original_projected_points=baseline_p,folded_b=b,folded_points=p,
            pre_twist_complex_products=twists,pair_adds=P*phi//2).items()}),i,order)


def prime(p):
    return len(factors(p))==1 and factors(p)[0]==(p,1)


def check(c):
    ds,omit,active,keep=layout(c)
    i=pivot_candidates(ds,active)[0]
    N=lcm(*ds)
    p=N+1
    while not prime(p): p+=N
    root=next(y for x in range(2,p) for y in [pow(x,(p-1)//N,p)]
              if all(pow(y,N//pp,p)!=1 for pp,_ in factors(N)))
    roots=[pow(root,k,p) for k in range(N)]
    coords=list(product(*(range(n) for n in ds)))
    half=ds[i]//2
    t=[n//gcd(n,ds[i]) if j!=i and active[j] else 0 for j,n in enumerate(ds)]
    assert all((ds[i]*tj)%n==0 and (half*tj)%n == (n//2 if active[j] else 0)
               for j,(tj,n) in enumerate(zip(t,ds,strict=True)) if j!=i)
    kcols=[ks for ks in coords if all(q==0 or k%q for k,q in zip(ks,omit,strict=True))]
    assert len(kcols)==prod(keep)
    if c==10000:
        kcols=kcols[::97]
    # Independent parity sources prevent the two input arrays being identified.
    values=[{x:((idx*idx+7*idx+31+delta*idx**3)%p) for idx,x in enumerate(coords)} for delta in (0,1)]
    for mode in kcols:
        delta=sum(k for k,a in zip(mode,active,strict=True) if a)%2
        s=(mode[i]+sum(mode[j]*(ds[i]*t[j]//ds[j]) for j in range(len(ds)) if i!=j))%ds[i]
        assert s%2==delta
        direct=sum(values[delta][x]*roots[sum((N//n)*k*xx for xx,k,n in zip(x,mode,ds,strict=True))%N] for x in coords)%p
        folded=0
        for y in coords:
            if y[i]>=half: continue
            x=tuple((yj+t[j]*y[i])%ds[j] for j,yj in enumerate(y))
            opposite=tuple((xx+(n//2 if a else 0))%n for xx,n,a in zip(x,ds,active,strict=True))
            bucket=values[delta][x]+(-1)**delta*values[delta][opposite]
            phase=(N//ds[i])*delta*y[i]+(N//half)*(s//2)*y[i]
            phase+=sum(N//ds[j]*mode[j]*yj for j,yj in enumerate(y) if j!=i)
            folded+=bucket*roots[phase%N]
        assert direct==folded%p
    return len(kcols)


if __name__=="__main__":
    raw=json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]["raw_metadata"]
    total=Counter()
    for c,m,N,_,_ in raw:
        v,i,order=budget(c,N)
        total.update(v)
    assert len(raw)==7499 and total["original_projected_b"]==95864578358990 and total["original_projected_points"]==18394224556512
    tested={c:check(c) for c in [3,4,5,8,9,12,15,16,20,21,24,35,40,45,60,72,80,85,105,120,180,240,10000]}
    ratio=dict(butterflies=total["folded_b"]/total["original_projected_b"],
               points_including_twists=(total["folded_points"]+total["pre_twist_complex_products"])/total["original_projected_points"])
    result=dict(totals=total,ratios=ratio,finite_field_checked_modes=tested,rows=len(raw),
                sha256={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (SOURCE,PRODUCER,Path(__file__))})
    (HERE/"fold.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(result,indent=2))
