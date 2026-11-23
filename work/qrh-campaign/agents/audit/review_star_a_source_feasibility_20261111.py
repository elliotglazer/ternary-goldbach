"""Rational reconstruction of a method obstruction, not an A evaluation."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
SRC=ROOT/'work/qrh-campaign/agents/independent-feasibility'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()
checks={}
def ck(k,v):
    assert v,k
    checks[k]=True

ck('author pin',sha(SRC/'STAR_A_ONLY_SOURCE_FEASIBILITY_2026-11-11.md')=='B6FF600BE16B85502CD86593C5566452C8B1202CC24F49DA579E90323A642263')
ck('author scalar source',sha(SRC/'star_a_only_scalars_20261111.py')=='306B518EF673CA06678A2D4CCFEFEABF1A3BCF56CC9F499F64D4890856E3877C')
ck('author receipt',sha(SRC/'star_a_only_scalars_20261111.json')=='0056130014CC7CF09DFE458035FAC659D0581CCD49669204DDD6722F4D952D1B')
data=json.loads((SRC/'star_a_only_scalars_20261111.json').read_text())
for path,h in data['pins'].items(): ck('input '+path,sha(ROOT/path)==h)
ck('twelve input pins',len(data['pins'])==12)
def mul(a,b):
    out=[F(0)]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): out[i+j]+=x*y
    return out
base=[F(1)]
for _ in range(3): base=mul(base,[F(1),F(0),F(-1)])
def integ(p): return sum((2*x/F(i+1) for i,x in enumerate(p) if i%2==0),F(0))
lower=integ(mul(base,[F(1),F(0),F(-1,2)]))
upper=integ(base)
pmin=lower-F(221,100000)
ck('polynomial lower',lower==F(272,315))
ck('P zero lower',pmin==F(data['P0_lower']) and pmin>F(86,100))
ck('uniform Fourier bound',upper==F(32,35) and upper+F(221,100000)<1)
weight=2*F(1,4)*F(3,2)
ck('two modulus weights',weight==F(3,4))
coeff=(weight/3)*6*F(86,100)**2
ck('liminf coefficient',coeff==F(data['coefficient_lower']))
principal=F(640208,10**6)*F(32,13)*F(1415,1000)**2
ck('principal amplitude', (F(1415,1000)-F(1502,10**9))**2>2)
ck('principal allowance',principal==F(data['principal_upper']) and principal<F(3156,1000))
floor=49*coeff*(1-F(468,10**6))*F(49,64)-principal
ck('liminf comparison',floor==F(data['comparison_lower']) and floor>38)
ck('finite sieve domain',8*132900**2<F(49*10**25,2))
ck('small allowance comparison',F(49,4)*F(21,10**10)>F(1,10**10))
ck('finite totient product',2*3*5*7*11*13*17>265800 and F(2*3*5*7*11*13,1*2*4*6*10*12)<F(21,4))
for c,s in data['split_upper_comparisons'].items():
    v=F(1915)*F(21,4*int(c))**2
    ck('split '+c,v==F(s) and v>F(1,10**10))
cut=22974375
ck('cutoff accepted',F(1915)*F(21,4*cut)**2<=F(1,10**10))
ck('cutoff predecessor rejected',F(1915)*F(21,4*(cut-1))**2>F(1,10**10))
ck('saved cutoff',data['first_integer_C_passing_scalar_tail']==cut)
ck('single character target',F(1,10**10)/F(3,8)==F(8,3*10**10))
out={'scope':'exact rational method-obstruction checks; no actual character or A value','checks':checks,'check_count':len(checks),'P0_lower':str(pmin),'uniform_P_upper':str(upper+F(221,100000)),'comparison_lower':str(floor),'cutoff':cut,'input_pins':data['pins']}
dest=HERE/'review_star_a_source_feasibility_20261111.json'
with dest.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(f'{len(checks)} exact checks PASS; receipt {sha(dest)}')
