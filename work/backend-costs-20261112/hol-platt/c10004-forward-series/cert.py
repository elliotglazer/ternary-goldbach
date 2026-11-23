"""Price verification using independently scalar-generated preterminal candidate streams."""
import json,math
from collections import Counter
from time import perf_counter
from flint import fmpz
from series import HERE,prepare,horner,kernel


def run(c,rows):
    timing=Counter()
    kernel.cache_clear()
    count=0
    for k,coef in rows.items():
        t=perf_counter()
        a,b,r,den,D,w=prepare(c,k,coef)
        L=b-a+1
        d=len(D[0])-1
        bias=((1<<(w*L))-1)//((1<<w)-1)<<(w-1)
        mask=(1<<(w*L))-1
        H=1<<(w-1)
        differences=[(-1)**j*math.comb(d+1,j) for j in range(d+2)]
        sparse=sum(v<<(w*j) for j,v in enumerate(differences))
        timing["prepare"]+=perf_counter()-t
        for z in D:
            t=perf_counter()
            ys=[horner(z,r+i*1024) for i in range(L)]
            timing["scalar_candidate"]+=perf_counter()-t
            t=perf_counter()
            raw=b"".join((y+H).to_bytes(w//8,"little") for y in ys)
            candidate=int.from_bytes(raw,"little")-bias
            timing["pack_candidate"]+=perf_counter()-t
            t=perf_counter()
            seeds=[horner(z,r+i*1024) for i in range(d+1)]
            U=sum(sum(differences[j]*seeds[i-j] for j in range(i+1))<<(w*i) for i in range(d+1))
            timing["independent_seeds_and_U"]+=perf_counter()-t
            t=perf_counter()
            assert (sum((v*candidate)<<(w*j) for j,v in enumerate(differences))-U)&mask==0
            timing["sparse_shift_check"]+=perf_counter()-t
            t=perf_counter()
            assert (int(fmpz(sparse)*fmpz(candidate))-U)&mask==0
            timing["gmp_short_product_check"]+=perf_counter()-t
            t=perf_counter()
            for i,y in enumerate(ys):
                if math.gcd(c,a+i)==1:
                    _=(2*y+den)//(2*den)
                    count+=1
            timing["filter_and_divide_from_known_candidate"]+=perf_counter()-t
    return dict(c=c,cells=len(rows),coordinate_sinks=count,times=timing)


if __name__=="__main__":
    low={int(k):v for k,v in json.loads((HERE.parent/"c10004-p20-source/h1-mixed.json").read_bytes()).items()}
    high=json.loads((HERE.parent/"c10004-exact-horner/edge-slab.json").read_bytes())["rows"][-1]
    results=[run(c,low) for c in (131071,265800)]
    results.append(run(131072,{int(k):v for k,v in high["mixed"].items()}))
    count=json.loads((HERE.parent/"c10004-effective-degree/counts.json").read_bytes())["scenarios"][1]
    slots=sum(int(d)*v for d,v in count["weights_by_effective_degree"].items())
    price=dict(complex_samples=count["residues"],retained_complex_horner_stages=slots,
               scalar_multiplications=2*slots,scalar_additions=2*slots,
               terminal_coordinate_rounds=2*count["residues"])
    (HERE/"cert.json").write_text(json.dumps(dict(results=results,band1_scalar_baseline=price),indent=2)+"\n")
