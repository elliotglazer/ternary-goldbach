import csv,json,statistics,time
from pathlib import Path
from flint import acb,arb,ctx
p=Path(__file__).resolve().parent;ctx.prec=112;ctx.threads=1
rows=list(csv.DictReader((p/'alternating-receipt.tsv').open(),delimiter='\t'))
rows=sorted(rows,key=lambda r:float(abs(arb(r['hardy_real_112']))))
ix=sorted(set(range(16))|{(len(rows)-1)*k//16 for k in range(17)})
M=3989
u=time.process_time();w=time.perf_counter()
logs=[arb(n).log() for n in range(1,M+1)]
amps=[1/arb(n).sqrt() for n in range(1,M+1)]
setup=[time.perf_counter()-w,time.process_time()-u]
out=[]
for j in ix:
    item=rows[j];tick=int(item['tick_1024']);t=arb(tick)/1024;pi=arb.pi()
    w=time.perf_counter();u=time.process_time()
    saddle=(t/(2*pi)).sqrt();N=saddle.floor().unique_fmpz();assert N is not None and int(N)<=M;N=int(N)
    z=1-2*(saddle-N);den=(pi*z).cos();assert not den.contains(0)
    F=(pi*(z*z+arb(3)/4)/2).cos()/den
    corr=-((-1)**N)*F/saddle.sqrt()
    theta=t*(t/(2*pi)).log()/2-t/2-pi/8+1/(48*t)
    K=2*sum((a*(theta-t*l).cos() for a,l in zip(amps[:N],logs[:N])),arb(0))+corr
    E=(arb(451)/1000)/(t**(arb(3)/4))
    assert K>E if int(item['sign'])>0 else K < -E
    assert abs(K-arb(item['hardy_real_112']))<E
    out.append(dict(tick=tick,quantile_index=j,N=N,K=str(K),tail_bound=str(E),correction=str(corr),theta=str(theta),sign=int(item['sign']),wall=time.perf_counter()-w,cpu=time.process_time()-u))
res=dict(prec=112,selection="16 smallest retained margins plus 17 order-statistic quantiles",cached_source_wall_cpu=setup,rows=out,min_tail_ratio=min(float(abs(arb(r['K']))/arb(r['tail_bound'])) for r in out))
(p/'riemann-siegel.json').write_text(json.dumps(res,indent=2)+'\n');print(len(out),setup,statistics.median(r['wall'] for r in out),sum(r['wall'] for r in out),res['min_tail_ratio'])
