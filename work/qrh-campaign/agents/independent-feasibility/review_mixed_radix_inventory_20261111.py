"""Independent exact transform schedule inventory, with no roots or transforms evaluated."""
from pathlib import Path
from functools import cache
from math import prod
from fractions import Fraction
import json,hashlib
A=Path(__file__).resolve().parents[1]
source=A/'zero-sum/mixed_radix_character_inventory_20261111.json'
author=json.loads(source.read_text())
N=300000
spf=[0]*(N+1);phi=list(range(N+1));phi[1]=1
for p in range(2,N+1):
 if spf[p]:continue
 for x in range(p,N+1,p):
  if not spf[x]:spf[x]=p
  phi[x]-=phi[x]//p
primitive=phi[:]
for d in range(1,N+1):
 for x in range(2*d,N+1,d):primitive[x]-=primitive[d]
def factor(n):
 z=[]
 while n>1:
  p=spf[n];e=0
  while n%p==0:n//=p;e+=1
  z.append((p,e))
 return z
Z=(0,0,0,0,0)
def plus(*v):return tuple(map(sum,zip(*v)))
def scale(c,v):return tuple(c*x for x in v)
def power2(n):return n&(n-1)==0
@cache
def rad(n):
 # Count twiddles by stage rather than the closed formula.
 g=a=q=0;s=2
 while s<=n:
  copies=n//s;half=s//2;quarter=int(s>=4)
  g+=copies*(half-1-quarter);q+=copies*quarter;a+=n;s*=2
 return g,a,q,0,0
@cache
def chirp(n):
 reduced=n//(2 if n%2==0 else 1)
 d=prod(p**((e+1)//2) for p,e in factor(reduced))
 count=n//d;h=(2*d*d//n)%4
 # Among multiples j=d*l only odd l can have a nonidentity fourth root.
 odd=count//2
 q=odd if h in (1,3) else 0
 neg=odd if h==2 else 0
 return n-count,q,neg,count-q-neg
@cache
def blue(n):
 p=1
 while p<2*n-1:p*=2
 g,q,neg,_=chirp(n)
 return plus(scale(2,rad(p)),(p+2*g,0,2*q,2*neg,p))
@cache
def old(n):return rad(n) if power2(n) else blue(n)
def divisors(n):
 ds=[1]
 for p,e in factor(n):ds=[v*p**j for v in ds for j in range(e+1)]
 return ds
@cache
def twiddle(r,m):
 n=r*m;rot=neg=0
 for h in (1,2,3):
  if h*n%4:continue
  t=h*n//4
  count=sum(1 for a in divisors(t) if a<r and 1<=t//a<m)
  if h==2:neg+=count
  else:rot+=count
 return (r-1)*(m-1)-rot-neg,0,rot,neg,0
plans={}
@cache
def new(n):
 if power2(n):plans[n]=('radix2',);return rad(n)
 r=spf[n]
 if r==n:
  if n<=11:plans[n]=('direct_prime',);return ((n-1)**2,n*(n-1),0,0,0)
  plans[n]=('bluestein',);return blue(n)
 m=n//r;c=plus(scale(r,new(m)),scale(m,new(r)),twiddle(r,m))
 if c[0]<=old(n)[0] and c[1]<=old(n)[1]:plans[n]=('split',r,m);return c
 plans[n]=('bluestein',);return old(n)
keys=list(author['large_reduced']['baseline'])
axes=set();rows=[];checks=0
for ar in author['rows']:
 lo,hi=ar['range'];o=Z;v=Z;cnum=pr=inp=out=0
 for c in range(lo,hi+1):
  if not ((c%2 and c<=150000) or c%4==0):continue
  dims=[]
  for p,e in factor(c):
   if p==2:
    if e==2:dims.append(2)
    else:dims.extend([2,2**(e-2)])
   else:dims.append((p-1)*p**(e-1))
  assert prod(dims)==phi[c]
  axes.update(dims)
  heightnum=max(100000000,200*c+75000000) if c%4==0 else 100000000
  j=-(-64*heightnum//(5*c))+1
  cnum+=1;pr+=primitive[c];inp+=j*phi[c];out+=j*primitive[c]
  for d in dims:
   o=plus(o,scale(j*(phi[c]//d),old(d)));v=plus(v,scale(j*(phi[c]//d),new(d)))
 vals=dict(conductors=cnum,primitive_labels=pr,coarse_residue_inputs=inp,coarse_primitive_outputs=out)
 for k,x in vals.items():assert x==ar[k];checks+=1
 assert dict(zip(keys,o))==ar['baseline'];assert dict(zip(keys,v))==ar['mixed'];checks+=10
 rows.append(dict(**vals,baseline=dict(zip(keys,o)),mixed=dict(zip(keys,v))))
active=set()
def visit(n):
 if n in active:return
 active.add(n)
 if plans[n][0]=='split':
  _,r,m=plans[n];visit(r);visit(m)
for d in axes:visit(d)
counts={t:sum(plans[d][0]==t for d in active) for t in ('radix2','direct_prime','split','bluestein')}
assert counts==author['choices_count'];checks+=4
for mode,ds in [('old',set(d for d in axes if not power2(d))),('mixed',set(d for d in active if plans[d][0]=='bluestein'))]:
 ps=[1<<(2*d-2).bit_length() for d in ds]
 record=author[mode+'_setup']
 assert len(ds)==record['kernel_count'] and sum(ps)==record['kernel_entries'] and max(ps)==record['max_padded_length']
 assert sum(ds)==record['chirp_entries']
 summed=plus(Z,*(rad(p) for p in ps));assert dict(zip(keys,summed))==record['kernel_forward_fft'];checks+=9
assert sum(d for d in active if plans[d][0]=='split')==author['mixed_CT_full_root_table_entry_upper'];checks+=1
# Independent direct small modular classifications. No complex roots evaluated.
for n in range(2,301):
 counts0=[0,0,0,0]
 for j in range(n):
  if 2*j*j%n==0:counts0[(2*j*j//n)%4]+=1
 assert chirp(n)==(n-sum(counts0),counts0[1]+counts0[3],counts0[2],counts0[0]);checks+=1
for r in range(2,18):
 for m in range(2,18):
  n=r*m;cheap=[0,0,0,0]
  for a in range(1,r):
   for v in range(1,m):
    if (4*a*v)%n==0:cheap[(4*a*v//n)%4]+=1
  assert twiddle(r,m)==((r-1)*(m-1)-sum(cheap),0,cheap[1]+cheap[3],cheap[2],0);checks+=1
large_old=plus(*(tuple(r['baseline'][k] for k in keys) for r in rows[1:]))
large_new=plus(*(tuple(r['mixed'][k] for k in keys) for r in rows[1:]))
assert Fraction(621939,10**6)<=Fraction(large_new[0],large_old[0])<=Fraction(621940,10**6)
assert Fraction(550472,10**6)<=Fraction(large_new[1],large_old[1])<=Fraction(550473,10**6);checks+=2
out=dict(status='PASS_INDEPENDENT_INTEGER_INVENTORY',checks=checks,source_sha256=hashlib.sha256(source.read_bytes()).hexdigest().upper(),rows=rows,choices=counts,large_old=large_old,large_new=large_new,scope='Metadata only; no transform/root/function/prime-candidate evaluations')
with Path(__file__).with_suffix('.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=checks,large_old=large_old,large_new=large_new)))
