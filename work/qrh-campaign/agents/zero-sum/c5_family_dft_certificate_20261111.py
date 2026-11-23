"""Shared all-primitive conductor5 contour; explicit pole-cancelled EM acceptance.
Tests exact character DFT/indexing and simultaneous whole-panel completeness.
External FLINT elementary balls, not a Lean certificate or production Hcert(5).
"""
from fractions import Fraction as F
from math import comb,factorial
from pathlib import Path
import hashlib,json,time,sys
from flint import arb,acb,ctx
import flint
ctx.prec=128
LEFT=F(111,200);RIGHT=F(2);T=F(12);N=64;M=20
PATH=Path(__file__).with_suffix('.json')
def ar(q):
 q=F(q);return arb(str(q.numerator))/q.denominator
def box(a,b):
 return acb(arb(ar((a[0]+b[0])/2),ar(abs(a[0]-b[0])/2)),arb(ar((a[1]+b[1])/2),ar(abs(a[1]-b[1])/2)))
def eb(r):
 e=arb(0,r.upper());return acb(e,e)
def dy(a):
 m,e=a.mid().man_exp();m=int(m);e=int(e);return F(m*2**e) if e>=0 else F(m,2**(-e))
bern=[F(1)]
for n in range(1,2*M+1):bern.append(-sum(F(comb(n+1,k))*bern[k] for k in range(n))/F(n+1))
co=[ar(bern[2*k]/factorial(2*k)) for k in range(1,M+1)]
residues=[1,2,4,3]
assert [pow(2,j,5) for j in range(4)]==residues
pre=[]
for a in residues:
 A=F(a,5);B=ar(N+A);pre.append(([ar(j+A).log() for j in range(N)],B.log(),[B**(1-2*k) for k in range(1,M+1)]))
def exprel(z):
 v=term=acb(1)
 for k in range(1,19):term=term*z/(k+1);v+=term
 return v+eb(abs(z).exp()*abs(z)**19/factorial(20))
def evaluate(s):
 poch=[acb(1)]
 for j in range(2*M):poch.append(poch[-1]*(s+j))
 lb0=pre[0][1];base=((1-s)*lb0).exp();v=[]
 for logs,lb,powers in pre:
  bp=(-s*lb).exp()
  z=sum(((-s*l).exp() for l in logs),acb(0))+bp/2
  z+=bp*sum((co[k-1]*poch[2*k-1]*powers[k-1] for k in range(1,M+1)),acb(0))
  err=4*abs(poch[2*M])*(lb*(1-ar(LEFT)-2*M)).exp()/(6**(2*M)*(ar(LEFT)+2*M-1))
  step=lb-lb0
  # Removes the SAME B0^(1-s)/(s-1) from every Hurwitz function.
  v.append(z-base*step*exprel((1-s)*step)+eb(err))
 # Exact positive-sign DFT on residues 2^j. k=0 is deliberately discarded.
 i=acb(0,1);scale=(-s*arb(5).log()).exp()
 out=[scale*(v[0]+i*v[1]-v[2]-i*v[3]),scale*(v[0]-v[1]+v[2]-v[3]),scale*(v[0]-i*v[1]-v[2]+i*v[3])]
 return out

def wind(v):
 assert v[0]==v[-1];w=0
 for a,b in zip(v,v[1:]):
  det=a[0]*b[1]-a[1]*b[0]
  if a[1]<=0<b[1] and det>0:w+=1
  elif b[1]<=0<a[1] and det<0:w-=1
 return w

def witness(v,a,b):
 for axis,iv in enumerate((v.real,v.imag)):
  for sign in (1,-1):
   if sign*iv>0 and sign*a[axis]>0 and sign*b[axis]>0:return [axis,sign]
 return None

def check_partition(rows):
 prev=(LEFT,-T);length=F(0)
 for row in rows:
  a,b=tuple(map(F,row['a'])),tuple(map(F,row['b']));assert a==prev
  assert ((a[1]==b[1]==-T and LEFT<=a[0]<b[0]<=RIGHT) or(a[0]==b[0]==RIGHT and -T<=a[1]<b[1]<=T) or(a[1]==b[1]==T and LEFT<=b[0]<a[0]<=RIGHT) or(a[0]==b[0]==LEFT and -T<=b[1]<a[1]<=T))
  length+=abs(a[0]-b[0])+abs(a[1]-b[1]);prev=b
 assert prev==(LEFT,-T) and length==2*(RIGHT-LEFT+2*T)

def replay(data):
 assert data['parameters']=={'c':5,'generator':2,'characters':[1,2,3],'left':str(LEFT),'right':str(RIGHT),'height':str(T),'N':N,'M':M,'bits':128}
 rows=data['panels'];check_partition(rows);verts=[[] for _ in range(3)]
 for row in rows:
  vals=evaluate(box(tuple(map(F,row['a'])),tuple(map(F,row['b']))))
  for k in range(3):
   va,vb=tuple(map(F,row['va'][k])),tuple(map(F,row['vb'][k]));axis,sign=row['witnesses'][k]
   assert axis in(0,1) and sign in(-1,1)
   assert sign*(vals[k].real if axis==0 else vals[k].imag)>0 and sign*va[axis]>0 and sign*vb[axis]>0
   if verts[k]:assert verts[k][-1]==va
   else:verts[k].append(va)
   verts[k].append(vb)
 w=[wind(v) for v in verts];assert w==data['windings']==[0,0,0];return w

def main():
 start=time.perf_counter()
 if '--replay' in sys.argv:
  d=json.loads(PATH.read_text());w=replay(d);print(json.dumps({'replay_pass':True,'windings':w,'seconds':time.perf_counter()-start}));return
 rows=[];cache={};calls=0;maxdepth=0
 def vertex(a):
  if a not in cache:cache[a]=[(dy(v.real),dy(v.imag)) for v in evaluate(box(a,a))]
  return cache[a]
 def visit(a,b,depth):
  nonlocal calls,maxdepth
  calls+=1
  if calls>30000 or depth>24 or time.perf_counter()-start>60:raise RuntimeError('bounded pilot incomplete')
  va,vb=vertex(a),vertex(b);v=evaluate(box(a,b));ws=[witness(v[k],va[k],vb[k]) for k in range(3)]
  if all(w is not None for w in ws):
   rows.append({'a':list(map(str,a)),'b':list(map(str,b)),'va':[list(map(str,v)) for v in va],'vb':[list(map(str,v)) for v in vb],'witnesses':ws});maxdepth=max(maxdepth,depth)
  else:
   mid=((a[0]+b[0])/2,(a[1]+b[1])/2);visit(a,mid,depth+1);visit(mid,b,depth+1)
 corners=[(LEFT,-T),(RIGHT,-T),(RIGHT,T),(LEFT,T),(LEFT,-T)]
 for a,b in zip(corners,corners[1:]):visit(a,b,0)
 check_partition(rows)
 windings=[wind([tuple(map(F,rows[0]['va'][k]))]+[tuple(map(F,r['vb'][k])) for r in rows]) for k in range(3)]
 assert windings==[0,0,0]
 elapsed=time.perf_counter()-start
 # Builtin Hurwitz is diagnostic only, outside acceptance; avoid its pole at1.
 diagnostics=[]
 for point in [(F(2),F(0)),(LEFT,T),(LEFT,-T)]:
  s=box(point,point);got=evaluate(s);i=acb(0,1)
  for k in range(1,4):
   ref=(-s*arb(5).log()).exp()*sum((i**(k*j)*s.zeta(acb(ar(F(a,5)))) for j,a in enumerate(residues)),acb(0))
   assert got[k-1].overlaps(ref)
  diagnostics.append({'point':list(map(str,point)),'all_three_overlap':True})
 at1=evaluate(acb(1));assert all(v.is_finite() for v in at1)
 # Conjugation swaps k1,k3, not the sign of t inside a fixed complex character.
 vp=evaluate(box((LEFT,T),(LEFT,T)));vm=evaluate(box((LEFT,-T),(LEFT,-T)))
 assert vp[0].conjugate().overlaps(vm[2]) and vp[1].conjugate().overlaps(vm[1])
 data={'status':'EXTERNAL_EXPLICIT_EM_SHARED_CONTOUR_PASS','parameters':{'c':5,'generator':2,'characters':[1,2,3],'left':str(LEFT),'right':str(RIGHT),'height':str(T),'N':N,'M':M,'bits':128},'primitive_parities':['odd','even','odd'],'windings':windings,'product_winding':sum(windings),'panel_count':len(rows),'vector_panel_calls':calls,'distinct_vertex_calls':len(cache),'maxdepth':maxdepth,'construction_seconds':elapsed,'diagnostics':diagnostics,'at_one_values_diagnostic':[str(v) for v in at1],'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'flint_version':flint.__FLINT_VERSION__,'panels':rows}
 PATH.write_text(json.dumps(data,indent=2)+'\n');print(json.dumps({k:v for k,v in data.items() if k!='panels'},indent=2))
if __name__=='__main__':main()
