"""Exact scalar proof-budget comparisons; no function or circuit evaluation."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent / 'qrh-campaign' / 'agents'
PINS = {
    'audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md': '6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA',
    'major-constants/REVIEW_LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md': '3D8831ABB2BBD69A1AD82389B8A2082DBCE18D5E6C47E73230F6808F0EBFF589',
    'audit/SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md': '32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E',
    'major-constants/REVIEW_SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md': '61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730',
    'integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md': 'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C',
    'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md': 'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
    'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md': '09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
}
checks = 0

def ck(ok):
    global checks
    assert ok
    checks += 1

def fstr(x):
    return f'{x.numerator}/{x.denominator}'

def billionth_upper(x):
    return (x.numerator * 10**9 + x.denominator - 1) // x.denominator

for rel, expected in PINS.items():
    ck(hashlib.sha256((AGENTS / rel).read_bytes()).hexdigest().upper() == expected)

C = 1266 * 202305920 * 2**14
fixed_l = F(1, 2**82) + 4 * F(1, 2**63)
coarse_tail = F(1, 2**46)
sharp_tail = F(927193523, 10**9 * 2**46)
target = F(1, 2**45)
old_strong_target = F(691, 1024) * target
old_loose_target = F(7, 10) * target
rows = []
for p in range(100, 113):
    epsilon = F(C, 2**p)
    pre_scale = F(1, 2**82) + 2 * F(1, 2**63) + epsilon
    r_l = fixed_l + epsilon
    r_direct = 27 * r_l + 2 * F(1, 2**54)
    r_y = r_direct + 2 * F(1, 2**55)
    numeric = 5 * r_y + 83 * F(1, 2**55) + F(1, 2**51)
    r_coarse = coarse_tail + numeric
    r_sharp = sharp_tail + numeric
    ck(p >= 100)
    ck(2**p >= 29961461170177)
    ck(2**p >= 2 * 424706204)
    ck(pre_scale < 1)
    ck(516 * 4033 < 2**21)
    ck(r_l < 1 and 4032 + r_l < 2**12)
    ck(r_direct < 1 and 108864 + r_direct < 2**17)
    ck(r_y < 1 and 108864 + r_y < 2**17)
    ck(F(1, 2**66) * 2**12 + F(1, 2**54) == 2 * F(1, 2**54))
    ck(F(1, 2**72) * 2**17 + F(1, 2**55) == 2 * F(1, 2**55))
    ck(r_sharp < r_coarse)
    fixed_numeric = 5 * (27 * fixed_l + 2 * F(1, 2**54) + 2 * F(1, 2**55)) + 83 * F(1, 2**55) + F(1, 2**51)
    ck(r_coarse == coarse_tail + fixed_numeric + 135 * epsilon)
    rows.append({
        'p': p,
        'epsilon': fstr(epsilon),
        'r_l_upper': fstr(r_l),
        'direct_radius_upper': fstr(r_direct),
        'common_sample_radius_upper': fstr(r_y),
        'coarse_ratio_to_2m45': fstr(r_coarse / target),
        'sharp_ratio_to_2m45': fstr(r_sharp / target),
        'sharp_ratio_billionth_upper': billionth_upper(r_sharp / target),
        'coarse_below_2m45': r_coarse < target,
        'coarse_below_seven_tenths': r_coarse < old_loose_target,
        'sharp_below_old_strong': r_sharp < old_strong_target,
    })

ck(next(r['p'] for r in rows if r['coarse_below_2m45']) == 106)
ck(next(r['p'] for r in rows if r['coarse_below_seven_tenths']) == 108)
ck(next(r['p'] for r in rows if r['sharp_below_old_strong']) == 108)
ck(rows[8]['sharp_ratio_billionth_upper'] == 653052762)
ck(rows[6]['sharp_ratio_billionth_upper'] == 837311263)
ck(F(653052762, 10**9) < F(691, 1024))
ck(F(837311263, 10**9) < F(21, 25))

out = {
    'scope': 'conditional scalar sufficient precision; no values, costs or signs',
    'pins': PINS,
    'checks': checks,
    'C_T': C,
    'nontransform_L_allowance': fstr(fixed_l),
    'sharp_analytic_tail': fstr(sharp_tail),
    'rows': rows,
    'minimal_for_declared_scalar_tests_only': {'coarse_2m45': 106, 'coarse_seven_tenths': 108, 'sharp_old_strong': 108},
    'precision_selected': False,
    'actual_certificates_produced': False,
}
dest = HERE / 'lower_transform_precision_allocation_20261111.json'
with dest.open('x', encoding='utf-8') as f:
    json.dump(out, f, indent=2)
    f.write('\n')
print(json.dumps({'checks': checks, 'receipt': str(dest), 'bytes': dest.stat().st_size,
                  'sha256': hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
