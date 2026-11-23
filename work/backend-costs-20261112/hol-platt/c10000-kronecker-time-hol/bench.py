import hashlib,json,sys,statistics
from pathlib import Path
from time import process_time_ns,perf_counter_ns
here=Path(__file__).resolve().parent
def seed(tag):
    s=hashlib.shake_256(tag.encode()).digest(128)
    return int.from_bytes(s,"big") | 2**1023 | 1
A=seed("tile-price/A");B=seed("tile-price/B")
sizes=[6144,65536,524288,2097152]+[65536*w//8 for w in (552,616,680,744)]
mod=65537
def repetitions(size):
    return (0,32,96) if size<100000 else (0,3,8)
def expected(size,r):
    copies=size//128
    x=(-A*copies)%mod;y=(B*copies)%mod
    return (x+y)%mod+sum(((x+i)*y)%mod for i in range(r))
def generate():
    txt=(here/"TilePrice.sml.in").read_text().replace("SEEDA",str(A)).replace("SEEDB",str(B))
    rows=[(s,r,expected(s,r)) for s in sizes for r in repetitions(s)]
    (here/"TilePriceScript.sml").write_text(txt+"\nval rows = ["+",".join(f"({s},{r},{e})" for s,r,e in rows)+"];\nval _=List.app one rows;\nval _=List.app one (rev rows);\n")
def native():
    from flint import ctx,fmpz
    ctx.threads=1
    small_only="--short-native" in sys.argv
    ans=json.loads((here/"native.json").read_bytes()) if small_only else {}
    for size in sizes:
        if small_only and size>=100000:continue
        t=process_time_ns()
        scale=((fmpz(1)<<(8*size))-1)//((fmpz(1)<<1024)-1)
        x=-A*scale;y=B*scale
        c=process_time_ns()-t
        assert int(abs(x).bit_length())==int(y.bit_length())==8*size
        rec=[]
        for r in ({6144:4096,65536:256}.get(size,repetitions(size)[-1]),)*3:
            cpu=process_time_ns();wall=perf_counter_ns()
            z=x*y
            single_wall=perf_counter_ns()-wall;single_cpu=process_time_ns()-cpu
            assert int(z%mod)==(int(x%mod)*int(y%mod))%mod
            cpu=process_time_ns();wall=perf_counter_ns()
            total=int((x+y)%mod)
            for i in range(r):
                total+=int(((x+i)*y)%mod)
            elapsed_wall=perf_counter_ns()-wall;elapsed_cpu=process_time_ns()-cpu
            assert total==expected(size,r)
            rec.append(dict(r=r,cpu_each=elapsed_cpu*1e-9/r,wall_each=elapsed_wall*1e-9/r,single_cpu=single_cpu*1e-9,single_wall=single_wall*1e-9))
        ans[str(size)]=dict(setup_cpu=c*1e-9,measurements=rec)
    (here/"native.json").write_text(json.dumps(ans,indent=2)+"\n")
if __name__=="__main__":
    (native if "--native" in sys.argv or "--short-native" in sys.argv else generate)()

