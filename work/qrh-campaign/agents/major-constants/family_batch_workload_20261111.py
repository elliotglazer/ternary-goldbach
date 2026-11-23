"""Full arithmetic family model. No L-values, FFTs, or spectral samples."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

M = 300000
phi = list(range(M + 1))
spf = list(range(M + 1))
for p in range(2, M + 1):
    if spf[p] == p:
        for n in range(p, M + 1, p):
            phi[n] -= phi[n] // p
            if spf[n] == n:
                spf[n] = p
# Independent divisor inversion, not the primitive prime-power recurrence.
primitive = phi.copy()
primitive[1] = 1
for d in range(1, M + 1):
    for n in range(2 * d, M + 1, d):
        primitive[n] -= primitive[d]

def factors(n):
    out = []
    while n > 1:
        p, e = spf[n], 0
        while n % p == 0:
            n //= p
            e += 1
        out.append((p, e))
    return out

def dims(fs):
    out = []
    for p, e in fs:
        if p != 2:
            out.append((p - 1) * p ** (e - 1))
        elif e == 2:
            out.append(2)
        elif e >= 3:
            out.extend([2, 2 ** (e - 2)])
    return out

def ceilf(x):
    return -(-x.numerator // x.denominator)

def height(c):
    qt = c if c % 2 == 0 else 2*c
    hp = 200 + max(1000, ceilf(F(704 * 1200000, 7 * qt)))
    return min(F(hp), F(100000000, c))

names = ['primitive_outputs', 'unit_coefficients', 'direct_matrix_products',
         'tensor_direct_products', 'padded_three_fft_butterflies',
         'padded_pointwise_and_chirp_products']
totals = {k: 0 for k in names}
weighted_t = {k: 0 for k in names}
scale = 10**6
height_bounds = {k: [0, 0] for k in names}
groups = {}
maxima = {k: [0, None] for k in ['phi', 'primitive', 'axes', 'axis_order', 'padded_axis', 'height']}
row_digest = hashlib.sha256()
count = 0
for c in range(2, M + 1):
    if not ((c <= 150000 and c % 2 == 1) or c % 4 == 0):
        assert not primitive[c] or c > 150000
        continue
    a = primitive[c]
    assert a > 0
    fs = factors(c)
    expected = 1
    for p, e in fs:
        expected *= p-2 if e == 1 else p**(e-2)*(p-1)**2
    assert a == expected
    ds = dims(fs)
    product = 1
    for m in ds:
        product *= m
    assert product == phi[c]
    butterflies = pointwise = maxpad = 0
    for m in ds:
        P = 1 << (2*m-2).bit_length()
        d = P.bit_length()-1
        assert P >= 2*m-1 and P < 2*(2*m-1)
        fibers = phi[c]//m
        butterflies += fibers * 3 * (P//2) * d
        pointwise += fibers * (P + 2*m)
        maxpad = max(maxpad, P)
    weights = dict(zip(names, [a, phi[c], a*phi[c], phi[c]*sum(ds), butterflies, pointwise]))
    h = height(c)
    t = h.numerator // h.denominator + 1
    assert h < t <= h + 1
    key = ('odd' if c % 2 else 'four_divides') + ':' + str(c.bit_length()-1)
    g = groups.setdefault(key, {'conductors':0, 'primitive_outputs':0, 'unit_coefficients':0,
                                'primitive_T0':0, 'unit_T0':0})
    g['conductors'] += 1
    g['primitive_outputs'] += a
    g['unit_coefficients'] += phi[c]
    g['primitive_T0'] += a*t
    g['unit_T0'] += phi[c]*t
    for k, w in weights.items():
        totals[k] += w
        weighted_t[k] += w*t
        z = h*w*scale
        height_bounds[k][0] += z.numerator//z.denominator
        height_bounds[k][1] += ceilf(z)
    for k, v in [('phi',phi[c]),('primitive',a),('axes',len(ds)),
                 ('axis_order',max(ds)),('padded_axis',maxpad),('height',h)]:
        if v > maxima[k][0]:
            maxima[k] = [v,c]
    row_digest.update((f'{c}|{a}|{phi[c]}|{h}|{t}|{ds}|{butterflies}|{pointwise}\n').encode())
    count += 1
assert count == 149999
assert totals['primitive_outputs'] == 5543640187
assert groups['odd:1']['primitive_outputs'] == 1  # conductor 3

result = {
    'scope': 'Arithmetic workload only. No spectral data or throughput estimate.',
    'nonprincipal_conductors': count,
    'single_common_point_totals': totals,
    'T0_weighted_totals': weighted_t,
    'Hcert_weighted_bounds': {
        k: {'lower':str(F(lo,scale)), 'upper':str(F(hi,scale)),
            'width':str(F(hi-lo,scale))} for k,(lo,hi) in height_bounds.items()},
    'maxima': {k:{'value':str(v),'conductor':c} for k,(v,c) in maxima.items()},
    'arithmetic_row_digest_sha256': row_digest.hexdigest().upper(),
    'groups_by_modulus_parity_and_floor_log2': groups,
    'grid_formula': 'T0=floor(Hcert)+1; ny=2*rho*T0; S=2*rho*(3*nx+2)*T0+2*nx+1',
    'uncertified_grid_examples': [],
}
for nx,rho in [(1,1),(1,16),(4,16)]:
    result['uncertified_grid_examples'].append({
        'nx':nx,'rho':rho,
        'totals':{k:2*rho*(3*nx+2)*weighted_t[k]+(2*nx+1)*totals[k] for k in names}})
out = Path(__file__).with_suffix('.json')
out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if not k.startswith('groups')},indent=2))
