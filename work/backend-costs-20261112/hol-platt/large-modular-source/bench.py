"""Compare an exact modular evaluation of the stored polynomial with Horner."""
import hashlib
import json
from math import gcd
from pathlib import Path
from statistics import median
from time import perf_counter_ns

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
LOW = HOL / "c10004-p20-source/h1-mixed.json"
EDGE = HOL / "c10004-exact-horner/edge-slab.json"


def horner(xs, arg):
    value = 0
    for x in reversed(xs):
        value = value * arg + x
    return value


def prepare(c, cell, mixed, grids):
    g = gcd(1024, c)
    v = 2 * c // g
    columns = [[x << (94 - bits) for x in pair] for pair, bits in zip(mixed, grids, strict=True)]
    while len(columns) > 1 and columns[-1] == [0, 0]:
        columns.pop()
    d = len(columns) - 1
    den = v**d
    # abs(r/v) <= 1/4, so the absolute value of P(r/v) is <= (4/3) max |C_j|.
    bias = 2 * max(abs(x) for col in columns for x in col) + 1
    shift = bias * den + den // 2
    # B*v - r > (2*bias+1)*den for every selected residual.
    base = 1 << (((2*bias+1)*den // v + 2).bit_length())
    coords = list(zip(*columns))
    constants = [den*horner(xs, base) + shift for xs in coords]
    direct = [[x*v**(d-j) for j, x in enumerate(xs)] for xs in coords]
    # The nearest cell with ties to the smaller cell, restricted to the unit interval.
    lower = max(1, ((2*cell-1)*c)//2048 + 1)
    upper = min(c-1, ((2*cell+1)*c)//2048)
    residues = [(1024*a-cell*c)//g for a in range(lower, upper+1) if gcd(a,c)==1]
    assert residues and all(4*abs(r)<=v and base*v-r>(2*bias+1)*den for r in residues)
    return den, bias, base*v, constants, direct, residues


def evaluate(params):
    den, bias, center, constants, direct, residues = params
    def mod():
        return [x % (center - r) // den - bias for r in residues for x in constants]
    def ref():
        return [(horner(xs, r) + den//2)//den for r in residues for xs in direct]
    return mod, ref


def measured(fn, count):
    times = []
    for _ in range(5):
        start = perf_counter_ns()
        for _ in range(8):
            fn()
        times.append((perf_counter_ns()-start)/(8000*count))
    return median(times)


def main():
    low = json.loads(LOW.read_bytes())
    edge = json.loads(EDGE.read_bytes())
    grids = edge["grids"]
    coverage, receipts = [], []
    with (HERE / "terms.txt").open("w", encoding="ascii", newline="\n") as f:
        for c,h,cells in [(131071,1,low),(265800,1,low),(131072,6337,edge["rows"][0]["mixed"]),
                          (131072,6400,edge["rows"][-1]["mixed"]),
                          (131068,6337,edge["rows"][0]["mixed"]),
                          (100004,6400,edge["rows"][-1]["mixed"])]:
            count = 0
            for key, mixed in cells.items():
                k = int(key)
                args = prepare(c,k,mixed,grids)
                mod,ref = evaluate(args)
                expected = ref()
                assert mod()==expected, (c,h,k)
                count += len(expected)//2
                if k != (512 if h==1 else 1):
                    continue
                den, bias, center, constants, direct, residues = args
                bias_num = bias*den + den//2
                g = gcd(1024,c)
                v = 2*c//g
                coeffs = [[x // v**(len(xs)-1-j) for j,x in enumerate(xs)] for xs in direct]
                name = f"c{c}h{h}k{k}"
                print(name,den,bias,center,center//v,bias_num,file=f)
                for row in [residues,constants,*direct,*coeffs,expected]:
                    print(*row,file=f)
                receipts.append(dict(name=name,complex=len(residues),degree=len(direct[0])-1,
                                     numerator_bits=[abs(x).bit_length() for x in constants],
                                     modulus_bits=center.bit_length(),
                                     modular_us=measured(mod,len(residues)),direct_us=measured(ref,len(residues))))
            coverage.append(dict(c=c,h=h,cells=len(cells),exact_complex_matches=count))
    paths = [LOW, EDGE, HERE/"terms.txt", Path(__file__)]
    return dict(coverage=coverage,measurements=receipts,
                sha256={str(p.relative_to(HOL)): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})


if __name__ == "__main__":
    result = main()
    (HERE/"native.json").write_text(json.dumps(result, indent=2)+"\n")
    print(json.dumps(result, indent=2))

