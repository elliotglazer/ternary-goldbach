"""Exact rational replay of the finite regionS certificate.

Uses only Python integer/Fraction arithmetic. The log series remainder and
integer cube-root inequalities are explicit. This is not a Lean proof.
"""
from fractions import Fraction as F
from math import isqrt, factorial
from pathlib import Path
import json

S = 10**18
K = 24

def up(x):
    return F(-((-x.numerator * S) // x.denominator), S)

def down(x):
    return F((x.numerator * S) // x.denominator, S)

def atanh_log(z):
    assert 0 <= z <= F(1, 3)
    power = z
    total = F(0)
    for j in range(K):
        total += 2 * power / (2*j+1)
        power *= z*z
    tail = 2 * power / ((2*K+1)*(1-z*z))
    return total, total+tail

L2, U2 = atanh_log(F(1, 3))

def log_bounds(n):
    assert n >= 1
    k = n.bit_length()-1
    z = F(n-2**k, n+2**k)
    a, b = atanh_log(z)
    return down(k*L2+a), up(k*U2+b)

def cube_floor(n):
    lo, hi = 0, 1 << ((n.bit_length()+2)//3)
    while lo+1 < hi:
        mid = (lo+hi)//2
        if mid**3 <= n:
            lo = mid
        else:
            hi = mid
    assert lo**3 <= n < (lo+1)**3
    return lo

primes = [p for p in range(2,20001)
          if all(p % d for d in range(2,isqrt(p)+1))]
logs = {p:log_bounds(p) for p in primes}
small = [(3,F('1.39953')),(5,F('1.36194')),(7,F('1.3115')),
         (11,F('1.24148')),(13,F('1.21777')),(17,F('1.18326')),
         (19,F('1.17031')),(23,F('1.14988')),(29,F('1.12806')),
         (31,F('1.12235'))]

def raw_gp_upper(p):
    u = cube_floor(p*10**36)
    return up(F(p,p-1)*(1+F(10**24,u*u)))

theta_lo = F(0)
shat_hi = F(0)
G = F(1)
rows = []
for k,p in enumerate(primes,1):
    theta_lo += logs[p][0]
    if theta_lo > 2000:
        excluded = {'k':k,'p':p,'theta_lower_scaled':int(theta_lo*S)}
        break
    shat_hi = up(shat_hi+(logs[3][1]/3 if p==2 else logs[p][1]/p))
    g = next((v for bound,v in small if p<=bound), None)
    G = up(G*(raw_gp_upper(p) if g is None else g))
    kap = F('0.3726')*(max(F('23.8143'),theta_lo)-shat_hi)+F('0.0274177')
    assert kap > 0
    lam = up((F('7.4527')*G/kap)**3)
    assert lam < 20000
    rows.append({'k':k,'p':p,'lambda_upper_scaled':int(lam*S)})

theta_hi = F(0)
g1000 = F(1)
for p in primes:
    theta_hi += logs[p][1]
    assert theta_hi < F('1.039')*p
    if p<=1000:
        g1000 = up(g1000*raw_gp_upper(p))
assert g1000 < 5000
assert F(1,999)+F(1,100) < F('.0017')*log_bounds(1000)[0]

# H(2000)<=.015*2000 reduces to C^3 <= exp(19.8), C=7.4527*5000/(.18*2000).
def exp_lower(x,degree):
    return sum((x**j/F(factorial(j)) for j in range(degree+1)),F(0))

assert (F('7.4527')*5000/(F('.18')*2000))**3 < exp_lower(F('19.8'),20)
assert 2000 < exp_lower(F(20),4)
assert 3 < exp_lower(F(10),1)
assert log_bounds(2000)[0] > 7
assert log_bounds(2000)[1] < 40
assert F(4,3)*(8+F(18,7)) < 15
assert log_bounds(15)[0] > F(93,35)
assert F('1.7882') < exp_lower(F('0.6'),3)

result = {'kind':'exact rational certificate replay; not Lean verification',
          'scale':S,'log_series_terms':K,'finite_cases':len(rows),
          'first_excluded':excluded,'finite_lambda_cap':20000,
          'max_lambda_upper_scaled':max(r['lambda_upper_scaled'] for r in rows),
          'theta_prime_endpoint_checks':len(primes),
          'theta20000_upper_scaled':int(theta_hi*S),
          'gp1000_upper_scaled':int(g1000*S),
          'scalar_checks':'passed','rows':rows}
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k!='rows'},indent=2))
