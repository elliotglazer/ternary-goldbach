"""Exact rational checks for MINOR_ENERGY_QRH.md; not a Lean proof.

No numerical quadrature or floating point enters an acceptance check.
The analytic projection, differentiation and explicit-formula claims are
separate paper obligations, not certified by this script.
"""
from fractions import Fraction as Q
from math import factorial

def exp_lower(n):
    return sum((Q(n) ** j / factorial(j) for j in range(31)), Q(0))

for k, cap in enumerate([Q(1, 2), Q(1), Q(3), Q(10)]):
    p = Q(2*k+3, 2)
    threshold = p ** (2*k+3) / cap**2
    assert exp_lower(2*k+3) > threshold
    print('moment', k, 'squared-exp-threshold', threshold, 'PASS')

assert Q(165,100)*Q(203,100) < 4
assert Q(27182818286,10**10) < Q(165,100)**2
assert Q(45,10)**2 > Q(195,10)
assert Q(192,10)**2 > 368
assert exp_lower(1) > Q(1)
assert Q(1)/exp_lower(1) < Q(1,2)

K0_num = 2*(Q(195,10)+2*Q(192,10))*Q(1,2) + 4*2*Q(45,10)*2 + 4*Q(155,10)
Fprime = 2*2*Q(45,10)*Q(1,2)+4*2
K1_num = 2*(Q(195,10)+2*Q(192,10)) + 4*2*Q(45,10)*7 + 4*58 + 2*Fprime
assert K0_num == Q(1919,10) and K0_num/Q(9,8) < 172
assert K1_num == Q(6338,10) and K1_num/Q(9,8) < 566
assert Q(29,10)*Q(1,2) < 2 # b <=23/8 <2.9, positive part of E'
assert 7+Q(31,2)*Q(3,2)+4*5 < 58
assert 3+2*Q(3,2) < 7

x0=49*10**25
assert 2125**8 < x0
assert Q(27182818286,10**10)**61 < x0
residual=Q(7,100)/2125*(172+Q(566,61))
assert residual+Q(1,10**27) < Q(6,1000)
main_error=Q(195,10**8)+Q(53,10**8)/61
assert Q(640206,10**6)+main_error+Q(6,1000) < Q(64621,10**5)
assert Q(64621,10**5) < Q(65,100)

Kv1=16703*8*Q(27182818286,10**10)
Kv2=2*Kv1*Q(27182818286,10**10)
assert Kv1 < 400000 and Kv2 < 2200000
assert 400000*Q(66403,10000)*10**6/6 < 5*10**11
assert 2200000*Q(66403,10000)*10**6/6 < 3*10**12
assert Q(5*10**11)+Q(3*10**12,61) < 6*10**11

Aerr=(Q(8,5)*368+Q(1000)/Q(8,5))/200**4+Q(368,2*200**4)-Q(2,10**9)
Berr=(Q(2,5)*368+Q(60)/Q(2,5))/200**4+Q(37,100)*Q(368,200**4)+Q(23,10**8)
assert Aerr==Q(871625,10**12) and Berr==Q(50085,10**11)
print('kernel-numerators',K0_num,K1_num)
print('relative-zero-error',residual,'< 0.006')
print('tight-main-upper-errors',Aerr,Berr)
print('PASS_ALL_EXACT_RATIONAL_CHECKS')
