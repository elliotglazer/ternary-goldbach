"""Closed-form rational envelopes and matched integer-price review only."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-campaign/agents'
pins={
'work/qrh-campaign/agents/moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md':'96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3',
'work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.py':'22D456ADE5596011FF01145F384C2FA0A93D86C29E4A8EB97AE2C24FDA1B1162',
'work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.json':'4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9'}
data=json.loads((BASE/'moebius/fixed_horner_degree_envelope_costs_20261111.json').read_text())
pins.update(data['pins']);n=0
def ck(x):
 global n
 assert x
 n+=1
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def cap(x):
 e=x.numerator.bit_length()-x.denominator.bit_length()
 if Q(2)**e<=x:e+=1
 ck(Q(2)**(e-1)<=x<Q(2)**e)
 return e
def digits(w):return max(1,(w+7)//8)
def price(a,b):
 m,k=sorted((digits(a),digits(b)))
 return sum(5*k+2 for _ in range(m))+1
profiles={'uniform100':[100]*20,'root_linear':[100,100]+list(range(98,80,-1)),
'fixed_15442':[100,100,100,100,97,95,95,95,89,87,87,87,81,79,79,79,71,71,71,71]}
u=Q(1,2**100);W=4*u+330*Q(1,2**110);flat=2**27*(u/4+330*Q(1,2**110))
summary={}
for band in ('first_four','final'):
 if band=='first_four':Z=[Q(5170)+Q(1,2**116)+W]+[6*Q(5,4)**j/factorial(j)+min(4**j*W,flat) for j in range(1,20)]
 else:Z=[Q(9023,2)+Q(1,2**116)+u]+[Q(15,2)*Q(7,8)**j/factorial(j)+u for j in range(1,20)]
 summary[band]={}
 for name,b in profiles.items():
  r=data['results'][band][name];ck(r['grids']==b)
  e=[Q(3,4)*Q(2)**(-v) for v in b];C=[z+x for z,x in zip(Z,e)]
  # Expanded finite sums, independent of the author's backward recurrence.
  A=[sum(C[k]*Q(1,4)**(k-j) for k in range(j,20))+sum(e[k]*Q(1,4)**(k-j) for k in range(j,19)) for j in range(20)]
  T=[A[j+1]/4+e[j] for j in range(19)]
  total=0;old=0;remaining=0
  for s in r['stages']:
   j=s['stage'];delta=b[j]-b[j+1]
   ck(Q(s['input_accumulator_norm_cap'])==A[j+1] and Q(s['rounded_product_norm_cap'])==T[j])
   ck(Q(s['coefficient_norm_cap'])==C[j] and Q(s['output_accumulator_norm_cap'])==A[j])
   mi,li=cap(A[j+1]*2**b[j+1]),cap(T[j]*2**b[j])
   ck((mi,li)==(s['input_magnitude_bits'],s['rounded_product_magnitude_bits']))
   ck(s['coefficient_signed_bits']==cap(C[j]*2**b[j])+1)
   ck(s['output_add_and_state_signed_bits']==cap(A[j]*2**b[j])+1)
   base=132900*A[j+1]*2**b[j+1]
   ck(s['raw_unaligned_product_signed_bits']==cap(base)+1)
   for label,t in (('uncancelled',0),('guaranteed_even_cancellation',min(delta,1))):
    v=s['product_variants'][label];x=base*2**(delta-t);y=T[j]*2**b[j]*Q(531600,2**t)
    ck(v['cancelled_bits']==t and v['remaining_alignment_bits']==delta-t)
    ck(v['shifted_numerator_signed_bits']==cap(x)+1)
    ck(v['witness_product_signed_bits']==cap(y)+1)
    ck(v['raw_residual_signed_bits']==cap(x+y)+1)
    ck(v['doubled_raw_residual_signed_bits']==cap(2*(x+y))+1)
    ck(v['complex_product_template_events']==2*(price(18,mi)+price(20-t,li)))
   total+=2*(price(18,mi)+price(20,li));remaining+=delta-min(delta,1)
   old+=2*(price(18,b[j+1]+(16 if j==18 else 17))+price(20,b[j]+15))
  ck(total==r['product_template_events'] and old==r['old_coarse_product_template_events'])
  ck(r['guaranteed_cancelled_alignment_bits']==remaining)
  ck(r['initial_coefficient_signed_bits']==cap(A[19]*2**b[19])+1)
  err=sum((2 if j<19 else 1)*e[j]*Q(1,4)**j for j in range(20))/u
  ck(err==Q(r['error_factor']) and err<Q(8,3))
  ck(Q(r['error_reserve'])==Q(8,3)-err)
  ck(r['maximum_output_state_signed_bits']==114)
  summary[band][name]=total
ck(list(summary['first_four'].values())==[12562,11272,10702])
ck(list(summary['final'].values())==[11872,10552,9970])
out={'status':'PASS_FIXED_SIX_CASE_REPRICING','checks':n,'pins':pins,'summary':summary,
'scope':'Closed-form rational metadata only, no author execution, values, optimization, builds or overall cost adoption.'}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':n,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
