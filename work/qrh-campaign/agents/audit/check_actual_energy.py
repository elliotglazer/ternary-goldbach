from fractions import Fraction as F
from pathlib import Path
import json
f=lambda x:F(str(x))
tail=20*f('.000336')/(1-F(1,40))
s0=f('.607')+f('.607')*f('1.415')+2*f('.136')*f('1.733')+3*f('.0112')*2+tail
s1=f('.607')*f('1.415')*f('.833')+2*f('.136')*f('1.733')*f('1.049')+3*f('.0112')*2*f('1.178')+tail
assert s0<f('2.1') and s1<f('1.4')
residual=2*f('.0023')*f('1.000000000000001')*(f('2.1')+f('1.4')/f('7.81'))
assert f('7.81')**2<61 and residual<f('.0105')
assert f('2.719')<f('1.649')**2 and f('1.6595')**2<f('2.8')
Q=150000
phi=list(range(Q+1)); squarefree=[True]*(Q+1)
for p in range(2,Q+1):
 if phi[p]==p:
  for k in range(p,Q+1,p):phi[k]-=phi[k]//p
  for k in range(p*p,Q+1,p*p):squarefree[k]=False
lo=min((phi[c],c) for c in range(149901,150000,2) if squarefree[c])
assert lo==(73728,149955)
coef=F(2,lo[0]**2)*F(1200000,149900)*f('1.2534')**2*f('2.8')
assert coef==F(30547447,2357723136000000)
corrected=f('1.01')*coef
err=101*f('1e-30')*f('381.22')*f('13.59756')
assert corrected<f('1.31e-8') and err<f('1e-24')
assert f('1.31e-8')*68+f('1e-24')<f('9e-7')
out={'S0_rational_upper':str(s0),'S1_rational_upper':str(s1),'residual_coefficient_upper':str(residual),'min_phi':lo[0],'attained_at':lo[1],'pre_correction_log_coefficient':str(coef),'post_correction_log_coefficient':str(corrected),'removal_error_upper':str(err)}
Path('work/qrh-campaign/agents/audit/actual_energy_checks.json').write_text(json.dumps(out,indent=2)+'\n')
for k,v in out.items():print(k,v)
