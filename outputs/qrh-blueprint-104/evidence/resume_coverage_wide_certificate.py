"""Exact rational all-scale certificate for the q rectangle with every permitted twist.
Uses the full source TypeI2_le_small and TypeI2_le_large with epsilon3/100. Upstream analytic
producer inputs remain conditions. No Lean theorem is claimed.
"""
from fractions import Fraction as F
from pathlib import Path
import sys,json
from functools import lru_cache
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE))
import resume_minor_allscale_certificate as core
I=core.I;bb=core.bb;pi=core.pi;e=core.e
Q0=90090;Q1=100000;MAXR=F(1001,192);Y0=10**25;Y=Y0
q=I(Q0,Q1);ph=F(Q0)/MAXR;eps=core.eps
# Fixed U coefficient at Q0; the source general lemmas allow this for all q.
a=1/(1152*I(2*Q0).root());b=I(576)
al=a*(1-eps);be=b*(1-eps);p=a*b
M=I(F('2.8')*MAXR)
G1=M/2-F('1.5')*al.log()+I(2*q*q).log()/2
G2=M+(16*b*q*q/3).log()+(b*q).log()
eta=core.eta;c2=core.c2;ep=F(3,100);cp=1+eta*p;d=core.d
K=q/(2*c2);l=I(2*q).log();L=(1/(al*be)).log()
baseC=2*(32*cp).root()/pi
Dcoeff=baseC*(1+ep)*I(3+2*ep).root()
A0=F('1.0064')*baseC*(1+(1+ep)/e)*p
A1=F('1.0064')*baseC*(1+ep)/e*p*(4*b/3)
A1+=F('1.0064')*(35*32*c2/(3*pi**2))*F(3,4)
C2=Dcoeff*F('1.0064')*b
assert I(F(1,20)*Y0).root(3).l>768*Q1
assert (F('1.03883')+I(q).log()).l>1
UEDGES=[F(1200000,49)]+list(map(F,[33000,40000,50000,65000,85000,110000,150000,250000,400000]))+[F(26400000,49),F(1200000)]

def phi(n):
 out=n;remaining=n;prime=2
 while prime*prime<=remaining:
  if remaining%prime==0:
   out=out//prime*(prime-1)
   while remaining%prime==0:remaining//=prime
  prime+=1
 if remaining>1:out=out//remaining*(remaining-1)
 return out
TOTIENT_ROWS=[]
for integer_q in range(Q0,Q1+1):
 phi_q=phi(integer_q);phi_2q=phi(2*integer_q)
 assert F(integer_q,phi_q)<=MAXR and F(2*integer_q,phi_2q)<=MAXR
 TOTIENT_ROWS.append([integer_q,phi_q,phi_2q])

# Same analytic core with interval q and the separately certified ratio2q bound.
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
 i1=(MAXR+F('2.67')+G1+2-I(4).log())/(2*q)+32*(F('.5')-2/pi**2)*(a*a/(4*q*T**2)*(e.root()*T/al).log()+1/(e*T**3))+err
 cuv=2*(32*cp).root()/pi+3*cp/(2*c2*e)
 cq=(32*cp).root()/pi*((2*a*T**2/q).log()+1/e)+2*eta/pi+2*(3*32*cp).root()/pi+3*cp/(2*c2)+55*32*c2/(6*pi**2)
 i2=G2/(2*q)+32*(F('.125')-1/(2*pi**2))*(F('.511')*p*p/q+a*a*b*I(q).log()/T+F('1.022')*a*b*b/T**2+F('.511')*q*b*b/T**4)+F('1.0064')*cuv*p+F('1.0064')*F('.75')*cq/T
 kap=2/pi**2+27/(al*be.root()*T)
 rest=4*(kap*q/(2*ph)).root()*(2/(al.root()*T)+l.root()*(2*e*I(2*q).root()/(T*T.root())+4/(al.root()*T*(T/(2*q*a)).log().root())))+8*F('1.4262')*(kap*(F('.5')+1/(al*T**2))).root()/(be*T).root()
 L=(1/(al*be)).log();B=F('.60428')*L+F('.0924')+216/(al*be.root()*T)
 h=(be/(2*q)).log()+I(w).log()/3-d
 E=i1+i2+rest+9*s/T**3
 assert h.l>0 and L.l>0
 aq=I(8*q).log()/2;hr=(I(300000)/(2*q)).log()+I(w).log()/3
 er=F('2.5257')/I(2*q).root()+F('13.2')/(2*ph)+(F('16.267')*l+F('24.42'))/q+F('3.77')/I(w*Y).root(6)+3*I(w*Y).log()/(w*Y)
 assert hr.l>0 if w>=2 else True
 return E,L,B,h,aq,hr,er

def smallrest(T):
 cuv=baseC+3*cp/(2*c2*e)
 cq=(32*cp).root()/pi*((2*a*T**2/q).log()+1/e)+2*eta/pi+2*(3*32*cp).root()/pi+3*cp/(2*c2)+55*32*c2/(6*pi**2)
 return F('1.0064')*cuv*p+F('1.0064')*F(3,4)*cq/T

def large_coeffs(lo,hi,u0,u1):
 dlo=max(K.l,lo*u0);dhi=hi*u1
 constant=A0+Dcoeff*(F('1.03883')+I(q).log()+(6*p*dlo/I(2).root()).lp())/dlo
 linear=A1+F('1.0064')*F('1.5')*cp*(2+(1+ep)/ep*(2*p*dhi).lp())*(4*b/3)
 return constant.u,linear.u,C2.u

@lru_cache(None)
def scale_constants(k,lo):
 global Y
 Y=Y0*2**(3*k)
 E,_,B,_,_,_,_=constants(lo)
 T=I(lo*Y).root(3)
 sm=smallrest(T)
 return E-sm,B,T,sm

def main(nr=128):
 bins=[]
 for i in range(1,160):
  lo=F(i,20);hi=F(i+1,20);mass=core.old.mass(lo,hi)
  choices=[]
  for u0,u1 in zip(UEDGES,UEDGES[1:]):
   small_possible=lo*u0<=K.u;large_possible=hi*u1>=K.l
   choices.append((small_possible,large_coeffs(lo,hi,u0,u1) if large_possible else None))
  h=(be/(2*q)).log()+I(lo).log()/3-core.d
  assert h.l>0
  bins.append((lo,hi,mass,h,choices))
 rows=[[] for _ in range(len(UEDGES)-1)]
 ln2hi=I(2).log().u
 tail=17*F('.05')**3/3+17*F(65,8)/10**13
 for j in range(nr):
  rlo=core.rmax*j/nr;rhi=core.rmax*(j+1)/nr
  diff=1/rhi-core.v0.u
  ratio=diff/ln2hi
  k=max(0,min(8,ratio.numerator//ratio.denominator))
  if k:assert k*ln2hi<=diff
  totals=[tail for _ in rows]
  for lo,hi,mass,h,choices in bins:
   common,B,T,sm=scale_constants(k,lo)
   mainterm=((L+l*(1+L*rhi/(1+h*rhi)).log())*B/(2*ph)).root()
   base=(common+mainterm).u
   for idx,(small_possible,coeffs) in enumerate(choices):
    candidates=[sm.u] if small_possible else []
    if coeffs is not None:
     c0,c1,c2=coeffs;candidates.append(c0+c1/T.l+c2/T.l**2)
    assert candidates
    totals[idx]+=bb.up(mass*(base+max(candidates)))
  lower=bb.LOWA*(F('.41415')+F('.27125')*(1+core.ar*rlo).log().l)+bb.LOWB
  for idx,total in enumerate(totals):
   rows[idx].append({'rbin':j,'scale_power':k,'rlo':str(rlo),'rhi':str(rhi),'upper':str(bb.up(total)),'lower':str(bb.down(lower)),'gap':str(bb.down(lower-total))})
  if j%16==15:print('completed r cells',j+1,flush=True)
 results=[]
 for u0,u1,rr in zip(UEDGES,UEDGES[1:],rows):
  worst=min(rr,key=lambda r:F(r['gap']))
  result={'u0':str(u0),'u1':str(u1),'passes':all(F(r['gap'])>0 for r in rr),'worst':worst,'rows':rr}
  results.append(result);print(json.dumps({k:v for k,v in result.items() if k!='rows'}),flush=True)
 out={'status':'Exact rational all-scale envelope certificate. Analytic source producer obligations remain; no Lean proof.','q_lower':Q0,'q_upper':Q1,'totient_ratio_upper':str(MAXR),'totient_rows':TOTIENT_ROWS,'y_min':str(Y0),'parameter_multiplier':128,'typeI2_epsilon':str(ep),'r_cells':nr,'w_bins':len(bins),'u_cells':len(results),'results':results}
 Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
 assert all(r['passes'] for r in results)
if __name__=='__main__':main()
