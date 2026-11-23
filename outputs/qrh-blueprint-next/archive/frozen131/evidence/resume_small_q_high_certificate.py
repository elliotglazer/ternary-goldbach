"""Exact all-scale raw high-twist rectangles for reduced denominators2..39.
Uses the reviewed q1 monotonicity and exact Q/phi(Q), not even-q identities.
Original Type I/II producer conditions remain. No Lean proof is claimed.
"""
from fractions import Fraction as F
from pathlib import Path
from contextlib import redirect_stdout
import io,sys,json,math
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/'major-constants'))
with redirect_stdout(io.StringIO()):
 import base_gap_90090_certificate as core
I=core.I;b=core.b;Y=10**25;NR=32
v0=I(Y).log()/3+I(F(9,601200)).log();rmax=(1/v0).u
assert I(F(1,50)*Y).root(3).l>58000000
assert F(9*58000000)/(F('2.004')*2400000)>81
assert 1500>3**6 and F(2,6)+F(2,4)*(1+F('.002')/6)<1
assert 2*39<1500
phi=lambda q:sum(math.gcd(k,q)==1 for k in range(1,q+1))
phi_rows=[{'q':q,'phi':phi(q),'phi2q':phi(2*q),'ratio':str(F(q,phi(q))),'typeI_ratio':str(F(2*q,phi(2*q)))} for q in range(2,40)]
assert all(F(row['ratio'])<=F(15,4) for row in phi_rows)
# The two source ratios are separately recorded; only the reduced ratio enters
# the already specialized raw RHS. We do not substitute typeI_ratio for ratio.
masses=[]
for i in range(1,400):
 lo=F(i,50);hi=F(i+1,50);masses.append((lo,hi,core.mass(lo,hi)))
tail=17*F('.02')**3/3+17*F(65,8)/10**13
ar=I(1200000).log()/2

def certify(Fmax,U0):
 bins=[]
 for lo,hi,mass in masses:
  tlo=lo*U0/4;thi=hi*U0/4;ell=I(tlo).log()
  hr=I(F(300000)/thi).log()+I(lo).log()/3;aq=I(4*thi).log()/2
  assert (1+hr*rmax).l>0
  aa=(ell+F('.002')).u;ab=(I(4*tlo).log()/2).u;bc=(F('.30214')*ell+F('.7468')).u*Fmax/tlo
  rem=(F('2.5257')/I(tlo).root()+F('13.2')*Fmax/tlo+2/tlo*(F('16.267')*ell+F('24.42'))+F('3.77')/I(lo*Y).root(6)+3*I(lo*Y).log()/(lo*Y)).u
  bins.append((mass,aq.u,hr.l,aa,ab,bc,rem))
 rows=[]
 for j in range(NR):
  rlo=rmax*j/NR;rhi=rmax*(j+1)/NR;total=tail
  for mass,aq,hr,aa,ab,bc,rem in bins:
   C=b.logs(1+aq*rhi/(1+hr*rhi))[1]
   main=b.root_up((aa*C+ab)*bc,2)
   total+=b.up(mass*(main+rem))
  lower=b.LOWA*(F('.41415')+F('.27125')*(1+ar*rlo).log().l)+b.LOWB
  rows.append({'rbin':j,'upper':str(b.up(total)),'lower':str(b.down(lower)),'gap':str(b.down(lower-total))})
  if j%8==7:print('F',Fmax,'U',U0,'r cells',j+1,flush=True)
 worst=min(rows,key=lambda row:F(row['gap']))
 return {'Fmax':str(Fmax),'u_lower':U0,'u_upper':1200000,'passes':all(F(row['gap'])>0 for row in rows),'worst':worst,'rows':rows}
results=[certify(F(2),300000),certify(F(15,4),600000)]
family=json.loads((HERE.parent/'zero-sum'/'resume_base_gap_finite_family_20261111.json').read_text())
sample={row['q']:row for row in family['samples']}
joins=[]
for q in family['full_gap_failures']:
 if q==1 or q>39:continue
 f=F(q,phi(q));high=300000 if f<=2 else 600000
 prefix=sample[q]['u_prefix_integer'];assert high<=prefix
 joins.append({'q':q,'phi':phi(q),'ratio':str(f),'finite_prefix':prefix,'high_start':high,'overlap':prefix-high})
out={'status':'Exact conditional scalar rectangles plus joins to original factor4 finite-family certificate. No analytic producer or finite spectral theorem is proved.','q_min':2,'q_max':39,'y_min':str(Y),'w_lower':'1/50','w_upper':8,'w_bins':399,'r_cells':NR,'phi_rows':phi_rows,'results':results,'finite_family_input':'resume_base_gap_finite_family_20261111.json, original factor4 profile','residual_joins':joins}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2))
print(json.dumps({'results':[{k:v for k,v in row.items() if k!='rows'} for row in results],'joins':joins},indent=2))
assert all(row['passes'] for row in results)
