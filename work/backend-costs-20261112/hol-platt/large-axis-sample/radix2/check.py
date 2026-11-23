"""Check a radix-two outer split and both signed periodic chirps against the actual DFT."""
import hashlib
import json
import sys
from pathlib import Path
from statistics import median
from time import perf_counter
from flint import acb,arb,ctx,fmpz

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent))
from fixtures import nearest,Cyclic,pairmul,quantize

ctx.prec=256
ctx.threads=1


def trial(key):
    n,p,cap,w=key
    assert n%2==0
    m=n//2
    S=1<<p
    fine=2*S
    H=fine<<64
    chirp_seed=nearest(acb.exp_pi_i(acb(1)/m),H)
    if m%2: chirp_seed=tuple(-u for u in chirp_seed)
    chirp_step=nearest(acb.exp_pi_i(acb(2)/m),H)
    twiddle_step=nearest(acb.exp_pi_i(acb(2)/n),H)
    rat=chirp_seed
    z=tw=(H,0)
    ws=[]
    twiddles=[]
    for j in range(m):
        wj=quantize(z,1<<64)
        tj=quantize(tw,1<<64)
        for observed,true in ((wj,(-1 if m%2 and j%2 else 1)*acb.exp_pi_i(acb((j*j)%(2*m))/m)),
                              (tj,acb.exp_pi_i(acb(2*j)/n))):
            dx=true.real*fine-observed[0]
            dy=true.imag*fine-observed[1]
            assert dx*dx+dy*dy<1
        ws.append(wj)
        twiddles.append(tj)
        z=quantize(pairmul(z,rat),H)
        rat=quantize(pairmul(rat,chirp_step),H)
        tw=quantize(pairmul(tw,twiddle_step),H)
    a,b=1276261,1534179
    xs=[]
    for j in range(n):
        a=(6364136223846793005*a+1442695040888963407)%(2*cap*S)
        b=(1442695040888963407*b+6364136223846793005)%(2*cap*S)
        xs.append((2*(a-cap*S),2*(b-cap*S)))
    ring=Cyclic(m,2*(4*cap+2)*fine+2,fine)
    ker=ring.complex_pack([(x,-y) for x,y in ws])
    def transform(input_rows):
        pre=[quantize(pairmul(x,c),fine) for x,c in zip(input_rows,ws,strict=True)]
        r,i=ring.product(ring.complex_pack(pre),ker,fmpz)
        return [quantize(pairmul(x,c),fine*fine) for x,c in zip(zip(ring.unpack(r),ring.unpack(i)),ws,strict=True)]
    def run():
        even=[]
        odd=[]
        for j in range(m):
            x,y=xs[j],xs[j+m]
            even.append((x[0]+y[0],x[1]+y[1]))
            odd.append(quantize(pairmul((x[0]-y[0],x[1]-y[1]),twiddles[j]),fine))
        return [q for pair in zip(transform(even),transform(odd),strict=True) for q in pair]
    times=[]
    for _ in range(3):
        t=perf_counter()
        ys=run()
        times.append(perf_counter()-t)
    # The bound for the whole unnormalized output at the FINE grid is
    # 6*n*(M+1). M=2*cap bounds the Euclidean norm of every initial center.
    checked=[]
    for k in (0,1,n//2,n-1):
        step=acb.exp_pi_i(acb(2*k)/n)
        unit=acb(1)
        truth=acb(0)
        for x,y in xs:
            truth+=unit*acb(x,y)
            unit*=step
        err=abs(truth-acb(*ys[k]))
        assert err < 6*n*(2*cap+1)
        checked.append(float(err.upper()))
    result=dict(n=n,inner=m,odd_inner=bool(m%2),p=p,inner_p=p+1,cap=cap,inner_lane_bytes=ring.width,
                chirp_seed=chirp_seed,chirp_step=chirp_step,twiddle_step=twiddle_step,
                control=(sum(ker)+n+2*m)%65537,expected=[ys[k] for k in (0,1,n//2,n-1)],
                checked_mode_grid_errors=checked,allowed_grid_error=6*n*(2*cap+1),
                dense_native_warm_seconds=median(times),digest=sum(x+3*y for x,y in ys)%65537)
    return result


if __name__=="__main__":
    keyrows=[tuple(map(int,line.split()[:4])) for line in (HERE.parent/"fast/panel.txt").read_text().splitlines()]
    rows=[trial(k) for k in keyrows]
    result=dict(rows=rows,input_sha256=hashlib.sha256((HERE.parent/"fast/panel.txt").read_bytes()).hexdigest())
    (HERE/"checks.json").write_text(json.dumps(result,indent=2)+"\n")
    with (HERE/"panel.txt").open("w",encoding="ascii",newline="\n") as f:
        for r in rows:
            print(r['n'],r['p'],r['cap'],r['inner_lane_bytes'],(r['inner']-1).bit_length(),*r['chirp_seed'],
                  *r['chirp_step'],*r['twiddle_step'],r['control'],r['digest'],*(x for z in r['expected'] for x in z),file=f)
    print([(r["n"],r["inner"],r["dense_native_warm_seconds"]) for r in rows])
