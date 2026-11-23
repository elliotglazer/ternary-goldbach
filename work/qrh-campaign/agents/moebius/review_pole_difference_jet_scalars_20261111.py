"""Exact scalar identities only; no log/exp/phi/L values or jet evaluation."""
from fractions import Fraction as F
from math import comb, factorial
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
AUTHOR = HERE.parent / 'zero-sum' / 'POLE_DIFFERENCE_JET_ENCLOSURE_PLAN_2026-11-11.md'
AUTHOR_SHA = '3F73AF600725DDB51ED622577BF374251B38C408D0D52D4EA06CFCF1BDD60011'

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()

def main():
    assert sha(AUTHOR) == AUTHOR_SHA
    counts = {}
    def check(name, claim):
        assert claim, name
        counts[name] = counts.get(name, 0) + 1
    for h in range(65):
        for k in range(h + 1):
            check('normalized_binomial_weight',
                  F(comb(h, k), factorial(h)) == F(1, factorial(h-k)*factorial(k)))
            # Symbolic coefficient of ell^(h-k)*d^(k+1) at s=1.
            check('removable_value_polynomial_coefficient',
                  F(1, factorial(h-k)*factorial(k)*(k+1))
                  == F(comb(h+1, k+1), factorial(h+1)))
    for q in range(1, 129):
        check('factorial_tail_ratio',
              F(1, factorial(q+2))/F(1, factorial(q+1)) == F(1, q+2))
        for k in range(33):
            check('double_integral_tail_mass',
                  F(1, factorial(q-1))*F(1,q)*F(1,q+k+1)
                  == F(1, factorial(q)*(q+k+1)))
    for r in range(33):
        for offset in range(65):
            check('positive_log_tail_denominator',
                  F(1, 2*r+2*offset+1) <= F(1, 2*r+1))
    for c in range(2, 34):
        for n in range(1, 34):
            check('coarse_strip_prefactor', F(3*(c*n+1), c*n) <= F(9,2))
    for k in range(1, 65):
        check('convolution_term_count', sum(h+1 for h in range(k)) == k*(k+1)//2)
    report = {
        'status': 'PASS_EXACT_SCALAR_IDENTITIES_ONLY',
        'author_sha256': AUTHOR_SHA,
        'script_sha256': sha(Path(__file__)),
        'checks': counts,
        'total_checks': sum(counts.values()),
        'scope': 'Finite rational/combinatorial diagnostics supporting a separate universal paper proof; no transcendental/function/model/FFT evaluation.'
    }
    out = HERE / 'review_pole_difference_jet_scalars_20261111.json'
    if out.exists():
        assert json.loads(out.read_text(encoding='utf-8')) == report
    else:
        out.write_text(json.dumps(report, indent=2)+'\n', encoding='utf-8')
    print(json.dumps(report))

if __name__ == '__main__':
    main()
