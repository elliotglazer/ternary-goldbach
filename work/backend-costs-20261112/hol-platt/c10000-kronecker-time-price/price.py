"""Price exact truncated Bluestein on the zero-extra normalized time-transform schedule."""
from collections import Counter,defaultdict
from fractions import Fraction as F
from math import ceil
from pathlib import Path
import hashlib,json,random,sys
from time import process_time,perf_counter
from flint import fmpz,ctx

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/"time-pruning"))
from count_time_fft import SOURCE,primitive_count


def bits(r):
    """Smallest p with 2^p >= positive rational r."""
    d=r.numerator.bit_length()-r.denominator.bit_length()
    return d+int((1<<d)*r.denominator<r.numerator)


def run():
    src=SOURCE.read_bytes()
    selected=json.loads(src)["scenarios"][0]["small_sign_only_conditional_candidate"]
    tilts=dict(selected["conductor_theta"])
    groups=defaultdict(Counter)
    total=Counter()
    examples={}
    widths=[]
    cache_keys=set()
    for c,m,n,old_p,raw_exp in selected["raw_metadata"]:
        theta=tilts[c]
        count=primitive_count(c)
        J=(25*n+191)//192
        L=2*J+1
        K=L+m
        T=F(7*5*n,2816*64*2**82 * 3**theta)
        B=2*F(40_000_000 if c%2 else 80_000_000,theta)**2+1
        p=bits(((7*B+12)*L+n)/T)+1
        u=F(1,1<<p)
        assert ((7*B+12)*L+n)*u<T and u*(B+2)+u*u<1
        S=1<<p
        X,Y=ceil((B+1)*S),S+1
        limit=4*L*X*Y
        w=8*((limit.bit_length()+1+7)//8)
        assert 2*limit<1<<w
        ab=L*w//8
        bb=K*w//8
        result=(L+K)*w//8
        values=dict(characters=count,transforms=count,big_products=3*count,
            scalar_product_operand_bytes=3*(ab+bb)*count,
            scalar_product_output_bytes=3*result*count,
            positive_source_pairs=(J+1)*count,prechirp_slots=L*count,postchirp_slots=(m+1)*count,
            dense_old_butterflies=(n//2)*(n.bit_length()-1)*count)
        for data in (groups[n],total):
            data.update(values)
            data.update({"conductors":1})
        cache_keys.add((n,p,w,m))
        widths.append((old_p,p,w,old_p-p))
        if c in (3,4,10000):
            examples[c]=dict(n=n,m=m,J=J,L=L,K=K,theta=theta,coefficient_norm=str(B),
                       raw_sample_exponent=raw_exp,raw_sample_tolerance=str(T),
                       old_raw_precision=old_p,p=p,field_bits=w,operand_bytes=[ab,bb],
                       result_bytes=result,primitive_characters=count)
    assert total["dense_old_butterflies"]==89858217607168
    out=dict(source_sha256=hashlib.sha256(src).hexdigest(),by_length=groups,totals=total,
             cache_shape_keys=len(cache_keys),width_ranges={k:[min(v),max(v)] for k,v in
             zip(["old_p","new_p","field_bits","precision_saving"],zip(*widths))},examples=examples)
    (HERE/"counts.json").write_text(json.dumps(out,indent=2)+"\n")
    return examples[10000]


def bench(row):
    ctx.threads=1
    rng=random.Random(10000500)
    result=[]
    for exp in (12,14,16):
        n=1<<exp
        J=(25*n+191)//192
        m=ceil(F(row["m"]*n,row["n"]))
        L,K=2*J+1,2*J+1+m
        w=row["field_bits"]
        payload=[]
        for length in [L,K]:
            b=rng.randbytes(length*w//8-1)+bytes([191])
            payload.append(fmpz(int.from_bytes(b,"little")))
        cpu,wall=process_time(),perf_counter()
        z=payload[0]*payload[1]
        elapsed=process_time()-cpu,perf_counter()-wall
        assert z%65537==((payload[0]%65537)*(payload[1]%65537))%65537
        result.append(dict(n=n,field_bits=w,source_length=L,kernel_length=K,
                           operand_bytes=[L*w//8,K*w//8],product_bits=z.bit_length(),
                           cpu_seconds=elapsed[0],wall_seconds=elapsed[1]))
    (HERE/"synthetic.json").write_text(json.dumps(result,indent=2)+"\n")


if __name__=="__main__":
    bench(run())
