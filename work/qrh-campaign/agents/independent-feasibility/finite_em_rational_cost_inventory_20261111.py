"""Saved-data sizes, integer denominator bounds and symbolic counts only.

No evaluator imports, elementary functions, models, DFTs, or proof builds.
"""
from pathlib import Path
from fractions import Fraction as F
from math import factorial, lcm
import hashlib,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parent
FILES={
 'integration/small_em_batch_candidate_20261111_01.json':'2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E',
 'independent-feasibility/small_em_batch_independent_replay_20261111_01.json':'2D0CF58A1825978455B029ABE3A73382745955D7EE1A74106A8FF98116A3EE80',
 'integration/small_em_batch_candidate_20261111.py':'23D358590279AA810EAE764D3FEEA0756C51DF8CF0EA6F05B457A192BB82822C',
 'independent-feasibility/review_small_em_batch_prepared_20261111.py':'A6F6A8C78B4DC70F657564D19398ADF2E9F8922B005969B7ABAAA62BFBBC5A9A',
 'integration/FINITE_EM_RATIONAL_CHECKER_BLUEPRINT_2026-11-11.md':'F6B784776E24F767FA3A45C3006394F0E718FF491712077FC9EBDC74EDE92F22',
 'major-constants/FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md':'50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541',
}
files={}
for name,pin in FILES.items():
 raw=(ROOT/name).read_bytes();sha=hashlib.sha256(raw).hexdigest().upper()
 assert sha==pin,name
 files[name]={'sha256':sha,'bytes':len(raw)}
c=json.loads((ROOT/'integration/small_em_batch_candidate_20261111_01.json').read_bytes())
def packed(x):return len(json.dumps(x,separators=(',',':'),ensure_ascii=True).encode('utf-8'))
def stats(x):
 out={'dyadic_count':0,'max_mantissa_bits':0,'min_exponent':None,'max_exponent':None,
      'rational_count':0,'max_numerator_bits':0,'max_denominator_bits':0}
 def walk(v):
  if isinstance(v,dict):
   if set(v)=={'mantissa','exponent'}:
    out['dyadic_count']+=1;out['max_mantissa_bits']=max(out['max_mantissa_bits'],abs(int(v['mantissa'])).bit_length())
    e=v['exponent'];out['min_exponent']=e if out['min_exponent'] is None else min(e,out['min_exponent'])
    out['max_exponent']=e if out['max_exponent'] is None else max(e,out['max_exponent'])
   elif set(v)=={'numerator','denominator'}:
    out['rational_count']+=1
    out['max_numerator_bits']=max(out['max_numerator_bits'],abs(int(v['numerator'])).bit_length())
    out['max_denominator_bits']=max(out['max_denominator_bits'],int(v['denominator']).bit_length())
   else:
    for w in v.values():walk(w)
  elif isinstance(v,list):
   for w in v:walk(w)
 walk(x);return out
sections={k:{'compact_json_bytes':packed(c[k]),'stats':stats(c[k])} for k in
          ('elementary','bins','moments','transforms','main_jets','corrections','g_jets','panels','endpoints')}
target={k:c[k] for k in ('parameters','analytical_budget','g_jets','panels','endpoints')}
j7={'parameters':c['parameters'],'analytical_budget':c['analytical_budget'],
    'g_jets':[c['g_jets'][7]],'panels':[c['panels'][7]],'endpoints':c['endpoints'][7:9]}
zeros=sum(int(x['radius']['mantissa'])==0 for x in c['moments'])
segments=[]
for row in c['bins']:
 if segments and segments[-1]['q']==row['q']:segments[-1]['last_n']=row['n']
 else:segments.append({'q':row['q'],'k':row['k'],'first_n':row['n'],'last_n':row['n']})
df=1
for row in c['corrections']['bernoulli']:df=lcm(df,int(row['factor']['denominator']))
dc=10000
dr=lcm(2,dc**31*df)
dq=dc*dr
denominators=[]
for b,g in [(1025,513)]:
 dmoment=2**(39*b+23)*factorial(15)*factorial(23)
 ddirect=2**(g+15*b)*factorial(15)
 de=2**(15*b)*factorial(15)
 # Full correction exact polynomial*log-exponential convolution*phase,
 # before its final rounding gate. Fresh elementary phase has grid b.
 dcorrection=dq*de*2**b
 denominators.append({'leaf_grid_b':b,'named_gate_grid_g':g,
  'uniform_moment_denominator_bits':dmoment.bit_length(),
  'uniform_direct_main_denominator_bits':ddirect.bit_length(),
  'correction_R_denominator_bits':dr.bit_length(),
  'correction_Q_denominator_bits':dq.bit_length(),
  'log_B_coefficient_common_denominator_bits':de.bit_length(),
  'fresh_phase_full_correction_denominator_bits':dcorrection.bit_length(),
  'FFT_one_stage_denominator_exponent':g+b+1,
  'FFT_no_interstage_rounding_denominator_exponent':g+5*(b+1),
  'exact_contraction_denominator_exponent_before_scale':g+3*23,
  'phase_step_product_denominator_exponent':g+b})
eps=F(1,2**512)
e=F(8193)*eps
for _ in range(7):e=(1+2*eps)*e+3*eps
assert e<2**15*eps
term=(2**15*2**45+2**46)*eps
assert term<2**61*eps
main=1024*term+eps
assert main<2**72*eps
correction=(2**48)*(2**15*2**13+2**13)*eps+eps
assert correction<2**78*eps
assembled=2002*main+correction+eps
assert assembled<2**84*eps<F(1,2**53)
counts={
 'batch':{'main_phases':1024,'fresh_B_phases':8,'moment_contributions':1024*16*24,
  'residual_recurrence_steps':1024*16*23,'main_log_weight_updates':1024*15,
  'normalized_FFTs':16*24,'butterflies':16*24*16*5,'FFT_complex_additions':16*24*32*5,
  'dense_moment_gates':16*24*32,'FFT_stage_output_gates':16*24*32*5,
  'exact_Horner_final_gates':8*16,'correction_gates':8*16,'assembly_gates':8*16,
  'total_named_gates_exact_Horner':16*24*32+16*24*32*5+3*8*16,
  'total_named_gates_24_Horner_updates':16*24*32+16*24*32*5+27*8*16},
 'direct_fresh':{'complex_phase_certificates':8*1025,'main_coefficient_contributions':8*1024*16,
  'main_derivative_recurrence_steps':8*1024*15},
 'direct_phase_reuse':{'complex_base_and_step_certificates':2*1025,
  'phase_recurrence_products':7*1025,'phase_output_gates_including_base':8*1025,
  'main_log_power_recurrence_steps':1024*15,'B_log_power_recurrence_steps':15,
  'main_coefficient_contributions':8*1024*16,'nontrivial_complex_real_products':8*1024*15,
  'main_sum_gates':8*16,'correction_gates':8*16,'assembly_gates':8*16,
  'total_named_gates':8*1025+3*8*16},
 'shared':{'logs_including_exact_log1':1025,'Bernoulli_factors':16,
  'correction_multiplications_upper':8*((3*16+2)*16+16*17//2),
  'rational_image_Horner_complex_products':17*15,'rational_image_Horner_complex_adds':17*15,
  'rational_image_reciprocals':17}}
out={'scope':'Static saved-data inventory and exact integer symbolic cost/denominator checks only. No evaluator imports or analytic/model/transform computations.',
 'files':files,'sections':sections,'whole_target_compact_json_bytes':packed(target),
 'j7_slice_compact_json_bytes':packed(j7),'target_stats':stats(target),'j7_stats':stats(j7),
 'moment_zero_claims':zeros,'moment_nonzero_claims':len(c['moments'])-zeros,
 'saved_bin_segments':segments,'bin_counts':c['elementary']['bin_counts'],
 'factor_common_denominator':str(df),'factor_common_denominator_bits':df.bit_length(),
 'denominator_designs':denominators,'symbolic_counts':counts,
 'direct_phase_reuse_scalar_checks':{'status':'PASS','phase_bound':'2^15*epsilon',
   'main_bound':'2^72*epsilon','correction_bound':'2^78*epsilon','assembled_bound':'2^84*epsilon',
   'epsilon':'2^-512'},
 'qualification':'Compact JSON sizes are encodings of existing target values, not proof-term bytes or new rational witnesses. Denominator bounds are for the explicitly specified exact-center schedules.'}
HERE.joinpath('finite_em_rational_cost_inventory_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:out[k] for k in ('whole_target_compact_json_bytes','j7_slice_compact_json_bytes','moment_zero_claims','moment_nonzero_claims','saved_bin_segments','denominator_designs','symbolic_counts')},indent=2))
