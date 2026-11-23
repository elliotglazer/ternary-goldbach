"""Abstract exact scheduling tests; no prime, Fourier or function data."""
from pathlib import Path
from itertools import product
import hashlib, json

HERE=Path(__file__).resolve().parent
pin='8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9'
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
ck(hashlib.sha256((HERE/'SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md').read_bytes()).hexdigest().upper()==pin)
cases=0; switches=0; worst_num=0; worst_den=1
# Four abstract target positions. Their two-element stencils overlap and wrap.
stencils=[{i,(i+1)%4} for i in range(4)]
for length in range(5):
 for requests in product(range(4),repeat=length):
  unique=list(dict.fromkeys(requests))
  for K in (1,2,4,7,11,20):
   for setup in (0,9):
    for miss in (0,3):
     # Dense query cost 2, local fixed query cost 5. Setup is lazy.
     cache=set(); ls=[]; rs=[]
     for i,target in enumerate(unique):
      new=stencils[target]-cache
      li=5+miss*len(new)+(setup if i==0 else 0)
      ls.append(li); rs.append(li-2)
      cache.update(new)
     rental=0; cost=0; bought=False; buy_at=None
     for i,r in enumerate(rs):
      if not bought and rental+r>=K:
       bought=True; buy_at=i; cost+=K
      if bought: cost+=2
      else: cost+=ls[i]; rental+=r
     D=2*len(unique); R=sum(rs)
     oracle=D+min(R,K) if unique else 0
     ck(cost<=D+2*min(R,K))
     ck(cost<=2*oracle)
     if bought:
      ck(rental<K); ck(sum(rs[:buy_at+1])>=K); ck(R>=K)
      ck(cost==D+rental+K); switches+=1
     else:
      ck(cost==sum(ls)); ck(R<K or not unique)
     if oracle and cost*worst_den>worst_num*oracle:
      worst_num,worst_den=cost,oracle
     cases+=1
# The nonnegative excess-cost hypothesis cannot just be dropped.
K=10; dense=[1,20]; local=[11,1]
bad_online=K+sum(dense); bad_oracle=min(sum(local),K+sum(dense))
ck(bad_online>2*bad_oracle)
# Exact-threshold-before-pay handles an arbitrarily large first miss.
ck(10 <= 2*min(1000000,10))
out={'scope':'abstract charged schedules only; controller cost separate',
     'predecessor_sha256':pin,'checks':checks,'cases':cases,'switch_cases':switches,
     'worst_observed_ratio':{'numerator':worst_num,'denominator':worst_den},
     'negative_rent_counterexample':{'dense_setup':K,'dense_queries':dense,'local_queries':local,
                                      'online':bad_online,'oracle':bad_oracle},
     'theorem':'ALG <= controller + common + D + 2 min(R,K), for nonempty requests and r_i>=0'}
dest=HERE/'online_polyphase_switching_20261111.json'
with dest.open('x',encoding='utf-8') as f: json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':checks,'cases':cases,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
