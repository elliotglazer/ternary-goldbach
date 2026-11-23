"""Exact parameter witnesses for arbitrary rational auxiliary target heights.

Checks scalar sufficient conditions only; does not evaluate any L-function/FFT.
"""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

def witness(c, target, tolerance):
    target, tolerance = F(target), F(tolerance)
    assert c > 1 and target >= 1 and 0 < tolerance <= 1
    cap = c * target
    k = ell = 1
    while 32 * cap * F(3, 8)**k >= tolerance / 4:
        k += 1
    while 16 * cap * F(3, 8)**ell >= tolerance / 4:
        ell += 1
    x = 2
    while F(3, 2) / cap * F(8, 3)**(2*x) < ell:
        x += 1
    period = (1 + F(8, 3)*k)*target
    n = 2
    while n < period*x/3:
        n *= 2
    dft_norm_cap = F(88*x, 21)
    m = 1
    while True:
        n0 = m + 1
        z = 3*F(2*m+3)/cap - F(1, n0)
        exponent = 3*F(n0*n0)/cap
        j = exponent.numerator // exponent.denominator
        if z > 0 and exponent >= F(3,4):
            series = 2*n0*(1+1/z)*F(3,8)**j
            if dft_norm_cap*series < tolerance/4:
                break
        m *= 2
    assert period > 2*target
    assert n >= period*x/3 and n < 2*period*x/3
    assert n & (n-1) == 0
    assert 32*cap*F(3,8)**k < tolerance/4
    assert 16*cap*F(3,8)**ell < tolerance/4
    assert F(3,2)/cap*F(8,3)**(2*x) >= ell
    assert dft_norm_cap*series < tolerance/4
    return {
        'conductor': c, 'target': str(target), 'c_target': str(cap),
        'tolerance': str(tolerance), 'K': k, 'L': ell,
        'frequency_lower_integer': x, 'period': str(period),
        'radix2_length': n, 'gaussian_terms': m,
        'dft_norm_cap': str(dft_norm_cap),
        'per_coefficient_rounding_target': str(tolerance/(8*dft_norm_cap)),
        'normalized_fft_rounding_target': str(tolerance/8),
        'status': 'PASS_EXACT_PARAMETER_CONDITIONS',
    }

cases = [(3,F(1000000)), (300000,F(1000)), (4,F(100000000)),
         (101,F(10001,2)), (8,F(7,3))]
rows = [witness(c,t,F(1,10**30)) for c,t in cases]
receipt = {
    'status':'PASS_EXACT_PARAMETERS_ONLY', 'rows':rows,
    'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'scope':'No coefficients, FFT outputs, signs, zero counts, or runtime forecast. Rounding targets remain unproved.'
}
Path(__file__).with_suffix('.json').write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print(json.dumps(receipt,indent=2))
