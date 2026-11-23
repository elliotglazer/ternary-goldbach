"""Diagnostic with analytically certified dyadic lower scales per compact-r cell."""
import runpy,math,json
from pathlib import Path
HERE=Path(__file__).resolve().parent
m=runpy.run_path(str(HERE/'resume_middle_allscale_model.py'))
base=m['m'];Y0=1e25

def dynamic_cell(u0,u1,mult=16,ep=.07,nr=128):
 m['setup'](mult);worst=(1,None);v0=1/base['rmax']
 for j in range(nr):
  rlo=base['rmax']*j/nr;rhi=base['rmax']*(j+1)/nr
  k=max(0,min(128,math.floor((1/rhi-v0)/math.log(2))))
  yeff=Y0*2.**(3*k)
  base['envelope'].__globals__['Y']=yeff;m['extra'].__globals__['Y']=yeff
  upper=17*.05**3/3+17*(65/8)*1e-13
  for i in range(1,160):
   lo=i/20;hi=(i+1)/20;mid=(lo+hi)/2
   mass=(hi-lo)/6*sum(c*w*w*math.exp(-w*w/2) for c,w in [(1,lo),(4,mid),(1,hi)])+84*(hi-lo)**5/2880
   E,L,B,h=base['envelope'](lo)
   if hi*u1>m['K']:
    inc=m['extra'](lo,max(m['K'],lo*u0),hi*u1,ep)
    E+=max(0,inc) if lo*u0<m['K'] else inc
   upper+=mass*(E+math.sqrt((L+base['l']*math.log1p(L*rhi/(1+h*rhi)))*B/(2*base['ph'])))
  lower=base['LOWA']*(.41415+.27125*math.log1p(base['ar']*rlo))+base['LOWB']
  if lower-upper<worst[0]:worst=(lower-upper,j)
 return {'u0':u0,'u1':u1,'mult':mult,'epsilon':ep,'gap':worst[0],'rbin':worst[1]}
if __name__=='__main__':
 edges=[33000,40000,50000,65000,85000,110000,150000,200000,275000,375000,538776]
 rows=[]
 for vf in [16,64,128]:
  for u0,u1 in zip(edges,edges[1:]):
   r=dynamic_cell(u0,u1,vf);rows.append(r);print(r,flush=True)
 Path(__file__).with_suffix('.json').write_text(json.dumps(rows,indent=2))
