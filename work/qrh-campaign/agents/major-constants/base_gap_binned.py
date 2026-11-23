"""Exact fixed-bin sufficient classifier for the direct etaStar base gap.
No quadrature sampling: Simpson masses have a global fourth-derivative remainder.
No Lean compiler and no claim that upstream Type I/II inputs are discharged.
"""
from fractions import Fraction as F
from functools import lru_cache
from math import factorial,isqrt
import json
Y=10**25; SCALE=10**12; RBASE=F('.41415'); REND=F('.583405')

def up(q):return F((q.numerator*SCALE+q.denominator-1)//q.denominator,SCALE)
def down(q):return F(q.numerator*SCALE//q.denominator,SCALE)
@lru_cache(None)
def logs(q):
 q=F(q);k=0
 while q>=2:q/=2;k+=1
 while q<1:q*=2;k-=1
 def unit(v):
  z=(v-1)/(v+1)
  s=2*sum((z**(2*j+1)/F(2*j+1) for j in range(32)),F(0))
  return s,s+2*z**65/(65*(1-z*z))
 l,u=unit(q); l2,u2=unit(F(2))
 if k>=0:return down(l+k*l2),up(u+k*u2)
 return down(l+k*u2),up(u+k*l2)
@lru_cache(None)
def root_up(q,k):
 q=F(q)
 if k==2:return F(isqrt(q.numerator*SCALE**2//q.denominator)+1,SCALE)
 lo=0;hi=SCALE
 while F(hi,SCALE)**k<q:hi*=2
 while hi-lo>1:
  mid=(lo+hi)//2
  if F(mid,SCALE)**k<q:lo=mid
  else:hi=mid
 return F(hi,SCALE)
@lru_cache(None)
def phi_up(w):
 z=w*w/2
 exp_lo=sum((z**j/factorial(j) for j in range(121)),F(0))
 return up(w*w/exp_lo)
# |phi''''| <=12+78/e+224/e²+216/e³ <84, by maximizing w^(2m)e^(-w²/2).
assert 12+F(78)/F('2.7')+F(224)/F('2.7')**2+F(216)/F('2.7')**3<84
assert sum((F(1,factorial(j)) for j in range(8)),F(0))>F('2.7')
edges=[F('.01'),F('.025')]+[F(i,20) for i in range(1,161)]
bins=[]
for l,u in zip(edges,edges[1:]):
 h=u-l
 mass=up(h/6*(phi_up(l)+4*phi_up((l+u)/2)+phi_up(u))+84*h**5/2880)
 bins.append((l,u,mass,up(F('3.8')*root_up(1/(l*Y),6))))
# Trivial eta2 coefficient17 on the omitted intervals; e^32>10^13.
assert sum((F(32)**j/factorial(j) for j in range(121)),F(0))>10**13
TAIL=17*F('.01')**3/3+17*F(65,8)/10**13
H0lo,H0hi=logs(F(1200000))
V0lo=logs(F(Y))[0]/3+logs(F(9,601200))[0]
assert V0lo>8
assert RBASE+F('.27125')*logs(1+H0hi/(2*V0lo))[1]<REND
# Constants of the independently checked all-y lower envelope aR+b.
Flo=F('1.78')*F('2.478081')+F('2.50637')/F('2.478088')
Lg=Flo*(F(13,4)*F('12.61153')+F('7.82'))+F('13.66')*F('12.61153')+F('37.55')
LOWA=F('1.398')*F('12.61153')*F('2.3286')/F('547.723')
LOWB=F('1.398')*((F('.8764')*F('2.3286')+F('2.526'))/F('547.723')+Lg/150000)

@lru_cache(None)
def kappa(tmax,l):
 dlo=logs(F(300000)/tmax)[0]+logs(l)[0]/3
 assert V0lo+dlo>0
 ratio=F(1) if dlo>=0 else V0lo/(V0lo+dlo)
 return up(max(F(1),logs(4*tmax)[1]/H0lo*ratio))

def certify(Q0,Q1,v):
 assert 4<=Q0<=Q1<=150000 and v>0
 # Monotonic coefficient inequalities hold at t>=2Q0>=8>e².
 rows=[]
 for j in range(16):
  D0=F(600000,49)+F(600000- F(600000,49))*j/16
  D1=F(600000,49)+F(600000- F(600000,49))*(j+1)/16
  A=B=F(0)
  for l,u,mass,rem in bins:
   tmin=F(max(2*Q0,l*D0/2));tmax=F(max(2*Q1,u*D1/2))
   k=kappa(tmax,l);logt=logs(tmin)[1]
   rt=root_up(v/tmin,2);ri=root_up(1/tmin,2)
   # Keep exact rational affine expression. Its value is positive on R>=RBASE.
   ai=k*logt*rt
   bi=(RBASE*(1-k)*logt+F('.8764'))*rt+F('2.526')*ri+2/tmin*(v*(F(13,4)*logt+F('7.82'))+F('13.66')*logt+F('37.55'))+rem
   A+=mass*ai;B+=mass*bi
  B+=TAIL
  gaps=[(LOWA-A)*r+LOWB-B for r in (RBASE,REND)]
  rows.append(dict(j=j,gap=min(gaps),gap_low_R=gaps[0],gap_high_R=gaps[1],A=A,B=B))
 worst=min(rows,key=lambda r:r['gap'])
 passed=all(r['gap']>0 for r in rows)
 return dict(Q0=Q0,Q1=Q1,v=str(v),passed=passed,worst_bin=worst['j'],
  gap_lower=str(down(worst['gap'])),gap_diagnostic=float(worst['gap']),
  rows=[{k:(str(down(z)) if k.startswith('gap') else float(z) if isinstance(z,F) else z) for k,z in r.items()} for r in rows])

cells=[(50000,150000,F('1.6')),(60000,150000,F(2)),(100000,150000,F(4)),(120000,150000,F(1001,192)),(125000,150000,F('5.5'))]
results=[certify(*c) for c in cells]
assert all(r['passed'] for r in results)
print(json.dumps(dict(status='Exact rational sufficient inequalities with explicit analytic remainder. Analytic interpolation and Type I/II theorem still need Lean proofs.',w_bins=len(bins),D_bins=16,tail_bound=str(TAIL),cells=results),indent=2))

