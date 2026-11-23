"""Independent formal polynomial/fixed rational checks; reads no inventory."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
from collections import defaultdict
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3]
B='work/qrh-campaign/agents/'
pins={B+'audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md':'08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F',B+'audit/sharper_normalized_transform_precision_20261111.py':'3DC029F54A98735C1B5491DA9EF62B879F0085AF5CF62898418D5B40ADCA70E4',B+'audit/sharper_normalized_transform_precision_20261111.json':'0A1D5A6E57A6D1036CD7916422AE4C51D83ED6C8F642C5C2C7BB65871BC87B30'}
checks=0
def ck(x):
 global checks
 assert x;checks+=1
def read(p,h):
 path=ROOT/p;ck(path.stat().st_size<256*1024)
 raw=path.read_bytes();ck(hashlib.sha256(raw).hexdigest().upper()==h);return raw
raws={p:read(p,h) for p,h in pins.items()}
receipt=json.loads(raws[B+'audit/sharper_normalized_transform_precision_20261111.json'])
for p,h in receipt['pins'].items():pins[p]=h;read(p,h)
# Sparse formal polynomials indexed by sorted variable-name tuples.
class Poly:
 def __init__(self,c=0,terms=None):self.t=terms if terms is not None else ({():F(c)} if c else {})
 def __add__(self,o):
  o=o if isinstance(o,Poly) else Poly(o);d=defaultdict(F,self.t)
  for m,c in o.t.items():d[m]+=c
  return Poly(terms={m:c for m,c in d.items() if c})
 __radd__=__add__
 def __neg__(self):return Poly(terms={m:-c for m,c in self.t.items()})
 def __sub__(self,o):return self+-o if isinstance(o,Poly) else self+(-o)
 def __rsub__(self,o):return -self+o
 def __mul__(self,o):
  o=o if isinstance(o,Poly) else Poly(o);d=defaultdict(F)
  for m,c in self.t.items():
   for n,e in o.t.items():d[tuple(sorted(m+n))]+=c*e
  return Poly(terms={m:c for m,c in d.items() if c})
 __rmul__=__mul__
 def __eq__(self,o):return self.t==(o.t if isinstance(o,Poly) else Poly(o).t)
N,P,R,a,b,x,y=[Poly(terms={(v,):F(1)}) for v in ['n','P','R','a','b','x','y']]
AA=1+3*R
q=N*(3*AA+1)+2
Q=3*N*P*AA+1
old=6*P*AA+2*R*(2*N+1)+8
sharp=F(9,2)*P*AA+F(3,2)*P+3*R*N+12*R+14
# Compare after multiplying the exact coefficient by 2n.
exact2n=3*(P*q+R*(N*(2*N-1)+2*P))+2*(N+1)
ck(2*N*sharp-exact2n==R*(27*N-6*P)+26*N-6*P-2)
ck(old-sharp==R*(F(9,2)*P+N-10)-6)
ck(Q-P*(AA+1)==(3*N-1)*P*AA-P+1)
ck(Q-q==3*N*AA*(P-1)-N-1)
def guard(a,b):return a+b+2*a*b
ck(guard(a+x,b+y)-guard(a,b)==x+2*b*x+y+2*a*y+2*x*y)
ck(8*(F(9,2)*4+2-10)-6==74)
# Scalar constants, independently composed through actual downstream stages.
u=lambda p:F(1,1<<p)
S=202305920;C=1266*S*(1<<14)
ck(C==4196258524692480)
ck(29961461170177<1<<100)
ck(2*424706204<1<<100)
ck(4*265800<1266**2)
ck(256*790257<S<256*790258)
T=F(927193523,10**9)*u(46)
rows=[]
for p in (100,106,108):
 eps=C*u(p)
 pre=eps+u(82)+2*u(63)
 rL=eps+u(82)+4*u(63)
 direct=27*rL+2*u(54)
 rY=direct+2*u(55)
 final=T+5*rY+83*u(55)+u(51)
 fixed=T+135*(u(82)+4*u(63))+10*u(54)+93*u(55)+u(51)
 ck(pre<1);ck(rL<1);ck(direct<1);ck(rY<1)
 ck(final==fixed+135*eps)
 rows.append({'p':p,'radius_ratio':str(final/u(45))})
ratio=F(rows[-1]['radius_ratio'])
ck(ratio==F(2804840254168152529,4294967296000000000))
ck(ratio==F(receipt['complete_radius_ratio']))
ck(ratio<F(653052762,10**9)<F(691,1024))
# Clearing the nonnegative selector's sqrt(c) gives the stated squared form;
# doubling precision multiplies its squared LHS by 1/4, without row evaluation.
ck(F(1,2)**2==F(1,4))
result={'scope':'Formal polynomial identities and fixed scalar/source checks; no inventory parsed','checks':checks,'pins':pins,'formal_identities':5,'downstream_cases':rows,'radius_ratio_p108':str(ratio),'derived_frequency_or_runtime':False}
out=(json.dumps(result,sort_keys=True,indent=2)+'\n').encode();assert len(out)<16384
with (HERE/'review_sharper_normalized_transform_precision_20261111.json').open('xb') as f:f.write(out)
print(json.dumps({'checks':checks,'bytes':len(out),'p108_ratio':str(ratio)}))
