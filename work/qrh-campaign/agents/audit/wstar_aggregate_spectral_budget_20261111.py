"""Exact rational budget only. No prime, zero, transform or analytic evaluation."""
from fractions import Fraction as F
from pathlib import Path
import json

j=F('8.79'); u=F('3.67e-6'); rho=F('8.85e-7')
p=F('1.504e-6')
inner=F('3e-6')+3*rho
row=800*(96+F(2904)/(3*F('3.48')**2))
G=7000000
checks={
 'principal_root_floor':3160000000000**2<10**25,
 'principal_residual':F(1,10**17)+F(4700000,3160000000000)<F('1.5e-6'),
 'full_principal_removal':F('1.5e-6')+2*F('2e-9')==p,
 'remaining_budget_positive':u>p,
 'mixed_budget':inner**2<j*(u-p)**2,
 'full_strip_gram_row':49*row<G,
 'weighted_spectral_budget':G*F(4,7*10**18)==F('2e-6')**2,
 'unweighted_spectral_budget':G*F(4,7*10**6)==4,
 'weighted_remainder_join':F('2e-6')+F('1e-6')==F('3e-6'),
 'unweighted_remainder_join':2+1==3,
 'density_kernel_mass':F(1,10**24)<F(1,2),
 'density_comparison_obstruction':F(3,4)*F(1,2)*3732480000000000>10**33*F(4,7*10**18),
}
assert all(checks.values())
out={'scope':'Exact rational scalar comparisons only; no spectral or actual energy conclusion',
     'checks':checks,'count':len(checks),
     'normalized_nonprincipal_norm_allowance':str(inner),
     'squared_budget_slack':str(j*(u-p)**2-inner**2),
     'full_strip_star_gram_row_upper':str(49*row),
     'G':G,'Q_A_target':str(F(4,7*10**18)),'Q_B_target':str(F(4,7*10**6))}
dest=Path(__file__).with_suffix('.json')
if dest.exists(): raise SystemExit('Refusing to overwrite receipt')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8',newline='\n')
print('PASS_EXACT_WSTAR_AGGREGATE_BUDGET',len(checks))
