"""Independent fixed scalar review. No inventories, values or author imports."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
AGENTS = HERE.parent
AUTHOR = AGENTS / 'integration'
PINS = {
    'TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md': 'DB2E3B9FF269E551901622B844AF579D7FCE12045F71B66D947CA392FD1A928C',
    'tight_tensor_product_precision_20261111.py': '61C0E6CA85D0A2B4902D5DE4634DFA8B53912FE7B71297C2E1A62A150D609BA9',
    'tight_tensor_product_precision_20261111.json': '40D68D74CBC17CF42DB189B4D9B1D8BD49669724CD0D0771F442AF47DDC9F50A',
}
checks = []
def check(name, condition):
    assert condition, name
    checks.append(name)

data = {}
for name, pin in PINS.items():
    data[name] = (AUTHOR / name).read_bytes()
    check('author pin ' + name, hashlib.sha256(data[name]).hexdigest().upper() == pin)
receipt = json.loads(data['tight_tensor_product_precision_20261111.json'])
for name, pin in receipt['source_pins'].items():
    check('dependency pin ' + name, hashlib.sha256((AGENTS / name).read_bytes()).hexdigest().upper() == pin)
blueprint = ROOT / 'work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md'
check('blueprint pin', hashlib.sha256(blueprint.read_bytes()).hexdigest().upper() == receipt['blueprint_pin'])

S = 202305920
Q = 1 << 72
B = F(Q, Q-1)
V = 1 << 14
C = 1266*S*V
eps = F(C, 1 << 108)
check('global S bound', 0 < S < 1 << 28)
check('strict geometric ratio', F(S, 1 << 100) < F(1,Q))
check('factor reciprocal', B == F(1)/(1-F(1,Q)))
check('factor comparison', 1 < B < 2)
check('global C', C == 4196258524692480 == receipt['global_C'])
check('saved B', [B.numerator,B.denominator] == receipt['B'])
check('local safety', 29961461170177 < 1 << 100)
check('old peak safety', 2*424706204 < 1 << 100)
check('general q80 factor', 1 < B < F(1 << 52,(1 << 52)-1) < 2)
check('zero intrinsic', B*0 == 0)
check('old selector implication', Q*Q < 4*(Q-1)*(Q-1))
check('one bit not forced by factor alone', 2*B > 2)
for p in range(100,109):
    # Cancel formal phi^2*S_local^2/c from squared intrinsic ratios.
    analytic = (B*V*F(1,1 << p)/eps)**2
    integer = F(Q*Q*(1 << (2*(108-p))), ((Q-1)*1266*S)**2)
    check('squared selector coefficient p'+str(p), analytic == integer)

tail = F(927193523,10**9)*F(1,1 << 46)
alpha = F(1,1 << 82)
rL = eps+alpha+4*F(1,1 << 63)
rDirect = 27*rL+2*F(1,1 << 54)
rY = rDirect+2*F(1,1 << 55)
full = tail+5*rY+83*F(1,1 << 55)+F(1,1 << 51)
fixed = tail+135*(alpha+4*F(1,1 << 63))+10*F(1,1 << 54)+93*F(1,1 << 55)+F(1,1 << 51)
check('full decomposition', full == fixed+135*eps)
check('fixed receipt', fixed == F(*receipt['R_fixed']))
ratio = full*(1 << 45)
check('exact old R108', ratio == F(2804840254168152529,4294967296000000000) == F(*receipt['R108_ratio']))
check('directed upper', ratio < F(653052762,10**9) < F(691,1024))
check('pre conductor factor bound', eps+alpha+2*F(1,1 << 63) < 1)
check('stored transform cap', 516*4033 < 1 << 21)
check('L radius and magnitude', rL < 1 and 4033 < 1 << 12)
check('direct sample radius and magnitude', rDirect < 1 and 108865 < 1 << 17)
check('negative sample radius and magnitude', rY < 1 and 108865 < 1 << 17)
check('guard domain', F(26525,4) < 7000)
check('no assignment claim', receipt['precision_counts_computed'] is False)

out = {'scope':'Fixed rational checks and pinned Markdown only; no inventory or numerical values.',
       'checks':len(checks),'assertions':checks,'author_pins':PINS,
       'dependency_pins':receipt['source_pins'],'blueprint_pin':receipt['blueprint_pin'],
       'R108_ratio':[ratio.numerator,ratio.denominator],
       'author_program_executed':False,'inventories_read':False}
encoded = (json.dumps(out,indent=2,sort_keys=True)+'\n').encode()
path = HERE / 'review_tight_tensor_precision_20261111.json'
with path.open('xb') as stream:
    stream.write(encoded)
print(json.dumps({'checks':len(checks),'bytes':len(encoded),'sha256':hashlib.sha256(encoded).hexdigest().upper()}))
