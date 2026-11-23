"""Run low-precision Bluestein axes on actual q=10004 Hurwitz data and bound every sign."""
import csv
import gzip
import hashlib
import json
import sys
from functools import lru_cache
from pathlib import Path

from flint import acb, arb, ctx, fmpz

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
sys.path[:0] = [str(HOL / "c10004-grid-repair"), str(HOL / "large-axis-sample")]
import complete
from fixtures import Cyclic, nearest, pairmul, quantize
from reference import upnorm

PRECISIONS = (16, 20, 24, 28, 32)
SOURCE_BITS = 81


def div_up(a, b):
    return -(-a // b)


@lru_cache(maxsize=None)
def chirps(n, p):
    s = 1 << p
    values = [acb.exp_pi_i(acb(j * j % (2 * n)) / n) for j in range(n)]
    centers = [nearest(value, s) for value in values]
    for value, (u, v) in zip(values, centers, strict=True):
        assert abs(value * s - acb(u, v)) < 1
    return centers


def slice_transform(rows, p):
    n = len(rows)
    s = 1 << p
    roots = chirps(n, p)
    pre = [quantize(pairmul((a, b), root), s) for (a,b,_), root in zip(rows,roots,strict=True)]
    ring = Cyclic(n, max(1,max(abs(v) for z in pre for v in z)), s)
    u, v = ring.product(ring.complex_pack(pre), ring.complex_pack([(x,-y) for x,y in roots]), fmpz)
    conv = zip(ring.unpack(u), ring.unpack(v), strict=True)
    out = [quantize(pairmul(z, w), s*s) for z,w in zip(conv,roots,strict=True)]
    # Three perturbed unit factors, one prechirp rounding per input, and one final rounding.
    l1 = sum(upnorm(a,b) for a,b,_ in rows)
    radius = sum(e for _,_,e in rows) + 1 + div_up(
        l1 * ((s+1)**3-s**3) + n * s*(s+1)**2, s**3)
    return [(a, b, radius) for a,b in out[1:]]


def tensor(source, p):
    divisor = 1 << (SOURCE_BITS-p)
    # The original Hurwitz value is within 1 Euclidean unit on the fine grid.
    # The two-coordinate nearest rounding adds at most sqrt(1/2) coarse units.
    assert divisor >= 4
    base = [quantize(z, divisor) for z in source]
    first = [(a-c,b-d,2) for (a,b),(c,d) in zip(base[::2],base[1::2],strict=True)]
    middle = [slice_transform(first[i:i+40],p) for i in range(0,len(first),40)]
    return [r for col in zip(*middle,strict=True) for r in slice_transform(col,p)]


def read_signs(tag):
    mid = tag == "mid"
    name = "high-midpoints.tsv.gz" if mid else tag + "-signs.tsv.gz"
    path = HOL / "c10004-grid-repair" / name
    with gzip.open(path, "rt", newline="") as f:
        rows = csv.DictReader(f, delimiter="\t")
        return {((2*int(r["left_j"])+1 if mid else int(r["j"])),
                 int(r["k41"]),int(r["k61"])):int(r["sign"]) for r in rows}


def main():
    ctx.prec, ctx.threads = 224, 1
    labels, phase = complete.phases()
    results, hashes = {}, {}
    for tag, nodes in (("low",range(1,33)),("high",range(84184,84200)),("mid",range(168369,168398,2))):
        existing = read_signs(tag)
        assert len(existing) == len(nodes) * len(labels)
        ledger = {p:[] for p in PRECISIONS}
        for j in nodes:
            path = (HOL / "c10004-time-slab" / f"h{j}.tsv" if tag=="low" else
                    HOL / "c10004-grid-repair" / f"j{j}-source.tsv")
            if tag == "mid":
                path = HOL / "c10004-grid-repair" / f"mid{j}-source.tsv"
            hashes[path.name] = hashlib.sha256(path.read_bytes()).hexdigest()
            raw = complete.comp.read(path)
            assert [int(row["index"]) for row in raw] == list(range(4800))
            source = [(int(r["re"]),int(r["im"])) for r in raw]
            t = arb(5*j)/(128 if tag=="mid" else 64)
            z = acb(arb(1)/2,t)
            parts = [f*acb(complete.Q)**(-z) for f in complete.factors(t)]
            factors = [phase[k]*parts[complete.comp.parity(*k)] for k in labels]
            for p in PRECISIONS:
                values = tensor(source,p)
                unsure = []
                for k,(a,b,e),f in zip(labels,values,factors,strict=True):
                    enclosed = f*acb(arb(a,e),arb(b,e))/(1<<p)
                    assert enclosed.imag.contains(0)
                    sign = int(enclosed.real>0)-int(enclosed.real<0)
                    if sign:
                        assert existing[(j,*k)]==sign
                    else:
                        unsure.append(k)
                ledger[p].append(dict(j=j,uncertain=len(unsure),uncertain_labels=unsure))
        results[tag] = {p:dict(signs=len(existing),unresolved=sum(r["uncertain"] for r in rows),
                               nodes_with_unresolved=sum(bool(r["uncertain"]) for r in rows),nodes=rows)
                        for p,rows in ledger.items()}
        print(tag,[(p,r["unresolved"],r["nodes_with_unresolved"]) for p,r in results[tag].items()],flush=True)
    receipt = dict(conductor=complete.Q,source_bits=SOURCE_BITS,source_hashes=hashes,
                   script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),results=results)
    (HERE / "signs.json").write_text(json.dumps(receipt,indent=2)+"\n")


if __name__=="__main__":
    main()
