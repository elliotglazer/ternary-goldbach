from fractions import Fraction as F
from pathlib import Path
import json
f=lambda x:F(str(x))
k=f('.514')/f('1.1181')
checks={
'digamma_factor_margin': f('.18')*f('2.39')**2-1,
'digamma_constant_margin': f('.4')-f('.6931471808')/2-f('.18')/4,
'stechkin_square_margin':f('.514')**2+f('1.1181')**2-f('1.5'),
'exp20_lower_margin':f('2.7182818283')**20-f('4e8'),
'reciprocal2_margin':f('.351')*f('2.39')**2-2,
'reciprocal11_margin':f('1.926')*f('2.39')**2-11,
'kappa_upper_margin':f('.55')-(1-k),
'log_main_margin':f('9.83')-(10+f('.4')-f('1.1447')/2),
'digamma_difference_margin':f('.491')-k/2*(f('.20604')+f('1.926')),
'E1_margin':f('1.2857')-(1/f('.6181')-f('1.1447')/2+(f('1.0329')-1/f('1.80905'))/2),
'weighted_E1_margin':f('.592')-k*f('1.2857'),
'vM6_85_margin':f('6.85')-(f('.351')+f('.55')*f('9.83')+f('.491')+f('.592')),
'hr2_margin':1-f('.98')*f('1.014'),
'hr3_margin':f('1.618')*f('.6181')-1,
'hr4_margin':f('.62')*f('1.6141')-1,
'weighted_hr34_margin':f('1.03')-k*(f('1.618')+f('.62')),
'Z55_5_margin':F(500,9)+f('.98')-f('1.03')-f('55.5'),
'real_500_7_margin':f('1.1447')/2-f('.9197')/2+1/(2*f('1.507')),
'positivity_contradiction_margin':-(18*F(500,7)+54*f('6.85')-30*f('55.5'))
}
assert all(v>0 for v in checks.values())
out={key:{'exact':str(v),'decimal':float(v)} for key,v in checks.items()}
Path('work/qrh-campaign/agents/audit/fixed_gap_rational_results.json').write_text(json.dumps(out,indent=2)+'\n')
for key,v in checks.items():print(key, float(v))

