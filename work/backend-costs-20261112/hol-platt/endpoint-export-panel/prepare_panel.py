"""Bind the rounded inclusive replay to all eight frozen Gaussian panel pairs."""
import json, sys
from pathlib import Path
from fractions import Fraction as F
from math import ceil

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/"endpoint-export"))
from prepare import runs,digest
team=HERE.parents[2]/"grh-goldbach-20261120/team"
even=json.loads((HERE.parent/"guard-repricing/endpoint-grid-panel.json").read_bytes())["rows"]
even={(r["q"],tuple(r["labels"])):r for r in even}
lines, saved=[], []
for q in (65536,180180,65537,132899):
    folder=team/f"gaussian-panel-q{q}"
    data=(folder/"inclusive-rounded.json").read_bytes()
    native=json.loads(data)
    counts=json.loads((folder/"counts.json").read_bytes())
    sub=counts["sub"]
    t0=F(counts["T"])*64*sub/5
    assert t0.denominator==1
    guards={x["extra"] for row in counts["counts"].values() for x in row["fixed"]}
    edges={1,t0-1,t0+1,*(t0+g*sub-1 for g in guards)}
    for row in native["rows"]:
        if row["guard"]!=640: continue
        labs=row["labels"]
        t,h=(int(F(row[k])*64*sub/5) for k in ("T","H"))
        assert t==ceil(t0/sub)*sub and h-t==640*sub
        phase=F(row["phase_upper"])*2**32
        assert phase.denominator==1 and F(row["allowances"]["moderate"])==18
        records, signed, scans=[], {}, []
        for label in labs:
            p=folder/f"signs-{label}.tsv"
            raw=p.read_bytes()
            signed[p.name]=digest(raw)
            assert signed[p.name]==counts["sha256"][p.name]==native["signed_inputs"][p.name]
            stream=[tuple(map(int,line.split())) for line in raw.splitlines()]
            assert all(s in (-1,1) for x,s in stream)
            assert all(i<j for (i,_),(j,_) in zip(stream,stream[1:]))
            ticks={x for x,_ in stream}
            assert {0,t,h}<=ticks and edges<=ticks and all(x%sub!=0 for x in edges)
            scan=[]
            for lo,hi in [(0,t),(t,h)]:
                region=[(x,s) for x,s in stream if lo<=x<=hi and x not in edges]
                changes=[x for (_,a),(x,b) in zip(region,region[1:]) if a!=b]
                k,w=len(changes),sum(hi-x for x in changes)
                scan.extend((k,w))
                rs=runs([(x+1,s) for x,s in region],sub)
                records+=[" ".join(map(str,[lo,hi+2,k,w+k,len(rs)])),
                          " ".join(str(i) for r in rs for i in r)]
            scans.append(scan)
        K=sum(s[0] for s in scans); W=sum(s[3] for s in scans)
        assert [s[0] for s in scans]==row["main_counts"] and (K,W)==(row["K"],row["W_ticks"])
        excess=(F(row["phase_upper"])+36)/50-F(W,h-t)-K
        assert excess==F(row["U_minus_K"]["moderate"])
        if (q,tuple(labs)) in even:
            e=even[q,tuple(labs)]
            assert e["scans"]==scans and F(e["phase_upper"])==F(row["phase_upper"]) and (excess<1)==e["passes"]
        lines+=[" ".join(map(str,[q,*labs,"grid",sub,640,int(phase),18,1,int(excess<1)])),*records]
        saved.append(dict(q=q,labels=labs,K=K,scans=scans,excess=str(excess),passed=excess<1,
                    signed_source_sha256=signed,native_sha256=digest(data)))
assert len(saved)==8
payload=("\n".join([str(len(saved)),*lines])+"\n").encode()
(HERE/"selected-packets.txt").write_bytes(payload)
(HERE/"receipts.json").write_text(json.dumps(dict(packet_sha256=digest(payload),rows=saved),indent=2)+"\n")
print([(r["q"],r["K"],r["passed"]) for r in saved])
