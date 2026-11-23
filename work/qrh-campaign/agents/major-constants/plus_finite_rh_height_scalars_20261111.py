"""Exact rational scalar checks for the original-RH plus-height candidate."""
from fractions import Fraction as F
from math import ceil, factorial
from pathlib import Path
import json

piu=F(3927,1250)
u_lo,u_hi=F(233,10),F(1989,100)
Aodd=u_lo*piu*531600
Aeven=u_lo*piu*1063200
Ahigh=u_hi*piu*1063200
EB=F(223,250)*260/F(2)**59
Z,C,fac,IB=F(8863,50),F(9,100),F(3231,25),F(2721,1250)
def e2(IA,EA):
    return fac*(EB*(2*Z*IB+2*C*IB**2)+EA*(2*Z*IA+2*C*IA**2))
elo=e2(F(222000),F(6,10**23))
ehi=e2(F(877,100),F(12,10**17))
cap=F(112,10**12)
K1=F(14521,100)*(F(28515)/F(87,25)+37864)
K2=F(14321,100)*(F(33086)/F(87,25)+43934)
checks={
 'exp_point7_lower':sum(F(7,10)**k/factorial(k) for k in range(4))>2,
 'EB_exponent':F(799,5000)*260>59*F(7,10),
 'growth_C':11*F(22,5)<=C*460*F(12039,10000),
 'IA_low':1+piu*600001/F(2123,250)<=222000,
 'IA_high':1+piu*21/F(2123,250)<=F(877,100),
 'low_E2':elo<cap,
 'high_E2':ehi<cap,
 'old_E2_contract':cap*F(54773,100)<F(69,10**9),
 'K1':K1<7660000,
 'K2':K2<7660000,
 'odd_height_floor':461*132900<10**8,
 'odd_height_slope':201*132900+Aodd<10**8,
 'even_low_height_floor':461*60000<10**8,
 'even_low_height_slope':201*60000+Aeven<10**8,
 'even_middle_height_floor':461*125000<10**8,
 'even_middle_height_slope':201*125000+Ahigh<10**8,
 'even_high_height_floor':261*265800<75000000,
 'even_high_height_slope':265800+Ahigh<75000000,
 'high_twist':F(1063200,60000)<20,
 'global_twist':F(1063200,2)<600000,
 'u_domains':u_lo>=10 and u_hi>=10,
 'old_energy_implies_relaxed':F(425,10**9)**2<F(702,10**15),
 'pending_base_gap_odd_dominance':u_lo*3*531600>27000000,
 'pending_base_gap_even_dominance':u_hi*3*1063200>54000000,
}
examples=[]
for c in [3,4,5,10001,60000,60001,100000,125000,125004,132899,265800]:
    qt=c if c%2==0 else 2*c
    u=u_hi if c%2==0 and c>60000 else u_lo
    raw=200+max(F(260),u*piu*F(1063200,qt))
    new=ceil(raw)
    old=F(10**8,c) if c%2 else max(F(10**8,c),200+F(75000000,c))
    assert raw<=new<raw+1 and new<old
    examples.append({'c':c,'new_closed_integer_height':new,'original_height':old})
assert all(checks.values())
def enc(x):
    if isinstance(x,F):return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
    if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
    if isinstance(x,list):return [enc(v) for v in x]
    return x
data={'scope':'rational metadata only; no spectral or analytic evaluations',
 'Aodd':Aodd,'Aeven_low':Aeven,'Aeven_high':Ahigh,'EB_cap':EB,
 'E2_low':elo,'E2_high':ehi,'E2_uniform':cap,'K1':K1,'K2':K2,
 'checks':checks,'examples':examples}
Path(__file__).with_suffix('.json').write_text(json.dumps(enc(data),indent=2)+'\n',encoding='utf-8')
print(f'PASS: {len(checks)} scalar checks and {len(examples)} exact ceiling examples')
