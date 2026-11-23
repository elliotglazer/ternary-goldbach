"""Single fixed candidate; exact rational certificates, no function evaluation."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
BASE = ROOT / 'work/ternary-goldbach/TernaryGoldbach/Explicit'
names = ['PsiExplicit', 'PsiLarge', 'PsiPlateau', 'PsiPlateau1e8',
         'PsiRange', 'ZetaZeroSums', 'ZeroSumGen']
pins = {str((BASE/(n+'.lean')).relative_to(ROOT)).replace('\\','/'):
        hashlib.sha256((BASE/(n+'.lean')).read_bytes()).hexdigest().upper() for n in names}
H = Q(88_000_000)
K = Q(13,2)
delta = K/H
a = K*delta
checks = {}
values = {}
def ck(k,v):
    assert v, k
    checks[k] = True
def val(k,x):
    x=Q(x)
    values[k]={'numerator':str(x.numerator),'denominator':str(x.denominator)}
    return x
for k,x in [('H',H),('K',K),('delta',delta),('a',a)]: val(k,x)
ck('positive_H_below_3e10',0<H<=30_000_000_000)
ck('delta_bounds',Q(7,100_000_000)<=delta<=Q(1,208))
ck('delta_below_K',delta<=K)
ck('a_below_old',a<=Q(49,100_000_000))
ck('deltaH_eq_K',delta*H==K)
ck('positive_small_exp_argument',0<=delta**2/2+a<=1)
ck('exp_delta2_half_upper',1+delta**2<=Q('1.000001'))
ck('exp_abs_a_half_upper',1+a<=Q('1.000001'))
ck('exp_delta2_eighth_upper',1+delta**2/4<=Q('1.000001'))
ck('exp_delta2_half_plus_a_upper',1+delta**2+2*a<=Q('1.000001'))
line = val('line_majorant',Q('1.000001')*(Q('1.000001')+Q('0.000317'))*2*571)
ck('line_le1143',line<=1143)
ck('sqrt_x_lower_square',Q('3.16e8')**2<=10**17)
vg = val('Vg_majorant',Q('7.6856')*Q('82.6')*Q('1.000001')/delta/Q('2.5066')*(Q('1.000001')/Q('3.16e8')+Q(1,100_000)))
ck('Vg_le37000',vg<=37_000)
ck('c3_dynamic',Q('36.6')*Q('1.2039')>44)
t = val('geometric_t',Q('4.4')*delta**2*H)
r = val('geometric_r_lower',t/(1+t))
tail_factor = val('tail_factor',2*Q('1.000001')/H*(Q('421.2')/r+(Q('73.2')/H)/r**2))
ck('tail_factor_lt5',tail_factor<5)
v = K*K/2
term = Q(1)
partial = Q(1)
for n in range(1,81):
    term *= v/n
    partial += term
val('exp_positive_partial_sum_0_through80',partial)
g = val('g_upper',Q(7,10**10))
ck('exp_negative_certificate',partial*g>1)
tail = val('tail_absolute_upper',5*g)
den = val('unsmoothing_den_lower',1-2*g)
ck('den_positive',den>0)
e = delta**2/2+a
eu = val('exp_shift_upper',1+e+e**2)
up = val('upper_relative_coefficient',(eu+tail)/den-1)
lo = val('lower_relative_coefficient',a+tail+4*g)
budget = Q(491,10**9)
val('upper_relative_margin',budget-up)
val('lower_relative_margin',budget-lo)
ck('upper_relative_budget',up<budget)
ck('lower_relative_budget',lo<budget)
ck('upper_sqrt_budget',Q(1143)/den<1145)
ck('lower_sqrt_budget',1143<1145)
exp_a = val('exp_a_upper',1+a+a*a)
upconst = val('upper_constant',4*10**10*exp_a+Q(37_000)/den)
loconst = val('lower_constant',2*10**10+37_000)
ck('upper_constant_budget',upconst<42_000_000_000)
ck('lower_constant_budget',loconst<42_000_000_000)
ck('upper_cutoff_domain',10**10*exp_a<=10**17)
ck('lower_cutoff_domain',Q(1,10**7)-1<=-a)
out={'scope':'single fixed candidate; exact rational and finite-polynomial witnesses only',
     'candidate':{'H':88_000_000,'K':'13/2','delta':'13/176000000'},
     'positive_exp_polynomial_degree':80,'checks':checks,'values':values,'pins':pins}
p=Path(__file__).with_suffix('.json')
with p.open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2)
    f.write('\n')
print(json.dumps({'checks':len(checks),'source_pins':len(pins),'output':str(p)}))
