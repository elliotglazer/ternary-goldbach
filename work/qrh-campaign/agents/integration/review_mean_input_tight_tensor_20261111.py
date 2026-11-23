"""Independent fixed checks of tight mean-input composition; no values/folds."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
ROOT=Path(__file__).resolve().parent.parent
HERE=Path(__file__).resolve().parent
checks=[]
def ck(name,test):
 if not test:raise AssertionError(name)
 checks.append(name)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
pins={
'independent-feasibility/MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md':'4A7EB4A925A84F70F882A2AC4A1D44B5EB6132B5C6066C12FB4DC4159EF1CDED',
'independent-feasibility/mean_input_tight_tensor_20261111.py':'245FAA10E7146E080988CB45AF11908663BA66DA4B7093B2446D86D9A45537DF',
'independent-feasibility/mean_input_tight_tensor_20261111.json':'CC669611310F0842915CBED594298F309DB0D8779B7F7509AE87E601B34BCF2D'}
for p,h in pins.items():ck('artifact '+p,sha(ROOT/p)==h)
r=json.loads((ROOT/'independent-feasibility/mean_input_tight_tensor_20261111.json').read_text())
for p,h in r['pins'].items():ck('source '+p,sha(ROOT/p)==h)
# Five-variable formal polynomials over Q. No numerical source input.
Z=(0,)*5
def con(a):return {Z:F(a)} if a else {}
def var(i):
 e=[0]*5;e[i]=1;return {tuple(e):F(1)}
def add(*args):
 d={}
 for a in args:
  for e,c in a.items():d[e]=d.get(e,F(0))+c
 return {e:c for e,c in d.items() if c}
def mul(a,b):
 d={}
 for e,c in a.items():
  for f,v in b.items():
   k=tuple(x+y for x,y in zip(e,f));d[k]=d.get(k,F(0))+c*v
 return {e:c for e,c in d.items() if c}
def sc(a,c):return mul(a,con(c))
N,P,R=map(var,range(3));one=con(1)
A=add(one,sc(R,3))
Q=add(sc(mul(N,A),3),N,con(2))
E=add(mul(P,Q),mul(R,add(mul(N,add(sc(N,2),con(-1))),sc(P,2))))
sharp=add(sc(mul(P,A),F(9,2)),sc(P,F(3,2)),sc(mul(R,N),3),sc(R,12),con(14))
old=add(sc(mul(P,A),6),sc(mul(R,add(sc(N,2),one)),2),con(8))
lhs=add(sc(mul(N,sharp),2),sc(E,-3),sc(add(N,one),-2))
rhs=add(mul(R,add(sc(N,27),sc(P,-6))),sc(N,26),sc(P,-6),con(-2))
ck('formal sharp versus prechirp gap',lhs==rhs)
ck('formal old minus sharp',add(old,sc(sharp,-1))==add(mul(R,add(sc(P,F(9,2)),N,con(-10))),con(-6)))
a,b,x,y=map(var,range(4))
def f(a,b):return add(a,mul(b,add(sc(a,2),one)))
fgap=add(f(add(a,x),add(b,y)),sc(f(a,b),-1))
ck('formal CT monotonic safety',fgap==add(mul(x,add(one,sc(b,2))),mul(y,add(sc(a,2),one)),sc(mul(x,y),2)))
t,h=var(0),var(1)
cleared=add(one,sc(t,-1),sc(mul(add(one,h),add(one,sc(t,-1),sc(h,-1))),-1))
ck('formal tensor denominator induction',cleared==add(mul(h,t),mul(h,h)))
S,T,rho=map(var,range(3))
W=add(mul(rho,add(T,sc(S,-1))),sc(mul(S,T),186))
ck('formal combined common numerator',W==add(mul(rho,T),sc(mul(rho,S),-1),sc(mul(S,T),186)))
ck('formal W square retains mixed contribution',mul(W,W)==add(mul(mul(rho,rho),mul(add(T,sc(S,-1)),add(T,sc(S,-1)))),sc(mul(mul(rho,add(T,sc(S,-1))),mul(S,T)),372),sc(mul(mul(S,S),mul(T,T)),186**2)))
# Fixed algebraic fixtures, not an inventory or candidate precision search.
fixtures=[]
for n in (2,5,31):
 ppad=1<<(2*n-2).bit_length();k=ppad.bit_length()-1;rr=2*k+4;aa=1+3*rr
 eb=ppad*(3*n*aa+n+2)+rr*(n*(2*n-1)+2*ppad)
 xx=F(eb,n);co=6*ppad*aa+2*rr*(2*n+1)+8
 cs=F(9*ppad*aa+3*ppad,2)+3*rr*n+12*rr+14
 ct=(eb+n-1)//n+2;db=max(1,2*k,ppad*aa,3*n*ppad*aa+1);dt=max(db,2*co)
 ck(f'geometry and X floor {n}',2*n<=ppad<4*n and xx>=3*ppad*aa>=300)
 ck(f'noncircular X bound {n}',xx<cs<co)
 ck(f'guarded final chirp {n}',xx+xx/dt+F(n+1,n)<=ct<=cs)
 ck(f'exact ceiling {n}',ct-3<xx<=ct-2)
 ck(f'new safety includes oldpeak {n}',dt>=db and F(co,dt)<=F(1,2))
 fixtures.append([n,eb,str(xx),ct,dt])
ck('guard separation fixed example',601<=1024<2*688)
sg=202305920;cg=4196258524692480
ck('positive tensor denominator floor',sg<2**28<2**50)
ck('retained local guard floor',29961461170177<2**45<2**50)
ck('retained peak guard floor',849412408<2**30<2**50)
noise=F(1032,2**63);regrid=F(1,2**50)
ck('nonnegative radius reserve',noise+regrid<1)
ck('augmented mean',175+F(1001,96)<186)
ck('raw and augmented sup reserve',173+516+noise<690 and 173+516+noise+regrid+1<692)
ck('fallback with exact denominator',633*F(186*sg,2**108-sg)<=F(cg,2**108))
ck('target identity',cg==1266*sg*16384)
# S0/rho100 and common denominator at fixed symbolic scalar witnesses.
for ss,tt,rr in ((0,2**50,1),(0,2**108,0),(23,2**100,0)):
 w=rr*(tt-ss)+186*ss*tt
 ee=F(rr,tt)+F(186*ss,tt-ss)
 ck(f'fixed clearing {ss},{tt.bit_length()},{rr}',ee==F(w,tt*(tt-ss)))
ck('rho transition strict direction',F(1,2**99)+F(186*sg,2**99-sg)>F(186*sg,2**100-sg))
rfix=F(927193523,10**9*2**46)+135*(F(1,2**82)+F(4,2**63))+F(10,2**54)+F(93,2**55)+F(1,2**51)
ratio=(rfix+135*F(cg,2**108))*2**45
ck('complete retained radius',ratio==F(2804840254168152529,4294967296000000000)<F(691,1024))
out={'scope':'Fixed symbolic identities/rational witnesses/hash checks; no inventory, precision selection, values or author imports.',
'checks':len(checks),'assertions':checks,'artifact_pins':pins,'source_pins':r['pins'],'fixed_leaf_fixtures':fixtures,
'complete_ratio':[ratio.numerator,ratio.denominator],
'limitations':['Rounded normalized cache only','Old local and peak guards retained','Full P20 and actual nonnegative input radius sums','Mean186 is not width692','No assignment, pricing or producer adoption']}
p=HERE/'review_mean_input_tight_tensor_20261111.json'
with p.open('x',encoding='utf-8',newline='\n') as g:json.dump(out,g,indent=2);g.write('\n')
print(json.dumps({'checks':len(checks),'bytes':p.stat().st_size,'receipt_sha256':sha(p)}))
