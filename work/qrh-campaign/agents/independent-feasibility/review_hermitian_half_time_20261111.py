"""Independent exact phase, error and saved-count checks; no function values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

BASE = Path(__file__).resolve().parents[1]
PINS = {
    'major-constants/HERMITIAN_HALF_TIME_TRANSFORM_2026-11-11.md': '16BA0E67BF7B674FD29748303DB44CBF0E43808727D053FCC008B3C22886F8A6',
    'major-constants/hermitian_half_time_fft_20261111.py': '7655A0319E84137D611FA20DE0261462EB3098077BA4EABFD5BF4EE2369B9AB6',
    'major-constants/hermitian_half_time_fft_20261111.json': '8630BC8723E8D0658152CD7B807E4E8FE6D68F2C1F236192B1E8B0E09DEA5BB2',
    'audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md': '076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430',
    'zero-sum/REVIEW_SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md': '5683768E8F7B8B93FD4CD2E45CDBED40BFA9CC1BAE238CF920A22B40FEBB820A',
    'major-constants/SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md': '8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9',
    'prime-estimates/small_family_theta_inventory_final_20261111.json': '26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69',
}
checks = 0
def need(ok):
    global checks
    assert ok
    checks += 1

for name, pin in PINS.items():
    need(hashlib.sha256((BASE/name).read_bytes()).hexdigest().upper() == pin)

# Separate even/odd coefficients. All checks are congruences, not root values.
for n in [8, 16, 32, 64, 128]:
    m = n//2
    for f in range(n):
        j = f % m
        upper = int(f >= m)
        for r in range(m):
            need((2*r*f - 2*r*j) % n == 0)
            need(((2*r+1)*f - (2*r*j+j+upper*m)) % n == 0)
    for j in range(1, m):
        need((m-j - (m + (-j))) % n == 0)
    for jmax in range(1, n//4):
        positive = set(range(1, jmax+1))
        negative = {m-j for j in positive}
        need(positive.isdisjoint(negative))
        need(0 not in positive | negative)
        twiddle_exponents = {2*j for j in range(m//2)}
        union = twiddle_exponents | positive
        need(len(union) == n//4 + (jmax+1)//2)
        need(union <= set(range(n//2)))

B = 3125000000001
delta = F(5,64)
need(2*B+1 < 2**43)
need(4*(2*B+1) < 2**46)
need((2*B+1)*2**30 < 2**74)
precision = []
for theta, bits in [(64,244), (128,345)]:
    eps = F(1, 2**82 * 3**theta)
    for depth in range(18,32):
        n = 2**depth
        m = n//2
        jmax = (25*n+191)//192
        need(jmax < m//2)
        need(2*jmax+1 < n)
        ctime = 2*depth+4
        h = F(44,7*n)*1/delta
        exact_gate = eps*delta / (448*ctime*(B+1))
        for label, u in [('inherited', exact_gate), ('optional', F(1,2**bits))]:
            phase_error = (B+1)*u
            input_error = (2+u)*phase_error + (B+2)*u
            need(phase_error < 1)
            need(input_error <= (3*B+5)*u)
            need(u <= F(1,2*depth))
            propagated = input_error
            for _ in range(depth-1):
                propagated = (1+u/2)*propagated + (B+2)*u
            bound = (2*(3*B+5)+(depth-1)*(2*B+4))*u
            need(propagated <= bound)
            need(bound <= ctime*(B+2)*u)
            need(bound < 1)
            need(m*bound < eps/(64*h))
            if label == 'inherited':
                need(m*bound < eps*n*delta/448)
            precision.append({'theta':theta, 'depth':depth, 'gate':label, 'passed':True})

source = json.loads((BASE/'prime-estimates/small_family_theta_inventory_final_20261111.json').read_text())
author = json.loads((BASE/'major-constants/hermitian_half_time_fft_20261111.json').read_text())
rows = []
for s in source['scenarios']:
    t = s['totals']
    S, old, J, C = [t[k] for k in ['time_dft_complex_outputs','time_butterflies','frequency_conjugate_copies','primitive_labels']]
    need(C == 18477108)
    # Both saved parity channels must sum to the same complete domain.
    for field in ['time_dft_complex_outputs','time_butterflies','frequency_conjugate_copies','primitive_labels']:
        need(sum(v[field] for v in s['by_conductor_parity'].values()) == t[field])
    half = (2*old-S)//4
    need(4*half == 2*old-S)
    products = half+J
    need(products < old)
    r = {'extra_nodes':s['extra_nodes'], 'theta':s['theta'],
         'full_time_butterflies':old, 'full_time_complex_slots_sum':S,
         'positive_coefficients_sum':J, 'half_time_butterflies':half,
         'packed_complex_products':products, 'packed_complex_additions':2*products,
         'packed_complex_rounds':3*products+C, 'packing_complex_products':J,
         'packing_complex_additions':2*J, 'packing_complex_rounds':3*J+C,
         'half_time_complex_slots_sum':S//2, 'raw_real_outputs_sum':S,
         'complex_product_reduction':old-products, 'labels_preserved':C}
    match = [a for a in author['whole_family_rows'] if (a['extra_nodes'],a['theta']) == (s['extra_nodes'],s['theta'])]
    need(len(match) == 1)
    for key, value in r.items():
        need(match[0][key] == value)
    rows.append(r)
need(len(rows) == 8)
for k in range(18,32):
    n=2**k; j=(25*n+191)//192
    old=n*k//2; half=(n//2)*(k-1)//2
    need(old-half == n*(k+1)//4)
    need(old-half-j > 0)
    need(3*old-(3*(half+j)+1) > 0)
    # Formal affine-in-B comparison in (5), not a numeric substitution.
    need(2*3+(k-1)*2 == 2*k+4)
    need(2*5+(k-1)*4 == 4*k+6)
    need(2*(2*k+4)-(4*k+6) == 2)
    for row_B in [1,2,2*312500**2+1,2*625000**2+1,B]:
        need(F(row_B+2, row_B+1) < 2)
        row_u=F(1,2**82)*delta/(448*(2*k+4)*(row_B+1))
        need((row_B+1)*row_u < 1)
        need((2*k+4)*(row_B+2)*row_u < 1)

out = {'status':'PASS_EXACT_METADATA', 'scope':'symbolic phase congruences, rational error recurrence and saved metadata only',
       'checks':checks, 'pins':PINS, 'precision_rows':precision, 'whole_family_rows':rows}
destination=Path(__file__).with_suffix('.json')
with destination.open('x', encoding='utf-8') as stream:
    json.dump(out, stream, indent=2)
    stream.write('\n')
print(json.dumps({'checks':checks, 'sha256':hashlib.sha256(destination.read_bytes()).hexdigest().upper()}))
