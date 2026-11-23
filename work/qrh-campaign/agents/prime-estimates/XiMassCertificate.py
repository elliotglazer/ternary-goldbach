from fractions import Fraction as F
from math import factorial, isqrt
from pathlib import Path
import json, runpy

HERE=Path(__file__).resolve().parent
model=runpy.run_path(str(HERE.parent/'mellin'/'joint_principal_model.py'))
log_bounds=model['log_bounds']
D=10**6

def t12(f): return sum((f**i/F(factorial(i)) for i in range(12)),F(0))
def chk_low(c,p):
    a,r=divmod(c,D); f=F(r,D)
    return F(27182818286,10**10)**a*(t12(f)+f**12*F(13,12*factorial(12)))<=p

def chk_up(c,p):
    a,r=divmod(c,D); f=F(r,D)
    return p<F(27182818283,10**10)**a*t12(f)

def prime_base(n):
    if n<2:return None
    p=next((p for p in range(2,isqrt(n)+1) if n%p==0),n)
    t=n
    while t%p==0:t//=p
    return p if t==1 else None

primes=[n for n in range(2,2001) if prime_base(n)==n]
nums={p:(log_bounds(p)[0]*D).numerator//(log_bounds(p)[0]*D).denominator for p in primes}
assert all(chk_low(c,p) for p,c in nums.items())
terms=[(n,prime_base(n)) for n in range(2,2001) if prime_base(n)]
S=sum((F(nums[p],D*n*n) for n,p in terms),F(0))
H=sum((F(1,n) for n in range(1,1001)),F(0))
assert F(748547086,10**8)<=H
assert chk_up(6908755,1001)
gamma=F(748547086,10**8)-F(6908755,D)
assert gamma>F(576715,D)
assert S>F(56945,10**5)
W=F(3,2)-F(11447,10000)/2-F(576715,D)/2-F(56945,10**5)
assert W<F(7,100)
print(json.dumps(dict(prime_count=len(primes),finite_prime_power_count=len(terms),finite_sum_lower=float(S),gamma_lower=float(gamma),rounded_mass_upper=float(W),margin=float(F(7,100)-W)),indent=2))
(HERE/'XiMassLogData.txt').write_text(', '.join(f'({p}, {nums[p]})' for p in primes)+'\n',encoding='utf-8')
