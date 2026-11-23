"""Independent integer FFT reference for workload draws and the saved q=10000 Gauss input."""
from hashlib import sha256
import json
from pathlib import Path
from flint import acb,ctx

HERE=Path(__file__).resolve().parent
PRIME=(1<<61)-1


def multiply(a,b,s):
    x,y=a
    u,v=b
    return ((x*u-y*v+s//2)//s,(x*v+y*u+s//2)//s)


def roots(numerator,denominator,count,p):
    s=1<<p
    fine=s<<72
    def quant(angle,scale):
        root=acb.exp_pi_i(acb(2*angle)/denominator)
        result=[(x*scale+0.5).floor().unique_fmpz() for x in (root.real,root.imag)]
        assert all(x is not None for x in result)
        return tuple(int(x) for x in result)
    step=quant(numerator,fine)
    z=(fine,0)
    values=[]
    for j in range(count):
        a=tuple((k+(1<<71))>>72 for k in z)
        assert a==quant((j*numerator)%denominator,s)
        values.append(a)
        z=multiply(z,step,fine)
    return step,values


def inputs(n,fill,cap,a,b):
    xs=[]
    for i in range(fill):
        a=(6364136223846793005*a+1442695040888963407)%(2*cap)
        b=(1442695040888963407*b+6364136223846793005)%(2*cap)
        xs.append((a-cap,b-cap))
    return xs+[(0,0)]*(n-fill)


def fft(xs,ws,s):
    n=len(xs)
    d=(n-1).bit_length()
    out=[xs[int(format(j,f"0{d}b")[::-1],2)] for j in range(n)]
    for level in range(1,d+1):
        m=1<<level
        for base in range(0,n,m):
            for i in range(m//2):
                a,b=out[base+i]
                c,e=multiply(out[base+i+m//2],ws[i*(n//m)],s)
                out[base+i]=(a+c,b+e)
                out[base+i+m//2]=(a-c,b-e)
    return out


def digest(zs):
    a=b=0
    for x,y in zs:
        a=(1000003*a+x)%PRIME
        b=(1000033*b+y)%PRIME
    return a,b


def panels():
    plan=json.loads((HERE/"plan.json").read_bytes())
    records=[]
    lines=[]
    for name,st in plan["strata"].items():
        mode=1 if name=="point" else 2 if name=="add" else 0
        for draw,(d,p,e,fill,sign) in enumerate(st["draws"]):
            n=1<<d
            s=1<<p
            step,ws=roots(sign,n if not mode else 257,n//2 if not mode else n,p)
            def apply(a,b):
                xs=inputs(n,fill,s<<e,a,b)
                if not mode:
                    return fft(xs,ws,s)
                if mode==1:
                    return [multiply(x,y,s) for x,y in zip(xs,ws,strict=True)]
                return [(x+u,y+v) for (x,y),(u,v) in zip(xs,ws,strict=True)]
            x=apply(1276261,1534179)
            u=apply(7191061,7129357)
            rep=max(2,min(8192,12000//max(1,n*d//2 if not mode else n)))
            ix=len(records)
            values=[ix,mode,d,p,e,fill,*step,*digest(x),*digest(u),rep]
            lines.append(" ".join(map(str,values)))
            records.append(dict(id=ix,mode=mode,stratum=name,draw=draw,d=d,p=p,e=e,fill=fill,sign=sign,reps=rep))
    (HERE/"panels.txt").write_text("\n".join(lines)+"\n",newline="\n")
    (HERE/"panels.json").write_text(json.dumps(records,indent=2)+"\n")
    print(len(records),"workload draws")


def actual():
    src=HERE.parent/"c10000-bluestein-hol"
    input_files=["inputs","chirps","kernel","roots","expected"]
    def read(name):
        return [tuple(map(int,line.split())) for line in (src/(name+".tsv")).read_text().splitlines()]
    xs,ws,ker,positive,expected=map(read,input_files)
    negative=[(a,-b) for a,b in positive]
    s=1<<307
    pre=[multiply(x,w,s) for x,w in zip(xs,ws,strict=True)]
    padded=pre+[(0,0)]*524
    forward=fft(padded,positive,s)
    product=[multiply(x,w,s) for x,w in zip(forward,ker,strict=True)]
    inverse=fft(product,negative,s)
    post=[multiply(x,w,s) for x,w in zip(inverse[:500],ws,strict=True)]
    assert post==expected
    stages=[("pre",1,xs,ws,pre),("forward",0,padded,positive,forward),
            ("pointwise",1,forward,ker,product),("inverse",0,product,negative,inverse),
            ("post",1,inverse[:500],ws,post)]
    def flat(zs):
        return " ".join(str(k) for pair in zs for k in pair)
    with (HERE/"actual.txt").open("w",newline="\n") as fout:
        for label,mode,inp,rot,out in stages:
            print(label,mode,len(inp),file=fout)
            for vec in (inp,rot,out):
                print(flat(vec),file=fout)
    paths=[src/(n+".tsv") for n in input_files]
    (HERE/"actual.json").write_text(json.dumps(dict(conductor=10000,p=307,
        compared_coordinates=sum(2*len(y) for _,_,_,_,y in stages),
        source_hashes={p.name:sha256(p.read_bytes()).hexdigest() for p in paths}),indent=2)+"\n")


if __name__=="__main__":
    ctx.prec,ctx.threads=600,1
    panels()
    actual()
