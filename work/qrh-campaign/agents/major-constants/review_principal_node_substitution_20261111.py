"""Exact finite composition diagnostics; no theta, xi, or quadrature evaluated."""
from fractions import Fraction as F
from math import factorial, comb
from pathlib import Path
import json

checks=0
h=F(1,3)
for j in range(8):
    for k in range(-3,4):
        v=k*h
        # Rational stand-ins suffice for a universal product-error identity.
        w=h*v**j/factorial(j)*F(2)**k
        wh=w+F(k-j,1000)
        p=F(k+2,11)
        P=p+F(j-k,10000)
        assert w*P-wh*p == w*(P-p)+(w-wh)*p
        checks+=1
        if k==0:
            assert w==(h if j==0 else 0)
            checks+=1

# Normalized Taylor coefficients of arbitrary rational polynomials.
for degree in range(8):
    a=[F((-1)**m,m+1) for m in range(degree+1)]
    center=F(2,7)
    z=F(-3,11)
    coefs=[sum((a[m]*comb(m,j)*center**(m-j) for m in range(j,degree+1)),F(0)) for j in range(degree+1)]
    assert sum((coefs[j]*z**j for j in range(degree+1)),F(0)) == sum((a[m]*(center+z)**m for m in range(degree+1)),F(0))
    checks+=1

# Logarithmic derivative of exp(a*u-q*exp(2u)) is a-2*q*exp(2u).
assert 2-2*F(1)==0
assert 4-2*F(2)==0
assert 4-2*F(3,2)>0  # point-tail threshold is insufficient for derivative tail
checks+=3

for d in range(8):
    for rho in [F(0),F(1,4),F(2,3)]:
        assert sum((rho**j for j in range(d+1)),F(0))+rho**(d+1)/(1-rho)==1/(1-rho)
        checks+=1

out={'status':'PASS','checks':checks,
     'scope':'Rational product-error identities, normalized Taylor algebra, monotonicity thresholds and geometric remainder only. No analytic function or spectral samples.'}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
