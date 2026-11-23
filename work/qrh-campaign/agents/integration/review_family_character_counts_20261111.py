"""Independent integer count cross-check; does not prove character surjectivity."""
from pathlib import Path
import json
import hashlib
from fractions import Fraction
from math import ceil

LIMIT = 300000
phi = list(range(LIMIT + 1))
mu = [1] * (LIMIT + 1)
mu[0] = 0
primes = []
for p in range(2, LIMIT + 1):
    if phi[p] == p:
        primes.append(p)
        for n in range(p, LIMIT + 1, p):
            phi[n] -= phi[n] // p
            mu[n] = -mu[n]
        for n in range(p*p, LIMIT + 1, p*p):
            mu[n] = 0

# Independently invert phi(n)=sum_{d|n} primitive(d).
primitive = [0] * (LIMIT + 1)
for k in range(1, LIMIT + 1):
    if mu[k]:
        for d in range(1, LIMIT // k + 1):
            primitive[k*d] += mu[k] * phi[d]
assert primitive[1] == 1
assert all(x >= 0 for x in primitive)
assert all(primitive[n] == 0 for n in range(2, LIMIT+1, 4))
odd = sum(primitive[n] for n in range(1, 150001, 2))
four = sum(primitive[n] for n in range(4, LIMIT+1, 4))
active = list(range(1,150001,2)) + list(range(4,LIMIT+1,4))
# Orthogonality gives sum_{all chi mod d} chi(-1)=phi(d) only for d=1,2.
# Mobius inversion therefore gives primitive even-minus-odd = mu(n)+[2|n]mu(n/2).
parity_difference = lambda n: mu[n] + (mu[n//2] if n % 2 == 0 else 0)
assert all((primitive[n] + parity_difference(n)) % 2 == 0 for n in active)
even = sum((primitive[n] + parity_difference(n)) // 2 for n in active)
odd_parity = sum((primitive[n] - parity_difference(n)) // 2 for n in active)
assert even + odd_parity == odd + four
author_receipt = Path(__file__).resolve().parent.parent / 'zero-sum/family_character_manifest_20261111.json'
author_hash = hashlib.sha256(author_receipt.read_bytes()).hexdigest()
assert author_hash == 'df040a89b7e2d8856023b9d36169f741b1cd05b3db6c5d8d1d30c27e855b6eb7'
recorded = json.loads(author_receipt.read_text())['counts']
assert (odd+four, odd, four, even, odd_parity) == tuple(recorded[k] for k in
    ['primitive_characters','odd_conductor_characters','four_divisible_conductor_characters','even_characters','odd_characters'])
for c in active:
    qt = c if c%2==0 else 2*c
    raw = Fraction(704*1200000,7*qt)
    hp = ceil(200+max(Fraction(1000),raw))
    assert hp == 200+max(1000,ceil(raw))
    height = min(Fraction(hp),Fraction(100000000,c))
    assert height > 0
    if str(c) in recorded['height_samples_exact']:
        assert str(height) == recorded['height_samples_exact'][str(c)]
result = dict(kind='exact arithmetic cross-check; not a character coverage proof',
              method='Mobius convolution of Euler phi', odd_cutoff=150000, four_cutoff=300000,
              odd_primitive_total=odd, divisible_by_four_primitive_total=four,
              active_primitive_total=odd+four, includes_principal_conductor_one=True,
              even_character_total=even, odd_character_total=odd_parity,
              author_receipt_sha256=author_hash, exact_height_dispatch_checks=len(active),
              positive_active_conductor_count=sum(primitive[n] > 0 for n in range(1,150001,2))
                  + sum(primitive[n] > 0 for n in range(4,LIMIT+1,4)),
              pilot_counts={str(n): primitive[n] for n in [1,2,4,8,12,16,20,24,40,45,72,120,360]})
target = Path(__file__).with_suffix('.json')
target.write_text(json.dumps(result, indent=2)+'\n', encoding='utf8')
print(json.dumps(result))
