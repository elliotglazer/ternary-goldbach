from actual import *
import sys
sys.set_int_max_str_digits(0)
for label in labels:
    fields=list(map(int,(p/f'term-{label}.txt').read_text().split()));w,e,orig,*rest=fields
    a,b,c,x,y=rest[:5]
    def pop(z,width):B=1<<width;q=(z+B//2)//B;return z-B*q,q
    dig=[]
    for i in range(64):
        A,a=pop(a,544);B,b=pop(b,544);C,c=pop(c,544);u,x=pop(x,243);v,y=pop(y,243)
        h=project(A,B,C,(u,v))//(1<<e)+(1<<(w-1));assert 0<=h<(1<<w);dig.append(h)
    sel={int(s.split()[0]) for s in (p/f'selected-{label}.tsv').open()}
    for d in (2,3):
        base=d*T-2*J
        ix=[i for i in range(T) if base+i in sel];m=sum(1<<i for i in ix)
        bits=sum(dig[i%64]<<(j*w) for j,i in enumerate(ix))
        (p/f'mask-{label}-{d}.txt').write_text(f'{m:x} {bits:x} {len(ix)}\n')
