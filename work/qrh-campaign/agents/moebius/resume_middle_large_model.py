"""Diagnostics of the exact general large-twist Type I2 source formula."""
import math,json,runpy
from pathlib import Path
HERE=Path(__file__).resolve().parent
m=runpy.run_path(str(HERE/'base_gap_90090_parameters.py'))
q=m['q'];ph=m['ph'];c2=m['c2'];etaL=m['etaL'];lp=m['lp'];formula=m['formula'];K=q/(2*c2)

def full(z,u,w,vf=16,pf=1,epsilon=.07):
 vals,meta=formula(z,0,vf,pf)
 du=w*u;delta=du/q
 assert du*.75*z**(2/3)<=z
 if du<=K:return sum(vals)
 U=meta['U'];V=meta['V'];H=.75*z**(2/3);p=U*V/z;cp=1+etaL*p
 # Retain common leading/quadratic terms of the small formula at delta=0.
 cuv=2*math.sqrt(32*cp)/math.pi+3*cp/(2*c2*math.e)
 cq=math.sqrt(32*cp)/math.pi*(lp(2*U/q)+1/math.e)+2*etaL/math.pi*max(1,math.log(32*math.exp(3)*q*q*V/(4*math.pi*etaL*z)))+2*math.sqrt(96*cp)/math.pi+3*cp/(2*c2)+55*32*c2/(6*math.pi**2)
 oldrest=1.0064*cuv*p+1.0064*cq*H/z
 newrest=1.0064*(2*math.sqrt(32*cp)/math.pi)*(1+(1+epsilon)*(1+V/H)/math.e)*p
 newrest+=1.0064*1.5*cp*(2+(1+epsilon)/epsilon*lp(2*p*du))*V/H
 newrest+=1.0064*35*32*c2/(3*math.pi**2)*H/z
 newrest+=2*math.sqrt(32*cp)/math.pi*(1+epsilon)*math.sqrt(3+2*epsilon)*((1.03883+math.log(q)+lp(6*p*du/math.sqrt(2)))/du+1.0064*V/z)
 return sum(vals)-oldrest+newrest

def integrate(u,y=1e25,vf=16,pf=1,epsilon=.07,n=1000):
 def integ(a,b):
  if a>=b:return 0
  h=(b-a)/n
  return h/3*sum((1 if j in(0,n) else 4 if j%2 else 2)*full((a+j*h)*y,u,a+j*h,vf,pf,epsilon)*(a+j*h)**2*math.exp(-(a+j*h)**2/2) for j in range(n+1))
 cut=max(.05,min(8,K/u))
 # Treat the endpoint of the large branch by its right-hand value. A single
 # quadrature endpoint has zero integral mass but otherwise introduces O(h).
 a=integ(.05,cut)
 if cut<8:
  cut2=cut*(1+1e-14)
  a+=integ(cut2,8)
 return a+17*.05**3/3+17*(65/8)*1e-13
if __name__=='__main__':
 rows=[]
 for vf in [1,16,64,128]:
  for ep in [.01,.03,.07,.15]:
   for u in [33000,50000,75000,100000,150000,250000,400000,538776]:
    val=integrate(u,vf=vf,epsilon=ep,n=600)
    rows.append({'u':u,'vf':vf,'epsilon':ep,'total':val})
 for u in [33000,50000,75000,100000,150000,250000,400000,538776]:print(min((r for r in rows if r['u']==u),key=lambda r:r['total']))
 Path(__file__).with_suffix('.json').write_text(json.dumps(rows,indent=2))
