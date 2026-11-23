"""Independent backward min-plus grid search; exact metadata only."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
A=ROOT/'work/qrh-campaign/agents/prime-estimates'
pins={
 'work/qrh-campaign/agents/prime-estimates/OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md':'A27CD526DB41C599F43912626827062EDC454F887A722782FF3953BE5BFFCE29',
 'work/qrh-campaign/agents/prime-estimates/optimize_degree_horner_grids_20261111.py':'CB760828296AB00D2469B06B53FEE3BE2980B815186CED384D36DF94BD225AA8',
 'work/qrh-campaign/agents/prime-estimates/optimize_degree_horner_grids_20261111.json':'9BA037D7AAFB7A0F053C109ABD9751112B586805236A14D9467EFD29B32871CE',
}
checks=0
def check(x):
 global checks
 assert x
 checks+=1
for p,h in pins.items():check(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
receipt=json.loads((A/'optimize_degree_horner_grids_20261111.json').read_text())
for p,h in receipt['pins'].items():
 check(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
 pins[p]=h
def byte(w):return (w+7)//8
def node(j,b):return byte(b+15) if j==0 else byte(b+16) if j==19 else byte(b+17)+byte(b+15)
def weight(j,b):return (1 if j==19 else 2) << (138-b-2*j)
limit=32*2**38
# A suffix state stores first grid, total digit cost and minimum weight.
# No prefix feasibility pruning is used. Costs exceeding the uniform maximum
# cannot contribute to the frontier, because uniform100 minimizes every error term.
states={(b,node(19,b)):weight(19,b) for b in range(70,101)}
layers=[len(states)]
for j in range(18,0,-1):
 nxt={}
 for b in range(70,101):
  cost=node(j,b);w=weight(j,b)
  for (following,d),old in states.items():
   if following>b:continue
   key=(b,d+cost)
   if key[1]>555:continue
   val=w+old
   if val<nxt.get(key,val+1):nxt[key]=val
 states=nxt;layers.append(len(states))
best={}
for (_,d),w in states.items():
 d+=15;w+=weight(0,100)
 if 9*w<limit and w<best.get(d,w+1):best[d]=w
frontier={};record=None
for d,w in sorted(best.items()):
 if record is None or w<record:frontier[d]=w;record=w
check(len(frontier)==74)
check(list(frontier)==list(range(497,571)))
saved={r['digit_subtotal']:r['weighted_integer'] for r in receipt['pareto_profiles']}
check(frontier==saved)
def inspect(row):
 b=row['grid'];check(len(b)==20 and b[0]==100)
 check(all(70<=x<=100 for x in b) and all(x>=y for x,y in zip(b,b[1:])))
 err=F(3,4)*sum(F(2 if j<19 else 1)*F(2)**(100-x-2*j) for j,x in enumerate(b))
 cost=0
 for j in range(19):
  iw=b[j+1]+(16 if j==18 else 17);qw=b[j]+15
  cost+=2*((5*byte(iw)*3+2*3+1)+(5*byte(qw)*3+2*3+1))
  s=row['stages'][j]
  check(s['input_magnitude_bits']==iw and s['rounded_magnitude_bits']==qw)
  check(s['post_product_shift']==b[j]-b[j+1])
  check(s['shifted_X_signed_bits']==b[j]+36 and s['doubled_residual_signed_bits']==b[j]+38)
 check(cost==row['product_macro_events'])
 check(err==F(row['error_in_u']) and err<F(8,3))
 check(F(8,3)-err==F(row['reserve_in_u']))
 return cost,err
for r in receipt['pareto_profiles']:inspect(r)
u=inspect(receipt['comparisons']['uniform100'])
l=inspect(receipt['comparisons']['root_linear_profile'])
first=receipt['pareto_profiles'][0];minimum=inspect(first)
check((minimum[0],l[0],u[0])==(15442,16252,17632))
check(minimum[1]==F(5253,2048))
check(F(8,3)-minimum[1]==F(625,6144))
check(F(8,3)-u[1]<1)
for need,result in receipt['reserve_choices'].items():
 eligible=[(30*d+532,F(8,3)-F(3*w,4*2**38)) for d,w in frontier.items() if F(8,3)-F(3*w,4*2**38)>=F(need)]
 check((result is None)==(not eligible))
 if eligible:check((result['product_macro_events'],F(result['reserve_in_u']))==min(eligible))
C=2**16;bound=F(4*(C+1),3)
check(bound<2**17 and bound/4+1<2**15)
check(F(3,4)*F(1,2**70)<1)
check(40665+1<C and 132900<2**18 and 531600<2**20)
out={'status':'PASS_BOUNDED_BACKWARD_DP_AND_PAPER_WIDTH_REVIEW','checks':checks,'pins':pins,
 'backward_layer_sizes':layers,'frontier':{str(d):w for d,w in frontier.items()},
 'minimum_product_events':15442,'linear_product_events':16252,'uniform_product_events':17632,
 'scope':'Exact rational/integer metadata, no author program imported or executed; no coefficient values or builds.'}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),'frontier':len(frontier)}))
