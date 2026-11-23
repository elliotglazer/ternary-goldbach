"""Diagnostic of analytically uniform all-scale envelopes; not a certificate."""
import math,json
from pathlib import Path
q=90090;ph=17280;Y=1e25;eps=1e-8
l=math.log(2*q);a=1/(144*math.sqrt(2*q));b=72.;al=a*(1-eps);be=b*(1-eps);p=a*b
M=2.8*q/ph;eta=8*math.log(2);pi=math.pi;e=math.e;c2=6*pi/(5*math.sqrt(32))
d=math.log(9/601200);ar=math.log(1200000)/2;rmax=1/(math.log(Y)/3+d)
G1=M/2-1.5*math.log(al)+.5*math.log(2*q*q)
G2=M+math.log(384*q*q)+math.log(b*q)

def envelope(w):
 T=(w*Y)**(1/3);s=math.log(T)
 assert eps*a*T*T>=1 and eps*b*T>=1
 assert al*T>=1/192 and a*q/(c2*T)<1
 assert 32*e**3*q*q/(4*pi*eta*T**3)<e and 32*e**3*q*q*b/(4*pi*eta*T*T)<e
 assert 2*a*T*T/q>1
 c1=1+eta*a/T;cp=1+eta*p
 err=2*math.sqrt(32*c1)/pi*a/T*math.log(e*T/al)
 err+=q/T**3*(2*eta/pi*3*s+2*math.sqrt(32*c1)/pi*(math.sqrt(3)+.5*math.log(2*a*T*T/q))*math.log(q/c2))
 err+=1.5*c1*math.sqrt(2/c2)/T**1.5*math.log(2*T**3/c2)+20*32*c2**1.5/(3*pi*pi)*math.sqrt(2)/T**1.5*math.log(2*e*T**3/c2)
 i1=(q/ph+2.67+G1+2-math.log(4))/(2*q)+32*(.5-2/pi**2)*(a*a/(4*q*T*T)*math.log(math.sqrt(e)*T/al)+1/(e*T**3))+err
 cuv=2*math.sqrt(32*cp)/pi+3*cp/(2*c2*e)
 cq=math.sqrt(32*cp)/pi*(math.log(2*a*T*T/q)+1/e)+2*eta/pi+2*math.sqrt(3*32*cp)/pi+3*cp/(2*c2)+55*32*c2/(6*pi*pi)
 i2=G2/(2*q)+32*(.125-1/(2*pi*pi))*(.511*p*p/q+a*a*b*math.log(q)/T+1.022*a*b*b/T**2+.511*q*b*b/T**4)+1.0064*cuv*p+1.0064*.75*cq/T
 kap=2/pi**2+27/(al*math.sqrt(be)*T)
 rest=4*math.sqrt(kap*q/(2*ph))*(2/(math.sqrt(al)*T)+math.sqrt(l)*(2*e*math.sqrt(2*q)/T**1.5+4/(math.sqrt(al)*T*math.sqrt(math.log(T/(2*q*a))))))+8*1.4262*math.sqrt(kap*(.5+1/(al*T*T)))/math.sqrt(be*T)
 L=math.log(1/(al*be));B=.60428*L+.0924+216/(al*math.sqrt(be)*T)
 h=math.log(be/(2*q))+math.log(w)/3-d
 return i1+i2+rest+9*s/T**3,L,B,h

def central(w,r):
 E,L,B,h=envelope(w)
 return E+math.sqrt((L+l*math.log1p(L*r/(1+h*r)))*B/(2*ph))
def raw(w,r):
 aq=math.log(8*q)/2;h=math.log(300000/(2*q))+math.log(w)/3
 C=math.log1p(aq*r/(1+h*r));z=w*Y
 return math.sqrt((C*(l+.002)+math.log(8*q)/2)*(.30214*l+.7468)/(2*ph))+2.5257/math.sqrt(2*q)+13.2/(2*ph)+(16.267*l+24.42)/q+3.77*z**(-1/6)+3*math.log(z)/z
LOWA=.0749564247688777;LOWB=.016078319462795997

def simpson(f,lo,hi,n=600):
 h=(hi-lo)/n
 return h/3*sum((1 if i in (0,n) else 4 if i%2 else 2)*f(lo+i*h)*(lo+i*h)**2*math.exp(-(lo+i*h)**2/2) for i in range(n+1))
def bound(r,cut=2.5):
 up=simpson(lambda w:central(w,r),.05,cut)+simpson(lambda w:raw(w,r),cut,8)+17*.05**3/3+17*(65/8)*1e-13
 low=LOWA*(.41415+.27125*math.log1p(ar*r))+LOWB
 return low-up,up,low
if __name__=='__main__':
 print('G1,G2,rmax',G1,G2,rmax)
 results=[]
 for cut in [2.5,2.0,1.9]:
  rows=[(rmax*j/200,*bound(rmax*j/200,cut)) for j in range(201)]
  worst=min(rows,key=lambda x:x[1]);print('cut',cut,'worst',worst,'ends',rows[0],rows[-1]);results.append({'cut':cut,'worst':worst,'ends':[rows[0],rows[-1]]})
 Path(__file__).with_suffix('.json').write_text(json.dumps(results,indent=2))
