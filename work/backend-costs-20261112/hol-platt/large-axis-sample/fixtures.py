"""Generate diagnostic inputs and reference answers for each presampled Fourier slice."""
import hashlib
import json
import sys
from pathlib import Path
from flint import acb,ctx,fmpz

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
sys.path.insert(0,str(HOL/"c10000-kronecker"))
from kronecker import Cyclic,pairmul,quantize

ctx.prec=256
ctx.threads=1


def nearest(z,S):
    out=[]
    for x in (z.real,z.imag):
        v=(x*S+0.5).floor().unique_fmpz()
        assert v is not None and abs(x*S-v)<0.5
        out.append(int(v))
    return tuple(out)


def make(key):
    n,p,cap,w=key
    S=1<<p
    H=S<<64
    rat=nearest(acb.exp_pi_i(acb(1)/n),H)
    seed=rat
    step=nearest(acb.exp_pi_i(acb(2)/n),H)
    z=(H,0)
    ws=[]
    for j in range(n):
        center=quantize(z,1<<64)
        truth=acb.exp_pi_i(acb((j*j)%(2*n))/n)
        # Complex discrepancy strictly below a p-grid unit is the contract.
        dx=truth.real*S-center[0]
        dy=truth.imag*S-center[1]
        assert dx*dx+dy*dy<1
        ws.append(center)
        z=quantize(pairmul(z,rat),H)
        rat=quantize(pairmul(rat,step),H)
    ring=Cyclic(n,2*cap*S+2,S)
    assert ring.width==w
    ker=ring.complex_pack([(x,-y) for x,y in ws])
    a,b=1276261,1534179
    xs=[]
    for i in range(n):
        a=(6364136223846793005*a+1442695040888963407)%(2*cap*S)
        b=(1442695040888963407*b+6364136223846793005)%(2*cap*S)
        xs.append((a-cap*S,b-cap*S))
    pre=[quantize(pairmul(x,c),S) for x,c in zip(xs,ws)]
    real,imag=ring.product(ring.complex_pack(pre),ker,fmpz)
    ys=[quantize(pairmul(x,c),S*S) for x,c in zip(zip(ring.unpack(real),ring.unpack(imag)),ws)]
    selection=[]
    for k in (0,1,n//2,n-1):
        rx=ry=0
        for j,x in enumerate(pre):
            u,v=ws[(k-j)%n]
            dx,dy=pairmul(x,(u,-v))
            rx+=dx
            ry+=dy
        assert ys[k]==quantize(pairmul((rx,ry),ws[k]),S*S)
        selection.extend(ys[k])
    checksum=sum(x+3*y for x,y in ys)%65537
    control=(sum(ker)+2*n)%65537
    return [n,p,cap,w,(n-1).bit_length(),*seed,*step,control,checksum,*selection]


def main():
    plan=json.loads((HERE/"sample.json").read_bytes())
    names=["small","medium","long","tail"]
    bounds=[(5,10),(11,13),(14,16),(17,18)]
    for group,(lo,hi) in zip(names,bounds):
        path=HERE/(group+".txt")
        # Write by stratum so completed small/medium receipts are available while
        # high-precision checks on the long lengths run.
        with path.open("w",encoding="ascii",newline="\n") as out:
            keys=list(dict.fromkeys(tuple(k) for b in range(lo,hi+1) for k in plan["strata"][str(b)]["draws"]))
            for key in keys:
                print(*make(key),file=out,flush=True)
        print(group,len(keys),hashlib.sha256(path.read_bytes()).hexdigest(),flush=True)


if __name__=="__main__":
    main()
