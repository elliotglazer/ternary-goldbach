"""Independent explicit-theta xi enclosures. No builtin zeta, Gamma or L."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json,time,sys
from flint import arb,acb,ctx

START=time.perf_counter()
# Frozen tiny dyadic theta terms have denominators with up to 76844 digits.
# This bound affects only local parsing, not the mathematical enclosures.
sys.set_int_max_str_digits(1000000)
HERE=Path(__file__).resolve().parent
SRC=HERE.parent/'zero-sum'
PINS={
 'PRINCIPAL_XI_POINT_PILOT_2026-11-11.md':'AEBEA66214042FCCB24A50ACBD26FA2284035B1D8B2942CE9F8FE9FA961F3E94',
 'principal_xi_point_pilot_20261111.py':'264183495A1345B2EE6774D49F20864B4E218D14B09F73F23DF24E2A8BD653B2',
 'principal_xi_point_pilot_20261111.json':'BC521AE8AC5A53E7331909E0C80DB9B347905675D0680E3D192F0B3A29446A6D'}
for name,pin in PINS.items():
    assert hashlib.sha256((SRC/name).read_bytes()).hexdigest().upper()==pin
old=json.loads((SRC/'principal_xi_point_pilot_20261111.json').read_text())
assert old['status']=='PASS_EXTERNAL_XI_POINTS_ONLY'
assert old['script_sha256'].upper()==PINS['principal_xi_point_pilot_20261111.py']
ctx.prec=192

def ar(q):
    q=F(q);return arb(str(q.numerator))/q.denominator
def rb(v):return [str(v.lower().fmpq()),str(v.upper().fmpq())]
def cb(v):return {'real':rb(v.real),'imag':rb(v.imag)}
def subinterval(new,stored):
    lo,hi=map(F,rb(new));a,b=map(F,stored)
    return a<=lo<=hi<=b
def subcomplex(new,stored):
    return subinterval(new.real,stored['real']) and subinterval(new.imag,stored['imag'])
def box(e):
    radius=arb(0,e.upper());return acb(radius,radius)

pi=arb.pi();q=F(3,4);A=F(113984,81);M=A/q
assert M==F(455936,243)

# Re-evaluate every producer finite kernel aggregate at higher precision,
# using a factorization distinct from the producer's two-term expression.
def kernel(w,N,terms=False):
    u=(2*w).exp(); pref=4*(w/2).exp()
    vals=[]
    for n in range(1,N+1):
        z=pi*n*n*u
        vals.append(pref*z*(2*z-3)*(-z).exp())
    return vals if terms else sum(vals,acb(0))

node_count=0
for row in old['positive_nodes']:
    w=acb(ar(F(row['v'])),ar(F(1,8)))
    z=kernel(w,12)
    assert subcomplex(z,row['P_N_positive']),row['k']
    node_count+=1
term_count=0
for row in old['selected_terms']:
    w=acb(ar(F(row['k'],64)),ar(F(1,8)))
    val=kernel(w,12,True)[row['n']-1]
    assert subcomplex(val,row['term'])
    term_count+=1
assert node_count==193 and term_count==6

# Recheck all four producer analytic error balls at higher precision.
oq=2*ar(M)*ar(F(1,2)).exp()/((pi*32).exp()-1)
os=ar(M)*(-ar(q)*arb(6).exp()).exp()
ot=ar(F(385,64)*A)*(arb(6)-ar(q*169)).exp()
for key,value in [('quadrature',oq),('spatial',os),('theta',ot),('total_analytic',oq+os+ot)]:
    assert subinterval(value,old['errors'][key]),key

# An independent unshifted trapezoid. All parameters change except V=3.
b=F(0);r=F(1,3);h=F(1,80);K=240;N=16;V=K*h;T=2
assert V==3 and 1-2*r*r>=F(1,2) and 4*r<3
quad=2*ar(M)*ar(T*r).exp()/((2*pi*ar(r/h)).exp()-1)
space=ar(M)*(-ar(q)*(2*ar(V)).exp()).exp()
theta=ar(h*(2*K+1)*A)*(2*ar(V)-ar(q*(N+1)**2)).exp()
assert ar(q)*(2*ar(V)).exp()>1
analytic=quad+space+theta
assert analytic<ar(F(1,10**68))

# Purely real positive-node kernel; factorized summand is elementary.
nodes=[]
for k in range(K+1):
    v=ar(k*h);u=(2*v).exp();pref=4*(v/2).exp()
    zvals=[pi*n*n*u for n in range(1,N+1)]
    nodes.append(pref*sum((z*(2*z-3)*(-z).exp() for z in zvals),arb(0)))

results=[]
for row in old['points']:
    sigma,t=map(F,row['s']);assert 0<=sigma<=2 and abs(t)<=T
    z=acb(ar(sigma-F(1,2)),ar(t))
    val=acb(nodes[0])
    for k in range(1,K+1):
        # P(-v)=P(v) gives the cosh combination; no shifted recovery phase.
        arg=z*ar(k*h)
        val+=nodes[k]*(arg.exp()+(-arg).exp())
    finite=ar(h)*val
    xi=finite+box(analytic)
    assert xi.is_finite() and xi.real>0
    assert xi.real.rad()+xi.imag.rad()<ar(F(1,10**50))
    assert subcomplex(xi,row['xi_enclosure']),row['name']
    if sigma in (0,1) and t==0:assert xi.contains(acb(1))
    if sigma==2 and t==0:assert (xi-acb(pi/3)).contains(0)
    if sigma==F(1,2):assert xi.imag.contains(0)
    results.append({'name':row['name'],'s':row['s'],'finite_sum':cb(finite),
                    'xi_enclosure':cb(xi),'diagnostic':str(xi),
                    'contained_in_producer_enclosure':True,'positive_real_part':True})

assert time.perf_counter()-START<60
out={'status':'PASS_INDEPENDENT_EXPLICIT_THETA_XI_POINTS_ONLY','producer_pins':PINS,
     'parameters':{'bits':ctx.prec,'b':str(b),'r':str(r),'h':str(h),'K':K,'N':N,'V':str(V),
                   'kappa':'1/2','T':T,'A':str(A),'M':str(M),'q':str(q),'sigma_domain':['0','2']},
     'producer_rechecks':{'all_finite_nodes_contained':node_count,'selected_terms_contained':term_count,
                           'analytic_error_balls_contained':4},
     'errors':{'quadrature':rb(quad),'space':rb(space),'theta':rb(theta),'analytic_total':rb(analytic)},
     'points':results,'scope':'Five independent point enclosures, no segment or spectral claim'}
(HERE/'review_principal_xi_points_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'status':out['status'],'nodes':node_count,'terms':term_count,
 'errors':{'quad':str(quad),'space':str(space),'theta':str(theta)},
 'points':[{'name':r['name'],'value':r['diagnostic']} for r in results]},indent=2))
