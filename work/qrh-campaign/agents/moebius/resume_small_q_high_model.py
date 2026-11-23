"""Floating high-u overlap diagnostics. No certificates from this file."""
import math,json
from pathlib import Path
HERE=Path(__file__).resolve().parent
family=json.loads((HERE.parent/'zero-sum'/'resume_base_gap_finite_family_20261111.json').read_text())
Y=1e25;v0=math.log(Y)/3+math.log(9/601200);rmax=1/v0
A=.0749564247688777;B=.016078319462795997
phi=lambda n:sum(math.gcd(j,n)==1 for j in range(1,n+1))
def margin(q,u0,nr=128):
 f=q/phi(q);bins=[]
 for i in range(1,400):
  lo=i/50;hi=(i+1)/50;mid=(lo+hi)/2
  mass=(hi-lo)/6*(lo*lo*math.exp(-lo*lo/2)+4*mid*mid*math.exp(-mid*mid/2)+hi*hi*math.exp(-hi*hi/2))+84*(hi-lo)**5/2880
  tlo=lo*u0/4;thi=hi*u0/4;ell=math.log(tlo);hr=math.log(300000/thi)+math.log(lo)/3
  aq=math.log(4*thi)/2;bc=(.30214*ell+.7468)*f/tlo
  rem=2.5257/math.sqrt(tlo)+13.2*f/tlo+2/tlo*(16.267*ell+24.42)+3.77*(lo*Y)**(-1/6)+3*math.log(lo*Y)/(lo*Y)
  bins.append((mass,hr,aq,ell,bc,rem))
 worst=(1,None)
 for j in range(nr):
  rlo=rmax*j/nr;rhi=rmax*(j+1)/nr;upper=17*.02**3/3+17*(65/8)*1e-13
  for mass,hr,aq,ell,bc,rem in bins:
   C=math.log1p(aq*rhi/(1+hr*rhi));upper+=mass*(math.sqrt((C*(ell+.002)+math.log(4*math.exp(ell))/2)*bc)+rem)
  lower=A*(.41415+.27125*math.log1p(math.log(1200000)/2*rlo))+B
  if lower-upper<worst[0]:worst=(lower-upper,j)
 return worst
if __name__=='__main__':
 out=[]
 for row in family['samples']:
  q=row.get('q',row.get('reduced_q'))
  if q not in family['full_gap_failures'] or q==1:continue
  U=row['u_prefix_integer'];gap,j=margin(q,U)
  result={'q':q,'phi':phi(q),'u0':U,'gap':gap,'rbin':j};out.append(result);print(result)
 (HERE/'resume_small_q_high_model.json').write_text(json.dumps(out,indent=2))
