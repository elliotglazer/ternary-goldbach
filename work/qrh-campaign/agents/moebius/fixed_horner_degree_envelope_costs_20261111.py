"""Three fixed profiles; rational envelope/byte-template metadata only."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AGENTS=HERE.parent
PROFILES={
 'uniform100':[100]*20,
 'root_linear':[100,100]+list(range(98,80,-1)),
 'fixed_15442':[100,100,100,100,97,95,95,95,89,87,87,87,81,79,79,79,71,71,71,71]}
PINS={
 'work/qrh-campaign/agents/major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
 'work/qrh-campaign/agents/prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
 'work/qrh-campaign/agents/prime-estimates/stored_hurwitz_degree_bounds_20261111.py':'1F0D78DF0CF364A68DEE066D10CBA66C7B192A9C231AAB55B5B458A80B0BE6F5',
 'work/qrh-campaign/agents/prime-estimates/stored_hurwitz_degree_bounds_20261111.json':'E947C32ED8EA30BA14ED64A7DFF83AA1C8E3F3F222AAD1AD8DAA8484013781BE',
 'work/qrh-campaign/agents/prime-estimates/OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md':'A27CD526DB41C599F43912626827062EDC454F887A722782FF3953BE5BFFCE29',
 'work/qrh-campaign/agents/prime-estimates/optimize_degree_horner_grids_20261111.json':'9BA037D7AAFB7A0F053C109ABD9751112B586805236A14D9467EFD29B32871CE',
 'work/qrh-campaign/agents/independent-feasibility/REVIEW_OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md':'A9D0D867D68FE902E0270A988DCED8E1D2A0B711EF9F4A99A2EEB24ABCA92A0B',
 'work/qrh-blueprint/DEGREE_DEPENDENT_HORNER_GRID_PROPOSAL_2026-11-11.md':'0249787E3EC22DAC609C28FE62CE847A8389CDB6D81ADD5A65D783A872A5DE12',
 'work/qrh-campaign/agents/prime-estimates/REVIEW_DEGREE_DEPENDENT_HORNER_GRID_2026-11-11.md':'D475972DB3EBDEC46D1AAB5DC5D4CBD7D7C157936E333ECE46737F45C34DC5E9',
 'work/qrh-campaign/agents/audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md':'84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C',
 'work/qrh-campaign/agents/moebius/REVIEW_B100_PRODUCT_ONLY_HORNER_2026-11-11.md':'1C1902623E32D7D565A3173FE852E4B4340A154EC71AE6F462196C7CAA65AD7A',
 'work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md':'3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def q(x):return str(x)
def strict_power(x):
 ck(x>0)
 e=0
 while F(2)**e<=x:e+=1
 while F(2)**(e-1)>x:e-=1
 ck(F(2)**(e-1)<=x<F(2)**e)
 return e
def bytes_for(bits):return max(1,(bits+7)//8)
def mul_cost(a,b):
 m,n=sorted((bytes_for(a),bytes_for(b)),reverse=True)
 return 5*m*n+2*n+1
def main():
 for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
 sourcepath=AGENTS/'prime-estimates/stored_hurwitz_degree_bounds_20261111.json'
 source=json.loads(sourcepath.read_text(encoding='utf-8'))
 # Reconstruct the supplied rational envelopes without importing its producer.
 u=F(1,2**100);ut=F(1,2**110);rem=F(1,2**116)
 W=4*u+330*ut;flat=2**27*(u/4+330*ut)
 result={}
 for band in ('first_four','final'):
  Z=[]
  for j,row in enumerate(source['cohorts'][band]):
   if band=='first_four':
    ideal=F(5170)+rem if j==0 else 6*F(5,4)**j/factorial(j)
    numeric=min(4**j*W,flat)
   else:
    ideal=F(9023,2)+rem if j==0 else F(15,2)*F(7,8)**j/factorial(j)
    numeric=u
   ck(ideal==F(row['ideal_finite_polynomial_bound']))
   ck(numeric==F(row['numerical_coefficient_error_bound']))
   Z.append(ideal+numeric)
   ck(Z[-1]==F(row['stored_center_norm_bound']))
  result[band]={}
  for name,b in PROFILES.items():
   ck(len(b)==20 and b[0]==100 and all(b[j]>=b[j+1]>=70 for j in range(19)))
   e=[F(3,4)*F(2)**(-x) for x in b]
   coeff=[Z[j]+e[j] for j in range(20)]
   acc=[F(0)]*20;prod=[F(0)]*19
   acc[19]=coeff[19]
   for j in range(18,-1,-1):
    prod[j]=acc[j+1]/4+e[j]
    acc[j]=coeff[j]+prod[j]
   err=sum((2 if j<19 else 1)*e[j]*F(1,4)**j for j in range(20))/u
   ck(err<F(8,3))
   stages=[]
   for j in range(18,-1,-1):
    delta=b[j]-b[j+1]
    M=acc[j+1]*2**b[j+1];L=prod[j]*2**b[j]
    mb,lb=strict_power(M),strict_power(L)
    cb=strict_power(coeff[j]*2**b[j]);ab=strict_power(acc[j]*2**b[j])
    ck(mb>=1 and lb>=1)
    rprod=132900*M
    variants={}
    for label,t in [('uncancelled',0),('guaranteed_even_cancellation',min(delta,1))]:
     vcap=F(531600,2**t)
     X=rprod*2**(delta-t);LV=L*vcap
     variants[label]=dict(cancelled_bits=t,remaining_alignment_bits=delta-t,
       divisor_magnitude_bits=20-t,
       shifted_numerator_signed_bits=strict_power(X)+1,
       witness_product_signed_bits=strict_power(LV)+1,
       raw_residual_signed_bits=strict_power(X+LV)+1,
       doubled_raw_residual_signed_bits=strict_power(2*(X+LV))+1,
       complex_product_template_events=2*(mul_cost(18,mb)+mul_cost(20-t,lb)))
    ck(variants['uncancelled']['complex_product_template_events']==variants['guaranteed_even_cancellation']['complex_product_template_events'])
    oldM=b[j+1]+(16 if j==18 else 17);oldL=b[j]+15
    stages.append(dict(stage=j,input_grid=b[j+1],output_grid=b[j],alignment_bits=delta,
       coefficient_norm_cap=q(coeff[j]),input_accumulator_norm_cap=q(acc[j+1]),
       rounded_product_norm_cap=q(prod[j]),output_accumulator_norm_cap=q(acc[j]),
       input_magnitude_bits=mb,rounded_product_magnitude_bits=lb,
       input_bytes=bytes_for(mb),rounded_product_bytes=bytes_for(lb),
       coefficient_signed_bits=cb+1,output_add_and_state_signed_bits=ab+1,
       raw_unaligned_product_signed_bits=strict_power(rprod)+1,
       product_variants=variants,
       old_coarse_complex_product_events=2*(mul_cost(18,oldM)+mul_cost(20,oldL))))
   new=sum(r['product_variants']['uncancelled']['complex_product_template_events'] for r in stages)
   old=sum(r['old_coarse_complex_product_events'] for r in stages)
   ck(old=={'uniform100':17632,'root_linear':16252,'fixed_15442':15442}[name])
   result[band][name]=dict(grids=b,error_factor=q(err),error_reserve=q(F(8,3)-err),
      product_template_events=new,old_coarse_product_template_events=old,subtotal_difference=old-new,
      complex_stages=19,real_product_proofs=76,exact_complex_coefficient_additions=19,
      complex_direct_conversions_per_distinct_array=20,extra_final_rounds=0,
      nonzero_alignments=sum(x['alignment_bits']>0 for x in stages),
      total_alignment_bits=sum(x['alignment_bits'] for x in stages),
      guaranteed_cancelled_alignment_bits=sum(x['product_variants']['guaranteed_even_cancellation']['remaining_alignment_bits'] for x in stages),
      initial_coefficient_signed_bits=strict_power(acc[19]*2**b[19])+1,
      maximum_output_state_signed_bits=max(x['output_add_and_state_signed_bits'] for x in stages),stages=stages)
 out=dict(status='PASS_FIXED_PROFILE_RATIONAL_REPRICING',checks=checks,pins=PINS,
   source_receipt_sha256=hashlib.sha256(sourcepath.read_bytes()).hexdigest().upper(),
   model='Ordinary-PA proposed byte product-template events M(m,n)=5mn+2n+1 with smaller row count; all other costs separate.',
   scope='Three fixed profiles/two source-band classes; no optimization, function values, implementation or total-cost adoption.',results=result)
 dest=HERE/'fixed_horner_degree_envelope_costs_20261111.json'
 with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
 print(json.dumps({'checks':checks,'summary':{k:{p:v['product_template_events'] for p,v in row.items()} for k,row in result.items()}}))
if __name__=='__main__':main()
