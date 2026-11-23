"""Independent rational scalar checks only; no function or transform evaluation.

The mathematical reduction to these rational inequalities belongs to the
accompanying review. This script does not establish an EM or Cauchy theorem.
"""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
from hashlib import sha256
import json

checks = {}


def check(name, condition):
    checks[name] = bool(condition)
    if not condition:
        raise AssertionError(name)


cmax = 300000
cTmax = 100000000
rho = F(1, 16)
sigma_min = F(111, 200) - rho
Xmax = cTmax + 38*cmax
main_count_bound = cTmax + 37*cmax

check('target_real_floor', sigma_min == F(197, 400))
check('outer_real_floor', F(111, 200)-1 > -F(1, 2))
check('outer_rising_factor_slack', 4+30 < 36)
check('target_rising_factor_slack', 2+2*rho+31 < 36)
check('Xmax_below_power_two', Xmax < 2**27)
check('sqrt_Xmax_below_power_two', Xmax < (2**14)**2)
check('small_extra_exponent', 27*F(3, 400) < 1)
check('EM_denominator_positive', 31+sigma_min > 0)

# N>=36, v<=c, and X_a<c(N+1) give these three contributions.
# Endpoint plus all Bernoulli terms is at most (1/2+4/35)*v*sqrt(Xmax).
endpoint_and_bernoulli = F(1, 2)+F(4, 35)
check('endpoint_and_Bernoulli_under_1_3', endpoint_and_bernoulli < F(13, 10))
outer_bracket = main_count_bound+F(13, 10)*cmax+F(37, 36)*cmax
check('outer_bracket_below_2pow27', outer_bracket < 2**27)
check('outer_value_below_2pow42', 2**14*outer_bracket < 2**42)

em = F(8*2**14, 1)/((31+sigma_min)*6**32)
taylor = F(2**42)*rho**30/(1-rho)
check('EM_below_2pow_minus70', em < F(1, 2**70))
check('Taylor_below_2pow_minus77', taylor < F(1, 2**77))
check('sqrt2_below_3over2', 2 < F(3, 2)**2)
check('analytic_coordinate_square_under_2pow_minus69',
      F(3, 2)*(em+taylor) < F(1, 2**69))
# This is an optional sufficient extra arithmetic allowance, not a claim
# that any actual arithmetic producer meets it.
check('optional_coordinate_arithmetic_2pow_minus72_also_fits',
      F(3, 2)*(F(1, 2**70)+F(1, 2**77)+F(1, 2**72)) < F(1, 2**69))

base = Path(__file__).resolve().parent.parent/'major-constants'
pins = {
    'FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md': '9D2AEE85DB76673ACE63D17057B1B2B3BEAEC925F9A38A9980171696FF4EC233',
    'finite_u_uniform_scalar_budget_20261111.py': '25BF32F802D2FDD3B3042D44A1D3675863CC457896CA92AFDF8244715A476E5C',
    'finite_u_uniform_scalar_budget_20261111.json': 'FAAE4C0DD298F161513AC4A15935CF75CA40E863A4BDBB66DB322404607D3303',
}
for name, digest in pins.items():
    check('pin_'+name, sha256((base/name).read_bytes()).hexdigest().upper() == digest)

# Independent formal reciprocal of sum z^j/(j+1)!, giving B_j/j!.
bern_coeff = [F(1)]
for n in range(1, 65):
    bern_coeff.append(-sum(bern_coeff[n-j]/factorial(j+1) for j in range(1, n+1)))
check('Bernoulli_initial_values', bern_coeff[1:5] == [F(-1,2), F(1,12), F(0), F(-1,720)])
for m in range(1, 33):
    check('Bernoulli_bound_'+str(m), abs(bern_coeff[2*m]) <= F(4, 6**(2*m)))
check('author_geometric_correction', F(4,9)/(1-F(4,9)) == F(4,5))
check('author_outer_prefactor_primary', 1+F(23,360) < 2)

batch = F(2**18, factorial(32))
check('weighted_main_sum_cap', F(8,5)**8*2**(27*5) < 2**(18*8))
check('residual_p32_cap', batch < F(1, 2**99))
per_coeff = F(1,2**78)+F(1,2**79)+2*F(1,2**77)
check('per_coefficient_arithmetic', per_coeff < F(1,2**75))
check('weighted_and_final_arithmetic', F(16,15)*F(1,2**75)+F(1,2**75) < F(1,2**70))
complete = F(3,2)*(em+taylor)+batch+F(1,2**70)
check('complete_conditional_error', complete < F(1,2**68))

X2 = F(cTmax,3)+24*cmax
check('comparison_X_cap', X2 < 2**26)
check('comparison_root_cap', X2 < 6400**2)
check('comparison_outer_bound', F(2**26)*6400*(1+F(23,220)) < 2**40)
em2 = F(8*6400)/(63+sigma_min)/2**64
taylor2 = F(2**40)*rho**24/(1-rho)
check('comparison_EM_cap', em2 < F(1,2**54))
check('comparison_Taylor_cap', taylor2 < F(1,2**55))
check('comparison_analytic_cap', em2+taylor2 < F(1,2**53))

receipt = json.loads((base/'finite_u_uniform_scalar_budget_20261111.json').read_text())
def fraction(obj):
    return F(int(obj['numerator']), int(obj['denominator']))
check('receipt_primary_em', fraction(receipt['primary']['em_upper']) == em)
check('receipt_primary_Taylor', fraction(receipt['primary']['taylor_upper']) == taylor)
check('receipt_primary_complete', fraction(receipt['primary']['optional_complete_norm_upper']) == complete)
check('receipt_comparison_em', fraction(receipt['comparison']['em_upper']) == em2)
check('receipt_comparison_Taylor', fraction(receipt['comparison']['taylor_upper']) == taylor2)
check('receipt_check_count', receipt['check_count'] == len(receipt['checks']) == 57)
def phi_by_factorization(n):
    result, remaining, p = n, n, 2
    while p*p <= remaining:
        if remaining % p == 0:
            result -= result//p
            while remaining % p == 0:
                remaining //= p
        p += 1
    if remaining > 1:
        result -= result//remaining
    return result
for row in receipt['examples']:
    c = row['c']
    T = F(cTmax,c)
    N = (T.numerator+T.denominator-1)//T.denominator+36
    v = phi_by_factorization(c)
    check('example_'+str(c), fraction(row['T']) == T and row['N'] == N
          and row['v'] == v and row['residue_head_terms'] == v*N
          and row['Xmax'] == c*(N+1) < Xmax)

print(json.dumps({
    'status': 'PASS_EXACT_RATIONAL_SCALARS',
    'checks': checks,
    'em_bound': str(em),
    'taylor_bound': str(taylor),
    'outer_bracket': str(outer_bracket),
    'check_count': len(checks),
    'input_pins': pins,
    'optional_complete_bound': str(complete),
    'scope': 'Scalar inequalities only; no functions, models, FFTs or spectral data.'
}, indent=2))
