"""Compute the p307 length-500 Bluestein convolution by signed integer packing."""

import argparse
import hashlib
import json
from pathlib import Path
from statistics import median
from time import perf_counter_ns


HERE = Path(__file__).resolve().parent
SOURCE = HERE.parent / "c10000-bluestein-hol"
S = 1 << 307


def pairmul(z, w):
    x,y = z
    u,v = w
    return x*u-y*v, x*v+y*u


def quantize(z, denominator):
    return tuple((2*x+denominator)//(2*denominator) for x in z)


def rows(name):
    return [tuple(map(int,line.split())) for line in (SOURCE/name).read_text().splitlines()]


class Cyclic:
    def __init__(self, n, max_a, max_b):
        # Each real or imaginary coefficient has at most 2n products.
        bound = 2*n*max_a*max_b
        self.width = (bound.bit_length()+1+7)//8
        self.n = n
        self.base = 1 << (8*self.width)
        self.bias = self.base//2
        if bound >= self.bias-1:
            raise ValueError("insufficient signed digit range")
        self.bits = n*8*self.width
        self.modulus = (1 << self.bits)-1
        self.offset = self.bias*(self.modulus//(self.base-1))

    def pack(self, values):
        digits = b"".join((v+self.bias).to_bytes(self.width,"little") for v in values)
        return int.from_bytes(digits,"little") - self.offset

    def unpack(self, number):
        # 2^bits = 1 mod modulus. Both signed product differences also fold.
        number += self.offset
        folded = (number & self.modulus) + (number >> self.bits)
        digits = (folded % self.modulus).to_bytes(self.n*self.width,"little")
        return [int.from_bytes(digits[i:i+self.width],"little")-self.bias
                for i in range(0,len(digits),self.width)]

    def complex_pack(self, row):
        x,y = zip(*row)
        return self.pack(x), self.pack(y)

    def product(self, a, b, number_type):
        x,y = map(number_type,a)
        u,v = map(number_type,b)
        first = x*u
        second = y*v
        third = (x+y)*(u+v)
        return int(first-second), int(third-first-second)


def timing(fn):
    times = []
    for _ in range(7):
        start = perf_counter_ns()
        fn()
        times.append((perf_counter_ns()-start)/1e6)
    return median(times)


def main(number_type, publish):
    inputs = rows("inputs.tsv")
    chirps = rows("chirps.tsv")
    n = len(inputs)
    if n != 500 or len(chirps) != n or any(len(z)!=2 for z in inputs+chirps):
        raise ValueError("unexpected source")
    def prepare():
        return [quantize(pairmul(z,w),S) for z,w in zip(inputs,chirps,strict=True)]
    a = prepare()
    b = [(x,-y) for x,y in chirps]
    ring = Cyclic(n,max(abs(v) for z in a for v in z),max(abs(v) for z in b for v in z))
    pa, pb = ring.complex_pack(a), ring.complex_pack(b)
    def products():
        return ring.product(pa,pb,number_type)
    real, imag = products()
    def unpack():
        return list(zip(ring.unpack(real),ring.unpack(imag)))
    conv = unpack()
    def finish(conv):
        return [quantize(pairmul(z,w),S*S) for z,w in zip(conv,chirps,strict=True)]
    out = finish(conv)
    def run(cached):
        kernel = pb if cached else ring.complex_pack(b)
        u,v = ring.product(ring.complex_pack(prepare()),kernel,number_type)
        return finish(list(zip(ring.unpack(u),ring.unpack(v))))
    # Direct complex multiplication and circular indexing, with no digit packing.
    direct = []
    for k in range(n):
        xr = xi = 0
        for j,z in enumerate(a):
            dr,di = pairmul(z,b[(k-j)%n])
            xr,xi = xr+dr,xi+di
        direct.append((xr,xi))
    if direct != conv or finish(direct) != out:
        raise ValueError("packed convolution differs from direct convolution")
    if publish:
        (HERE/"output.tsv").write_text("".join(f"{i}\t{x}\t{y}\n"
                                               for i,(x,y) in enumerate(out)),encoding="ascii")
        cr,ci = ring.complex_pack(conv)
        operand = dict(n=n,width_bytes=ring.width,
                       signed_hex={k:hex(v) for k,v in zip(
                           ("ar","ai","br","bi","conv_r","conv_i"),(*pa,*pb,cr,ci),strict=True)})
        (HERE/"operands.json").write_text(json.dumps(operand)+"\n",encoding="ascii")
    return dict(n=n,width_bytes=ring.width,backend=number_type.__name__,
                arithmetic="three exact integer products, cyclic fold; rounded prechirp and last output",
                checked_direct_outputs=len(out),median_wall_milliseconds={
                    "prechirp":timing(prepare),"pack_input":timing(lambda:ring.complex_pack(a)),
                    "pack_kernel":timing(lambda:ring.complex_pack(b)),"three_products":timing(products),
                    "cyclic_reduce_unpack":timing(unpack),"postchirp":timing(lambda:finish(conv)),
                    "warm_all":timing(lambda:run(True)),"cold_all":timing(lambda:run(False))},
                sha256={name:hashlib.sha256((SOURCE/name).read_bytes()).hexdigest()
                        for name in ("inputs.tsv","chirps.tsv")})


if __name__=="__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--flint",action="store_true")
    ap.add_argument("--publish",action="store_true")
    arg = ap.parse_args()
    if arg.flint:
        from flint import fmpz
        typ = fmpz
    else:
        typ = int
    print(json.dumps(main(typ,arg.publish),indent=2))
