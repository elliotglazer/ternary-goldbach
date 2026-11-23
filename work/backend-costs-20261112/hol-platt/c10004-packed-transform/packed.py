"""Cross-height integer transforms at c=10004, with two rounding schedules."""

import argparse
import csv
import hashlib
import json
from pathlib import Path
from time import perf_counter, process_time


HERE = Path(__file__).resolve().parent
HOL = HERE.parent
G = 81
S = 1 << G
ROOTS = {int(n): row for n, row in json.loads(
    (HOL / "c10004-roots/table.json").read_bytes())["rows"].items()}


def bound_factor(n):
    """Bound every complex coordinate in units of a common input bound >= 1."""
    if n == 2:
        return 2
    if n in (3, 5):
        return 1 + 3 * (n-1)
    radix = 3 if n == 15 else 2
    return bound_factor(radix) * 3 * bound_factor(n//radix)


def depth(n):
    if n in (2, 3, 5):
        return int(n != 2)
    radix = 3 if n == 15 else 2
    return depth(n//radix) + 1 + depth(radix)


class Layout:
    def __init__(self, lanes, sign_bits, rounding_bits):
        self.lanes = lanes
        self.sign_bits = sign_bits
        self.bias = 1 << sign_bits
        self.field = self.bias*2 - 1
        self.bytes = (sign_bits + 1 + rounding_bits + 7)//8
        self.bits = 8*self.bytes
        self.ones = ((1 << (self.bits*lanes))-1)//((1 << self.bits)-1)
        self.mask = self.field*self.ones
        self.shift_bias = self.bias*self.ones
        self.round_offset = ((self.bias << G) + S//2)*self.ones

    def pack(self, signed):
        if len(signed) != self.lanes or any(abs(x) >= self.bias for x in signed):
            raise ValueError("input outside signed lane range")
        data = b"".join((x+self.bias).to_bytes(self.bytes, "little") for x in signed)
        return int.from_bytes(data, "little") - self.shift_bias

    def unpack(self, packed):
        data = (packed+self.shift_bias).to_bytes(self.bytes*self.lanes, "little")
        values = [int.from_bytes(data[j:j+self.bytes], "little") - self.bias
                  for j in range(0, len(data), self.bytes)]
        if any(abs(x) > self.bias for x in values):
            raise ValueError("result outside certified lane range")
        return values

    def rounded(self, packed):
        return (((packed+self.round_offset) >> G) & self.mask) - self.shift_bias


def rotate(z, n, k, layout, delayed):
    a, b = z
    scale = S if delayed else 1
    k %= n
    if k == 0:
        return a*scale, b*scale
    if 2*k == n:
        return -a*scale, -b*scale
    if 4*k == n:
        return -b*scale, a*scale
    if 4*k == 3*n:
        return b*scale, -a*scale
    wr, wi = ROOTS[n][k]
    t = wr*(a+b)
    real, imag = t-b*(wr+wi), t+a*(wi-wr)
    if delayed:
        return real, imag
    return layout.rounded(real), layout.rounded(imag)


def direct(row, k, layout, delayed):
    ar, ai = row[0]
    n = len(row)
    if n == 2:
        br, bi = row[1]
        return (ar-br, ai-bi) if k % 2 else (ar+br, ai+bi)
    if delayed:
        ar, ai = ar*S, ai*S
    for j in range(1, n):
        br, bi = rotate(row[j], n, k*j, layout, delayed)
        ar, ai = ar+br, ai+bi
    return ar, ai


def transform(row, omit, layout, delayed):
    n = len(row)
    if n in (2, 3, 5):
        return [direct(row, i, layout, delayed) for i in range(omit, n)]
    r = 3 if n == 15 else 2
    m = n//r
    children = [transform(row[j::r], False, layout, delayed) for j in range(r)]
    bridge = [[rotate(children[j][v], n, j*v, layout, delayed) for j in range(r)]
              for v in range(m)]
    return [direct(bridge[k % m], k//m, layout, delayed) for k in range(omit, n)]


def tensor(xs, layout, delayed):
    def run(row):
        return transform(row, True, layout, delayed)
    first = [run(xs[j:j+2])[0] for j in range(0, len(xs), 2)]
    middle = [run(first[j:j+40]) for j in range(0, len(first), 40)]
    return [z for col in zip(*middle) for z in run(col)]


def read(path, count, labels):
    with path.open() as f:
        rows = list(csv.DictReader(f, delimiter="\t"))
    if len(rows) != count or any(not labels(i,r) for i,r in enumerate(rows)):
        raise ValueError(f"unexpected coordinates in {path}")
    real, imag = ("re", "im") if "re" in rows[0] else ("re_grid", "im_grid")
    return [(int(r[real]), int(r[imag])) for r in rows]


def read_data(slab):
    sources, outputs, files = [], [], []
    hs = list(range(1, slab+1)) if slab else [1,2,84198,84199]
    for h in hs:
        if slab:
            p = HOL / "c10004-time-slab"
            source, expected = p / f"h{h}.tsv", p / f"h{h}-spectrum.tsv"
        elif h <= 2:
            source = HOL / f"c10004-reference/h{h}.tsv"
            expected = HOL / f"c10004-real-transform/h{h}-spectrum.tsv"
        else:
            p = HOL / "c10004-high-reference"
            source, expected = p / f"j{h}-source.tsv", p / f"j{h}-completed.tsv"
        sources.append(read(source, 4800, lambda i,r: int(r["index"]) == i))
        outputs.append(read(expected, 2301, lambda i,r: (int(r["k41"]),int(r["k61"]))
                            == (1+i//59,1+i%59)))
        files.extend([source, expected])
    return hs, sources, outputs, files


def timed(fn):
    cpu, wall = process_time(), perf_counter()
    result = fn()
    return result, {"cpu": process_time()-cpu, "wall": perf_counter()-wall}


def benchmark(sources, outputs, delayed):
    bound = max(abs(v) for xs in sources for pair in xs for v in pair)
    for n in (2, 40, 60):
        bound *= bound_factor(n)
    final_bits = G*sum(map(depth, (2,40,60))) if delayed else 0
    bits = bound.bit_length() + final_bits
    layout = Layout(len(sources), bits, 0 if delayed else G)

    def pack():
        return [(layout.pack([p[0] for p in row]), layout.pack([p[1] for p in row]))
                for row in zip(*sources)]

    def unpack(packed):
        columns = [list(zip(layout.unpack(a),layout.unpack(b))) for a,b in packed]
        if final_bits:
            half = 1 << (final_bits-1)
            columns = [[((a+half) >> final_bits,(b+half) >> final_bits) for a,b in col]
                       for col in columns]
        return [list(xs) for xs in zip(*columns)]

    packed, tin = timed(pack)
    result, tfft = timed(lambda: tensor(packed,layout,delayed))
    xs, tout = timed(lambda: unpack(result))
    maximum = max(max(abs(a-u), abs(b-v)) for ys,refs in zip(xs,outputs,strict=True)
                  for (a,b),(u,v) in zip(ys,refs,strict=True))
    if not delayed and maximum != 0:
        raise ValueError(f"eager result differs by {maximum} grid units")
    return dict(lanes=layout.lanes, lane_bits=layout.bits, field_bits=bits,
                delayed_scale_bits=final_bits, max_coordinate_difference=maximum,
                outputs=2301*len(sources), pack=tin, transform=tfft, unpack=tout)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--slab", type=int, default=0)
    args = parser.parse_args()
    hs, sources, outputs, files = read_data(args.slab)
    result = {key: benchmark(sources,outputs,delayed) for key, delayed in
              (("original_rounding",False), ("delayed_rounding",True))}
    result["height_indices"] = hs
    result["sha256"] = {str(p.relative_to(HOL)): hashlib.sha256(p.read_bytes()).hexdigest()
                         for p in files + [HOL / "c10004-roots/table.json", Path(__file__).resolve()]}
    print(json.dumps(result, indent=2))
