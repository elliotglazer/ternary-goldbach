"""Candidate external zetaF head counts via shared contours and Taylor panels.

No built-in zeta calls. Euler--Maclaurin plus an explicit Cauchy Taylor bound.
No Lean proof. A bounded incomplete run is never a spectral certificate.
"""
import argparse, hashlib, json, time
from fractions import Fraction as F
from math import comb, factorial, ceil
from pathlib import Path
from flint import arb, acb, acb_series, ctx

LEFT=F(-1,10); RIGHT=F(11,10); M=32; K=24; RADIUS=F(1)
ctx.prec=128;ctx.cap=K

def ar(q):
    q=F(q); return arb(str(q.numerator))/q.denominator
def point(p): return acb(ar(p[0]),ar(p[1]))
def cbox(a,b):
    return acb(arb(ar((a[0]+b[0])/2),ar(abs(a[0]-b[0])/2)),
               arb(ar((a[1]+b[1])/2),ar(abs(a[1]-b[1])/2)))
def error_box(r):
    v=arb(0,r.upper()); return acb(v,v)
def dyadic(a):
    m,e=map(int,a.mid().man_exp());return F(m*2**e) if e>=0 else F(m,2**(-e))
def encode(p):return list(map(str,p))
def decode(p):return tuple(map(F,p))
def midpoint(a,b):return ((a[0]+b[0])/2,(a[1]+b[1])/2)
def distance(a,b):
    assert a[0]==b[0] or a[1]==b[1]
    return abs(a[0]-b[0])+abs(a[1]-b[1])
def crossing(a,b):
    det=a[0]*b[1]-a[1]*b[0]
    if a[1]<=0<b[1]:
        assert det!=0, 'polygon edge intersects origin'
        return int(det>0)
    if b[1]<=0<a[1]:
        assert det!=0, 'polygon edge intersects origin'
        return -int(det<0)
    return 0
def witness(image,va,vb):
    if not image.is_finite():return None
    for axis,iv in enumerate((image.real,image.imag)):
        for sign in (1,-1):
            if sign*iv>0 and sign*va[axis]>0 and sign*vb[axis]>0:
                return axis,sign
    return None

def grid(height):
    height=F(height);assert 14<=height<=1500 and height.denominator==1
    cap=int(height*1024);n=14*1024;out=[F(n,1024)]
    while n<cap:
        n=min(cap,n+n//100);out.append(F(n,1024))
    return out

class Evaluator:
    def __init__(self,N):
        self.N=N; self.B=N+1; self.logs=[ar(j).log() for j in range(1,N+1)]
        self.lb=ar(self.B).log()
        bern=[F(1)]
        for n in range(1,2*M+1):
            bern.append(-sum(F(comb(n+1,k))*bern[k] for k in range(n))/F(n+1))
        assert bern[2]==F(1,6) and bern[4]==F(-1,30)
        self.coeff=[ar(bern[2*k]/factorial(2*k)) for k in range(1,M+1)]
        self.powers=[ar(self.B)**(1-2*k) for k in range(1,M+1)]
    def finite(self,s):
        """Entire, finite, pole-cancelled EM expression, scalar or series."""
        val=sum(((-s*l).exp() for l in self.logs),0)+(-s*self.lb).exp()/2
        poch=s*0+1;terms=0
        for j in range(1,2*M):
            poch*=s+(j-1)
            if j%2==1:
                k=(j+1)//2
                terms+=self.coeff[k-1]*poch*self.powers[k-1]
        val+=(-s*self.lb).exp()*terms
        return (s-1)*val+((1-s)*self.lb).exp()
    def em_error(self,S):
        # All actual contour points have Re(s)>=LEFT.
        poch=arb(1)
        for j in range(2*M):poch*=S+j
        rem=4*poch*(self.lb*(1-ar(LEFT)-2*M)).exp()
        rem/=6**(2*M)*(ar(LEFT)+2*M-1)
        return (S+1)*rem
    def outer_bound(self,center):
        # Bound finite g on |s-center|<=1; g is entire even to the left of LEFT.
        S=abs(point(center))+ar(RADIUS)
        sigma=ar(center[0]-RADIUS)
        terms=sum(((-sigma*l).exp() for l in self.logs),arb(0))
        bp=(-sigma*self.lb).exp();terms+=bp/2
        poch=arb(1);corr=arb(0)
        for j in range(1,2*M):
            poch*=S+j-1
            if j%2==1:
                k=(j+1)//2
                corr+=abs(self.coeff[k-1])*poch*self.powers[k-1]
        terms+=bp*corr
        return (S+1)*terms+((1-sigma)*self.lb).exp()

class Model:
    def __init__(self,ev,a,b):
        self.a=a;self.b=b;self.center=midpoint(a,b);self.h=distance(a,b)/2
        assert 0<self.h<=F(1,10)
        s=acb_series([point(self.center),1],prec=K)
        jet=ev.finite(s);self.coef=[jet[j] for j in range(K)]
        S=abs(point(self.center))+ar(self.h)
        q=ar(self.h/RADIUS)
        self.err=ev.em_error(S)+ev.outer_bound(self.center)*q**K/(1-q)
        assert self.err.is_finite() and self.err>=0
    def image(self,a,b):
        z=cbox((a[0]-self.center[0],a[1]-self.center[1]),
               (b[0]-self.center[0],b[1]-self.center[1]))
        out=self.coef[-1]
        for c in reversed(self.coef[:-1]):out=out*z+c
        return out+error_box(self.err)

def path_geometry(a,b,kind):
    if kind=='bottom':return a==(LEFT,F(0)) and b==(RIGHT,F(0))
    if kind=='crossbar':return a[0]==RIGHT and b[0]==LEFT and a[1]==b[1]
    if kind=='right':return a[0]==b[0]==RIGHT and 0<=a[1]<b[1]
    if kind=='left':return a[0]==b[0]==LEFT and 0<=a[1]<b[1]
    return False

def run(height,seconds,maxblocks):
    started=time.perf_counter();N=max(80,ceil(F(height)/3));ev=Evaluator(N)
    vertices={};blocks=[];paths=[];counts=[];evaluations=0;deepest=0
    targets=grid(height)
    def vertex(p,model):
        if p not in vertices:
            z=model.image(p,p);assert z.is_finite()
            vertices[p]=(dyadic(z.real),dyadic(z.imag))
        return vertices[p]
    def limit():
        if time.perf_counter()-started>seconds or len(blocks)>=maxblocks:
            raise RuntimeError('bounded cost limit reached')
    def path(a,b,kind):
        nonlocal evaluations,deepest
        assert path_geometry(a,b,kind)
        pathid=len(paths);row=dict(a=encode(a),b=encode(b),kind=kind,blocks=[],crossing=0)
        paths.append(row)
        n=ceil(distance(a,b)/F(1,5));prev=a
        for j in range(1,n+1):
            limit();end=(a[0]+(b[0]-a[0])*F(j,n),a[1]+(b[1]-a[1])*F(j,n))
            model=Model(ev,prev,end)
            block=dict(a=encode(prev),b=encode(end),path=pathid,panels=[],error_diagnostic=str(model.err))
            row['blocks'].append(len(blocks));blocks.append(block)
            def visit(x,y,depth):
                nonlocal evaluations,deepest
                limit();evaluations+=1;deepest=max(deepest,depth)
                if depth>24:raise RuntimeError('nonvanishing panel depth limit reached')
                vx=vertex(x,model);vy=vertex(y,model)
                image=model.image(x,y);w=witness(image,vx,vy)
                if w is not None:
                    block['panels'].append(dict(a=encode(x),b=encode(y),va=encode(vx),vb=encode(vy),witness=list(w)))
                    row['crossing']+=crossing(vx,vy);return
                mid=midpoint(x,y);visit(x,mid,depth+1);visit(mid,y,depth+1)
            visit(prev,end,0);prev=end
        assert prev==b
        return pathid
    status='INCOMPLETE';reason='not started';q=F(0)
    try:
        bottom=path((LEFT,F(0)),(RIGHT,F(0)),'bottom');pr=pl=0;old=F(0)
        for i,t in enumerate(targets):
            r=path((RIGHT,old),(RIGHT,t),'right');l=path((LEFT,old),(LEFT,t),'left')
            c=path((RIGHT,t),(LEFT,t),'crossbar')
            pr+=paths[r]['crossing'];pl+=paths[l]['crossing']
            w=paths[bottom]['crossing']+pr+paths[c]['crossing']-pl
            assert w>=0
            if i==0:assert w==0,'height14 base count is not zero'
            else:
                assert w>=counts[-1]['N'],'counts decreased'
                q+=w*(1/old-1/t)
            counts.append(dict(t=str(t),N=w,Q_upper=str(q),right_path=r,left_path=l,crossbar_path=c))
            if i%20==0 or t==height:
                print(json.dumps(dict(checkpoint=i,height=str(t),N=w,Q_upper=float(q),blocks=len(blocks),seconds=time.perf_counter()-started)),flush=True)
            old=t
        assert q<2
        status='PASS_EXTERNAL_HEAD_COUNTS' if height==1500 else 'PASS_EXTERNAL_PREFIX_ONLY'
        reason='all requested paths and checkpoints passed'
    except RuntimeError as e:reason=str(e)
    data=dict(status=status,reason=reason,height=str(height),N=N,M=M,K=K,radius=str(RADIUS),
        precision_bits=ctx.prec,grid=list(map(str,targets)),counts=counts,Q_upper=str(q),
        blocks=blocks,paths=paths,evaluations=evaluations,deepest=deepest,
        elapsed_seconds=time.perf_counter()-started,
        script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        caveat='External interval computation only. Incomplete/prefix output does not certify Q1500.')
    return data

def replay(data):
    assert data['status'] in ('PASS_EXTERNAL_HEAD_COUNTS','PASS_EXTERNAL_PREFIX_ONLY')
    height=F(data['height']);assert data['grid']==list(map(str,grid(height)))
    assert data['M']==M and data['K']==K and F(data['radius'])==RADIUS
    assert data['precision_bits']==ctx.prec
    ev=Evaluator(data['N']);paths=data['paths'];blocks=data['blocks'];global_vertices={}
    seen=[];actual_cross=[]
    for pi,p in enumerate(paths):
        a,b=decode(p['a']),decode(p['b']);assert path_geometry(a,b,p['kind'])
        prev=a;w=0
        for bi in p['blocks']:
            seen.append(bi);block=blocks[bi]
            ba,bb=decode(block['a']),decode(block['b'])
            assert block['path']==pi and ba==prev
            assert distance(a,ba)+distance(ba,bb)+distance(bb,b)==distance(a,b)
            model=Model(ev,ba,bb);pv=ba
            for row in block['panels']:
                x,y=decode(row['a']),decode(row['b']);vx,vy=decode(row['va']),decode(row['vb'])
                assert x==pv and distance(ba,x)+distance(x,y)+distance(y,bb)==distance(ba,bb)
                assert x!=y
                for z,v in ((x,vx),(y,vy)):
                    if z in global_vertices:assert global_vertices[z]==v
                    else:global_vertices[z]=v
                image=model.image(x,y);axis,sign=row['witness']
                assert axis in(0,1) and sign in(-1,1)
                assert sign*(image.real if axis==0 else image.imag)>0
                assert sign*vx[axis]>0 and sign*vy[axis]>0
                w+=crossing(vx,vy);pv=y
            assert pv==bb;prev=bb
        assert prev==b and w==p['crossing'];actual_cross.append(w)
    assert sorted(seen)==list(range(len(blocks)))
    assert len(paths)==1+3*len(data['grid']) and paths[0]['kind']=='bottom'
    pr=pl=0;old=F(0);q=F(0);prevN=0
    assert len(data['counts'])==len(data['grid'])
    for i,row in enumerate(data['counts']):
        t=F(row['t']);assert t==F(data['grid'][i])
        ids=[row['right_path'],row['left_path'],row['crossbar_path']]
        assert ids==[1+3*i,2+3*i,3+3*i]
        r,l,c=ids
        assert (decode(paths[r]['a']),decode(paths[r]['b']))==((RIGHT,old),(RIGHT,t))
        assert (decode(paths[l]['a']),decode(paths[l]['b']))==((LEFT,old),(LEFT,t))
        assert (decode(paths[c]['a']),decode(paths[c]['b']))==((RIGHT,t),(LEFT,t))
        pr+=actual_cross[r];pl+=actual_cross[l]
        w=actual_cross[0]+pr+actual_cross[c]-pl
        assert w==row['N'] and w>=prevN
        if i==0:assert w==0
        else:q+=w*(1/old-1/t)
        assert q==F(row['Q_upper']);old=t;prevN=w
    assert q==F(data['Q_upper']) and q<2
    if data['status']=='PASS_EXTERNAL_HEAD_COUNTS':assert height==1500
    print(json.dumps(dict(status='REPLAY_PASS_EXTERNAL_ONLY',height=str(height),checkpoints=len(data['counts']),Q_upper=str(q))))

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--height',type=int,default=50)
    ap.add_argument('--seconds',type=int,default=55);ap.add_argument('--maxblocks',type=int,default=3000)
    ap.add_argument('--replay',type=Path);args=ap.parse_args()
    if args.replay:replay(json.loads(args.replay.read_text()))
    else:
        out=run(args.height,args.seconds,args.maxblocks)
        dest=Path(__file__).with_name('psi_head_counts_20261111_h'+str(args.height)+'.json')
        dest.write_text(json.dumps(out,separators=(',',':'))+'\n')
        print(json.dumps({k:v for k,v in out.items() if k not in('blocks','paths','counts','grid')},indent=2))
