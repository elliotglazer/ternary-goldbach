"""Floating diagnostic of exact-cell design for q1 high twists."""
import math,json
from pathlib import Path
Y=1e25;v0=math.log(Y)/3+math.log(9/601200);rmax=1/v0
A=.0749564247688777;B=.016078319462795997
edges=[190000.]
while edges[-1]<1200000:edges.append(min(1200000,edges[-1]*1.05))
def run(nr=128):
 worst=(1,None)
 for ui,(u0,u1) in enumerate(zip(edges,edges[1:])):
  for j in range(nr):
   rlo=rmax*j/nr;rhi=rmax*(j+1)/nr;upper=17*.02**3/3+17*(65/8)*1e-13
   for i in range(1,400):
    lo=i/50;hi=(i+1)/50;mid=(lo+hi)/2
    mass=(hi-lo)/6*(lo*lo*math.exp(-lo*lo/2)+4*mid*mid*math.exp(-mid*mid/2)+hi*hi*math.exp(-hi*hi/2))+84*(hi-lo)**5/2880
    tlo=lo*u0/4;thi=hi*u1/4;ell=math.log(tlo);hr=math.log(300000/thi)+math.log(lo)/3
    C=math.log1p(math.log(4*thi)/2*rhi/(1+hr*rhi))
    val=math.sqrt((C*(ell+.002)+math.log(4*tlo)/2)*(.30214*ell+.7468)/tlo)+2.5257/math.sqrt(tlo)+13.2/tlo+2/tlo*(16.267*ell+24.42)+3.77*(lo*Y)**(-1/6)+3*math.log(lo*Y)/(lo*Y)
    upper+=mass*val
   lower=A*(.41415+.27125*math.log1p(math.log(1200000)/2*rlo))+B
   if lower-upper<worst[0]:worst=(lower-upper,(ui,j,u0,u1,upper,lower))
 return worst
if __name__=='__main__':print(run())
