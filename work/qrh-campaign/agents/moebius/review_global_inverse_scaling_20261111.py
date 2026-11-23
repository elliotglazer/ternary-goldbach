"""Bounded exact scalar checks only; no family enumeration or L evaluations."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent;AGENTS=HERE.parent
PINS={
 'zero-sum/GLOBAL_INVERSE_SCALING_LIMITS_2026-11-11.md':'DDAA08056E5159790D4E7C58BBF7F028538E1C885CF5E8A1E8D0CA0EF4C6C141',
 'major-constants/FAMILY_BATCH_WORKLOAD_MODEL_2026-11-11.md':'3A5444AB295112E86DF0740DB8F4533EC37510A66E41EB0DF0340D16CF82A4E1',
 'major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md':'3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D',
 'zero-sum/c5_global_inverse_candidate_20261111.py':'3F86D07FB695EAD08F677E7C1F9BBDFE9D9BB0FF5F74F269D9B0B3DA0AEB321B',
 'zero-sum/c5_centered_complete_attempt_20261111.py':'01F1E30A4CDA60482BA5DDDFCBCBB04F6BD47B16F4CA955BB54FE3B2DF37FF71'}
for rel,pin in PINS.items():assert hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper()==pin
def ceil(x):return -(-x.numerator//x.denominator)
def height(c):
 qt=c if c%2==0 else 2*c
 hp=200+max(1000,ceil(F(704*1200000,7*qt)))
 h=min(F(hp),F(10**8,c))
 return hp,h,h.numerator//h.denominator+1
def counts(T,n):
 P=32*T+1;J=128*T+94;train=64*T+48;val=128*T+96
 return {'height':T,'primitive_count':n,'poles':P,'models':J,'training_rows':train,
  'validation_rows':val,'matrix_entries':train*(P+1),'rational_jet_products':n*13*P*J,
  'coefficient_slots':n*(P+1)}
pilot=counts(12,3)
assert (pilot['poles'],pilot['models'],pilot['training_rows'],pilot['validation_rows'],pilot['rational_jet_products'])==(385,1630,816,1632,24474450)
examples=[]
for c,n,target in [(4,1,(25000001,800000033,3200000222,1280000144000003808,33280003681600095238)),
                   (5,3,(12068773,386200737,1544803038,298302037056321760,23267558800022121234))]:
 hp,h,T=height(c);row=counts(T,n)
 assert tuple(row[k] for k in ('height','poles','models','matrix_entries','rational_jet_products'))==target
 row.update({'conductor':c,'Hp':hp,'Hcert':str(h)});examples.append(row)
nT=5392479925954;nn=5543640187
slots=32*nT+2*nn;bytecount=16*slots
assert slots==172570444910902 and bytecount==2761127118574432
a=F(111,200);delta=a-F(1,2);outer=a-F(1,4)
assert delta==F(11,200) and 1/delta==F(200,11) and outer==F(61,200)
# The control-neighborhood l1 norm is <=T+5/2<T+3 for every T>=0.
assert F(2)+F(1,4)+F(1,4)==F(5,2)<3
# Exact reflected-counterexample samples verify roots and symmetry factors.
reflected=[]
for eps in [F(1,100),F(1,1000),F(1,1000000)]:
 z=a-eps;zz=1-z
 assert z<a and zz<a and a-zz==F(11,100)-eps
 boundary=eps*(F(11,100)-eps)
 assert (a-z)*(a-zz)==boundary>0
 reflected.append({'epsilon':str(eps),'boundary_value':str(boundary)})
out={'status':'PASS_EXACT_SCALAR_REVIEW','pins':PINS,'pilot':pilot,'height_examples':examples,
 'family_inputs_reused_without_reenumeration':{'sum_nT0':nT,'sum_n':nn},
 'literal_complex_coefficient_slots':slots,'illustrative_16byte_encoding':bytecount,
 'reflected_counterexample_checks':reflected,
 'no_L_evaluations':True,'no_family_scan':True}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
