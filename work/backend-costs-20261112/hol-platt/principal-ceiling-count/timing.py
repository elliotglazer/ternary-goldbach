import csv,json,time
from collections import defaultdict
from pathlib import Path
from flint import arb,ctx,dirichlet_char
ctx.threads=1
p=Path(__file__).resolve().parent
data=defaultdict(list)
for r in csv.DictReader((p/'shard-signs.tsv').open(),delimiter='\t'):data[int(r['end'])].append((int(r['numerator']),int(r['sign'])))
counts={int(r['end']):(int(r['lo_count']),int(r['hi_count'])) for r in csv.DictReader((p/'shards.csv').open())}
chi=dirichlet_char(1,1)
with (p/'timing.csv').open('w',newline='') as f:
    w=csv.writer(f);w.writerow(['end','bits','rep','sites','count_wall','sign_wall','count_cpu','sign_cpu'])
    for rep in range(4):
        ctx.prec=128 if rep==3 else 80
        for end,sites in data.items():
            t0=time.perf_counter();u0=time.process_time()
            ns=tuple(int(arb(h).zeta_nzeros().unique_fmpz()) for h in (end-8,end))
            assert ns==counts[end]
            t1=time.perf_counter();u1=time.process_time()
            for a,expected in sites:
                z=chi.hardy_z(arb(a)/128)
                assert z.imag.contains(0) and (z.real>0 if expected>0 else z.real<0)
            w.writerow([end,ctx.prec,rep,len(sites),t1-t0,time.perf_counter()-t1,u1-u0,time.process_time()-u1]);f.flush()
print("RECHECK_PASS")
