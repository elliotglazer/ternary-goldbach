"""Independent exact metadata and tolerance checks, no analytic evaluations."""
from pathlib import Path
from fractions import Fraction as F
from collections import Counter
from functools import lru_cache
import hashlib,json
A=Path(__file__).resolve().parents[1]
P=A/'prime-estimates'
pins={
'CLARIFICATION_MINIMAL_THETA_BUCKET_ROUNDING_2026-11-11.md':'4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41',
'NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md':'6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043',
'MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md':'73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A',
'small_family_minimal_theta_20261111.py':'0B0656A46461D397B9A459BEFEFC9686640FDCBC4EA5C6CD73E19BB2C3B1C5E0',
'small_family_minimal_theta_20261111.json':'25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422',
'small_family_theta_inventory_final_20261111.json':'26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69'}
checks=0
def ck(x):
 global checks
 checks+=1
 assert x,checks
def ceil(x):return (x.numerator+x.denominator-1)//x.denominator
def bits(x):return ((x.denominator-1)//x.numerator).bit_length()
def p2(n):return 1<<(n-1).bit_length()
for f,h in pins.items():ck(hashlib.sha256((P/f).read_bytes()).hexdigest().upper()==h)
new=json.loads((P/'small_family_minimal_theta_20261111.json').read_text())
old=json.loads((P/'small_family_theta_inventory_final_20261111.json').read_text())
for f,h in new['pins'].items():ck(hashlib.sha256(Path(f).read_bytes()).hexdigest().upper()==h)

# Independent divisor inversion of ordinary parity characters.
lim=10000
phi=list(range(lim+1));phi[1]=1
mu=[1]*(lim+1);spf=list(range(lim+1))
for p in range(2,lim+1):
 if spf[p]==p:
  for n in range(p,lim+1,p):
   phi[n]-=phi[n]//p;mu[n]*=-1
   if spf[n]==n:spf[n]=p
  for n in range(p*p,lim+1,p*p):mu[n]=0
prim=[0]*(lim+1);ev=[0]*(lim+1)
for d in range(1,lim+1):
 for n in range(d,lim+1,d):
  prim[n]+=phi[d]*mu[n//d]
  ev[n]+=(phi[d] if d<=2 else phi[d]//2)*mu[n//d]
@lru_cache(None)
def axis(d):
 if d&(d-1)==0:
  k=d.bit_length()-1
  return d*k//2,0,0,2*k+4,max(1,2*k)
 L=p2(2*d-1);k=L.bit_length()-1;r=2*k+4;a=1+3*r
 return L*k,L+2*d,L,6*L*a+2*r*(2*d+1)+8,max(1,2*k,L*a,3*d*L*a+1)
family=[]
for c in range(3,lim+1):
 if not(c%2 or c%4==0):continue
 axes=[];x=c
 while x>1:
  p=spf[x];e=0
  while x%p==0:x//=p;e+=1
  if p>2:axes.append((p-1)*p**(e-1))
  elif e==2:axes.append(2)
  else:axes.extend([2,2**(e-2)])
 h=int(ev[c]>0)+int(prim[c]>ev[c]);band=sum(c>=v for v in [100,1000,10000])
 U=([F(21),F(20),F(39,2),F(96,5)] if c%2 else [F(113,5),F(211,10),F(201,10),F(191,10)])[band]
 H=200+ceil(max(F(240 if c%2 else 255),F(3927,1250)*U*F(531600 if c%2 else 1063200,c)))
 costs=[sum(phi[c]//d*axis(d)[j] for d in axes) for j in range(3)]
 family.append((c,phi[c],prim[c],h,H,*costs,sum(axis(d)[3] for d in axes),max(axis(d)[4] for d in axes)))
ck(len(family)==7499 and sum(r[2] for r in family)==18477108)
params={};C=44;n0=8192;B=3**11;M=B+1;BP=2*3**33;tau=F(1,2**80)
for odd in [True,False]:
 for theta in range(64,129):
  W=F(40000000 if odd else 80000000,theta);eps=tau/(4*3**theta)
  K=L=1;r=F(3,8)
  while 128*W*W*r**K>=eps:K+=1
  while 48*W*r**L>=eps:L+=1
  ck(128*W*W*r**K<eps<=128*W*W*r**(K-1))
  ck(48*W*r**L<eps<=48*W*r**(L-1))
  ck(F(8,3)**20>=W*(20+L))
  v=3*n0*n0/W;z=3*(2*n0+1)/W-F(1,n0)
  ck(v>=2 and z>0)
  tail=2*C*n0*(1+1/z)*r**(v.numerator//v.denominator)
  ck(tail<eps/8)
  pb=bits(eps/(192*C*BP*n0**4));delta=F(1,2**pb)
  ck(6*delta<=eps/(32*C*BP*n0**4)<12*delta)
  epref=eps/(64*C*(n0*n0+2));D=min(delta/16,1/W)
  sigma=min(F(1,4),D/(64*M**4),epref/(16*M**3),F(1,16*n0))
  ck(15*M**4*sigma<D and 7*M**3*sigma<epref and 4*n0*sigma<=F(1,4))
  t=dict(theta=theta,odd=odd,W=W,eps=eps,K=K,L=L,seed_bits=pb,sigma=sigma,tail=tail)
  saved=next(x for x in new['selectors'] if x['odd']==odd and x['theta']==theta)
  ck({k:str(v) if isinstance(v,F) else v for k,v in t.items()}==saved)
  params[odd,theta]=t
def length(m,t):
 return max(8,p2(ceil(max(F(2*m*t['K'],t['theta']),F(5*m+128*t['K'],5),F(384,5)))))
def tols(c,v,S,safe,m,N,R,t):
 eps,W,sigma=t['eps'],t['W'],t['sigma'];J=R-1;eta=sigma/256
 dr=sigma/(4*B*max(1,J));k0=min(dr/16,sigma/(16384*c*c));k=N.bit_length()-1
 char=min(F(1,safe),F(1,2*S),eps/(128*C*BP*v*S*(n0*n0+2)))
 gauss=min(F(1,safe),F(1,2*S),eta/(256*v*S))
 time=min(F(1,2*k),eps*F(5,64)/(56*(2*k+4)*(2*W*W+2)))
 scale=tau/(32*(2*W*W+1)*3**t['theta']*max(1,m))
 ck(J*dr<=F(1,2) and k0<=eta/(8*c) and 3*k0<=eta/(32*v) and m*scale<F(1,2))
 return dict(seed=F(1,2**t['seed_bits']),sigma=sigma,radial=dr,setup=k0,character=char,gauss=gauss,time=time,scale=scale)
summaries=[]
for extra in [0,167,320,640]:
 choices=[];hist=Counter();tot=Counter();ranges={};weighted=Counter();denoms=Counter()
 for c,v,n,h,H,g,pp,sc,S,safe in family:
  m=(64*H+4)//5+extra;V=F(5*m,64);odd=bool(c%2);end=params[odd,128];N=length(m,end)
  lengths=[length(m,params[odd,q]) for q in range(64,129)]
  theta=next(q for q in range(64,129) if lengths[q-64]<=N);t=params[odd,theta]
  ck(lengths[theta-64]==N and all(n>N for n in lengths[:theta-64]))
  ck(V>=2*theta and 1<=F(c)*V/theta<=t['W'])
  ck(F(5*N,64)>=max(2*V*t['K']/theta,V+2*t['K'],F(6)))
  R=ceil(F(50*N,384))+1;T=ceil(n0*(1+F(5*N,192))+R)
  ck(R-1<N//2 and m+1<=N)
  choices.append(theta);hist[theta]+=1
  st=tols(c,v,S,safe,m,N,R,t);et=tols(c,v,S,safe,m,N,R,end)
  weights=dict(seed=2*T,sigma=R,radial=R,setup=1,character=h*R*g,gauss=g,time=n*(N//2)*(N.bit_length()-1),scale=m)
  for key,val in st.items():
   ck(val>=et[key]);p=bits(val);po=bits(et[key]);ck(p<=po)
   if key not in ranges:ranges[key]=[p,p,po,po]
   else:ranges[key]=[min(ranges[key][0],p),max(ranges[key][1],p),min(ranges[key][2],po),max(ranges[key][3],po)]
   weighted[key]+=weights[key]*(po-p);denoms[key]+=weights[key]
  # Omitted-from-eight allocations are still charged; no exact bucket switch.
  for denom in [32*C*BP*n0,64*C*(n0*n0+2),32*C,16]:
   ck(t['eps']/denom>=end['eps']/denom)
  ck(t['eps']/(16*N*(2*t['W']**2+2))>=end['eps']/(16*N*(2*end['W']**2+2)))
  tot.update(dict(Gaussian_unit_gates_upper=2*T,outer_complex_exp_upper=R,main_character_butterflies=h*R*g,main_character_point_products=h*R*pp,time_butterflies=n*(N//2)*(N.bit_length()-1),primitive_grid_outputs=n*(m+1),bucket_additions_upper=h*T,main_character_inverse_dyadic_scales=h*R*sc,gauss_character_inverse_dyadic_scales=sc,Gaussian_seed_unit_contractions_upper=R))
 saved=next(x for x in new['scenarios'] if x['extra_nodes']==extra)
 ck(choices==saved['choice_in_increasing_active_conductor_order'])
 ck({str(k):v for k,v in sorted(hist.items())}==saved['histogram'])
 ck(ranges==saved['bit_ranges_selected_then_128'] and dict(weighted)==saved['weighted_bit_savings'] and dict(denoms)==saved['weight_denominators'])
 previous=next(x for x in old['scenarios'] if x['extra_nodes']==extra and x['theta']==128)
 for key,val in tot.items():ck(val==previous['totals'][key])
 ck({k:tot[k] for k in saved['counts_identical_to_theta128']}==saved['counts_identical_to_theta128'])
 summaries.append(dict(extra=extra,histogram=dict(sorted(hist.items())),counts=dict(tot),ranges=ranges))
out=dict(status='PASS exact selectors/choices/tolerances with frozen rounded-bucket clarification',checks=checks,pins=pins,selectors=130,choices=29996,scenarios=summaries)
with Path(__file__).with_name('review_minimal_theta_final_20261111.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print('PASS',checks,'exact checks')
