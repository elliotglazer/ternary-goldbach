"""Exact conditioning/budget checks only; no logs, exponentials or jets evaluated."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

def p2(k): return F(2**k) if k>=0 else F(1,2**(-k))
checks=[]
def ck(label,b):
    assert b,label
    checks.append(label)

delta=p2(-240)
rounding=p2(-224)
G=F(8**30-1,7)
ck('geometric recurrence factor',G==sum(F(8**j) for j in range(30)))
ck('30-order amplification below2^88',G<2**88)
ck('log endpoints below7',F(5,2)**7>303)
ck('normalized power and derivative l1 bound',3**8<2**13)
ck('scaled rising-factor bound',F(33)<F(297,8))
numerator=2**16*delta+rounding
off=G*(numerator+rounding)
at_one=2**11*delta+rounding
ck('off-center P accuracy',off<p2(-134))
ck('at-one P accuracy',at_one<p2(-223))
ck('P budget fits original block',max(off,at_one)<p2(-84))
per_exponential_coefficient=2**15*delta
head=37*per_exponential_coefficient+rounding
half=per_exponential_coefficient/2+rounding
bernoulli=16*per_exponential_coefficient+rounding
residue=head+half+bernoulli+max(off,at_one)+rounding
character=4*residue+rounding
ck('half block meets old target',half<p2(-84))
ck('Bernoulli block meets old target',bernoulli<p2(-84))
ck('full independent coefficient radius',character<p2(-128))

author_error=p2(-76)+F(2**17,factorial(32))
ind_radius=p2(-128)
ck('complete independent ball containment margin',author_error+2*ind_radius<p2(-75))
ck('pole component count',90+90+180==360)
ck('character coefficient count',3*3*30==270)
# Inherited norm budgets, retaining square-padding loss only on analytic tails.
E=p2(-70); Tay=p2(-77); rho=F(1,16)
tube=F(3,2)*(E+Tay)+p2(-75)/(1-rho)+p2(-75)
ck('whole-disk inherited allowance',tube<p2(-68))

def enc(x):
    if isinstance(x,F): return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
    if isinstance(x,dict): return {k:enc(v) for k,v in x.items()}
    if isinstance(x,list): return [enc(v) for v in x]
    return x

data=dict(scope='Scalar-only independent-path accuracy; no pilot execution or data acceptance',
          elementary_error=delta,named_rounding_error=rounding,amplification=G,
          numerator_error=numerator,off_center_P_error=off,at_one_P_error=at_one,
          head_error=head,half_error=half,bernoulli_error=bernoulli,
          residue_error=residue,character_error=character,
          canonical_independent_radius=ind_radius,author_center_error_bound=author_error,
          containment_margin=p2(-75)-author_error-2*ind_radius,
          checks=checks,check_count=len(checks))
Path(__file__).with_suffix('.json').write_text(json.dumps(enc(data),indent=2)+'\n',encoding='utf-8')
print(f'PASS {len(checks)} exact checks; independent complete coefficient radius2^-128 suffices.')
