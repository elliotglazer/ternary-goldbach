from pathlib import Path
from flint import acb, arb, ctx
ctx.prec=200
ctx.threads=1
here=Path(__file__).resolve().parent
lines=[]
for start in (1,84000):
    for j in range(start,start+512):
        for a in (0,1):
            t=arb(5*j)/64
            g=acb(arb(1)/4+arb(a)/2,t/2)
            z=acb(0,g.lgamma().imag-t*arb.pi().log()/2).exp()
            for coord in (z.real,z.imag):
                v=coord+2
                lower=int((v.lower()*2**150).floor().unique_fmpz())
                upper=int((v.upper()*2**150).ceil().unique_fmpz())
                center=int((v*2**105+arb(1)/2).floor().unique_fmpz())
                assert 2*lower>(2*center-1)*2**45 and 2*upper<(2*center+1)*2**45
                lines.append(f'{lower} {upper} {center}')
(here/'gamma-rectangles.txt').write_text('\n'.join(lines)+'\n')
