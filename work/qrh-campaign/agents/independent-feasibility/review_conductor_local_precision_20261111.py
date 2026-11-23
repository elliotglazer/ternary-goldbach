"""Frozen-paper hashes and fixed rational constants only; no inventory parsing."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
BLUEPRINT = AGENTS.parent.parent / 'qrh-blueprint'
AUTHOR = AGENTS / 'major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md'
EXPECTED = '1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A'
checks = []
def check(name, predicate):
    assert predicate, name
    checks.append(name)
def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()
check('author pin', sha(AUTHOR) == EXPECTED)
pins = []
for rel, expected in re.findall(r'^\|([^|]+)\|([0-9A-F]{64})\|$', AUTHOR.read_text(encoding='utf-8'), re.M):
    path = BLUEPRINT / rel[len('blueprint/'):] if rel.startswith('blueprint/') else AGENTS / rel
    actual = sha(path)
    check('pin ' + rel, actual == expected)
    pins.append({'path': rel, 'sha256': actual})
check('eleven author dependencies', len(pins) == 11)
two = lambda k: F(2**k) if k >= 0 else F(1, 2**(-k))
sg = 202305920
cg = 1266 * sg * 2**14
check('global intrinsic coefficient', cg == 4196258524692480)
tail = F(927193523, 10**9) * two(-46)
fixed = tail + 135*(two(-82)+4*two(-63)) + 10*two(-54)+93*two(-55)+two(-51)
eps = cg * two(-108)
direct = tail + 5*(27*(eps+two(-82)+4*two(-63))+2*two(-54)+2*two(-55)) + 83*two(-55)+two(-51)
total = fixed + 135*eps
check('complete composition identity', total == direct)
ratio = total / two(-45)
check('exact p108 ratio', ratio == F(2804840254168152529, 4294967296000000000))
check('outward p108 ceiling', ratio < F(653052762, 10**9))
check('retained earlier ceiling', F(653052762,10**9) < F(691,1024))
check('positive remaining intrinsic allowance', total > fixed)
check('p100 old D safety', 2**100 >= 29961461170177)
check('p100 old peak safety', 2**100 >= 2*424706204)
check('uniform conductor factor', 4*265800 < 1266**2)
check('p100 sufficient axis sum', 256*790257 == 202305792 < sg)
check('next integer fails old-factor threshold', 256*790258 > sg)
for p in range(100,109):
    check('positive squared test factor p'+str(p), 2**(2*(108-p)) > 0)
    if p < 108:
        check('squared test relaxes by four p'+str(p), 2**(2*(108-p)) == 4*2**(2*(108-(p+1))))
check('one precision per conductor', 108-100+1 == 9)
check('cache length bound', 9*6004 == 54036)
check('bounded plan states', 9*37117 == 334053 < 1000000)
check('guards within source cap', F(26525,4) < 7000)
result = {
    'scope': 'Fixed rational constants and source hashes only. No conductor/axis inventory parsed, no author imported, no analytic values or builds.',
    'author_sha256': EXPECTED,
    'script_sha256': sha(Path(__file__)),
    'checks': checks,
    'check_count': len(checks),
    'pins': pins,
    'complete_radius_ratio': str(ratio),
    'fixed_radius': str(fixed),
    'intrinsic_allowance': str(eps),
    'nine_precision_kernel_entry_upper': 9*337702368,
}
out = HERE / 'review_conductor_local_precision_20261111.json'
with out.open('x', encoding='utf-8', newline='\n') as stream:
    json.dump(result, stream, indent=2)
    stream.write('\n')
print(json.dumps({'checks': len(checks), 'script_sha256': result['script_sha256'], 'receipt_sha256': sha(out)}))
