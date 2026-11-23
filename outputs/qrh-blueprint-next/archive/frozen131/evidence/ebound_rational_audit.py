"""Exact rational audit for EBOUND_UNCONDITIONAL.md; no Lean proof claim."""
from fractions import Fraction as F
from decimal import Decimal, localcontext

checks = []
def check(name, condition):
    assert condition, name
    checks.append(name)

def decimal(q):
    with localcontext() as ctx:
        ctx.prec = 45
        return str(Decimal(q.numerator) / Decimal(q.denominator))

X = F('4.9e26')
s0 = F('2.2135e13')
e_lo = F('2.7182818283')
e_hi = F('2.7182818286')
log2_hi = F('0.6931471808')
sqrt2_hi = F('1.41422')
q1 = F('1.54693')
q2 = F('2.393')

check('sqrt X >= s0', s0**2 <= X)
check('sqrt X >= 1e8', F('1e8') <= s0)
check('X^(1/6) >= 28000', F(28000)**6 <= X)
check('exp 2 <= 1e8 from exp 1 upper', e_hi**2 <= F('1e8'))
check('exp 6 <= X from exp 1 upper', e_hi**6 <= X)
check('log 1e8 <= 19 from exp 1 lower', F('1e8') <= e_lo**19)
check('log X <= 61.5 from exp 1 lower and exp .5 >= 13/8', X <= e_lo**61 * F(13, 8))
check('log 4 <= 1.387', 2 * log2_hi <= F('1.387'))
check('Chebyshev psi coefficient < 1.4', F('1.387') + 2*F(19, 10000) < F('1.4'))
check('higher-power coefficient < .1', F('61.5') / 28000 < F('.1'))
check('sqrt 2 <= chosen upper', 2 <= sqrt2_hi**2)
d = 1 - sqrt2_hi / 4
check('geometric denominator positive', 0 < d)
check('geometric first inverse bound', 1 <= q1*d)
check('geometric second inverse bound', 1 <= q2*d*d)
A = F('1.94')**2 * (F('1.4')/2 + F('1.5'))
B = F('1.5') * F('2.32')**2 * sqrt2_hi
alpha = A + B*q1
beta = B*log2_hi*q2
check('log coefficient <= 25.943', alpha <= F('25.943'))
check('constant coefficient <= 18.94', beta <= F('18.94'))
bound = (F('25.943')*F('61.5') + F('18.94'))/s0
slack = F('8e-11') - bound
check('final coefficient < 8e-11', 0 < slack)
print('All', len(checks), 'exact rational checks passed.')
print('A =', A, '=', decimal(A))
print('B_upper =', B, '=', decimal(B))
print('alpha_upper =', alpha, '=', decimal(alpha))
print('beta_upper =', beta, '=', decimal(beta))
print('Final E/x bound =', bound, '=', decimal(bound))
print('Margin below 8e-11 =', slack, '=', decimal(slack))
print('Conditional on the explicit analytic inequalities proved in the note; not a Lean certificate.')
