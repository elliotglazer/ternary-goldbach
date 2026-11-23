"""Exact scalar/pin checks only; no analytic evaluations or author imports."""
from fractions import Fraction as F
from pathlib import Path
import hashlib, json, re

ROOT = Path(__file__).resolve().parents[4]
AUTHOR = ROOT / 'work/qrh-campaign/agents/independent-feasibility/GLOBAL_FINITE_RH_TPLUS_PAPER_ASSEMBLY_2026-11-11.md'
EXPECTED = '24E1A29A0FEAFFA297159DAE04CDD0613C5A38757F5F44B63B01A2B5E5D1280A'
checks = []
def check(name, p):
    assert p, name
    checks.append(name)
def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()
check('author pin', sha(AUTHOR) == EXPECTED)
pins = re.findall(r'\| `(work/[^`]+)` \| `([0-9A-F]{64})` \|', AUTHOR.read_text(encoding='utf-8'))
check('25 table pins', len(pins) == 25)
for path, digest in pins:
    check('pin ' + path, sha(ROOT / path) == digest)
def ceil(x):
    return -(-x.numerator // x.denominator)
R = 132900
check('base coefficient', F('19.89')*3*531600 == 31720572)
check('base dominance', F('19.89')*3*531600 > 27000000)
check('star coefficient dominance', F('19.89')*3 > F(704,343))
check('star floor dominance', 460 > 300)
check('Tplus four', ceil(200 + F('23.3')*F('3.1416')*F(1063200,4)) == 19456569)
check('Hstar four', ceil(F(704,343)*F(1063200,4)) == 545549)
rho = F('8.85e-7')
check('plus primitive energy', F('4.25e-7')**2 == F('1.80625e-13'))
check('relaxed plus', F('1.80625e-13') < F('7.02e-13'))
check('plus Parseval reserve', F('7.83e-13') < rho*rho)
check('Z', 16*R*rho*rho*19 < F('.006')**2)
a = F('.640208')*F('13.59756')
check('Y', a < F('2.951')**2)
check('X', F('2.957')**2 == F('8.743849') < F('8.79'))
check('star A', 7000000*F(12,5)*F('2.321e-19') < (F('2e-6')-F('8e-9'))**2)
check('star B', 7000000*10**6*F('1.753e-12') < (F('6.48')-F('.00048'))**2)
check('star B square', F('6.48')**2 < 42 < 62)
reserve = F('3.67e-6')*F('2.964')-F('1.902e-6')-F('2e-6')
check('weighted star reserve positive', reserve > 0)
check('weighted star row', reserve**2 > rho**2*62)
check('weighted star root lower', F('2.964')**2 < F('8.79'))
v = F('7.78')*F('2.85')
check('cubic AMGM identity', (49*(F('8.79')+a)/9+9*v/2)**2-2*49*v*(F('8.79')+a) == (49*(F('8.79')+a)/9-9*v/2)**2)
check('phi coarse root', 265800 < 516**2)
check('base energy removal', F('.024')+F('2e-9')*516 == F('.024001032'))
base = F('.024001032')+F('.000544')+F('.000002')+F('.000000004')
check('base sum', base == F('.024547036'))
check('direct ghat', base < F('.03') < F(435635673,13700000000))
mass = F(2*6734875660393277758,10**18)
check('mass', mass == F(3367437830196638879,250000000000000000))
lowerI = (F('.638108')*mass-F('.00108')-100001*F('8e-11'))/F('1.00001')
check('I', lowerI == F(537129254732779210450233,62500625000000000000000))
margin = F(17454234627055702473150105611895106422794893597,12867056213564954145112500000000000000000000000000)
check('inherited margin interval', F('.0013565') < margin < F('.0013566'))
receipt = {'scope':'exact rational joins and file pins only; no spectral evidence or whole scalar-engine replay', 'author_sha256':EXPECTED, 'checks':checks, 'check_count':len(checks), 'result':'PASS'}
out = Path(__file__).with_suffix('.json')
out.write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'result':'PASS','checks':len(checks),'receipt_sha256':sha(out)}))
