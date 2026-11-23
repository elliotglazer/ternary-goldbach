"""Price fixed discovery rules against a complete, independently evaluated midpoint panel."""
import csv
import gzip
import hashlib
import json
from collections import Counter
from fractions import Fraction as F
from math import prod
from pathlib import Path

HERE=Path(__file__).resolve().parent
N=2301


def value(z):
    # Screening alone uses the displayed midpoint. Ground truth uses the
    # rigorous independent sign column from the original interval computation.
    return float(z.strip("[]").split()[0])


def main():
    coarse={}
    with gzip.open(HERE/"high-signs.tsv.gz","rt") as f:
        for row in csv.DictReader(f,delimiter="\t"):
            coarse[int(row["j"]),int(row["k41"]),int(row["k61"])]=(int(row["sign"]),value(row["scaled_value"]))
    mid={}
    with gzip.open(HERE/"high-midpoints.tsv.gz","rt") as f:
        for row in csv.DictReader(f,delimiter="\t"):
            mid[int(row["left_j"]),int(row["k41"]),int(row["k61"])]=int(row["sign"])
    assert len(coarse)==16*N and len(mid)==15*N and set(mid.values())=={-1,1}
    first,last=84184,84199
    out={}
    for size in (4,6,8):
        rules={t:Counter() for t in (0,0.001,0.01)}
        nodes={t:set() for t in rules}
        for j in range(first,last):
            a0=min(max(first,j-size//2+1),last-size+1)
            support=list(range(a0,a0+size))
            x=F(2*j+1,2)
            weights=[float(prod((x-k)/(i-k) for k in support if k!=i)) for i in support]
            for key,s_mid in ((k,mid[k]) for k in mid if k[0]==j):
                _,a,b=key
                sign,vl=coarse[j,a,b]
                sr,vr=coarse[j+1,a,b]
                if sign!=sr:
                    continue
                obs=[coarse[k,a,b][1] for k in support]
                predicted=sum(u*v for u,v in zip(obs,weights))
                norm=max(map(abs,obs))
                hidden=sign!=s_mid
                for theta,counts in rules.items():
                    selected=sign*predicted<=theta*norm
                    counts["same_sign"]+=1
                    counts["hidden"]+=hidden
                    if selected:
                        counts["selected"]+=1
                        counts["true"]+=hidden
                        nodes[theta].add(j)
                    elif hidden:
                        counts["miss"]+=1
        for theta,counts in rules.items():
            assert counts["hidden"]==13 and counts["same_sign"]==27620
            counts["selected_nodes"]=len(nodes[theta])
        out[size]=rules
    result=dict(rules=out,scope="Same-sign intervals only, conductor 10004, indices 84184–84199. Midpoint signs are a reference for discovery and do not exhaust possible zeros.",
        sha256={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in
                [HERE/"high-signs.tsv.gz",HERE/"high-midpoints.tsv.gz",Path(__file__)]})
    (HERE/"screen.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(out))


if __name__=="__main__":
    main()
