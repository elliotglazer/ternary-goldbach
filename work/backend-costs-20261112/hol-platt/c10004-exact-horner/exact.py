"""Evaluate the stored mixed-grid K20 polynomial exactly up to terminal division."""

import hashlib
import json
import statistics
from pathlib import Path
from time import perf_counter_ns


HERE = Path(__file__).resolve().parent
SLAB = HERE.parent / "c10004-p20-slab/slab.json"
C = 10004
V = 2*C


def coefficients(rows, cell, grids):
    columns = [[(int(x) << (94-g)) for row in rows for x in row["mixed"][cell][j]]
               for j, g in enumerate(grids)]
    while len(columns) > 1 and not any(columns[-1]):
        columns.pop()
    return columns


def prepare(rows, cell, grids):
    columns = coefficients(rows, cell, grids)
    degree = len(columns)-1
    cols = [[n * V**(degree-j) for n in col] for j, col in enumerate(columns)]
    # For any anchored unit, |r| <= c/2. Bound every intermediate.
    bound = 0
    maximum = 0
    for col in reversed(cols):
        bound = (C//2)*bound + max(map(abs,col))
        maximum = max(maximum,bound)
    width = (maximum.bit_length()+8)//8
    base = 1 << (8*width)
    lanes = len(cols[0])
    ones = (base**lanes - 1)//(base-1)
    bias = base//2
    def pack(xs):
        raw = b"".join((x+bias).to_bytes(width,"little") for x in xs)
        return int.from_bytes(raw,"little") - bias*ones
    return dict(width=width, lanes=lanes, offset=bias*ones, bias=bias,
                denominator=V**degree, columns=list(map(pack, cols)), scalar=columns)


def accumulate(table, r):
    if 2*abs(r)>C:
        raise ValueError("residue outside selected nearest cell")
    columns = table["columns"]
    total = columns[-1]
    for x in reversed(columns[:-1]):
        total = r*total + x
    return total


def finish(table, total):
    width = table["width"]
    raw = (total + table["offset"]).to_bytes(width*table["lanes"], "little")
    den = table["denominator"]
    return [(2*(int.from_bytes(raw[i:i+width],"little")-table["bias"])+den)//(2*den)
            for i in range(0,len(raw),width)]


def check(table, cell, a, rows, centers):
    r = 1024*a-int(cell)*C
    columns = table["scalar"]
    degree = len(columns)-1
    den = V**degree
    worst = 0
    for i, z in enumerate(centers):
        num = sum(col[i]*r**j*V**(degree-j) for j, col in enumerate(columns))
        if (2*num+den)//(2*den) != z:
            raise ValueError("packed numerator disagrees with direct power sum")
        row = next(u for u in rows[i//2]["outputs"][cell] if u[0] == a)
        worst = max(worst,abs(z-row[1+i%2]))
    return worst


def median_us(fn):
    times = []
    for _ in range(9):
        start = perf_counter_ns()
        for _ in range(6):
            fn()
        times.append((perf_counter_ns()-start)/6000)
    return statistics.median(times)


def experiment(slab):
    cells, rows, grids = slab["cells"], slab["rows"], slab["grids"]
    def setup():
        return {cell: prepare(rows,cell,grids) for cell in cells}
    tables = setup()
    cases = [(cell, a, 1024*a-int(cell)*C) for cell in cells for a in cells[cell]]
    def hot():
        return [accumulate(tables[cell], r) for cell, _, r in cases]
    totals = hot()
    def decode():
        return [finish(tables[cell], n) for (cell,_,_), n in zip(cases,totals,strict=True)]
    def full(reuse):
        cache = tables if reuse else setup()
        return [finish(cache[cell],accumulate(cache[cell],r)) for cell,_,r in cases]
    delta = max(check(tables[cell],cell,a,rows,ys)
                for (cell,a,_),ys in zip(cases,decode(),strict=True))
    fixture = prepare(rows[:8],"1",grids)
    r = 1024*5-C
    out = accumulate(fixture,r)
    sample = {"h":list(range(1,9)), "cell":1, "residue":5, "r":r,
              "width_bytes":fixture["width"], "columns":fixture["columns"],
              "denominator":fixture["denominator"], "packed_numerator":out,
              "centers":finish(fixture,out)}
    (HERE/"h1-8-a5.json").write_text(json.dumps(sample,indent=2)+"\n",encoding="ascii")
    return dict(heights=len(rows),residues=len(cases),complex_outputs=len(rows)*len(cases),
                max_old_mixed_coordinate_difference=delta,
                degrees={k:len(t["columns"])-1 for k,t in tables.items()},
                lane_bytes={k:t["width"] for k,t in tables.items()},
                python_median_wall_us={"setup_both_cells":median_us(setup),
                    "seven_packed_accumulations":median_us(hot),"terminal_unpack_divide":median_us(decode),
                    "warm_complete":median_us(lambda:full(True)), "cold_complete":median_us(lambda:full(False))},
                sha256=hashlib.sha256(SLAB.read_bytes()).hexdigest())


if __name__ == "__main__":
    print(json.dumps(experiment(json.loads(SLAB.read_bytes())),indent=2))
