"""Independent exact scalar check; analytic horizontal bounds are inputs."""
from fractions import Fraction as F
from pathlib import Path
from math import factorial
import json

def atan_interval(q):
    x=F(1,q)
    s=sum((-1)**k*x**(2*k+1)/(2*k+1) for k in range(24))
    return s,s+x**49/49

a,b=atan_interval(5),atan_interval(239)
lo,hi=16*a[0]-4*b[1],16*a[1]-4*b[0]
p=F(314159,100000)
assert lo>p and hi<F(22,7)
intercept=F(18397,10000)*p-F(57795,10000)
slope=F(621,5000)*p-F(39,100)
assert intercept==F(83123,10**9)>0
assert slope==F(92739,5*10**8)>0
lower=F(18,10000)+F(12183,10000)+F(148,100)*(F(11,10000)+F(1506,1000))
assert lower==F(3450608,1000000)<F(34507,10000)
assert sum(F(763,500)**k/factorial(k) for k in range(25))>F(1149,250)
upper=F(3,4)*F(763,500)+F(148,125)+F(9,64)*F(11,10000)
assert upper<F(2911,1250)
out=dict(status='PASS',intercept_margin=str(intercept),slope_margin=str(slope),
         lower_combination=str(lower),upper_combination=str(upper),
         scope='Exact rounding conditional on analytic horizontal estimates; no Turing proof or numerical zero computation')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps(out,indent=2))
