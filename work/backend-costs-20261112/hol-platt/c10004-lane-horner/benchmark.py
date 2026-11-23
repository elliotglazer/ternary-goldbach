"""Fixed-residue, synthetic K20 coefficients. Run with bundled Python."""
import hashlib
import json
import random

from pathlib import Path
from statistics import median
from time import perf_counter_ns

here = Path(__file__).resolve().parent
receipt = here.parents[2]/"qrh-campaign/agents/integration/guarded_residue_evaluation_frontier_20261111.json"
blob = receipt.read_bytes()
assert hashlib.sha256(blob).hexdigest() == "da5b4b1c09a5d6f10d8b1133af5f2bd95e9711bdb309dd1f1feab4e8e7e1a5f7"
rec = json.loads(blob)["selected_records"]["band1_K20_b94"]
stages = rec["stages"]
widths = [s["Mbits"] for s in stages] + [rec["output_signed_bits"]]
bias = [1 << w for w in widths]
deltas = [s["grids"][1]-s["grids"][0] for s in stages]
v = 20008

def reference(rows,r):
    out = []
    for row in rows:
        x = row[0]
        for d,c in zip(deltas,row[1:]):
            x = ((r*x << d)+v//2)//v+c
        out.append(64*x)
    return out

def parameters(r):
    params=[]
    bits=0
    for i,d in enumerate(deltas):
        c=abs(r)<<d
        offset=(v//2-c*bias[i])%v
        correction=(c*bias[i]+offset-v//2)//v
        w=max(1,(2*bias[i]*c+offset).bit_length())
        k=w+(v-1).bit_length()
        m=((1<<k)+v-1)//v
        qbits=max(1,((2*bias[i]*c+offset)//v).bit_length())
        bits=max(bits,w+m.bit_length(),qbits+k,widths[i+1]+4,qbits+2)
        params.append((c,offset,correction,k,m,qbits))
    return params,(bits+7)//8

def pack(xs,nb):
    return int.from_bytes(b"".join(x.to_bytes(nb,"little") for x in xs),"little")

def unpack(z,nb,n):
    raw=z.to_bytes(nb*n,"little")
    return [int.from_bytes(raw[i:i+nb],"little") for i in range(0,len(raw),nb)]

STRIDE = parameters(5002)[1]
def coefficient_pack(rows):
    return [pack((row[i]+b for row in rows),STRIDE) for i,b in enumerate(bias)]

def residual_setup(n,r):
    p,_=parameters(r)
    unit=pack([1]*n,STRIDE)
    op=[(c,offset*unit,correction*unit,k,m,((1<<qb)-1)*unit,2*bias[i]*unit)
        for i,(c,offset,correction,k,m,qb) in enumerate(p)]
    return op

def prepare(rows,r):
    return coefficient_pack(rows),residual_setup(len(rows),r),STRIDE,len(rows)

def evaluate(prepared,r):
    co,op,_,_=prepared
    z=co[0]
    for coef,(c,off,cor,k,m,mask,twob) in zip(co[1:],op):
        if r<0:
            z=twob-z
        z=(((z*c+off)*m >> k)&mask)+coef-cor
    return z

def discharge(z,prep):
    return [64*(x-bias[-1]) for x in unpack(z,prep[2],prep[3])]

def timed(f,loops):
    times=[]
    for _ in range(7):
        start=perf_counter_ns()
        for j in range(loops):
            f()
        times.append((perf_counter_ns()-start)/loops/1000)
    return round(median(times),2)

def check(rows,r):
    scalar=reference(rows,r)
    # Check all intermediate bounds independently for this input block.
    for row in rows:
        x=row[0]
        for i,(d,co) in enumerate(zip(deltas,row[1:])):
            assert abs(x)<bias[i] and abs(co)<bias[i+1]
            x=((r*x << d)+v//2)//v+co
        assert abs(x)<bias[-1]
    p=prepare(rows,r)
    z=evaluate(p,r)
    assert discharge(z,p)==scalar
    return p,z

def fixture(n,rng):
    return [[rng.randrange(-b//16,b//16) for b in bias] for _ in range(n)]

def residual(a):
    return 1024*a-10004*((2048*a+10003)//20008)
def main():
    rng=random.Random(10004)
    for a in [1,3,5,7,9,11,53,10003]:
        check(fixture(18,rng),residual(a))
    for r in [-5002,-1,0,1,5002]:
        rows=fixture(18,rng)
        rows[0][0]=5002
        check(rows,r)
    # Reciprocal proof edge cases and exact positive and negative half-integers.
    for w in [1,16,59,111]:
        k=w+(v-1).bit_length()
        m=((1<<k)+v-1)//v
        for n in [0,1,(1<<w)-1]+[rng.randrange(1<<w) for _ in range(1000)]:
            assert n*m>>k==n//v
    for t in [-4,-1,0,5]:
        x=t*v+v//2
        assert (x+v//2)//v == t+1
    
    r=residual(10003)
    print("heights,lanes,stride_bits,scalar_us,coef_transpose_pack_us,residual_setup_us,packed_eval_us,unpack_output_us,cold_us")
    for heights in [1,4,16,64,256]:
        rows=fixture(2*heights,rng)
        p,z=check(rows,r)
        loops=max(3,500//heights)
        def cold():
            prepared=prepare(rows,r)
            return discharge(evaluate(prepared,r),prepared)
        print(heights,len(rows),8*p[2],timed(lambda:reference(rows,r),loops),
              timed(lambda:coefficient_pack(rows),loops),timed(lambda:residual_setup(len(rows),r),loops),timed(lambda:evaluate(p,r),loops),
              timed(lambda:discharge(z,p),loops),timed(cold,loops),sep=",")
    
    # Materialize next height-major tensor slab from residue-major evaluations.
    heights=64
    residues=64
    grid=[check(fixture(2*heights,rng),residual(1+2*j))[1] for j in range(residues)]
    shape=(None,None,STRIDE,2*heights)
    def discharge_slab():
        decoded=[discharge(z,shape) for z in grid]
        return [[(row[2*h],row[2*h+1]) for row in decoded] for h in range(heights)]
    print("slab64x64_unpack_plus_transpose_us",timed(discharge_slab,10),sep=",")

if __name__=="__main__":
    main()
