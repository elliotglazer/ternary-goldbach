"""One-core warm kernel shape prices. Inputs are dense deterministic integers."""
import json,random,sys
from pathlib import Path
from time import process_time,perf_counter
from statistics import median
from flint import fmpz,acb,ctx
here=Path(__file__).resolve().parent
sys.path.insert(0,str(here.parent/'c10000-kronecker'))
from kronecker import Cyclic,pairmul,quantize
ctx.prec=160
ctx.threads=1
data=json.loads((here/'counts.json').read_text())
res={}
def rounds(z,S):
    def coord(x):
        y=x*S
        n=(y+0.5).floor().unique_fmpz()
        assert n is not None and abs(y-n)<0.5
        return int(n)
    return coord(z.real),coord(z.imag)
for key,row in sorted(data['bins'].items(),key=lambda kv:int(kv[0])):
    n=row['max_length']; p=row['max_p']; cap=row['max_cap']
    S=1<<p
    rng=random.Random(n)
    xs=[(rng.randrange(-cap*S,cap*S),rng.randrange(-cap*S,cap*S)) for _ in range(n)]
    t=process_time()
    chirps=[rounds(acb.exp_pi_i(acb((j*j+(n*(j%2) if n%2 else 0))%(2*n))/n),S) for j in range(n)]
    ring=Cyclic(n,2*cap*S+2,S)
    kernel=ring.complex_pack([(x,-y) for x,y in chirps])
    setup=process_time()-t
    cpu=[]; wall=[]
    for _ in range(9 if n<1000 else 3):
        t=process_time();w=perf_counter()
        pre=[quantize(pairmul(z,r),S) for z,r in zip(xs,chirps)]
        a,b=ring.product(ring.complex_pack(pre),kernel,fmpz)
        out=[quantize(pairmul(c,r),S*S) for c,r in zip(zip(ring.unpack(a),ring.unpack(b)),chirps)]
        cpu.append(process_time()-t);wall.append(perf_counter()-w)
    for k in sorted({0,1,n//2,n-1}):
        u=v=0
        for j,z in enumerate(pre):
            x,y=chirps[(k-j)%n]
            a,b=pairmul(z,(x,-y))
            u+=a;v+=b
        assert quantize(pairmul((u,v),chirps[k]),S*S)==out[k]
    res[key]=dict(n=n,p=p,cap=cap,lane_bytes=ring.width,setup_cpu=setup,
                  cpu=cpu,wall=wall,median_wall=median(wall),rows=row['slices'],
                  guarded_base_warm_hours=row['slices']*median(wall)/3600)
    (here/'native-panel.json').write_text(json.dumps(res,indent=2))
    print(n,median(wall),res[key]['guarded_base_warm_hours'],flush=True)
