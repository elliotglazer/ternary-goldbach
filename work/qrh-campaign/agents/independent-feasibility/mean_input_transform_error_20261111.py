"""Fixed rational witnesses for the paper mean-input error proof. No inventory or values."""
from pathlib import Path
from fractions import Fraction as F
from math import prod
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
PINS = {
    'zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md': 'C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01',
    'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md': '4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
    'audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md': '1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537',
    'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md': 'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
    'independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md': '412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7',
    'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md': '09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
    'audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md': '96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D',
    'audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md': '6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA',
    'independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md': 'B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266',
    'audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md': '03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904',
    'prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md': '1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328',
}
checks = 0
def ck(condition):
    global checks
    checks += 1
    if not condition:
        raise AssertionError(checks)

for path, expected in PINS.items():
    ck(hashlib.sha256((ROOT / path).read_bytes()).hexdigest().upper() == expected)

# Synthetic scalar recurrences, never a gate/input evaluation.
radix = []
for k in (1, 2, 3, 5, 8, 12):
    u = F(1, 2*k)
    coefficient = F(0)
    for j in range(1, k+1):
        coefficient = (1+u)*coefficient + 1 + F(2, 2**j)
    ck((1+u)**k <= 2)
    ck(coefficient <= 2*k+4)
    radix.append([k, str(coefficient), 2*k+4])

for cm, cr in ((0,0), (0,2), (2,0), (2,2), (10,8), (123,77)):
    d_safe = max(1, cm+cr*(2*cm+1))
    u = F(1,d_safe)
    d = cm*(1+u)+1
    ck(d+cr*(1+u*d) == cm+cr+1+u*(cm+cr*d))
    ck(d+cr*(1+u*d) <= cm+cr+2)

blue = []
for n in (2,3,13,257):
    m = 2*n-1
    k = (m-1).bit_length()
    p_pad = 2**k
    r = 2*k+4
    a = 1+3*r
    q_old = 3*n*p_pad*a+1
    q = 3*n*a+n+2
    z = F(n*m,p_pad)+2
    c_old = 6*p_pad*a+2*r*(2*n+1)+8
    c_new = F(9*p_pad*a+3*p_pad,2)+3*r*n+12*r+14
    exact = F(3,2)*F(p_pad*q+r*(n*m+2*p_pad),n)+F(n+1,n)
    ck(2*n <= p_pad < 4*n)
    ck(p_pad*(a+1) < q_old)
    ck(q < q_old)
    ck(n*(a+1)+m*a+(a+1)+1 == q)
    ck(exact <= c_new)
    ck(c_old-c_new == r*(F(9*p_pad,2)+n-10)-6)
    ck(c_old-c_new >= 74)
    ck(z > 1)
    # Original inverse-divide circuit's relaxed post-chirp coefficient.
    ck(F(2*(q_old+r*(n*m+2)+1),n)+1+F(1,n) <= c_old)
    blue.append({'n':n,'P':p_pad,'q':q,'C_old':c_old,'C_new':int(c_new)})

for cs in ((0,), (2,4), (8,10,2), (100,3,77,0)):
    s = sum(cs)
    u = F(1, max(1, 2*s))
    e = F(0)
    for c in cs:
        e = e + c*u*(1+e)
    ck(e == prod(1+c*u for c in cs)-1)
    ck(e <= 2*s*u)

# Only fixed integer products and rational margins; no primality testing.
ck(prod((2,3,5,7,11,13,17)) == 510510 > 265800)
totient_ratio = prod(F(p,p-1) for p in (2,3,5,7,11,13))
ck(totient_ratio == F(1001,192))
ck(265800 < 516**2)
eps = 2*516*F(1,2**63)+F(1,2**80)
ck(eps < 1)
ck(175+2*totient_ratio == F(17801,96) < 186)
ck(165+2*totient_ratio == F(16841,96) < 176)
ck(692 > 3*186)

data = {'scope':'fixed rational witnesses only; no inputs, roots, transforms, conductor inventory or precision selection',
        'checks':checks,'pins':PINS,'radix_scalar_fixtures':radix,'bluestein_scalar_fixtures':blue,
        'mean_augmented_uniform_cap':186,'mean_augmented_final_only_cap':176,
        'runtime_widths':'unchanged sup-norm capacities; not average-based'}
out = HERE / 'mean_input_transform_error_20261111.json'
with out.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(data,f,indent=2)
    f.write('\n')
print(json.dumps({'checks':checks,'receipt':str(out),'sha256':hashlib.sha256(out.read_bytes()).hexdigest().upper()}))
