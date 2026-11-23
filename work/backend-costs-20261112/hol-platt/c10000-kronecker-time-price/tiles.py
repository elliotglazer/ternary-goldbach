"""Middle-window tile pairs with exact ragged lengths and calibrated dense tile controls."""
import json,random
from collections import Counter,defaultdict
from fractions import Fraction as F
from math import ceil
from statistics import median
from time import process_time,perf_counter
from flint import fmpz,ctx
from price import HERE,SOURCE,primitive_count,bits


def tri(k):
    return (k+1)*(k+2)//2 if k>=0 else 0


def cdf(k,ni,nj):
    return tri(k)-tri(k-ni)-tri(k-nj)+tri(k-ni-nj)


def parts(length,T):
    q,r=divmod(length,T)
    return ([(0,q,T)] if q else [])+([(q,1,r)] if r else [])


def pairs(L,m,T):
    K=L+m
    lo,hi=L-1,L-1+m
    n=0
    result=Counter()
    for i,ni,a in parts(L,T):
        for j,nj,b in parts(K,T):
            s0=(lo-a-b+2+T-1)//T-i-j
            s1=hi//T-i-j
            num=cdf(s1,ni,nj)-cdf(s0-1,ni,nj)
            n+=num
            result["pair_count"]+=num
            result["full_pairs" if a==b==T else "ragged_pairs"]+=num
            result["input_fields"]+=num*(a+b)
            result["result_fields"]+=num*(a+b)
            # Actual output tile indices intersected. A tile pair spans at most
            # two natural output tiles. Apply requested-window intersection separately.
            for d in range(2):
                start=d*T
                end=min((d+1)*T-1,a+b-2)
                if start>end:
                    continue
                q0=(lo-end+T-1)//T-i-j
                q1=(hi-start)//T-i-j
                result["pieces"]+=cdf(q1,ni,nj)-cdf(q0-1,ni,nj)
    return result


def test():
    for T in (2,3,4,7):
        for L in range(1,27):
            for m in range(31):
                hits=pieces=0
                for i in range(0,L,T):
                    for j in range(0,L+m,T):
                        end=i+j+min(T,L-i)+min(T,L+m-j)-2
                        left,right=max(L-1,i+j),min(L-1+m,end)
                        if left<=right:
                            hits+=1
                            pieces+=right//T-left//T+1
                c=pairs(L,m,T)
                assert (hits,pieces)==(c["pair_count"],c["pieces"])


def bench(T,w):
    rng=random.Random(T+w)
    v=[fmpz(int.from_bytes(rng.randbytes(T*w//8-1)+b"\xf1","little")) for _ in range(2)]
    times=[]
    for _ in range(3):
        wall,cpu=perf_counter(),process_time()
        z=v[0]*v[1]
        times.append((perf_counter()-wall,process_time()-cpu))
        assert z%65537==(v[0]%65537)*(v[1]%65537)%65537
    return dict(w=w,T=T,operand_bytes=T*w//8,wall_median=median(a for a,b in times),
                cpu_median=median(b for a,b in times),samples=times)


def main():
    ctx.threads=1
    test()
    schedule=json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]
    theta=dict(schedule["conductor_theta"])
    out=[]
    for T in (2**14,2**16):
        controls={w:bench(T,w) for w in [552,616,680,744]}
        strata=defaultdict(Counter)
        groups=Counter()
        examples={}
        for c,m,n,_,_ in schedule["raw_metadata"]:
            t=theta[c]
            B=2*F(40_000_000 if c%2 else 80_000_000,t)**2+1
            J=(25*n+191)//192
            L=2*J+1
            tol=F(35*n,2816*64*2**82*3**t)
            p=1+bits(((7*B+12)*L+n)/tol)
            S=1<<p
            w=8*((((4*L*ceil((B+1)*S)*(S+1)).bit_length()+1)+7)//8)
            cls=next(v for v in controls if v>=w)
            work=pairs(L,m,T)
            chars=primitive_count(c)
            vals=dict(integer_products=3*work["pair_count"]*chars,
                      full_integer_products=3*work["full_pairs"]*chars,
                      ragged_integer_products=3*work["ragged_pairs"]*chars,
                      accumulation_pieces=3*work["pieces"]*chars,
                      input_payload_bytes=3*work["input_fields"]*w//8*chars,
                      result_payload_bytes=3*work["result_fields"]*w//8*chars,
                      output_real_grid_samples=(m+1)*chars,
                      output_tile_sinks=3*((L-1+m)//T-(L-1)//T+1)*chars)
            strata[n].update(vals)
            groups[cls]+=vals["integer_products"]
            if c in (4,10000):
                examples[c]=dict(field_width=w,per_character_pair_work=work,
                                 max_integer_operand_bytes=w*T//8)
        total=sum(strata.values(),Counter())
        estimates={metric:sum(groups[w]*controls[w][metric]/3600 for w in groups)
                   for metric in ("cpu_median","wall_median")}
        out.append(dict(T=T,totals=total,by_N=strata,control_groups=groups,
                        measured_full_products=controls,hour_model=estimates,examples=examples))
    (HERE/"tiles.json").write_text(json.dumps(out,indent=2)+"\n")


if __name__=="__main__":
    main()
