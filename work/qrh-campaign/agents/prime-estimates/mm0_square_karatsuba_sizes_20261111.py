"""Exact proposed proof-template recurrences, no modular values/proofs or benchmarks."""
from functools import lru_cache
from pathlib import Path
import json
def S(n): return 5*n*n+2*n+1
def A(n): return 2*n+1
def C_raw(n): return 5*n*(n-1)//2+12*n+3
def C(n): return min(S(n),C_raw(n))
def hg(n):
    h=(n+1)//2
    return 12*h+8*n+21
def hc(n):
    h=(n+1)//2
    return 10*h+8*n+18
@lru_cache(None)
def model(kind,n,threshold,adaptive):
    base=S(n) if kind=='mul' else C(n)
    if n<=threshold: return (base,0,1,0,0)
    h=(n+1)//2; g=n//2
    assert h+1<n
    kids=[model(kind,j,threshold,adaptive) for j in [h,g,h+1]]
    overhead=hg(n) if kind=='mul' else hc(n)
    cost=sum(k[0] for k in kids)+overhead
    if adaptive and cost>=base: return (base,0,1,0,0)
    return (cost,1+sum(k[1] for k in kids),sum(k[2] for k in kids),
            n+sum(k[3] for k in kids),max(k[4] for k in kids)+1)
rows=[]
for b in [4,8,10,12,16]:
    for w in [90,718,2871]:
        n=(w+b-1)//b
        old=2*S(n)+6*n+3
        tri=C(n)+S(n)+6*n+3
        schemes=[]
        for threshold in [3,8,16,32]:
            for adaptive in [False,True]:
                m=model('mul',n,threshold,adaptive)
                c=model('sq',n,threshold,adaptive)
                schemes.append(dict(threshold=threshold,adaptive=adaptive,
                    general=dict(cost=m[0],internal_nodes=m[1],leaves=m[2],node_width_sum=m[3],depth=m[4]),
                    square=dict(cost=c[0],internal_nodes=c[1],leaves=c[2],node_width_sum=c[3],depth=c[4]),
                    modular_square=c[0]+m[0]+6*n+3,
                    modular_general=2*m[0]+6*n+3))
        rows.append(dict(b=b,width=w,n=n,general_schoolbook=S(n),
            triangular_square_raw=C_raw(n),square_base=C(n),
            old_modular_square=old,triangular_modular_square=tri,
            old_44_squares=44*old,triangular_44_squares=44*tri,schemes=schemes))
# A deliberately wrong no-growth recurrence is included only as a diagnostic.
@lru_cache(None)
def wrong_no_growth(n):
    if n<=8: return C(n)
    h=(n+1)//2; g=n//2
    return wrong_no_growth(h)+wrong_no_growth(g)+wrong_no_growth(h)+hc(n)
out=dict(scope='finite algebra/event models, excludes split/representation costs and all timings',
    rows=rows,unsafe_no_growth_example=dict(n=359,
        actual=model('sq',359,8,False)[0],unsafe=wrong_no_growth(359)))
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    for r in rows:
        if r['b'] in [4,8]:
            best=min(r['schemes'],key=lambda s:s['modular_square'])
            print(r['b'],r['width'],r['n'],r['old_modular_square'],r['triangular_modular_square'],
                best['modular_square'],best['threshold'],best['adaptive'])
    print(out['unsafe_no_growth_example'])
