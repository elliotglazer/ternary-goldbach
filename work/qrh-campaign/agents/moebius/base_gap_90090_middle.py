"""Floating diagnostics only. No interval or quadrature certification.
Full Type I/II source formulas below the small-delta cutoff, old raw above.
"""
import ast, contextlib, io, json, math, runpy
from pathlib import Path
HERE=Path(__file__).resolve().parent
model=runpy.run_path(str(HERE/'base_gap_90090_parameters.py'))
formula=model['formula']; q=model['q']; ph=model['ph']; c2=model['c2']
# Extract the exact saved raw function without executing its exploratory scans.
tree=ast.parse((HERE/'base_gap_typeii_numeric.py').read_text())
ns={'math':math,'Y':1e25}
exec(compile(ast.Module(body=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='bound'],type_ignores=[]),'<saved bound>','exec'),ns)
raw=lambda z,t:ns['bound'](q,t,y=z,ph=ph)[1]
WLO=.05; WHI=8.; GAMMA=.5772156649015328606
TAIL=17*WLO**3/3+17*(WHI+1/WHI)*math.exp(-WHI**2/2)
K=q/(2*c2)
def R(y,t):return .41415+.27125*math.log1p(math.log(4*t)/(2*math.log(9*y**(1/3)/(2.004*t))))
def ghat(y):
 r=150000.;t=2*r;fr=math.exp(GAMMA)*math.log(math.log(r))+2.50637/math.log(math.log(r))
 lg=fr*(3.25*math.log(t)+7.82)+13.66*math.log(t)+37.55
 gx=((R(y,t)*math.log(t)+.8764)*math.sqrt(fr)+2.526)/math.sqrt(t)+lg/r+3.8*y**(-1/6)
 h=.276*y**(-1/6)*math.log(y)**1.5+1234*y**(-1/3)*math.log(y)
 return 1.398*max(gx,h)+17*(670/r)**3/3

def simpson(fn,a,b,n):
 if b<=a:return 0.
 h=(b-a)/n
 return h/3*sum((1 if i in (0,n) else 4 if i%2 else 2)*fn(a+i*h) for i in range(n+1))
def weight(w):return w*w*math.exp(-w*w/2)
def evaluate(u,vf=16.,pf=1.,y=1e25,n=1000):
 cut=min(WHI,K/u);cut=max(WLO,cut)
 # Inside this interval both Fourier min branches are constant. Delta=0
 # evaluates their exact values while avoiding a rounded endpoint rejection.
 small=simpson(lambda w:sum(formula(w*y,0.,vf,pf)[0])*weight(w),WLO,cut,n)
 transition=8*q/u
 knots=sorted(set([cut,WHI]+([transition] if cut<transition<WHI else [])))
 high=sum(simpson(lambda w:raw(w*y,max(2*q,w*u/4))*weight(w),a,b,n) for a,b in zip(knots,knots[1:]))
 return {'u':u,'V_multiplier':vf,'UV_multiplier':pf,'y':y,'w_cut':cut,'small':small,'raw_above':high,'tails':TAIL,'total':small+high+TAIL,'ghat':ghat(y),'slack':ghat(y)-small-high-TAIL}

def bisect_zero(a,b,vf,y=1e25,n=1500):
 fa=evaluate(a,vf,y=y,n=n)['slack']
 for _ in range(35):
  m=(a+b)/2;fm=evaluate(m,vf,y=y,n=n)['slack']
  if fm*fa>0:a=m;fa=fm
  else:b=m
 return (a+b)/2

if __name__=='__main__':
 us=[26000,28000,30000,32000,35000,40000,45000,50000,60000,75000,90000,100000,125000,150000,200000,250000,300000,350000,400000,450000,500000,538776]
 multipliers=[1,4,16,64,128]
 rows=[evaluate(u,vf,n=1000) for u in us for vf in multipliers]
 # Test product changes on selected difficult twists, without replacing full formula.
 products=[evaluate(u,vf,pf,n=1000) for u in [35000,40000,50000,75000,150000,300000] for vf in [16,64,128] for pf in [.5,.75,1.,1.5,2.]]
 ys=[evaluate(u,vf,y=10.**e,n=1000) for e in [25,30,40,60] for u in [26000,30000,35000,40000,75000,150000,300000,450000,500000,538776] for vf in [16,128]]
 crossings=[{'V_multiplier':vf,'low_crossing':bisect_zero(26000,50000,vf),'high_crossing':bisect_zero(300000,538776,vf)} for vf in multipliers]
 refinement=[evaluate(u,128,n=n) for u in [35000,40000,150000,450000,500000] for n in [1000,2000,4000]]
 result={'status':'Floating diagnostics only. Source inputs retain their original analytic obligations. No all-y proof or certified quadrature.', 'cutoff_constant':K,'ghat_at_Y':ghat(1e25),'tail_bound':TAIL,'rows':rows,'product_variations':products,'y_samples':ys,'crossings':crossings,'quadrature_refinement':refinement}
 (HERE/'base_gap_90090_middle_results.json').write_text(json.dumps(result,indent=2))
 print(json.dumps({k:result[k] for k in ['status','cutoff_constant','ghat_at_Y','tail_bound','crossings']},indent=2))
 for u in us:
  rr=[r for r in rows if r['u']==u];best=min(rr,key=lambda r:r['total'])
  print(u, 'cut',round(best['w_cut'],6),'totals',*[round(r['total'],9) for r in rr],'best_slack',round(best['slack'],9))
 print('best products')
 for u in [35000,40000,50000,75000,150000,300000]:
  print(min((r for r in products if r['u']==u),key=lambda r:r['total']))
 print('y sample worst slacks')
 for e in [25,30,40,60]:
  print(e,[(u,round(min((r for r in ys if r['u']==u and r['y']==10.**e),key=lambda r:r['total'])['slack'],9)) for u in [26000,30000,35000,40000,75000,150000,300000,450000,500000,538776]])
