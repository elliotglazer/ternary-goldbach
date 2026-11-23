from actual import *
def hx(n):return ('-' if n<0 else '')+format(abs(int(n)),'x')
for label in labels:
   seed=(p/f'b-{label}-0.hex').read_text().splitlines()
   vals=[int(v,16) for v in seed[0].split()]
   w,e,_,X,Y,_,_=[int(v,16) for v in seed[1].split()]
   raw=[decode(fmpz(v),64) for v in vals[:3]]
   roots=[chirp(i-128) for i in range(128*64,129*64)]
   for k in (0,2,4):
      genuine=(p/f'b-{label}-{k}.hex').read_text().splitlines()
      n=1<<k;rep=((1<<(544*64*n))-1)//((1<<(544*64))-1)
      out=[' '.join(hx(v*rep) for v in vals)]
      for line in genuine[1:]:
         _,_,m,_,_,_,cnt=[int(v,16) for v in line.split()]
         digits=[]
         for i in range(64):
            if (m>>i)&1:
               q=project(*(readint(t,i) for t in raw),roots[i])//(1<<e)
               dig=q+(1<<(w-1))
               # The reference row's exponent is shared across its positions; inactive lanes can exceed its width.
               digits.append(dig)
         expected=sum(v<<(j*w) for j,v in enumerate(digits))
         assert expected>=0
         out.append(' '.join(map(hx,(w,e,m,X,Y,expected,cnt))))
      (p/f'b-p{label}-{k}.hex').write_text('\n'.join(out)+'\n')
