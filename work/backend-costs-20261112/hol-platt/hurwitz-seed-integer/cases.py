"""Encode the independently checked integer replay fixtures for stock HOL4."""
import json
from produce import HERE, bernoulli, needed


def zig(v):
    return 2*abs(v)+int(v<0)


def main():
    fixtures = json.loads((HERE/"fixtures.json").read_bytes())
    with (HERE/"cases.txt").open("w",encoding="ascii",newline="\n") as out:
        for r in fixtures:
            ops = r["tasks"]
            print(r["band"],r["grid"],r["center"],r["j"],file=out)
            print(*(v for (n,l),k in zip(ops,needed(ops)[1:],strict=True) for v in (n,l,k)),file=out)
            print(*(zig(v) for pair in r["phases"] for v in pair),file=out)
            bs=bernoulli(max(l for _,l in ops))[1:]
            print(*(zig(v) for b in bs for v in (b.numerator,b.denominator)),file=out)
            print(*(zig(v) for pair in r["seeds"] for v in pair),file=out)


if __name__=="__main__":
    main()
