"""Exact P3 verifier. Reads rational coefficients; no LP or floating arithmetic accepted."""
from fractions import Fraction as F
from pathlib import Path
from math import factorial
import json
H=Path(__file__).resolve().parent
r=json.loads((H/'resume_p3_exact_kernel_20261111.json').read_text())
d,m=r['d'],r['m']; c={int(j):F(v) for j,v in r['coeff'].items()}
assert d==24 and m==72 and len(c)==45
assert all(1<=j<=m for j in c)
assert sum(v*F(j,d) for j,v in c.items())==1
points=sorted({F(0)}|{F(d*i,j) for j in range(1,m+1) for i in range(1,j+1)})
def kernel(u):return sum(v*(F(j,d)*u).__floor__() for j,v in c.items())
for u in points:assert kernel(u)<=(0 if u<1 else u)
for a,b in zip(points,points[1:]):assert kernel((a+b)/2)==kernel(a)
assert sum(v*j for j,v in c.items())==24
# Generate proposed log boxes by rational atanh, then ACCEPT them only after
# replaying the existing Small.chkLow / Small.chkStep rational definitions.
def logbox(q):
 k=0
 while q>=2:q/=2;k+=1
 def series(z):
  t=(z-1)/(z+1);s=2*sum(t**(2*i+1)/F(2*i+1) for i in range(40))
  return s,s+2*t**81/F(81)/(1-t*t)
 a,b=series(q);l,h=series(F(2));return a+k*l,b+k*h
D=10**6
EL=F(27182818283,10**10);EH=F(27182818286,10**10)
def t12(f):return sum(f**i/F(factorial(i)) for i in range(12))
def low(n,j):
 a,b=divmod(n,D);f=F(b,D)
 return EH**a*(t12(f)+f**12*F(13,12*factorial(12)))<=j
def high(n,j):
 a,b=divmod(n,D);return j<EL**a*t12(F(b,D))
boxes={}
for j in sorted(set(c)|{24}):
 lo,hi=logbox(F(j));L=(lo*D).__floor__();U=L+1
 assert low(L,j) and high(U,j),(j,L,U)
 boxes[j]=(L,U)
S=sum(v*F(j,d)*F(boxes[j][0] if v>=0 else boxes[j][1],D) for j,v in c.items())-F(boxes[24][1],D)
B=sum(abs(v) for v in c.values())
assert S>=F('0.2665') and B<=F('5.51')
assert high(1100000,3) and high(9211000,10000)
error=F('5.51')*F('11.311')/10000
constant=1-F('.2665')+error+F(1,10000)
assert constant==F('.739832361') and constant<F('.74')
out={'denominator':D,'log_boxes':{str(j):list(v) for j,v in boxes.items()},'S_certified_lower':str(S),'B_exact':str(B),'integer_constant':str(constant),'safe_margin':str(F('.74')-constant)}
(H/'resume_p3_log_certificate_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'coefficient_count':len(c),'breakpoints_including_zero':len(points),'log_box_count':len(boxes),'S_lower':str(S),'B':str(B),'integer_constant':str(constant),'safe_margin':str(F('.74')-constant)},indent=2))
