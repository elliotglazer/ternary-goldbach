"""External interval certificate for chi_3, [.555,2] x [-33,33].
Explicit Euler--Maclaurin remainder; FLINT elementary balls; exact polygon winding.
No builtin L/zeta call is used in acceptance. No Lean proof is claimed.
"""
from fractions import Fraction as F
from math import comb,factorial
from pathlib import Path
import hashlib,json,sys,time
from flint import acb,arb,ctx
import flint

ctx.prec=128
LEFT=F(111,200);T=F(33);RIGHT=F(2);N=80;M=24
PATH=Path(__file__).with_suffix('.json')
def ar(q):
    q=F(q);return arb(str(q.numerator))/q.denominator
def cbox(a,b):
    return acb(arb(ar((a[0]+b[0])/2),ar(abs(a[0]-b[0])/2)),
               arb(ar((a[1]+b[1])/2),ar(abs(a[1]-b[1])/2)))
def error_box(r):
    e=arb(0,r.upper());return acb(e,e)
def dyadic(a):
    m,e=a.mid().man_exp();m=int(m);e=int(e)
    return F(m*2**e) if e>=0 else F(m,2**(-e))
bern=[F(1)]
for n in range(1,2*M+1):
    bern.append(-sum(F(comb(n+1,k))*bern[k] for k in range(n))/F(n+1))
assert bern[2]==F(1,6) and bern[4]==F(-1,30)
coeff=[ar(bern[2*k]/factorial(2*k)) for k in range(1,M+1)]
pre={}
for a in (F(1,3),F(2,3)):
    B=ar(N+a)
    pre[a]=([ar(j+a).log() for j in range(N)],B.log(),
            [B**(1-2*k) for k in range(1,M+1)])

def regular_em(s,a):
    """Hurwitz zeta with B^(1-s)/(s-1) omitted, including remainder.
    Domain contract: the actual evaluated point has Re(s)>=LEFT.
    Its input ball may extend slightly left by outward rounding.
    """
    logs,lb,powers=pre[a]
    poch=[acb(1)]
    for j in range(2*M):poch.append(poch[-1]*(s+j))
    bp=(-s*lb).exp()
    val=sum(((-s*l).exp() for l in logs),acb(0))+bp/2
    val+=bp*sum((coeff[k-1]*poch[2*k-1]*powers[k-1]
                 for k in range(1,M+1)),acb(0))
    rem=4*abs(poch[2*M])*(lb*(1-ar(LEFT)-2*M)).exp()
    rem/=6**(2*M)*(ar(LEFT)+2*M-1)
    return val+error_box(rem)

def exprel(z):
    K=18;term=acb(1);value=term
    for k in range(1,K+1):term=term*z/(k+1);value+=term
    r=abs(z)
    return value+error_box(r.exp()*r**(K+1)/factorial(K+2))

def evaluate(s):
    one=regular_em(s,F(1,3));two=regular_em(s,F(2,3))
    lb1=pre[F(1,3)][1];step=pre[F(2,3)][1]-lb1
    poles=((1-s)*lb1).exp()*step*exprel((1-s)*step)
    return (-s*arb(3).log()).exp()*(one-two+poles)

def cross(a,b):return a[0]*b[1]-a[1]*b[0]
def winding(vertices):
    assert vertices[0]==vertices[-1]
    result=0
    for a,b in zip(vertices,vertices[1:]):
        det=cross(a,b)
        if a[1]<=0<b[1] and det>0:result+=1
        elif b[1]<=0<a[1] and det<0:result-=1
    return result

def witness(image,va,vb):
    if not image.is_finite():return None
    for axis,iv in enumerate((image.real,image.imag)):
        for sign in (1,-1):
            if sign*iv>0 and sign*va[axis]>0 and sign*vb[axis]>0:
                return axis,sign
    return None

def check_input_partition(panels):
    start=(LEFT,-T);prev=start;length=F(0)
    for row in panels:
        a=tuple(map(F,row['a']));b=tuple(map(F,row['b']))
        assert a==prev
        assert ((a[1]==b[1]==-T and LEFT<=a[0]<b[0]<=RIGHT) or
                (a[0]==b[0]==RIGHT and -T<=a[1]<b[1]<=T) or
                (a[1]==b[1]==T and LEFT<=b[0]<a[0]<=RIGHT) or
                (a[0]==b[0]==LEFT and -T<=b[1]<a[1]<=T))
        length+=abs(b[0]-a[0])+abs(b[1]-a[1]);prev=b
    assert prev==start and length==2*(RIGHT-LEFT+2*T)

def replay(data):
    assert data['rectangle']==[['111/200','-33'],['2','33']]
    assert data['N']==N and data['M']==M and data['precision_bits']==ctx.prec
    panels=data['panels'];check_input_partition(panels)
    verts=[]
    for row in panels:
        a=tuple(map(F,row['a']));b=tuple(map(F,row['b']))
        va=tuple(map(F,row['va']));vb=tuple(map(F,row['vb']))
        if verts:assert verts[-1]==va
        else:verts.append(va)
        image=evaluate(cbox(a,b));axis,sign=row['witness']
        assert axis in (0,1) and sign in (1,-1)
        assert sign*(image.real if axis==0 else image.imag)>0
        assert sign*va[axis]>0 and sign*vb[axis]>0
        verts.append(vb)
    assert verts[0]==verts[-1]
    w=winding(verts)
    assert w==data['exact_winding_integer']==0
    return len(panels),w

def elementary_tests():
    v=[(F(-1),F(-1)),(F(1),F(-1)),(F(1),F(1)),(F(-1),F(1)),(F(-1),F(-1))]
    assert winding(v)==1 and winding(list(reversed(v)))==-1
    assert witness(acb(arb(0,1),arb(0,1)),(F(1),F(1)),(F(1),F(1))) is None
    assert witness(acb(2),(F(0),F(0)),(F(2),F(0))) is None

def main():
    elementary_tests();started=time.perf_counter()
    if '--replay' in sys.argv:
        data=json.loads(PATH.read_text());n,w=replay(data)
        print(json.dumps(dict(status='REPLAY_PASS_EXTERNAL_INTERVAL',panels=n,
            exact_winding_integer=w,wall_seconds=time.perf_counter()-started)))
        return
    panels=[];cache={};evaluations=0;splits=0;maxdepth=0
    def vertex(a):
        if a not in cache:
            z=evaluate(cbox(a,a));assert z.is_finite()
            cache[a]=(dyadic(z.real),dyadic(z.imag))
        return cache[a]
    def visit(a,b,depth):
        nonlocal evaluations,splits,maxdepth
        evaluations+=1
        if evaluations>30000 or depth>25 or time.perf_counter()-started>90:
            raise RuntimeError('bounded limit reached; contour NOT certified')
        va,vb=vertex(a),vertex(b);image=evaluate(cbox(a,b))
        h=witness(image,va,vb)
        if h is not None:
            panels.append(dict(a=list(map(str,a)),b=list(map(str,b)),
                va=list(map(str,va)),vb=list(map(str,vb)),witness=list(h),
                image_diagnostic=str(image)))
            maxdepth=max(maxdepth,depth);return
        splits+=1;mid=((a[0]+b[0])/2,(a[1]+b[1])/2)
        visit(a,mid,depth+1);visit(mid,b,depth+1)
    corners=[(LEFT,-T),(RIGHT,-T),(RIGHT,T),(LEFT,T),(LEFT,-T)]
    try:
        for a,b in zip(corners,corners[1:]):visit(a,b,0)
    except RuntimeError as e:
        PATH.write_text(json.dumps(dict(status='INCOMPLETE',reason=str(e),
            accepted_partial_panels=panels),indent=2));raise
    check_input_partition(panels)
    verts=[tuple(map(F,panels[0]['va']))]+[tuple(map(F,p['vb'])) for p in panels]
    w=winding(verts);assert w==0
    elapsed=time.perf_counter()-started
    # Builtin Hurwitz agreement is a diagnostic, never an acceptance input.
    references=[]
    for a in ((LEFT,F(0)),(LEFT,F(33)),(F(2),F(-33)),(F(1),F(0))):
        s=cbox(a,a)
        if a==(F(1),F(0)):
            ref=arb.pi()/(3*arb(3).sqrt())
        else:
            ref=(-s*arb(3).log()).exp()*(s.zeta(acb(ar(F(1,3))))-s.zeta(acb(ar(F(2,3)))))
        assert evaluate(s).overlaps(ref)
        references.append(dict(point=list(map(str,a)),overlap=True))
    data=dict(status='PASS_EXTERNAL_INTERVAL_CERTIFICATE_ONLY',function='primitive real chi modulo3',
        requested_height=32,contour_height='33',rectangle=[['111/200','-33'],['2','33']],
        orientation='counterclockwise',N=N,M=M,precision_bits=ctx.prec,
        python_flint_version=flint.__version__,flint_version=flint.__FLINT_VERSION__,
        script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        evaluations=evaluations,subdivisions=splits,accepted_panels=len(panels),
        max_depth=maxdepth,exact_winding_integer=w,construction_seconds=elapsed,
        reference_checks=references,panels=panels,
        caveat='External interval arithmetic plus mathematical homotopy/argument principle; not kernel-checked; not Hp(3).')
    PATH.write_text(json.dumps(data,indent=2)+'\n')
    print(json.dumps({k:v for k,v in data.items() if k!='panels'},indent=2))

if __name__=='__main__':main()
