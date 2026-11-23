"""Independently decode the submitted masks and witnesses; no producer imports."""
import json,hashlib
from fractions import Fraction as F
from pathlib import Path

HERE=Path(__file__).resolve().parent
OLD=HERE.parent/"full-height-count"
NEW=HERE.parent/"sparse-count"
STEP=4096
CUT,LAST=84224*STEP,84864*STEP


def lines(p):
    return p.read_text().splitlines()


def decode(p,lower,upper,first):
    prev=lower
    sign=first
    seq=[]
    for line in lines(p):
        n,x=map(int,line.split())
        assert 1<=n<=32
        for _ in range(n):
            tag=x&255
            x>>=8
            if tag!=255:
                tick=(prev//STEP+tag)*STEP
            else:
                tick=x&0xffffffff
                x>>=32
            assert lower<tick<upper and prev<tick
            seq.append((tick,sign))
            prev,sign=tick,-sign
        assert x==0
    return seq


def summary(points,upper):
    right=[t for (_,a),(t,b) in zip(points,points[1:]) if a!=b]
    return right,len(right),sum(upper-t for t in right)


def run():
    rows=json.loads((NEW/"inputs.json").read_bytes())["channels"]
    densepack=json.loads((OLD/"pack.json").read_bytes())
    run=iter(lines(OLD/"stencils.txt"))
    kernels={}
    for _ in range(int(next(run))):
        k,r,o,d,e=map(int,next(run).split())
        kernels[k]=(r,o,d,e,list(map(int,next(run).split())))
    output=[]
    for row in rows:
        label=row["label"]
        dense=[tuple(map(int,line.split())) for line in lines(OLD/f"signs-{label}.tsv")]
        signs=dict(dense)
        assert len(signs)==len(dense) and dense==sorted(dense)
        raw=list(map(int,lines(OLD/f"grid-{label}.txt")))
        vals={}
        for i,line in enumerate(lines(NEW/f"raw-{label}.txt")):
            mask,*fields=line.split()
            mask=int(mask)
            slots=[64*i+j for j in range(64) if mask>>j&1]
            assert mask>=0 and mask.bit_length()<=64 and len(slots)==len(fields)
            for j,val in zip(slots,fields):
                v=int(val,16)-2**255
                assert j<len(raw) and v==raw[j]
                vals[j]=v
        jobs={int(l.split()[0]):int(l.split()[1]) for l in lines(NEW/f"jobs-{label}.txt")}
        used=set()
        def actual(t):
            if t%STEP==0:
                pos=128+t//STEP
                used.add(pos)
                v=vals[pos]
                assert abs(v)>519575974158994+1
            else:
                r,o,d,e,weights=kernels[jobs[t]]
                assert len(weights)==r and d>0 and o==t%STEP
                src=list(range(128+t//STEP+1-r//2,128+t//STEP+1-r//2+r))
                used.update(src)
                v=sum(vals[i]*w for i,w in zip(src,weights))
                assert abs(v)>d*(e+5)
            return 1 if v>0 else -1
        endpoint=[actual(t) for t in [0,1,CUT-1,CUT,LAST]]
        assert endpoint[0]==endpoint[1] and endpoint[2]==endpoint[3]
        rec={}
        for name,lower,upper in [("main",0,CUT),("aux",CUT,LAST)]:
            original=[(t,s) for t,s in dense if lower<t<upper]
            witnesses=decode(NEW/f"{name}-{label}.txt",lower,upper,1 if row[name]["first_positive"] else -1)
            assert all(actual(t)==s==signs[t] for t,s in witnesses)
            rr,n,w=summary(original,upper)
            sr,sn,sw=summary(witnesses,upper)
            assert len(witnesses)==sn+1 and n==sn
            archived=next(x for x in densepack if x["label"]==label and x["region"]==int(name=="aux"))
            assert (n,w)==(archived["flips"],archived["weight"])
            if name=="aux":
                assert rr==sr and w==sw
            rec[name]=dict(flips=n,original_weight=w,witness_weight=sw,first_dense=rr[0],
                           first_witness=sr[0],first_moved_right=next(([a,b] for a,b in zip(rr,sr) if a!=b),None))
        assert used==set(vals)
        output.append(dict(label=label,raw=len(vals),jobs=len(jobs),end_signs=endpoint,regions=rec))
    counts=json.loads((OLD/"counts.json").read_bytes())["counts"]
    pairs=[]
    for i,v in enumerate(counts.values()):
        a,b=output[2*i:2*i+2]
        archived=v["fixed"][-1]
        K=a["regions"]["main"]["flips"]+b["regions"]["main"]["flips"]
        W=a["regions"]["aux"]["witness_weight"]+b["regions"]["aux"]["witness_weight"]
        assert W==archived["W_ticks"]
        anum=F(archived["phase_upper"])*2**32
        assert anum.denominator==1
        slack=2**32*(5*W+20480*640*(K+1))-262144*(int(anum)+36*2**32)
        assert slack>0
        pairs.append(dict(labels=[a["label"],b["label"]],K=K,W=W,integer_strict_slack=slack))
    report=dict(channels=output,pairs=pairs,hashes={str(p.relative_to(HERE.parent)):hashlib.sha256(p.read_bytes()).hexdigest()
                 for p in [NEW/"prepare.py",NEW/"SparseCountScript.sml",NEW/"inputs.json",OLD/"CountReceiptScript.sml",OLD/"FullCountScript.sml",OLD/"counts.json",OLD/"pack.json"]})
    (HERE/"audit.json").write_text(json.dumps(report,indent=2)+"\n")


if __name__=="__main__":
    run()
