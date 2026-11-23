import hashlib, json, time
from pathlib import Path
from flint import arb, acb, ctx
ctx.prec=208
ctx.threads=1
base=Path(__file__).resolve().parent
P=126
S=1<<P
O=1<<105
B=1<<128
tile=64
def nearest(x,s):
    return int((x*s+arb(1)/2).floor().unique_fmpz())
def pair(z):
    return nearest(z.real,S),nearest(z.imag,S)
def prod(x,y,den):
    a,b=x
    c,d=y
    return ((a*c-b*d+den//2)//den,(a*d+b*c+den//2)//den)
def cls(x):
    return 1 if x < -1 else 2 if x>1 else 0
def packed(v):
    return sum((x+S)<<(128*i) for i,x in enumerate(v))
entries=[]
summary=[]
for q,n in ((10004,84881),(131071,6378)):
    t0=time.process_time()
    step=pair(acb(0,-5*arb(q).log()/128).exp())
    state=(S,0)
    digest=hashlib.sha256()
    samples=[]
    start_state=state
    ambiguous=0
    touched=0
    maxerr=arb(0)
    for j in range(n):
        t=arb(5*j)/64
        phases=[]; outs=[]; mask=0
        for a in (0,1):
            g=acb(arb(1)/4+arb(a)/2,t/2)
            ang=g.lgamma().imag
            dyn=pair(acb(0,ang-t*arb.pi().log()/2).exp())
            z=prod(state,dyn,(1<<(2*P-105)))
            true=acb(0,ang-t*(arb.pi()*q).log()/2).exp()
            err=abs(acb(*z)-true*O)
            assert err<1
            maxerr=max(maxerr,err.upper())
            for c in z:
                code=cls(c)
                ambiguous+=code==0
                mask|=code<<(2*len(outs))
                outs.append(c)
            phases.extend(dyn)
        digest.update(bytes([mask]))
        assert int(mask)<256
        samples.append((phases,mask))
        state=prod(state,step,S)
        if len(samples)==tile or j+1==n:
            start=j+1-len(samples)
            # Matched contiguous initial and final 256-tick panels at each conductor.
            if start<256 or start//64>=(n-1)//64-3:
                streams=[packed([x[0][i] for x in samples]) for i in range(4)]
                masks=sum(x[1]<<(8*i) for i,x in enumerate(samples))
                entries.append([q,start,len(samples),*step,*start_state,*state,*streams,masks])
                touched+=len(samples)
            samples=[];start_state=state
    summary.append(dict(q=q,n=n,sample_ticks=touched,ambiguous_coordinate_count=ambiguous,
                        max_grid_error=str(maxerr),mask_sha256=digest.hexdigest(),
                        cpu=time.process_time()-t0))
(base/'strips.txt').write_text(''.join(' '.join(map(str,row))+'\n' for row in entries))
(base/'native.json').write_text(json.dumps(summary,indent=2))
print(summary)
