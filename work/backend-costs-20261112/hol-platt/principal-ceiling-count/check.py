import csv
import json
from pathlib import Path
from time import perf_counter, process_time
import flint
from flint import arb, ctx, dirichlet_char
ctx.prec=80
ctx.threads=1
out=Path(__file__).resolve().parent
T=10**8
chi=dirichlet_char(1,1)
def timed(f):
    w,c=perf_counter(),process_time()
    value=f()
    return value, [perf_counter()-w,process_time()-c]
def count(t):
    x=arb(t).zeta_nzeros().unique_fmpz()
    assert x is not None
    return int(x)
counts,tcount=timed(lambda:[count(T-8),count(T)])
def signs():
    for d in [16,32,64,128]:
        values=[]
        for i in range(8*d+1):
            z=chi.hardy_z(arb((T-8)*d+i)/d)
            assert z.imag.contains(0)
            s=1 if z.real>0 else -1 if z.real<0 else 0
            assert s
            values.append((i+(T-8)*d,d,s,str(z.real)))
        changes=sum(a[2]!=b[2] for a,b in zip(values,values[1:]))
        if changes==counts[1]-counts[0]:
            return values,changes
    raise ValueError("unresolved signs")
(vals,lower),tsign=timed(signs)
with (out/'signs.tsv').open('w',newline='') as f:
    w=csv.writer(f,delimiter='\t');w.writerow(['numerator','denominator','sign','real_ball']);w.writerows(vals)
report=dict(window=[T-8,T],positive_counts=counts,lower=lower,sites=len(vals),precision=ctx.prec,
    python_flint=flint.__version__,count_wall_cpu=tcount,sign_wall_cpu=tsign)
(out/'receipt.json').write_text(json.dumps(report,indent=2)+'\n')
print(report)
