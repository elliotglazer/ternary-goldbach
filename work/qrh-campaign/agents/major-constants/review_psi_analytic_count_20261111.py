"""Independent rational arithmetic for the analytic count audit.

No imports from the author checker; no zeta calls or zero data. Logarithms use
the atanh series with a positive geometric remainder, independently of the
author's exponential-inversion enclosures. Analytic soundness is in the note.
"""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json, hashlib

def ceilf(x):return -(-x.numerator//x.denominator)
def rounded(x):return str(F(ceilf(x*10**12),10**12))
def atan(x,n=85):
    s=sum(((-1)**j*x**(2*j+1)/F(2*j+1) for j in range(n)),F(0))
    last=(-1)**n*x**(2*n+1)/F(2*n+1)
    return min(s,s+last),max(s,s+last)
al,au=atan(F(1,5));bl,bu=atan(F(1,239))
piL=16*al-4*bu;piU=16*au-4*bl
assert F('3.14159265358979')<piL<piU<F('3.14159265358980')

def logunit(x,n=110):
    assert 1<=x<=2
    z=(x-1)/(x+1)
    lower=2*sum((z**(2*j+1)/F(2*j+1) for j in range(n)),F(0))
    upper=lower+2*z**(2*n+1)/(F(2*n+1)*(1-z*z))
    return lower,upper
l2,u2=logunit(F(2))
def logbound(x):
    x=F(x); assert x>=1
    k=0
    while x>2:x/=2;k+=1
    l,u=logunit(x)
    return l+k*l2,u+k*u2
def expbound(x,n=55):
    assert 0<=x<n+2
    terms=[x**j/F(factorial(j)) for j in range(n+1)]
    lower=sum(terms,F(0))
    upper=lower+terms[-1]*x/F(n+1)/(1-x/F(n+2))
    return lower,upper

lrL,lrU=logbound(F(19,15));l48L,l48U=logbound(48)
assert lrL>F(2,9) and l48U<4
assert F('1503.9')/F('1498.1')<2 and 41<2*1500
assert F(1,3)+F(3,16*1500)<F(3,8)  # gamma error / pi <1/8, pi>3
assert 18+F(13,8)<20

a=1500;T=10**6
laL,laU=logbound(a);ltL,ltU=logbound(T)
lcL,_=logbound(2*piL);_,lcU=logbound(2*piU)
b0L=((ltL-lcU)**2-(laU-lcL)**2)/(4*piU)+(laL-lcU-1)/(2*piU)+F(7,8*a)
b0U=((ltU-lcL)**2-(laL-lcU)**2)/(4*piL)+(laU-lcL-1)/(2*piL)+F(7,8*a)
epL,epU=expbound(F('.035'))
budgetL=a*(24/(1+epU)-2-b0U)
budgetU=a*(24/(1+epL)-2-b0L)
assert F('69.5')<budgetL<budgetU<F('69.56')
rows=[]
for A,B,cap in [(4,10,'23.965'),(5,10,'23.976'),(6,10,'23.987'),(7,10,'23.999'),(5,20,'23.990')]:
    lower=(1+epL)*(2+b0L+(A*(laL+1)+B)/a)
    upper=(1+epU)*(2+b0U+(A*(laU+1)+B)/a)
    assert lower<upper<F(cap)<24
    rows.append({'A':A,'B':B,'upper_rounded_1e12':rounded(upper),'cap':cap})

# Independent low-degree Binet numerator checks. Later coefficients have
# closed forms (n-2)/n! and (n-3)(n-4)/n!, positive in their stated ranges.
for n in range(5):
    lower=-F(2,factorial(n))+(F(1,factorial(n-1)) if n>=1 else 0)
    lower+=2 if n==0 else (1 if n==1 else 0)
    assert lower==(0 if n<3 else F(n-2,factorial(n)))
    upper=F(12,factorial(n))-(F(6,factorial(n-1)) if n>=1 else 0)+(F(1,factorial(n-2)) if n>=2 else 0)
    upper-=12 if n==0 else (6 if n==1 else (1 if n==2 else 0))
    assert upper==0

out={'status':'independent exact scalar review only; no analytic or finite spectral theorem is machine-proved',
     'budget_lower_rounded_down':str(F((budgetL*10**12).numerator//(budgetL*10**12).denominator,10**12)),
     'budget_upper_rounded':rounded(budgetU),'moment_bounds':rows,
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
