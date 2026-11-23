import json
import time
from pathlib import Path
from flint import arb, acb, ctx
ctx.prec=176
ctx.threads=1
out=[]
for first in (0, 84000):
    t0=time.process_time()
    maxrad=arb(0)
    for j in range(first, first+512):
        t=arb(5)*j/64
        for a in (0,1):
            g=acb(arb(1)/4+arb(a)/2,t/2)
            ang=g.lgamma().imag-t*arb.pi().log()/2
            z=acb(0,ang).exp()
            rad=max(z.real.rad(),z.imag.rad(),maxrad)
            maxrad=rad
            assert rad < arb(2)**(-145)
    out.append(dict(first=first,points=1024,cpu=time.process_time()-t0,
                    max_coord_radius=str(maxrad)))
Path(__file__).with_name('gamma-panel.json').write_text(json.dumps(out,indent=2))
print(out)
