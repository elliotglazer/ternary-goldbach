"""Independent integer geometry, finite-price integration and path checks."""
from pathlib import Path
from fractions import Fraction as F
from itertools import combinations,product
import hashlib,json
HERE=Path(__file__).resolve().parent
P=HERE.parent/'independent-feasibility'
ROOT=HERE.parents[3]
pins={'FINITE_COVERAGE_COST_FRONTIER_V2_2026-11-11.md':'F512044F2F5E9B55A7DFC9B5DAE8D094F4D290C41B5A9AB9202E42DD69901753',
'finite_coverage_cost_frontier_v2_20261111.py':'DA3FBF545ED5AC5DC34529DC87AA09C39CFABE003CD09094EDA827CBAB6F99FF',
'finite_coverage_cost_frontier_v2_20261111.json':'4026FD4C556DCC475367AE7E1CEE5DCB2E654914E8568130FAA3140C54E2E39C'}
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
for fn,h in pins.items():ck(hashlib.sha256((P/fn).read_bytes()).hexdigest().upper()==h)
d=json.loads((P/'finite_coverage_cost_frontier_v2_20261111.json').read_text())
for fn,h in d['pins'].items():ck(hashlib.sha256((ROOT/fn).read_bytes()).hexdigest().upper()==h)
def cd(a,b):return -((-a)//b)
def order(n):
 m=0
 while n>=(2**(m+1)+1)**2:m+=1
 return m
for row in d['rows']:
 B=row['B'];D=B-2;Y=d['T']-B;K=cd(d['T']-5,D)-1
 ck(row['K_min']==K and Y-(K-1)*D>=5)
 spans=sorted({5,Y+1}|{2**j for j in range(1,91) if 5<2**j<=Y}|{(2**j+1)**2 for j in range(1,46) if 5<(2**j+1)**2<=Y})
 bands=[]
 for lo,hi in zip(spans,spans[1:]):
  jmin=max(0,cd(Y-(hi-1),D));jmax=min(K-1,(Y-lo)//D)
  n=max(0,jmax-jmin+1)
  if n:bands.append(dict(lo=lo,hi_exclusive=hi,count=n,width=lo.bit_length(),squares=order(lo)))
 ck(bands==row['bands'])
 for key,power in [('reverse_squares',0),('reverse_square_times_width_squared',2)]:ck(row[key]==sum(b['count']*b['squares']*b['width']**power for b in bands))
 ck(row['reverse_width_capacity']==sum(b['count']*b['width'] for b in bands))
 ck(row['binary_word_count']==cd(D,128))

# Integrate monotone integer-step prices exactly and compare every admissible
# small geometry, including exact threshold and exact multiple endpoints.
for T in range(9,302,2):
 for B in range(4,T-3,2):
  D=B-2;Y=T-B;K=cd(T-5,D)-1
  vals=[Y-j*D for j in range(K)]
  ck(5<=min(vals)<=D+3 and min(vals)-D<5)
  for mode in range(3):
   def price(x):
    if x<5:return 0
    return [1,order(x),order(x)*x.bit_length()**2+x.bit_length()][mode]
   integral=sum(price(x) for x in range(5,Y))
   subtotal=sum(price(x) for x in vals)
   ck(F(integral,D)<=subtotal<=F(integral,D)+price(Y))

def frontier(xs):
 xs=set(xs)
 return sorted(x for x in xs if not any(y!=x and all(a<=b for a,b in zip(y,x)) for y in xs))
pool=[3,9,17,23,35,47,59];T=71
variants=[[(0,0)]]+[[(13-i,2*i+1),(i+1,17-i)] for i in range(1,len(pool))]
dp=[[(4,0,0)]]
for j in range(1,len(pool)):
 labels=[]
 for i in range(j):
  for b,a,v in dp[i]:
   for aa,vv in variants[j]:labels.append((max(b,pool[j]-pool[i]+2),a+aa,v+vv))
 dp.append(frontier(labels))
done=frontier((max(b,T-pool[j]),a,v) for j,ls in enumerate(dp) for b,a,v in ls)
literal=[]
for length in range(len(pool)):
 for ids in combinations(range(1,len(pool)),length):
  chain=(0,)+ids
  cutoff=max([4,T-pool[chain[-1]]]+[pool[j]-pool[i]+2 for i,j in zip(chain,chain[1:])])
  for choices in product(*(variants[j] for j in ids)):
   literal.append((cutoff,sum(a for a,v in choices),sum(v for a,v in choices)))
  # Direct coverage is over odd labels; no primality is claimed.
  ck(all(any(pool[i]+4<=n<=pool[i]+cutoff for i in chain) for n in range(7,T+1,2)))
  K=max(0,cd(T-5,cutoff-2)-1)
  ck(len(ids)>=K)
  for j in range(K):ck(pool[chain[-1-j]]>=T-cutoff-j*(cutoff-2))
ck(frontier(literal)==done)
for a,b,c in product(range(4),repeat=3):
 ck(min(a*x+b*y+c*z for x,y,z in done)==min(a*x+b*y+c*z for x,y,z in literal))
out=dict(status='PASS_INDEPENDENT_FRONTIER_V2',checks=checks,author_pins=pins,source_pins_checked=len(d['pins']),large_rows=len(d['rows']),variant_path_frontier=done,scope='Integer labels and symbolic prices only; no primality, residues or timing.')
with Path(__file__).with_suffix('.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({k:v for k,v in out.items() if k!='variant_path_frontier'},indent=2))
