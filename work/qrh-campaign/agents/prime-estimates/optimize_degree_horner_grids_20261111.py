"""Bounded exact grid/cost dynamic program. No coefficient or function values."""
from pathlib import Path
from fractions import Fraction
import hashlib,json,time
ROOT=Path(__file__).resolve().parents[4]
start=time.monotonic()
pins={
 'work/qrh-blueprint/DEGREE_DEPENDENT_HORNER_GRID_PROPOSAL_2026-11-11.md':'0249787E3EC22DAC609C28FE62CE847A8389CDB6D81ADD5A65D783A872A5DE12',
 'work/qrh-campaign/agents/prime-estimates/REVIEW_DEGREE_DEPENDENT_HORNER_GRID_2026-11-11.md':'D475972DB3EBDEC46D1AAB5DC5D4CBD7D7C157936E333ECE46737F45C34DC5E9',
 'work/qrh-campaign/agents/audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md':'84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C',
 'work/qrh-campaign/agents/prime-estimates/B100_HORNER_FIXED_FACTOR_PROOF_REUSE_2026-11-11.md':'973FA8095EA9BC4768B1D50B70AB0218FE730508C46E7BC37F68B5E944381CE0',
}
checks=0
def ck(ok):
 global checks
 checks+=1
 assert ok
for path,digest in pins.items():
 ck(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==digest)
def digits(bits):return (bits+7)//8
def node_cost(j,b):
 if j==0:return digits(b+15)
 if j==19:return digits(b+16)
 return digits(b+17)+digits(b+15)
def weight(j,b):return (1 if j==19 else 2)*2**(138-b-2*j)
def admit(w):return 9*w<32*2**38
def describe(profile):
 w=sum(weight(j,b) for j,b in enumerate(profile))
 cost=sum(node_cost(j,b) for j,b in enumerate(profile))
 error=Fraction(3*w,4*2**38)
 stages=[]
 for j in range(19):
  bj,bn=profile[j],profile[j+1]
  inp=bn+(16 if j==18 else 17)
  quot=bj+15
  delta=bj-bn
  ck(delta>=0)
  stages.append(dict(j=j,input_magnitude_bits=inp,rounded_magnitude_bits=quot,
   factor_r_bits=18,factor_v_bits=20,post_product_shift=delta,
   complex_product_macro_events=2*(15*digits(inp)+7+15*digits(quot)+7),
   shifted_X_signed_bits=bj+36,witness_signed_bits=bj+36,
   residual_signed_bits=bj+37,doubled_residual_signed_bits=bj+38))
 ck(sum(s['complex_product_macro_events'] for s in stages)==30*cost+532)
 return dict(grid=list(profile),weighted_integer=w,digit_subtotal=cost,
  product_macro_events=30*cost+532,error_in_u=str(error),
  reserve_in_u=str(Fraction(8,3)-error),
  positive_shift_stages=sum(s['post_product_shift']>0 for s in stages),
  total_shift_bits=sum(s['post_product_shift'] for s in stages),
  maximum_shift=max(s['post_product_shift'] for s in stages),stages=stages)

# State=(last grid, accumulated digit subtotal); value=(least error integer, profile).
states={(100,node_cost(0,100)):(weight(0,100),(100,))}
layer_sizes=[len(states)]; transitions=0
for j in range(1,20):
 next_states={}
 for (previous,cost),(w,profile) in states.items():
  for b in range(70,previous+1):
   transitions+=1
   nw=w+weight(j,b)
   if not admit(nw):continue
   key=(b,cost+node_cost(j,b)); candidate=(nw,profile+(b,))
   old=next_states.get(key)
   if old is None or nw<old[0] or (nw==old[0] and candidate[1]>old[1]):
    next_states[key]=candidate
 states=next_states
 layer_sizes.append(len(states))
 if time.monotonic()-start>30:raise RuntimeError('bounded metadata guard exceeded')
 ck(bool(states))
best={}
for (_,cost),(w,profile) in states.items():
 old=best.get(cost)
 if old is None or w<old[0] or (w==old[0] and profile>old[1]):best[cost]=(w,profile)
frontier=[]; prior=None
for cost,(w,profile) in sorted(best.items()):
 if prior is None or w<prior:
  ck(admit(w)); ck(all(70<=b<=100 for b in profile))
  row=describe(profile)
  ck(row['weighted_integer']==w and row['digit_subtotal']==cost)
  frontier.append(row);prior=w
uniform=describe((100,)*20)
root_profile=describe(tuple([100,100]+list(range(98,80,-1))))
ck(uniform['product_macro_events']==17632)
ck(frontier[0]['product_macro_events']<=root_profile['product_macro_events'])
choices={}
for reserve in (Fraction(1,24),Fraction(1,12),Fraction(1,6),Fraction(1,3),Fraction(1,2),Fraction(1)):
 valid=[r for r in frontier if Fraction(r['reserve_in_u'])>=reserve]
 choices[str(reserve)]=None if not valid else dict(grid=valid[0]['grid'],
  product_macro_events=valid[0]['product_macro_events'],reserve_in_u=valid[0]['reserve_in_u'])
out=dict(status='PASS_BOUNDED_EXACT_MONOTONE_GRID_DP',checks=checks,pins=pins,
 bounds=dict(first=100,minimum=70,maximum=100,degree=19,error_strictly_below='8/3'),
 model='Complex products only: 2 coordinates, rM then exact shift, Lv witness; M(n,3)=15n+7.',
 layer_sizes=layer_sizes,transitions=transitions,final_states=len(states),
 feasible_costs=len(best),pareto_profiles=frontier,reserve_choices=choices,
 comparisons=dict(uniform100=uniform,root_linear_profile=root_profile),
 scope='No coefficients, tables, quotient outputs, functions, builds, timings or runtime winner.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps(dict(status=out['status'],checks=checks,transitions=transitions,
 frontier=len(frontier),minimum=frontier[0]['product_macro_events'],grid=frontier[0]['grid'],
 reserve=frontier[0]['reserve_in_u'],linear=root_profile['product_macro_events'])))
