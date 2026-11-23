"""Independent topology and alternative Euler--Maclaurin panel check.
Uses existing FLINT elementary balls, N=96,M=20, direct pole terms (the contour
avoids s=1); no builtin L/zeta evaluation. No Lean theorem or production claim.
"""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib,json,time
from flint import arb,acb,ctx
HERE=Path(__file__).resolve().parent;AUTHOR=HERE.parent/'zero-sum'
source=AUTHOR/'c3_right_rectangle_20261111.py'
certificate=source.with_suffix('.json')
assert hashlib.sha256(source.read_bytes()).hexdigest()=='24d676376d36e39b89b718956f36fc0c6b3d0a6169053e5926d6043893d2dd4f'
assert hashlib.sha256(certificate.read_bytes()).hexdigest()=='27613ab3b75e26e5e1b20a4e66290cf425ffbd1b8e926c17b3487485275a0225'
data=json.loads(certificate.read_text());panels=data['panels'];ctx.prec=192
N=96;M=20;LEFT=Q(111,200);T=Q(33)
def A(q):
    q=Q(q);return arb(str(q.numerator))/q.denominator
def box(a,b):
    return acb(arb(A((a[0]+b[0])/2),A(abs(b[0]-a[0])/2)),
               arb(A((a[1]+b[1])/2),A(abs(b[1]-a[1])/2)))
assert arb(arb(1,1),arb(0)).contains(0) and arb(arb(1,1),arb(0)).contains(2)
assert arb(arb(1),arb(1,1)).contains(-1) and arb(arb(1),arb(1,1)).contains(3)
co=[arb.bernoulli(2*k)/factorial(2*k) for k in range(1,M+1)]
logs={a:[A(k+a).log() for k in range(N)] for a in [Q(1,3),Q(2,3)]}
bs={a:A(N+a) for a in logs};lbs={a:b.log() for a,b in bs.items()}
powb={a:[b**(1-2*k) for k in range(1,M+1)] for a,b in bs.items()}
def hurwitz(s,a):
    lb=lbs[a];bp=(-s*lb).exp()
    rising=[acb(1)]
    for j in range(2*M):rising.append(rising[-1]*(s+j))
    result=sum(((-s*l).exp() for l in logs[a]),acb(0))
    result+=bp*(bs[a]/(s-1)+A(Q(1,2)))
    result+=bp*sum((co[k-1]*rising[2*k-1]*powb[a][k-1] for k in range(1,M+1)),acb(0))
    radius=4*abs(rising[-1])*(lb*(1-A(LEFT)-2*M)).exp()/(6**(2*M)*(A(LEFT)+2*M-1))
    error=arb(0,radius.upper())
    return result+acb(error,error)
def evaluate(s):
    return (-s*arb(3).log()).exp()*(hurwitz(s,Q(1,3))-hurwitz(s,Q(2,3)))
start=(LEFT,-T);last=start;vertices=[];edge_lengths=[Q(0)]*4;failures=[]
initial_failures=[];refined_leaves=0;max_depth=0
def check_subpanel(a,b,axis,sign,depth=0):
    global refined_leaves,max_depth
    image=evaluate(box(a,b))
    if sign*(image.real if axis==0 else image.imag)>0:
        refined_leaves+=1;max_depth=max(max_depth,depth);return True
    if depth==8:return False
    mid=tuple((x+y)/2 for x,y in zip(a,b))
    return check_subpanel(a,mid,axis,sign,depth+1) and check_subpanel(mid,b,axis,sign,depth+1)
began=time.perf_counter()
for i,row in enumerate(panels):
    a=tuple(map(Q,row['a']));b=tuple(map(Q,row['b']));assert a==last
    va=tuple(map(Q,row['va']));vb=tuple(map(Q,row['vb']))
    if vertices:assert vertices[-1]==va
    else:vertices.append(va)
    vertices.append(vb)
    if a[1]==b[1]==-T:edge=0;assert LEFT<=a[0]<b[0]<=2
    elif a[0]==b[0]==2:edge=1;assert -T<=a[1]<b[1]<=T
    elif a[1]==b[1]==T:edge=2;assert LEFT<=b[0]<a[0]<=2
    else:edge=3;assert a[0]==b[0]==LEFT and -T<=b[1]<a[1]<=T
    edge_lengths[edge]+=abs(b[0]-a[0])+abs(b[1]-a[1]);last=b
    axis,sign=row['witness'];assert axis in [0,1] and sign in [-1,1]
    assert sign*va[axis]>0 and sign*vb[axis]>0
    image=evaluate(box(a,b))
    if not sign*(image.real if axis==0 else image.imag)>0:initial_failures.append(i)
    if not check_subpanel(a,b,axis,sign):failures.append(i)
assert last==start and vertices[0]==vertices[-1]
assert edge_lengths==[2-LEFT,2*T,2-LEFT,2*T]
# Independent winding via crossings of x=0 (rotate the polygon 90 degrees).
w=0;positive=negative=0
for a,b in zip(vertices,vertices[1:]):
    determinant=a[0]*b[1]-a[1]*b[0]
    if a[0]<=0<b[0] and determinant>0:w+=1;positive+=1
    if b[0]<=0<a[0] and determinant<0:w-=1;negative+=1
assert w==0
assert not failures, failures
out={'status':'Independent topology passed; alternative EM same-witness failures reported explicitly',
     'N':N,'M':M,'precision_bits':ctx.prec,'panels':len(panels),'edge_lengths':list(map(str,edge_lengths)),
     'exact_rotated_winding':w,'positive_crossings':positive,'negative_crossings':negative,
     'initial_unrefined_panel_failures':len(initial_failures),
     'refined_leaves':refined_leaves,'maximum_refinement_depth':max_depth,
     'alternative_panel_failures':failures,'alternative_all_panels_pass':not failures,
     'seconds':time.perf_counter()-began,'input_script_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
     'input_certificate_sha256':hashlib.sha256(certificate.read_bytes()).hexdigest(),
     'requested_height':32,'contour_height':33,'production_height_proved':False}
HERE.joinpath('c3_rectangle_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
