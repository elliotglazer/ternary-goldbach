"""Reprice frozen geometry descriptors only; no unit scan or function values."""
from pathlib import Path
from fractions import Fraction as Q
from math import comb,factorial
from functools import lru_cache
import hashlib,json
B=Path(__file__).resolve().parents[1]
pins={
'major-constants/length_guard_fd_costs_20261111.json':'5388F1D02DBA2A7BD4F921DAAE55AA4BEEAFC3217E6DC0C7F65DFBECC8A2CA50',
'audit/REVIEW_LENGTH_GUARDED_STAGEWISE_FD_COSTS_2026-11-11.md':'8560547AEF747FD3E3072666DA030B84E8DEB059D0749CD80A3AA0AC05520E79',
'major-constants/VARIABLE_DEGREE_GRID_ROUNDED_DIFFERENCES_2026-11-11.md':'79F8EA3F6F8BE2AA0EC61E335BB068EA2690A3AA84CBB4BBF39D6878FC4F1B55',
'major-constants/variable_degree_rounded_fd_20261111.json':'82C2BDAC4E313A18A90799957DDA04E2BB96FBB9FE2B62208D4714E9FED1B143',
'audit/REVIEW_VARIABLE_DEGREE_GRID_ROUNDED_DIFFERENCES_2026-11-11.md':'F77403A37293F22EBCBEA84B4FED2FC2ABED02317B9E0C4F8C50132528DB6E91',
'moebius/joint_horner_length_precision_20261111.json':'59EBE87D5E5B2623C8F40A1EADB0F7803106F5005F90826C35F5B08C69284742',
'independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7',
'prime-estimates/stored_hurwitz_degree_bounds_20261111.json':'E947C32ED8EA30BA14ED64A7DFF83AA1C8E3F3F222AAD1AD8DAA8484013781BE',
'major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
'moebius/fixed_horner_degree_envelope_costs_20261111.json':'4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for f,h in pins.items():ck(hashlib.sha256((B/f).read_bytes()).hexdigest().upper()==h)
def read(f):return json.loads((B/f).read_text())
old=read('major-constants/length_guard_fd_costs_20261111.json')
fd=read('major-constants/variable_degree_rounded_fd_20261111.json')
hor=read('moebius/joint_horner_length_precision_20261111.json')
oldhor=read('moebius/fixed_horner_degree_envelope_costs_20261111.json')
source=read('prime-estimates/stored_hurwitz_degree_bounds_20261111.json')
Z={cl:list(map(lambda r:Q(r['stored_center_norm_bound']),rs)) for cl,rs in source['cohorts'].items()}
def nu(x):return (x&-x).bit_length()-1
def bits(x):
 ck(x>0)
 q=max(1,x.numerator.bit_length()-x.denominator.bit_length())
 while x>Q(2)**q:q+=1
 while q>1 and x<=Q(2)**(q-1):q-=1
 return q
def fresh():return dict(core=0,products={},adders={},shifts={},signed_bridges=0)
def inc(d,k,n=1):d[k]=d.get(k,0)+n
def prod(d,a,b):
 a,b=max(1,a),max(1,b);x,y=sorted(((a+7)//8,(b+7)//8))
 d['core']+=5*x*y+2*x+1;inc(d['products'],f'{a},{b}');d['signed_bridges']+=1
def plus(d,w,signed=True):
 d['core']+=2*((max(1,w)+7)//8)+1;inc(d['adders'],str(max(1,w)));d['signed_bridges']+=int(signed)
def shift(d,w,s):inc(d['shifts'],f'{max(1,w)},{s}')
def combine(*ds):
 r=fresh()
 for d in ds:
  for k in ('core','signed_bridges'):r[k]+=d[k]
  for k in ('products','adders','shifts'):
   for key,n in d[k].items():inc(r[k],key,n)
 return r
def gate(d,qbits,den,w,alignment=None,dyadic=False):
 db=den.bit_length()
 if dyadic:shift(d,qbits,nu(den))
 else:
  odd=den>>nu(den);prod(d,qbits,odd.bit_length())
  if nu(den):shift(d,qbits+odd.bit_length(),nu(den))
 plus(d,w);plus(d,db+3);plus(d,db+2,False)
 shift(d,db+1,1);shift(d,db,1)
 if alignment is not None:shift(d,*alignment)
@lru_cache(None)
def stir(a,j):return int(a==j==0) if a==0 else (0 if j==0 else j*stir(a-1,j)+stir(a-1,j-1))
@lru_cache(None)
def kernel(k,j,mode):
 s=Q(1,40 if mode=='guard20' else 20)
 return sum(Q(comb(k,r))*Q(1,4)**(k-r)*s**r*factorial(j)*stir(r,j) for r in range(j,k+1))
@lru_cache(None)
def envelopes(cl,K,b,mode):
 n=K-1;e=Q(3,4)*Q(2)**-b;c=[z+e for z in Z[cl][:K]]
 E=[]
 for i in range(K):
  E.append([sum(c[n-i+k]*(Q(2)**j*Q(1,4)**k if mode=='all_cell' else kernel(k,j,mode)) for k in range(j,i+1)) for j in range(i+1)])
 return c,E
def descriptors(r):
 # Recover ONLY metadata already present in the certified schedule.
 ss=r['horner']['uniform100']['shift_terms'];p=0;out=[];v=2*r['c']
 stages=oldhor['results'][r['cohort']]['uniform100']['stages']
 for _ in range(r['U']):
  found=[]
  for st in stages:
   for coord in range(2):
    group=[]
    while True:
     ck(p<len(ss));g=ss[p];p+=1;group.append(g)
     if g[1]==0:break
    ck(len(group) in (3,4))
    db=group[-2][0];tp=v.bit_length()-db;ck(0<=tp<=nu(v));den=v>>tp
    rb=group[-1][0]-st['input_magnitude_bits'];ck(rb>=1)
    expect=[]
    if nu(den):expect.append([st['rounded_product_magnitude_bits']+(den>>nu(den)).bit_length(),nu(den)])
    expect += [[db+1,1],[db,1],[st['input_magnitude_bits']+rb,0]]
    ck(group==expect);found.append((den,rb,tp))
  ck(len(set(found))==1);den,rb,tp=found[0]
  out.append(dict(den=den,r_bits=rb,tp=tp))
 ck(p==len(ss));return out
def fd_schedule(r,a,desc):
 K,b,d=a['K'],a['b'],a['d'];n=K-1;L=r['L'];m=min(K,L);mode=r['domain'];cl=r['cohort']
 coef,E=envelopes(cl,K,b,mode);v=2*r['c'];F=r['F'];q0=F*r['lo']-r['k']*r['c']
 # All-cell normalization now follows the separately reviewed finite divisibility proof.
 t=min(nu(F),nu(v),nu(abs(q0))) if q0 else min(nu(F),nu(v))
 vp,Fp,rp=v>>t,F>>t,q0>>t;delta=nu(Fp)
 lam=[j*delta+nu(factorial(j)) for j in range(K)]
 ck(v==vp*2**t and F==Fp*2**t and q0==rp*2**t)
 S=sum(comb(L-1,j) for j in range(m));p=b+S.bit_length()+d
 beta=Q(3,4)*Q(2)**-p*S;eb=Q(3,4)*Q(2)**-b;ep=Q(3,4)*Q(2)**-p
 def mag(i,j,x):return bits(x*2**b*vp**i/Q(2)**lam[j])
 init=fresh();powers=fresh()
 for i in range(1,K):
  prod(powers,(vp**(i-1)).bit_length(),vp.bit_length())
  for _ in range(2):prod(init,bits(coef[n-i]*2**b),(vp**i).bit_length())
  for j in range(min(i-1,m-1)+1):
   factor=rp+j*Fp
   if j==0:raw=E[i-1][0]/4+coef[n-i]
   elif mode=='all_cell':raw=E[i-1][j]/4+E[i-1][j-1]/2
   else:
    s=Q(1,40 if mode=='guard20' else 20);raw=(Q(1,4)+j*s)*E[i-1][j]+j*s*E[i-1][j-1]
   for _ in range(2):
    prod(init,mag(i-1,j,E[i-1][j]),max(1,abs(factor).bit_length()));plus(init,mag(i,j,raw)+1)
  for j in range(1,min(i,m-1)+1):
   scale=j>>nu(j);sec=E[i-1][j-1]*(Q(1,2) if mode=='all_cell' else Q(j,40 if mode=='guard20' else 20))
   for _ in range(2):
    for z in range(scale.bit_length()):
     if scale>>z&1:shift(init,mag(i-1,j-1,E[i-1][j-1]),z)
    for z in range(scale.bit_count()-1):plus(init,mag(i,j,sec)+1)
 adv=fresh();exact_adv=fresh()
 for r0 in range(L-1):
  for j in range(min(n-1,L-2-r0)+1):
   for _ in range(2):
    plus(adv,bits((E[n][j]+E[n][j+1]+2*beta)*2**p)+1)
    shift(exact_adv,mag(n,j+1,E[n][j+1]),lam[j+1]-lam[j]);plus(exact_adv,mag(n,j,E[n][j]+E[n][j+1])+1)
 ir=fresh();fr=fresh();efr=fresh();export=fresh();D=vp**n
 for j in range(m):
  exponent=p-b+lam[j];cancel=min(exponent,nu(D));den=D>>cancel
  qb=bits((E[n][j]+ep)*2**p);xb=bits(E[n][j]*2**p*den);w=max(xb,qb+den.bit_length())+2
  for _ in range(2):gate(ir,qb,den,w,(mag(n,j,E[n][j]),exponent-cancel))
 qb=bits((E[n][0]+beta+eb)*2**b);x=bits((E[n][0]+beta)*2**p);den=2**(p-b)
 for u in desc:
  for _ in range(2):
   gate(fr,qb,den,max(x,qb+p-b)+2,dyadic=True)
   ed=u['den']**n;gate(efr,qb,ed,qb+ed.bit_length()+2)
   if u['tp']>t:shift(efr,mag(n,0,E[n][0]),n*(u['tp']-t))
   shift(export,qb,100-b)
 components=dict(cold_powers=powers,initialization=init,initial_rounds=ir,rounded_advances=adv,dyadic_finals=fr,grid100_exports=export,exact_advances=exact_adv,exact_finals=efr)
 total=combine(powers,init,ir,adv,fr,export);exact=combine(powers,init,exact_adv,efr,export)
 return dict(K=K,b=b,d=d,p=p,beta=str(beta),alpha_ratio=a['alpha_ratio'],t=t,n=n,m=m,coefficient_conversions=K,prescales=n,initial_rounds=m,components=components,total=total,exact_FD_diagnostic=exact,
  live_max_signed_bits=max(bits((E[n][j]+beta)*2**p)+1 for j in range(m)),output_signed_bits=qb+1,grid100_output_signed_bits=qb+101-b)
def hor_schedule(r,profile,a,desc):
 K=a['K'];gr=a['grids'];c=[z+Q(3,4)*Q(2)**-b for z,b in zip(Z[r['cohort']][:K],gr)]
 A=[Q(0)]*K;T=[Q(0)]*(K-1);A[-1]=c[-1]
 for j in range(K-2,-1,-1):T[j]=A[j+1]/4+Q(3,4)*Q(2)**-gr[j];A[j]=c[j]+T[j]
 h=fresh();ex=fresh()
 for u in desc:
  for st in a['stages']:
   j=st['j'];inp=bits(A[j+1]*2**gr[j+1]);qb=bits(T[j]*2**gr[j]);ck(inp==st['Mbits'] and qb==st['Lbits'])
   align=gr[j]-gr[j+1];cancel=min(align,nu(u['den']));den=u['den']>>cancel;left=align-cancel
   xb=u['r_bits']+inp+left;w=max(xb,qb+den.bit_length())+2
   for _ in range(2):
    prod(h,inp,u['r_bits']);gate(h,qb,den,w,(inp+u['r_bits'],left));plus(h,bits(A[j]*2**gr[j])+1)
  for _ in range(2):shift(ex,bits(A[0]*2**gr[0]),100-gr[0])
 return dict(profile=profile,K=K,b=gr[0],grids=gr,alpha_ratio=a['alpha_ratio'],coefficient_conversions=K,evaluation=h,grid100_exports=ex,total=combine(h,ex))
rows=[]
for r in old['rows']:
 case={1024:'band1',4096:'band3',8192:'band4',16384:'band5_declared'}[r['F']]
 desc=descriptors(r);ck(len(desc)==r['U'])
 fs=[fd_schedule(r,a,desc) for a in fd['candidates'] if a['case']==case and a['admitted']]
 hs=[hor_schedule(r,pr,a,desc) for pr,data in hor['results'][case]['profiles'].items() for a in data['candidates'] if a['admitted']]
 bf=min(fs,key=lambda x:(x['total']['core'],x['K'],x['b'],x['d']));bh=min(hs,key=lambda x:(x['total']['core'],x['K'],x['b'],x['profile']))
 rows.append(dict(geometry={k:r[k] for k in ('c','F','k','lo','hi','L','U','domain','cohort')},case=case,unit_descriptors=desc,fd_candidates=fs,horner_candidates=hs,
  minimum_core=dict(fd=[bf['K'],bf['b'],bf['d'],bf['p'],bf['total']['core']],horner=[bh['profile'],bh['K'],bh['b'],bh['total']['core']],projected_horner_minus_fd=bh['total']['core']-bf['total']['core']),old_core=dict(rounded_FD=r['rounded_FD_core'],fixed_Horner=r['horner']['fixed_15442']['core'])))
out=dict(checks=checks,pins=pins,scope='Same12 frozen cells, decoded unit capacity descriptors, admitted bounded candidates only; typed cost cores not a method winner',rows=rows)
path=Path(__file__).with_suffix('.json')
with path.open('x') as f:json.dump(out,f,indent=2)
print(json.dumps(dict(checks=checks,sha256=hashlib.sha256(path.read_bytes()).hexdigest().upper(),summary=[dict(L=r['geometry']['L'],c=r['geometry']['c'],case=r['case'],fd_count=len(r['fd_candidates']),hor_count=len(r['horner_candidates']),**r['minimum_core']) for r in rows])))
