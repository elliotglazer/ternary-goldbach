"""Independent elementary interval replay. Never executes or writes producer files.

Direct endpoint powers replace the producer's recurrent update. The alternate
certificate changes B, panel count, precision, and the right endpoint.
No zeta, Gamma, numerical integration, or prime-table call occurs here.
"""
from pathlib import Path
from fractions import Fraction
import hashlib
import json
import time
import flint
from flint import arb, ctx

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRODUCER = ROOT / 'work/qrh-blueprint/turing-scalars'
PINS = {
    'ZETA_LOG_INTEGRAL_2026-11-11.md': '66dcfc80712a8773682d23f2121bb05a2494cee1ad7eb7a975eeaed7b399852e',
    'zeta_log_integral.py': '5bb356e9ff112adff19919cd946f2c60d6d621f78b17aed50a4e4b5fbc803fad',
    'zeta_log_integral.json': '687344ffd5e44b52059b848867ae09c316a827eee8108e6342316c41d9b0b5bc',
}

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

for name, pin in PINS.items():
    assert digest(PRODUCER / name) == pin, name
old = json.loads((PRODUCER / 'zeta_log_integral.json').read_text())
assert old['script_sha256'] == PINS['zeta_log_integral.py']
assert len(old['log_upper_samples']) == 2049

def ball(q):
    q = Fraction(q)
    return arb(q.numerator) / q.denominator

def run(B, panels, right, precision, compare=None):
    ctx.prec = precision
    left = Fraction(5, 4)
    step = (Fraction(right) - left) / panels
    logs = [arb(n).log() for n in range(1, B+1)]
    endpoints = []
    checksum = hashlib.sha256()
    endpoint_sum = arb(0)
    started = time.perf_counter()
    overlaps = 0
    for j in range(panels+1):
        s = ball(left + j*step)
        powers = [(-s*logn).exp() for logn in logs]
        # Separate integral, endpoint, B2 correction, and remainder majorant.
        integral_tail = B*powers[-1]/(s-1)
        endpoint = powers[-1]/2
        correction = s*powers[-1]/(12*B)
        remainder_majorant = s*powers[-1]/(12*B)
        upper = sum(powers[:-1], arb(0)) + integral_tail + endpoint + correction + remainder_majorant
        assert upper > 1
        value = upper.log()
        assert value > 0
        text = str(value)
        endpoints.append(text)
        checksum.update((text+'\n').encode())
        endpoint_sum += value * (1 if j == 0 or j == panels else 2)
        if compare is not None:
            assert value.overlaps(arb(compare['log_upper_samples'][j])), j
            overlaps += 1
    trapezoid = endpoint_sum*ball(step)/2
    log2 = arb(2).log()
    # Independently use exact 2^(-right), with integer right.
    tail = arb(1)/(2**right) / log2 * ball(1+Fraction(2,right-1))
    bound = trapezoid+tail
    assert bound < ball(Fraction(5918,5000))
    assert bound < ball(Fraction(148,125))
    if compare is not None:
        assert trapezoid.overlaps(arb(compare['trapezoid']))
        assert tail.overlaps(arb(compare['tail']))
        assert bound.overlaps(arb(compare['bound']))
    return {
        'B': B, 'panels': panels, 'right': right,
        'left': str(left), 'step': str(step), 'precision_bits': precision,
        'trapezoid': str(trapezoid), 'tail': str(tail), 'bound': str(bound),
        'margin_to_1_1836': str(ball(Fraction(5918,5000))-bound),
        'producer_endpoint_overlaps': overlaps,
        'endpoint_sha256': checksum.hexdigest(),
        'log_upper_samples': endpoints,
        'wall_seconds': time.perf_counter()-started,
    }

results = [run(64, 2048, 32, 192, old), run(96, 3072, 36, 224)]
# Exact checks on the parameter and polynomial bounds used in the paper review.
assert Fraction(123,8192) == (Fraction(32)-Fraction(5,4))/2048
assert Fraction(1,6) >= Fraction(1,12)
assert Fraction(5918,5000) < Fraction(148,125)
for name, pin in PINS.items():
    assert digest(PRODUCER/name) == pin, 'Producer changed during replay: '+name
receipt = {
    'status': 'PASS_INDEPENDENT_EXTERNAL_EM_CHORD_REPLAY',
    'producer_pins': PINS,
    'script_sha256': digest(Path(__file__)),
    'python_flint': flint.__version__,
    'method': 'Direct elementary endpoint exponentials, no recurrent powers or builtin zeta',
    'scope': 'External Arb evidence under independently reviewed analytic reduction; no Lean proof',
    'results': results,
}
HERE.joinpath('review_zeta_log_integral_20261111.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({**{k:v for k,v in receipt.items() if k!='results'},
                  'results': [{k:v for k,v in r.items() if k!='log_upper_samples'} for r in results]}, indent=2))
