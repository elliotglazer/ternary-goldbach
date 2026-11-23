"""Exact rational compact-scale certificate for q90090 small-twist envelope.
Analytic domination is proved in RESUME_MINOR_2026-11-11.md. This is external
rational arithmetic, not a Lean theorem; upstream producer obligations remain.
"""
from fractions import Fraction as F
from contextlib import redirect_stdout
from pathlib import Path
import sys,io,json
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/'major-constants'))
with redirect_stdout(io.StringIO()):
 import base_gap_90090_certificate as old
I=old.I;bb=old.b;pi=old.pi;e=old.e
q=90090;ph=17280;Y=10**25;eps=F(1,10**8)
l=I(2*q).log();a=1/(144*I(2*q).root());b=I(72);al=a*(1-eps);be=b*(1-eps);p=a*b
M=I(F('2.8')*F(q,ph));eta=8*I(2).log();c2=6*pi/(5*I(32).root())
d=I(F(9,601200)).log();ar=I(1200000).log()/2
v0=I(Y).log()/3+d;rmax=(1/v0).u
G1=M/2-F('1.5')*al.log()+I(2*q*q).log()/2
G2=M+I(384*q*q).log()+(b*q).log()
assert (2*33000/F(q))<(1/(2*c2)).l
assert v0.l>8

def constants(w):
 T=I(w*Y).root(3);s=T.log()
 assert (eps*a*T**2).l>=1 and (eps*b*T).l>=1
 assert (al*T).l>=F(1,192) and (a*q/(c2*T)).u<1
 assert (32*e**3*q*q/(4*pi*eta*T**3)).u<e.l
 assert (32*e**3*q*q*b/(4*pi*eta*T**2)).u<e.l
 assert (2*a*T**2/q).l>e.u**2
 # All logarithmic-over-power factors used below decrease for T>=T0.
 assert s.l>18 and (T/(2*q*a)).log().l>17
 c1=1+eta*a/T;cp=1+eta*p
 err=2*(32*c1).root()/pi*a/T*(e*T/al).log()
 err+=q/T**3*(2*eta/pi*3*s+2*(32*c1).root()/pi*(I(3).root()+F('.5')*(2*a*T**2/q).log())*(q/c2).log())
 err+=F('1.5')*c1*(2/c2).root()/(T*T.root())*(2*T**3/c2).log()+20*32*c2*c2.root()/(3*pi**2)*I(2).root()/(T*T.root())*(2*e*T**3/c2).log()
 i1=(F(q,ph)+F('2.67')+G1+2-I(4).log())/(2*q)+32*(F('.5')-2/pi**2)*(a*a/(4*q*T**2)*(e.root()*T/al).log()+1/(e*T**3))+err
 cuv=2*(32*cp).root()/pi+3*cp/(2*c2*e)
 cq=(32*cp).root()/pi*((2*a*T**2/q).log()+1/e)+2*eta/pi+2*(3*32*cp).root()/pi+3*cp/(2*c2)+55*32*c2/(6*pi**2)
 i2=G2/(2*q)+32*(F('.125')-1/(2*pi**2))*(F('.511')*p*p/q+a*a*b*I(q).log()/T+F('1.022')*a*b*b/T**2+F('.511')*q*b*b/T**4)+F('1.0064')*cuv*p+F('1.0064')*F('.75')*cq/T
 kap=2/pi**2+27/(al*be.root()*T)
 rest=4*(kap*q/(2*ph)).root()*(2/(al.root()*T)+l.root()*(2*e*I(2*q).root()/(T*T.root())+4/(al.root()*T*(T/(2*q*a)).log().root())))+8*F('1.4262')*(kap*(F('.5')+1/(al*T**2))).root()/(be*T).root()
 L=(1/(al*be)).log();B=F('.60428')*L+F('.0924')+216/(al*be.root()*T)
 h=(be/(2*q)).log()+I(w).log()/3-d
 E=i1+i2+rest+9*s/T**3
 assert h.l>0 and L.l>0
 aq=I(8*q).log()/2;hr=I(F(300000,2*q)).log()+I(w).log()/3
 er=F('2.5257')/I(2*q).root()+F('13.2')/(2*ph)+(F('16.267')*l+F('24.42'))/q+F('3.77')/I(w*Y).root(6)+3*I(w*Y).log()/(w*Y)
 assert hr.l>0 if w>=2 else True
 return E,L,B,h,aq,hr,er

def central(c,r):
 E,L,B,h,_,_,_=c
 return (E+((L+l*(1+L*r/(1+h*r)).log())*B/(2*ph)).root()).u

def raw(c,r):
 _,_,_,_,aq,h,er=c
 C=(1+aq*r/(1+h*r)).log()
 factor_one=C*(l+F('.002'))+aq
 factor_two=F('.30214')*l+F('.7468')
 mainterm=factor_one*factor_two/(2*ph)
 return (mainterm.root()+er).u

def main(n=128):
 # Finer near-zero bins, then .05 throughout. Both cuts2 and2.5 are edges.
 edges=[F('.05')]+[F(i,20) for i in range(2,161)]
 bins=[]
 for lo,hi in zip(edges,edges[1:]):
  bins.append((lo,hi,old.mass(lo,hi),constants(lo)))
 tail=17*F('.05')**3/3+17*F(65,8)/10**13
 results=[]
 for cut,umax in [(F('2.5'),26000),(F(2),33000)]:
  rows=[]
  for j in range(n):
   rlo=rmax*j/n;rhi=rmax*(j+1)/n
   upper=tail+sum((mass*(central(c,rhi) if hi<=cut else raw(c,rhi)) for lo,hi,mass,c in bins),F(0))
   lower=bb.LOWA*(F('.41415')+F('.27125')*(1+ar*rlo).log().l)+bb.LOWB
   gap=lower-upper
   rows.append({'j':j,'r_lo':str(rlo),'r_hi':str(rhi),'upper':str(bb.up(upper)),'lower':str(bb.down(lower)),'gap':str(bb.down(gap))})
  worst=min(rows,key=lambda x:F(x['gap']))
  result={'cut':str(cut),'u_upper':umax,'passes':all(F(r['gap'])>0 for r in rows),'worst':worst,'rows':rows}
  print(json.dumps({k:v for k,v in result.items() if k!='rows'}),flush=True);results.append(result)
 out={'status':'Exact rational compact-r certificate, conditional on analytic domination and original Type I/II producer estimates. No Lean compilation.','q':q,'y_min':str(Y),'u_min':'1200000/49','r_max':str(rmax),'r_cells':n,'w_bins':len(bins),'G1_upper':str(G1.u),'G2_upper':str(G2.u),'tail':str(tail),'results':results}
 Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
 assert all(r['passes'] for r in results)
if __name__=='__main__':main()

