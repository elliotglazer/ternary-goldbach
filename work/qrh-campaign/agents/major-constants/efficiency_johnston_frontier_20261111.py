"""Finite rational parameter certificates; no analytic-function/prime/zero evaluations."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

def exp_lower(z, n):
    return sum((z**k/F(factorial(k)) for k in range(n+1)), F(0))

def exp_upper(z, n):
    assert z >= 0 and z < n+2
    return exp_lower(z,n)+z**(n+1)/F(factorial(n+1))/(1-z/F(n+2))

def enc(x):
    x=F(x)
    return {'numerator':str(x.numerator),'denominator':str(x.denominator),
            'ceil_times_10pow15':str(-(-x.numerator*10**15//x.denominator))}

A=10**16
X=10**27
PI=F(314,100)
assert exp_upper(F(23,10),50)<10<exp_lower(F(231,100),30)
assert 16*F(23,10)>36 and 16*F(231,100)<37
assert 27*F(23,10)>62 and 27*F(231,100)<63
assert exp_upper(F(358,100),60)<36
assert exp_lower(F(21,10),30)>8
assert exp_lower(F(3,10),3)>F(4,3)
assert exp_lower(F(5),30)>127
assert exp_lower(F(6),30)>400
assert exp_lower(F(1),4)>F(8,3)
assert exp_lower(F(1387,1000),30)>4
assert exp_upper(F(547,100),70)<F(10500,44)
assert exp_lower(F(732,100),50)>1500
# Existing head Q1500<1.668 plus analytic closed count with 5log(t)+167/8.
reciprocal_excess=2*(F(1668,1000)-((F(547,100)-1)**2+1)/(4*F(22,7))
                       +(5*F(732,100)+F(207,8))/1500)
assert reciprocal_excess<F(1,10)

# D(20)>0.97, from the defining positive I1 series and an exp(1) enclosure.
# No Bessel or exponential implementation is called.
e_upper=exp_upper(F(1),40)
i1_lower=sum((F(10**(2*n+1),factorial(n)*factorial(n+1)) for n in range(41)),F(0))
assert F(56,10)**2<10*PI
assert F(112,10)*i1_lower>F(97,100)*e_upper**20

# Uniform domains for x in[A,X], Q in[1,50], L=log x.
EPS=F(1,10000)
assert F(37**2*7,10**8)<EPS  # eps decreasing in L>5, evaluated only at A
CMAX=F(75,2)
assert 24<=F(36,2)+6 and F(63,2)+6==CMAX
assert CMAX*EPS<F(62,1000)**2
assert F(71,100)*F(62,1000)<F(45,1000)
assert 1/(1-F(45,1000))<F(105,100)
assert 1+11*CMAX*EPS<F(105,100)
assert F(50)*F(2,3)<36*6  # c/eps < sqrt(x)
assert 6/EPS>5000  # sqrt(2c)/eps>60000
assert F(177,100)**2<PI

# Bounds for E1, middle band and low band, after division by sqrt(x)*L^2.
high_pref=F(1,200)*(1+F(1,2**36))/(1-F(1,2**48))
assert high_pref<F(51,10000)
high=F(16,100)*F(51,10000)*F(105,100)*5/(2*36)
assert high<F(6,100000)
ratio=(F(3,8)+F(1,2**24))/(1-F(1,2**48))
assert ratio<F(38,100)
middle=F(105,100)*F(38,100)/(4*PI*36)
assert middle<F(9,10000)
assert F(50)/(2*PI)<8
low=(F(1,2)-F(491,100*63))**2/(2*PI)
assert low<F(284,10000)

# B0>sqrt(x): use D20>.97, exp(-eps)>.99, sqrt(pi(L+12))<3sqrtL.
assert F(97,100)*F(99,100)*36**2/(3*50)>1
outer=1/(1-2*EPS)*(1+EPS/36)
assert outer<F(10003,10000)
smooth_const=4*F(10003,10000)/F(177,100)
assert smooth_const<F(2261,1000)
residual=(F(201,100)*EPS*F(10003,10000)/36
          +F(5,2)*F(10003,10000)/(10**8*36)
          +F(3,10**8*36**2)+F(1,2*10**8*36))
assert residual<F(6,10**6)

# Elementary ordinary psi-theta difference and normalization allowance.
assert 400**6<A
assert F(1387,1000)+F(126,400)<F(171,100)
assert F(171,100)/36**2<F(132,100000)
base=(F(284,10000)+F(9,10000)+F(6,100000)+F(6,10**6)
      +F(132,100000)+F(1,10)/36**2)
assert base<F(31,1000)
# Coarse inverse-square replacement in the explicit-formula constant.
inverse_square_head=F(2,14)*(F(1668,1000)+F(1069,1500))
inverse_square_tail=F(12,4500)+(80+F(187,4))/1500**2
assert inverse_square_head+inverse_square_tail<F(344,1000)<1
assert F(22,10)+F(1,2)+F(6,1000)+F(8,1000)<3

# c/eps increases on this interval; endpoint bound valid for every Q.
assert F(39,5)**2<62
SQRTX=3163*10**10
assert SQRTX**2>X
height_per_Q=CMAX*SQRTX/(62**2*F(39,5))
assert height_per_Q<4*10**10

rows=[]
for Q,B in [(1,6*10**17),(2,3*10**17),(4,15*10**16),(8,8*10**16),
            (16,5*10**16),(32,3*10**16),(48,2*10**16),(50,2*10**16)]:
    coef=F(31,1000)+F(2261,1000*Q)
    gap=2*coef*SQRTX*63**2
    assert 1<=Q<=50 and B>=2*A and B%2==0
    assert gap<B-4
    rows.append({'Q':Q,'RH_height':str(4*10**10*Q),'binary_cutoff':str(B),
                 'theta_coefficient':enc(coef),'gap_error_upper':enc(gap),
                 'gap_positive_margin_lower':enc(B-4-gap),
                 'binary_range_factor_vs_4e18':enc(F(4*10**18,B))})

out={'scope':'exact rational scalar certificates only; no RH, prime count or analytic evaluator',
 'A':str(A),'X':str(X),'Q_domain':[1,50],
 'log10_bounds':[enc(F(23,10)),enc(F(231,100))],
 'D20_gt_0p97_certificate':True,
 'reciprocal_excess_upper':enc(reciprocal_excess),
 'inverse_square_upper':enc(inverse_square_head+inverse_square_tail),
 'explicit_formula_absolute_allowance':3,
 'high_coefficient_upper':enc(high),'middle_coefficient_upper':enc(middle),
 'low_coefficient_upper':enc(low),'desmoothing_numerator_upper':enc(smooth_const),
 'residual_and_jump_upper':enc(residual),'non_smoothing_allocation':enc(base),
 'height_per_Q_upper':enc(height_per_Q),'rows':rows}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
