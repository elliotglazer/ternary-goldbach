"""Exact rational all-scale certificate for the remaining q90090 twist band.
Uses the full source TypeI2_le_large with epsilon3/100. Upstream analytic
producer inputs remain conditions. No Lean theorem is claimed.
"""
from fractions import Fraction as F
from pathlib import Path
import sys,json
from functools import lru_cache
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE))
import resume_minor_allscale_certificate as core
I=core.I;bb=core.bb;pi=core.pi;e=core.e;q=core.q;ph=core.ph;Y=10**25
# Change only this imported module's in-memory parameter constants. The reviewed
# earlier file remains unchanged. P128 has U=floor(T²/(1152sqrt(2q))), V=floor576T.
core.a=1/(1152*I(2*q).root());core.b=I(576)
core.al=core.a*(1-core.eps);core.be=core.b*(1-core.eps);core.p=core.a*core.b
core.G1=core.M/2-F('1.5')*core.al.log()+I(2*q*q).log()/2
core.G2=core.M+(16*core.b*q*q/3).log()+(core.b*q).log()
a,b,al,be,p=core.a,core.b,core.al,core.be,core.p
eta=core.eta;c2=core.c2;ep=F(3,100);cp=1+eta*p
K=q/(2*c2);l=I(2*q).log();L=(1/(al*be)).log()
baseC=2*(32*cp).root()/pi
Dcoeff=baseC*(1+ep)*I(3+2*ep).root()
A0=F('1.0064')*baseC*(1+(1+ep)/e)*p
A1=F('1.0064')*baseC*(1+ep)/e*p*(4*b/3)
A1+=F('1.0064')*(35*32*c2/(3*pi**2))*F(3,4)
C2=Dcoeff*F('1.0064')*b
assert (I(F(1,20)*Y).root(3)).l>768*q
assert (F('1.03883')+I(q).log()).l>1
UEDGES=list(map(F,[33000,40000,50000,65000,85000,110000,150000,250000,400000]))+[F(26400000,49)]

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
 core.Y=Y*2**(3*k)
 E,_,B,_,_,_,_=core.constants(lo)
 T=I(lo*core.Y).root(3)
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
 out={'status':'Exact rational all-scale envelope certificate. Analytic source producer obligations remain; no Lean proof.','q':q,'y_min':str(Y),'parameter_multiplier':128,'typeI2_epsilon':str(ep),'r_cells':nr,'w_bins':len(bins),'u_cells':len(results),'results':results}
 Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
 assert all(r['passes'] for r in results)
if __name__=='__main__':main()
