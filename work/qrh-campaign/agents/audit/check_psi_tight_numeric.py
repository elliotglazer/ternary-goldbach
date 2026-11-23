from fractions import Fraction as F
from pathlib import Path
import json
f=lambda s:F(str(s))
T=f('1e8')+f('3.48')
J=int(f('1e8')/f('3.48'))+1
checks={
'log_argument1_margin':f('1.3e8')-(abs(T)+22),
'log_argument2_margin':f('1.3e8')-f('1.25')*(abs(T)+11),
'exp19_lower_margin':f('2.7182818283')**19-f('1.3e8'),
'Z401_margin':401*f('.5')-(f('10.24')+19+9*19),
'Jl_margin':30000000-J,
'count_margin':f('3e10')-2*f('3e7')*401,
'Mg_unit_margin':f('2.39')-2*f('1.000002'),
'exp80_lower_margin':f('2.7182818283')**80-f('5e34')}
assert all(v>0 for v in checks.values())
assert f('6e-25')*f('5e34')==f('3e10')
out={k:{'exact':str(v),'decimal':float(v)} for k,v in checks.items()}
out['exact_Jl']=J
Path('work/qrh-campaign/agents/audit/psi_tight_numeric_results.json').write_text(json.dumps(out,indent=2)+'\n')
for k,v in checks.items(): print(k, float(v))
print('Exact Jl:',J)
