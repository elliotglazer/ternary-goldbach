"""Prepare two consecutive heights with only root witnesses and the shared EM table."""
import json
import sys
from time import process_time
from flint import ctx
from cases import zig
from produce import HERE, S, bernoulli, coordinates, needed, power_phase, root_and_step, scale, seed
from normalize import supplied
from seed_em import schedule


def main(normalized=False):
    ctx.prec,ctx.threads=510,1
    configuration="normalized-counts.json" if normalized else "integer.json"
    stem="normalized-linked" if normalized else "linked"
    bands=json.loads((HERE/configuration).read_bytes())["bands"]
    summary=[]
    with (HERE/(stem+".txt")).open("w",encoding="ascii",newline="\n") as out:
        for rec in [bands[0], bands[-1]]:
            j=rec["hi"]-2
            f=rec["grid"]
            r=64 if normalized else 2
            p=rec["seed_bits"] if normalized else 320
            c=f-r if normalized else rec["center"]
            tasks=schedule(f,rec["hi"],rec["degree"],p,r) if normalized else rec["tasks"]
            roots=[]
            first=[]
            second=[]
            st=process_time()
            for i in range(needed(tasks)[0]):
                a=(i+1)*f+c
                k=a.bit_length()-f.bit_length()
                if (f<<k)>a:
                    k-=1
                mag,step=root_and_step(a,f)
                w=power_phase(mag,step,j)
                first.append(w)
                second.append(scale(w,*step,S))
                roots.extend((k,mag))
            seeds=[coordinates(f,c,j+x,tasks,rs,radius=r,output_bits=p) for x,rs in enumerate([first,second])]
            inside=process_time()-st
            worst=0
            for x,group in enumerate(seeds):
                direct=supplied(f,c,j+x,r,rec["degree"],p) if normalized else seed(f,c,j+x,rec["degree"],320)
                worst=max(worst,max(abs(u-v) for a,b in zip(group,direct,strict=True) for u,v in zip(a,b,strict=True)))
            assert worst<=1
            summary.append(dict(band=rec["band"],start=j,phase_pairs=len(first),max_delta=worst,producer_cpu=inside))
            print(rec["band"],f,c,j,*([r,p] if normalized else []),file=out)
            print(*(v for (n,l),k in zip(tasks,needed(tasks)[1:],strict=True) for v in (n,l,k)),file=out)
            print(*roots,file=out)
            bs=bernoulli(max(l for n,l in tasks))[1:]
            print(*(zig(v) for b in bs for v in (b.numerator,b.denominator)),file=out)
            for group in seeds:
                print(*(zig(v) for pair in group for v in pair),file=out)
    (HERE/(stem+".json")).write_text(json.dumps(summary,indent=2)+"\n")
    print(summary)


if __name__=="__main__":
    if sys.argv[1:] not in ([],["--normalized"]):
        raise SystemExit("Usage: linked.py [--normalized]")
    main(bool(sys.argv[1:]))
