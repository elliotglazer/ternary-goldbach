"""Exact rounding checks for Rumely's printed horizontal-log bounds.
Does not prove those analytic bounds, Littlewood's identity, or a Turing checker.
"""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import hashlib,json
def atan(t,n):return sum(((-1)**j*t**(2*j+1)/Q(2*j+1) for j in range(n)),Q(0))
pi_lower=16*atan(Q(1,5),16)-4*atan(Q(1,239),7)
assert pi_lower>Q(314159,100000)
pl=Q(314159,100000)
A=Q(34507,10000)+Q(23288,10000)
D=Q(24,100)+Q(15,100)
margin_a=Q(18397,10000)*pl-A
margin_b=Q(1242,10000)*pl-D
assert margin_a>0 and margin_b>0
# Two final arithmetic combinations in the original proof; their analytic inputs
# remain separate obligations and are not certified here.
lower_const=Q(18,10000)+Q(12183,10000)+Q(148,100)*(Q(11,10000)+Q(1506,1000))
assert lower_const<Q(34507,10000)
x=Q(1526,1000)
assert sum((x**j/factorial(j) for j in range(20)),Q(0))>Q(4596,1000)
upper_const=Q(3,4)*x+Q(1184,1000)+Q(9,64)*Q(11,10000)
assert upper_const<Q(23288,10000)
assert Q(9,64)<Q(15,100)
out={'status':'PASS_EXACT_CONSTANT_ROUNDING_ONLY',
 'pi_lower_reduction':str(pl),'intercept_margin':str(margin_a),
 'slope_margin':str(margin_b),'lower_constant_combination':str(lower_const),
 'upper_constant_combination':str(upper_const),
 'scope':'Conditional arithmetic from printed analytic estimates; no proof of their inputs or numerical zero claim.',
 'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
