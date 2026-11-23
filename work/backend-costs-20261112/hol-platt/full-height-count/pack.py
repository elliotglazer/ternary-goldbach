"""Group exact strict signs on equally spaced short runs. Recheck by decoding."""
from fractions import Fraction as F
from hashlib import sha256
import json
from spectrum import HERE,LABELS,parameters
from repair import SUB,GUARDS


def pack(entries):
    out = []
    i = 0
    while i<len(entries):
        length = 1
        while (length<60 and i+length<len(entries) and
               entries[i+length][0]==entries[i][0]+4096*length):
            length += 1
        word = sum((s>0)<<b for b,(_,s) in enumerate(entries[i:i+length]))
        out.append((entries[i][0],length,word))
        i += length
    assert [(i+b*SUB,1 if word&(1<<b) else -1) for i,n,word in out for b in range(n)]==entries
    return out


def run():
    counts = json.loads((HERE/"counts.json").read_bytes())
    main,*_ = parameters()
    lines = []
    receipts = []
    for k,pair in enumerate((LABELS[:2],LABELS[2:])):
        chosen = counts["counts"][str(pair)]["fixed"][-1]
        H = (main+GUARDS[-1])*SUB
        T = main*SUB
        for j,label in enumerate(pair):
            path = HERE/("signs-%d.tsv"%label)
            assert sha256(path.read_bytes()).hexdigest()==counts["sha256"][path.name]
            stream = [tuple(map(int,line.split())) for line in path.read_text().splitlines()]
            for region,(lower,upper) in enumerate(((0,T),(T,H))):
                entries = [(i,s) for i,s in stream if lower<i<upper]
                packed = pack(entries)
                flips = [j for (i,a),(j,b) in zip(entries,entries[1:]) if a!=b]
                amount = len(flips)
                assert amount==chosen["main_label_counts" if not region else "aux"][j]
                weight = sum(upper-i for i in flips)
                lines += [" ".join(map(str,[k,j,region,lower,upper,len(entries),amount,weight,len(packed)])),
                          " ".join(str(v) for t in packed for v in t)]
                receipts.append(dict(label=label,region=region,blocks=len(packed),entries=len(entries),
                                     flips=amount,weight=weight))
        assert receipts[-1]["weight"]+receipts[-3]["weight"]==chosen["W_ticks"]
        # h(K+1)+W>A+2B in common units, for the moderate b=18 route.
        Af = F(chosen["phase_upper"])*(1<<32)
        assert Af.denominator==1
        lines += [" ".join(map(str,[GUARDS[-1],int(Af),18]))]
    (HERE/"packets.txt").write_text("\n".join(lines)+"\n",newline="\n")
    (HERE/"pack.json").write_text(json.dumps(receipts,indent=2)+"\n")


if __name__=="__main__":
    run()
