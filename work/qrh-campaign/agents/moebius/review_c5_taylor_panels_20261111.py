"""Four fixed c5 panels: alternate explicit polynomial arithmetic, no series oracle.

N80/M24, degree14, radius1/8, 224bits; unchanged385-pole witness.
No new panels, fits, built-in L functions or global spectral claim.
"""
from fractions import Fraction as F
from pathlib import Path
from math import comb,factorial
from flint import arb,acb,ctx
import json,hashlib,time
ctx.prec=224
HERE=Path(__file__).resolve().parent;SRC=HERE.parent/'zero-sum'
D=14;N=80;M=24;R=F(1,8)
PINS={
 'C5_RESIDUAL_TAYLOR_PANELS_2026-11-11.md':'91AFE6E39AE15CC85DC5A8C7E74D18A8CFBF60F2106DACD361946002A43D371A',
 'c5_residual_taylor_panels_20261111.py':'F1F91D5BC8B9DAF5BCA8B44FA55C1D333500662496157A453FB9E70CBD37FE4C',
 'c5_residual_taylor_panels_20261111.json':'8801DEBF7956C20403B20A1A04819B61E5FAFAF2A8FA39DA10E3888132C28F8C',
 'c5_global_inverse_candidate_20261111.json':'02C623629D3DF9218AFB7689F39698AF5C4F4D6FB6776056C4B275220D148E6E',
 'c5_global_inverse_certificate_20261111.json':'7FAA8640C48E48C6BB03CE3AA0921CE77042F42A464E1F371221E888AEE946EA'}
for name,pin in PINS.items():assert hashlib.sha256((SRC/name).read_bytes()).hexdigest().upper()==pin
def ar(x):
 x=F(x);return arb(str(x.numerator))/x.denominator
def const(x):return[acb(x)]+[acb(0) for _ in range(D)]
def add(a,b):return[x+y for x,y in zip(a,b)]
def scale(a,x):
 if isinstance(x,F):x=ar(x)
 return[z*x for z in a]
def mul(a,b,cap=D+1):
 out=[acb(0) for _ in range(min(len(a)+len(b)-1,cap))]
 for j in range(len(a)):
  for k in range(min(len(b),len(out)-j)):out[j+k]+=a[j]*b[k]
 return out
def exp_linear(v,slope):
 out=[v.exp()]
 for j in range(1,D+1):out.append(out[-1]*slope/j)
 return out
def norm(poly,rho):return sum((abs(z).upper()*ar(rho)**j for j,z in enumerate(poly)),arb(0)).upper()
def rat(x):return str(x.upper().fmpq())
bern=[F(1)]
for n in range(1,2*M+1):bern.append(-sum(F(comb(n+1,j))*bern[j] for j in range(n))/F(n+1))
co=[ar(bern[2*k]/factorial(2*k)) for k in range(1,M+1)]
pre=[]
for a in (1,2,4,3):
 B=ar(N+F(a,5));pre.append(([ar(j+F(a,5)).log() for j in range(N)],B.log(),[B**(1-2*k) for k in range(1,M+1)]))
def jets(center):
 s=acb(ar(center[0]),ar(center[1]));rise=[const(1)]
 for j in range(2*M):rise.append(mul(rise[-1],[s+j,acb(1)]+[acb(0)]*(D-1)))
 base=exp_linear((1-s)*pre[0][1],-pre[0][1]);raw=[]
 for logs,lb,powers in pre:
  bp=exp_linear(-s*lb,-lb);v=scale(bp,F(1,2));corr=const(0)
  for l in logs:v=add(v,exp_linear(-s*l,-l))
  for k in range(1,M+1):corr=add(corr,scale(rise[2*k-1],co[k-1]*powers[k-1]))
  v=add(v,mul(bp,corr));step=lb-pre[0][1]
  linear=[(1-s)*step,-acb(step)]+[acb(0)]*(D-1)
  term=const(1);poly=term
  for j in range(1,19):term=scale(mul(term,linear),F(1,j+1));poly=add(poly,term)
  raw.append(add(v,scale(mul(base,poly),-step)))
 sc=exp_linear(-s*ar(5).log(),-ar(5).log());ii=acb(0,1)
 return [mul(sc,[sum((raw[j][m]*ii**(k*j) for j in range(4)),acb(0)) for m in range(D+1)]) for k in (1,2,3)]
def controls(center,radius):
 s=acb(ar(center[0]),ar(center[1]));sig=ar(center[0]-radius);S=abs(s).upper()+ar(radius)
 rise=[arb(1)]
 for j in range(2*M):rise.append(rise[-1]*(S+j))
 base=((1-sig)*pre[0][1]).exp();finite=err=arb(0)
 for logs,lb,powers in pre:
  bp=(-sig*lb).exp()
  v=sum(((-ar(center[0])*l+ar(radius)*abs(l).upper()).exp() for l in logs),arb(0))+bp/2
  v+=bp*sum((abs(co[k-1]).upper()*rise[2*k-1]*powers[k-1] for k in range(1,M+1)),arb(0))
  step=abs(lb-pre[0][1]).upper();z=(S+1)*step
  poly=sum((z**j/factorial(j+1) for j in range(19)),arb(0))
  finite+=v+base*step*poly
  err+=base*step*z.exp()*z**19/factorial(20)
  err+=4*rise[2*M]*(lb*(1-sig-2*M)).exp()/(6**(2*M)*(sig+2*M-1))
 sc=(-sig*ar(5).log()).exp();return(sc*finite).upper(),(sc*err).upper()
def main():
 start=time.perf_counter();candidate=json.loads((SRC/'c5_global_inverse_candidate_20261111.json').read_text())
 old=json.loads((SRC/'c5_global_inverse_certificate_20261111.json').read_text())
 frozen=json.loads((SRC/'c5_residual_taylor_panels_20261111.json').read_text())
 coeff=[[acb(ar(F(z[0])),ar(F(z[1]))) for z in row] for row in candidate['coefficients']]
 poles=[acb(ar(F(x)),ar(F(y))) for x,y in candidate['poles']];out=[]
 for index,row in zip((29999,3871,457,24860),frozen['panels']):
  assert index==row['attempt_index'] and row['a']==old['attempts'][index]['a'] and row['b']==old['attempts'][index]['b']
  a,b=tuple(map(F,row['a'])),tuple(map(F,row['b']));center=tuple((a[j]+b[j])/2 for j in range(2));rho=abs(a[1]-b[1])/2
  assert 0<rho<R and center[0]-R>0
  s=acb(ar(center[0]),ar(center[1]));gj=jets(center);bj=[const(v) for v in coeff[0]];bt=[arb(0) for _ in range(3)]
  for pole,cc in zip(poles,coeff[1:]):
   diff=s-pole;dist=abs(diff).lower();assert dist>ar(rho)
   inv=1/diff;p=inv
   for j in range(D+1):
    for k in range(3):bj[k][j]+=cc[k]*p
    p*=-inv
   for k in range(3):bt[k]+=abs(cc[k]).upper()*ar(rho)**(D+1)/(dist**(D+1)*(dist-ar(rho)))
  mg,outer_error=controls(center,R);_,panel_error=controls(center,rho)
  gt=mg*ar(rho/R)**(D+1)/(1-ar(rho/R));le=panel_error+gt;scalar=[]
  for k in range(3):
   rp=scale(mul(gj[k],bj[k],2*D+1),-1);rp[0]+=1
   er=le*(norm(bj[k],rho)+bt[k])+norm(gj[k],rho)*bt[k]
   scalar.append((norm(rp,rho)+er).upper())
  l1=sum(scalar,arb(0)).upper();moment=sum((x**32 for x in scalar),arb(0)).upper()
  assert l1<1 and moment<1
  out.append({'index':index,'center':list(map(str,center)),'rho':str(rho),'sigma_floor':str(center[0]-R),
   'l1_upper':rat(l1),'T16_upper':rat(moment),'scalar_residual_upper':list(map(rat,scalar)),
   'finite_g_bound':rat(mg),'L_minus_g_outer':rat(outer_error),'L_minus_g_panel':rat(panel_error),'g_tail':rat(gt)})
 result={'status':'PASS_FOUR_FIXED_PANELS_ONLY','full_rectangle_certified':False,'pins':PINS,
  'precision_bits':224,'EM_N':N,'EM_M':M,'degree':D,'control_radius':str(R),
  'polynomial_method':'explicit finite coefficient loops; no acb_series; radial polynomial norm',
  'panels':out,'elapsed_seconds':time.perf_counter()-start}
 Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({'status':result['status'],'seconds':result['elapsed_seconds'],
  'bounds':[(p['index'],float(F(p['l1_upper'])),float(F(p['T16_upper']))) for p in out]},indent=2))
if __name__=='__main__':main()
