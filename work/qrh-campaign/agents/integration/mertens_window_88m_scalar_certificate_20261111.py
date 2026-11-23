"""Exact single-parameter Mertens window certificate; no function values."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json
ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/ternary-goldbach/TernaryGoldbach'
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
d=Q(1,11_000_000)
val('delta',d)
ck('deltaH8',d*H==8)
ck('small_delta',0<d<1)
ck('exp_delta2_half',1+d*d<Q('1.000001'))
ck('exp_delta2_eighth',1+d*d/4<Q('1.000001'))
ck('exp_mellin32',1+d*d*Q(9,4)<Q('1.000001'))
line=val('line_majorant',Q('1.000001')*(Q('2.7182818286')+1)*1142)
ck('line',line<Q('4246.5'))
ck('tail_exp_prefactor',Q('7.3891')*Q('1.000001')<Q('7.3892'))
t=Q('4.4')*d*d*H
r=val('r_lower',t/(1+t))
ck('c3_dynamic',Q('36.6')*Q('1.2039')>44)
tail=val('tail_majorant',2*Q('7.3892')*Q('1.3e-14')/H*(Q('421.2')/r+Q('73.2')/H/r**2))
ck('tail',tail<Q('3e-13'))
vg=val('Vg_sqrt_coefficient',Q('7.6856')*Q('82.6')*Q('1.000001')*(Q('.3679')+1)/d/Q('2.5066')/10**12)
ck('vertical',vg<Q('.0044'))
ck('total_sqrt_error',Q('4246.5')+Q('.0044')<4247)
g=val('G_upper',Q('1.000001')*(Q('20.0856')-1)/Q('1.5'))
ck('G',g<Q('12.724'))
edge=val('edge_delta_coefficient',Q('1.6488')*(2*Q('1.3863')+8+d))
ck('edge_coefficient',edge<Q('17.77'))
ck('two_edges_fit_old_allowance',2*Q('17.77')*d<Q('3.376e-6'))
ck('B_quarter',Q(1,27**3)+Q('4.92e-7')<Q(1,4))
sqrtcoef=val('final_sqrt_coefficient',4*Q('28.16')+Q(8494)/Q('6.389'))
logcoef=val('final_logcube_coefficient',8+4*Q('12.724')/Q('6.389'))
newconst=val('final_constant',4*Q('9.84e-7')+(Q('3e-13')*20001+4*Q('12.724')*Q('4.92e-7')+2*Q('17.77')*d)/Q('6.389'))
oldedgeconst=val('constant_without_edge_refinement',4*Q('9.84e-7')+(Q('3e-13')*20001+4*Q('12.724')*Q('4.92e-7')+2*Q('21.1')*d)/Q('6.389'))
ck('final_sqrt',sqrtcoef<1443)
ck('final_logcube',logcoef<16)
ck('final_inverse',4*3+1==13)
ck('final_constant',newconst<Q('8.4e-6'))
ck('old_edge_does_not_pass_coefficient_test',oldedgeconst>Q('8.4e-6'))
val('constant_margin',Q('8.4e-6')-newconst)
names=['Prelim/MertensWindow','Prelim/MertensProduct','Prelim/PNTMertens',
       'Explicit/PsiExplicit','Explicit/PsiPlateau','Explicit/PsiPlateau1e8',
       'Explicit/ZetaZeroSums','Explicit/ZeroSumGen']
pins={str((BASE/(n+'.lean')).relative_to(ROOT)).replace('\\','/'):
      hashlib.sha256((BASE/(n+'.lean')).read_bytes()).hexdigest().upper() for n in names}
out={'scope':'rational bounds for Mertens E1 window, retaining explicit local-variation premise',
     'height':88000000,'checks':checks,'values':values,'pins':pins}
p=Path(__file__).with_suffix('.json')
with p.open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2)
    f.write('\n')
print(json.dumps({'checks':len(checks),'source_pins':len(pins),'output':str(p)}))
