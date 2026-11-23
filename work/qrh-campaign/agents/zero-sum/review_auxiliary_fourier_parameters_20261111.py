"""Independent exact reconstruction; reads but never writes producer files."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
BASE = ROOT / 'work/qrh-blueprint/turing-scalars'
EXPECTED = {
    'AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md': '45E848935AC76C8450550DFE02279C697514BF227B37EA6FD25221B3F7C37F47',
    'auxiliary_fourier_parameters.py': '7C1A901FEF4B9A9289E82849DFDADDE1C97AB3AB238B4BFFC90C6A15D71BFAF8',
    'auxiliary_fourier_parameters.json': 'E32CEB4C944E8732472EB70A53D45778203860989785F296C7D2ACA241956F20',
}


def verify_pins():
    for name, digest in EXPECTED.items():
        assert hashlib.sha256((BASE / name).read_bytes()).hexdigest().upper() == digest


def exponent_below(factor, target):
    exponent, value = 0, Q(factor)
    while exponent < 1 or value >= target:
        exponent += 1
        value *= Q(3, 8)
    return exponent, value


def reconstruct(c, height, tolerance):
    assert isinstance(c, int) and c > 1 and height >= 1 and 0 < tolerance <= 1
    C = c * height
    K, time = exponent_below(32 * C, tolerance / 4)
    L, frequency = exponent_below(16 * C, tolerance / 4)
    x, exp_lower = 2, Q(8, 3)**4
    while 3 * exp_lower < 2 * C * L:
        x += 1
        exp_lower *= Q(64, 9)
    P = height * (Q(8 * K, 3) + 1)
    threshold = P * x / 3
    ceiling = -(-threshold.numerator // threshold.denominator)
    N = 1 << (ceiling - 1).bit_length()
    D = Q(88 * x, 21)
    ell = 0
    while True:
        M = 1 << ell
        n0 = M + 1
        z = Q(3 * (2 * M + 3), 1) / C - Q(1, n0)
        exponent = 3 * n0 * n0 / C
        j = exponent.numerator // exponent.denominator
        if z > 0 and exponent >= Q(3, 4):
            series = D * 2 * n0 * (1 + 1 / z) * Q(3, 8)**j
            if series < tolerance / 4:
                break
        ell += 1
    assert threshold > 2 and threshold <= N < 2 * threshold
    assert N % 2 == 0 and N & (N - 1) == 0
    assert P > 2 * height and P >= Q(11, 3)
    assert Q(3, 8) * P / height == K + Q(3, 8) > 1
    assert Q(3, 8) * (P - height) / height == K
    assert Q(44, 7) / P < 2
    assert 3 * N / P >= x
    assert Q(44 * N, 7) / P < D
    assert Q(3, 2) * exp_lower / C >= L
    assert time + frequency + series + tolerance / 4 < tolerance
    fields = {
        'conductor': c, 'target': str(height), 'c_target': str(C),
        'tolerance': str(tolerance), 'K': K, 'L': L,
        'frequency_lower_integer': x, 'period': str(P),
        'radix2_length': N, 'gaussian_terms': M, 'dft_norm_cap': str(D),
        'per_coefficient_rounding_target': str(tolerance / (8 * D)),
        'normalized_fft_rounding_target': str(tolerance / 8),
        'status': 'PASS_EXACT_PARAMETER_CONDITIONS',
    }
    diagnostic = {'c': c, 'H': str(height), 'e': str(tolerance),
                  'K': K, 'L': L, 'x': x, 'N': N, 'M': M,
                  'radix2_stages': N.bit_length() - 1,
                  'time_bound_over_budget': str(time / tolerance),
                  'frequency_bound_over_budget': str(frequency / tolerance),
                  'series_bound_over_budget': str(series / tolerance),
                  'total_with_future_rounding_over_budget': str((time + frequency + series) / tolerance + Q(1, 4))}
    return fields, diagnostic


verify_pins()
author = json.loads((BASE / 'auxiliary_fourier_parameters.json').read_text())
assert author['status'] == 'PASS_EXACT_PARAMETERS_ONLY'
assert author['script_sha256'].upper() == EXPECTED['auxiliary_fourier_parameters.py']
results = []
for row in author['rows']:
    rebuilt, diagnostic = reconstruct(row['conductor'], Q(row['target']), Q(row['tolerance']))
    assert rebuilt == row
    results.append(diagnostic)
edge_cases = []
for c, H, e in [(2, Q(1), Q(1)), (3, Q(1), Q(1, 10**60)),
                (300000, Q(1001, 3), Q(1, 10**60))]:
    _, diagnostic = reconstruct(c, H, e)
    edge_cases.append(diagnostic)
verify_pins()
out = {'status': 'PASS_INDEPENDENT_EXACT_SCALARS', 'producer_pins': EXPECTED,
       'matched_complete_rows': len(results), 'rows': results, 'extra_edge_cases': edge_cases,
       'scope': 'No FFT data, signs, zero counts or runtime claim. Future rounding targets remain obligations.',
       'review_script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2) + '\n')
print('PASS: five complete rows matched; three extra boundary cases; producer pins unchanged')
