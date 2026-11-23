"""Exact arithmetic for MAJOR_UPPER_PRINCIPAL.md.
Checks a model obstruction to aggregate zero constraints, not actual zeta zeros.
"""
from fractions import Fraction as F
from math import comb
x0=49*10**25
I=sum((F(2*(-1)**k*comb(7,k),2*k+1) for k in range(8)),F(0))
assert F(84,100)**4*2 < 1 # .84 < 2^(-1/4)
A=F(84,100)*I
pair_square=2*(A-F(2,100))
assert pair_square>F('1.01')**2
# Each compact complex wave derivative has this L2 squared upper bound.
derivative_sq=2*(F(784)*F(4,19)+49)+2*10001*(F(64)*F(4,19)+1)
assert derivative_sq<600**2
# Pair derivative norm <=1200; use 2pi>6 for Fourier tail.
assert F(1200,6*200000)<=F('.001')
assert F('1.01')-F('.001')-2*F('.00221')-F('1e-18')>1
# Reflection x^(-3/4) times norm<2 of each wave.
assert F(8,10**19)<F('1e-18') and x0**3>10**76
# Mass and count checks.
g=100
w=2*F(9,8)/(F(9,8)**2+g*g)+2*F(15,8)/(F(15,8)**2+g*g)
assert 15*w<F('.009')<F('.07')
c=F(90)
B=9200*(c+22)*(F(5,4)*(c+11))**9+20*(c+22)**3*(F(5,4)*(c+11))**2
assert B/F('.355')>(F(10)/F(15,8))**30
assert B/F('.355')>(F(10)/F(9,8))**15
assert (5*10**6)**4>x0
assert F(3*15**2,5*10**6)==F('.000135')>F('.0001')
# Sufficient target and harmless remaining terms.
assert 2125**8<x0
W0=F('13.59756'); L=W0*1200000
assert L<5000**2
assert F(21,2125)+F('5e-12')+F('1e-15')<F('.01')
V=106000*8*(40*(2/F('4e-7'))+F('2.6')*(2/F('4e-7')**2))
assert V<3*10**19
print('compact energy rational lower',A)
print('compact pair squared norm lower',pair_square)
print('single derivative norm squared upper',derivative_sq)
print('model quartet mass',15*w)
print('PASS: sufficient K_W=300; model Ep>.000135; no actual zero assertion')


