"""Exact scalar checks for a conservative FFT alias parameter protocol.

These inequalities do not evaluate any character, Fourier coefficient, or sign.
Analytic assumptions and normalization are derived in the adjacent proof plan.
"""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

checks = {}


def check(name, lhs, rhs, relation):
    assert (lhs < rhs) if relation == '<' else (lhs > rhs)
    checks[name] = {'lhs': str(lhs), 'relation': relation, 'rhs': str(rhs)}


# exp(1)>8/3 by its first four nonnegative Taylor terms and a positive remainder.
check('time_alias_upper', F(32 * 10**8) * F(3, 8)**96, F(1, 10**30), '<')
check('frequency_gaussian_exponent_lower', F(3, 2 * 10**8) * F(8, 3)**24, F(200), '>')
check('frequency_alias_upper', F(12 * 10**8) * F(3, 8)**200, F(1, 10**75), '<')
M = 100000
check('series_exponent_lower', F(3, 10**8) * (M + 1)**2, F(300), '>')
check('series_ratio_exponent_lower', F(3, 10**8) * (2 * M + 3) - F(1, M + 1),
      F(1, 200), '>')
check('series_per_coefficient_upper', F(402 * (M + 1)) * F(3, 8)**300,
      F(1, 10**119), '<')
check('DFT_norm_factor_upper', F(44, 7) * (4 + F(2, 257)), F(26), '<')
check('series_all_coefficient_upper', F(26, 10**119), F(1, 10**117), '<')
check('full_example_ledger_upper', F(1, 10**30) + F(1, 10**75) + F(1, 10**117)
      + F(26, 10**50) + F(1, 10**40), F(2, 10**30), '<')

receipt = {'status': 'PASS: exact scalar implications only; no FFT or finite spectral certificate',
           'parameter_protocol': {'T': 'Hcert(c), c>1 active, so T>=1 and c*T<=100000000',
                                  'eta': '1-1/T', 'P': '257*T',
                                  'N': '2*ceil(2*P), even', 'fold_radius': 0,
                                  'Gaussian_series_terms': M,
                                  'future_per_coefficient_rounding_bound': '1/10^50',
                                  'future_normalized_FFT_arithmetic_bound': '1/10^40'},
           'checks': checks,
           'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
Path(__file__).with_suffix('.json').write_text(json.dumps(receipt, indent=2) + '\n')
print('PASS', len(checks), 'exact scalar checks; no analytic data generated')
