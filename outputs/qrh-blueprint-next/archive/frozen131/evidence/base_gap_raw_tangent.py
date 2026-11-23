"""Exact square-root tangent tests for the raw first-choice envelope.
Research diagnostic: failed upper bounds are not lower bounds on the actual sum.
"""
from fractions import Fraction as F
from contextlib import redirect_stdout
import io,json
from pathlib import Path
with redirect_stdout(io.StringIO()):
 import base_gap_binned as b

def test(Q0,Q1,V,rparts=8):
 rows=[]
 for j in range(16):
  D0=F(600000,49)+(F(600000)-F(600000,49))*j/16
  D1=F(600000,49)+(F(600000)-F(600000,49))*(j+1)/16
  cell=[]
  for k in range(rparts):
   rlo=b.RBASE+(b.REND-b.RBASE)*k/rparts
   rhi=b.RBASE+(b.REND-b.RBASE)*(k+1)/rparts
   rm=(rlo+rhi)/2
   A=B=F(0)
   for l,u,mass,_ in b.bins:
    tmin=F(max(2*Q0,l*D0/2));tmax=F(max(2*Q1,u*D1/2))
    kap=b.kappa(tmax,l);ell=b.logs(tmin)[1]
    # q(r)=V/tmin * ((kappa*(r-RBASE)/.27125+.5)*ell
    #                    +.002*kappa*(r-RBASE)/.27125+log2) * (.30214*ell+.7468).
    fac=V/tmin*(F('.30214')*ell+F('.7468'))
    qa=fac*kap*(ell+F('.002'))/F('.27125')
    qb=fac*(ell/2+b.logs(F(2))[1])-qa*b.RBASE
    assert qa*rlo+qb>0
    h=b.root_up(qa*rm+qb,2)
    # sqrt(q)<=q/(2h)+h/2 follows from (sqrt(q)-h)^2>=0.
    ta=qa/(2*h)
    tb=qb/(2*h)+h/2
    rem=F('3.77')*b.root_up(1/(l*b.Y),6)+3*b.logs(l*b.Y)[1]/(l*b.Y)
    rest=F('2.5257')*b.root_up(1/tmin,2)+(F('13.2')*V+2*(F('16.267')*ell+F('24.42')))/tmin+rem
    assert ta*rlo+tb+rest>0
    A+=mass*ta;B+=mass*(tb+rest)
   B+=b.TAIL
   gaps=[(b.LOWA-A)*r+b.LOWB-B for r in (rlo,rhi)]
   cell.append(dict(rlo=str(rlo),rhi=str(rhi),A=str(A),B=str(B),gap_lower=str(b.down(min(gaps))),gap_diagnostic=float(min(gaps))))
  rows.append(dict(D_index=j,Dlo=str(D0),Dhi=str(D1),passes=all(F(r['gap_lower'])>0 for r in cell),worst_gap=min(r['gap_diagnostic'] for r in cell),r_cells=cell))
 return dict(Q0=Q0,Q1=Q1,V=str(V),passed=all(r['passes'] for r in rows),D_rows=rows)
results=[test(90090,90090,F(1001,192)),test(90090,150000,F(1001,192))]
out=dict(status='Exact rational upper-envelope tests; first-choice Type I/II inputs remain open; failures are not impossibility proofs.',r_parts=8,D_parts=16,w_parts=len(b.bins),results=results)
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
for r in results:
 print(json.dumps({k:v for k,v in r.items() if k!='D_rows'}))
 print(json.dumps([{k:v for k,v in row.items() if k!='r_cells'} for row in r['D_rows']],indent=2))
