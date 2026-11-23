"""Independent actual-L Cauchy model, direct EM samples, every stored panel.
No builtin zeta/L; no contour or winding assertion. Frozen inputs are read-only.
"""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial,prod
import contextlib,io,runpy,sys,json,hashlib,time
from flint import arb,acb,ctx
HERE=Path(__file__).resolve().parent;AUTHOR=HERE.parent/'zero-sum'
PINS={
 'C101_CAUCHY_ALPHA_BLOCK_2026-11-11.md':'4f73c1fa9c8d8c1c5eccd22db0348fcac52108c126b840e5bc419fcd9968bf5b',
 'c101_cauchy_alpha_block_20261111.py':'fd75dac17af6735e9a5ae72e5a47096592609d2371cd5a65643b544f5b8f4e11',
 'c101_cauchy_alpha_block_20261111.json':'087c2577d42cfb22ca9ba2e0e00d17bd9c5c9585c4bab854920a3e26131e2f84'}
for name,h in PINS.items():assert hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest()==h
frozen=json.loads((AUTHOR/'c101_cauchy_alpha_block_20261111.json').read_text())
oldargs=sys.argv;sys.argv=['c101_cauchy_alpha_block_20261111.py','--recompute']
with contextlib.redirect_stdout(io.StringIO()):
    author=runpy.run_path(str(AUTHOR/'c101_cauchy_alpha_block_20261111.py'))
sys.argv=oldargs
for key,value in frozen.items():
    if key.endswith('_seconds'):continue
    assert value==author['out'][key], key
print('Author replay: all non-timing receipt fields match.',flush=True)

assert all(101%d for d in range(2,11))
residues=[];a=1
for j in range(100):residues.append(a);a=a*2%101
assert a==1 and sorted(residues)==list(range(1,101))
logs={a:j for j,a in enumerate(residues)}
for a in range(1,101):
    for b in range(1,101):assert logs[a*b%101]==(logs[a]+logs[b])%100
assert logs[100]==50
assert list(range(1,100))==[row['k'] for row in frozen['characters']]
assert all((100-k)%100 in range(1,100) for k in range(1,100))
SIG=Q(61,200);CENTER_RE=Q(111,200);R=Q(1,2);RHO=Q(1,4);RAD=Q(1,8)
S=Q(200211,200);MMAX=Q(102)*S/Q(11,200)
assert MMAX==1856502 and CENTER_RE-RHO==SIG and CENTER_RE-R==Q(11,200)
assert 1000+CENTER_RE+RHO<1002 and Q(16)/(SIG+31)<1
E=Q(2*prod(1002+j for j in range(32)),512**32*factorial(32))
assert E==Q(frozen['alpha_error_exact']) and 400*E<Q(1064,10**26)
old_alias=MMAX/(1-RAD/R)*((RAD/R)**64+(RHO/R)**64/(1-(RHO/R)**64))
assert old_alias==Q(frozen['cauchy_error_exact']) and old_alias<Q(14,10**14)

ctx.prec=192;N=768;M=48;COUNT=48
def A(q):
    q=Q(q);return arb(str(q.numerator))/q.denominator
def root(j,n):
    angle=2*arb.pi()*A(Q(j,n));return acb(angle.cos(),angle.sin())
def error(r):
    e=arb(0,r.upper());return acb(e,e)
center=acb(A(CENTER_RE),1000)
charroots=[root(j,100) for j in range(100)]
sampleroots=[root(j,COUNT) for j in range(COUNT)]
co=[arb.bernoulli(2*k)/factorial(2*k) for k in range(1,M+1)]
pre=[]
for a in range(1,101):
    alpha=Q(a,101);B=A(N+alpha)
    pre.append(([A(n+alpha).log() for n in range(N)],B,B.log(),
                [B**(1-2*k) for k in range(1,M+1)]))
def vector(s):
    # Natural residue order and direct raw Hurwitz integral terms. s is far from1.
    poch=[acb(1)]
    for j in range(2*M):poch.append(poch[-1]*(s+j))
    values=[]
    for bases,B,lb,powers in pre:
        bp=(-s*lb).exp()
        v=sum(((-s*l).exp() for l in bases),acb(0))+bp*(B/(s-1)+A(Q(1,2)))
        v+=bp*sum((co[k-1]*poch[2*k-1]*powers[k-1] for k in range(1,M+1)),acb(0))
        err=4*abs(poch[-1])*B**(1-A(SIG)-2*M)/(6**(2*M)*(A(SIG)+2*M-1))
        values.append(v+error(err))
    scale=(-s*arb(101).log()).exp()
    return [scale*sum((v*charroots[k*logs[a]%100] for a,v in enumerate(values,1)),acb(0))
            for k in range(1,100)]
began=time.perf_counter();samples=[]
for j,w in enumerate(sampleroots):
    vals=vector(center+A(RHO)*w)
    assert all(v.is_finite() for v in vals);samples.append(vals)
    if j%12==11:print('Independent direct-EM sample vectors:',j+1,flush=True)
coeff=[[sum((samples[j][k]*sampleroots[-j*n%COUNT] for j in range(COUNT)),acb(0))/COUNT
        for n in range(COUNT)] for k in range(99)]
alias=MMAX/(1-RAD/R)*((RAD/R)**COUNT+(RHO/R)**COUNT/(1-(RHO/R)**COUNT))
assert alias<Q(1,10**8)
def model(k,lo,hi):
    z=acb(0,arb(A((lo+hi)/2),A((hi-lo)/2)))/A(RHO);v=acb(0)
    for c in reversed(coeff[k-1]):v=v*z+c
    return v+error(A(alias))
leaves=0;maxdepth=0;min_margin=arb(1000000)
def check(k,lo,hi,axis,sign,depth=0):
    global leaves,maxdepth,min_margin
    v=model(k,lo,hi);coordinate=sign*(v.real if axis==0 else v.imag)
    if coordinate>0:
        leaves+=1;maxdepth=max(maxdepth,depth)
        if coordinate.lower()<min_margin.lower():min_margin=coordinate.lower()
        return
    assert depth<8,(k,lo,hi)
    mid=(lo+hi)/2;check(k,lo,mid,axis,sign,depth+1);check(k,mid,hi,axis,sign,depth+1)
panel_count=0
for row in frozen['characters']:
    k=row['k'];assert row['parity']==('odd' if k%2 else 'even');last=-RAD
    for p in row['panels']:
        lo,hi=Q(p['lo']),Q(p['hi']);axis,sign=p['witness']
        assert lo==last and -RAD<=lo<hi<=RAD and axis in [0,1] and sign in [-1,1]
        check(k,lo,hi,axis,sign);last=hi;panel_count+=1
    assert last==RAD
assert panel_count==159==frozen['total_accepted_panels']
for name,h in PINS.items():assert hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest()==h
out={'status':'PASS_INDEPENDENT_ALL_CHARACTER_WHOLE_PANEL_MODEL',
 'input_sha256':PINS,'author_replay_all_non_timing_fields_match':True,
 'parameters':{'bits':ctx.prec,'N':N,'M':M,'samples':COUNT,'natural_residue_order':True,
               'raw_Hurwitz_integral_terms':True,'outer_bound':int(MMAX)},
 'alias_error_exact':str(alias),'alias_error_float_diagnostic':float(alias),
 'exact_character_multiplication_pairs_checked':10000,'characters':99,
 'stored_panels':panel_count,'independent_accepted_leaves':leaves,
 'additional_maxdepth':maxdepth,'minimum_coordinate_lower_bound_diagnostic':str(min_margin),
 'independent_seconds':time.perf_counter()-began,
 'builtin_zeta_or_L_acceptance':False,'overlap_is_proof':False,
 'scope':'Only sigma=.555,t in[999.875,1000.125]; no contour, winding, production height or Lean.'}
HERE.joinpath('c101_model_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
