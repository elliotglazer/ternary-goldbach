"""All-scale-envelope diagnostic for the general Type I2 large branch."""
import math,runpy,json
from pathlib import Path
HERE=Path(__file__).resolve().parent
m=runpy.run_path(str(HERE/'resume_minor_allscale_model.py'))
q=m['q'];Y=m['Y'];K=q/(2*m['c2'])

def setup(mult):
 m['a']=1/(9*math.sqrt(2*q)*mult);m['b']=4.5*mult
 m['al']=m['a']*(1-m['eps']);m['be']=m['b']*(1-m['eps']);m['p']=m['a']*m['b']
 m['G1']=m['M']/2-1.5*math.log(m['al'])+.5*math.log(2*q*q)
 m['G2']=m['M']+math.log(16*m['b']*q*q/3)+math.log(m['b']*q)
 # Functions returned by runpy keep a distinct globals dictionary.
 for name in ['envelope','central']:
  m[name].__globals__.update({k:m[k] for k in ['a','b','al','be','p','G1','G2']})

def extra(w,du_lo,du_hi,ep):
 a,b,p,c2,eta=m['a'],m['b'],m['p'],m['c2'],m['eta']
 T=(w*Y)**(1/3);cp=1+eta*p
 cuv=2*math.sqrt(32*cp)/math.pi+3*cp/(2*c2*math.e)
 cq=math.sqrt(32*cp)/math.pi*(math.log(2*a*T*T/q)+1/math.e)+2*eta/math.pi+2*math.sqrt(96*cp)/math.pi+3*cp/(2*c2)+55*32*c2/(6*math.pi**2)
 smallrest=1.0064*cuv*p+1.0064*.75*cq/T
 lp=lambda x:max(math.log(x),0)
 vq=b/(.75*T)
 large=1.0064*(2*math.sqrt(32*cp)/math.pi)*(1+(1+ep)*(1+vq)/math.e)*p
 large+=1.0064*1.5*cp*(2+(1+ep)/ep*lp(2*p*du_hi))*vq
 large+=1.0064*35*32*c2/(3*math.pi**2)*.75/T
 large+=2*math.sqrt(32*cp)/math.pi*(1+ep)*math.sqrt(3+2*ep)*((1.03883+math.log(q)+lp(6*p*du_lo/math.sqrt(2)))/du_lo+1.0064*b/T**2)
 return large-smallrest

def cell(u0,u1,mult=128,ep=.07,nr=128):
 setup(mult);bins=[]
 for i in range(1,160):
  lo=i/20;hi=(i+1)/20;mid=(lo+hi)/2
  mass=(hi-lo)/6*sum(k*w*w*math.exp(-w*w/2) for k,w in [(1,lo),(4,mid),(1,hi)])+84*(hi-lo)**5/2880
  E,L,B,h=m['envelope'](lo)
  if hi*u1>K:
   inc=extra(lo,max(K,lo*u0),hi*u1,ep)
   E+=max(0,inc) if lo*u0<K else inc
  bins.append((mass,E,L,B,h))
 worst=(1,None)
 for j in range(nr):
  rlo=m['rmax']*j/nr;rhi=m['rmax']*(j+1)/nr
  upper=17*.05**3/3+17*(65/8)*1e-13
  for mass,E,L,B,h in bins:upper+=mass*(E+math.sqrt((L+m['l']*math.log1p(L*rhi/(1+h*rhi)))*B/(2*m['ph'])))
  lower=m['LOWA']*(.41415+.27125*math.log1p(m['ar']*rlo))+m['LOWB']
  if lower-upper<worst[0]:worst=(lower-upper,j)
 return {'u0':u0,'u1':u1,'mult':mult,'epsilon':ep,'gap':worst[0],'rbin':worst[1]}
if __name__=='__main__':
 rows=[]
 edges=[33000+(538776-33000)*j/16 for j in range(17)]
 for mult in [16,64,128]:
  for ep in [.03,.07,.15]:
   rr=[cell(x,y,mult,ep) for x,y in zip(edges,edges[1:])];rows+=rr;print('parameters',mult,ep,'worst',min(rr,key=lambda r:r['gap']))
 for j in range(16):print('bestcell',min((r for r in rows if r['u0']==edges[j]),key=lambda r:-r['gap']))
 Path(__file__).with_suffix('.json').write_text(json.dumps(rows,indent=2))
