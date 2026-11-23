"""Bounded independent parameter/formula consistency checks, not proof by overlap.
Analytic enclosure justification is supplied in the companion review. No builtin zeta.
"""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial, prod
import hashlib, json, runpy, sys, io, contextlib, time
from flint import arb, acb, ctx
HERE=Path(__file__).resolve().parent; AUTHOR=HERE.parent/'zero-sum'
PINS={
 'FAMILY_ALPHA_MATERIALIZATION_2026-11-11.md':'f6a4dbdf9d6ea212b3c93ae282ce1ca1c463a8004d67617240232f2c74958b5c',
 'family_alpha_materialize_20261111.py':'fd2c16f0b3c969265e61972d5f2c5772c56e9baba41b66c34f7f82dc2de1f0f6',
 'family_alpha_materialize_20261111.json':'8e50cda44befe7ce2f38ba3eb3bcdcd1007ce64fc778e7f3ecba0959ff0c3e48'}
for f,h in PINS.items(): assert hashlib.sha256((AUTHOR/f).read_bytes()).hexdigest()==h
receipt=json.loads((AUTHOR/'family_alpha_materialize_20261111.json').read_text())
# Author module executes its full five-case recomputation on import; prohibit writes.
oldargs=sys.argv; sys.argv=['family_alpha_materialize_20261111.py','--recompute']
with contextlib.redirect_stdout(io.StringIO()) as capture:
    author=runpy.run_path(str(AUTHOR/'family_alpha_materialize_20261111.py'))
sys.argv=oldargs
replay=author['out']
for old,new in zip(receipt['runs'],replay['runs']):
    for key in ['name','s_center','s_radii','all100_overlap','max_input_EM_error',
                'max_grid_radius','max_direct_radius','min_grid_accuracy_bits',
                'min_direct_accuracy_bits','samples']:
        assert old[key]==new[key], (old['name'],key)

LEFT=Q(111,200); NN=768; MM=48
def A(q):
    q=Q(q); return arb(str(q.numerator))/q.denominator
def error(r):
    e=arb(0,r.upper()); return acb(e,e)
def panel(re,im,rr,ri):
    return acb(arb(A(re),A(rr)),arb(A(im),A(ri)))
ctx.prec=192
co=[arb.bernoulli(2*j)/factorial(2*j) for j in range(1,MM+1)]
def scalar(s,alpha,lower,deflate):
    # Separately calculated powers at the actual argument; no k-recurrence reuse.
    B=A(NN+alpha); lb=B.log(); bp=(-s*lb).exp()
    v=sum(((-s*A(n+alpha).log()).exp() for n in range(NN)),acb(0))+bp/2
    rising=acb(1)
    for j in range(1,2*MM+1):
        rising*=s+(j-1)
        if j%2:
            v+=co[(j-1)//2]*rising*B**(-j)*bp
    z=(1-s)*lb
    if deflate and abs(z)<1:
        # Independent degree-48 regularized integral expansion, including at s=1.
        series=acb(0)
        for j in range(48,-1,-1): series=series*z+A(Q(1,factorial(j+1)))
        v-=lb*(series+error(abs(z).exp()*abs(z)**49/factorial(50)))
    else:
        assert not (s-1).contains(0)
        v+=((z.exp()-1) if deflate else z.exp())/(s-1)
    radius=4*abs(rising)*B**(1-A(lower)-2*MM)/(6**(2*MM)*(A(lower)+2*MM-1))
    return v+error(radius)

E=Q(2*prod(1002+j for j in range(32)),512**32*factorial(32))
assert E<Q(2660,10**29)
geometry=[]
for a in range(1,101):
    alpha=Q(a,101); cell=(16*a)//101; center=Q(2*cell+1,32)
    assert 0<=cell<16 and abs(alpha-center)<=Q(1,32) and alpha>0
    geometry.append([a,cell])
results=[]; begin=time.perf_counter()
for ci,(name,re,im,rr,ri) in enumerate(author['cases']):
    assert Q(re)-Q(rr)>=LEFT
    assert (abs(Q(re))+Q(rr))**2+(abs(Q(im))+Q(ri))**2<1002**2
    ctx.prec=160; s_old=panel(re,im,rr,ri)
    grid,_=author['materialize'](s_old)
    assert len(grid)==16 and all(len(row)==32 for row in grid)
    assert all(v.is_finite() for row in grid for v in row)
    fast=[author['alpha_eval'](s_old,Q(a,101),grid) for a in range(1,101)]
    ctx.prec=192; s=panel(re,im,rr,ri)
    # All 512 coefficient intervals checked on each of the three original panels.
    coefficient_checks=0
    if ci<3:
        for cell in range(16):
            alpha=16+Q(2*cell+1,32); mul=acb(1)
            for k in range(32):
                if k: mul*=-(s+k-1)/k
                independent=mul*scalar(s+k,alpha,LEFT+k,k==0)
                assert independent.is_finite() and independent.overlaps(grid[cell][k])
                # Check the report's max-input-error claim without its max selector.
                rising=acb(1)
                for j in range(80): rising*=s+k+j
                B=A(512+alpha)
                err=4*abs(rising)*B**(1-A(LEFT)-k-80)/(6**80*(A(LEFT)+k+79))
                assert err<A(Q(78,10**42))
                coefficient_checks+=1
    direct=[]
    for a in range(1,101):
        val=scalar(s,Q(a,101),LEFT,True)
        assert val.is_finite() and val.overlaps(fast[a-1]); direct.append(val)
    results.append({'name':name,'coefficients_checked':coefficient_checks,
                    'residues_checked':100,'all_consistency_checks_pass':True,
                    'alternative_min_accuracy_bits':min(v.rel_accuracy_bits() for v in direct),
                    'alternative_max_radius':max(float(v.real.rad()+v.imag.rad()) for v in direct)})
for f,h in PINS.items(): assert hashlib.sha256((AUTHOR/f).read_bytes()).hexdigest()==h
out={'status':'PASS_BOUNDED_ANALYTIC_REVIEW_WITH_NUMERICAL_CONSISTENCY_CHECKS',
     'input_sha256':PINS,'author_replay_all_non_timing_fields_match':True,
     'independent_parameters':{'bits':192,'N':NN,'M':MM,'exprel_degree':48},
     'runs':results,'exact_grid_error':str(E),'all100_exact_cell_assignments_pass':True,
     'all_primary_input_EM_errors_below_7_8e_minus41':True,
     'seconds':time.perf_counter()-begin,
     'overlap_is_analytic_proof':False,'builtin_zeta_or_L_used':False,
     'full_contour_or_production_height_or_Lean_claim':False}
HERE.joinpath('alpha_materialization_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
