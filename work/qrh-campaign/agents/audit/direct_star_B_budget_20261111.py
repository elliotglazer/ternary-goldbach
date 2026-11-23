"""Exact rational/integer comparisons only. No analytic or prime values."""
from fractions import Fraction as F
from pathlib import Path
import json

R=132900; rho=F('8.85e-7'); u=F('3.67e-6'); p=F('1.504e-6'); j=F('8.79')
C=j*(u-p)**2
def passes(A,B):
 gap=C-A-rho*rho*B
 return gap>=0 and gap*gap>=4*A*rho*rho*B
frontier=[]
for A,expected in [(F('9e-12'),14),(F('4e-12'),24),(F('1e-12'),37),(F(0),52)]:
 good=[B for B in range(101) if passes(A,B)]
 assert max(good)==expected and not passes(A,expected+1)
 frontier.append({'A':str(A),'largest_integer_B':expected})
checks={
 'absolute_B_ceiling':52<C/(rho*rho)<53,
 'R_even':R%2==0,
 'removal_volume':12*R*R<(4*R)**2,
 'removal_upper':F(2,10**9)*(4*R)==F('0.0010632'),
 'sieve_size_domain':(20000*R)**2<=49*10**25//16,
 'sieve_log_domain_sufficient':(2*R)**10<(10**25)**3,
 'log_2R_gt_11_via_exp1_lt3':3**11<2*R,
 'exp2_gt7_positive_series':sum((F(2**k,1)/__import__('math').factorial(k) for k in range(6)),F(0))>7,
 'tail_mass':1-F(5,14)==F(9,14),
 'VU_lower':F(9,14)**2/2>F(1,5),
 'source_mass_upper':F('13.59756')<14,
 'optimistic_sieve_obstruction':49*(2*(11+2)-14)*F(1,5)==F('117.6')>53,
}
assert all(checks.values())
out={'status':'PASS_EXACT_DIRECT_STAR_B_BUDGET','scope':'Algebraic model only; no B or coefficient-energy assertion',
 'frontier':frontier,'B_absolute_supremum':str(C/(rho*rho)),'checks':checks}
dest=Path(__file__).with_suffix('.json')
if dest.exists():raise SystemExit('Refusing to overwrite receipt')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8',newline='\n')
print(out['status'])
