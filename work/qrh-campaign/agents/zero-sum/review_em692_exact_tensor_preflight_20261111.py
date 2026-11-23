"""Fixed paper/schema checks only; no assignment, inventory, or author imports."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    'major-constants/EM692_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md': '01BC1696B7AF781D5638968A18E551014658B86986823B2C65F7AAE15433292A',
    'audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md': '03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904',
    'prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md': '1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328',
    'independent-feasibility/FULL_P20_GRID60_MAGNITUDE_SCOPE_COMPANION_2026-11-11.md': 'FE52146FBF51009631A9E232492A141053B9936AA90EB1B4017FE7A8D0021A5E',
    'major-constants/REVIEW_FULL_P20_GRID60_MAGNITUDE_SCOPE_2026-11-11.md': '5140949742F0BF54941815DCFC8C34DEB96133A89517FE7EBC874380A03B2EBE',
    'zero-sum/FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md': 'F0B7399E638A7EBD43FE37F9EAAD8DCFB0583FEA785F7425D9DAFF096D464DE6',
    'integration/REVIEW_FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md': '372F685F72449A11C970ADD855EB5CB64D52E4512B669DB1AD2FC6102FB6DD37',
    'prime-estimates/TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md': '5E3B9FCDC374998149ABBF3262BF925E0D02C6BFBF399462D1C34ABB68218F6F',
    'major-constants/REVIEW_TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md': 'E7482930B1A6B57FD6C186AD4612E655379D0978DD6C5EDA9C4D4D6D247920F5',
    'major-constants/COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md': 'EBA33B23C531312243495B9B0321597FC26D8AEBA8E1CF24626457474EA3A997',
    'integration/REVIEW_COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md': '8745235D810A1F06E8661961A05EF93C8DB24574121700DF6D924AE6EC2615C4',
}
checks = []
def check(name, condition):
    if not condition:
        raise AssertionError(name)
    checks.append(name)

pins = []
for relative, expected in PINS.items():
    with (AGENTS / relative).open('rb') as stream:
        data = stream.read(256 * 1024 + 1)
    check('bounded paper ' + relative, len(data) <= 256 * 1024)
    actual = hashlib.sha256(data).hexdigest().upper()
    check('pin ' + relative, actual == expected)
    pins.append({'path': relative, 'sha256': actual, 'bytes': len(data)})

S = 202305920
Cg = 4196258524692480
check('Cg normalization', Cg == 1266 * S * 16384)
check('source magnitude p50', F(690) + 1 + F(1, 2**50) < 692)
check('allowed magnitude parameter', 1 <= 692 <= 16384)
check('tensor denominator positive', S < 2**28 < 2**50)
check('old local safety floor', 29961461170177 < 2**45 < 2**50)
check('old peak safety floor', 849412408 < 2**30 < 2**50)
check('three bit lower endpoint', 80 - 3 == 77)
check('three bit upper endpoint', 105 - 3 == 102)
check('three bit safety', 2**77 > max(29961461170177, 849412408))
check('intrinsic denominator loss', F(S, 2**77) < F(1, 64))
ratio = F(8 * 692 * 64, 8828 * 63)
check('ratio reduction', ratio == F(88576, 139041))
check('strict two thirds ratio', ratio < F(2, 3))
check('ratio gap', F(2, 3) - ratio == F(4118, 139041))
check('regrid independent third', 3 * 633 * 2**31 < Cg)
check('combined strict target', ratio + F(633 * 2**31, Cg) < 1)
check('old tensor factor strengthens bound', F(2**52, 2**52-1) > 1)

# Verify the cleared numerator as a polynomial in rho,S,T.
def mul(a, b):
    out = {}
    for x, cx in a.items():
        for y, cy in b.items():
            key = tuple(i+j for i,j in zip(x,y))
            out[key] = out.get(key, 0) + cx*cy
    return {k:v for k,v in out.items() if v}
w = {(1,0,1):1, (1,1,0):-1, (0,1,1):692}
expected_square = {
    (2,0,2):1, (2,1,1):-2, (2,2,0):1,
    (1,1,2):1384, (1,2,1):-1384, (0,2,2):692**2,
}
check('exact W square cross terms', mul(w,w) == expected_square)
check('zero S still has rho T', {k:v for k,v in w.items() if k[1] == 0} == {(1,0,1):1})
check('nonnegative selector exponent', 2*(108-50) == 116 and 2*(108-108) == 0)

# This is a seven-size literal ledger, not reads of the seven JSON inputs.
sizes = [25110201,1911933,9568390,2672728,137719,13957,41665]
check('input bytes', sum(sizes) == 39456593)
check('individual encoded input cap', max(sizes) < 32 * 2**20)
check('aggregate encoded input cap', sum(sizes) < 64 * 2**20)
check('59 precision labels', 108-50+1 == 59)
check('53 actual search labels', 102-50+1 == 53)
check('compact mask decimal capacity', len(str(2**59-1)) == 18)
record_cases = [(125399,108,13), (37116,2**59-1,27), (6003,2**59-1,26)]
for a,b,bound in record_cases:
    check('record bytes ' + str(bound), len(json.dumps([a,b],separators=(',',':')).encode())+1 == bound)
for count,per_record,expected,cap in [(125400,13,1630200,3),(37117,27,1002159,3),(6004,26,156104,2)]:
    check('array record bound ' + str(count), count*per_record == expected)
    check('wrapper cap ' + str(count), expected + 2**20 <= cap*2**20)
check('substantive rows', 125400+37117+6004 == 168521 < 200000)
check('four file caps and reserve', 3+3+2+1+3 == 12)
check('candidate loop ceiling', 125400*53 == 6646200)
check('interface loop ceiling', 125400*59 == 7398600)
check('inherited chosen/predecessor ceiling', 125400*3*2 == 752400)
check('edges per closure', 37117*2 == 74234)
check('new node bit ceiling', 37117*59 == 2189903)
check('new kernel bit ceiling', 6004*59 == 354236)
check('four alternative node bit ceiling', 37117*(9+9+29+59) == 3934402)
check('four alternative kernel bit ceiling', 6004*(9+9+29+59) == 636424)
check('future selector scalar capacity', (2*(19+147)+116) < 1024)

result = {
    'scope':'fixed rational, polynomial and static schema checks; paper hash reads only',
    'author_imported_or_executed':False,
    'inventory_json_read':False,
    'precision_population_or_mask_computed':False,
    'checks':len(checks), 'check_names':checks, 'paper_pins':pins,
    'input_size_ledger_only':sizes,
    'three_bit_intrinsic_ratio':[ratio.numerator,ratio.denominator],
    'three_bit_regrid_target_ratio':[633*2**31,Cg],
    'no_execution_authorization':True,
}
out = HERE / 'review_em692_exact_tensor_preflight_20261111.json'
encoded = (json.dumps(result,indent=2)+'\n').encode()
assert len(encoded) < 64*1024
with out.open('xb') as stream:
    stream.write(encoded)
print(json.dumps({'checks':len(checks),'receipt_bytes':len(encoded),'receipt_sha256':hashlib.sha256(encoded).hexdigest().upper()}))
