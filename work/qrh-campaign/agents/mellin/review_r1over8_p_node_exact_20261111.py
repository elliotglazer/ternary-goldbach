"""Independent rational P evaluation: 384 bits, five modes, alternate Taylor series."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parent
PINS={
 'integration/R1OVER8_P_NODE_EXACT_2026-11-11.md':'C11F586345B4C9F4C2FDD9A0B927902B323E53C9796AB06E509460454BA128A6',
 'integration/r1over8_p_node_exact_20261111.py':'4EE532C9698CCD8B462D40A1D102CE6DAD35741173C7D43F911C3AE7B2F15286',
 'integration/r1over8_p_node_exact_20261111.json':'DDF8B38A52FEBB70F019E805068ED4480CB086C8A27A00A86DAA0D05882AF584',
 'integration/lossless_modular_word_20261111.json':'E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910',
 'mellin/REVIEW_LOSSLESS_MODULAR_WORD_R1OVER8_2026-11-11.md':'5F6D22F549CF251EC44DAC4D436DAD0FF5A077902C22B81978F359AECAAC6C28',
 'independent-feasibility/REVIEW_R1OVER8_SEED_RATIONAL_2026-11-11.md':'0D17AC890A1E87D8B226484B78B32B085EC87753E26998AF02D0F5F47C4955E8',
 'integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md':'C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D',
 'integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md':'6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99',
}
for p,h in PINS.items():assert hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h,p
S=1<<384
def floor(x):return x.numerator//x.denominator
def interval(l,h):
 assert l<=h
 a,b=F(floor(l*S),S),F(-floor(-h*S),S)
 assert a<=l<=h<=b
 return a,b
def point(x):return F(x),F(x)
def add(a,b):return interval(a[0]+b[0],a[1]+b[1])
def neg(a):return -a[1],-a[0]
def sub(a,b):return add(a,neg(b))
def mul(a,b):
 p=[x*y for x in a for y in b];return interval(min(p),max(p))
def scale(a,x):return mul(a,point(x))
def inverse(a):
 assert not a[0]<=0<=a[1]
 p=[1/a[0],1/a[1]];return interval(min(p),max(p))
def widen(a,e):return interval(a[0]-e,a[1]+e)
Z=point(0);O=point(1)
def ca(a,b):return add(a[0],b[0]),add(a[1],b[1])
def cs(a,x):return scale(a[0],x),scale(a[1],x)
def cm(a,b):return sub(mul(a[0],b[0]),mul(a[1],b[1])),add(mul(a[0],b[1]),mul(a[1],b[0]))
def ci(a):
 def sq(x):return interval(F(0) if x[0]<=0<=x[1] else min(x[0]**2,x[1]**2),max(x[0]**2,x[1]**2))
 q=inverse(add(sq(a[0]),sq(a[1])));return mul(a[0],q),neg(mul(a[1],q))
def l1(a):return sum(max(abs(x),abs(y)) for x,y in a)
def arctan(x):
 n=140;v=sum((-1)**k*x**(2*k+1)/F(2*k+1) for k in range(n))
 return v,v+x**(2*n+1)/F(2*n+1)
a,b=arctan(F(1,5)),arctan(F(1,239))
PI=interval(16*a[0]-4*b[1],16*a[1]-4*b[0]);assert 3<PI[0]<PI[1]<4
events=[]
def exppos(x):
 assert x>=0
 t=x;k=0
 while t>F(1,2):t/=2;k+=1
 assert k<=16
 # Horner evaluation of the degree99 positive exponential polynomial.
 n=100;v=point(F(1,factorial(n-1)))
 for j in reversed(range(n-1)):v=add(mul(v,point(t)),point(F(1,factorial(j))))
 tail=F(1,2**n*factorial(n))*F(2*(n+1),2*(n+1)-1)
 v=interval(v[0],v[1]+tail)
 for _ in range(k):v=mul(v,v)
 events.append({'kind':'exp','x':str(x),'reduced':str(t),'k':k})
 return v
def expone(x):return exppos(x) if x>=0 else inverse(exppos(-x))
def expi(a):return expone(a[0])[0],expone(a[1])[1]
def cis(a):
 k=floor(((a[0]+a[1])/2)/(PI[0]+PI[1])+F(1,2))
 y=sub(a,scale(PI,2*k));assert -4<=y[0]<=y[1]<=4
 # Full complex Taylor polynomial, distinct from separate trig recurrences.
 v=(O,Z);p=(O,Z);iy=(Z,y);n=168
 for j in range(1,n):p=cs(cm(p,iy),F(1,j));v=ca(v,p)
 tail=F(2*4**n,factorial(n));assert F(4,n+1)<F(1,2)
 events.append({'kind':'cis','k':k,'y':[str(q) for q in y]})
 return widen(v[0],tail),widen(v[1],tail)
def ce(a):
 p=expi(a[0]);q=cis(a[1]);return mul(p,q[0]),mul(p,q[1])
packet=json.loads((ROOT/'integration/lossless_modular_word_20261111.json').read_text())['packet']
nodes={n['id']:n for n in packet['nodes']}
def dy(p):return F(int(p['mantissa']))*F(2)**p['exponent']
def box(k):
 out=[]
 for a in ('re','im'):
  p=nodes[k]['value'][a];m,r=dy(p['mid']),dy(p['rad'])
  assert (dy(p['lo']),dy(p['hi']))==(m-r,m+r)
  out.append((m-r,m+r))
 return tuple(out)
v=box('s5.t');tau=box('tau');assert v[1][0]>=9
g=[(Z,Z) for _ in range(3)]
for j in range(5):
 a=F(2*j+1,2);z=(Z,scale(PI,a*a));h=cs(ce(cm(z,v)),2)
 for d in range(3):
  g[d]=ca(g[d],h);h=cm(h,z)
tail=F(2)**-537;assert 2*9*F(11,2)**2>=544
g=[(widen(h[0],tail),widen(h[1],tail)) for h in g]
g=[cm((Z,point(-1)),h) for h in g]
amp=F(1)
for stage in (4,3,2,1,0):
 A=box(f's{stage}.A');B=ci(box(f's{stage}.t'));B2=cm(B,B);B3=cm(B2,B);B4=cm(B3,B)
 # Explicit triangular matrix multiplication for the jet.
 coefficients=[[(O,Z),(Z,Z),(Z,Z)], [cs(B,F(-1,2)),B2,(Z,Z)], [cs(B2,F(3,4)),cs(B3,-3),B4]]
 out=[]
 for row in coefficients:
  h=(Z,Z)
  for c,x in zip(row,g):h=ca(h,cm(c,x))
  out.append(cm(A,h))
 g=[cs(h,-1) for h in out] if stage in (1,3) else out
 E=l1(B);Ab=l1(A);amp*=max(Ab,Ab*(E/2+E**2),Ab*(3*E**2/4+3*E**3+E**4))
phase=cis(sub(scale(PI,F(1,8)),point(F(1,2000002))));er=expi(point(F(1,16)))
pref=(mul(er,phase[0]),mul(er,phase[1]))
P=cm(pref,ca(cs(cm(tau,g[1]),6),cs(cm(cm(tau,tau),g[2]),4)))
amp*=l1(pref)*(6*l1(tau)+4*l1(tau)**2)
assert tail*amp<F(2)**-200
author=json.loads((ROOT/'integration/r1over8_p_node_exact_20261111.json').read_text())['result']
center=list(map(F,author['center']))
err=sum(max(abs(l-c),abs(h-c)) for (l,h),c in zip(P,center))
assert 0<err<F(2)**-128
assert any(l>0 or h<0 for l,h in P)
assert P[0][0]>10**12 and P[1][1]<-2*10**12
for p,a in zip(P,(author['P_box']['re'],author['P_box']['im'])):
 l,h=map(F,a);assert max(p[0],l)<=min(p[1],h)
out={'status':'PASS alternate complete rational one-node enclosure','pins':PINS,
 'precision':384,'pi_terms':140,'exp_terms':100,'cis_terms':168,'theta2_modes':5,
 'P_box':[[str(q) for q in a] for a in P],'author_center':author['center'],
 'independent_error_about_author_center':str(err),'radius':str(F(2)**-128),
 'tail':str(tail),'tail_error':str(tail*amp),'events':events,
 'scope':'One r=1/8 point, paper analytic lemmas plus exact rational replay; no numerical oracle or Lean.'}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:out[k] for k in ('status','precision','theta2_modes','radius','scope')},indent=2))
