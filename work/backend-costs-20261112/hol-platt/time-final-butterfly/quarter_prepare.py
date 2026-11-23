"""Derive quarter-transform certificates for four actual checked final-stage tiles."""
from pathlib import Path
from flint import acb,arb,ctx
from time import perf_counter,process_time
import json,hashlib
here=Path(__file__).resolve().parent
data=here.parent/'full-height-count'
sparse=here.parent/'sparse-count'
labels=[3,6667,11,9091]
tiles=[2,512,1026,1318]
N=524288
Q=N//4
ctx.prec=420
ctx.threads=1
src=data/'coefficients.tsv'
assert hashlib.sha256(src.read_bytes()).hexdigest()==json.loads((data/'spectrum.json').read_bytes())['sha256']['coefficients.tsv']
masks=[[int(l.split()[0]) for l in (sparse/f'raw-{h}.txt').read_text().splitlines()] for h in labels]
with (here/'full-operands.hex').open() as f:
    packets={i:l.split() for i,l in enumerate(f) if i in tiles}
P=304
def scaled(z):
    x=int((z.mid()*(1<<P)+arb(1)/2).floor().unique_fmpz())
    assert abs(z*(1<<P)-x)<1
    return x
def quant(x,t):return (x+(1<<(P-t-1)))>>(P-t)
def enc(x,b):
    assert -(1<<(b-1))<=x<(1<<(b-1))
    return x+(1<<(b-1))
def dec(x,b):return x%(1<<b)-(1<<(b-1))
def rnd(x,T):return (x+T//2)//T
start,cpu=perf_counter(),process_time()
quarter=[]
for col in range(4):
    cells={64*i+j:[None]*4 for i in tiles for j in range(64) if (masks[col][i]>>j)&1}
    for parity in range(4):
        arr=[acb(0)]*Q
        with src.open() as f:
            for j,l in enumerate(f):
                fields=l.split()
                a=acb(arb((int(fields[1+2*col]),-256)),arb((int(fields[2+2*col]),-256)))
                if (-j)%4==parity:arr[((-j)%N)//4]=a
                if j and j%4==parity:arr[j//4]=a.conjugate()
        out=acb.dft(arr);del arr
        for pos,vs in cells.items():
            z=out[(pos-128)%Q]
            vs[parity]=tuple(map(scaled,(z.real,z.imag))) if parity else (scaled(z.real),)
        del out
    quarter.append(cells)
tot=0
with (here/'quarter.hex').open('w',newline='\n') as f:
    for tile in tiles:
        _,p,w,count,*values=packets[tile];p,w,count=map(int,(p,w,count))
        S=1<<p; t=p+32;T=1<<t
        records=[]; biggest=0
        for value in values:
            z=int(value,16);pos=z%131072;r=z>>17
            wr=dec(r,p+2);wi=dec(r>>(p+2),p+2);old=r>>(2*p+4)
            W=acb.exp_pi_i(acb(-2*(pos-128))/N)
            ur,ui=tuple(quant(scaled(a),t) for a in (W.real,W.imag))
            assert max(abs(ur),abs(ui))<=T
            for a,b in [(ur,wr),(ui,wi)]:assert (b-1)*T<=(a-1)*S and (a+1)*S<=(b+1)*T
            vr,vi=rnd(ur*ur-ui*ui,T),rnd(2*ur*ui,T)
            lanes=[]
            for col in range(4):
                if pos not in quarter[col]:continue
                half=[dec(old>>(j*w),w) for j in range(3)]
                old >>= 3*w
                c0,c1,c2,c3=[[quant(x,t) for x in pair] for pair in quarter[col][pos]]
                fields=[c0[0],*c1,*c2,*c3]
                biggest=max(biggest,max(abs(x) for x in fields));lanes.append(fields)
                for target,(a,b,c,imag) in zip(half,[(c0[0],*c2,False),(c1[0],*c3,False),(c1[1],*c3,True)]):
                    center=a*T+(vr*c+vi*b if imag else vr*b-vi*c)
                    err=T+abs(vr)+abs(vi)+6*(abs(b)+abs(c))+12
                    assert (target-1)*T*T <= (center-err)*S and (center+err)*S <= (target+1)*T*T
                tot+=1
            assert old==0
            records.append((pos,ur,ui,lanes))
        width=biggest.bit_length()+1
        tokens=[str(tile),str(t),str(width),str(count)]
        for pos,ur,ui,lanes in records:
            bits=0
            for fields in reversed(lanes):
                for x in reversed(fields):bits=(bits<<width)+enc(x,width)
            root=enc(ur,t+2)+(enc(ui,t+2)<<(t+2))
            tokens.append(format(pos+((root+(bits<<(2*t+4)))<<17),'x'))
        f.write(' '.join(tokens)+'\n')
print(json.dumps(dict(labels=labels,tiles=tiles,outputs=tot,quarter_payload=(here/'quarter.hex').stat().st_size,
  native_wall=perf_counter()-start,native_cpu=process_time()-cpu)))
