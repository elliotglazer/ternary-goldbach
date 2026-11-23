"""Group all relevant tile products on a diagonal before taking a centered split."""
import hashlib
import json
import sys
from collections import Counter, defaultdict
from fractions import Fraction as F
from math import ceil
from pathlib import Path
from random import Random
from statistics import median

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
sys.path.insert(0,str(HOL/"c10000-kronecker-time-price"))
from price import SOURCE, bits, primitive_count
from tiles import pairs,parts,cdf

T=65536


def diagonal_counts(L,m,T):
    lo,hi=L-1,L-1+m
    first,last=lo//T,hi//T
    extra=False
    for i,ni,a in parts(L,T):
        for j,nj,b in parts(L+m,T):
            d=first-1-i-j
            if d>=0 and (first-1)*T+a+b-2>=lo and cdf(d,ni,nj)>cdf(d-1,ni,nj):
                extra=True
    return last-first+1, int(extra)


def validate():
    rng=Random(492175)
    cases=0
    for width in (2,3,4,7,11):
        for L in range(1,35):
            for m in (0,1,2,3,8,13,37):
                lo,hi=L-1,L-1+m
                B=1<<18
                H=B**width
                aa=[rng.randint(-41,41) for _ in range(L)]
                bb=[rng.randint(-45,45) for _ in range(L+m)]
                assert 41*45*L<B//2
                def pack(arr): return sum(x*B**i for i,x in enumerate(arr))
                sums=defaultdict(int)
                for i in range(0,L,width):
                    for j in range(0,L+m,width):
                        x,y=aa[i:i+width],bb[j:j+width]
                        if i+j<=hi and i+j+len(x)+len(y)-2>=lo:
                            sums[(i+j)//width]+=pack(x)*pack(y)
                tiles,ex=diagonal_counts(L,m,width)
                assert ex==int(lo//width-1 in sums)
                carry=0
                out=[]
                for d in range(lo//width-ex,hi//width+1):
                    z=sums[d]+carry
                    carry=(z+H//2)//H
                    low=z-H*carry
                    for k in range(width):
                        digit=(low+B//2)%B-B//2
                        low=(low-digit)//B
                        if lo<=d*width+k<=hi:
                            out.append(digit)
                    assert low==0
                assert len(out)==m+1 and tiles==hi//width-lo//width+1
                expected=[sum(aa[i]*bb[v-i] for i in range(L) if 0<=v-i<len(bb))
                          for v in range(lo,hi+1)]
                assert out==expected
                cases+=1
    return cases


def main():
    cases=validate()
    sched=json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]
    theta=dict(sched["conductor_theta"])
    widths=defaultdict(Counter)
    for c,m,n,_,_ in sched["raw_metadata"]:
        chars=primitive_count(c)
        L=2*((25*n+191)//192)+1
        t=theta[c]
        B=2*F(40_000_000 if c%2 else 80_000_000,t)**2+1
        tol=F(35*n,2816*64*2**82*3**t)
        p=bits(((7*B+12)*L+n)/tol)+1
        S=1<<p
        w=8*(((4*L*ceil((B+1)*S)*(S+1)).bit_length()+8)//8)
        cls=next(wc for wc in [552,616,680,744] if wc>=w)
        before=pairs(L,m,T)["pair_count"]
        tiles,extra=diagonal_counts(L,m,T)
        widths[cls].update(dict(products=3*chars*before,output_tiles=3*chars*tiles,
                                preceding_boundary_splits=3*chars*extra,
                                grouped_splits=3*chars*(tiles+extra)))
    total=sum(widths.values(),Counter())
    assert total["products"]==1051852215 and total["output_tiles"]==107615058
    # This split diagnostic also forms a low result and an add. Use the paired
    # time difference against constructing the same large synthetic product.
    log=HOL/"small-time-nonproduct-hol/tile04_bench.log"
    rates=defaultdict(dict)
    for line in log.read_text().splitlines():
        if line.startswith("TILE,"):
            _,mode,k,w,rep,sec,_=line.split(",")
            if int(k)==16 and int(mode) in (2,3):
                rates[int(w)][int(mode),int(rep)]=float(sec)
    def split_rate(w):
        samples=[rates[w][2,r]-rates[w][3,r] for r in (1,2,3)]
        assert min(samples)>0
        return median(samples)
    times={w:split_rate(w) for w in (552,616,744)}
    brackets={w:(times[w],times[w]) if w!=680 else (min(times[616],times[744]),max(times[616],times[744]))
              for w in widths}
    price={k:[sum(row[k]*brackets[w][i] for w,row in widths.items())/3600 for i in (0,1)]
           for k in ("products","grouped_splits")}
    return dict(T=T,control_cases=cases,by_width=widths,total=total,split_rate_seconds=times,
                same_synthetic_split_hours=price,
                hours_scope="Kernel control sensitivity. 680-bit class bracketed by neighboring measured classes. Excludes additions of unsplit products, regrids, the postchirp, packing and physical IO.",
                sha256={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in
                        [SOURCE,log,HOL/"small-time-nonproduct-hol/TileCostScript.sml",Path(__file__)]})


if __name__=="__main__":
    r=main()
    (HERE/"fold.json").write_text(json.dumps(r,indent=2)+"\n")
    print(json.dumps({k:r[k] for k in ("control_cases","total","split_rate_seconds","same_synthetic_split_hours")},indent=2))
