"""Price a shared source-coefficient table built by local Taylor translations."""
from fractions import Fraction
from functools import lru_cache
from hashlib import sha256
from math import comb
from pathlib import Path
from statistics import mean
from time import perf_counter, process_time
import json

from flint import acb, arb, ctx

HERE = Path(__file__).resolve().parent
BANDS = HERE.parent/"large-weighted-slab/later-band-budget.json"
ORDER = 20
OUTPUT_BITS = 94
CELLS = 16
SEED_BITS = 320


def nearest(x, p):
    z = (x*(1<<p)+arb(1)/2).floor().unique_fmpz()
    if z is None:
        raise ArithmeticError("unresolved seed rounding")
    return int(z)


def seed(f, anchor, j, degree, p):
    s = acb(arb(1)/2,arb(5*j)/64)
    a = 1+arb(anchor)/f
    factor = acb(1)
    out = []
    for m in range(degree+1):
        z = factor*(s+m).zeta(a)
        x,y = nearest(z.real,p),nearest(z.imag,p)
        assert abs(z*(1<<p)-acb(x,y)) < 1
        out.append((x,y))
        factor *= -2*(s+m)/(f*(m+1))
    return out


def bounds(f, last, degree):
    # z = f*(a-a0)/2. Sixteen consecutive grid sites are at |z| <= 4.
    h = Fraction(CELLS,4)
    height = 1+(5*last+63)//64
    m = degree+1
    amplitude = Fraction(2)
    for r in range(m):
        amplitude *= Fraction(2*(height+r),f*(r+1))
    errors = []
    for k in range(ORDER):
        ratio = Fraction(2*(height+m),f*(m+1-k))*h
        if ratio>=1:
            return None
        remainder = amplitude*comb(m,k)*h**(m-k)/(1-ratio)
        rounding = sum(comb(n,k)*h**(n-k) for n in range(k,m))/(1<<SEED_BITS)
        errors.append(remainder+rounding)
    return max(errors)


@lru_cache(None)
def weights(degree, offset):
    # Common denominator 2^degree, offset/2 in the local coordinate.
    return [[comb(m,k)*offset**(m-k)*(1<<(degree-m+k))
             for m in range(k,degree+1)] for k in range(ORDER)]


def expand(coeffs, offset):
    degree = len(coeffs)-1
    drop = SEED_BITS+degree-OUTPUT_BITS
    def coord(k,ws,j):
        numerator = sum(w*z[j] for w,z in zip(ws,coeffs[k:],strict=True))
        return (numerator+(1<<(drop-1))) >> drop
    return [(coord(k,ws,0),coord(k,ws,1)) for k,ws in enumerate(weights(degree,offset))]


def timed(run):
    begin,t = process_time(),perf_counter()
    count=0
    while True:
        answer=run()
        count+=1
        cpu=process_time()-begin
        if cpu>=0.20:
            return answer,cpu/count,(perf_counter()-t)/count,count


def main():
    ctx.prec,ctx.threads = 440,1
    configuration = json.loads(BANDS.read_bytes())["bands"]
    result = []
    for i,band in enumerate(configuration,1):
        lo,hi = band["height_indices"]
        f = band["cells"]-1
        for degree in range(32,193,4):
            error = bounds(f,hi-1,degree)
            if error is not None and error < Fraction(1,1<<110):
                break
        else:
            raise ValueError("larger seed precision or degree required")
        # Weights are the same at every group and height for a given degree.
        for off in range(-8,8):
            weights(degree,off)
        panels = []
        for b in range(3):
            # Sample the height and the spatial coordinate separately by rotating thirds.
            j = lo+(hi-lo)*(2*b+1)//6
            start = (f*((2*((b+i)%3)+1))//6)//CELLS*CELLS
            mid = start+8
            co,seed_time,seed_wall,ns = timed(lambda: seed(f,mid,j,degree,SEED_BITS))
            table,translation_time,translation_wall,nt = timed(lambda: [expand(co,off) for off in range(-8,8)])
            # Direct unrelated evaluations at both ends and two interior target cells.
            worst=0
            direct_rows,direct_time,direct_wall,nd = timed(lambda: [seed(f,start+ix,j,ORDER-1,OUTPUT_BITS)
                                                          for ix in (0,5,10,15)])
            for ix,direct in zip((0,5,10,15),direct_rows,strict=True):
                worst = max(worst,max(abs(u-v) for a,c in zip(table[ix],direct,strict=True)
                                      for u,v in zip(a,c,strict=True)))
            assert worst<=1
            panels.append(dict(j=j,first_cell=start,seed_cpu=seed_time,seed_wall=seed_wall,
                translate_cpu=translation_time,translate_wall=translation_wall,
                four_direct_cells_cpu=direct_time,four_direct_cells_wall=direct_wall,
                max_coordinate_delta=worst,repetitions=[ns,nt,nd]))
        # A center table every 16 cells, with one remaining end cell evaluated directly.
        heights=hi-lo
        native = heights*(f//CELLS*mean(p["seed_cpu"]+p["translate_cpu"] for p in panels)
                          +mean(p["four_direct_cells_cpu"]/4 for p in panels))/3600
        direct = heights*(f+1)*mean(p["four_direct_cells_cpu"]/4 for p in panels)/3600
        result.append(dict(band=i,f=f,lo=lo,hi=hi,degree=degree,panels=panels,
            uniform_seed_and_tail_error_in_grid_units=float(error*(1<<OUTPUT_BITS)),
            original_complex_coefficients=heights*(f+1)*ORDER,
            seed_groups=heights*(f//CELLS),endpoint_cells=heights,
            extrapolated_one_thread_hours=native,direct_one_thread_hours=direct))
        print(i,degree,round(native),round(direct),flush=True)
    totals = {key:sum(r[key] for r in result) for key in ["original_complex_coefficients",
        "seed_groups","endpoint_cells","extrapolated_one_thread_hours","direct_one_thread_hours"]}
    (HERE/"panels.json").write_text(json.dumps(dict(bands=result,totals=totals,precision=ctx.prec,
        seed_bits=SEED_BITS,source_grid_bits=OUTPUT_BITS,band_sha256=sha256(BANDS.read_bytes()).hexdigest()),
        indent=2)+"\n")


if __name__=="__main__":
    main()
