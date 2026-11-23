"""Finite scalar certificate for the upper horizontal-log reduction.

No zeta evaluation, prime/zero scan, or analytic theorem oracle is used.
The J<1.184 tail integral and Rademacher bound are separate analytic leaves.
"""
from fractions import Fraction as F
from math import isqrt, factorial
from pathlib import Path
import hashlib,json

scale=10**12
roots=[]
zeta_upper=F(1)  # Integral from256 to infinity of x^(-5/4) is exactly1.
for n in range(1,257):
    r=isqrt(isqrt(n*scale**4))
    assert 0<r and r**4<=n*scale**4<(r+1)**4
    roots.append(r)
    zeta_upper+=F(scale,n*r)
bound=F(4595599709731,10**12)
assert zeta_upper<bound<F(1149,250)
# exp(763/500)>1149/250 implies log(4.596)<1.526.
assert sum(F(763,500)**k/factorial(k) for k in range(21))>F(1149,250)
alpha_integral=F(9,64)
delta=F(81,80000)
assert delta<F(11,10000)
intercept=F(3,4)*F(763,500)+F(148,125)+alpha_integral*delta
old_intercept=F(3,4)*F(763,500)+F(148,125)+alpha_integral*F(11,10000)
assert intercept<old_intercept<F(2911,1250)
assert alpha_integral<F(3,20)
out=dict(status='PASS_EXACT_SCALARS',n=256,scale=scale,fourth_root_lower_numerators=roots,
         zeta_upper_rational=str(bound),log_zeta_upper='763/500',
         coefficient=str(alpha_integral),sharper_intercept=str(intercept),
         original_intercept=str(old_intercept),
         script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
         analytic_leaves_proved=False)
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps({k:v for k,v in out.items() if k!='fourth_root_lower_numerators'},indent=2))
