"""Independent saved-pin, exact selector and formal algebra checks. No evaluators."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
BASE = HERE.parent
checks = 0
def check(condition):
    global checks
    assert condition
    checks += 1
def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()

artifacts = {
    'audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md': '96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D',
    'audit/large_character_complete_error_contract_20261111.py': '42C666E3C0F419FCE4795A21D54A22727FEBBF8D49B8EB7F8324ED550FBDE650',
    'audit/large_character_complete_error_contract_20261111.json': '86C2F5441C5E706DEEA1976AC00026E0F3E39FBB492CC31E524C4BC1636091C6',
    'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md': '4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
    'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md': '9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
}
pins = {}
for rel, expected in artifacts.items():
    path = BASE / rel
    check(digest(path) == expected)
    pins[str(path)] = expected
author = json.loads((BASE / 'audit/large_character_complete_error_contract_20261111.json').read_text())
check(len(author['pins']) == 21)
for name, entry in author['pins'].items():
    path = Path(name)
    check(digest(path) == entry['sha256'])
    pins[str(path)] = entry['sha256']
extra = BASE / 'integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md'
pins[str(extra)] = digest(extra)

# Search every smaller integer precision instead of reproducing the author's bit_length selector.
C = 2 * 633 * 202305920 * (1 << 14)
check(C == 4196258524692480 == author['intrinsic_coefficient'])
rows = []
for s, expected in ((60, 112), (82, 134), (100, 152)):
    def valid(p):
        return (1 << p) >= 29961461170177 and (1 << p) >= 2*424706204 and F(C, 1 << p) <= F(1, 1 << s)
    p = next(p for p in range(200) if valid(p))
    check(p == expected)
    check(all(not valid(j) for j in range(p)))
    row = next(r for r in author['precision_rows'] if F(r['epsilon_T']) == F(1, 1 << s))
    check(row['p'] == p and F(row['intrinsic_radius']) == F(C, 1 << p))
    rows.append({'allowance_exponent': s, 'minimal_sufficient_p': p, 'radius': str(F(C, 1 << p))})

# Formal multivariate polynomial identities. These are algebra checks, not analytic values.
def var(name): return {(name,): F(1)}
def plus(*polys):
    out = {}
    for p in polys:
        for m, a in p.items(): out[m] = out.get(m, F(0)) + a
    return {m: a for m, a in out.items() if a}
def neg(p): return {m: -a for m, a in p.items()}
def sub(p, q): return plus(p, neg(q))
def mul(p, q):
    out = {}
    for a, x in p.items():
        for b, y in q.items():
            m = tuple(sorted(a+b))
            out[m] = out.get(m, F(0)) + x*y
    return {m: a for m, a in out.items() if a}
q, qh, true, stored, sh = map(var, ('q', 'qh', 'true', 'stored', 'sh'))
check(plus(mul(q, sub(true, stored)), mul(q, sub(stored, sh)), mul(sub(q, qh), sh)) == sub(mul(q, true), mul(qh, sh)))
e, eh, z, zh, l, lh = map(var, ('e', 'eh', 'z', 'zh', 'l', 'lh'))
check(plus(mul(mul(e,z), sub(l,lh)), mul(mul(sub(e,eh),zh),lh), mul(mul(e,sub(z,zh)),lh)) == sub(mul(mul(e,z),l),mul(mul(eh,zh),lh)))
a, ah, u, uh = map(var, ('a', 'ah', 'u', 'uh'))
check(plus(mul(sub(a,ah),u),mul(ah,sub(u,uh))) == sub(mul(a,u),mul(ah,uh)))
k, kh, y, yh = map(var, ('k', 'kh', 'y', 'yh'))
check(plus(mul(k,sub(y,yh)),mul(sub(k,kh),yh)) == sub(mul(k,y),mul(kh,yh)))
rk, ry, mk, my = map(var, ('rk', 'ry', 'mk', 'my'))
check(plus(mul(plus(mk,rk),ry),mul(my,rk)) == plus(mul(mk,ry),mul(rk,ry),mul(my,rk)))
check(F(1,1 << 82) + F(1,1 << 82) == F(1,1 << 81))

out = {
    'status': 'PASS_SAVED_PINS_SELECTOR_AND_FORMAL_ALGEBRA', 'checks': checks,
    'pins': pins, 'precision_rows': rows,
    'formal_identities': ['scaled L split', 'proxy split', 'amplitude-unit multiplier split', 'interpolation split', 'one kernel/input cross term'],
    'limitations': ['No actual values or margins', 'No new inventory', 'No author code execution', 'No selected complete sign tolerance', 'Analytic proofs checked in accompanying paper review'],
}
dest = HERE / 'review_large_character_complete_error_contract_20261111.json'
with dest.open('x', encoding='utf8', newline='\n') as f:
    json.dump(out, f, indent=2)
    f.write('\n')
print(json.dumps({'checks': checks, 'pins': len(pins), 'receipt_sha256': digest(dest)}))
