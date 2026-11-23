"""Recover and verify an exact factorial-kernel certificate for the P3 paper route."""
from fractions import Fraction as F
from pathlib import Path
import json,runpy
H=Path(__file__).resolve().parent
r=json.loads((H/'resume_p3_kernel24_20261111.json').read_text());d=r['d'];m=r['m']
cs={int(j):v for j,v in r['coeff'].items()};ids=sorted(cs);k=len(ids)
pts=sorted(set(F(d*i,j) for j in range(1,m+1) for i in range(1,j+1)))
rows=[([F(j,d) for j in ids],F(1))]
for u in pts:
 a=[F((F(j,d)*u).__floor__()) for j in ids];b=F(0) if u<1 else u
 if abs(sum(float(v)*cs[j] for v,j in zip(a,ids))-float(b))<1e-7:rows.append((a,b))
basis={}
for aa,b in rows:
 a=aa+[b]
 for p,rr in sorted(basis.items()):
  v=a[p]
  if v:a=[x-v*y for x,y in zip(a,rr)]
 p=next((i for i,x in enumerate(a[:-1]) if x),None)
 if p is None:
  assert not a[-1], 'inconsistent active equations';continue
 v=a[p];a=[x/v for x in a]
 for q,rr in list(basis.items()):
  v=rr[p]
  if v:basis[q]=[x-v*y for x,y in zip(rr,a)]
 basis[p]=a
 if len(basis)==k:break
assert len(basis)==k,(len(basis),k)
coef={j:basis[i][-1] for i,j in enumerate(ids)}
assert sum(coef[j]*F(j,d) for j in ids)==1
for u in pts:
 val=sum(coef[j]*(F(j,d)*u).__floor__() for j in ids)
 assert val <= (0 if u<1 else u),(u,val)
logb=runpy.run_path(str(H.parent/'mellin'/'joint_principal_model.py'))['log_bounds']
Slo=F(0);Shi=F(0)
for j,c in coef.items():
 lo,hi=logb(F(j,d));t=c*F(j,d)
 Slo+=t*(lo if t>=0 else hi);Shi+=t*(hi if t>=0 else lo)
B=sum(abs(c) for c in coef.values())
# For x>=10000, all ax>=1. Absolute factorial residual <=1+log(ax).
# a<=3 and log3<1.1, log10000<9.211: B*(logx+2.1)/x <= B*11.311/10000.
margin=Slo-F(1)+logb(F(3))[0]-logb(F(2))[1]/2-B*F(11311,10000000)
print(json.dumps({'support':k,'points':len(pts),'max_den_digits':max(len(str(c.denominator)) for c in coef.values()),'Slo':float(Slo),'Shi':float(Shi),'B':float(B),'constant_upper':float(1-Slo),'tail_error_at10000':float(B*F(11311,10000000)),'margin_at10000':float(margin)},indent=2))
assert margin>0
out={'d':d,'m':m,'coeff':{str(j):str(c) for j,c in coef.items()},'S_lower':'0.26659','B_upper':'7','points':len(pts)}
assert Slo>F(26659,100000);assert B<7
(H/'resume_p3_exact_kernel_20261111.json').write_text(json.dumps(out,indent=2))