"""Exact scalar design checks only. No FFT, twiddle table, or L-value is computed."""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import hashlib
import json

checks = {}
def check(name, lhs, rhs):
    assert lhs < rhs, name
    checks[name] = {'lhs':str(lhs),'relation':'<','rhs':str(rhs)}

def atan_sum(q):
    return sum(((-1)**j)*q**(2*j+1)/Q(2*j+1) for j in range(50))

pi_center = 16*atan_sum(Q(1,5))-4*atan_sum(Q(1,239))
pi_error = Q(16,101*5**101)+Q(4,101*239**101)
tail = Q(22,7)**65/Q(factorial(65))/(1-Q(22,7*66))
complex_round = Q(1,2**179)
real_round = Q(1,2**180)
delta = Q(1,10**52)
B = 100000001
stage_error = 36*(B+2)*delta
final_error = 51*stage_error+(B+1)*delta+delta

check('pi_center_lower', Q(3), pi_center)
check('pi_center_upper', pi_center, Q(22,7))
check('pi_error', pi_error, Q(1,10**60))
check('twiddle_enclosure', pi_error+tail+complex_round, delta)
check('butterfly_rounding', complex_round, delta)
check('scale_enclosure', 16*pi_error+real_round, delta)
check('normalized_output_multiplier', Q(16*22,7), Q(51))
check('power_two_exponent_bound', Q(8*257*50000000), Q(2**37))
check('stage_product_geometric_argument', 18*delta, Q(1,2))
check('stage_error_below_one', stage_error, Q(1))
check('finite_fft_output_error', final_error, Q(1,10**40))
check('series_aggregate', Q(51,10**119), Q(1,10**117))
ledger = Q(1,10**30)+Q(1,10**75)+Q(51,10**119)+Q(51,10**50)+Q(1,10**40)
check('alternative_protocol_ledger',ledger,Q(2,10**30))

out = {'status':'PASS: 13 exact scalar design checks; no FFT or spectral data',
       'checks':checks,
       'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS: 13 scalar checks; no FFT, twiddle table, or L-values computed')
