from actual import *
def hx(n):return ('-' if n<0 else '')+format(abs(int(n)),'x')
for label in labels:
    source=(old/f'heads-{label}.txt').read_text().splitlines()
    for k in (0,2,4):
        start=128;count=64<<k;j=start*64;d,i=divmod(j+2*J,T)
        assert i+count<=T
        vals=[]
        for high in (False,True):
            for s in range(3):
                if high:buf=decode(fmpz(int.from_bytes((p/f'c{label}-{s}-{d}.carry').read_bytes(),'little',signed=True)),T)
                else:buf=(p/f'c{label}-{s}-{d}.bin').read_bytes()
                vals.append(int.from_bytes(buf[68*i:68*(i+count)],'little')-int(bias(count)))
        lines=[' '.join(map(hx,vals))]
        for row in range(start,start+(1<<k)):
            m,w,e,h=source[row].split();m,w,e,h=int(m),int(w),int(e),int(h,16)
            roots=[chirp(v-128) for v in range(64*row,64*row+64)]
            x,y=[sum((v+(1<<242))<<(243*i) for i,v in enumerate(c)) for c in zip(*roots)]
            lines.append(' '.join(map(hx,(w,e,m,x,y,h,m.bit_count()))))
        (p/f'b-{label}-{k}.hex').write_text('\n'.join(lines)+'\n')
