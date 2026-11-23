"""Choose a strict sign witness per run and retain just its raw dependencies."""
from hashlib import sha256
from itertools import groupby
import json
from pathlib import Path
from time import process_time

HERE=Path(__file__).resolve().parent
OLD=HERE.parent/"full-height-count"
JOIN=HERE.parent/"grid-sign-join"
STEP=4096
CUT=84224*STEP
LAST=84864*STEP
HALO=128


def digest(path):
    return sha256(path.read_bytes()).hexdigest()


def region(entries,lo,hi,raw,aux):
    source=[(t,s) for t,s in entries if lo<t<hi]
    keep=[]
    for sign,series in groupby(source,key=lambda pt:pt[1]):
        pts=list(series)
        coarse=[(t,s) for t,s in pts if t%STEP==0]
        keep.append(pts[0] if aux or not coarse else max(coarse,key=lambda p:abs(raw[HALO+p[0]//STEP])))
    def count(xs):
        right=[b for (_,a),(b,s) in zip(xs,xs[1:]) if a!=s]
        return len(right),sum(hi-t for t in right)
    big=count(source)
    small=count(keep)
    if big[0]!=small[0] or (aux and big!=small):
        raise ValueError("lost a bracket or changed an auxiliary right endpoint")
    blocks=[]
    prev=lo
    for k in range(0,len(keep),32):
        buf=bytearray()
        for t,_ in keep[k:k+32]:
            delta=t//STEP-prev//STEP
            if t%STEP==0 and 0<=delta<255:
                buf.append(delta)
            else:
                buf.append(255)
                buf.extend(t.to_bytes(4,"little"))
            prev=t
        blocks.append((min(32,len(keep)-k),int.from_bytes(buf,"little")))
    # Decode from scratch, including every chunk boundary and alternating bit.
    out=[]
    prev=lo
    sign=keep[0][1]
    for n,v in blocks:
        for _ in range(n):
            v,tag=divmod(v,256)
            if tag==255:
                v,t=divmod(v,1<<32)
            else:
                t=(prev//STEP+tag)*STEP
            assert prev<t<hi
            out.append((t,sign))
            prev,sign=t,-sign
        assert v==0
    assert out==keep
    return keep,blocks,dict(candidates=len(source),witnesses=len(keep),brackets=small[0],
                            weight=small[1],original_weight=big[1],first_positive=keep[0][1]>0)


def main():
    start=process_time()
    counts=json.loads((OLD/"counts.json").read_bytes())
    quant=json.loads((JOIN/"inputs.json").read_bytes())
    packets=json.loads((OLD/"pack.json").read_bytes())
    rad=quant["coarse_radius"]
    kernel_lines=iter((OLD/"stencils.txt").read_text().splitlines())
    kernels=[]
    for i in range(int(next(kernel_lines))):
        k,r,o,d,e=map(int,next(kernel_lines).split())
        coeff=list(map(int,next(kernel_lines).split()))
        assert k==i and len(coeff)==r and sum(map(abs,coeff))<5*d
        kernels.append((r,o,d,e,coeff))
    report=[]
    for row in quant["results"]:
        label=row["label"]
        signs=OLD/f"signs-{label}.tsv"
        grid=OLD/f"grid-{label}.txt"
        jobs=JOIN/f"jobs-{label}.txt"
        assert digest(signs)==counts["sha256"][signs.name]
        assert digest(grid)==row["input_sha256"] and digest(jobs)==row["jobs_sha256"]
        raw=list(map(int,grid.read_text().splitlines()))
        entries=[tuple(map(int,l.split())) for l in signs.read_text().splitlines()]
        lookup=dict(entries)
        assert len(raw)==85121 and len(lookup)==len(entries)
        main_pts,mblocks,m=region(entries,0,CUT,raw,False)
        aux_pts,ablocks,a=region(entries,CUT,LAST,raw,True)
        previous=[r for r in packets if r["label"]==label]
        assert [r["flips"] for r in previous]==[m["brackets"],a["brackets"]]
        assert a["weight"]==previous[1]["weight"]
        requested={t for t,_ in main_pts+aux_pts}|{0,1,CUT-1,CUT,LAST}
        spans={t//STEP+HALO for t in requested if t%STEP==0}
        coarse_count=len(spans)
        for i in spans:
            assert abs(raw[i])>rad+1 and (raw[i]>0)==(lookup[(i-HALO)*STEP]>0)
        job_indices={t:k for t,k,*_ in (map(int,l.split()) for l in jobs.read_text().splitlines())}
        sparse_jobs=[]
        for t in sorted(requested):
            if t%STEP:
                k=job_indices[t]
                r,o,d,e,weights=kernels[k]
                lo=t//STEP+HALO+1-r//2
                local=range(lo,lo+r)
                value=sum(w*raw[i] for w,i in zip(weights,local,strict=True))
                assert o==t%STEP and abs(value)>d*(e+5) and (value>0)==(lookup[t]>0)
                sparse_jobs.append((t,k))
                spans.update(local)
        rows=[]
        for i in range(0,len(raw),64):
            ids=[j for j in range(i,min(i+64,len(raw))) if j in spans]
            mask=sum(1<<(j-i) for j in ids)
            biased=[raw[j]+(1<<255) for j in ids]
            assert all(0<=x<1<<256 for x in biased)
            rows.append(" ".join([str(mask),*(format(x,"x") for x in biased)]))
        def lines(name,lines):
            path=HERE/f"{name}-{label}.txt"
            path.write_text("\n".join(lines)+"\n",newline="\n")
            return digest(path)
        hashes=dict(raw=lines("raw",rows),
                    jobs=lines("jobs",["%d %d"%p for p in sparse_jobs]),
                    main=lines("main",["%d %d"%p for p in mblocks]),
                    aux=lines("aux",["%d %d"%p for p in ablocks]))
        cert=dict(label=label,main=m,aux=a,required_raw=len(spans),coarse=coarse_count,
            extra_stencil_indices=len(spans)-coarse_count,repairs=len(sparse_jobs),
            dense_raw=len(raw),dense_jobs=len(job_indices),hashes=hashes,
            endpoints=[1+int(lookup[t]>0) for t in (0,CUT)],raw_sha256=digest(grid))
        target=[int(m["first_positive"]),int(a["first_positive"]),*cert["endpoints"],
                m["brackets"],m["weight"],a["brackets"],a["weight"]]
        hashes["target"]=lines("target",[" ".join(map(str,target))])
        report.append(cert)
    phase_rows=[s.strip() for s in (OLD/"packets.txt").read_text().splitlines() if len(s.split())==3]
    assert len(phase_rows)==2 and all(r.split()[::2]==["640","18"] for r in phase_rows)
    for name,row in zip(["even","odd"],phase_rows,strict=True):
        (HERE/f"pair-{name}.txt").write_text(row+"\n",newline="\n")
    result=dict(channels=report,discovery_reuse_cpu=process_time()-start,
                source_hashes={str(p.name):digest(p) for p in [OLD/"pack.json",OLD/"counts.json",OLD/"stencils.txt",JOIN/"inputs.json"]})
    (HERE/"inputs.json").write_text(json.dumps(result,indent=2)+"\n")
    print([(c["label"],c["required_raw"],c["repairs"],c["main"]["brackets"],c["aux"]["brackets"]) for c in report])


if __name__=="__main__":
    main()
