"""Source-formula floating diagnostic; no certified numerical conclusions."""
import math,json
from pathlib import Path
q=90090;ph=17280;f=q/ph;Y=1e25;c0=32.;c2=6*math.pi/(5*math.sqrt(c0));etaL=8*math.log(2)
def lp(x):return max(math.log(x),0.)
def mu(U):return min(1.,2.8*f/math.log(U/(2*q*q))) if U>2*q*q else 1.
def formula(z,delta,vfactor=1.,uvfactor=1.):
 T=z**(1/3);height=.75*T*T;t=2*q
 V=math.floor(vfactor*4.5*T);U=math.floor(uvfactor*T*T/(9*math.sqrt(t))/vfactor)
 assert U>=math.sqrt(3) and U<=min(z/4,z/math.e,height/2)
 assert q*V<=height and 16*V<=height and V>=2.5e7 and U*V<=z and V<=z/4
 assert abs(delta)<=1/(2*c2)
 assert 3.5*z/U<=height and 2*math.e*q<=V
 assert abs(delta)*q*height<=z
 mi=min(1,c0/(math.pi*delta)**2) if delta else 1
 lf=min(2-math.log(4),96*math.log(2)/(math.pi*delta)**2) if delta else 2-math.log(4)
 c1=1+etaL*U/z
 err441=2*math.sqrt(c0*c1)/math.pi*U*math.log(math.e*z/U)+1.5*c1*z/q*lp(U/(c2*z/q))*math.log(q/c2)+(2*etaL/math.pi*max(1,math.log(c0*math.exp(3)*q*q/(4*math.pi*etaL*z)))*math.log(z)+2*math.sqrt(c0*c1)/math.pi*(math.sqrt(3)+.5*lp(2*U/q))*math.log(q/c2))*q+1.5*c1*math.sqrt(2*z/c2)*math.log(2*z/c2)+20*c0*c2**1.5/(3*math.pi**2)*math.sqrt(2*z)*math.log(2*math.e*z/c2)
 I1=z/(2*q)*mi*(f+2.67+math.log(z/U)*mu(U))+z/(2*q)*lf*mu(U)+c0*(.5-2/math.pi**2)*(U*U/(4*q*z)*math.log(math.sqrt(math.e)*z/U)+1/math.e)+err441
 cp=1+etaL*U*V/z
 cuv=2*math.sqrt(c0*cp)/math.pi+3*cp/(2*c2*math.e)
 cq=math.sqrt(c0*cp)/math.pi*(lp(2*U/q)+1/math.e)+2*etaL/math.pi*max(1,math.log(c0*math.exp(3)*q*q*V/(4*math.pi*etaL*z)))+2*math.sqrt(3*c0*cp)/math.pi+3*cp/(2*c2)+55*c0*c2/(6*math.pi**2)
 I2=z/(2*q)*mi*mu(min(height/(2*V),U))*math.log(V*q)+c0*(.125-1/(2*math.pi**2))/z*(U*U/q*(.511*V*V+V*q*math.log(q))+(2*U+q)*(.511*V*V))+1.0064*cuv*U*V+1.0064*cq*height
 lam=math.log(z/(U*V));Phi=math.log(2*q)*math.log(math.log(z/U/(2*q))/math.log(V/(2*q)))
 zeta=27.;kap=2/math.pi**2+zeta*math.sqrt(z/V)/U
 II_main=z/math.sqrt(2*ph)*math.sqrt((lam+Phi)*(.60428*lam+.0924+8*zeta*math.sqrt(z/V)/U))
 II_rest=4*math.sqrt(kap*q*z/(2*ph))*(2*math.sqrt(z/U)+math.sqrt(math.log(2*q))*(2*math.e*math.sqrt(2*q)+4*math.sqrt(z/U/math.log(z/U/(2*q)))))+8*1.4262*z*math.sqrt(kap*(.5+1/U))/math.sqrt(V)
 return [I1/z,I2/z,II_main/z,II_rest/z,3*math.log(z)/z], {'U':U,'V':V,'UV/z':U*V/z,'Q_over_qV':height/(q*V),'zeta_correction':8*zeta*math.sqrt(z/V)/U,'lambda':lam,'Phi':Phi}
if __name__=='__main__':
 rows=[]
 for vf in [1,2,4,8,16,32,64,100,200]:
  try:
   vals,meta=formula(Y,1200000/(49*q),vf)
   rows.append({'V_multiplier':vf,'components':vals,'sum':sum(vals),**meta})
  except AssertionError:pass
 print(json.dumps(rows,indent=2));Path(__file__).with_name('base_gap_90090_parameters_results.json').write_text(json.dumps(rows,indent=2))

# Full source-formula integration on the small-twist band. This is floating
# Simpson evidence only, with analytic trivial tails explicitly added.
def integrated_candidates(N=4000):
 import contextlib,io,runpy
 with contextlib.redirect_stdout(io.StringIO()):
  prior=runpy.run_path(str(Path(__file__).with_name('base_gap_typeii_numeric.py')))
 def integ(fn,a,b):
  h=(b-a)/N
  return h/3*sum((1 if i in (0,N) else 4 if i%2 else 2)*fn(a+i*h) for i in range(N+1))
 weight=lambda w:w*w*math.exp(-w*w/2)
 delta=1200000/(49*q)
 old=lambda w:prior['bound'](q,2*q,y=w*Y)[1]*weight(w)
 high=integ(old,2.5,8)
 tail=17*.05**3/3+17*(8+1/8)*math.exp(-32)
 output=[]
 for vf in [1,4,16,64]:
  parts=[integ(lambda w:formula(w*Y,w*delta,vf)[0][j]*weight(w),.05,2.5) for j in range(5)]
  output.append({'V_multiplier':vf,'central_components':parts,'upper_w_raw_contribution':high,'trivial_tails':tail,'total':sum(parts)+high+tail})
 return {'warning':'Floating Simpson diagnostics; no quadrature remainder or all-y certificate. Source assumptions retained.', 'panels_per_interval':N,'old_raw_with_same_tails':integ(old,.05,8)+tail,'candidates':output}
if __name__=='__main__':
 integrated=integrated_candidates()
 print(json.dumps(integrated,indent=2))
 Path(__file__).with_name('base_gap_90090_integrated_results.json').write_text(json.dumps(integrated,indent=2))
