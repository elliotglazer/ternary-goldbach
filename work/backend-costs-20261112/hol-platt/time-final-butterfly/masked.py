from pathlib import Path
from collections import Counter
import json
here=Path(__file__).resolve().parent
labels=(3,6667,11,9091)
tiles=[2,512,1026,1318]
masks=[[int(l.split()[0]) for l in (here.parent/f'sparse-count/raw-{label}.txt').read_text().splitlines()] for label in labels]
assert all(len(ms)==1331 for ms in masks)
all_hist=Counter( sum((masks[j][i//64]>>(i%64)&1)<<j for j in range(4)).bit_count() for i in range(85121))
orig=[int(l,16) for l in (here/'batch.hex').read_text().splitlines()]
def extract(z,k,w):return (z>>k)% (1<<w)
def signed(z,k,w):return extract(z,k,w)-(1<<(w-1))
def shorten(x,p):
    return x if p==256 else (x+(1<<(255-p)))>>(256-p)
out=[]
summary=[]
for tile_ord,tile in enumerate(tiles):
    exword=orig[65*tile_ord]
    vals=[]
    for offset in range(64):
        mask=sum(((ms[tile]>>offset)&1)<<j for j,ms in enumerate(masks))
        if not mask:continue
        z=orig[65*tile_ord+1+offset]
        wr,wi=signed(z,0,258),signed(z,258,258)
        lanes=[]
        for j in range(4):
            if mask>>j&1:
                x=z>>(516+873*j)
                lanes.append((j,signed(x,0,280),signed(x,280,280),signed(x,560,280),signed(x,840,32),1+extract(x,872,1)))
        vals.append((mask,wr,wi,lanes))
    for p in range(24,257,8):
        S=1<<p
        safe=True
        flat=[]
        for mask,wr0,wi0,lanes in vals:
            wr,wi=shorten(wr0,p),shorten(wi0,p)
            for j,a0,b0,c0,q,s in lanes:
                a,b,c=(shorten(v,p) for v in (a0,b0,c0))
                flat.extend((a,b,c))
                e=extract(exword,8*j,8)
                z=a*S+wr*b-wi*c
                err=S+abs(wr)+abs(wi)+abs(b)+abs(c)+2
                den=(1<<e)*S*S
                safe &= q*den <= (z-err)<<220 and (z+err)<<220 < (q+1)*den
        if safe:break
    assert safe
    w=max((abs(v).bit_length()+1 for v in flat),default=2)
    R=1<<(p+2); B=1<<w; H=1<<32
    n=len(vals)
    head=n+(p<<8)+(w<<17)+(exword<<26)
    out.append(format(head,'x'))
    for mask,wr0,wi0,lanes in vals:
        wr,wi=shorten(wr0,p),shorten(wi0,p)
        rt=(wr+R//2)+(wi+R//2)*R
        y=0
        for j,a0,b0,c0,q,s in reversed(lanes):
            a,b,c=(shorten(v,p) for v in (a0,b0,c0))
            assert -H//2<=q<H//2 and s in (1,2)
            lane=(a+B//2)+(b+B//2)*B+(c+B//2)*B**2+(q+H//2)*B**3+(s-1)*H*B**3
            assert 0<=lane<2*H*B**3
            y=lane+2*H*B**3*y
        out.append(format(mask+16*(rt+R**2*y),'x'))
    summary.append(dict(tile=tile,ticks=n,decisions=sum(len(x[3]) for x in vals),p=p,width=w))
(here/'masked.hex').write_bytes(('\n'.join(out)+'\n').encode())
print(json.dumps(dict(ticks=85121,global_counts=[sum(m.bit_count() for m in a) for a in masks],
    overlap_by_number_of_labels=all_hist,union=85121-all_hist[0],pilot=summary,
    active_tile_label_pairs=sum(m!=0 for a in masks for m in a), bytes=(here/'masked.hex').stat().st_size),indent=2))
