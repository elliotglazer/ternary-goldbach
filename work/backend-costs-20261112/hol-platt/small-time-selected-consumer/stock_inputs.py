from actual import *
import sys
sys.set_int_max_str_digits(0)
r=[]
for l in labels:
    gold=(old/f'heads-{l}.txt').read_text().splitlines()
    # Prespecified first partly occupied, interior main-region row after physical index 8192.
    ix=next(i for i in range(128,len(gold)) if 4<=int(gold[i].split()[0]).bit_count()<=24)
    m,w,e,h=gold[ix].split();m,w,e,h=int(m),int(w),int(e),int(h,16);start=ix*64
    values=[[],[],[],[],[]]
    for c in range(3):
        d,off=divmod(2*J+start,T);assert off+64<=T
        f=(p/f'c{l}-{c}-{d}.bin').read_bytes();values[c]=[(int.from_bytes(f[j*68:(j+1)*68],'little')-hb) for j in range(off,off+64)]
    for i in range(64):
        x,y=chirp(start+i-128);values[3].append(x);values[4].append(y)
    vals=[sum(v<<(i*(544 if c<3 else 243)) for i,v in enumerate(vs)) for c,vs in enumerate(values)]
    (p/f'term-{l}.txt').write_text(' '.join(map(str,[w,e,m,*vals,h,m.bit_count()]))+'\n')
    r.append([l,ix,m.bit_count(),w,e])
(p/'stock-cases.json').write_text(json.dumps(r))
