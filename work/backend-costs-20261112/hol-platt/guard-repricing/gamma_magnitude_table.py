"""Create certified dyadic gamma magnitude tables for every large-family base tick."""
from hashlib import sha256
from pathlib import Path
from time import process_time,perf_counter
from statistics import median
import json
from flint import acb,arb,ctx

here=Path(__file__).resolve().parent
manifest=here.parents[2]/"qrh-campaign/agents/integration/transform_structural_manifest_20261111.json"
raw=manifest.read_bytes()
rows=json.loads(raw)["conductors"]
length,q=max((r[4]+41+640,r[0]) for r in rows)
assert (length,q)==(84881,10004)
ctx.prec,ctx.threads=128,1
pi=arb.pi()
def encode(x,bits):
    m,e=x.mid().man_exp()
    exponent=int(e)+int(m).bit_length()-1
    quantum=arb((1,exponent-bits))
    k=int((x/quantum).floor().unique_fmpz())
    assert 1<<bits<=k<2<<bits and k*quantum<=x and x<=(k+1)*quantum
    return exponent.to_bytes(1,"big",signed=True)+(k-(1<<bits)).to_bytes(bits//8,"big")

tables={16:bytearray(),24:bytearray()}
cpu,wall=process_time(),perf_counter()
for j in range(length):
    t=arb(5*j)/64
    for a in (0,1):
        x=arb(1+2*a)/4
        # Real(logGamma) is log|Gamma|, independent of the logarithm branch.
        log_magnitude=acb(x,t/2).lgamma().real+pi*t/4-x*pi.log()
        value=log_magnitude.exp()
        assert value>0
        for bits,table in tables.items():
            table.extend(encode(value,bits))
generation_cpu=process_time()-cpu
generation_wall=perf_counter()-wall
entries={}
for bits,table in tables.items():
    path=here/f"gamma-magnitude-p{bits}.bin"
    path.write_bytes(table)
    assert len(table)==2*length*(1+bits//8)
    entries[bits]=dict(bytes=len(table),sha256=sha256(table).hexdigest())

# Check every serialized interval again at independent precision, using |Gamma|
# directly rather than the real part of logGamma.
cpu,wall=process_time(),perf_counter()
ctx.prec=192
pi=arb.pi()
for j in range(length):
    t=arb(5*j)/64
    products={bits:arb(1) for bits in tables}
    for a in (0,1):
        x=arb(1+2*a)/4
        v=(pi*t/4).exp()*abs(acb(x,t/2).gamma())/pi**x
        for bits,table in tables.items():
            width=1+bits//8
            offset=width*(2*j+a)
            exponent=int.from_bytes(table[offset:offset+1],"big",signed=True)
            k=(1<<bits)+int.from_bytes(table[offset+1:offset+width],"big")
            quantum=arb((1,exponent-bits))
            assert k*quantum<=v and v<=(k+1)*quantum
            products[bits]*=arb((k+arb(1)/2)*quantum,quantum/2)
    exact_product=2/(1+(-2*pi*t).exp()).sqrt()
    assert all(iv.contains(exact_product) for iv in products.values())
check_cpu=process_time()-cpu
check_wall=perf_counter()-wall

def product(center,radius,k):
    mid=2*k+1
    return mid*center,mid*radius+abs(center)+radius

# Integer multiplier throughput at the actual p81 input center/radius widths.
fixture=json.loads((here.parent/"dispatched-score/precision-audit.json").read_bytes())["q10004_j1_p81"]
sample=fixture["worst"]
v,d=int(sample["v"]),int(sample["d"])
times=[]
for _ in range(7):
    start=perf_counter()
    for j in range(100000):
        z=product(v,d,(1<<24)+(j%1021))
    times.append((perf_counter()-start)*1e9/100000)
out=dict(ticks=length,indices=[0,length-1],largest_q_for_length=q,rows=len(rows),entries=2*length,
    generator_cpu_s=generation_cpu,generator_wall_s=generation_wall,direct_check_cpu_s=check_cpu,
    direct_check_wall_s=check_wall,reflection_identity_ticks=length,tables=entries,manifest_sha256=sha256(raw).hexdigest(),
    certified_factor="exp(pi*t/4) |Gamma((1/2+a+it)/2)| pi^(-(1+2a)/4); conductor factor omitted",
    format="tick-major, parity even then odd; signed int8 floor(log2), unsigned big-endian fraction B bits; k=2^B+fraction, dyadic interval [k,k+1]*2^(exponent-B)",
    cpu_scope="Single-thread native generation computed gamma once per entry and encoded both tables. Verification recomputed every entry at 192 bits using gamma directly. File writes excluded from timings.",
    sparse_integer_product_ns=median(times),product_input_bit_widths=[abs(v).bit_length(),d.bit_length()],
    product_scope="Native integer center/radius product on already-loaded k, excluding lookup, serialization and HOL.")
(here/"gamma-magnitude-table.json").write_text(json.dumps(out,indent=2)+"\n")
print(json.dumps(out,indent=2))
