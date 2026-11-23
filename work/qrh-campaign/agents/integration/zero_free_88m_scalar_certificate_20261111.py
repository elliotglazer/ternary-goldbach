"""Rational witnesses for one zero-free-region threshold; no function values."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/ternary-goldbach/TernaryGoldbach/Explicit'
checks={}
values={}
def ck(k,x):
    assert x,k
    checks[k]=True
def val(k,x):
    x=Q(x)
    values[k]={'numerator':str(x.numerator),'denominator':str(x.denominator)}
    return x
H=Q(88_000_000)
L0=Q('18.29')
sigma=Q('1.01695')
kl=Q('.4471')
ku=Q('.46235')
q=Q(29,100)
term=Q(1)
P=Q(1)
for n in range(1,11):
    term*=q/n
    P+=term
nextterm=term*q/11
exp_q_upper=P+nextterm/(1-q/12)
exp_L_upper=val('exp_L0_rational_upper',Q('2.7182818286')**18*exp_q_upper)
ck('log_floor_witness',exp_L_upper<H)
ck('beta_gt_point95',1/(11*L0)<Q('.05'))
ck('sigma_upper',1+Q('.31')/L0<sigma)
ck('sigma_domain',sigma<Q('1.02')<Q('1.6181'))
ck('stechkin_domain',Q('.5')**2+Q('1.1181')**2>Q('1.5'))
ck('kappa_lower',kl*Q('1.1181')<Q('.5'))
ck('kappa_upper',(sigma-Q('.5'))/Q('1.1181')<ku)
ck('kappa_below_one',0<kl<ku<1)
ck('tiny_terms',Q('7.5')/H**2<Q(1,10**15))
ck('inverse_sigma',Q('.9833')*sigma<1)
ck('inverse_half_sigma',Q('.6629')*(sigma/2+1)<1)
ck('log_sigma_domain',sigma/2+2<Q('2.5085'))
ck('zero_den_upper',Q('.31')+Q(1,11)<Q('.40091'))
ck('zero_pole_lower',Q('2.4943')*Q('.40091')<1)
e1u=(1/Q('1.6181')+1/Q('.6181')-Q('1.1447')/2
      +(Q('1.0329')-2/Q('1.6181')-1/Q('1.80905'))/2)
val('E1_upper_from_source_logs',e1u)
ck('E1_upper',e1u<Q('1.2857'))
ck('kappa_E1_upper',ku*Q('1.2857')<Q('.5945'))
zsub=val('subtracted_pole_upper',ku*(1/Q('.6181')+1/Q('1.5681')))
ck('subtracted_pole_upper',zsub<Q('1.043'))
ck('log_multiplier_positive',L0/2+Q('.36')-Q('1.2')/2>0)
c0=val('real_axis_constant',-Q('1.1447')/2+(Q('.9197')-Q('.6629'))/2)
c=val('nonzero_axis_constant',Q('.5529')*(Q('.36')-Q('1.1447')/2)+ku*Q('.20604')/2+Q('.5945')+Q(1,10**15))
slope=val('weighted_slope',18*Q(100,31)+54*Q('.27645')-30*Q('2.4943'))
constant=val('weighted_constant',18*c0+54*c+Q('.27645')*(17*Q('.6932')+6*Q('1.0987')+2*Q('.6932'))+30*(Q('1.043')-Q('.9833')))
ck('negative_slope',slope<0)
R0=val('weighted_upper_at_L0',slope*L0+constant)
val('contradiction_margin',-R0)
ck('strict_contradiction',R0<0)
pins={str((BASE/(n+'.lean')).relative_to(ROOT)).replace('\\','/'):
      hashlib.sha256((BASE/(n+'.lean')).read_bytes()).hexdigest().upper()
      for n in ['ZeroFreeRegion','ZeroFree','XiPartial','PsiLarge','PsiRange1','PsiAsymp']}
out={'scope':'rational witnesses only; no analytic value or zero evaluation',
     'height':88000000,'log_lower_bound':'18.29','checks':checks,'values':values,'pins':pins}
p=Path(__file__).with_suffix('.json')
with p.open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2)
    f.write('\n')
print(json.dumps({'checks':len(checks),'source_pins':len(pins),'output':str(p)}))
