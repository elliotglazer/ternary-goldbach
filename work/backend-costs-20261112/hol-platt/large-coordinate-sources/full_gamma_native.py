from pathlib import Path
import hashlib, json, time
from flint import arb, acb, ctx
ctx.prec=200
ctx.threads=1
t0=time.process_time()
maxrad=arb(0)
pi_log=arb.pi().log()
dg=hashlib.sha256()
for j in range(84881):
    t=arb(5*j)/64
    for a in (0,1):
        g=acb(arb(1)/4+arb(a)/2,t/2)
        z=acb(0,g.lgamma().imag-t*pi_log/2).exp()
        for v in (z.real,z.imag):
            m=(v*(2**105)+arb(1)/2).floor().unique_fmpz()
            assert m is not None and abs(v*2**105-int(m))<arb(1)/2
            dg.update(int(m).to_bytes(14,'little',signed=True))
            maxrad=max(maxrad,v.rad())
r=dict(j_max=84880,phases=169762,coordinates=339524,cpu=time.process_time()-t0,max_coord_radius=str(maxrad),p105_digest=dg.hexdigest(),encoding='j ascending, a=0 then 1, real then imag, signed little-endian 14 bytes')
print(r)
Path(__file__).with_name('full-gamma-native.json').write_text(json.dumps(r,indent=2))
