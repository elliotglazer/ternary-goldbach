from actual import *
def hx(v):return ('-' if v<0 else '')+format(abs(int(v)),'x')
for label in labels:
    rows=(old/f'heads-{label}.txt').read_text().splitlines()
    for row in (0,128,512,1024):
        j=row*64;d,k=divmod(j+2*J,T)
        assert k+64<=T
        b=[(p/f'c{label}-{s}-{d}.bin').read_bytes() for s in range(3)]
        # Real upper-carry field slice in the very same tile and positions.
        bh=[decode(fmpz(int.from_bytes((p/f'c{label}-{s}-{d}.carry').read_bytes(),'little',signed=True)),T) for s in range(3)]
        lo=[int(pack([readint(t,i) for i in range(k,k+64)])) for t in b]
        hi=[int(pack([readint(t,i) for i in range(k,k+64)])) for t in bh]
        roots=[chirp(i-128) for i in range(j,j+64)]
        x,y=[sum((v+(1<<242))<<(243*i) for i,v in enumerate(c)) for c in zip(*roots)]
        m,w,e,h=rows[row].split();m,w,e,h=int(m),int(w),int(e),int(h,16)
        assert w>0 or m==0
        arr=[w,e,m,*lo,*hi,x,y,h,m.bit_count()]
        (p/f'g-{label}-{row}.hex').write_text(' '.join(map(hx,arr)))
