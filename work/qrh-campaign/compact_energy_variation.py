"""Exact polynomial variation bounds for compact squared smoothing.

Research arithmetic, not a Lean certificate. Bernstein convexity bounds the
integral of an absolute polynomial. Dropping exp(-(t-1)^2) increases it.
"""
from fractions import Fraction as F
from math import comb
import json

def add(a,b):
    return [(a[i] if i<len(a) else F(0))+(b[i] if i<len(b) else F(0))
            for i in range(max(len(a),len(b)))]

def mul(a,b):
    c=[F(0)]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): c[i+j]+=x*y
    return c

def deriv(a): return [i*a[i] for i in range(1,len(a))]

def gaussian_deriv(p):
    return add(deriv(p),mul([F(2),F(-2)],p))

def euler_second(p):
    dp=gaussian_deriv(p)
    ddp=gaussian_deriv(dp)
    return add([F(0)]+dp,[F(0),F(0)]+ddp)

def bernstein_abs_integral(p,a,b):
    n=len(p)-1
    c=[sum((p[k]*comb(k,j)*a**(k-j)*(b-a)**j for k in range(j,n+1)),F(0))
       for j in range(n+1)]
    bs=[sum((c[j]*F(comb(i,j),comb(n,j)) for j in range(i+1)),F(0))
        for i in range(n+1)]
    return (b-a)*sum(map(abs,bs),F(0))/(n+1)

def variation(p,parts=64):
    assert p[0]==0
    total=F(0)
    # t^(beta-1) <= 1/t on (0,1), and <=1 on (1,2).
    for j in range(parts):
        total+=bernstein_abs_integral(p[1:],F(j,parts),F(j+1,parts))
        total+=bernstein_abs_integral(p,F(1)+F(j,parts),F(1)+F(j+1,parts))
    return total

P=[F(0)]*6+[F(comb(6,k)*2**(6-k)*(-1)**k) for k in range(7)]
G=mul([F(-1),F(1)],P)
result={}
for name,p in [('h',P),('g',G)]:
    h0=variation(p)
    h2=variation(euler_second(p))
    K=F(15,8)*h0+F(8,9)*h2
    result[name]={'H0_exact':str(h0),'H0_upper':float(h0),
                  'H2_exact':str(h2),'H2_upper':float(h2),
                  'K_exact':str(K),'K_upper':float(K)}
    # Choose deliberately loose rational constants for a later formal proof.
    assert K < (25 if name=='h' else 20)
print(json.dumps(result,indent=2))
