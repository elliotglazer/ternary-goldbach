"""Diagnostic first pass at exact common published-height QRH tails; not a certificate."""
import math,json
from pathlib import Path
M=300000;R=150000
phi=list(range(M+1));spf=list(range(M+1));mu=[1]*(M+1);a=[0]*(M+1);a[1]=1
for p in range(2,M+1):
 if spf[p]==p:
  for n in range(p,M+1,p):
   phi[n]-=phi[n]//p;mu[n]*=-1
   if spf[n]==n:spf[n]=p
  for n in range(p*p,M+1,p*p):mu[n]=0
for n in range(2,M+1):
 p=spf[n];v=n;e=0
 while v%p==0:v//=p;e+=1
 a[n]=a[v]*(p-2 if e==1 else p**(e-2)*(p-1)**2)
x0=4.9e26;y0=1e25
Et=[0.]*(M+1);Es=[0.]*(M+1);tp=[0.]*(M+1)
def ec(t,d):
 u=t/(math.pi*d)
 return .588*u*u*math.exp(-.1065*u*u) if u<80 else 0.
def eb(t):return .892*t*math.exp(-.1598*t) if t<5000 else 0.
for c in range(1,M+1):
 if not a[c] or(c%2 and c>R):continue
 D=1200000/(2*c if c%2 else c)
 oldH=200+max(1000,math.ceil((704/7)*D))
 H=min(1e8/c,oldH)
 Ns=math.ceil(400*(2*max(1000,math.ceil((704/343)*D))/3.48+2))
 G=3+D/2.7;GA=800*G+106/H*G*G;GB=2400+954/H
 t=(3.5*(eb(H-100)*GB+ec(H-100,D)*GA)+.00625*(eb(H-200)*GB+ec(H-200,D)*GA))*x0**(-.125)
 tp[c]=t
 for q in range(c,M+1,c):
  if q%2 and q>R:continue
  r=q//c
  if mu[r] and math.gcd(c,r)==1:
   w=c*a[c]/phi[q]
   Et[q]+=w*t*t
   Es[q]+=w*49*102000*Ns*y0**(-.89)
nt=sum(2*1200000/(2*q if q%2 else q)*Et[q] for q in range(1,M+1) if Et[q])
mix=sum(Et[q]*Es[q] for q in range(1,M+1))
at=sum((min(381.22,2*1200000/(2*q if q%2 else q)*1.2534**2)/phi[q]**2)*Et[q] for q in range(1,M+1) if mu[q] and(q%2==0 or q<=R))
out={'diagnostic_only':True,'max_percharacter_tail':max(tp),'max_c':tp.index(max(tp)),'Ntail':nt,'N_tail_norm':math.sqrt(nt),'plusTail_times_starLow_norm2':mix,'mixed_tail_norm':math.sqrt(mix),'Aplus_tail':at,'cross_total_using_low_norm_0005':(.0005+math.sqrt(mix)+1e-8)**2}
print(json.dumps(out,indent=2));Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
