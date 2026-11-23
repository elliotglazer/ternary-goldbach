"""Exact metadata for six fixed signed Horner schedules; no function values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PINS={
 'work/qrh-campaign/agents/moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md':'96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3',
 'work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.py':'22D456ADE5596011FF01145F384C2FA0A93D86C29E4A8EB97AE2C24FDA1B1162',
 'work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.json':'4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9',
 'work/qrh-campaign/agents/independent-feasibility/REVIEW_FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md':'57D7DEDBA4D5497861DD641F4CC68416CA89EEAD0358F2151DA005ABCE319468',
 'work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md':'3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def bits(x):
 ck(x>0)
 w=0
 while F(2)**w<=x:w+=1
 while F(2)**(w-1)>x:w-=1
 ck(F(2)**(w-1)<=x<F(2)**w)
 return w
def nbytes(w):return max(1,(w+7)//8)
def add(w):return 2*nbytes(w)+1
def main():
 for path,pin in PINS.items():ck(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==pin)
 prior=json.loads((HERE/'fixed_horner_degree_envelope_costs_20261111.json').read_text(encoding='utf-8'))
 results={}
 for band,profiles in prior['results'].items():
  results[band]={}
  for pname,p in profiles.items():
   cases={}
   for mode in ('uncancelled','guaranteed_even_cancellation'):
    rows=[]
    for s in p['stages']:
     j=s['stage'];bi=s['input_grid'];bo=s['output_grid']
     delta=s['alignment_bits'];t=s['product_variants'][mode]['cancelled_bits']
     m=F(s['input_accumulator_norm_cap'])*2**bi
     ell=F(s['rounded_product_norm_cap'])*2**bo
     coeff=F(s['coefficient_norm_cap'])*2**bo
     v=F(531600,2**t)
     rawproduct=132900*m
     x=rawproduct*2**(delta-t)
     lv=ell*v
     r=x+lv
     sraw=2*r+v
     a=ell+coeff
     ck(a==F(s['output_accumulator_norm_cap'])*2**bo)
     # S,C independently range-restricted to <2^(21-t), before equality.
     # Their sum with carry 1 is <2^(22-t), fitting three bytes.
     guard_operand_bits=21-t
     guard_raw_bits=guard_operand_bits+1
     ck(2*v<F(2)**guard_operand_bits)
     ck(nbytes(guard_raw_bits)==3)
     widths={'residual_add':bits(r),'range_add':bits(sraw),
             'guard_add':guard_raw_bits,'coefficient_add':bits(a)}
     events={k:2*add(w) for k,w in widths.items()}
     ck(widths['residual_add']+1==s['product_variants'][mode]['raw_residual_signed_bits'])
     ck(widths['coefficient_add']+1==s['output_add_and_state_signed_bits'])
     rows.append(dict(stage=j,input_grid=bi,output_grid=bo,
       cancellation_bits=t,alignment_bits=delta-t,
       product_events=s['product_variants'][mode]['complex_product_template_events'],
       magnitude_bit_caps=widths,complex_add_template_events=events,
       raw_caps={'product':str(rawproduct),'aligned_X':str(x),'Lv':str(lv),
                 'residual':str(r),'range_add':str(sraw),'coefficient_sum':str(a)},
       range_slack_operand_bits=guard_operand_bits,
       shifts=[{'role':'alignment','instances':2,'input_magnitude_bits':bits(rawproduct),'distance':delta-t},
               {'role':'double_residual','instances':2,'input_magnitude_bits':bits(r),'distance':1}]))
    totalP=sum(s['product_events'] for s in rows)
    totalA=sum(sum(s['complex_add_template_events'].values()) for s in rows)
    bykind={k:sum(s['complex_add_template_events'][k] for s in rows) for k in rows[0]['complex_add_template_events']}
    ck(totalP==p['product_template_events'])
    ck(totalA==sum(bykind.values()))
    cases[mode]=dict(product_template_events=totalP,add_template_events=totalA,
        declared_template_event_sum=totalP+totalA,add_events_by_kind=bykind,
        real_product_instances=76,natural_add_template_instances=152,
        signed_add_bridge_instances=114,signed_product_bridge_instances=76,
        nearest_range_implication_instances=38,
        alignment_shift_instances=sum(2 for row in rows if row['alignment_bits']>0),
        alignment_shift_bit_distance=sum(2*row['alignment_bits'] for row in rows),
        residual_doubling_instances=38,
        cancellation_binding_stage_instances=sum(1 for row in rows if row['cancellation_bits']),
        rows=rows)
   results[band][pname]=cases
 comparisons=[]
 for band,profiles in results.items():
  for mode in ('uncancelled','guaranteed_even_cancellation'):
   for old,new in [('uniform100','root_linear'),('uniform100','fixed_15442'),('root_linear','fixed_15442')]:
    a,b=profiles[old][mode],profiles[new][mode]
    comparisons.append(dict(band=band,mode=mode,old=old,new=new,
       product_reserve=a['product_template_events']-b['product_template_events'],
       addition_reserve=a['add_template_events']-b['add_template_events'],
       sum_reserve=a['declared_template_event_sum']-b['declared_template_event_sum']))
 # Symbolic integer coefficient identities for S=2(X-Lv)+v, S+C+1=2v.
 # They reduce exactly to C=v-1-2(X-Lv); no sampled values.
 X,Lv,V=(1,0,0,0),(0,1,0,0),(0,0,1,0)
 S=(2,-2,1,0);C=(-2,2,1,-1)
 ck(tuple(S[i]+C[i]+(1 if i==3 else 0) for i in range(4))==(0,0,2,0))
 out=dict(status='PASS_FIXED_SIGNED_SCHEDULE_METADATA',checks=checks,pins=PINS,
  scope='Exact widths/template counts only; unknown conversion/sign/shift/binding/generation costs retained symbolically.',
  results=results,comparisons=comparisons)
 dest=HERE/'signed_horner_schedule_costs_20261111.json'
 with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
 print(json.dumps({'checks':checks,'summary':{band:{p:{m:(r['product_template_events'],r['add_template_events']) for m,r in cases.items()} for p,cases in ps.items()} for band,ps in results.items()},'comparisons':comparisons}))
if __name__=='__main__':main()
