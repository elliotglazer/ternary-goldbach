"""Bounded reference timings for a signed middle-convolution streaming consumer."""
import hashlib,json,random,sys
from collections import Counter,defaultdict
from fractions import Fraction as F
from math import ceil
from pathlib import Path
from statistics import median
from time import perf_counter
from flint import arb,acb,ctx

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/"c10000-kronecker-time-price"))
from price import SOURCE,primitive_count,bits
from tiles import pairs
T=65536


def timed(fn,reps=1):
    values=[]
    for _ in range(reps):
        t=perf_counter()
        result=fn()
        values.append(perf_counter()-t)
    return median(values),result


def metrics(w,p):
    rng=random.Random(w)
    word=w//8
    nbits=w*T
    half=1<<(w-1)
    tilehalf=1<<(nbits-1)
    bias=int.from_bytes(half.to_bytes(word,"little")*T,"little")
    S=1<<p
    # Signed payloads chosen at realistic coefficient and unit-chirp widths.
    data=[(rng.randrange(-(1<<(p+39)),1<<(p+39)),rng.randrange(-(1<<(p+39)),1<<(p+39))) for _ in range(T)]
    roots=[(rng.randrange(-S,S),rng.randrange(-S,S)) for _ in range(T)]
    def prechirp():
        return [((x*r-y*s+S//2)>>p,(x*s+y*r+S//2)>>p) for (x,y),(r,s) in zip(data,roots)]
    def regrid():
        return [((x+(1<<31))>>32,(y+(1<<31))>>32) for x,y in data]
    pre,coords=timed(prechirp)
    rg,_=timed(regrid)
    def encode(coords):
        return tuple(int.from_bytes(b"".join((z+half).to_bytes(word,"little") for z in col),"little")-bias
                     for col in ([a for a,b in coords],[b for a,b in coords],[a+b for a,b in coords]))
    encoding,packed=timed(lambda:encode(coords))
    kernel_enc,_=timed(lambda:encode(roots))
    z=-(rng.getrandbits(2*nbits-9))
    seed=rng.getrandbits(nbits-10)
    def split():
        high=(z+tilehalf)>>nbits
        return z-(high<<nbits),high
    spl,(low,high)=timed(split,7)
    assert low+(high<<nbits)==z and -tilehalf<=low<tilehalf
    add,_=timed(lambda:seed+low,11)
    # Completed convolution fields can occupy roughly twice the prechirp grid
    # width. Populate independent signed full-width result streams, not inputs.
    results=[]
    for _ in range(3):
        raw=b"".join((half+rng.randrange(-(1<<(w-8)),1<<(w-8))).to_bytes(word,"little") for i in range(T))
        results.append(int.from_bytes(raw,"little")-bias)
    finalize,bytecols=timed(lambda:[(v+bias).to_bytes(T*word,"little") for v in results])
    def emit():
        out=bytearray()
        for i,(r,s) in enumerate(roots):
            offset=i*word
            a,b,c=(int.from_bytes(col[offset:offset+word],"little")-half for col in bytecols)
            re,im=a-b,c-a-b
            shift=2*p+19
            norm=((re*r-im*s)+(1<<(shift-1)))>>shift
            out.extend(norm.to_bytes((p+48+7)//8,"little",signed=True))
        return out
    finish,_=timed(emit)
    ctx.prec=p+64
    def cht():
        for j in range(2048):
            z=acb.exp_pi_i(acb((j*j)%(1<<20))/(1<<19))
            for v in (z.real,z.imag):
                y=v*S
                a=(y+arb(1)/2).floor().unique_fmpz()
                assert a is not None and abs(y-a)<arb(1)/2
    chirps,_=timed(cht)
    return dict(regrid_pair=rg/T,prechirp_pair=pre/T,pack_three_source_fields=encoding/T,
                pack_three_kernel_fields=kernel_enc/T,split_product=spl,add_piece=add,
                finalize_three_tiles=finalize,extract_complete_emit=finish/T,chirp=chirps/2048)


def main():
    ctx.threads=1
    data=json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]
    theta=dict(data["conductor_theta"])
    groups=defaultdict(Counter)
    for c,m,n,old_p,raw_exp in data["raw_metadata"]:
        t=theta[c]
        L=2*((25*n+191)//192)+1
        J=(L-1)//2
        B=2*F(40_000_000 if c%2 else 80_000_000,t)**2+1
        tol=F(35*n,2816*64*2**82*3**t)
        p=bits(((7*B+12)*L+n)/tol)+1
        S=1<<p
        width=8*(((4*L*ceil((B+1)*S)*(S+1)).bit_length()+8)//8)
        cls=next(v for v in [552,616,680,744] if v>=width)
        x=groups[cls]
        chars=primitive_count(c)
        hits=pairs(L,m,T)
        x.update(dict(positive_source_pairs=(J+1)*chars,prechirp_pairs=L*chars,
              packed_source_triplets=L*chars,packed_kernel_triplets=L+m,
              chirps=m+J+1,products=3*hits["pair_count"]*chars,
              pieces=3*hits["pieces"]*chars,
              complex_output_tiles=((L-1+m)//T-(L-1)//T+1)*chars,
              samples=(m+1)*chars,output_bytes=(m+1)*chars*((p+ceil(B).bit_length()+3+7)//8),
              source_spool_write_bytes=3*L*(width//8)*chars,
              kernel_spool_write_bytes=3*(L+m)*(width//8),
              pair_operand_capacity_bytes=3*hits["input_fields"]*(width//8)*chars))
    counters={k:metrics(k,p) for k,p in zip([552,616,680,744],[241,273,305,339])}
    mapping={"regrid_pair":"positive_source_pairs","prechirp_pair":"prechirp_pairs",
             "pack_three_source_fields":"packed_source_triplets","pack_three_kernel_fields":"packed_kernel_triplets",
             "split_product":"products","add_piece":"pieces","finalize_three_tiles":"complex_output_tiles",
             "extract_complete_emit":"samples","chirp":"chirps"}
    hours={k:sum(counters[w][k]*v[metric] for w,v in groups.items())/3600 for k,metric in mapping.items()}
    receipt=dict(source_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest(),T=T,
                counts=sum(groups.values(),Counter()),by_width=groups,per_event_wall_seconds=counters,
                model_one_worker_wall_hours=hours,total_modeled_wall_hours=sum(hours.values()))
    (HERE/"receipt.json").write_text(json.dumps(receipt,indent=2)+"\n")


if __name__=="__main__":
    main()
