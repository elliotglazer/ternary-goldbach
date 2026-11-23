"""Fixed source pins and rational inequalities only; no values or inventories."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[4]
AGENTS = ROOT / 'work/qrh-campaign/agents'
AUTHOR = AGENTS / 'audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md'
EXPECTED = '03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904'
checks = 0
def ck(p):
    global checks
    assert p
    checks += 1

ck(hashlib.sha256(AUTHOR.read_bytes()).hexdigest().upper() == EXPECTED)
pins = {}
for raw, digest in re.findall(r'^\|([^|]+)\|([0-9A-F]{64})\|$', AUTHOR.read_text(), re.M):
    name = raw.split(',')[0]
    path = ROOT / name if name.startswith('work/') else AGENTS / name
    ck(hashlib.sha256(path.read_bytes()).hexdigest().upper() == digest)
    pins[name] = digest
ck(len(pins) == 9)

eta, remainder = F(1, 2**100), F(1, 2**116)
W = 4*eta + 330*F(1, 2**110)
perturb = 59*F(1, 2**60)
def H(x):
    return 1+x+x*x/(2*(1-x/3))

ck(4*F(1,2)/(1-F(1,2)**2) == F(8,3))
ck(F(1,2)+F(8,18) == F(17,18) < 1)
ck(4*F(17,20)/(1-F(17,20)**2) == F(1360,111))
ck(F(1,2)+F(1360,666) < 3)
ck(F(7009,9006) < F(17,20))
ck(7000**2+F(689,2)**2 < 7009**2)
ck(F(312,635)*F(7009,9006)**318 < remainder)

rows = [(220,14,15,1,60,65), (387,19,20,1,80,85),
        (720,26,27,1,108,113), (1720,41,42,1,168,173),
        (1500,38,39,3,156,163)]
for n,lo,hi,kappa,c0,out in rows:
    ck(lo**2 < n+1)
    ck(n+2 < hi**2)
    ck(F(kappa,lo) < F(1,2))
    ck(4*hi-1+F(kappa,lo)+remainder+eta < c0)

first_shift = 3*(H(F(5,8))-1)
last_shift = 3*(H(F(7,8))-1)
first_eval = 6*(H(F(5,16))-1)
last_eval = F(15,2)*(H(F(7,32))-1)
ck(first_shift == F(795,304))
ck(last_shift == F(1155,272))
ck(first_eval == F(1515,688))
ck(last_eval == F(20895,11392))
ck(first_shift+first_eval < F(79,16))
ck(last_shift+last_eval < F(111,16))
ck(W < 5*eta < F(1,2**90))
ck(F(4,3)*eta < F(1,2**90))
ck(perturb < F(1,2**54))
ck(perturb+W < F(1,16))
ck(perturb+F(4,3)*eta < F(1,16))
for n,lo,hi,kappa,c0,out in rows:
    shift, ev, error = (first_shift, first_eval, W) if n != 1500 else (last_shift, last_eval, F(4,3)*eta)
    ck(c0+shift+ev+error+perturb < out)
ck(first_shift+W < 3)
ck(last_shift+eta < F(9,2))
ck(265800 < 516**2)
ck(173+517 == 690)
ck(163+517 == 680)
ck(690+1+F(1,2**80) < 692)
ck(680+1+F(1,2**80) < 682)

receipt = dict(scope='Fixed rational bounds and source hashes only; no function values or inventories',
               author_sha256=EXPECTED, source_pins=pins, checks=checks,
               output_caps=[r[-1] for r in rows], coarse_caps=[r[-2] for r in rows],
               first_margin=str(5-first_shift-first_eval-W-perturb),
               final_margin=str(7-last_shift-last_eval-F(4,3)*eta-perturb))
dest = Path(__file__).with_suffix('.json')
with dest.open('x', encoding='utf-8') as f:
    json.dump(receipt, f, indent=2)
    f.write('\n')
print(json.dumps(dict(checks=checks, receipt_bytes=dest.stat().st_size,
                     receipt_sha256=hashlib.sha256(dest.read_bytes()).hexdigest().upper())))
