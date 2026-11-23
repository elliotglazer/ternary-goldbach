"""Exhaustive finite scalar admission, not evaluation of any analytic value."""
from pathlib import Path
from fractions import Fraction as F
from functools import lru_cache
from collections import Counter
import json,hashlib
HERE=Path(__file__).resolve().parent
A=HERE.parent
PINS={
 HERE/'WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md':'74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE',
 HERE/'small_family_theta_inventory_final_20261111.json':'26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69',
 A/'audit/REVIEW_WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md':'34FB45C1CEBFF34A49C7C450BF1C78223593AB188EFEFC7C3EE7FE7658CB0AFE'}
checks=0
def ck(b):
 global checks
 assert b
 checks+=1
def ceil(x):return -(-x.numerator//x.denominator)
def bits(x):
 b=max(0,x.denominator.bit_length()-x.numerator.bit_length())
 if F(1,1<<b)>x:b+=1
 return b
def factors(n):
 out=[];p=2
 while p*p<=n:
  if n%p==0:
   e=0
   while n%p==0:n//=p;e+=1
   out.append((p,e))
  p+=1
 if n>1:out.append((n,1))
 return out
def cdata(c):
 v=n=1;axes=[]
 for p,e in factors(c):
  v*=(p-1)*p**(e-1);n*=p-2 if e==1 else (p-1)**2*p**(e-2)
  if p>2:axes.append((p-1)*p**(e-1))
  elif e==2:axes.append(2)
  elif e>2:axes.extend([2,2**(e-2)])
 return v,n,axes
def height(c):
 i=0 if c<100 else 1 if c<1000 else 2 if c<10000 else 3
 u=([F(21),F(20),F('19.5'),F('19.2')] if c%2 else [F('22.6'),F('21.1'),F('20.1'),F('19.1')])[i]
 return ceil(200+max(F(240 if c%2 else 255),F('3.1416')*u*F(531600 if c%2 else 1063200,c)))
@lru_cache(None)
def axis(d):
 if d&(d-1)==0:
  k=d.bit_length()-1
  return d*k//2,0,2*k+4,max(1,2*k)
 P=1<<(2*d-2).bit_length();k=P.bit_length()-1;R=2*k+4;a=1+3*R
 return P*k,P+2*d,6*P*a+2*R*(2*d+1)+8,max(1,2*k,P*a,3*d*P*a+1)

for f,h in PINS.items():ck(hashlib.sha256(f.read_bytes()).hexdigest().upper()==h)
base=json.loads((HERE/'small_family_theta_inventory_final_20261111.json').read_text())
X=10;C=44;n0=8192;B=3**11;M=B+1;Bpref=2*3**33;r=F(3,8);params={}
for odd in [True,False]:
 for theta in range(64,129):
  W=F(40000000 if odd else 80000000,theta);eps=F(1,2**80*4*3**theta)
  K=L=1
  while 32*W**2*r**K>=eps/4:K+=1
  while 12*W*r**L>=eps/4:L+=1
  v0=3*n0*n0/W;z0=3*(2*n0+1)/W-F(1,n0)
  ck(F(8,3)**20>=W*(20+L))
  ck(v0>=2 and z0>0)
  tail=C*2*n0*(1+1/z0)*r**(v0.numerator//v0.denominator)
  ck(tail<eps/8)
  p=bits(eps/(192*C*Bpref*n0**4));delta=F(1,2**p)
  ck(6*delta<=eps/(32*C*Bpref*n0**4))
  epref=eps/(64*C*(n0*n0+2));D=min(delta/16,1/W)
  sigma=min(F(1,4),D/(64*M**4),epref/(16*M**3),F(1,16*n0))
  ck(15*M**4*sigma<D and 7*M**3*sigma<epref and 4*n0*sigma<=F(1,4))
  params[odd,theta]=dict(theta=theta,odd=odd,W=W,eps=eps,K=K,L=L,seed_bits=p,sigma=sigma,tail=tail)
  if theta in [64,128]:
   old=next(t for t in base['parameters'] if t['odd']==odd and t['theta']==theta)
   ck([K,L,p]==[old['K'],old['L'],old['p']] and sigma==F(old['sigma']))

family=[]
for c in range(3,10001):
 if c%2 and c>1 or c%4==0:
  v,n,axes=cdata(c);h=1 if c in [3,4,12] else 2
  S=sum(axis(d)[2] for d in axes);safe=max(axis(d)[3] for d in axes)
  g=sum(v//d*axis(d)[0] for d in axes)
  pp=sum(v//d*axis(d)[1] for d in axes)
  family.append((c,v,n,h,S,safe,g,pp,height(c)))
ck(len(family)==7499 and sum(x[2] for x in family)==18477108)
def minN(m,K,theta):
 need=max(ceil(F(2*m*K,theta)),ceil(F(5*m+128*K,5)),ceil(F(384,5)))
 return max(8,1<<(need-1).bit_length())
def tolerances(c,v,S,safe,m,N,t):
 theta=t['theta'];W=t['W'];eps=t['eps'];sigma=t['sigma'];R=ceil(F(5*N*X,384))+1;J=R-1
 dr=sigma/(4*B*max(1,J));k0=min(dr/16,sigma/(16384*c*c));eta=sigma/256
 uchar=min(F(1,safe),F(1,2*S),eps/(128*C*Bpref*v*S*(n0*n0+2)))
 ugauss=min(F(1,safe),F(1,2*S),eta/(256*v*S))
 k=N.bit_length()-1;utime=min(F(1,2*k),eps*F(5,64)/(56*(2*k+4)*(2*W*W+2)))
 escale=F(1,2**80)/(4*(2*W*W+1));ds=escale/(8*3**theta*max(1,m))
 ck(J*dr<=F(1,2) and k0<=eta/(8*c) and 3*k0<=eta/(32*v) and m*ds<F(1,2))
 return dict(seed=F(1,2**t['seed_bits']),sigma=sigma,radial=dr,setup=k0,character=uchar,gauss=ugauss,time=utime,scale=ds)

rows=[];digest=hashlib.sha256()
for extra in [0,167,320,640]:
 hist=Counter();chosen=[];ranges={};weighted=Counter();same64=0;counts=Counter();weight_total=Counter()
 for c,v,n,h,S,safe,g,pp,H in family:
  m=ceil(F(64*H,5))+extra;V=F(5*m,64);odd=c%2==1
  endpoint=params[odd,128];N=minN(m,endpoint['K'],128)
  admitted=[]
  for theta in range(64,129):
   t=params[odd,theta]
   if minN(m,t['K'],theta)<=N:admitted.append(theta)
  theta=admitted[0];t=params[odd,theta]
  ck(all(minN(m,params[odd,q]['K'],q)>N for q in range(64,theta)))
  ck(V>=2*theta and 1<=c*V/theta<=t['W'])
  ck(F(5*N,64)>=max(2*V*t['K']/theta,V+2*t['K'],F(6)))
  ck(minN(m,t['K'],theta)==N)
  hist[theta]+=1;chosen.append(theta);same64+=theta==64
  selected=tolerances(c,v,S,safe,m,N,t);old=tolerances(c,v,S,safe,m,N,endpoint)
  R=ceil(F(5*N*X,384))+1;T=ceil(n0*(1+F(5*N,192))+R)
  ck(R-1<N//2 and m+1<=N)
  weights=dict(seed=2*T,sigma=R,radial=R,setup=1,character=h*R*g,gauss=g,time=n*(N//2)*(N.bit_length()-1),scale=m)
  for key,value in selected.items():
   ck(value>=old[key])
   p=bits(value);po=bits(old[key]);ck(p<=po)
   if key not in ranges:ranges[key]=[p,p,po,po]
   else:
    ranges[key][0]=min(ranges[key][0],p);ranges[key][1]=max(ranges[key][1],p)
    ranges[key][2]=min(ranges[key][2],po);ranges[key][3]=max(ranges[key][3],po)
   weighted[key]+=weights[key]*(po-p);weight_total[key]+=weights[key]
  count=dict(Gaussian_unit_gates_upper=2*T,outer_complex_exp_upper=R,main_character_butterflies=h*R*g,main_character_point_products=h*R*pp,time_butterflies=n*(N//2)*(N.bit_length()-1),primitive_grid_outputs=n*(m+1))
  counts.update(count)
  digest.update(json.dumps([extra,c,theta,N,R,T,{k:str(v) for k,v in selected.items()}],sort_keys=True).encode())
 target=next(s for s in base['scenarios'] if s['theta']==128 and s['extra_nodes']==extra)
 for k,v in counts.items():ck(target['totals'][k]==v)
 rows.append(dict(extra_nodes=extra,histogram=dict(sorted(hist.items())),choice_in_increasing_active_conductor_order=chosen,same64=same64,counts_identical_to_theta128=dict(counts),bit_ranges_selected_then_128=ranges,weighted_bit_savings=dict(weighted),weight_denominators=dict(weight_total)))
out=dict(status='PASS_ALL_130_SELECTORS_AND_29996_MINIMAL_CHOICES',checks=checks,pins={str(f):h for f,h in PINS.items()},common=dict(X=X,C=C,n0=n0,Delta='5/64',tau='1/1208925819614629174706176'),
 selectors=[{k:str(v) if isinstance(v,F) else v for k,v in t.items()} for t in params.values()],scenarios=rows,rows_digest=digest.hexdigest(),scope='Every integer theta is independently admitted; exact scalar/metadata only, no analytic values or throughput claim.')
with Path(__file__).with_suffix('.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=checks,scenarios=[{k:v for k,v in r.items() if k not in ('choice_in_increasing_active_conductor_order',)} for r in rows]),indent=2))
