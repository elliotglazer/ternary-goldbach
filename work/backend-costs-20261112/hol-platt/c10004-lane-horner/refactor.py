from pathlib import Path
p=Path("benchmark.py")
s=p.read_text().replace("def prepare(rows,r):\n    p,nb=parameters(r)\n    n=len(rows)\n    unit=pack([1]*n,nb)\n    co=[pack((row[i]+b for row in rows),nb) for i,b in enumerate(bias)]","""STRIDE = parameters(5002)[1]
def coefficient_pack(rows):
    return [pack((row[i]+b for row in rows),STRIDE) for i,b in enumerate(bias)]

def residual_setup(n,r):
    p,_=parameters(r)
    unit=pack([1]*n,STRIDE)""").replace("return co,op,nb,n","return op\n\ndef prepare(rows,r):\n    return coefficient_pack(rows),residual_setup(len(rows),r),STRIDE,len(rows)")
s=s.replace("rng=random.Random(10004)","def main():\n    rng=random.Random(10004)")
before,after=s.split("def residual(a):")
fn,rest=after.split("for a in [1")
s=before.split("def main():")[0]+"def residual(a):"+fn+"def main():\n    rng=random.Random(10004)\n"+"\n".join("    "+l for l in ("for a in [1"+rest).splitlines())+"\n"
s=s.replace("pack_transpose_setup_us","coef_transpose_pack_us,residual_setup_us").replace("timed(lambda:prepare(rows,r),loops)","timed(lambda:coefficient_pack(rows),loops),timed(lambda:residual_setup(len(rows),r),loops)")
s+="""    # Materialize next height-major tensor slab from residue-major evaluations.
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
"""
p.write_text(s)
