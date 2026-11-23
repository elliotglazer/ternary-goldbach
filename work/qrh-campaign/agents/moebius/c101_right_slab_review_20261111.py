"""Independent complete-slab check with alternate EM/Cauchy parameters.
No builtin zeta or L, no alpha interpolation, no production-height claim.
The three expected frozen hashes are supplied on the command line.
"""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib,json,sys,time
from flint import arb,acb,ctx

START=time.perf_counter()
HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parent/'zero-sum'
assert len(sys.argv)==4,'Supply note, script, receipt SHA256 pins'
names=['C101_RIGHT_SLAB_CERTIFICATE_2026-11-11.md','c101_right_slab_20261111.py','c101_right_slab_20261111.json']
pins=dict(zip(names,[s.lower() for s in sys.argv[1:]]))
def pincheck():
    for name,sha in pins.items():
        assert hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest()==sha,name
pincheck()
data=json.loads((AUTHOR/names[2]).read_text())
assert data['script_sha256']==pins[names[1]]
base_sha='fd75dac17af6735e9a5ae72e5a47096592609d2371cd5a65643b544f5b8f4e11'
assert data['evaluator_sha256'].lower()==base_sha
assert hashlib.sha256((AUTHOR/'c101_cauchy_alpha_block_20261111.py').read_bytes()).hexdigest()==base_sha
print('Prioritizing complete alternate contour verification; no redundant author regeneration.',flush=True)
pincheck()

def limit():
    assert time.perf_counter()-START<570,'INCOMPLETE: independent audit wall cap'

LEFT,RIGHT,LOW,HIGH=Q(111,200),Q(2),Q(7999,8),Q(8001,8)
edges=[LEFT+(RIGHT-LEFT)*Q(i,6) for i in range(7)]
centers=[(edges[i]+edges[i+1])/2 for i in range(6)]
R,RHO,RAD=Q(1,2),Q(1,4),Q(1,5)
SIG=centers[0]-RHO
OUTER=Q(600000)
assert centers[0]-R==Q(421,2400) and SIG==Q(1021,2400)
assert OUTER>102*Q(1003)/(centers[0]-R)
assert ((RIGHT-LEFT)/12)**2+Q(1,8)**2<RAD**2
assert data['label']==1 and data['rectangle']==list(map(str,[LEFT,RIGHT,LOW,HIGH]))
assert data['status']=='PASS_EXTERNAL_SINGLE_CHARACTER_SLAB'
assert data['R']==str(R) and data['rho']==str(RHO) and data['r']==str(RAD)
assert data['samples_per_model']==64 and data['outer_bound']==2000000
assert [m['center'] for m in data['models']]==[[str(c),'1000'] for c in centers]
old_alias=Q(2000000)/(1-RAD/R)*((RAD/R)**64+(RHO/R)**64/(1-(RHO/R)**64))
assert old_alias==Q(data['alias_exact']) and old_alias<Q(2,10**13)

# Exact identity of the single primitive nonprincipal character.
assert all(101%d for d in range(2,11))
gen=[pow(2,j,101) for j in range(100)]
assert sorted(gen)==list(range(1,101)) and pow(2,50,101)==100
logs={a:j for j,a in enumerate(gen)}
for a in range(1,101):
    for b in range(1,101):
        assert logs[a*b%101]==(logs[a]+logs[b])%100

# Verify exact closed geometry and a second rational winding ray.
last=(LEFT,LOW);verts=[];lengths=[Q(0)]*4;lastedge=0
panels=data['panels']
for row in panels:
    a,b=tuple(map(Q,row['a'])),tuple(map(Q,row['b']))
    va,vb=tuple(map(Q,row['va'])),tuple(map(Q,row['vb']))
    assert a==last
    if a[1]==b[1]==LOW:
        edge=0;assert LEFT<=a[0]<b[0]<=RIGHT
    elif a[0]==b[0]==RIGHT:
        edge=1;assert LOW<=a[1]<b[1]<=HIGH
    elif a[1]==b[1]==HIGH:
        edge=2;assert LEFT<=b[0]<a[0]<=RIGHT
    else:
        edge=3;assert a[0]==b[0]==LEFT and LOW<=b[1]<a[1]<=HIGH
    assert edge>=lastedge;lastedge=edge
    lengths[edge]+=abs(b[0]-a[0])+abs(b[1]-a[1]);last=b
    if verts:assert verts[-1]==va
    else:verts.append(va)
    verts.append(vb)
    axis,sign=row['witness'];assert axis in [0,1] and sign in [-1,1]
    assert sign*va[axis]>0 and sign*vb[axis]>0
    k=row['model'];assert k in range(6)
    for pt in [a,b]:assert (pt[0]-centers[k])**2+(pt[1]-1000)**2<=RAD**2
assert last==(LEFT,LOW) and verts[0]==verts[-1]
assert lengths==[RIGHT-LEFT,HIGH-LOW,RIGHT-LEFT,HIGH-LOW]
assert len(panels)==data['accepted_panels']
rv=[(3*x+4*y,-4*x+3*y) for x,y in verts]
pos=neg=0
for a,b in zip(rv,rv[1:]):
    det=a[0]*b[1]-a[1]*b[0]
    if a[1]<=0<b[1] and det>0:pos+=1
    elif b[1]<=0<a[1] and det<0:neg+=1
assert pos-neg==data['exact_winding']==0
print('Exact character, four edges, shared vertices and rotated winding passed.',flush=True)

# Alternate direct Hurwitz EM, numerical residue order, trig roots.
ctx.prec=192;N=768;M=48;COUNT=48
def A(q):
    q=Q(q);return arb(str(q.numerator))/q.denominator
def error(r):
    e=arb(0,r.upper());return acb(e,e)
def root(j,n):
    angle=2*arb.pi()*A(Q(j,n));return acb(angle.cos(),angle.sin())
weights=[root(logs[a],100) for a in range(1,101)]
roots=[root(j,COUNT) for j in range(COUNT)]
berns=[arb.bernoulli(2*k)/factorial(2*k) for k in range(1,M+1)]
pre=[]
for a in range(1,101):
    alpha=Q(a,101);B=A(N+alpha)
    pre.append(([A(n+alpha).log() for n in range(N)],B,B.log(),
                [B**(1-2*k) for k in range(1,M+1)]))

def sample(s):
    limit();poch=[acb(1)]
    for j in range(2*M):poch.append(poch[-1]*(s+j))
    total=acb(0)
    assert not (s-1).contains(0)
    for weight,(bases,B,lb,powers) in zip(weights,pre):
        bp=(-s*lb).exp()
        val=sum(((-s*l).exp() for l in bases),acb(0))+bp*(B/(s-1)+A(Q(1,2)))
        val+=bp*sum((berns[k-1]*poch[2*k-1]*powers[k-1] for k in range(1,M+1)),acb(0))
        er=4*abs(poch[-1])*B**(1-A(SIG)-2*M)/(6**(2*M)*(A(SIG)+2*M-1))
        total+=weight*(val+error(er))
    return (-s*arb(101).log()).exp()*total

alias=OUTER/(1-RAD/R)*((RAD/R)**COUNT+(RHO/R)**COUNT/(1-(RHO/R)**COUNT))
assert alias<Q(36,10**10)
models=[];model_seconds=[]
for c in centers:
    began=time.perf_counter();values=[sample(acb(A(c),1000)+A(RHO)*w) for w in roots]
    coeff=[sum((values[j]*roots[-j*n%COUNT] for j in range(COUNT)),acb(0))/COUNT for n in range(COUNT)]
    models.append(coeff);model_seconds.append(time.perf_counter()-began)
    print('Independent direct-EM model',len(models),'of 6 passed sample construction.',flush=True)

def box(a,b):
    return acb(arb(A((a[0]+b[0])/2),A(abs(a[0]-b[0])/2)),
               arb(A((a[1]+b[1])/2),A(abs(a[1]-b[1])/2)))
assert arb(arb(1,1),arb(0)).contains(0) and arb(arb(1,1),arb(0)).contains(2)
assert arb(arb(1),arb(1,1)).contains(-1) and arb(arb(1),arb(1,1)).contains(3)
calls=leaves=maxdepth=initial_failures=0
min_margin=arb(10**20)
def check(k,a,b,axis,sign,depth=0):
    global calls,leaves,maxdepth,min_margin,initial_failures
    limit();calls+=1
    z=(box(a,b)-acb(A(centers[k]),1000))/A(RHO);v=acb(0)
    for coefficient in reversed(models[k]):v=v*z+coefficient
    v+=error(A(alias));coord=sign*(v.real if axis==0 else v.imag)
    if coord>0:
        leaves+=1;maxdepth=max(maxdepth,depth)
        if coord.lower()<min_margin.lower():min_margin=coord.lower()
        return
    if depth==0:initial_failures+=1
    assert depth<10,('INCOMPLETE',k,a,b,axis,sign)
    mid=tuple((x+y)/2 for x,y in zip(a,b))
    check(k,a,mid,axis,sign,depth+1);check(k,mid,b,axis,sign,depth+1)
for row in panels:
    check(row['model'],tuple(map(Q,row['a'])),tuple(map(Q,row['b'])),*row['witness'])
pincheck()
out={'status':'PASS_INDEPENDENT_FULL_CLOSED_SLAB', 'author_pins':pins,
 'author_model_regeneration_performed':False,
 'reason':'Complete independent alternate-evaluator check prioritized within 10-minute computation cap.',
 'character_label':1,'exact_multiplication_pairs':10000,
 'rectangle':list(map(str,[LEFT,RIGHT,LOW,HIGH])),'edge_lengths':list(map(str,lengths)),
 'original_panels':len(panels),'rotated_winding':pos-neg,'positive_crossings':pos,'negative_crossings':neg,
 'alternate_parameters':{'precision':192,'EM_N':N,'EM_M':M,'Cauchy_samples':COUNT,
     'sample_sigma_floor':str(SIG),'outer_bound':str(OUTER),'alias_exact':str(alias)},
 'alternate_model_seconds':model_seconds,'alternate_panel_calls':calls,'alternate_leaves':leaves,
 'initial_inconclusive_panels':initial_failures,'extra_refinement_depth':maxdepth,
 'minimum_coordinate_lower_diagnostic':str(min_margin),'total_seconds':time.perf_counter()-START,
 'builtin_zeta_or_L_used':False,'mere_overlap_used_for_acceptance':False,
 'scope':'One actual chi_1 modulo101, one closed rectangle; no full height, family, or Lean claim',
 'review_script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
HERE.joinpath('c101_right_slab_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='author_pins'},indent=2))
