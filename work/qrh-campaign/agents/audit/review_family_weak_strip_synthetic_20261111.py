"""Independent rational replay via interpolation, not producer Bernstein conversion."""
from fractions import Fraction as Q
from math import comb
from pathlib import Path
from copy import deepcopy
import hashlib, json

SOURCE=Path(__file__).resolve().parents[1]/'zero-sum/family_weak_strip_synthetic_20261111.json'
def z(v): return tuple(map(Q,v))
def add(a,b): return (a[0]+b[0],a[1]+b[1])
def mul(a,b): return (a[0]*b[0]-a[1]*b[1],a[0]*b[1]+a[1]*b[0])
def at(p,x):
    y=(Q(0),Q(0))
    for c in p[::-1]: y=add(mul(y,x),c)
    return y
def invert(a):
    n=len(a); a=[list(row)+[Q(i==j) for j in range(n)] for i,row in enumerate(a)]
    for i in range(n):
        k=next(k for k in range(i,n) if a[k][i]); a[i],a[k]=a[k],a[i]
        c=a[i][i]; a[i]=[v/c for v in a[i]]
        for j in range(n):
            if j!=i:
                c=a[j][i]; a[j]=[v-c*w for v,w in zip(a[j],a[i])]
    return [row[n:] for row in a]
inverses={}
def controls(p,a,b):
    n=len(p)-1
    if n not in inverses:
        ts=[Q(j,n) for j in range(n+1)]
        matrix=[[Q(comb(n,k))*t**k*(1-t)**(n-k) for k in range(n+1)] for t in ts]
        inverses[n]=invert(matrix)
        assert all(sum(matrix[i][j]*inverses[n][j][k] for j in range(n+1))==Q(i==k)
                   for i in range(n+1) for k in range(n+1))
    values=[at(p,tuple(a[k]+Q(j,n)*(b[k]-a[k]) for k in range(2))) for j in range(n+1)]
    return [tuple(sum(row[j]*values[j][k] for j in range(n+1)) for k in range(2)) for row in inverses[n]]
def cross(a,b):
    if a[1]<=0<b[1]: sign=1
    elif b[1]<=0<a[1]: sign=-1
    else: return 0
    t=-a[1]/(b[1]-a[1]); x=a[0]+t*(b[0]-a[0])
    assert 0<=t<=1
    return sign if x>0 else 0
def replay(packet):
    p=list(map(z,packet['polynomial'])); x0,x1,y0,y1=map(Q,packet['bounds'])
    assert x0<x1 and y0<y1
    corners=[(x0,y0),(x1,y0),(x1,y1),(x0,y1),(x0,y0)]
    pos=0; total=0; pts=packet['panels']; last=corners[0]
    for side in range(4):
        count=0
        while pos<len(pts) and pts[pos]['side']==side:
            item=pts[pos]; a,b=z(item['a']),z(item['b']); assert a==last
            if side==0: assert a[1]==b[1]==y0 and x0<=a[0]<b[0]<=x1
            elif side==1: assert a[0]==b[0]==x1 and y0<=a[1]<b[1]<=y1
            elif side==2: assert a[1]==b[1]==y1 and x0<=b[0]<a[0]<=x1
            else: assert a[0]==b[0]==x0 and y0<=b[1]<a[1]<=y1
            va,vb=at(p,a),at(p,b); assert va==z(item['image_a']) and vb==z(item['image_b'])
            axis=item['axis']; assert axis in range(4)
            cs=controls(p,a,b)
            coordinate=lambda v:(v[0],-v[0],v[1],-v[1])[axis]
            margin=min(map(coordinate,cs)); assert margin==Q(item['margin']) and margin>0
            assert coordinate(va)>0 and coordinate(vb)>0
            total+=cross(va,vb); pos+=1; count+=1; last=b
        assert count and last==corners[side+1]
    assert pos==len(pts) and total==packet['winding']
    return {'panels':len(pts),'winding':total}
def product_roots(roots):
    p=[(Q(1),Q(0))]
    for root in roots:
        out=[(Q(0),Q(0)) for _ in range(len(p)+1)]
        for i,c in enumerate(p):
            out[i]=add(out[i],mul(c,(-root[0],-root[1]))); out[i+1]=add(out[i+1],c)
        p=out
    return p

raw=SOURCE.read_bytes(); d=json.loads(raw); results={}
for name, packets in d['packets'].items():
    for kind,packet in packets.items():
        if isinstance(packet,dict) and 'panels' in packet: results[name+'/'+kind]=replay(packet)
for name, betas, multiplicity in [('allowed_off_line',[Q(27,50),Q(23,50)],1),('double_critical',[Q(1,2)],2),('triple_critical',[Q(1,2)],3),('exact_beta_boundary',[Q(111,200),Q(89,200)],1)]:
    roots=[(b,Q(g)) for b in betas for g in [-1,1] for _ in range(multiplicity)]
    assert product_roots(roots)==list(map(z,d['packets'][name]['full']['polynomial']))
    assert all(b<=Q(111,200) and abs(g)<=1 for b,g in roots)
boundary=d['packets']['exact_beta_boundary']
assert product_roots([(Q(111,200),Q(g)) for g in [-1,1]])==list(map(z,boundary['boundary_factor']))
assert product_roots([(Q(89,200),Q(g)) for g in [-1,1]])==list(map(z,boundary['remaining_factor']))
for failure in [boundary['strict_right_failure'],d['exact_height_boundary_failure']]:
    x0,x1,y0,y1=map(Q,failure['bounds'])
    for r in map(z,failure['witnesses']):
        assert x0<=r[0]<=x1 and y0<=r[1]<=y1
        assert r[0] in [x0,x1] or r[1] in [y0,y1]
        p=boundary['full']['polynomial'] if failure is boundary['strict_right_failure'] else d['packets']['allowed_off_line']['full']['polynomial']
        assert at(list(map(z,p)),r)==(0,0)
negative=[]
base=d['packets']['allowed_off_line']['forbidden_right']
for label in ['zero_margin','missing_panel','wrong_winding','wrong_image','reversed_panels','wrong_axis']:
    q=deepcopy(base)
    if label=='zero_margin': q['panels'][0]['margin']='0'
    if label=='missing_panel': del q['panels'][0]
    if label=='wrong_winding': q['winding']=1
    if label=='wrong_image': q['panels'][0]['image_a']=['0','0']
    if label=='reversed_panels': q['panels'].reverse()
    if label=='wrong_axis': q['panels'][0]['axis']=5
    try: replay(q)
    except (AssertionError,IndexError,StopIteration): negative.append(label)
    else: raise AssertionError('accepted corruption: '+label)
assert SOURCE.read_bytes()==raw
result={'status':'PASS_INDEPENDENT_RATIONAL_REPLAY','source_sha256':hashlib.sha256(raw).hexdigest().upper(),'records':results,'total_panels':sum(r['panels'] for r in results.values()),'negative_controls_rejected':negative,'whole_panel_method':'degree-n exact rational interpolation to Bernstein coefficients, then positive convex weights','scope':'synthetic polynomial method validation only; no L-functions or Lean proof'}
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,indent=2))
