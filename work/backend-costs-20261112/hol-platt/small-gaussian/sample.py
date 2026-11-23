"""Sample actual frequencies proportional to their retained recurrence length."""
from collections import Counter,defaultdict
from hashlib import sha256
import json
from math import gcd
from pathlib import Path
from random import Random
import sys
from flint import acb,arb,ctx

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/"small-character-kernel"))
from cutoff import ceil,powers,SOURCE

SEED=202611202101
MOD=(1<<61)-1


def runs(row):
    num=32*157*64
    den=125*row["N"]
    R=row["frequencies"]
    for i in range((R-1)*num//den+1):
        lo=ceil(i*den,num)
        hi=min(R,ceil((i+1)*den,num))
        if lo>=hi: continue
        small,large=powers(i)
        last=ceil(row["K"]*small,large)-1
        while last and gcd(last,row["c"])!=1:
            last-=1
        if last<2: break
        yield lo,hi,last


def choose(rows):
    weights=Counter()
    frequencies=Counter()
    for row in rows:
        for lo,hi,last in runs(row):
            key=(last-1).bit_length()
            weights[key]+=(hi-lo)*last
            frequencies[key]+=hi-lo
    rng=Random(SEED)
    aims={k:sorted(rng.randrange(v) for _ in range(5)) for k,v in sorted(weights.items())}
    cumulative=Counter()
    choices=[]
    for r in rows:
        for lo,hi,last in runs(r):
            key=(last-1).bit_length()
            begin=cumulative[key]
            cumulative[key]+=(hi-lo)*last
            while aims[key] and aims[key][0]<cumulative[key]:
                index=aims[key].pop(0)-begin
                assert index>=0
                choices.append((key,r["c"],lo+index//last,last))
    assert cumulative==weights and all(not a for a in aims.values())
    return weights,frequencies,choices


def reference(row,m,j,V):
    c=row["c"]
    theta=row["theta"]
    p=(192*44*2*3**33*8192**4*4*3**theta*(1<<80)-1).bit_length()
    s=1<<p
    x=2*arb.pi()*j/(arb(5)*row["N"]/64)
    t=2*arb(theta)/V
    z=(arb.pi()/c)*(2*x).exp()*acb(t.sin(),t.cos())
    exact=(-z).exp()
    coords=[(a*s+arb(1)/2).floor().unique_fmpz() for a in (exact.real,exact.imag)]
    assert all(a is not None for a in coords)
    q=tuple(int(a) for a in coords)
    assert abs(exact*s-acb(*q))<1 and sum(a*a for a in q)<=s*s
    def cut(z):
        return -(abs(z)//s) if z<0 else z//s
    def mul(a,b):
        v=(cut(a[0]*b[0]-a[1]*b[1]),cut(a[0]*b[1]+a[1]*b[0]))
        assert sum(k*k for k in v)<=s*s
        return v
    g=q
    d=mul(q,q)
    h=mul(q,d)
    table=[[0,0,0,0] for _ in range(min(m,c))]
    max_ratio=0.0
    for i in range(1,m+1):
        cell=table[(i-1)%c]
        for k in range(2):
            cell[k]+=g[k]
            cell[k+2]+=i*g[k]
        if i in (1,2,m//2,m):
            err=abs((-z*i*i).exp()*s-acb(*g))
            limit=i*i+2*(i*i-1)
            assert err<limit
            max_ratio=max(max_ratio,float(err/limit))
        if i<m:
            g=mul(g,h)
            if i+1<m:
                h=mul(h,d)
    a=b=0
    for r,i,nr,ni in table:
        a=(1000003*(1000003*a+r)+nr)%MOD
        b=(1000033*(1000033*b+i)+ni)%MOD
    return p,q,(a,b),max_ratio,table


def main():
    ctx.prec=680
    ctx.threads=1
    path=HERE.parent/"small-character-kernel/cutoff.json"
    cutoff=json.loads(path.read_bytes())
    rows=cutoff["rows"]
    data={r["c"]:r for r in rows}
    raw=json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]["raw_metadata"]
    heights={c:arb(5*m)/64 for c,m,_,_,_ in raw}
    weights,freqs,choices=choose(rows)
    t=cutoff["totals"]
    assert sum(freqs.values())==t["transforms"]
    assert sum(weights.values())+t["nonempty"]-t["transforms"]==t["recurrence_terms"]
    cases=[]
    lines=[]
    for ix,(k,c,j,m) in enumerate(choices):
        p,q,digest,ratio,_=reference(data[c],m,j,heights[c])
        reps=max(4,min(4096,8000//m))
        lines.append(" ".join(map(str,[ix,c,m,p,*q,*digest,reps])))
        cases.append(dict(id=ix,band=k,c=c,m=m,j=j,p=p,reps=reps,max_tested_error_ratio=ratio))
    # Full independent residue tables for one many-wrap and one no-wrap case.
    full=[]
    for c in (3,10000):
        m=next(runs(data[c]))[2]
        p,q,digest,ratio,table=reference(data[c],m,0,heights[c])
        full.append(" ".join(map(str,[c,m,p,*q])))
        full.append(" ".join(str(v) for row in table for v in row))
    (HERE/"full.txt").write_text("\n".join(full)+"\n",newline="\n")
    (HERE/"bench.txt").write_text("\n".join(lines)+"\n",newline="\n")
    plan=dict(seed=SEED,weights=weights,frequencies=freqs,cases=cases,
              cutoff_sha256=sha256(path.read_bytes()).hexdigest(),raw_schedule_sha256=sha256(SOURCE.read_bytes()).hexdigest())
    (HERE/"sample.json").write_text(json.dumps(plan,indent=2)+"\n")
    print(len(cases),sum(weights.values()),sum(freqs.values()),max(r["max_tested_error_ratio"] for r in cases))


if __name__=="__main__":
    main()
