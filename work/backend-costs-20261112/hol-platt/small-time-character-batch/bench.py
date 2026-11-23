"""Compare separate native products and deterministic integer aggregation with a common multiplier."""
from pathlib import Path
from time import perf_counter,process_time
from statistics import median
import json,random,gc
from flint import fmpz,ctx

HERE=Path(__file__).resolve().parent
ctx.threads=1


def clock():
    return perf_counter(),process_time()


def elapsed(start):
    return [v-u for v,u in zip(clock(),start)]


def test(t,w,b,reps):
    rng=random.Random(t*100+w*10+b)
    size=t*w//8
    def operand():
        return fmpz(int.from_bytes(rng.randbytes(size-1)+bytes([71]),"little"))
    kernel=-operand()
    xs=[(-1 if j%2==0 else 1)*operand() for j in range(b)]
    stride=2*t*w
    results=[]
    for rep in range(reps):
        start=clock()
        if rep%2:
            xs=xs[::-1]
        # The multiplier is the exact same object in every single product.
        refs=[x*kernel for x in xs]
        separate=elapsed(start)
        start=clock()
        pack=fmpz(0)
        for x in reversed(xs):
            pack=(pack<<stride)+x
        enc=elapsed(start)
        start=clock()
        big=pack*kernel
        mult=elapsed(start)
        start=clock()
        # Convert once to unsigned blocks; avoid an O(batch^2) extraction loop.
        positive=sum((1<<(stride-1))<<(j*stride) for j in range(b))
        buf=(int(big)+positive).to_bytes(b*(stride//8),"little")
        half=1<<(stride-1)
        got=[int.from_bytes(buf[j*(stride//8):(j+1)*(stride//8)],"little")-half for j in range(b)]
        dec=elapsed(start)
        assert all(x==y for x,y in zip(refs,got))
        results.append(dict(separate=separate,pack=enc,multiply=mult,unpack=dec))
        del got,buf,refs,pack,big,positive,half
        gc.collect()
    sep=median(s["separate"][0] for s in results)
    prod=median(s["multiply"][0] for s in results)
    full=median(sum(s[k][0] for k in ["pack","multiply","unpack"]) for s in results)
    return dict(tile_slots=t,w=w,batch=b,operand_bytes=size,repetitions=results,
                median_separate_wall=sep,median_batch_product_wall=prod,
                median_batch_all_wall=full,product_speedup=sep/prod,all_speedup=sep/full)


if __name__=="__main__":
    out=[]
    for t,w,b in [(4096,552,4),(16384,552,2),(16384,552,4),(65536,552,2),(65536,744,2)]:
        out.append(test(t,w,b,3))
        (HERE/"bench.json").write_text(json.dumps(out,indent=2)+"\n")
