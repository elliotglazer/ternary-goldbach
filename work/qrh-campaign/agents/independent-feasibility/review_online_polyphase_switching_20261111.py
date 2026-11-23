"""Independent finite scheduling checks only; no evaluator or author import."""
from pathlib import Path
from itertools import product
from fractions import Fraction as F
import hashlib,json

HERE=Path(__file__).resolve().parent
A=HERE.parent
pins={
'major-constants/ONLINE_SPARSE_POLYPHASE_SWITCHING_2026-11-11.md':'078A8C9A9DA83888C837F1D13995EF87B2E7D14733587616D793F823AB7C0F52',
'major-constants/online_polyphase_switching_20261111.py':'B4DDCBF0D9B3A155C0D921D68B43DE3978CB4FD126CCB8FB9857219F13D01FBF',
'major-constants/online_polyphase_switching_20261111.json':'E23E7BB25C69DB258D79C057BC259C617C204216DD9439BE8A8FED0E13AEB92A',
'major-constants/SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md':'8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9',
'independent-feasibility/REVIEW_SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md':'F231302A5FBB884B4A4020E7D104264A8BEBAB9FB71D47BB45715907CE8BD01B'}
checks=0
cases=0
def ck(v):
 global checks
 assert v
 checks+=1
for p,h in pins.items():ck(hashlib.sha256((A/p).read_bytes()).hexdigest().upper()==h)

def verify(rents,dense,K,C):
 global cases
 spent=C; rental=0;bought=False
 # Check every stopping prefix, not just the completed input.
 for i,(r,d) in enumerate(zip(rents,dense)):
  if not bought and rental+r>=K:
   spent+=K;bought=True
  spent+=d
  if not bought:spent+=r;rental+=r
  R=sum(rents[:i+1]);D=sum(dense[:i+1])
  ck(spent<=C+D+2*min(R,K))
  ck(spent<=2*(C+D+min(R,K)))
  if bought:
   ck(R>=K)
   ck(spent==C+D+rental+K)
   ck(K==0 or rental<K)
  else:
   ck(spent==C+D+R)
   ck(R<K)
 if not rents:ck(spent==C and not bought)
 cases+=1

for length in range(5):
 for rs in product([F(0),F(1,3),F(2),F(101)],repeat=length):
  ds=[F((i*3+1)%5,2) for i in range(length)]
  for K in [F(0),F(1,2),F(3),F(20)]:
   for C in [F(0),F(7,3)]:verify(rs,ds,K,C)

# Independent cache scenario: three-point stencils on five coarse indexes.
stencils=[{i,(i+1)%5,(i+3)%5} for i in range(5)]
cache_cases=0
for length in range(5):
 for seq in product(range(5),repeat=length):
  unique=[]
  for x in seq:
   if x not in unique:unique.append(x)
  cache=set();rents=[];dense=[]
  for i,x in enumerate(unique):
   miss=len(stencils[x]-cache)
   d=1+x%2
   l=d+2+7*miss+(29 if i==0 else 0)
   rents.append(l-d);dense.append(d)
   cache|=stencils[x]
  verify(rents,dense,37,0)
  cache_cases+=1

ck(10+1+20>2*(11+1))
ck(10<=2*min(10,10**9))
ck(10**9+10>2*10) # Post-payment switching has unbounded overshoot.
saved=json.loads((A/'major-constants/online_polyphase_switching_20261111.json').read_text())
ck(saved['negative_rent_counterexample']['online']==31)
ck(saved['negative_rent_counterexample']['oracle']==12)
out=dict(scope='Abstract charged scheduling only; no arithmetic evaluator data',checks=checks,
 cases=cases,cache_streams=cache_cases,pins=pins,
 covers=['all stopping prefixes','K=0','empty stream','zero and rational rents',
         'large rent jump','lazy setup','duplicate queries','overlapping cache stencils'],
 comparator='same realized requests; fixed purchase; nonnegative local-minus-dense rents')
dest=HERE/'review_online_polyphase_switching_20261111.json'
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(checks=checks,cases=cases,sha256=hashlib.sha256(dest.read_bytes()).hexdigest().upper())))
