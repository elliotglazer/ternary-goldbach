"""Independent rational endpoints and source pins; no analytic values or author import."""
from fractions import Fraction as Q
from pathlib import Path
from hashlib import sha256
from math import factorial
import json

base = Path(__file__).resolve().parents[4]
checks = []
def check(name, a, relation, b):
    a, b = Q(a), Q(b)
    assert {'<': a < b, '<=': a <= b, '=': a == b}[relation], name
    checks.append(dict(name=name, left=str(a), relation=relation, right=str(b)))

e_upper = sum((Q(1, factorial(j)) for j in range(7)), Q(0)) + Q(1, factorial(7))*Q(8,7)
check('e upper for logarithm lower', e_upper, '<', Q(11,4))
check('log 1e12 exceeds 27', Q(11,4)**27, '<', 10**12)
check('exp3 finite sum above10', 10, '<', sum((Q(3)**j/factorial(j) for j in range(7)),Q(0)))
check('exp2 finite sum above7', 7, '<', sum((Q(2)**j/factorial(j) for j in range(7)),Q(0)))
check('exp1 finite sum above2.5', Q(5,2), '<', sum((Q(1,factorial(j)) for j in range(5)),Q(0)))
check('sqrt pi upper', Q(22,7), '<', Q(1773,1000)**2)
check('sqrt(pi/2) lower', Q(25,16), '<', Q(314,200))
check('Gamma5/2 lower squared', 1, '<', Q(9,16)*3)
V = Q(1254,1000)
check('Minkowski V', Q(137259,100000)**2*Q(3,8)*Q(1773,1000), '<', V)
check('lower V', Q(21,8)**2/9, '=', Q(49,64))
check('theta real error', Q(1,27**3)+Q(492,10**9)+Q(1,10**12), '<', Q(52,10**6))
check('D0', 4+2*Q(5,2), '=', 9)
check('D1', 20+8*4, '=', 52)
check('half derivative', 9+32, '=', 41)
check('inverse square derivative', Q(14,3)*16, '<', 75)
check('half log derivative', 20+9+32+75, '=', 136)
check('half weight integral', 1+4, '=', 5)
check('small t derivative', 64+512*Q(1,16), '=', 96)
check('small t w derivative', 2*32*96, '=', 6144)
low = Q(12288,5)*75+Q(11264,25)
check('low theta tail', low/Q(10**65), '<', Q(2,10**60))
check('small prime tail', Q(1024*7**5,10**62)*(2+Q(75,2))**2, '<', Q(1,10**50))
check('sqrt Y lower', (3*10**12)**2, '<', 10**25)
check('prime power endpoint', Q(14262,10000)*V*(41*75+141)/Q(3*10**12), '<', Q(2,10**9))
check('combined error', Q(2,10**9)+Q(1,10**50), '<', Q(21,10**10))
check('log slope', 1+Q(52,10**6)*9, '=', Q(1000468,10**6))
check('constant intercept', Q(1,2)+Q(52,10**6)*53, '=', Q(502756,10**6))

paths = ['MajorArcs/Cor933.lean', 'MajorArcs/Eta2Moments.lean', 'MajorArcs/Prop715.lean',
         'Prelim/ThetaExplicit.lean', 'Prelim/LambdaMu.lean', 'Helfgott/Defs.lean',
         'Helfgott/Eta2.lean', 'MinorArcs/LargeSievePrimes.lean']
pins = {p:sha256((base/'work/ternary-goldbach/TernaryGoldbach'/p).read_bytes()).hexdigest().upper() for p in paths}
packet = dict(scope='Independent rational and source-byte checks only; no analytic evaluation',
              checks=checks, count=len(checks), source_pins=pins)
out = Path(__file__).with_suffix('.json')
with out.open('x', encoding='utf-8', newline='\n') as f:
    json.dump(packet,f,indent=2); f.write('\n')
print(json.dumps(dict(checks=len(checks), receipt_sha256=sha256(out.read_bytes()).hexdigest().upper())))
