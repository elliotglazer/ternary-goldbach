"""Exact scalar witnesses for a paper bound; no spectral/analytic evaluation."""
from fractions import Fraction as F
from pathlib import Path
from math import factorial
import json

checks = {}
def check(name, proposition):
    assert proposition, name
    checks[name] = True

def exp_bounds(x, n):
    # Positive rational Taylor sum; all subsequent ratios <= x/(n+2).
    lower = sum((x**k / factorial(k) for k in range(n+1)), F(0))
    first = x**(n+1) / factorial(n+1)
    ratio = x / (n+2)
    check('tail_ratio_'+str(x)+'_'+str(n), 0 <= ratio < 1)
    return lower, lower + first/(1-ratio)

l, r, R, c = F(3,4), F(11,10), F(6,5), F(5,4)
check('geometry', 0 < l < r < R < c and c-l==F(1,2) and c-R==F(1,20))
check('disk_growth', F(3,2)/(c-R)*(1+(c+R)/50)==F(3147,100)<32)
check('center_integral_bound', 1+1/(c-1)==5)
elo,ehi=exp_bounds(F(7,15),12)
check('log_8_over_5_lower', ehi<F(8,5))
elo,ehi=exp_bounds(F(7,6),12)
check('log_16_over_5_upper', elo>F(16,5))
elo,ehi=exp_bounds(F(5,4),12)
check('log_22_over_7_upper', elo>F(22,7))
elo,ehi=exp_bounds(F(1),5)
check('e_lower', elo>F(27,10))
check('center_log_budget', F(27,10)**7>320*F(22,7))
check('inner_factor_budget', l*(1+F(7,6))/F(7,15)==F(195,56)<F(7,2))
check('outer_factor_budget', l*(1+1/F(7,15))==F(33,14)<F(7,2))
check('harmonic_budget', 2*r*F(5,4)-l==2<F(7,2))
intercept=F(7,2)*7+F(148,125)
check('lower_intercept', intercept==F(6421,250)<26)
check('lower_slope', F(7,2)-l==F(11,4))
check('turing_intercept', 10*F(157,50)>26+F(1717,500))
check('turing_slope', F(9,8)*F(157,50)>F(11,4)+F(3,4))
b=10+F(9,8)*18
check('allowance_at_18', b==F(121,4))
check('conditional_h50', F(2)-F(1,2)-2*b/50==F(29,100)>0)
# Rational derivative numerator for convexity: y/(1-y)^2 increases on [0,1).
# Its derivative is (1+y)/(1-y)^3 > 0; positivity is analytic, not sampled here.
receipt={'status':'PASS_EXACT_SCALARS','checks':checks,'number_of_checks':len(checks),
         'allowance_at_Z18':str(b),'conditional_h50_D_half_surplus':str(F(29,100)),
         'scope':'Rational Taylor witnesses and algebra only; complex-analysis proof is in the note.'}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:
    f.write(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'status':receipt['status'],'checks':len(checks)}))
