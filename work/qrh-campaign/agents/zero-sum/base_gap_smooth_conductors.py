"""Exact integer conductor enumeration; floating radical/log evaluations diagnostic."""
from pathlib import Path
import math,json,csv
from fractions import Fraction
ROOT=Path('work/qrh-campaign/agents/zero-sum')
def factors(n):
 out={};p=2
 while p*p<=n:
  while n%p==0:out[p]=out.get(p,0)+1;n//=p
  p+=1
 if n>1:out[n]=1
 return out
def phi(n):
 for p in factors(n): n=n//p*(p-1)
 return n
def mu(n):
 fs=factors(n)
 return 0 if any(a>1 for a in fs.values()) else (-1)**len(fs)
def prim(n):
 ans=1
 for p,a in factors(n).items():ans*=p-2 if a==1 else p**(a-2)*(p-1)**2
 return ans
def divisors(n):
 out=[1]
 for p,a in factors(n).items():out=[x*p**j for x in out for j in range(a+1)]
 return sorted(out)
def H(s):return 4*((1-2**(-s))/s)**2*2**(s/2)*math.gamma(1+s/2)
def F(s,d,L=50):
 val=sum((2j*math.pi*d)**k/math.factorial(k)*H(s+k) for k in range(L))
 rem=(2*math.pi*abs(d))**L/math.factorial(L)*H(s+L)
 return abs(val),rem
res=[];allrows=[]
for q in [90090,120120,180180,240240]:
 Q=q//math.gcd(q,2);ph=phi(q);rows=[]
 for c in divisors(q):
  r=q//c
  if mu(r)==0 or math.gcd(c,r)!=1 or prim(c)==0:continue
  n=prim(c);dif=mu(c)+(mu(c//2) if c%2==0 else 0)
  ne=(n+dif)//2;no=(n-dif)//2
  assert ne+no==n and ne>=0 and no>=0
  w=n*math.sqrt(c)/ph
  mass=(ne*(.5*math.log(c)-.29)+no*(.5*math.log(c)+.017))*math.sqrt(c)/ph if c>1 else .07*w
  rows.append(dict(q=q,Q=Q,c=c,quotient=r,primitive=n,even=ne,odd=no,gauss_squared=c,W_contribution=w,mass_upper_contribution=mass))
 assert sum(row['primitive']*row['c'] for row in rows)==ph*ph
 W=sum(r['W_contribution'] for r in rows);M=sum(r['mass_upper_contribution'] for r in rows)
 rows.sort(key=lambda r:r['W_contribution'],reverse=True)
 for row in rows:row['W_fraction']=row['W_contribution']/W;row['mass_fraction']=row['mass_upper_contribution']/M
 delta=600000/(49*Q);fv,fr=F(.875,delta)
 main=abs(mu(q))*min(1.2534,1.016/delta**2)/ph
 assert main==0
 den=10**6
 wl=sum(Fraction(r['primitive']*math.isqrt(r['c']*den**2),ph*den) for r in rows)
 wu=sum(Fraction(r['primitive']*(math.isqrt(r['c']*den**2)+1),ph*den) for r in rows)
 candidates=[];byM=sorted(rows,key=lambda r:r['mass_upper_contribution'],reverse=True)
 for k in [1,2,3,4,5,8]:
  done=byM[:k];rest=byM[k:]
  candidates.append(dict(blocks=k,conductors=[r['c'] for r in done],characters=sum(r['primitive'] for r in done),remaining_mass_coefficient=sum(r['mass_upper_contribution'] for r in rest)*10**(-25/8),remaining_W_fraction=sum(r['W_contribution'] for r in rest)/W))
 thresholds=[]
 for C in [100,1000,5000,10000,20000,50000,100000,200000,300000]:
  rr=[r for r in rows if r['c']<=C]
  thresholds.append(dict(C=C,conductors=len(rr),characters=sum(r['primitive'] for r in rr),W_fraction=sum(r['W_contribution'] for r in rr)/W,mass_fraction=sum(r['mass_upper_contribution'] for r in rr)/M))
 row=dict(q=q,Q=Q,factors=factors(q),phi=ph,delta_min=delta,delta_max=600000/Q,admissible_conductors=len(rows),nonzero_gauss_characters=sum(r['primitive'] for r in rows),even=sum(r['even'] for r in rows),odd=sum(r['odd'] for r in rows),W=W,W_lower=str(wl),W_upper=str(wu),main=main,certificate_candidates=candidates,W_over_sqrtq=W/math.sqrt(q),mass_upper_sum=M,y_factor=10**(-25/8),error_if_common_Z1=W*10**(-25/8),error_if_common_mass_kernel1=M*10**(-25/8),Z_cap_for_uniform_04712=(.04712-main)/(W*10**(-25/8)),K_cap_for_uniform_04712=(.04712-main)/(M*10**(-25/8)),Z_cap_for_endpoint_0598=(.0598-main)/(W*10**(-25/8)),K_cap_for_endpoint_0598=(.0598-main)/(M*10**(-25/8)),F_beta875_delta_min=fv,F_series_tail=fr,top_conductors=rows[:8],thresholds=thresholds)
 res.append(row);allrows+=rows
with (ROOT/'base_gap_smooth_conductors.csv').open('w',newline='',encoding='utf-8') as f:
 writer=csv.DictWriter(f,fieldnames=allrows[0].keys());writer.writeheader();writer.writerows(allrows)
(ROOT/'base_gap_smooth_conductors.json').write_text(json.dumps({'status':'exact integer counts; radical/log/kernel and budget figures floating diagnostics','rows':res},indent=2),encoding='utf-8')
for r in res:
 print({k:v for k,v in r.items() if k not in ['thresholds','top_conductors','certificate_candidates','W_lower','W_upper']})
 print('top',[(t['c'],t['primitive'],round(t['W_fraction'],5)) for t in r['top_conductors']])
 print('certificate candidates',r['certificate_candidates'])
