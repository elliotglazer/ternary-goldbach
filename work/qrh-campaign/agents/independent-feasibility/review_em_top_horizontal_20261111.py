"""Independent finite-EM top-path audit; no builtin special functions.
All six alternate models; exponential jets constructed by coefficient recurrence.
"""
from fractions import Fraction as Q
from pathlib import Path
from math import comb, factorial
import json, hashlib, time
from flint import arb, acb, acb_series, ctx

HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parent/'zero-sum'
PINS={
 'EM_TOP_HORIZONTAL_2026-11-11.md':'C8062D1BB197EF9A2FD8450BEAAF7E093B1448865751D0DB30623394C76F13BF',
 'em_top_horizontal_20261111.py':'F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10',
 'em_top_horizontal_20261111.json':'9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26'}
for name,pin in PINS.items():
 assert hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest().upper()==pin
original=json.loads((AUTHOR/'em_top_horizontal_20261111.json').read_text())
T=1000000; N=300001; B=N+1; M=36; K=26; R=Q(3,4); h=Q(1,8)
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
S=ends[Q(1,2)].log().imag/arb.pi()
Ft=arb(T)/(2*arb.pi())*((arb(T)/(2*arb.pi())).log()-1)+a(Q(7,8))
# Exact endpoint addition, no midpoint rounding or Arb-radius containment test.
lo=Q(bounds(Ft)[0])+Q(bounds(S)[0])-Q(1,8)
hi=Q(bounds(Ft)[1])+Q(bounds(S)[1])+Q(1,8)
ceil_lo=-((-lo.numerator)//lo.denominator); floor_hi=hi.numerator//hi.denominator
assert ceil_lo==floor_hi
out={'status':'PASS_ALL_SIX_INDEPENDENT_EM_MODELS','input_sha256':PINS,
 'N':N,'M':M,'K':K,'R':str(R),'h':str(h),'precision_bits':ctx.prec,
 'coefficient_method':'exp(-center log n), then a_j=a_(j-1)*(-log n)/j; no series exp',
 'blocks':rows,'endpoints':{str(x):cb(v) for x,v in sorted(ends.items())},
 'S':bounds(S),'F':bounds(Ft),'count_interval_exact':[str(lo),str(hi)],
 'unique_integer':ceil_lo,'seconds':time.perf_counter()-start,
 'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
 'scope':'External elementary interval arithmetic, conditional analytic EM/Taylor/count contracts; no Lean proof.'}
HERE.joinpath('review_em_top_horizontal_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k not in ('blocks','endpoints','input_sha256')},indent=2))
