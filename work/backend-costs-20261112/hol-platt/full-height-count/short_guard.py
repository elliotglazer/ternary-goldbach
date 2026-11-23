"""Export just the width-25 auxiliary data, reusing the full-height main count."""
from fractions import Fraction as F
import json
from pack import pack
from spectrum import HERE,LABELS,parameters
from repair import SUB


def main():
    m,*_ = parameters()
    counts=json.loads((HERE/"counts.json").read_bytes())
    lines=[]
    for pair in (LABELS[:2],LABELS[2:]):
        record=counts["counts"][str(pair)]["fixed"][1]
        assert record["extra"]==320
        A = F(record["phase_upper"])*(1<<32)
        assert A.denominator==1
        lines.append(f"320 {int(A)} 18")
        for j,label in enumerate(pair):
            values=dict(tuple(map(int,line.split())) for line in (HERE/("signs-%d.tsv"%label)).read_text().splitlines())
            assert values[0]==values[1] and values[m*SUB]==values[m*SUB-1]
            upper=(m+320)*SUB
            entries=[(i,s) for i,s in values.items() if m*SUB<i<upper]
            blocks=pack(entries)
            flips=[v for (u,s),(v,t) in zip(entries,entries[1:]) if s!=t]
            assert len(flips)==record["aux"][j]
            lines += [" ".join(map(str,[label,int(values[0]>0),int(values[m*SUB]>0),m*SUB,upper,len(flips),
                    sum(upper-f for f in flips),len(blocks)]))," ".join(str(x) for b in blocks for x in b)]
    (HERE/"short.txt").write_text("\n".join(lines)+"\n",newline="\n")


if __name__=="__main__":
    main()
