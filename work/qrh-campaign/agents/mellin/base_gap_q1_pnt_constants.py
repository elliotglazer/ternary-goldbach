"""Exact rational arithmetic for the conditional Q=1 PNT alternative.

This proves no prime-number-theorem estimate. It only checks the stated
constants once that independent estimate and the analytic bridges hold.
"""
from fractions import Fraction as F
eupper=F('2.7182818286')
assert eupper**45 < F('3.5e19')
assert F('1.254')**2 > F(11,7)
A=F('3.5e-6')
D=600000
piupper=F(22,7)
eps=F('1.1e-8')
small=46*(6*A**3+F(45,4)*A**5+F(9,2)*piupper*D*A**4)
assert small < F('1e-12')
V=F('6.27')+2*piupper*D*F(9,8)
large=eps*V
main=F('1.016')/(F(600000,49)**2)
assert main<F('7e-9')
removed=F('4e-9')
total=small+large+main+removed
assert total < F('.046673') < F('.04712')
published=F('1.0412e-8')*V+small+main+removed
print('variation upper:',V)
print('small-range tail:',small)
print('total under epsilon=1.1e-8:',total)
print('published-epsilon hypothetical total:',published)
print('PASS_EXACT_BUDGET; PNT INPUT REMAINS UNPROVED IN CAMPAIGN')
