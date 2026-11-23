"""Count disjoint sign brackets after omitting inconclusive witnesses channel by channel."""
import json
from pathlib import Path

from check import PRECISIONS, read_signs

HERE = Path(__file__).resolve().parent


def variations(signs):
    return sum(x*y < 0 for x,y in zip(signs, signs[1:]))


def main():
    results = json.loads((HERE/"signs.json").read_bytes())["results"]
    reference = {t:read_signs(t) for t in results}
    labels = [(k,l) for k in range(1,40) for l in range(1,60)]
    plans = {"low":[("low",j) for j in range(1,33)],
             "high":[("high",j) for j in range(84184,84200)],
             "high_with_midpoints":[("high",u//2) if u%2==0 else ("mid",u) for u in range(168368,168399)]}
    out = {}
    for name,nodes in plans.items():
        panels = []
        for p in PRECISIONS:
            dropped = {(tag,n["j"],tuple(k)) for tag in results for n in results[tag][str(p)]["nodes"]
                       for k in n["uncertain_labels"]}
            full = remaining = affected = 0
            losses = {}
            for k in labels:
                xs = [reference[t][(j,*k)] for t,j in nodes]
                keep = [s for (t,j),s in zip(nodes,xs,strict=True) if (t,j,k) not in dropped]
                loss = variations(xs)-variations(keep)
                assert loss >= 0
                if loss:
                    losses[str(k)] = loss
                full += variations(xs)
                remaining += variations(keep)
                affected += loss > 0
            panels.append(dict(bits=p,reference=full,certified=remaining,missing=full-remaining,
                               affected_characters=affected,losses=losses))
        out[name]=panels
    assert out["low"][0]["reference"]==6544 and out["high"][0]["reference"]==6895
    assert out["high_with_midpoints"][0]["reference"]==6921
    (HERE/"variations.json").write_text(json.dumps(out,indent=2)+"\n")
    for name, rows in out.items():
        print(name,[(r["bits"],r["certified"],r["missing"]) for r in rows])


if __name__=="__main__":
    main()
