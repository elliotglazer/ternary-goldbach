import csv,json,sys
from functools import lru_cache
from pathlib import Path
from time import perf_counter,process_time
from flint import arb,acb,ctx
ctx.prec=96;ctx.threads=1
p=Path(__file__).resolve().parent
grid=2**24
def certify(t):
    proposals=0;accepted=0;maxdepth=0
    @lru_cache(None)
    def point(k):return acb(arb(k)/grid,t).zeta()
    def panel(a,b,d):
        nonlocal proposals,accepted,maxdepth
        proposals+=1
        u,v=point(a),point(b)
        si=arb(arb(a+b)/(2*grid),arb(a-b)/(2*grid))
        cover=acb(si,t).zeta()
        signs=[cover.real>0, cover.imag>0,cover.real<0,cover.imag<0]
        if any(signs):
            delta=(v/u).arg()
            if delta.is_finite():
                accepted+=1;maxdepth=max(maxdepth,d)
                writer.writerow([t,a,b,grid,d,signs.index(True),str(cover),str(u),str(v),str(delta)])
                return delta
        if d>=22 or (a-b)%2:raise RuntimeError((a,b,d))
        m=(a+b)//2
        return panel(a,m,d+1)+panel(m,b,d+1)
    start=perf_counter(); cpu=process_time()
    initial=point(2*grid)
    assert initial.real>0
    angle=initial.arg()+panel(2*grid,grid//2,0)
    theta=acb(arb(1)/4,arb(t)/2).lgamma().imag-arb(t)*arb.pi().log()/2
    result=1+(theta+angle)/arb.pi()
    n=result.unique_fmpz()
    assert n is not None
    return dict(t=t,count=int(n),count_interval=str(result),theta=str(theta),path_argument=str(angle),
                proposals=proposals,accepted=accepted,maxdepth=maxdepth,point_evals=point.cache_info().misses,
                wall=perf_counter()-start,cpu=process_time()-cpu)
with (p/'top-panels.tsv').open('w',newline='') as f:
    writer=csv.writer(f,delimiter='\t');writer.writerow(['T','left_traversal','right_traversal','scale','depth','halfplane_REpos_IMpos_REneg_IMneg','whole_zeta','point_start','point_end','arg_ratio'])
    results=[]
    for t in (100,1000,100000000):
        results.append(certify(t));print(results[-1],flush=True)
        (p/'top-counts.json').write_text(json.dumps(results,indent=2)+'\n')
