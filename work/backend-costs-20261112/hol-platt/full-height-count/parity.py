"""Check the endpoint-sign hypotheses for using the two-unit margin for an exact count."""
from fractions import Fraction as F
from hashlib import sha256
import json
from repair import GUARDS,SUB
from spectrum import HERE,LABELS,parameters


def run():
    main,*_ = parameters()
    upper = main*SUB
    data = json.loads((HERE/"counts.json").read_bytes())
    pairs = []
    for pair in (LABELS[:2],LABELS[2:]):
        rows = []
        for channel,label in enumerate(pair):
            p = HERE/("signs-%d.tsv"%label)
            assert sha256(p.read_bytes()).hexdigest()==data["sha256"][p.name]
            signs = [tuple(map(int,s.split())) for s in p.read_text().splitlines()]
            inclusive = [(i,s) for i,s in signs if i<=upper]
            assert inclusive[0][0]==0 and inclusive[-1][0]==upper
            assert inclusive[1][0]==1 and inclusive[-2][0]==upper-1
            assert inclusive[0][1]==inclusive[1][1] and inclusive[-2][1]==inclusive[-1][1]
            k = sum(s!=t for (_,s),(_,t) in zip(inclusive,inclusive[1:]))
            assert k==data["counts"][str(pair)]["fixed"][0]["main_label_counts"][channel]
            assert k%2==int(inclusive[0][1]!=inclusive[-1][1])
            rows.append(dict(label=label,at_zero=inclusive[0][1],at_T=inclusive[-1][1],k=k))
        tests = []
        for r in data["counts"][str(pair)]["fixed"]:
            m = F(r["exact_margin"]["moderate"])
            tests.append(dict(extra=r["extra"],moderate_one_unit=m>0,moderate_two_unit=m+1>0,
                              strict_two_unit_margin=str(1+m)))
        pairs.append(dict(channels=rows,tests=tests))
    target = HERE/"parity.json"
    target.write_text(json.dumps(dict(pairs=pairs,input_sha256=sha256((HERE/"counts.json").read_bytes()).hexdigest()),indent=2)+"\n")
    print(pairs)


if __name__=="__main__":
    run()
