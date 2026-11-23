"""Finite integer arithmetic and rational comparisons only. No function evaluations."""
from pathlib import Path
from fractions import Fraction as F
from math import gcd
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
A=ROOT/'work/qrh-campaign/agents'
sources=[
 A/'audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md',
 A/'audit/DIRECT_STAR_B_SOURCE_OBSTRUCTION_V2_2026-11-11.md',
 A/'major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md',
 ROOT/'work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md',
]
S=ROOT/'work/ternary-goldbach/TernaryGoldbach'
sources += [S/p for p in ['MinorArcs/Bombieri.lean','MinorArcs/LargeSieveProof.lean','MinorArcs/LargeSieveWeights.lean','MinorArcs/LargeSievePrimes.lean','MinorArcs/LSQuot1.lean','Prelim/Ramare.lean','MajorArcs/Cor933.lean','MajorArcs/Eta2Moments.lean','MinorArcs/BaseGap.lean']]
pins=[{'path':str(p.relative_to(ROOT)).replace('\\','/'),'sha256':hashlib.sha256(p.read_bytes()).hexdigest().upper()} for p in sources]
assert pins[0]['sha256']=='AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B'
assert pins[1]['sha256']=='65B892756EA24A086C673082D3CA551AF99EECA5DDA63CB3523EE3F5514A88A9'
assert pins[3]['sha256']=='22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7'
checks={}
def ck(k,b):
 assert b,k
 checks[k]=True
N=44300
phi=list(range(N+1)); sf=[True]*(N+1)
for p in range(2,N+1):
 if phi[p]==p:
  for n in range(p,N+1,p): phi[n]-=phi[n]//p
  for n in range(p*p,N+1,p*p): sf[n]=False
grid=1<<64; low=0; count=0
for d in range(1,N+1):
 if gcd(d,6)==1 and sf[d]:
  v=phi[d]; low+=((2*v-1)*grid)//(2*v*v); count+=1
Glo=F(low,grid); Ghi=Glo+F(count,grid)
ck('terms',count==13468)
ck('directed_lower',low==67935707915980013489)
ck('G_weighted_gt_18_over_5',Glo>F(18,5))
ck('G_weighted_lt_369_over_100',Ghi<F(369,100))
# Independent local conductor-count reconstruction on a small fixed domain.
def fac(n):
 out=[];p=2
 while p*p<=n:
  e=0
  while n%p==0: n//=p;e+=1
  if e:out.append((p,e))
  p+=1
 if n>1:out.append((n,1))
 return out
def primitive(n):
 if n==1:return 1
 ans=1
 for p,e in fac(n):ans*=p-2 if e==1 else (p-1)**2*p**(e-2)
 return ans
for q in range(1,257):
 supported=sum(primitive(c) for c in range(1,q+1) if q%c==0 and sf[q//c] and gcd(q//c,c)==1)
 expected=F(phi[q])
 for p,e in fac(q):
  if e>=2:expected*=F(p-1,p)
 ck('support_count_'+str(q),supported==expected)
 d=supported-int(sf[q]); kap=F(d,phi[q])
 ck('support_fraction_'+str(q),0<=kap<=1 and (q%4!=0 or kap<=F(1,2)))
ck('eta2_first_moment',F(-3,16)+F(3,4)==F(9,16))
ck('etaU_first_moment',2*F(9,16)==F(9,8))
ck('mass_sqrt_pi_comparison',F('3.14')>F(25,8))
ck('triangular_pairing',3*F(5,4)-F(9,8)==F(21,8))
ck('V_lower',F(21,8)**2/9==F(49,64)>F(3,4))
eps=F(702,10**15); j=F('8.79');u=F(367,10**8)
ck('entire_target_ceiling',j*u*u/eps<169)
ck('comparison_lower',49*F(3,4)*(6*F(18,5)-14)==F(2793,10)>169)
ck('old_V_comparison_insufficient_for_new_budget',F(49,5)*(6*Glo-14)<j*u*u/eps)
ck('conditional_C_sqrt',50*eps<F('0.000005925')**2)
norm=F('0.000001902')+F('0.000003')+F('0.000005925')+F('0.000000283')/10+F(1,10**15)*1000
ck('complete_conditional_allocation',norm**2<j*u*u)
receipt={'scope':'Exact finite arithmetic, source bytes, conditional scalar budgets; no actual energy values','pins':pins,'checks':checks,'count':len(checks),'weighted_G6':{'d_max':N,'terms':count,'floor_sum':low,'denominator':grid,'lower':str(Glo),'upper':str(Ghi)},'complete_norm_upper':str(norm),'entire_target_ceiling':str(j*u*u/eps)}
out=Path(__file__).with_suffix('.json')
with out.open('x',encoding='utf-8',newline='\n') as f:json.dump(receipt,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks),'pins':len(pins),'weighted_terms':count}))
