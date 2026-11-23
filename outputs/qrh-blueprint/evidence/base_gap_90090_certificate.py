"""Rational interval certificate for Q90090 parameterized small-twist bounds.
All analytic producer assumptions of the source lemmas remain separate.
"""
from fractions import Fraction as F
from math import factorial
from contextlib import redirect_stdout
from pathlib import Path
import io,json
with redirect_stdout(io.StringIO()):
 import base_gap_binned as b
def round_endpoint(q,upper=False):
 q=F(q)
 if not q:return q
 step=F(2)**(abs(q.numerator).bit_length()-q.denominator.bit_length()-80)
 z=q/step;n=z.numerator//z.denominator
 return (n+int(upper and z!=n))*step
class I:
 def __init__(self,l,u=None):
  if isinstance(l,I):self.l,self.u=l.l,l.u
  else:self.l,self.u=F(l),F(l if u is None else u)
  self.l=round_endpoint(self.l);self.u=round_endpoint(self.u,True)
  assert self.l<=self.u
 def __add__(a,c):
  c=I(c);return I(a.l+c.l,a.u+c.u)
 __radd__=__add__
 def __neg__(a):return I(-a.u,-a.l)
 def __sub__(a,c):return a+-I(c)
 def __rsub__(a,c):return I(c)+-a
 def __mul__(a,c):
  c=I(c);v=[a.l*c.l,a.l*c.u,a.u*c.l,a.u*c.u];return I(min(v),max(v))
 __rmul__=__mul__
 def __truediv__(a,c):
  c=I(c);assert c.l>0;return a*I(1/c.u,1/c.l)
 def __rtruediv__(a,c):return I(c)/a
 def __pow__(a,n):
  assert n>=0
  if n==0:return I(1)
  if a.l>=0:return I(a.l**n,a.u**n)
  return a*(a**(n-1))
 def log(a):assert a.l>0;return I(b.logs(a.l)[0],b.logs(a.u)[1])
 def root(a,k=2):
  assert a.l>=0
  return I(max(F(0),b.root_up(a.l,k)-F(1,b.SCALE)),b.root_up(a.u,k))
 def floor(a):return I(a.l.numerator//a.l.denominator,a.u.numerator//a.u.denominator)
 def max(a,c):c=I(c);return I(max(a.l,c.l),max(a.u,c.u))
 def lp(a):return a.log().max(0)
def atan_bounds(x,n=30):
 s=sum(((-1)**j*x**(2*j+1)/F(2*j+1) for j in range(n)),F(0))
 t=(-1)**n*x**(2*n+1)/F(2*n+1)
 return I(min(s,s+t),max(s,s+t))
pi=16*atan_bounds(F(1,5))-4*atan_bounds(F(1,239))
es=sum((F(1,factorial(j)) for j in range(31)),F(0));e=I(es,es+F(1,factorial(31))*F(32,31))
q=90090;ph=17280;ratio=F(q,ph);c0=32;etaL=8*I(2).log();c2=6*pi/(5*I(32).root())

assert F(65000,q)<(1/(2*c2)).l
def parameter(z):
 T=z.root(3);H=F(3,4)*T**2;V=(72*T).floor();U=(T**2/(144*I(2*q).root())).floor()
 assert z.l>=1 and U.l>=I(3).root().u and U.u<=z.l/4 and U.u<=(z/e).l and U.u<=H.l/2
 assert q*V.u<=H.l and 16*V.u<=H.l and V.l>=25000000
 assert (U*V).u<=z.l and V.u<=z.l/4 and F('3.5')*(z/U).u<=H.l
 assert (2*e*q).u<=V.l and q<=H.l and 65000*H.u<=z.l
 assert (V/(2*q)).l>1 and (z/U/(2*q)).l>1
 # muBound<=1, minInv<=1, logFourierBound<=2-log4 throughout the input band.
 c1=1+etaL*U/z
 err=2*(32*c1).root()/pi*U*(e*z/U).log()+F('1.5')*c1*z/q*(U/(c2*z/q)).lp()*(q/c2).log()+(2*etaL/pi*(32*e**3*q*q/(4*pi*etaL*z)).log().max(1)*z.log()+2*(32*c1).root()/pi*(I(3).root()+F('.5')*(2*U/q).lp())*(q/c2).log())*q+F('1.5')*c1*(2*z/c2).root()*(2*z/c2).log()+20*32*c2*c2.root()/(3*pi**2)*(2*z).root()*(2*e*z/c2).log()
 i1=z/(2*q)*(ratio+F('2.67')+(z/U).log())+z/(2*q)*(2-I(4).log())+32*(F('.5')-2/pi**2)*(U**2/(4*q*z)*(e.root()*z/U).log()+1/e)+err
 cp=1+etaL*U*V/z
 cuv=2*(32*cp).root()/pi+3*cp/(2*c2*e)
 cq=(32*cp).root()/pi*((2*U/q).lp()+1/e)+2*etaL/pi*(32*e**3*q*q*V/(4*pi*etaL*z)).log().max(1)+2*(3*32*cp).root()/pi+3*cp/(2*c2)+55*32*c2/(6*pi**2)
 i2=z/(2*q)*(V*q).log()+32*(F('.125')-1/(2*pi**2))/z*(U**2/q*(F('.511')*V**2+V*q*I(q).log())+(2*U+q)*F('.511')*V**2)+F('1.0064')*cuv*U*V+F('1.0064')*cq*H
 lam=(z/(U*V)).log();Phi=I(2*q).log()*((z/U/(2*q)).log()/(V/(2*q)).log()).log()
 K=2/pi**2+27*(z/V).root()/U
 main=((lam+Phi)*(F('.60428')*lam+F('.0924')+216*(z/V).root()/U)).root()/I(2*ph).root()
 rest=4*(K*q/(2*ph*z)).root()*(2*(z/U).root()+I(2*q).log().root()*(2*e*I(2*q).root()+4*((z/U)/(z/U/(2*q)).log()).root()))+8*F('1.4262')*(K*(F('.5')+1/U)).root()/V.root()
 return [(i1/z).u,(i2/z).u,main.u,rest.u,(3*z.log()/z).u]

def raw(z):
 t=I(2*q);ell=t.log();C=(1+(4*t).log()/(2*(9*z.root(3)/(F('2.004')*t)).log())).log()
 return ((ratio/t).root()*(((C+F('.5'))*ell+F('.002')*C+I(2).log())*(F('.30214')*ell+F('.7468'))).root()+F('2.5257')/t.root()+(F('13.2')*ratio+2*(F('16.267')*ell+F('24.42')))/t+F('3.77')/z.root(6)+3*z.log()/z).u

def mass(l,u):
 h=u-l
 return b.up(h/6*(b.phi_up(l)+4*b.phi_up((l+u)/2)+b.phi_up(u))+84*h**5/2880)

def certificate(ymult):
 Y=10**25;ys=I(Y,Y*ymult);parts=[F(0)]*5;high=F(0)
 for i in range(2,100):
  l=F(i,40);u=F(i+1,40);vals=parameter(I(l,u)*ys);m=mass(l,u)
  parts=[s+m*v for s,v in zip(parts,vals)]
 for i in range(50,160):
  l=F(i,20);u=F(i+1,20);high+=mass(l,u)*raw(I(l,u)*ys)
 tail=17*F('.05')**3/3+17*F(65,8)/10**13
 r=(1+I(1200000).log()/(2*(9*ys.root(3)/601200).log())).log()*F('.27125')+F('.41415')
 lower=b.LOWA*r.l+b.LOWB;upper=sum(parts)+high+tail;gap=lower-upper
 return dict(y_lower=str(Y),y_upper=str(Y*ymult),central_upper=[str(b.up(s)) for s in parts],high_upper=str(b.up(high)),tail=str(tail),total_upper=str(b.up(upper)),ghat_lower=str(b.down(lower)),gap_lower=str(b.down(gap)),gap_diagnostic=float(gap),passes=gap>0)
if __name__=='__main__':
 results=[certificate(F('1.01')),certificate(F('1.05')),certificate(F('1.1'))]
 assert all(r['passes'] for r in results)
 out=dict(status='Exact rational finite scale rectangle; analytic source hypotheses remain separate; no all-y conclusion.',q=q,u_lower='1200000/49',u_upper=26000,results=results)
 Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
 print(json.dumps(out,indent=2))



