"""Exact rational review only; no analytic function or evaluator execution."""
from fractions import Fraction as F
from pathlib import Path
from hashlib import sha256
import json
import re

ROOT = Path(__file__).resolve().parents[4]
NOTE = ROOT / 'work/qrh-campaign/agents/zero-sum/SHARP_VERTICAL_SOURCE_JOIN_2026-11-11.md'
PIN = 'FBB5FC9E71CB2199F36331D7BB8AFE1E565A3D8C01F95E0CECF69A9D775D0AA4'
assert sha256(NOTE.read_bytes()).hexdigest().upper() == PIN
body = NOTE.read_text(encoding='utf-8')
sources = {}
for rel, expected in re.findall(r'\| ([A-Za-z0-9/]+\.lean) \| `([A-F0-9]{64})` \|', body):
    actual = sha256((ROOT / 'work/ternary-goldbach/TernaryGoldbach' / rel).read_bytes()).hexdigest().upper()
    assert actual == expected, rel
    sources[rel] = actual
assert len(sources) == 7

checks = {}
def check(label, value):
    assert value, label
    checks[label] = True

check('e1_positive_fourth_partial_sum_gt_8_over_3', F(65,24) > F(8,3))
check('conductor_log_bound', F(8,3)**13 > 300001)
check('DN_constant_log_bound', F(8,3)**8 > F(512)/F('.355'))
check('DN_lt150', 8+9*13+13 < 150)
check('log2_tangent_integral_gt_5_over_8', F(2,3) > F(5,8))
check('logarithmic_prefactor_lt8', 2/F(5,8)+F('4.8') == 8)
check('star_selected900', 300*F('2.74517') == F('823.551') < 900)
check('star_optional308', 112*F('2.74517') == F('307.45904') < 308)
check('zero0_selected600', 300*F('1.92182') < 600)
check('zero0_optional216', 112*F('1.92182') == F('215.24384') < 216)
check('plus_vertical106000', F('129.24')*300*F('2.72') == F('105459.84') < 106000)
check('plus_zero039000', 300*F('129.24') == 38772 < 39000)
check('plus_and_base_rate', F('.28')/600001 > F('4e-7'))
check('major_star_rate', F('.28')/(1+F(600000,49)) > F('2e-5'))
check('thP_cap', F(1,200) > F('4e-7'))

def v(k, theta):
    return k*8*(187*2/theta + F('2.6')*2/theta**2)
vp, vs, vb = v(106000,F('4e-7')),v(900,F('2e-5')),v(900,F('4e-7'))
check('Vp_exact', vp == 27560792880000000000)
check('Vs_exact', vs == 93734640000000)
check('Vb_exact', vb == 234006732000000000)
check('x_negative_power', F('4.9e26')**3 > F(10)**78)
check('y_negative_power', F('1e25')**3 > F(10)**74)
ep, es, eb = vp*F('1e-39')/6, vs*F('1e-37')/6, vb*F('1e-37')/6
check('plus_vertical_allowance', ep < F('4.6e-21'))
check('star_vertical_allowance', es < F('1.567e-24'))
check('base_vertical_allowance', eb < F('4e-21'))
check('plus_with_conditional_zero0', ep+400*39000/F('4.9e26') < F('4e-20'))
check('major_star_with_conditional_zero0', es+400*600/F('1e25') < F('2.8e-20'))
check('base_star_with_conditional_zero0', eb+400*600/F('1e25') < F('2.8e-20'))
check('selected_allowance', F('4e-20') < F('1e-18'))

out = {'scope':'exact rational checks and source hashes only; zero0 multiplicity remains an input',
       'author_sha256':PIN, 'sources':sources, 'checks':checks,
       'exact_vertical_caps':{'plus':str(vp),'major_star':str(vs),'base_star':str(vb)}}
dest = Path(__file__).with_suffix('.json')
dest.write_text(json.dumps(out,indent=2,sort_keys=True)+'\n',encoding='utf-8')
print(f'PASS: {len(checks)} exact checks; {len(sources)} source pins')
