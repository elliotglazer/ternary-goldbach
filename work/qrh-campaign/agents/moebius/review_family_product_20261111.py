"""Exact independent finite algebra. Synthetic arrays only, no L-function data."""
from fractions import Fraction as F
from pathlib import Path
from itertools import permutations
from math import gcd
import hashlib,json

HERE=Path(__file__).resolve().parent;SRC=HERE.parent/'zero-sum'
PINS={
 'FAMILY_PRODUCT_CERTIFICATION_FEASIBILITY_2026-11-11.md':'B701615E4D93727BF7A2C290C41F94EDEB40C0E9FE2BCFAB4A725CB6AC4B8973',
 'family_product_certificate_checks_20261111.py':'3F877AE40F2D89ABFC45E8981CBC8696149233D8909BC9146992A7EAE1B1A6C0',
 'family_product_certificate_checks_20261111.json':'68FAA891D5954CAC21D5460583578513083D0515459C2DF5F140A047A7B3401E'}
for name,pin in PINS.items():assert hashlib.sha256((SRC/name).read_bytes()).hexdigest().upper()==pin
Z=(F(0),F(0));ONE=(F(1),F(0))
def add(a,b):return(a[0]+b[0],a[1]+b[1])
def neg(a):return(-a[0],-a[1])
def sub(a,b):return add(a,neg(b))
def mul(a,b):return(a[0]*b[0]-a[1]*b[1],a[0]*b[1]+a[1]*b[0])
def conj(a):return(a[0],-a[1])
def norm2(a):return a[0]*a[0]+a[1]*a[1]
def total(xs):
 z=Z
 for x in xs:z=add(z,x)
 return z
def prod(xs):
 z=ONE
 for x in xs:z=mul(z,x)
 return z
def mobius(n):
 out=1;p=2
 while p*p<=n:
  if n%p==0:
   n//=p;out=-out
   if n%p==0:return 0
  p+=1
 return -out if n>1 else out
def determinant(m):
 n=len(m);answer=Z
 for p in permutations(range(n)):
  sign=(-1)**sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))
  term=prod(m[i][p[i]] for i in range(n))
  answer=add(answer,term if sign==1 else neg(term))
 return answer
def enc(z):return [str(z[0]),str(z[1])]

rows=[]
for c in (5,8):
 G=[g for g in range(1,c) if gcd(g,c)==1];v=len(G)
 def conv(a,b):return {g:total(mul(a[h],b[pow(h,-1,c)*g%c]) for h in G) for g in G}
 def hat(a,chi):return total(mul(a[g],chi[g]) for g in G)
 delta={g:ONE if g==1 else Z for g in G}
 e={g:Z for g in G}
 for d in range(1,c+1):
  if c%d:continue
  kernel=[g for g in G if (g-1)%d==0]
  for g in kernel:e[g]=add(e[g],(F(mobius(c//d),len(kernel)),F(0)))
 assert conv(e,e)==e and all(e[g]==conj(e[pow(g,-1,c)]) for g in G)
 if c==5:
  fourth=[ONE,(F(0),F(1)),(F(-1),F(0)),(F(0),F(-1))]
  log={pow(2,j,5):j for j in range(4)}
  chars=[{g:fourth[(k*log[g])%4] for g in G} for k in range(4)]
 else:
  coords={pow(7,j,8)*pow(5,k,8)%8:(j,k) for j in range(2) for k in range(2)}
  chars=[{g:(F((-1)**(j*coords[g][0]+k*coords[g][1])),F(0)) for g in G}
         for j in range(2) for k in range(2)]
 selected=[chi for chi in chars if hat(e,chi)==ONE]
 assert len(selected)==(3 if c==5 else 2)
 for chi in chars:
  assert hat(e,chi) in (Z,ONE)
  for g in G:
   for h in G:assert chi[g*h%c]==mul(chi[g],chi[h])
 a={g:(F(g+1,7),F(2-g,11)) for g in G}
 b={g:(F(g%3,13),F(1,17*g)) for g in G}
 ea=conv(e,a);ea_b=conv(ea,b);r={g:sub(e[g],ea_b[g]) for g in G}
 assert conv(e,r)==r
 compressed={g:add(sub(delta[g],e[g]),ea[g]) for g in G}
 matrix=[[compressed[x*pow(y,-1,c)%c] for y in G] for x in G]
 det=determinant(matrix);eigenprod=prod(hat(a,chi) for chi in selected)
 assert det==eigenprod
 moments=[];power=delta
 for k in range(1,4):
  power=conv(power,r)
  coeff_moment=v*sum(norm2(power[g]) for g in G)
  spectral_moment=sum(norm2(hat(r,chi))**k for chi in selected)
  assert coeff_moment==spectral_moment
  dagger={g:conj(power[pow(g,-1,c)]) for g in G}
  atone=conv(dagger,power)[1]
  assert atone[1]==0 and v*atone[0]==coeff_moment
  moments.append({'k':k,'exact_moment':str(coeff_moment)})
 rows.append({'c':c,'primitive_rank':len(selected),'projector':{str(g):enc(e[g]) for g in G},
              'nontrivial_compressed_determinant':enc(det),'moment_checks':moments})
n=149991
assert F(n,4**9)<1 and n*F(4,9)**16<1
assert F(22,7)**2/F(6)-1<F(2,3)
assert 2*3*5*7*11*13*17==510510>300000
out={'status':'PASS_INDEPENDENT_SYNTHETIC_PRODUCT_ALGEBRA','producer_pins':PINS,'rows':rows,
     'half_residual_k9':str(F(n,4**9)),'two_thirds_residual_k16':str(n*F(4,9)**16),
     'scope':'Nontrivial rational-complex synthetic convolution arrays only; no spectral evidence'}
(HERE/'review_family_product_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(out['status'])
