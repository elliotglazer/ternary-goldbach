"""Independent bounded review of the frozen elementary argument replay.

No frozen output is written. The original replay is redirected to this owned
directory; a separate calculation uses shorter series and a different arctan
addition reduction. The EM endpoint remains an accepted input, not reevaluated.
"""
from pathlib import Path
from fractions import Fraction as Q
import contextlib
import hashlib
import io
import json
import runpy

H=Path(__file__).resolve().parent
ROOT=H.parents[3]
P=ROOT/'work/qrh-blueprint/elementary-argument'
pins={
 'RIGHT_HALF_PLANE_ARGUMENT_2026-11-11.md':'29e860455878d580b3f7e359318ede37feaac0afabecad22e6163ce12ad65c86',
 'check_top_argument.py':'f411792fcc2d1f960f1f5bd43f530f6ac44974ccff647f2a6fb11e610a65dd31',
 'check_top_argument.json':'331ce3d0c1325f226f168b572d77d9590b29d4ba9bc539cf44c15f3d5a2f37b3',
}
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
for name,want in pins.items():assert sha(P/name)==want
module=runpy.run_path(str(P/'check_top_argument.py'),run_name='review_import')
# SOURCE was resolved on import. Only the output __file__ location changes.
module['main'].__globals__['__file__']=str(H/'review_top_argument_original_replay_20261111.py')
with contextlib.redirect_stdout(io.StringIO()):module['main']()
replayed=H/'review_top_argument_original_replay_20261111.json'
assert replayed.read_bytes()==(P/'check_top_argument.json').read_bytes()

def plus(x,y):return x[0]+y[0],x[1]+y[1]
def minus(x):return -x[1],-x[0]
def times(x,y):
    v=[a*b for a in x for b in y]
    return min(v),max(v)
def scaled(x,k):return times(x,(Q(k),Q(k)))
def quotient(x,y):
    assert 0<y[0]<=y[1] and x[0]<=x[1]
    return times(x,(1/y[1],1/y[0]))
def small(x,n):
    assert 0<=x<=Q(1,2) and n>0 and n%2==0
    # A recurrence for successive terms, rather than separate rational powers.
    term=x;s=Q(0)
    for j in range(n):
        s+=term
        term=-term*x*x*Q(2*j+1,2*j+3)
    assert term>=0
    return s,s+term

pi=plus(scaled(small(Q(1,5),32),16),scaled(small(Q(1,239),12),-4))
assert 3<pi[0]<pi[1]<4
base_half=small(Q(1,2),40)
def atan(x):
    if x<0:return minus(atan(-x))
    if x>1:return plus(scaled(pi,Q(1,2)),minus(atan(1/x)))
    if x<=Q(1,2):return small(x,40)
    # Different from the source pi/4 shift: add arctan(1/2).
    u=(x-Q(1,2))/(1+x/2)
    assert 0<u<=Q(1,3) and Q(1,2)*u<1
    assert (Q(1,2)+u)/(1-u/2)==x
    return plus(base_half,small(u,40))
def unit_log(y):
    assert 1<=y<=2
    t=(y-1)/(y+1);n=40;term=t;s=Q(0)
    for j in range(n):
        s+=2*term/Q(2*j+1)
        term*=t*t
    return s,s+2*term/(Q(2*n+1)*(1-t*t))
log2=unit_log(Q(2))
def logq(x):
    assert x>0
    k=0;y=x
    while y>2:k+=1;y/=2
    while y<1:k-=1;y*=2
    assert y*Q(2)**k==x
    return plus(scaled(log2,k),unit_log(y))
def roundout(x,p):
    d=10**p
    return Q((x[0]*d).__floor__(),d),Q((x[1]*d).__ceil__(),d)
source=ROOT/'work/qrh-campaign/agents/zero-sum/em_top_horizontal_20261111.json'
assert sha(source)=='9f8d349077cea0598c50c61377c80a0098ffbb0ef723a0a68d85a18fc73aec26'
data=json.loads(source.read_bytes())
assert data['T']==1000000 and data['status']=='PASS_EXPLICIT_EM_TOP_PATH'
z=data['endpoints']['1/2'];re=tuple(map(Q,z['re']));im=tuple(map(Q,z['im']))
assert 0<re[0]<=re[1] and im[0]<=im[1]
r=quotient(im,re)
arg=(atan(r[0])[0],atan(r[1])[1])
S=quotient(arg,pi)
x=roundout(quotient((Q(1000000),Q(1000000)),scaled(pi,2)),25)
lx,ux=logq(x[0]),logq(x[1]);assert lx[0]>1
F=(x[0]*(lx[0]-1)+Q(7,8),x[1]*(ux[1]-1)+Q(7,8))
count=plus(plus(F,S),(Q(-1,8),Q(1,8)))
lo,hi=count[0].__ceil__(),count[1].__floor__()
assert lo==hi==json.loads(replayed.read_bytes())['unique_integer']
tests=[Q(0),Q(1,2),Q(3,4),Q(1),Q(2),Q(1000),Q(1,2)-Q(1,10**12),
       Q(1,2)+Q(1,10**12),Q(1)-Q(1,10**12),Q(1)+Q(1,10**12)]
for t in tests:
    alt=atan(t);original=module['atan_rational'](t)
    assert alt[0]<=alt[1] and atan(-t)==minus(alt)
    assert max(alt[0],original[0])<=min(alt[1],original[1])
    assert alt[1]-alt[0]<Q(1,10**23)
for t in [Q(1,16),Q(1,2),Q(1),Q(2),Q(4),Q(1000000)]:
    aa=logq(t);bb=module['log_rational'](t)
    assert max(aa[0],bb[0])<=min(aa[1],bb[1])
for name,want in pins.items():assert sha(P/name)==want
out={'status':'PASS independent source-replay and alternate rational calculation',
     'original_replay_byte_identical':True,'original_output_sha256':sha(replayed),
     'alternate_pi_terms':[32,12],'alternate_atan_terms':40,'alternate_log_terms':40,
     'alternate_x_rounding_decimal_places':25,
     'alternate_S':[str(t) for t in roundout(S,20)],
     'alternate_F':[str(t) for t in roundout(F,20)],
     'alternate_count_interval':[str(t) for t in roundout(count,20)],
     'unique_integer':lo,'arctan_nonnegative_tests':len(tests),
     'log_test_count':6,'frozen_inputs_unchanged':True,
     'scope':'Conditional on accepted EM endpoint and analytic branch/count formula; no Lean or new EM evaluation'}
(H/'review_right_half_plane_comparison_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
