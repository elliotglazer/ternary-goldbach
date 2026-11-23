"""Exact polynomial-only endpoint extension; no analytic coefficient data."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
OWN=Path(__file__).resolve().parent
path='work/qrh-campaign/agents/prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md'
pin=hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()
assert pin=='99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1'
checks=0
def check(x):
 global checks
 assert x
 checks+=1
cases=[]
for c,F,k in [(20483,1024,0),(20483,1024,1024),(265800,1024,512)]:
 check(c>20*F)
 lo=max(1,-(-((2*k-1)*c)//(2*F)))
 hi=min(c-1,-(-((2*k+1)*c)//(2*F))-1)
 L=hi-lo+1
 check(L>0)
 for a in range(lo,hi+1):
  for j in range(20):
   check(abs(Q(F*(a+j)-k*c,2*c))<Q(29,40))
 for degree in range(20):
  def val(a):return (F*a-k*c)**degree*(2*c)**(19-degree)
  level=[val(lo+j) for j in range(20)]; state=[]
  for order in range(20):
   state.append(level[0]);level=[level[i+1]-level[i] for i in range(len(level)-1)]
  updates=0
  for i in range(L):
   check(state[0]==val(lo+i))
   if i<L-1:
    for j in range(19):state[j]+=state[j+1];updates+=1
  check(updates==19*(L-1))
 cases.append({'c':c,'F':F,'k':k,'L':L,'last_initial_a':lo+19,'full_advance_additions':19*(L-1)})
check(Q(1,4)+Q(19,40)==Q(29,40)<Q(3,4))
out={'scope':'Synthetic integer polynomial identities, not actual coefficients',
     'pins':{path:pin},'checks':checks,'cases':cases,
     'b122':{'live_signed_capacity':522,'raw_addition_signed_capacity':523},
     'per_bucket':{'prescales':19,'initial_scales':380,'initial_additions':380,
                   'triangle_subtractions':190,'advance':'19*(L-1)',
                   'total_add_sub':'19*L+551'}}
with (OWN/'screened_residue_difference_20261111.json').open('x',encoding='utf-8') as f:
 json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(out,indent=2))
