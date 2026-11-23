"""Independent exact scalar audit; no FFT, character data or special functions."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
NOTE = HERE.parent / 'zero-sum/OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md'
PIN = 'BA7A5D0517972FD9C93496E6166DEC471B36C18CA0B6BBA734985016ECD24B25'
assert hashlib.sha256(NOTE.read_bytes()).hexdigest().upper() == PIN
checks = []
def check(name, assertion):
    assert assertion, name
    checks.append(name)

slo, shi, C = F(89, 200), F(111, 200), 10**8
check('reflection endpoints', 1-slo == shi)
check('L1 endpoint product', slo*shi == F(9879, 40000))
check('L1 multiplier', 1/slo + 1/shi == F(40000, 9879))
check('conductor exponent at right edge', F(1, 2)-shi == -F(11, 200))
check('uniform A ratio power', (1-2*slo)/4 == F(11, 400))
check('conductor upper power of two', 300000 < 2**19)
check('A ratio is below two', 19*F(11, 400) < 1)
check('uniform M ratio below three', 2/(4*slo*shi) < 3)
check('single line M ratio', 1/(4*slo*shi) == F(10000, 9879))
check('two unequal reciprocal denominators', 1 + 1/slo < 4)
check('time exponent', F(3,8)*(257-1) == 96)
check('time denominators exceed half', F(3,8)*257 > 1 and F(3,8) < F(1,2))
etime = 96*C*F(3,8)**96
efreq = 32*C*F(3,8)**200
check('time budget', etime < F(1,10**30))
check('frequency budget', efreq < F(1,10**75))
check('frequency cutoff double exponential', F(3,2*C)*F(8,3)**24 > 200)
check('radix two output multiplier', 16*F(22,7) < 51)
M = 100000
d = F(3,C)
check('series Gaussian exponent above 300', d*(M+1)**2 > 300)
check('both prefactor exponents below two', shi+1 < 2)
check('uniform numerator monotonicity', d*(M+1)**2 > (shi+1)/2)
check('series ratio at most exp negative 1/200', d*(2*M+3)-F(1,M+1) > F(1,200))
eseries = 402*(M+1)*F(3,8)**300
check('series budget', eseries < F(1,10**119))
check('series output budget', 51*eseries < F(1,10**117))
total = etime + efreq + 51*eseries + F(51,10**50) + F(51,10**40)
check('total budget including scaled normalized FFT error', total < F(2,10**30))

# Exhaustive coefficient identities in sigma: testing 0 and 1 establishes
# these affine identities, not a numerical sample claim about L-functions.
for a in (0,1):
    for sigma in (F(0),F(1)):
        k, ell = sigma+a, 1-sigma+a
        check(f'reciprocal exponential a{a} s{sigma}', k-2*(a+F(1,2)) == -ell)
        check(f'reciprocal conductor a{a} s{sigma}', -k/2 == F(1,2)-sigma-ell/2)
        check(f'positive Gaussian rate a{a} s{sigma}', k-(a+1) == -(1-sigma))
        check(f'negative Gaussian rate a{a} s{sigma}', ell-(a+1) == -sigma)
        check(f'common conductor amplitude a{a} s{sigma}', -k/2+F(a+1,2) == (1-sigma)/2)

def rat(x):
    return {'numerator': str(x.numerator), 'denominator': str(x.denominator)}
receipt = {'scope': 'Exact scalar and affine-exponent audit only; no FFT or spectral data',
           'producer_sha256': PIN, 'passed': len(checks), 'checks': checks,
           'upper_bounds': {'time': rat(etime), 'frequency': rat(efreq),
                            'series_per_coefficient': rat(eseries), 'total': rat(total)}}
out = HERE / 'review_off_critical_fourier_20261111.json'
out.write_text(json.dumps(receipt, indent=2)+'\n', encoding='utf-8')
print(json.dumps({'passed': len(checks), 'receipt': str(out)}))
