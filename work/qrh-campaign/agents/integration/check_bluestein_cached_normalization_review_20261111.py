"""Independent finite rational review; no author imports, inventory or values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
HERE=Path(__file__).resolve().parent;AG=HERE.parent
PINS={
 'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md':'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
 'independent-feasibility/bluestein_cached_normalization_20261111.py':'A0A26A3B03297871BE12B2DC4FC5F37006B071FED113CB325ACBDC6EFC0001F3',
 'independent-feasibility/bluestein_cached_normalization_20261111_v2.json':'E8403465E72AB99A94F7F210801CE6FE17CE6679E9AEF29EEFBC3492B642B793',
 'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 'independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md':'5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A',
 'zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md':'087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D',
 'integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md':'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C',
}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for rel,h in PINS.items():ck(hashlib.sha256((AG/rel).read_bytes()).hexdigest().upper()==h)
author=json.loads((AG/'independent-feasibility/bluestein_cached_normalization_20261111_v2.json').read_text())
def clog(x):
 x=F(x);e=0
 while 2**e*x.denominator<x.numerator:e+=1
 return e
def add(w):return 2*((w+7)//8)+1
def mul(a,b):
 x,y=(a+7)//8,(b+7)//8
 return 5*x*y+2*min(x,y)+1
def three(a,b):
 r=a+b+2
 return {'product':mul(a+1,b)+2*mul(a,b+1),'addition':add(a+1)+2*add(r)+4*add(r+2),'raw_magnitude_bits':r}

# Formal identities, coefficients in the independent variables n,P,R,A.
def const(c):return {(0,0,0,0):F(c)}
def var(i):
 t=[0]*4;t[i]=1;return {tuple(t):F(1)}
def plus(*ps):
 r={}
 for p in ps:
  for k,v in p.items():r[k]=r.get(k,F(0))+v
 return {k:v for k,v in r.items() if v}
def scale(c,p):return {k:c*v for k,v in p.items() if c*v}
def times(p,q):
 r={}
 for k,v in p.items():
  for l,w in q.items():
   t=tuple(a+b for a,b in zip(k,l));r[t]=r.get(t,F(0))+v*w
 return {k:v for k,v in r.items() if v}
n,P,R,A=[var(i) for i in range(4)]
m=plus(scale(2,n),const(-1))
q=plus(scale(3,times(n,A)),n,const(2))
Cn=plus(scale(F(9,2),times(P,A)),scale(F(3,2),P),scale(3,times(R,n)),scale(12,R),const(14))
Co=plus(scale(6,times(P,A)),scale(2,times(R,plus(scale(2,n),const(1)))),const(8))
gap=plus(times(scale(2,n),Cn),scale(-3,plus(times(P,q),times(R,plus(times(n,m),scale(2,P))))),scale(-2,plus(n,const(1))))
ck(gap==plus(times(R,plus(scale(27,n),scale(-6,P))),scale(26,n),scale(-6,P),const(-2)))
diff=plus(Co,scale(-1,Cn))
# Substitute A=1+3R in the already linear A monomials.
sub={}
for powers,v in diff.items():
 i,j,k,l=powers;ck(l<=1)
 term={(i,j,k,0):v}
 if l:term=plus(term,{(i,j,k+1,0):3*v})
 sub=plus(sub,term)
ck(sub==plus(times(R,plus(scale(F(9,2),P),n,const(-10))),const(-6)))

ineq=[]
for row in author['inequalities']:
 N=row['n'];power=1
 while power<2*N-1:power*=2
 k=power.bit_length()-1;r=2*k+4;a=1+3*r;mm=2*N-1
 old=6*power*a+2*r*(2*N+1)+8
 new=F(9*power*a+3*power,2)+3*r*N+12*r+14
 qq=3*N*a+N+2;Q=3*N*power*a+1
 direct=F(3,2)*F(power*qq+r*(N*mm+2*power),N)+F(N+1,N)
 ck(old==row['old_C'] and new==row['new_C'] and direct==F(row['new_unrelaxed_C']))
 ck(2*N<=power<4*N and Q>power*(a+1) and qq<=Q)
 ck(new-direct>0 and old-new>=74)
 ck((new-direct)*2*N==r*(27*N-6*power)+26*N-6*power-2)
 zs=F(N*mm,power)+2
 ck(2*power*zs==row['new_peak'] and 2*power*zs>5*power)
 # Worst allowed local u gives all needed cache and point claims.
 u=F(1,Q)
 ck((a+1)*u<F(1,power) and F(mm,power)+(a+1)*u<1)
 ck(qq*u<=1 and power*a*u<=1)
 ineq.append({'n':N,'C_gap':str(old-new),'C_relaxation_gap':str(new-direct)})

examples=[]
for row in author['examples']:
 N,p=row['n'],row['p'];power=row['P'];k=power.bit_length()-1;b=14
 zo=2*N*(N+1)+2;zn=F(N*(2*N-1),power)+2
 aF=p+b+clog(N+2);bK=p+clog(2*N)
 op,np=three(aF,bK),three(aF,p)
 ck(op==row['old_point'] and np==row['new_point'])
 totals=[]
 for z,key in [(zo,'old_inverse'),(zn,'new_inverse')]:
  ps=ads=gs=0
  for j in range(1,k+1):
   width=p+b+clog(2**(j+1)*z)
   copies=power//2**j;count=copies*(2**(j-1)-1-int(j>=2))
   gate=three(width,p+1)
   pr=count*gate['product'];ad=count*gate['addition']+2*power*add(width+1)
   ck(row[key]['stages'][j-1]==dict(stage=j,data_magnitude_bits=width,general_products=count,complex_adds=power,product_core=pr,addition_core=ad))
   ps+=pr;ads+=ad;gs+=count
  ck(gs==power*k//2-3*power//2+2)
  ck(ps==row[key]['product_core'] and ads==row[key]['addition_core'])
  totals.append((ps,ads))
 olddiv=4*power*add(p+b+clog(2*power*zo)+2)
 savedp=power*(op['product']-np['product'])+totals[0][0]-totals[1][0]
 saveda=power*(op['addition']-np['addition'])+totals[0][1]-totals[1][1]+olddiv
 setup=4*power*add(bK+2);cache=2*power*(add(p+1)-add(bK+1))
 ck(savedp==row['runtime_product_core_saved'] and saveda==row['runtime_add_core_saved'])
 ck(setup==row['new_scale_setup_add_core'] and cache==row['cold_cache_sum_add_delta'])
 examples.append(dict(n=N,p=p,product_difference=savedp,addition_difference=saveda,setup_additions=setup,cache_addition_difference=cache))

def nearest_grid(x,p):
 t=F(x)*2**p+F(1,2)
 return F(t.numerator//t.denominator,2**p)
for p in (0,1,3,8):
 for k in (2,3,7,18):
  for a in (-65,-33,-17,-1,0,1,17,33,65):
   for d in (2,3,8,32):
    x=F(a,d)
    ck(nearest_grid(x/2**k,p+k)==nearest_grid(x,p)/2**k)
    err=nearest_grid(x,p)-x
    ck(-F(1,2**(p+1))<err<=F(1,2**(p+1)))
out=dict(verdict='PASS_BOUNDED_PAPER_SOURCE_REVIEW',checks=checks,pins=PINS,
 general_identities=['2n(Cnew-Cexact)=R(27n-6P)+26n-6P-2','Cold-Cnew=R(9P/2+n-10)-6'],
 scalar_rows=ineq,local_price_examples=examples,global_cost_fold=False,precision_selected=False)
path=HERE/'bluestein_cached_normalization_review_20261111.json'
with path.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':hashlib.sha256(path.read_bytes()).hexdigest().upper()}))
