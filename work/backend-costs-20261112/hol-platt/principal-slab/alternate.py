import csv,json,itertools,time,statistics,math
from pathlib import Path
from flint import arb,dirichlet_char,ctx
p=Path(__file__).resolve().parent
ctx.prec=112;ctx.threads=1
data=sorted((int(r['tick_1024']),int(r['sign']),abs(arb(r['enclosure']))) for r in csv.DictReader((p/'signs.tsv').open(),delimiter='\t'))
summary=json.loads((p/'summary.json').read_text())
assert summary['unresolved']==[]
runs=itertools.groupby(data,key=lambda x:x[1])
best=[max(group,key=lambda v:float(v[2])) for _,group in runs]
assert len(best)==summary['zero_increment']+1 and all(a[1]*b[1]<0 and a[0]<b[0] for a,b in zip(best,best[1:]))
counts=json.loads((p/'counts.json').read_text())['counts']
assert int(next(iter(counts)))==summary.get('lo',99995904)
chi=dirichlet_char(1,1);start=time.perf_counter();cpu=time.process_time()
with (p/'alternating-receipt.tsv').open('w',newline='') as f:
    w=csv.writer(f,delimiter='\t');w.writerow(['tick_1024','sign','hardy_real_112'])
    margins=[]
    for tick,sign,m in best:
        z=chi.hardy_z(arb(tick)/1024);assert z.imag.contains(0) and (z.real>0 if sign>0 else z.real<0)
        assert abs(z.real)>0;margins.append(float(abs(z.real).lower()));w.writerow([tick,sign,str(z.real)])
wall=time.perf_counter()-start;cpu=time.process_time()-cpu
res=dict(zeros=len(best)-1,sites=len(best),min_abs_floor=min(margins),low_1pct=sorted(margins)[len(margins)//100],median_abs=statistics.median(margins),first=best[0][0],last=best[-1][0],check_wall=wall,check_cpu=cpu,seconds_per_zero=cpu/(len(best)-1),full_count_high_rate_corehours=cpu/(len(best)-1)*248008025/3600)
(p/'alternating.json').write_text(json.dumps(res,indent=2)+'\n');print(res)
