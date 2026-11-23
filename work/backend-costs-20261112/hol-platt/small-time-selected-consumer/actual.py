from pathlib import Path
from flint import fmpz,arb,ctx
import json,time,hashlib
from functools import lru_cache
p=Path(__file__).resolve().parent;b=p.parent;src=b/'full-height-count';old=b/'sparse-head'
N=524288;J=68267;S=1<<240;W=544;T=65536;hb=1<<(W-1);labels=[3,6667,11,9091];ctx.prec=320;ctx.threads=1
def rnd(x,d):return (2*x+d)//(2*d)
def coord(x):
    a=(x*S+arb(1)/2).floor().unique_fmpz();assert a is not None;return int(a)
@lru_cache(None)
def root(k):
    k=k%(2*N)
    if k>N:
        x,y=root(k-N);return -x,-y
    if k>N//2:
        x,y=root(N-k);return -x,y
    if k>N//4:
        x,y=root(N//2-k);return y,x
    s,c=(arb(k)/(N)).sin_cos_pi();return coord(c),coord(s)
def chirp(j):return root(j*j)
@lru_cache(None)
def bias(n):return fmpz(hb)*((fmpz(1)<<(W*n))-1)//((1<<W)-1)
def pack(xs):return fmpz(int.from_bytes(b''.join((x+hb).to_bytes(W//8,'little') for x in xs),'little'))-bias(len(xs))
def decode(z,n):return int(z+bias(n)).to_bytes(n*(W//8),'little')
def chunks(a):return [pack(a[k:k+T]) for k in range(0,len(a),T)]
def cols(points):
    x,y=zip(*points);return [chunks(x),chunks(y),chunks([a+b for a,b in points])]
def grouped(a,b,lo,hi,keep_carries=None):
    sums={}
    for i,x in enumerate(a):
        for j,y in enumerate(b):
            d=i+j
            if d*T<=hi and (d+2)*T-2>=lo:sums[d]=sums.get(d,0)+x*y
    H=fmpz(1)<<(W*T);carry=0;tiles={}
    for d in range(min(sums),hi//T+1):
        z=sums.get(d,0)+carry;carry=(z+H//2)//H
        if d>=lo//T:
            tiles[d]=z-H*carry
            if keep_carries is not None:keep_carries[d]=carry
    return tiles
def readint(v,i):
    raw=int.from_bytes(v[i*68:(i+1)*68],'little');return raw-hb
def project(A,B,C,cs):
    x,y=cs; norm=rnd((A-B)*x-(C-A-B)*y,1<<(480+19))
    return norm//2
def one(label,i,kernel,coef,tot):
    rr=[int(x) for x in (src/f'grid-{label}.txt').read_text().splitlines()]
    hs=[s.split() for s in (old/f'heads-{label}.txt').read_text().splitlines()]
    sel={}
    for t,(m,w,e,h) in enumerate(hs):
        m,w,e,h=int(m),int(w),int(e),int(h,16);out=0
        for j in range(64):
            if (m>>j)&1:
                dig=(h>>(out*w))&((1<<w)-1);sel[64*t+j]=(w,e,dig-(1<<(w-1)));out+=1
    a=[]
    for k in range(-J,J+1):
        x,y=coef[abs(k)][2*i:2*i+2];y=-y if k<0 else y
        x,y=rnd(x,65536),rnd(y,65536)
        u,v=chirp(k);a.append((rnd(x*u-y*v,S),rnd(x*v+y*u,S)))
    aa=cols(a);lo=2*J;hi=lo+len(rr)-1
    start=time.process_time();carrymaps=[{} for _ in range(3)];alltiles=[grouped(x,y,lo,hi,carrymaps[c]) for c,(x,y) in enumerate(zip(aa,kernel))];prod=time.process_time()-start
    full=[{d:decode(z,T) for d,z in q.items()} for q in alltiles]
    for c,dd in enumerate(carrymaps):
        for d,h in dd.items():
            v=int(h);(p/f'c{label}-{c}-{d}.carry').write_bytes(v.to_bytes((v.bit_length()+8)//8,'little',signed=True))
    # Preserve the exact grouped low tiles as byte-aligned biased fields.
    for c,dd in enumerate(full):
        for d,v in dd.items():(p/f'c{label}-{c}-{d}.bin').write_bytes(v)
    mx=0;bad=[];entries=[]
    for j,wit in sel.items():
        d,t=divmod(lo+j,T);abc=[readint(q[d],t) for q in full];u,v=chirp(j-128)
        raw=project(*abc,(u,v));w,e,q=wit;mx=max(mx,abs(raw-rr[j]))
        if raw//(1<<e)!=q:bad.append((j,raw//(1<<e),q))
        entries.append([j,*abc,u,v,w,e,q])
    assert not bad,(label,bad[:4],mx)
    with (p/f'selected-{label}.tsv').open('w') as f:
        for row in entries:f.write(' '.join(map(str,row))+'\n')
    tot.append(dict(label=label,length=len(rr),retained=len(sel),max_raw_difference=mx,product_cpu=prod,first_diag=lo//T,last_diag=hi//T));print(tot[-1],flush=True)
if __name__=='__main__':
    coef=[list(map(int,x.split()))[1:] for x in (src/'coefficients.tsv').read_text().splitlines()];assert len(coef)==J+1
    length=len((src/'grid-3.txt').read_text().splitlines());bmin=-128-J
    kernel=cols([(x,-y) for x,y in map(chirp,range(bmin,bmin+length+2*J))])
    res=[]
    for i,l in enumerate(labels):
        one(l,i,kernel,coef,res);(p/'actual.json').write_text(json.dumps(res,indent=2))

