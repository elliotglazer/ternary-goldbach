"""Exact rational budget checks only, with no function/prime/zero evaluation."""
from fractions import Fraction as F
from pathlib import Path
import json
R=132900
totient=F(30030,5760)
assert F('1.2534')*F('1.016') < F('1.129')**2
main=totient*F('1.129')*49/(4*R)
assert main < F('.000544')
assert 365**2>R and 3160000000000**2<10**25
principal=F(1,10**17)+F(4700000,3160000000000)
assert principal < F('2e-6')
e0=F('2e-9'); residual=F(29,1000)
cop_bound=F('.000544')+F('2e-6')+2*e0+residual
primitive_bound=F('.000544')+F('2e-6')+366*e0+residual
assert cop_bound==F('0.029546004') < F('.03')
assert primitive_bound==F('0.029546732') < F('.03')
guard_cop=F('.000544')+F('2e-6')+2*e0+F('.013')
guard_primitive=F('.000544')+F('2e-6')+366*e0+F('.013')
assert guard_cop==F('.013546004') < F('.014')
assert guard_primitive==F('.013546732') < F('.014')
ghat=F('1.398')*((F('.41415')*12+F('.8764'))*F('1.7')+F('2.526'))/548
assert ghat>F('.03')
conditional_RH=365*F(1,10**17)+F(4700000,3160000000000)
assert conditional_RH<F('1.5e-6')
out=dict(status='PASS_EXACT_AGGREGATE_BASE_GAP_BUDGET',R=R,
         main_bound=str(main),principal_bound=str(principal),
         coprime_energy_threshold=str(residual**2),
         coprime_final_bound=str(cop_bound),primitive_final_bound=str(primitive_bound),
         unchanged_guard_energy_threshold=str(F('.013')**2),
         unchanged_guard_coprime_bound=str(guard_cop),unchanged_guard_primitive_bound=str(guard_primitive),
         retained_ghat_lower=str(ghat),conditional_RH_l1_bound=str(conditional_RH),
         scope='Sufficient scalar implications only; no actual aggregate or principal residual evaluated.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(out,indent=2))
