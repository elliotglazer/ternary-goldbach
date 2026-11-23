"""Explicit differentiated-theta trapezoid at five xi points. No zeta/Gamma calls."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json,time,sys
from flint import arb,acb,ctx
import flint

ctx.prec=160
HERE=Path(__file__).parent
PINS={
 '../integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md':
 '6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99',
 '../audit/REVIEW_PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md':
 'ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2'}
for path,pin in PINS.items():assert hashlib.sha256((HERE/path).read_bytes()).hexdigest().upper()==pin
def ar(x):
 x=F(x);return arb(str(x.numerator))/x.denominator
def rb(x):return [str(x.lower().fmpq()),str(x.upper().fmpq())]
def cb(x):return {'real':rb(x.real),'imag':rb(x.imag)}
def errbox(x):
 e=arb(0,x.upper());return acb(e,e)
def conj(x):return acb(x.real,-x.imag)

B=F(1,8);R=F(1,4);KAPPA=F(1,2);T=F(2);H=F(1,64);K=192;N=12;V=K*H
C=3*KAPPA;Q=C/2;Z0=3*C/2
A=(F(2048)/C**2+F(96)/C)*(1+Z0)/Z0;M=A/Q
assert 1-2*(B+R)**2>=KAPPA and 4*(B+R)<3
assert V==3
pi=arb.pi()
quad=2*ar(M)*(ar(T*R)).exp()/((2*pi*ar(R/H)).exp()-1)
space=ar(M)*(-ar(Q)*(2*ar(V)).exp()).exp()
theta=ar(H*(2*K+1)*A)*(2*ar(V)-ar(Q*(N+1)**2)).exp()
assert ar(Q)*(2*ar(V)).exp()>1
analytic=quad+space+theta
assert analytic<ar(F(1,10**35))
started=time.perf_counter();nodes=[];selected_terms=[];values=[]
for k in range(K+1):
 if time.perf_counter()-started>60:raise RuntimeError('INCOMPLETE: 60 second guard')
 w=acb(ar(k*H),ar(B));e2=(2*w).exp();e9=(ar(F(9,2))*w).exp();e5=(ar(F(5,2))*w).exp()
 terms=[]
 for n in range(1,N+1):
  term=(8*pi*pi*n**4*e9-12*pi*n*n*e5)*(-pi*n*n*e2).exp()
  terms.append(term)
  if k in [0,32,192] and n in [1,N]:selected_terms.append({'k':k,'n':n,'term':cb(term)})
 total=sum(terms,acb(0));values.append(total)
 nodes.append({'k':k,'v':str(k*H),'P_N_positive':cb(total)})

points=[('xi_0',F(0),F(0)),('xi_1',F(1),F(0)),('xi_2',F(2),F(0)),
        ('xi_half_plus_2i',F(1,2),F(2)),('xi_5032_plus_2i',F(629,1250),F(2))]
outputs=[]
for name,sigma,t in points:
 assert abs(sigma-F(1,2))<=F(3,2) and abs(t)<=T
 s=acb(ar(sigma),ar(t));z=s-ar(F(1,2))
 negative=acb(0);positive=acb(0)
 for k in range(1,K+1):
  positive+=values[k]*(z*ar(k*H)).exp()
  negative+=conj(values[k])*(-z*ar(k*H)).exp()
 raw=ar(H)*(negative+values[0]+positive)
 shifted=raw+errbox(analytic)
 recovery=(acb(0,ar(B))*z).exp()
 xi=recovery*shifted
 assert xi.is_finite() and xi.real>0
 assert xi.real.rad()+xi.imag.rad()<ar(F(1,10**30))
 if name in ['xi_0','xi_1']:assert xi.contains(acb(1))
 if name=='xi_2':assert (xi-acb(pi/3)).contains(0)
 if name=='xi_half_plus_2i':assert xi.imag.contains(0)
 outputs.append({'name':name,'s':[str(sigma),str(t)],
  'negative_unweighted_sum':cb(negative),'zero_node':cb(values[0]),'positive_unweighted_sum':cb(positive),
  'finite_trapezoid':cb(raw),'shifted_F_enclosure':cb(shifted),'recovery_factor':cb(recovery),
  'xi_enclosure':cb(xi),'xi_diagnostic':str(xi),'real_part_strictly_positive':True,
  'normalization_check':'exact 1 contained' if name in ['xi_0','xi_1'] else 'pi/3 difference contains 0' if name=='xi_2' else 'not an external reference comparison'})

out={'status':'PASS_EXTERNAL_XI_POINTS_ONLY','function':'source xiF, twice standard xi',
 'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'source_pins':PINS,
 'parameters':{'bits':ctx.prec,'b':str(B),'r':str(R),'kappa':str(KAPPA),'T':str(T),'h':str(H),'K':K,'N':N,'V':str(V),
               'C':str(C),'q':str(Q),'z0':str(Z0),'A':str(A),'M':str(M),'sigma_envelope':['0','2']},
 'errors':{'quadrature':rb(quad),'spatial':rb(space),'theta':rb(theta),'total_analytic':rb(analytic)},
 'positive_nodes':nodes,'selected_terms':selected_terms,'points':outputs,
 'flint_version':flint.__FLINT_VERSION__,'python_flint_version':flint.__version__,
 'elapsed_seconds':time.perf_counter()-started,
 'scope':'Five point enclosures only; no contour, winding, high-height, RH, or Lean claim. Normalization overlaps are consistency tests, not the analytic proof.'}
path=Path(__file__).with_suffix('.json')
if '--recompute' in sys.argv:
 old=json.loads(path.read_text());old.pop('elapsed_seconds');cmp=out.copy();cmp.pop('elapsed_seconds');assert old==cmp
else:path.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'status':out['status'],'elapsed_seconds':out['elapsed_seconds'],
                  'errors_diagnostic':{k:str(v) for k,v in [('quadrature',quad),('spatial',space),('theta',theta)]},
                  'points':[{'name':v['name'],'s':v['s'],'value':v['xi_diagnostic']} for v in outputs]},indent=2))
