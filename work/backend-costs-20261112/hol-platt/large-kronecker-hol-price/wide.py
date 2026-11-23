from collections import Counter
from pathlib import Path
import csv,gzip,json,sys,time,statistics
from flint import ctx,acb,fmpz
here=Path(__file__).resolve().parent
base=here.parent/"large-kronecker-price"
sys.path.insert(0,str(here.parent/"c10000-kronecker"))
from kronecker import Cyclic,pairmul,quantize
rows=Counter()
with gzip.open(base/"axis-histogram.csv.gz","rt") as f:
    for r in csv.DictReader(f):
        key=tuple(int(r[j]) for j in ("n","p","input_coordinate_cap","lane_bytes"))
        if key[0]>=32:rows[key]+=int(r["base_plus_41_slices"])
top=rows.most_common()
chosen=[k for k,v in top[:24]]
for n in [32,36,40,42,46,52,58,60,64,96,256,512,2048,8192]:
    chosen.append(next(k for k,v in top if k[0]==n))
chosen.append(next(k for k,v in top if k[1]==80))
lengths={p:min(k[0] for k,v in top if k[1]==p) for p in range(98,106)}
chosen=[next(k for k,v in top if k[0]==lengths[p] and k[1]==p) for p in range(98,106)]
ctx.prec=256;ctx.threads=1
def q(z,S):
    vals=[]
    for t in [z.real,z.imag]:
        v=(t*S+0.5).floor().unique_fmpz()
        assert v is not None and abs(t*S-v)<0.5
        vals.append(int(v))
    return tuple(vals)
out=[]
for n,p,cap,w in chosen:
    S=1<<p; H=S<<64; bound=cap*S; D=n.bit_length() if n&(n-1) else n.bit_length()-1
    root=q(acb.exp_pi_i(acb(1)/n),H)
    step=q(acb.exp_pi_i(acb(2)/n),H)
    ws=[];rat=root;z=(H,0)
    for i in range(n):
        wq=quantize(z,1<<64)
        true=q(acb.exp_pi_i(acb((i*i)%(2*n))/n),S)
        assert wq==true
        ws.append(wq)
        z=quantize(pairmul(z,rat),H)
        rat=quantize(pairmul(rat,step),H)
    a,b=1276261,1534179;xs=[]
    for i in range(n):
        a=(6364136223846793005*a+1442695040888963407)%(2*bound)
        b=(1442695040888963407*b+6364136223846793005)%(2*bound)
        xs.append((a-bound,b-bound))
    ring=Cyclic(n,2*cap*S+2,S);assert ring.width==w
    ker=ring.complex_pack([(x,-y) for x,y in ws])
    def run():
        pre=[quantize(pairmul(x,c),S) for x,c in zip(xs,ws)]
        real,imag=ring.product(ring.complex_pack(pre),ker,fmpz)
        ys=[quantize(pairmul(z,c),S*S) for z,c in zip(zip(ring.unpack(real),ring.unpack(imag)),ws)]
        return pre,ys
    ts=[]
    for _ in range(3):
        t=time.perf_counter();pre,ys=run();ts.append(time.perf_counter()-t)
    for k in (0,1,n//2,n-1):
        pp=[pairmul(z,(ws[(k-j)%n][0],-ws[(k-j)%n][1])) for j,z in enumerate(pre)]
        assert ys[k]==quantize(pairmul(tuple(map(sum,zip(*pp))),ws[k]),S*S)
    # HOL observes all coordinate pairs by summing exact integers modulo 65537 once.
    check=sum(x+3*y for x,y in ys)%65537
    x,y=ker
    control=(x+y+len(ws)+len(xs))%65537
    out.append(dict(n=n,p=p,cap=cap,lane_bytes=w,depth=D,root=root,step=step,
        selected=[ys[k] for k in (0,1,n//2,n-1)],checksum=check,control=control,
        matched_slices=rows[n,p,cap,w],native_warm_wall=statistics.median(ts)))
with (here/"wide.txt").open("w") as f:
    for r in out:
        vals=[r[k] for k in ("n","p","cap","lane_bytes","depth")]+[*r["root"],*r["step"],r["control"],r["checksum"]]+[v for z in r["selected"] for v in z]
        f.write(" ".join(map(str,vals))+"\n")
(here/"wide.json").write_text(json.dumps(out,indent=2))
print(len(out),sum(x["matched_slices"] for x in out))


