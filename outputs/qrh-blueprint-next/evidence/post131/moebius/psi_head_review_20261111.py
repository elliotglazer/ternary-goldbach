"""Independent exact geometry/count/moment review; no L-function evaluation."""
from pathlib import Path
from fractions import Fraction as F
import json,hashlib
HERE=Path(__file__).resolve().parent;AUTHOR=HERE.parent/'mellin'
filename=AUTHOR/'psi_head_counts_20261111_h1500.json'
assert hashlib.sha256(filename.read_bytes()).hexdigest()=='82ad7acdffbcac24d190a98acb78bf66471249d09bfe2c43051add2aaec0d030'
d=json.loads(filename.read_text());paths=d['paths'];blocks=d['blocks']
L=F(-1,10);R=F(11,10)
def pt(p):return tuple(map(F,p))
def segment(a,b,x,y):
    assert a!=b and x!=y
    k=0 if a[1]==b[1] else 1
    assert a[1-k]==b[1-k]==x[1-k]==y[1-k]
    sign=1 if b[k]>a[k] else -1
    assert sign*a[k]<=sign*x[k]<sign*y[k]<=sign*b[k]
def cross(a,b,rotated=False):
    k=0 if rotated else 1
    det=a[0]*b[1]-a[1]*b[0]
    if a[k]<=0<b[k]:assert det;return int(det>0)
    if b[k]<=0<a[k]:assert det;return -int(det<0)
    return 0
seen=[];vertices={};crosses=[];rotcrosses=[];panel_count=0
for pidx,p in enumerate(paths):
    a,b=pt(p['a']),pt(p['b']);last=a;w=v=0
    for bi in p['blocks']:
        seen.append(bi);block=blocks[bi];ba,bb=pt(block['a']),pt(block['b'])
        assert block['path']==pidx and ba==last;segment(a,b,ba,bb)
        assert abs(bb[0]-ba[0])+abs(bb[1]-ba[1])<=F(1,5)
        previous=ba
        for row in block['panels']:
            x,y=pt(row['a']),pt(row['b']);va,vb=pt(row['va']),pt(row['vb'])
            assert x==previous;segment(ba,bb,x,y)
            axis,sign=row['witness'];assert axis in [0,1] and sign in [-1,1]
            assert sign*va[axis]>0 and sign*vb[axis]>0
            for z,value in [(x,va),(y,vb)]:
                if z in vertices:assert vertices[z]==value
                vertices[z]=value
            w+=cross(va,vb);v+=cross(va,vb,True);previous=y;panel_count+=1
        assert previous==bb;last=bb
    assert last==b and w==p['crossing'];crosses.append(w);rotcrosses.append(v)
assert sorted(seen)==list(range(len(blocks)))
grid=[14*1024]
while grid[-1]<1500*1024:grid.append(min(1500*1024,grid[-1]+grid[-1]//100))
grid=[F(x,1024) for x in grid]
assert list(map(str,grid))==d['grid'] and len(grid)==472
assert len(paths)==1417 and len(blocks)==18300 and panel_count==18351
assert pt(paths[0]['a'])==(L,F(0)) and pt(paths[0]['b'])==(R,F(0))
right=left=rotright=rotleft=0;old=F(0);oldN=0;q=F(0)
for i,(t,row) in enumerate(zip(grid,d['counts'])):
    r,l,c=1+3*i,2+3*i,3+3*i
    assert [row['right_path'],row['left_path'],row['crossbar_path']]==[r,l,c]
    assert (pt(paths[r]['a']),pt(paths[r]['b']))==((R,old),(R,t))
    assert (pt(paths[l]['a']),pt(paths[l]['b']))==((L,old),(L,t))
    assert (pt(paths[c]['a']),pt(paths[c]['b']))==((R,t),(L,t))
    right+=crosses[r];left+=crosses[l];rotright+=rotcrosses[r];rotleft+=rotcrosses[l]
    n=crosses[0]+right+crosses[c]-left
    nr=rotcrosses[0]+rotright+rotcrosses[c]-rotleft
    assert n==nr==row['N'] and n>=oldN and t==F(row['t'])
    if i==0:assert n==0
    else:q+=n*(1/old-1/t)
    assert q==F(row['Q_upper']);old=t;oldN=n
assert old==1500 and oldN==1069 and q==F(d['Q_upper'])
assert q<F(833975893977619,500000000000000)<F('1.668')<2
# Independent scalar enclosure functions, smaller degrees than author's 160.
def exp_bounds(x):
    x=F(x);term=total=F(1)
    for j in range(1,81):term=term*x/j;total+=term
    return total,total+term*x/81/(1-x/82)
def atan_bounds(x):
    x=F(x);s=sum(((-1)**j*x**(2*j+1)/(2*j+1) for j in range(32)),F(0))
    return s,s+x**65/65
a,b=atan_bounds(F(1,5));c,e=atan_bounds(F(1,239))
pl=F('3.1415926');pu=F('3.1415927')
assert pl<16*a-4*e and 16*b-4*c<pu
al,au=F('7.313220'),F('7.313221');tl,tu=F('13.815510'),F('13.815511')
cl,cu=F('1.837877'),F('1.837878')
for x,lo,hi in [(1500,al,au),(10**6,tl,tu)]:
    assert exp_bounds(lo)[1]<x<exp_bounds(hi)[0]
assert exp_bounds(cl)[1]<2*pl and 2*pu<exp_bounds(cu)[0]
tail=((tu-cl)**2-(al-cu)**2)/(4*pl)+(au-cl-1)/(2*pl)+F(7,8*1500)+(5*(au+1)+20)/1500
weighted=(F('1.668')+tail)*(1+exp_bounds(F(35,400))[1])
assert weighted<F('23.953')<24
def up(x,den):return F(-(-x.numerator*den//x.denominator),den)
out={'status':'Independent complete rational topology/count audit and conditional wider-strip scalar check pass',
 'checkpoints':len(grid),'blocks':len(blocks),'panels':panel_count,'N1500':oldN,
 'Q_upper_directed_1e15':str(up(q,10**15)),
 'all_rotated_checkpoint_windings_agree':True,'weighted_conditional_upper_1e12':str(up(weighted,10**12)),
 'weighted_conditions':'reviewed analytic count N<=F+5logt+20 for t>=1500; unproved finite strip |beta-.5|<.0025 through1e6; multiplicity reflection/conjugation',
 'input_sha256':hashlib.sha256(filename.read_bytes()).hexdigest(),
 'analytic_panel_evaluation_performed_by_this_script':False}
HERE.joinpath('psi_head_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
