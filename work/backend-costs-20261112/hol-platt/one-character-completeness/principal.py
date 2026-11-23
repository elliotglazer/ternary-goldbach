"""Native principal RH-through-500 subrequirement, multiplicity-count saturation."""
import csv
import json
from pathlib import Path
from time import perf_counter,process_time
from flint import arb,ctx,dirichlet_char

ctx.prec=96
ctx.threads=1
here=Path(__file__).resolve().parent
chi=dirichlet_char(1,1)
t,c=perf_counter(),process_time()
upper=arb(500).zeta_nzeros().unique_fmpz()
assert upper is not None
upper_times=(perf_counter()-t,process_time()-c)
t,c=perf_counter(),process_time()
with (here/'principal-signs.tsv').open('w',newline='') as f:
    w=csv.writer(f,delimiter='\t',lineterminator='\n')
    w.writerow(('t_times_4','sign','hardy_real'))
    brackets=0
    previous=None
    for i in range(2001):
        z=chi.hardy_z(arb(i)/4)
        assert z.imag.contains(0)
        sign=1 if z.real>0 else -1 if z.real<0 else 0
        assert sign
        if previous is not None and sign!=previous:
            brackets+=1
        previous=sign
        w.writerow((i,sign,z.real))
assert brackets==int(upper)
print(json.dumps(dict(T=500,step='1/4',positive_upper=int(upper),positive_lower=brackets,
                      both=2*brackets,upper_wall_cpu=upper_times,
                      lower_wall_cpu=[perf_counter()-t,process_time()-c]),indent=2))
