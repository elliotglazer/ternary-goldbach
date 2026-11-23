"""Exact rational certificates for a ghatY lower-envelope proof.
No Lean compilation. The calculus and existing definition bridges are in the note.
"""
from fractions import Fraction as F
import math,json

def log_bounds(q,n=32):
 q=F(q); k=0
 while q>=2: q/=2;k+=1
 while q<1: q*=2;k-=1
 def unit(v):
  z=(v-1)/(v+1)
  s=2*sum((z**(2*j+1)/F(2*j+1) for j in range(n)),F(0))
  e=2*z**(2*n+1)/F(2*n+1)/(1-z*z)
  return s,s+e
 l,u=unit(q); l2,u2=unit(F(2))
 return (l+k*l2,u+k*u2) if k>=0 else (l+k*u2,u+k*l2)

Y=10**25; eps=F('.000481')+F('1.098e-6')
H5000=sum((F(1,j) for j in range(1,5001)),F(0))
gamma_low=H5000-log_bounds(5001)[1]
assert gamma_low>F('.577')
exp_partial=sum((F('.577')**j/math.factorial(j) for j in range(12)),F(0))
assert exp_partial>F('1.78')
c_lo=F('2.478081'); c_hi=F('2.478088')
log150_lo,log150_hi=log_bounds(150000)
assert log_bounds(log150_lo)[0]>c_lo and log_bounds(log150_hi)[1]<c_hi
F_lo=F('1.78')*c_lo+F('2.50637')/c_hi
sqrtF_lo=F('2.3286'); sqrtq_hi=F('547.723'); logq_lo=F('12.61153')
assert sqrtF_lo**2<=F_lo and sqrtq_hi**2>=300000
assert log_bounds(300000)[0]>=logq_lo
Lg_lo=F_lo*(F(13,4)*logq_lo+F('7.82'))+F('13.66')*logq_lo+F('37.55')
a=F('1.398')*logq_lo*sqrtF_lo/sqrtq_hi
b=F('1.398')*((F('.8764')*sqrtF_lo+F('2.526'))/sqrtq_hi+Lg_lo/150000)
assert F('.07')<=a<=F('.076')
Hlo,Hhi=log_bounds(1200000)
assert Hhi<14
rootlo=200000000; roothi=215443470
assert rootlo**3<=Y<=roothi**3
Vlo=log_bounds(F(9*rootlo,601200))[0]
Vhi=log_bounds(F(9*roothi,601200))[1]
assert Vlo>8
Rlo=F('.27125')*log_bounds(1+Hlo/(2*Vhi))[0]+F('.41415')
# For t=log y: |R'|=.27125*H/[3v(2v+H)] <= .01 for v>=8,H<=14.
Rderiv_hi=F('.27125')*14/(3*8*16)
assert Rderiv_hi<F('.01')
derivative_bracket_lo=F('.07')*F('.41415')/8-F('.076')*F('.01')-eps/8
assert derivative_bracket_lo>0
Yrootlo=F('1333.5'); assert Yrootlo**8<Y
uniform_strong=a*F('.41415')+b
assert uniform_strong>F('.04712')
endpoint_lower=a*Rlo+b
K=Yrootlo*(endpoint_lower-eps)
assert K>79
fallback=F('1.398')*(((F('.41415')*F('12.6')+F('.8764'))*F('1.949')+F('2.526'))/548+F(394,150000))
assert fallback>F('.0404')
result=dict(status='Exact rational scalar checks; not a Lean theorem. Positive log-series remainders and analytic monotonicity proof documented separately.',
 epsilon=eps,gamma_lower=gamma_low,Fr_lower=F_lo,Lg_lower=Lg_lo,
 a=a,b=b,v_at_Y_upper=Vhi,R_at_Y_lower=Rlo,
 uniform_strong_ghat_lower=uniform_strong,endpoint_ghat_lower=endpoint_lower,scaled_global_lower=K,
 recommended_scaled_cap=79,fallback_uniform_ghat_lower=fallback,
 derivative_bracket_lower=derivative_bracket_lo,
 implied_normalized_error_cap_at_Y_diagnostic=79/(1e25**.125))
def fmt(v):
 if isinstance(v,F):return {'decimal':float(v),'numerator':str(v.numerator),'denominator':str(v.denominator)}
 if isinstance(v,dict):return {k:fmt(x) for k,x in v.items()}
 return v
# Huge rationals are kept out of printed output; all comparisons above are exact.
print(json.dumps({k:(float(v) if isinstance(v,F) else v) for k,v in result.items()},indent=2))

