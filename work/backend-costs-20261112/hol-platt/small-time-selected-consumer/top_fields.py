from actual import *
from collections import Counter
def mul(ab,cd):
    a,b=ab;c,d=cd;v=(a*c,a*d,b*c,b*d);return min(v),max(v)
def approx(buf,j,w,e,u,v,extra,drop):
    # Discard bytes of each 544-bit signed field; recover its exact outward integer interval.
    t=max(0,min(536,((e+260-extra)//8)*8));h=t//8;ij=j*68
    def interval(b):
        q=int.from_bytes(b[ij+h:ij+68],'little')-(1<<(543-t));return q,q+1
    A,B,C=map(interval,buf)
    # Keep 56 postchirp fractional bits, outward-rounded from the original 240-bit roots.
    dx,dy=u>>drop,v>>drop
    # Recombine with u+v, v-u, -v; errors conservatively enclose independent endpoints.
    terms=[mul(A,(dx+dy,dx+dy+2)),mul(B,(dy-dx-1,dy-dx+1)),mul(C,(-dy-1,-dy))]
    shift=499-t-drop
    def head(z):return (rnd(z,1<<shift) if shift>=0 else z<<(-shift))//(1<<(e+1))
    return head(sum(z[0] for z in terms)),head(sum(z[1] for z in terms)),68-h
out=[]
for l in labels:
    buf={d:[(p/f'c{l}-{k}-{d}.bin').read_bytes() for k in range(3)] for d in [2,3]}
    rows=[list(map(int,x.split())) for x in (p/f'selected-{l}.tsv').open()]
    for extra,drop in ((12,184),(20,184),(32,184),(40,184),(20,144),(20,112),(20,80),(20,32),(32,112),(32,80)):
        strict=0;byt=Counter();start=time.process_time()
        for j,A,B,C,u,v,w,e,q in rows:
            d,i=divmod(j+2*J,T);a,b,n=approx(buf[d],i,w,e,u,v,extra,drop)
            assert a<=q<=b
            if a==b:strict+=1
            else:assert project(A,B,C,(u,v))//(1<<e)==q
            byt[n]+=1
        out.append(dict(label=l,extra=extra,chirp_fraction_bits=240-drop,tight=strict,total=len(rows),fallback=len(rows)-strict,bytes_per_field=byt,cpu=time.process_time()-start))
    print(l,out[-1],flush=True)
(p/'top-fields.json').write_text(json.dumps(out,indent=2))

