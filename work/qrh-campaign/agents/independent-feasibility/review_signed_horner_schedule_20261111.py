"""Independent fixed-schedule envelope/count reconstruction; no numerical values."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
B=ROOT/'work/qrh-campaign/agents'
pins={
'work/qrh-campaign/agents/moebius/SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md':'531DD23307CED3ED958198C750393D933287809B9E42EF738888370AA4DE4474',
'work/qrh-campaign/agents/moebius/signed_horner_schedule_costs_20261111.py':'82BDFCBDA7A905808EF404EFD4FE36BBDC688E14C23E194CE2B1DF89C04A5602',
'work/qrh-campaign/agents/moebius/signed_horner_schedule_costs_20261111.json':'0DF6FF38D7F14A9C3596423BE109E5EEC6CAF18E031F4329B907E43F5A60FF37'}
saved=json.loads((B/'moebius/signed_horner_schedule_costs_20261111.json').read_text())
prior=json.loads((B/'moebius/fixed_horner_degree_envelope_costs_20261111.json').read_text())
pins.update(saved['pins']);checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def cap(x):
 k=x.numerator.bit_length()-x.denominator.bit_length()
 if Q(2)**k<=x:k+=1
 ck(Q(2)**(k-1)<=x<Q(2)**k)
 return k
def byte(k):return max(1,(k+7)//8)
def add(k):return 2*byte(k)+1
def mul(a,b):
 m,n=sorted((byte(a),byte(b)))
 return m*(5*n+2)+1
results={}
for band,profiles in prior['results'].items():
 results[band]={}
 for name,p in profiles.items():
  results[band][name]={}
  for mode in ('uncancelled','guaranteed_even_cancellation'):
   sr=saved['results'][band][name][mode];P=A=sh=dist=0
   by={k:0 for k in ('residual_add','range_add','guard_add','coefficient_add')}
   for old,new in zip(p['stages'],sr['rows']):
    j=old['stage'];bi=old['input_grid'];bo=old['output_grid'];delta=bo-bi
    t=0 if mode=='uncancelled' else min(1,delta)
    M=Q(old['input_accumulator_norm_cap'])*2**bi
    L=Q(old['rounded_product_norm_cap'])*2**bo
    coef=Q(old['coefficient_norm_cap'])*2**bo
    prod=132900*M;X=prod*2**(delta-t);v=Q(531600,2**t);V=L*v
    raw={'product':prod,'aligned_X':X,'Lv':V,'residual':X+V,
         'range_add':2*(X+V)+v,'coefficient_sum':L+coef}
    ck(new['raw_caps']=={k:str(x) for k,x in raw.items()})
    widths={'residual_add':cap(X+V),'range_add':cap(2*(X+V)+v),
            'guard_add':22-t,'coefficient_add':cap(L+coef)}
    ck(widths==new['magnitude_bit_caps'])
    ck(2*v<2**(21-t) and byte(22-t)==3)
    ck(2*((2**(21-t))-1)+1<2**(22-t))
    cost=2*(mul(18,cap(M))+mul(20-t,cap(L)))
    ck(cost==new['product_events']);P+=cost
    for k,w in widths.items():
     a=2*add(w);ck(a==new['complex_add_template_events'][k]);by[k]+=a;A+=a
    ck(new['shifts'][0]['input_magnitude_bits']==cap(prod))
    ck(new['shifts'][0]['distance']==delta-t)
    ck(new['shifts'][1]['input_magnitude_bits']==cap(X+V))
    ck(new['shifts'][1]['distance']==1)
    sh+=2*bool(delta-t);dist+=2*(delta-t)
   ck((P,A)==(sr['product_template_events'],sr['add_template_events']))
   ck(by==sr['add_events_by_kind'])
   ck(sr['alignment_shift_instances']==sh and sr['alignment_shift_bit_distance']==dist)
   ck(sr['real_product_instances']==19*2*2)
   ck(sr['natural_add_template_instances']==19*2*4)
   ck(sr['signed_add_bridge_instances']==19*2*3)
   ck(sr['signed_product_bridge_instances']==19*2*2)
   ck(sr['nearest_range_implication_instances']==19*2)
   ck(sr['residual_doubling_instances']==19*2)
   results[band][name][mode]=[P,A]
for x in saved['comparisons']:
 old=results[x['band']][x['old']][x['mode']];new=results[x['band']][x['new']][x['mode']]
 ck(x['product_reserve']==old[0]-new[0])
 ck(x['addition_reserve']==old[1]-new[1])
 ck(x['sum_reserve']==sum(old)-sum(new))
out={'status':'PASS_SIGNED_SCHEDULE_CONDITIONAL_MODEL','checks':checks,'pins':pins,'results':results,
 'scope':'Raw envelopes and exact template metadata only; no author execution, coefficient values, optimization or builds.'}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
