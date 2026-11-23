from flint import arb,acb,ctx
from time import perf_counter
ctx.prec=96
for t in (100,1000,10**8):
 for p in (3,9,16):
    a=arb(1,arb(2)**(-p))
    start=perf_counter();z=acb(a,t).zeta()
    print(t,p,str(z)[:100],perf_counter()-start,flush=True)
