"""Direct Arb Hurwitz reference for the two positive nodes and initialization."""
import hashlib
import json
from math import gcd
from pathlib import Path
from time import perf_counter, process_time

import flint
from flint import acb, arb, ctx, dirichlet_char

OUT = Path(__file__).resolve().parent
Q = 10004
SCALE = 2**81
ctx.prec = 176
ctx.threads = 1


def residue(j4, j41, j61):
    return (2501*(1+2*j4) + 4880*pow(6,j41,41) + 2624*pow(2,j61,61)) % Q


def rounded(x):
    y = x*SCALE
    n = (y + arb(1)/2).floor().unique_fmpz()
    assert n is not None and abs(y-n) < arb(1)/2
    return int(n)


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run():
    mapping = [residue(i%2, (i//2)%40, i//80) for i in range(4800)]
    assert set(mapping) == {a for a in range(Q) if gcd(a,Q)==1}
    report = dict(prec_bits=ctx.prec, flint_python=flint.__version__,
                  threads=ctx.threads, nodes=[], script_sha256=digest(Path(__file__)))
    for h in [1,2,0]:
        s = acb(arb(1)/2, arb(5*h)/64)
        lines = ["index\ta\tre\tim\n"]
        balls = []
        wall, cpu = perf_counter(), process_time()
        for i,a in enumerate(mapping):
            value = s.zeta(acb(arb(a)/Q))
            balls.append(value)
            lines.append(f"{i}\t{a}\t{rounded(value.real)}\t{rounded(value.imag)}\n")
        cpu, wall = process_time()-cpu, perf_counter()-wall
        path = OUT / f"h{h}.tsv"
        path.write_bytes("".join(lines).encode("ascii"))
        node = dict(h=h,wall_seconds=wall,cpu_seconds=cpu,sha256=digest(path),checks=[])
        for label in [3,pow(3,-1,Q),7]:
            chi = dirichlet_char(Q,label)
            positive = sum((chi(a)*v for a,v in zip(mapping,balls)),acb(0))*acb(Q)**(-s)
            direct = chi.l(s)
            assert positive.overlaps(direct)
            phases = []
            for order,a in zip([2,40,60],[residue(1,0,0),residue(0,1,0),residue(0,0,1)]):
                phases.append(next(k for k in range(order) if
                              acb.exp_pi_i(acb(2*k)/order).overlaps(chi(a))))
            node["checks"].append(dict(conrey=label,positive_frequency=phases,
                                       primitive=bool(chi.is_primitive()),L=str(direct)))
        report["nodes"].append(node)
        (OUT/"receipt.json").write_text(json.dumps(report,indent=2)+"\n",encoding="ascii")


if __name__ == "__main__":
    run()
