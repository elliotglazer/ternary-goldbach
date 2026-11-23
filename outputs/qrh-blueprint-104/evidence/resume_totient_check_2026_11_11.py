"""Exact scalar replay for the resumed totient synthesis; no Lean invocation.

This checks arithmetic after the analytic/source lemmas in the companion note.
It does not prove those lemmas or the finite zero certificates discussed there.
"""
from fractions import Fraction as F
import hashlib
import json
from pathlib import Path

assert F(1001, 1000) ** 8 < 2
assert F(132) < 12000
assert F(2, 1000) ** 2 * 6000000 < F('7.2539') ** 2
assert F(200) + 12 + F('.0717') + F('3191.9427') + F('8465.1669') + 9 == F('11878.1813')
assert F('11878.1813') < 12000
poly = 7 * 350**3 + 65 * 350**2 + 96 * 350 + 384
assert poly == 308121484
assert F('1.398') * 12000 < 16800
assert 16800 * poly * 10**24 < 2**125
minor = (1 + F(1, 2000)) * F('1.037001') + 2001 * F('22.75') * F(8, 10**11)
assert minor == F('1.03752314232') < F('1.0376')
assert F('1.0404') - F('1.0376') - F('.00271') == F('.00009')

here = Path(__file__).resolve().parent
inputs = [
    here / 'GLOBAL_TOTIENT_TAIL.md',
    here / 'SECOND_CHOICE_WEAK_TOTIENT.md',
    here / 'TYPEII_TOTIENT.md',
    here.parent / 'zero-sum/SECOND_CHOICE_WEAK_REVIEW.md',
    here.parent / 'integration/GLOBAL_TOTIENT_FINITE_REVIEW.md',
]
print(json.dumps({
    'status': 'PASS_EXACT_ARITHMETIC_ONLY',
    'common_envelope_coefficient': 12000,
    'plateau_radius': '2^500',
    'layer_upper_rational': str(F(16800 * poly, 2**125)),
    'layer_below': '1e-24',
    'final_minor_with_1e_minus6_allowance': str(minor),
    'input_sha256': {str(p.relative_to(here.parent)): hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs},
}, indent=2))
