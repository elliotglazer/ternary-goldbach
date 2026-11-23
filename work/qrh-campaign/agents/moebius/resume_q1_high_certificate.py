"""Exact q1 high-twist raw-envelope certificate; conditional producer inputs remain.
Analytic monotonicity in t reduces u>=190000 to u=190000.
"""
from fractions import Fraction as F
from pathlib import Path
from contextlib import redirect_stdout
import io,sys,json
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/'major-constants'))
with redirect_stdout(io.StringIO()):
 import base_gap_90090_certificate as core
I=core.I;b=core.b;Y=10**25;U0=190000
v0=I(Y).log()/3+I(F(9,601200)).log();rmax=(1/v0).u
assert I(F(1,50)*Y).root(3).l>58000000
assert F(9*58000000,1)/(F('2.004')*2400000)>81
# Thus log(9 z^(1/3)/(2.004t))>4 using e<3; log t>6 since t>=950>3^6.
assert 950>3**6
assert F(2,6)+F(2,4)*(1+F('.002')/6)<1
bins=[]
for i in range(1,400):
 lo=F(i,50);hi=F(i+1,50);mass=core.mass(lo,hi)
 tlo=lo*U0/4;thi=hi*U0/4;ell=I(tlo).log()
 hr=I(F(300000)/thi).log()+I(lo).log()/3
 aq=I(4*thi).log()/2
 den_min=(1+hr*rmax).l;assert den_min>0
 # Freeze C at tmax,zmin, then raw product decreases with t at fixed C.
 aa=(ell+F('.002')).u;ab=(I(4*tlo).log()/2).u;bc=(F('.30214')*ell+F('.7468')).u/tlo
 rem=(F('2.5257')/I(tlo).root()+F('13.2')/tlo+2/tlo*(F('16.267')*ell+F('24.42'))+F('3.77')/I(lo*Y).root(6)+3*I(lo*Y).log()/(lo*Y)).u
 bins.append((mass,aq.u,hr.l,aa,ab,bc,rem))
tail=17*F('.02')**3/3+17*F(65,8)/10**13
ar=I(1200000).log()/2;rows=[]
for j in range(128):
 rlo=rmax*j/128;rhi=rmax*(j+1)/128
 total=tail
 for mass,aq,hr,aa,ab,bc,rem in bins:
  C=b.logs(1+aq*rhi/(1+hr*rhi))[1]
  main=b.root_up((aa*C+ab)*bc,2)
  total+=b.up(mass*(main+rem))
 lower=b.LOWA*(F('.41415')+F('.27125')*(1+ar*rlo).log().l)+b.LOWB
 rows.append({'rbin':j,'upper':str(b.up(total)),'lower':str(b.down(lower)),'gap':str(b.down(lower-total))})
 if j%16==15:print('r cells',j+1,flush=True)
worst=min(rows,key=lambda row:F(row['gap']))
out={'status':'Exact scalar all-scale raw certificate plus separately documented monotonicity in t; Type I/II analytic producers remain.','q':1,'u_lower':U0,'u_upper':1200000,'y_min':str(Y),'w_lower':'1/50','w_upper':8,'w_bins':399,'r_cells':128,'worst':worst,'rows':rows}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2))
print(json.dumps({k:v for k,v in out.items() if k!='rows'},indent=2))
assert all(F(row['gap'])>0 for row in rows)
