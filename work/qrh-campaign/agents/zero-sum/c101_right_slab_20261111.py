"""One fixed actual character/slab; pinned explicit EM samples, no special-function oracle."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json,time,sys
from flint import arb,acb,ctx
import flint

ROOT=Path(__file__).parent
BASE=ROOT/'c101_cauchy_alpha_block_20261111.py'
BASE_SHA='FD75DAC17AF6735E9A5AE72E5A47096592609D2371CD5A65643B544F5B8F4E11'
assert hashlib.sha256(BASE.read_bytes()).hexdigest().upper()==BASE_SHA
# Reuse only the frozen evaluator and its fixed tables, never its original run.
prefix=BASE.read_text().split('start=time.perf_counter();sampling_start=start;')[0]
assert prefix.endswith('\n') and 'def transform(s,inputs):' in prefix
env={'__file__':str(BASE),'__name__':'pinned_evaluator_definitions'}
exec(compile(prefix,str(BASE),'exec'),env)
ar,eb=env['ar'],env['eb']
LEFT,RIGHT,LOW,HIGH=F(111,200),F(2),F(7999,8),F(8001,8)
LABEL=1 # fixed before all actual evaluations; chi(2^j)=exp(2*pi*i*j/100)
R,RHO,RAD=F(1,2),F(1,4),F(1,5)
NS=64;OUTER=2000000;PATH=Path(__file__).with_suffix('.json')
edges=[LEFT+(RIGHT-LEFT)*j/6 for j in range(7)]
centers=[(edges[j]+edges[j+1])/2 for j in range(6)]
assert centers[0]-R>F(11,200)
assert F(102)*1003/F(11,200)<OUTER
assert ((RIGHT-LEFT)/12)**2+F(1,8)**2<RAD**2
assert centers[0]-RHO>=env['SIG']
alias=F(OUTER)/(1-RAD/R)*((RAD/R)**NS+(RHO/R)**NS/(1-(RHO/R)**NS))
assert alias<F(2,10**13)
roots=env['roots_sample'];weights=[env['roots_char'][(LABEL*j)%100] for j in range(100)]
started=time.perf_counter();models=[];stats=[]

def limit():
    if time.perf_counter()-started>540:raise RuntimeError('INCOMPLETE: 540 second computation limit')
def cbox(a,b):
    return acb(arb(ar((a[0]+b[0])/2),ar(abs(a[0]-b[0])/2)),
               arb(ar((a[1]+b[1])/2),ar(abs(a[1]-b[1])/2)))
def midpoint(v):
    m,e=v.mid().man_exp();m,e=int(m),int(e)
    return F(m*2**e) if e>=0 else F(m,2**(-e))
def one_sample(s):
    assert abs(s)<1002
    grid,em=env['materialize'](s)
    vals=[env['alpha_eval'](s,F(a,101),grid) for a in env['residues']]
    result=(-s*arb(101).log()).exp()*sum((v*w for v,w in zip(vals,weights)),acb(0))
    assert result.is_finite()
    return result,em
def make_models():
    for number,c in enumerate(centers):
        ts=time.perf_counter();samples=[];maxem=arb(0)
        for w in roots:
            limit();v,e=one_sample(acb(ar(c),1000)+ar(RHO)*w);samples.append(v)
            if e.upper()>maxem.upper():maxem=e
        coeff=[sum((samples[j]*roots[(-j*n)%NS] for j in range(NS)),acb(0))/NS for n in range(NS)]
        models.append(coeff)
        stats.append({'center':[str(c),'1000'],'seconds':time.perf_counter()-ts,
                      'max_sample_radius_L1_diagnostic':max(float(v.real.rad()+v.imag.rad()) for v in samples),
                      'max_unmultiplied_EM_remainder':str(maxem)})
        print('model',number+1,'of 6 complete',flush=True)
def evaluate(index,a,b):
    limit();c=centers[index]
    for x,y in [a,b]:assert (x-c)**2+(y-1000)**2<=RAD**2
    z=(cbox(a,b)-acb(ar(c),1000))/ar(RHO);v=acb(0)
    for coefficient in reversed(models[index]):v=v*z+coefficient
    return v+eb(ar(alias))
def witness(v,va,vb):
    if not v.is_finite():return None
    for axis,iv in enumerate((v.real,v.imag)):
        for sign in [1,-1]:
            if sign*iv>0 and sign*va[axis]>0 and sign*vb[axis]>0:return [axis,sign]
    return None
def winding(vertices):
    assert vertices[0]==vertices[-1];n=0
    for a,b in zip(vertices,vertices[1:]):
        det=a[0]*b[1]-a[1]*b[0]
        if a[1]<=0<b[1] and det>0:n+=1
        elif b[1]<=0<a[1] and det<0:n-=1
    return n
def verify(data):
    assert data['label']==LABEL and data['rectangle']==list(map(str,[LEFT,RIGHT,LOW,HIGH]))
    assert data['evaluator_sha256']==BASE_SHA
    panels=data['panels'];prev=(LEFT,LOW);length=F(0);verts=[]
    for row in panels:
        a,b=tuple(map(F,row['a'])),tuple(map(F,row['b']))
        assert a==prev
        assert ((a[1]==b[1]==LOW and LEFT<=a[0]<b[0]<=RIGHT) or
                (a[0]==b[0]==RIGHT and LOW<=a[1]<b[1]<=HIGH) or
                (a[1]==b[1]==HIGH and LEFT<=b[0]<a[0]<=RIGHT) or
                (a[0]==b[0]==LEFT and LOW<=b[1]<a[1]<=HIGH))
        va,vb=tuple(map(F,row['va'])),tuple(map(F,row['vb']))
        if verts:assert verts[-1]==va
        else:verts.append(va)
        v=evaluate(row['model'],a,b);axis,sign=row['witness']
        assert axis in [0,1] and sign in [-1,1]
        assert sign*(v.real if axis==0 else v.imag)>0
        assert sign*va[axis]>0 and sign*vb[axis]>0
        verts.append(vb);prev=b;length+=abs(a[0]-b[0])+abs(a[1]-b[1])
    assert prev==(LEFT,LOW) and length==2*(RIGHT-LEFT+HIGH-LOW)
    count=winding(verts);assert count==data['exact_winding']==0
    return count
def produce():
    panels=[];cache={};calls=0
    def vertex(index,a):
        if a not in cache:
            v=evaluate(index,a,a);cache[a]=(midpoint(v.real),midpoint(v.imag))
        return cache[a]
    def visit(index,a,b,depth):
        nonlocal calls
        calls+=1;limit()
        if calls>10000 or depth>20:raise RuntimeError('INCOMPLETE: panel bound')
        va,vb=vertex(index,a),vertex(index,b);v=evaluate(index,a,b);w=witness(v,va,vb)
        if w is not None:
            panels.append({'a':list(map(str,a)),'b':list(map(str,b)),'va':list(map(str,va)),
                           'vb':list(map(str,vb)),'model':index,'witness':w,'depth':depth,
                           'image_diagnostic':str(v)})
            return
        m=((a[0]+b[0])/2,(a[1]+b[1])/2);visit(index,a,m,depth+1);visit(index,m,b,depth+1)
    for j in range(6):visit(j,(edges[j],LOW),(edges[j+1],LOW),0)
    visit(5,(RIGHT,LOW),(RIGHT,HIGH),0)
    for j in reversed(range(6)):visit(j,(edges[j+1],HIGH),(edges[j],HIGH),0)
    visit(0,(LEFT,HIGH),(LEFT,LOW),0)
    verts=[tuple(map(F,panels[0]['va']))]+[tuple(map(F,p['vb'])) for p in panels]
    count=winding(verts)
    data={'status':'PASS_EXTERNAL_SINGLE_CHARACTER_SLAB' if count==0 else 'CERTIFIED_NONZERO_COUNT',
          'label':LABEL,'character':'chi_1(2^j mod101)=exp(2*pi*i*j/100); chi_1(0)=0',
          'rectangle':list(map(str,[LEFT,RIGHT,LOW,HIGH])),'orientation':'counterclockwise',
          'evaluator_sha256':BASE_SHA,'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          'bits':ctx.prec,'flint_version':flint.__FLINT_VERSION__,'R':str(R),'rho':str(RHO),'r':str(RAD),
          'samples_per_model':NS,'models':stats,'outer_bound':OUTER,'alias_exact':str(alias),
          'panels':panels,'panel_calls':calls,'accepted_panels':len(panels),'exact_winding':count,
          'elapsed_seconds':time.perf_counter()-started,
          'scope':'Only chi label1 and the stated closed slab; not [0,Hcert], not family certification or Lean proof.'}
    if count==0:verify(data)
    return data
try:
    make_models()
    if '--replay' in sys.argv:
        data=json.loads(PATH.read_text());verify(data)
        print(json.dumps({'status':'REPLAY_PASS','panels':len(data['panels']),'exact_winding':0,
                          'elapsed_seconds':time.perf_counter()-started},indent=2))
    else:
        data=produce();PATH.write_text(json.dumps(data,indent=2)+'\n')
        print(json.dumps({k:v for k,v in data.items() if k not in ['panels','models']},indent=2))
except Exception as err:
    if '--replay' not in sys.argv:
        PATH.write_text(json.dumps({'status':'INCOMPLETE','error':repr(err),'models_completed':len(models),
                                     'elapsed_seconds':time.perf_counter()-started},indent=2)+'\n')
    raise
