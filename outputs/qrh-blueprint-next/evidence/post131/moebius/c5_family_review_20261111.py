"""Independent complete c5 geometry and alternative direct-EM interval check.
No builtin zeta/L evaluation. New files only; frozen author data are read-only.
"""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial, prod
import hashlib, json, time
from flint import arb, acb, ctx

HERE = Path(__file__).resolve().parent
AUTHOR = HERE.parent / 'zero-sum'
PINS = {
 'FAMILY_EVALUATOR_INTERFACE_2026-11-11.md': 'dca03cd8c62e19fba574f92cf0aeaa818d7de4a6954b5d8cdf4150c4f62fdd5e',
 'c5_family_dft_certificate_20261111.py': 'c5125697833cc998c79d854f73d8d6d80b442c6972885c1ac35675f128851fc8',
 'c5_family_dft_certificate_20261111.json': 'e2cb12ad11f75cf64957864b1d64e88b347611eb09c4a3c419bf95b07a5d60e2',
 'family_hurwitz_grid_budget_20261111.py': 'a21fc69b86e5f947bef854bd92b6de3896c81723e07ebf120a487485ce01a586',
 'family_hurwitz_grid_budget_20261111.json': 'eee412cc1de72f6c0ab487825559f1e4f5d186685c7a059af97dfe3db3e579d5',
}
for name, digest in PINS.items():
    assert hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest() == digest
data = json.loads((AUTHOR/'c5_family_dft_certificate_20261111.json').read_text())
rows = data['panels']
ctx.prec = 192
N, M, LEFT, T = 80, 24, Q(111,200), Q(12)

def A(q):
    q=Q(q); return arb(str(q.numerator))/q.denominator

def box(a,b):
    return acb(arb(A((a[0]+b[0])/2),A(abs(b[0]-a[0])/2)),
               arb(A((a[1]+b[1])/2),A(abs(b[1]-a[1])/2)))

# Independent character construction in natural residue order, as exponents of i.
units = [1,2,3,4]
logs_mod5 = {1:0,2:1,3:3,4:2}
exponents = [[k*logs_mod5[a] % 4 for a in units] for k in [1,2,3]]
assert exponents == [[0,1,3,2],[0,2,2,0],[0,3,1,2]]
for k in [1,2,3]:
    for a in units:
        for b in units:
            assert k*logs_mod5[a*b%5]%4 == k*(logs_mod5[a]+logs_mod5[b])%4
assert [e[-1] for e in exponents] == [2,0,2]
assert [(-e)%4 for e in exponents[0]] == exponents[2]
# Only the trivial character can factor through the sole proper divisor 1 of 5.
assert all(any(e != 0 for e in row) for row in exponents)
roots = [acb(1),acb(0,1),acb(-1),acb(0,-1)]
co = [arb.bernoulli(2*k)/factorial(2*k) for k in range(1,M+1)]
pre = {}
for a in units:
    alpha=Q(a,5); B=A(N+alpha)
    pre[a]=([A(j+alpha).log() for j in range(N)], B, B.log(),
            [B**(1-2*k) for k in range(1,M+1)])

def evaluate(s):
    # Direct integral pole terms, not author's common-subtraction/exprel formula.
    # Every original or subdivided contour box excludes s=1.
    poch=[acb(1)]
    for j in range(2*M): poch.append(poch[-1]*(s+j))
    vals=[]
    for a in units:
        logs,B,lb,powers=pre[a]; bp=(-s*lb).exp()
        v=sum(((-s*l).exp() for l in logs),acb(0))
        v+=bp*(B/(s-1)+A(Q(1,2)))
        v+=bp*sum((co[k-1]*poch[2*k-1]*powers[k-1] for k in range(1,M+1)),acb(0))
        radius=4*abs(poch[-1])*(lb*(1-A(LEFT)-2*M)).exp()/(6**(2*M)*(A(LEFT)+2*M-1))
        err=arb(0,radius.upper()); vals.append(v+acb(err,err))
    scale=(-s*arb(5).log()).exp()
    return [scale*sum((roots[e]*v for e,v in zip(es,vals)),acb(0)) for es in exponents]

leaves=0; maxdepth=0; calls=0
def check(a,b,witnesses,depth=0):
    global leaves,maxdepth,calls
    vals=evaluate(box(a,b)); calls+=1
    if all(sign*(v.real if axis==0 else v.imag)>0 for v,(axis,sign) in zip(vals,witnesses)):
        leaves+=1; maxdepth=max(maxdepth,depth); return
    assert depth<8, (a,b,depth)
    mid=tuple((x+y)/2 for x,y in zip(a,b))
    check(a,mid,witnesses,depth+1); check(mid,b,witnesses,depth+1)

began=time.perf_counter()
last=(LEFT,-T); verts=[[] for _ in range(3)]; lengths=[Q(0)]*4
for row in rows:
    a,b=tuple(map(Q,row['a'])),tuple(map(Q,row['b'])); assert a==last
    if a[1]==b[1]==-T: side=0; assert LEFT<=a[0]<b[0]<=2
    elif a[0]==b[0]==2: side=1; assert -T<=a[1]<b[1]<=T
    elif a[1]==b[1]==T: side=2; assert LEFT<=b[0]<a[0]<=2
    else: side=3; assert a[0]==b[0]==LEFT and -T<=b[1]<a[1]<=T
    lengths[side]+=abs(b[0]-a[0])+abs(b[1]-a[1]); last=b
    assert len(row['va'])==len(row['vb'])==len(row['witnesses'])==3
    for k in range(3):
        va,vb=tuple(map(Q,row['va'][k])),tuple(map(Q,row['vb'][k]))
        axis,sign=row['witnesses'][k]; assert axis in [0,1] and sign in [-1,1]
        assert sign*va[axis]>0 and sign*vb[axis]>0
        if verts[k]: assert verts[k][-1]==va
        else: verts[k].append(va)
        verts[k].append(vb)
    check(a,b,row['witnesses'])
assert last==(LEFT,-T) and lengths==[2-LEFT,2*T,2-LEFT,2*T]
windings=[]; crossings=[]
for vs in verts:
    assert vs[0]==vs[-1]; pos=neg=0
    # Ray rotated by 90 degrees from the author's horizontal-ray implementation.
    for a,b in zip(vs,vs[1:]):
        det=a[0]*b[1]-a[1]*b[0]
        if a[0]<=0<b[0] and det>0: pos+=1
        if b[0]<=0<a[0] and det<0: neg+=1
    windings.append(pos-neg); crossings.append([pos,neg])
assert windings==[0,0,0]

# Exact real-alpha Taylor bound, including the stronger displayed report bounds.
K=32; shift=16; h=Q(1,32); sigma=LEFT
assert 2**2+1000**2 < 1002**2
assert 1+Q(shift)/(sigma+K-1) < 2
for j in range(16):
    center=Q(2*j+1,32)
    assert center-Q(j,16)==h and Q(j+1,16)-center==h
E=2*Q(prod(1002+j for j in range(K)),512**K*factorial(K))
assert E<Q(2660,10**29) and 300000*E<Q(7978,10**24)
out={'status':'PASS_EXTERNAL_INDEPENDENT_ALL_PANELS', 'input_sha256':PINS,
     'alternative_parameters':{'bits':ctx.prec,'N':N,'M':M,'direct_pole_terms':True},
     'character_exponents_natural_residue_order':exponents,
     'shared_panels':len(rows),'alternative_vector_calls':calls,'refined_leaves':leaves,
     'max_refinement_depth':maxdepth,'edge_lengths':list(map(str,lengths)),
     'rotated_windings':windings,'positive_negative_crossings':crossings,
     'exact_grid_error':str(E),'grid_error_float_diagnostic':float(E),
     'exact_300000_grid_error':str(300000*E),
     'strong_report_grid_bounds_pass':True,
     'seconds':time.perf_counter()-began,'builtin_zeta_or_L_acceptance':False,
     'formal_Lean_or_production_height_claim':False}
HERE.joinpath('c5_family_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
