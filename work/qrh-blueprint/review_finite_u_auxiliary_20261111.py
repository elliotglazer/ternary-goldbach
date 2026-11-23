"""Independent exact check of saved auxiliary-EM scalar witnesses.

No producer imports, function evaluation, or writes. General analytic soundness
and termination arguments are reviewed separately in the companion report.
"""
import hashlib
import json
from fractions import Fraction
from pathlib import Path

receipt = Path(__file__).resolve().parents[1] / 'qrh-campaign/agents/prime-estimates/finite_u_auxiliary_extension_20261111.json'
assert hashlib.sha256(receipt.read_bytes()).hexdigest().upper() == '978D65992310A5F871F2104F5E88D0BC6F18D4F13F759EEADFDF71FB7A2A89EB'
rows = json.loads(receipt.read_text(encoding='utf-8'))['rows']
checks = 0


def check(condition):
    global checks
    assert condition
    checks += 1


def rational(pair):
    return Fraction(int(pair[0]), int(pair[1]))


def factorial(n):
    value = 1
    for k in range(2, n + 1):
        value *= k
    return value


for row in rows:
    requested = rational(row['requested_U'])
    height = rational(row['U'])
    check(height == Fraction(-(-(32 * requested).numerator // (32 * requested).denominator), 32))
    ceiling = -(-height.numerator // height.denominator)
    c, p = row['c'], row['p']
    m, k, order, pole_order = row['M'], row['K'], row['P'], row['Qpole']
    eps = Fraction(1, 1 << p)
    n = ceiling + 2 * m + 4
    x = c * (n + 1)
    check((n, x) == (row['N'], row['X']))
    em = lambda j: Fraction(1600 * c * (ceiling + 2 * j + 5), 36**j * (800 * j - 203))
    taylor = lambda j: Fraction(32 * x * x, 15 * 16**j)
    moment = lambda j: Fraction(2 * x, factorial(j))
    pole = lambda j: Fraction(3 * x * x.bit_length()**(k - 1), n * factorial(j) * (j + 1))
    for key, function, selected, tolerance in (
        ('EM_bound', em, m, eps / 8), ('Taylor_bound', taylor, k, eps / 8),
        ('moment_bound', moment, order, eps / 8), ('pole_coefficient_tail', pole, pole_order, eps / 512),
    ):
        check(function(selected) == rational(row[key]))
        check(function(selected) <= tolerance)
        check(selected == 1 or function(selected - 1) > tolerance)
    caps = row['search_caps']
    check(em(caps['M']) < eps / 8)
    check(taylor(caps['K']) < eps / 8)
    check(moment(caps['P']) < eps / 8)
    check(pole(caps['Qpole']) < eps / 512)
    for j in range(1, caps['M']):
        check(18 * em(j + 1) < em(j))
    total = Fraction(3, 2) * (em(m) + taylor(k) + moment(order)) + eps / 30 + eps / 8
    check(total / eps == rational(row['complete_bound_over_eps']))
    check(total <= Fraction(173, 240) * eps < Fraction(3, 4) * eps)
    check(row['example_one_sided_grid']['J'] == 32 * height + 1)
    check(row['old_cap_holds'] == (c * height <= 100_000_000))

check(Fraction(3, 50)**2 + Fraction(1, 64)**2 < Fraction(1, 16)**2)
check(len(rows) == 6)
print(json.dumps({'status': 'PASS', 'exact_checks': checks, 'cases': len(rows),
                  'scope': 'Saved scalar witnesses only; no spectral or Lean proof claim.'}))
