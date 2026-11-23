"""Reviewer-owned exact assembly arithmetic and input pin check. No producer imports."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
A = 'work/qrh-campaign/agents/'
S = 'work/qrh-blueprint/turing-scalars/'
PINS = {
 A+'integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md': '72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C',
 S+'ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md': '0875B2B87A02421B7B8CD6CAD0D1C33433A051E240F48EA4C5F45FE04558BD27',
 A+'integration/REVIEW_ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md': '696E6E8B9C73D3AE3593F2D5C1386E4B386048DA046915CD976C0A43425D7E94',
 A+'audit/TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md': 'A8D21679E5BF2C631D7399D73A70E85E3486EBC6A92CC1668C5060E77E2E11C9',
 A+'integration/REVIEW_TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md': 'B4CAE7485D7BB6655D207BEB2E1716A904F637E36753C48EF5D15FD1A6B41992',
 A+'mellin/LITTLEWOOD_CANONICAL_LOG_PROOF_PLAN_2026-11-11.md': '6BB683D71E4B96A593E93699B3EEF52CF5443289DED3B1CEE06B3C232B7253D9',
 A+'audit/REVIEW_LITTLEWOOD_CANONICAL_LOG_PROOF_PLAN_2026-11-11.md': '1F477AC1CC894AFAD6D4714143B3C4DEC3C0E91330F16F2E1FA27106C56D84EB',
 S+'ZETA_LOG_INTEGRAL_2026-11-11.md': '66DCFC80712A8773682D23F2121BB05A2494CEE1AD7EB7A975EEAED7B399852E',
 A+'integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md': '262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2',
 A+'zero-sum/FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md': '740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF',
 A+'zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md': '6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4',
 A+'major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md': '3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58',
 'work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean': '5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341',
}

def check_pins():
    for name, expected in PINS.items():
        actual = hashlib.sha256((ROOT/name).read_bytes()).hexdigest().upper()
        assert actual == expected, (name, expected, actual)

check_pins()
checks = {}
def equal(name, x, y):
    assert x == y, (name, x, y)
    checks[name] = str(x)
def positive(name, x):
    assert x > 0, (name, x)
    checks[name] = str(x)

upper_a, upper_b = F(1717,500), F(3,4)
lower_a, lower_b = F(128), F(21)
pilo = F(157,50)
equal('upper_intercept_from_compact_and_J', F(9,4)+F(148,125), upper_a)
equal('unrounded_lower_intercept', 21*6+F(148,125), F(15898,125))
positive('lower_rounding_margin', lower_a-F(15898,125))
equal('difference_intercept', upper_a+lower_a, F(65717,500))
equal('difference_slope', upper_b+lower_b, F(87,4))
# Coefficient vectors in (1,Z1,Z2). No sampled endpoint comparisons.
common = (upper_a+lower_a,F(0),upper_b+lower_b)
forward = (upper_a+lower_a,lower_b,upper_b)
reverse = (upper_a+lower_a,upper_b,lower_b)
equal('forward_slack_coefficients', tuple(x-y for x,y in zip(common,forward)), (F(0),-lower_b,lower_b))
equal('reverse_slack_coefficients', tuple(x-y for x,y in zip(common,reverse)), (F(0),-upper_b,upper_b))
equal('final_intercept_margin', 42*pilo-common[0], F(223,500))
equal('final_slope_margin', F(693,100)*pilo-common[2], F(51,5000))
positive('final_intercept_margin_positive', F(223,500))
positive('final_slope_margin_positive', F(51,5000))
positive('Z_positive_domain', 2*50-2*F(22,7))
equal('two_channel_intercept', 2*F(42), F(84))
equal('two_channel_slope', 2*F(693,100), F(693,50))
equal('per_channel_surcharge_intercept_over_historical', F(42)-F(18397,10000), F(401603,10000))
equal('per_channel_surcharge_slope_over_historical', F(693,100)-F(621,5000), F(34029,5000))
check_pins()
out = {
 'status': 'PASS_EXACT_ASSEMBLY_ARITHMETIC_AND_13_PINS',
 'scope': 'Exact rational joins only; no analytic theorem, interval replay, family data or saturation claim.',
 'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
 'pins': PINS,
 'checks': checks,
}
dest = Path(__file__).with_suffix('.json')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(out['status'], 'checks='+str(len(checks)))
