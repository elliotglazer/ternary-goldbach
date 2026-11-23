"""Exact quadratic reciprocal acceptance; no transcendental or Lean evaluation.

Production acceptance uses imported compact dyadics only. Fraction is confined
to bounded regression oracles and the two explicitly bounded historical gates.
"""
from pathlib import Path
from fractions import Fraction as F
from itertools import combinations_with_replacement, product
import hashlib, importlib.util, json, sys
sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
 'integration/compact_dyadic_receipt_pilot_20261111.py':'6FC3E2976B53B49D1A4FDFBDEA6A2D1E327CAA8BFCA24CCE0B1A77CE90B39840',
 'integration/lossless_modular_two_step_20261111.py':'9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6',
 'integration/lossless_modular_two_step_20261111.json':'31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE',
}
def load(name, rel):
 p=AGENTS/rel
 assert hashlib.sha256(p.read_bytes()).hexdigest().upper()==PINS[rel]
 s=importlib.util.spec_from_file_location(name,p)
 m=importlib.util.module_from_spec(s);sys.modules[name]=m;s.loader.exec_module(m)
 return m
C=load('compact_recip_arithmetic', 'integration/compact_dyadic_receipt_pilot_20261111.py')
O=load('compact_recip_edge_oracle', 'integration/lossless_modular_two_step_20261111.py')
D, mul, sign3 = C.D, C.mul, C.sign3
BRANCHES = {}
def mark(k): BRANCHES[k]=BRANCHES.get(k,0)+1
def quadratic_nonnegative(a,b,X,Y):
 """iff a*(x*x+y*y)+b*x >= 0 throughout X x Y, b=+-1."""
 assert b in (-1,1)
 def residual(x,y):
  return sign3(mul(a,mul(x,x)),mul(a,mul(y,y)),x if b==1 else -x)>=0
 if a.m<=0:
  mark('concave_or_linear')
  return all(residual(x,y) for x,y in product(X,Y))
 # Y coordinate minimizes a*y^2 at the point nearest zero.
 y=Y[0] if Y[0].m>0 else Y[1] if Y[1].m<0 else D(0)
 slope=lambda x:sign3(mul(D(a.m,a.e+1),x),D(b))
 if slope(X[0])>=0:
  mark('convex_left');return residual(X[0],y)
 if slope(X[1])<=0:
  mark('convex_right');return residual(X[1],y)
 mark('convex_interior')
 # Positive multiplier 4a removes the denominator at x=-b/(2a).
 return sign3(mul(D(1,2),mul(mul(a,a),mul(y,y))),D(-1))>=0
def accept(inp,out,sgn=1):
 """Full-box enclosure of sgn/z. False on unordered boxes or origin."""
 if sgn not in (-1,1): return False
 if any(C.cmp(x[0],x[1])>0 for x in inp+out): return False
 if all(x[0].m<=0<=x[1].m for x in inp):return False
 if sgn==-1:out=tuple((-x[1],-x[0]) for x in out)
 X,Y=inp; (lr,ur),(li,ui)=out
 return (quadratic_nonnegative(-lr,1,X,Y)
  and quadratic_nonnegative(ur,-1,X,Y)
  and quadratic_nonnegative(-li,-1,Y,X)
  and quadratic_nonnegative(ui,1,Y,X))
def fd(q):
 q=F(q);assert q.denominator&(q.denominator-1)==0
 return D(q.numerator,-(q.denominator.bit_length()-1))
def ff(d):
 assert abs(d.e)<=4096
 return F(d.m)*F(2)**d.e
def qmath(a,b,X,Y):
 """Separate exact rational vertex oracle, used only on bounded regressions."""
 def minimum(I,c):
  pts=list(I)
  if a>0 and I[0]<=-c/(2*a)<=I[1]:pts.append(-c/(2*a))
  return min(a*x*x+c*x for x in pts)
 return minimum(X,F(b))+minimum(Y,F(0))>=0
def qaccept(inp,out):
 if any(x[0]>x[1] for x in inp+out):return False
 if all(x[0]<=0<=x[1] for x in inp):return False
 X,Y=inp;(lr,ur),(li,ui)=out
 return all((qmath(-lr,1,X,Y),qmath(ur,-1,X,Y),qmath(-li,-1,Y,X),qmath(ui,1,Y,X)))
def run():
 C.COUNTS.clear();C.MAXIMA.clear();BRANCHES.clear()
 intervals=list(combinations_with_replacement([F(n,2) for n in range(-4,5)],2))
 cases=origin=equalities=0
 for inp in product(intervals,repeat=2):
  din=tuple(tuple(map(fd,x)) for x in inp)
  if all(x[0]<=0<=x[1] for x in inp):
   assert not accept(din,((D(-100),D(100)),)*2);origin+=1;continue
  exact=O.reciprocal_rectangle(inp)
  assert qaccept(inp,exact);equalities+=1
  # Four exact-bound inward mutations must each fail, even for degenerate boxes.
  for side in range(4):
   out=[list(x) for x in exact];out[side//2][side%2]+=F(1,1024)*(1 if side%2==0 else -1)
   assert not qaccept(inp,tuple(tuple(x) for x in out));equalities+=1
  rounded=tuple((F((x[0]*64).__floor__(),64),F((x[1]*64).__ceil__(),64)) for x in exact)
  for side in range(-1,4):
   for step in ([0] if side==-1 else [-1,1]):
    out=[list(x) for x in rounded]
    if side!=-1:out[side//2][side%2]+=F(step,64)
    out=tuple(tuple(x) for x in out)
    expected=all(x[0]<=y[0]<=y[1]<=x[1] for x,y in zip(out,exact))
    dout=tuple(tuple(map(fd,x)) for x in out)
    assert accept(din,dout)==expected==qaccept(inp,out),(inp,out)
    assert accept(din,tuple((-x[1],-x[0]) for x in dout),-1)==expected
    cases+=2
 bounded_stats={'counts':dict(C.COUNTS),'maxima':dict(C.MAXIMA)}
 p=AGENTS/'integration/lossless_modular_two_step_20261111.json'
 assert hashlib.sha256(p.read_bytes()).hexdigest().upper()==PINS[str(p.relative_to(AGENTS)).replace('\\','/')]
 nodes={n['id']:n for n in json.loads(p.read_text())['packet']['nodes']}
 def box(n):return tuple(tuple(C.wire(n['value'][c][k]) for k in ('lo','hi')) for c in ('re','im'))
 gates=[]
 for name in ('S_output','A'):
  n=nodes[name];inp=box(nodes[n['args'][0]]);out=box(n);s=n['sign']
  C.COUNTS.clear();C.MAXIMA.clear();assert accept(inp,out,s)
  target=O.reciprocal_rectangle(tuple(tuple(map(ff,x)) for x in inp))
  if s==-1:target=tuple((-x[1],-x[0]) for x in target)
  assert all(ff(x[0])<=y[0]<=y[1]<=ff(x[1]) for x,y in zip(out,target))
  row={'id':name,'passed':True,'counts':dict(C.COUNTS),'maxima':dict(C.MAXIMA),'scaled':[]}
  for E in (10**100,-10**100):
   C.COUNTS.clear();C.MAXIMA.clear()
   shift=lambda box,e:tuple(tuple(D(v.m,v.e+e) for v in x) for x in box)
   assert accept(shift(inp,E),shift(out,-E),s)
   row['scaled'].append({'exponent':str(E),'passed':True,'counts':dict(C.COUNTS),'maxima':dict(C.MAXIMA)})
  gates.append(row)
 # Explicit slope-at-endpoint equality, zero inactive coordinate, and huge-gap cancellation.
 assert quadratic_nonnegative(D(1),-1,(D(1,-1),D(1)),(D(1,-1),D(1,-1)))
 assert not quadratic_nonnegative(D(1),-1,(D(0),D(1)),(D(0),D(0)))
 assert sign3(D(1),D(1,-10**100),D(-1))==1
 return {'status':'PASS external exact arithmetic only','pins':PINS,
  'bounded_acceptance_comparisons':cases,'origin_boxes_rejected':origin,
  'tight_rational_equalities_and_mutations':equalities,'bounded_stats':bounded_stats,
  'branches':BRANCHES,'lossless_gates':gates,
  'scope':'No transcendental seed, theta value, Lean proof, or whole receipt certified.'}
if __name__=='__main__':
 result=run();result['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
 out=HERE/'compact_reciprocal_rectangle_20261111.json'
 out.write_text(json.dumps(result,indent=2,sort_keys=True)+'\n',encoding='utf8')
 print(json.dumps({k:result[k] for k in ('status','bounded_acceptance_comparisons','origin_boxes_rejected','tight_rational_equalities_and_mutations')}))
