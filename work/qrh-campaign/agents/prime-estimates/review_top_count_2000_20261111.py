"""Independent finite-EM top-path audit; no builtin special functions.
All six alternate models; exponential jets constructed by coefficient recurrence.
Adapted with attribution from independent-feasibility/review_em_top_horizontal_20261111.py
SHA CD6C4E02FA2CB3F3D8F24EDA9B41C038466764C442E55C7997E6608DF9BC4A1E.
No author module is imported. Parameters differ from the height-2000 producer.
"""
from fractions import Fraction as Q
from pathlib import Path
from math import comb, factorial
import json, hashlib, time
from flint import arb, acb, acb_series, ctx

HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parents[3]/'work/qrh-blueprint/principal-chunk-2000'
PINS={
 'TOP_COUNT_2000_2026-11-11.md':'FE551A7B6B8C58C5E0394675AB63F694B16516B63570CD6FCA9D2CDB40665A25',
 'em_top_2000.py':'29FD53BC084FC38C3033E6C8D9E7DDB63E1AF0D96A8789216EC069AA7D75F6CF',
 'em_top_2000.json':'477BD15B17326BCE7333346491BA820C98DB2FE2B07DBDB7A0D11278CD2AE252'}
for name,pin in PINS.items():
 assert hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest().upper()==pin
original=json.loads((AUTHOR/'em_top_2000.json').read_text())
T=2000; N=601; B=N+1; M=36; K=26; R=Q(3,4); h=Q(1,8)
ctx.prec=160; ctx.cap=K
start=time.perf_counter()
def limit():
 if time.perf_counter()-start>120: raise RuntimeError('independent 120-second budget exceeded')
def a(q):
 q=Q(q); return arb(q.numerator)/q.denominator
def bounds(x): return [str(x.lower().fmpq()),str(x.upper().fmpq())]
def cb(z): return {'re':bounds(z.real),'im':bounds(z.imag)}
def box(x):
 lo,hi=map(Q,x); return arb(a((lo+hi)/2),a((hi-lo)/2))
def readcb(z): return acb(box(z['re']),box(z['im']))
def ej(c,l):
 terms=[(-c*l).exp()]
 for j in range(1,K): terms.append(terms[-1]*(-l)/j)
 return acb_series(terms,prec=K)
logs=[arb(n).log() for n in range(1,N+1)]; lb=arb(B).log()
ber=[Q(1)]
for n in range(1,2*M+1):
 ber.append(-sum(Q(comb(n+1,j))*ber[j] for j in range(n))/Q(n+1))
co=[a(ber[2*k]/factorial(2*k)) for k in range(1,M+1)]
powers=[arb(B)**(1-2*k) for k in range(1,M+1)]
rows=[]; ends={}
for index in range(6):
 c=Q(5+2*index,8); z=acb(a(c),T); s=acb_series([z,1],prec=K)
 v=acb_series([0],prec=K); began=time.perf_counter()
 for i,l in enumerate(logs):
  v+=ej(z,l)
  if i%8192==0: limit()
 bp=ej(z,lb); rise=acb_series([1],prec=K); corr=acb_series([0],prec=K)
 for j in range(1,2*M):
  rise*=s+j-1
  if j%2: corr+=co[(j-1)//2]*powers[(j-1)//2]*rise
 v=(s-1)*(v+bp*(corr+a(Q(1,2))))+B*bp
 jet=[v[j] for j in range(K)]
 so=abs(z)+a(R); sigma=a(c-R)
 finite=arb(N)*(arb(N)**(-sigma) if c<R else arb(1))
 rise=arb(1); corr=arb(0)
 for j in range(1,2*M):
  rise*=so+j-1
  if j%2: corr+=abs(co[(j-1)//2])*powers[(j-1)//2]*rise
 outer=(so+1)*(finite+(-sigma*lb).exp()*(corr+a(Q(1,2))))+((1-sigma)*lb).exp()
 si=abs(z)+a(h); rise=arb(1)
 for j in range(2*M): rise*=si+j
 em=(si+1)*4*rise*((a(Q(1,2))-2*M)*lb).exp()/(6**(2*M)*a(Q(2*M)-Q(1,2)))
 tail=outer*a(h/R)**K/(1-a(h/R)); err=em+tail
 def image(lo,hi):
  offset=acb(arb(a((lo+hi)/2-c),a((hi-lo)/2)))
  val=jet[-1]
  for coeff in reversed(jet[:-1]): val=val*offset+coeff
  e=arb(0,err.upper())
  return (val+acb(e,e))/(acb(arb(a((lo+hi)/2),a((hi-lo)/2)),T)-1)
 whole=image(c-h,c+h); assert whole.real>0
 for x in [c-h,c+h]:
  val=image(x,x); assert val.real>0
  assert val.overlaps(readcb(original['endpoints'][str(x)]))
  if x in ends: assert val.overlaps(ends[x])
  else: ends[x]=val
 row={'center':str(c),'whole_image':cb(whole),'EM_error_zetaF':bounds(em),
      'Taylor_error_zetaF':bounds(tail),'outer_bound':bounds(outer),
      'seconds':time.perf_counter()-began}
 rows.append(row)
 print(json.dumps({'blocks':len(rows),'seconds':time.perf_counter()-start,
                   'real_lower':float(whole.real.lower())}),flush=True)
assert sorted(ends)==[Q(1,2)+Q(j,4) for j in range(7)]
assert ends[Q(2)].real>a(Q(1,4))
def plus(x,y):return x[0]+y[0],x[1]+y[1]
def minus(x):return -x[1],-x[0]
def times(x,y):
    v=[a*b for a in x for b in y]
    return min(v),max(v)
def scaled(x,k):return times(x,(Q(k),Q(k)))
def quotient(x,y):
    assert 0<y[0]<=y[1] and x[0]<=x[1]
    return times(x,(1/y[1],1/y[0]))
def small(x,n):
    assert 0<=x<=Q(1,2) and n>0 and n%2==0
    # A recurrence for successive terms, rather than separate rational powers.
    term=x;s=Q(0)
    for j in range(n):
        s+=term
        term=-term*x*x*Q(2*j+1,2*j+3)
    assert term>=0
    return s,s+term

pi=plus(scaled(small(Q(1,5),32),16),scaled(small(Q(1,239),12),-4))
assert 3<pi[0]<pi[1]<4
base_half=small(Q(1,2),40)
def atan(x):
    if x<0:return minus(atan(-x))
    if x>1:return plus(scaled(pi,Q(1,2)),minus(atan(1/x)))
    if x<=Q(1,2):return small(x,40)
    # Different from the source pi/4 shift: add arctan(1/2).
    u=(x-Q(1,2))/(1+x/2)
    assert 0<u<=Q(1,3) and Q(1,2)*u<1
    assert (Q(1,2)+u)/(1-u/2)==x
    return plus(base_half,small(u,40))
def unit_log(y):
    assert 1<=y<=2
    t=(y-1)/(y+1);n=40;term=t;s=Q(0)
    for j in range(n):
        s+=2*term/Q(2*j+1)
        term*=t*t
    return s,s+2*term/(Q(2*n+1)*(1-t*t))
log2=unit_log(Q(2))
def logq(x):
    assert x>0
    k=0;y=x
    while y>2:k+=1;y/=2
    while y<1:k-=1;y*=2
    assert y*Q(2)**k==x
    return plus(scaled(log2,k),unit_log(y))
def roundout(x,p):
    d=10**p
    return Q((x[0]*d).__floor__(),d),Q((x[1]*d).__ceil__(),d)
z=cb(ends[Q(1,2)]); re=tuple(map(Q,z['re'])); im=tuple(map(Q,z['im']))
r=quotient(im,re)
arg=(atan(r[0])[0],atan(r[1])[1]); Si=quotient(arg,pi)
x=roundout(quotient((Q(T),Q(T)),scaled(pi,2)),25)
lx,ux=logq(x[0]),logq(x[1]); assert lx[0]>1
Fi=(x[0]*(lx[0]-1)+Q(7,8),x[1]*(ux[1]-1)+Q(7,8))
lo=Fi[0]+Si[0]-Q(1,8); hi=Fi[1]+Si[1]+Q(1,8)
ceil_lo=-((-lo.numerator)//lo.denominator); floor_hi=hi.numerator//hi.denominator
assert ceil_lo==floor_hi
assert ceil_lo==original['unique_integer']
assert ceil_lo-1069==448
out={'status':'PASS_ALL_SIX_INDEPENDENT_EM_MODELS','input_sha256':PINS,
 'N':N,'M':M,'K':K,'R':str(R),'h':str(h),'precision_bits':ctx.prec,
 'coefficient_method':'exp(-center log n), then a_j=a_(j-1)*(-log n)/j; no series exp',
 'blocks':rows,'endpoints':{str(x):cb(v) for x,v in sorted(ends.items())},
 'T':T,'S':[str(q) for q in roundout(Si,25)],'F':[str(q) for q in roundout(Fi,25)],'count_interval_exact_outward_25dp':[str(q) for q in roundout((lo,hi),25)],
 'unique_integer':ceil_lo,'seconds':time.perf_counter()-start,
 'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
 'scope':'External elementary interval arithmetic, conditional analytic EM/Taylor/count contracts; no Lean proof.'}
HERE.joinpath('review_top_count_2000_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k not in ('blocks','endpoints','input_sha256')},indent=2))
