"""Exact scalar evidence only; no analytic evaluations or proof builds."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parent.parent
PINS = {
    'qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md': 'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
    'qrh-campaign/agents/audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md': '2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A',
}
for name, expected in PINS.items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest().upper() == expected

N, D, P, V, m = 1500, 4096, 28, 7000, 224
W = V + 32 + 2*m
r = F(W, 6*(N+1))
rem = F(4*(N+2), 1)/F(4*m-1, 2)*r**(2*m)
checks = []
def check(name, result):
    assert result, name
    checks.append(name)

check('r below retained contraction bound', r < F(17,20))
check('scaled rising factor below one', F(W,D*(N+1)) < 1)
check('complete remainder', rem < F(1,2**116))
fact = 1
for k in range(P):
    if k: fact *= k
    kth = F(4*(N+2),1)/F(2*k+4*m-1,2)*F(W,D*(N+1))**k/fact*r**(2*m)
    check(f'order {k} remainder', kth <= rem)

delta, u, eta = F(1,2**118), F(1,2**122), F(1,2**100)
seed = 10507*delta + 278753*u + rem
check('retained seed bound', seed < F(107,1000)*eta)
check('retained output bound', 2*seed + 351*F(1,2**110) < F(557,1000)*eta)
check('correction errors below old allowance', 31*m <= 7936)
check('source domain', F(1,2)+2*m > 1)
slots = P*(D+1)
saved_gamma = (256-m)*slots
saved_e = 2*(256-m)*(D+1)
check('gamma savings', saved_gamma == 3670912)
check('E savings', saved_e == 262208)
rows = {}
for H in (20199,20366,20519,20839):
    rows[str(H)] = {
        'gamma_scales_saved': H*saved_gamma,
        'gamma_additions_saved': H*saved_gamma,
        'E_stages_saved': H*saved_e,
    }
result = {
    'scope': 'exact scalar metadata, not numerical function certificates',
    'parameters': {'V':V,'D':D,'N':N,'P':P,'m':m,'W':W},
    'remainder': str(rem),
    'seed_over_eta': str(seed/eta),
    'checks': checks,
    'per_height': {'gamma_terms':m*slots,'E_stages':(P+2*m-2)*(D+1),
                   'gamma_scales_saved':saved_gamma,'E_stages_saved':saved_e},
    'prefix_savings': rows,
    'pins': PINS,
}
out = Path(__file__).with_name('joint_seed_m224_20261111.json')
if out.exists():
    assert json.loads(out.read_text(encoding='utf-8')) == result
else:
    out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(f'PASS {len(checks)} exact checks; {len(PINS)} input pins')
print(json.dumps(result['per_height']))
