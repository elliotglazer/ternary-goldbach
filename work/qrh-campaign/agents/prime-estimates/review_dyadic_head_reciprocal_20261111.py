"""Independent scalar/encoding audit; no reciprocal table or function values."""
from fractions import Fraction
from pathlib import Path
import hashlib
import json

Q = Fraction
here = Path(__file__).resolve().parent
root = here.parents[3]
source = here.parent / 'independent-feasibility'
pins = {
    'DYADIC_HEAD_RECIPROCAL_REUSE_2026-11-11.md': 'DB63BE813797CC0DA28F28EEBFEE394BFB2BCC34EFDFA2756F0F9718223F3FB9',
    'dyadic_head_reciprocal_bounds_20261111.py': 'BCB29B2F2254051A9F22532C9576CFD59528AD5040D45454020A7AAA2FED568F',
    'dyadic_head_reciprocal_bounds_20261111.json': '513ABDAC87D274FB518B7E65B156199B832E52187BDE20BEA6824569F09E3D0A',
}
count = 0
def check(test):
    global count
    assert test
    count += 1
for name, digest in pins.items():
    check(hashlib.sha256((source/name).read_bytes()).hexdigest().upper() == digest)
data = json.loads((source/'dyadic_head_reciprocal_bounds_20261111.json').read_text())
for name, digest in data['pins'].items():
    check(hashlib.sha256((root/name).read_bytes()).hexdigest().upper() == digest)

# Reconstruct the source ledger from head and endpoint coefficients.
n, p, b = 1500, 28, 1502
head_delta, head_u = 5*n, 5*n*p + 8*n + 1
endpoint_delta, endpoint_u = 2*b+3, 36*b+2679
check(head_delta+endpoint_delta == 10507)
check(head_u+endpoint_u+1 == 278753)
eta, delta, u, eps = (Q(1,2**k) for k in (100,118,122,130))
remainder = Q(156,1)/Q(635,2) * Q(7009,9006)**318
base = (head_delta+endpoint_delta)*delta + (head_u+endpoint_u+1)*u + remainder
added = 5*n*p*eps
new = base + added
output = 2*new + 351*Q(1,2**110)
for key, value in [('old_over_eta',base/eta), ('added_over_eta',added/eta),
                   ('new_over_eta',new/eta), ('output_over_eta',output/eta)]:
    check(Q(data['error'][key]) == value)
check(added/eta == Q(13125,67108864))
check(new < Q(107,1000)*eta < eta/4)
check(output < Q(557,1000)*eta < eta)
check(2**28 * (new+350*Q(1,2**110)) < 1)
check(remainder < Q(1,2**116))
for k in range(28):
    check(delta+k*(u+eps) < 1)
    check(5*n*k*eps <= added)
    check(7000**2+Q(2*(k+318)-1,2)**2 < 7009**2)

# Union of intervals [4096*(n+1),4096*(n+2)] for n=0,...,1499.
d = 4096
points = (n+1)*d - d + 1
occurrences = n*(d+1)
nonunit = (p-1)*(occurrences-1)
grid = data['grid']
check(points == grid['points'])
check(points-1 == grid['nonunit_points'])
check(occurrences == grid['occurrences'])
check(occurrences-points == n-1)
check((points-1)*130 == 8*grid['nonunit_raw_cache_bytes'])
check((n+1)*d == grid['max_numerator'] < 2**23)
for row, height in zip(data['scenarios'], [20199,20366,20519,20839], strict=True):
    check(row['H'] == height)
    check(row['complex_scalings_including_unity'] == height*(p-1)*occurrences)
    check(row['nonunit_complex_scalings'] == height*nonunit)
    check(row['nonunit_real_products'] == 2*height*nonunit)
    check(row['distinct_nonunit_reciprocals'] == points-1)

# Width and rounding-correction inequalities. No actual reciprocal is generated.
check(2**130 > 1501*(2**119+1))
check((2**123-1)*(2**130-1) < 2**253)
check((2**23-1)*(2**130-1) < 2**153)
check((2**23-1)*(2**123-1) < 2**146)
check(3000*2**122 < 2**134)
check((2**142).bit_length() == 143)
check(2**13 * 2**129 == 2**142)  # Nonunit equality counterexample.
check(2**123*eps == Q(1,128))
check(Q(1,2)+Q(1,128) < 1)
def limbs(bits): return (bits+7)//8
check(limbs(123)*limbs(130) == data['radix256_digit_product_subtotal']['dyadic_per_real_product'])
check(limbs(123)*limbs(23) == data['radix256_digit_product_subtotal']['baseline_quotient_identity_product'])
check(limbs(130)*limbs(23) == data['radix256_digit_product_subtotal']['reciprocal_certificate_product'])

result = {'status':'PASS_WITH_SEPARATE_NONSTRICT_PRODUCT_WIDTH_CLARIFICATION',
          'checks':count, 'source_pins':pins,
          'extra_over_eta':str(added/eta),
          'source_bound_below':'107/1000 eta', 'output_bound_below':'557/1000 eta',
          'valid_product_bits_at_equality':143,
          'scope':'Exact scalar and encoding checks only; no author import, reciprocal table, analytic values, or build.'}
target = Path(__file__).with_suffix('.json')
with target.open('x',encoding='utf-8') as handle:
    json.dump(result,handle,indent=2)
    handle.write('\n')
print(json.dumps(result,indent=2))
