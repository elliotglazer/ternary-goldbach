"""Independent rational/Taylor and pinned-source checks; no analytic values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
A=ROOT/'work/qrh-campaign/agents'
author=A/'independent-feasibility/BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md'
assert hashlib.sha256(author.read_bytes()).hexdigest().upper()=='776CD34413ECC389D10CE510913C694C6D6C34E8555FFE0D66702582B3A23898'
old=json.loads(author.with_name('base_gap_reduced_rh_height_scalars_20261111.json').read_text())
checks={}
def ck(k,v):
    assert v,k
    checks[k]=True
for pin in old['pins']:
    ck('pin:'+pin['path'],hashlib.sha256((ROOT/pin['path']).read_bytes()).hexdigest().upper()==pin['sha256'])
R=132900; C=2*R; K=8*R
ck('height_floor',F(27000000,R)>203 and F(54000000,C)>203)
ck('ceiling_below_old_real_height',54000000+C<100000000)
ck('odd_induced_even_twist',F(8*R,2)==4*R)
ck('common_ratio',F(27000000,4*R)==F(54000000,8*R))
ck('ratio',F(27000000,4*R)>F('16.1')*F('3.1416'))
ck('old_twist_cap',K<1200000)
ck('conductor_sqrt_cap',C<516**2)
ck('low_scale_sqrt',3160000000000**2<10**25)
ck('low_E1_numerator',F('1.37259')*3420000<4700000)
ck('weighted_low',F(4700000,3160000000000)<F('1.5e-6'))
ck('zero_term',F('1.92182')*15300/F(10**25)<F(1,10**20))
ck('vertical_term',F('2.74517')*21000000000000000/F(6*10**25*3160000000000)<F(1,10**20))
ck('weighted_small',F(1032,10**20)<F(2,10**17))
ck('B_monotonic',F('.1598')*203>32>1)
ck('A_monotonic',F('.1065')*F('16.1')**2>F('27.6')>1)
# Direct power/factorial finite sums differ from author's term recurrence.
for name,x,epsilon in [('B',F(32),F(13,10**15)),('A',F('27.6'),F(11,10**13))]:
    low=sum((x**n/F(factorial(n)) for n in range(121)),F(0))
    ck('positive_Taylor_'+name,low*epsilon>1)
ck('rhoB',F('2.18')*(1-F('.5406'))>1)
ck('c3',F('48.4')<41*F('1.2039') and F('48.4')<F('.2')*203*F('1.2039'))
ck('B_multiplier',2*F('177.26')*F('2.18')+F('.4')*F('2.18')**2<775)
ck('rhoA',F('3.1416')<F('.371')*F('1.93')*F('4.4'))
aa=F('1.371');bb=F('.371')
EA=F('.588')*F('16.1')**2*F(11,10**13)
EB=F('.892')*203*F(13,10**15)
# Expand all conductor-scaled terms independently.
Alow=F('354.52')*aa*516
Ainv=F('354.52')*bb*K
Aquad=F(82,27000000)*(aa*aa*C*516+2*aa*bb*K*516+bb*bb*K*K)
At=EA*(Alow+Ainv+Aquad)
Bt=EB*775*516
ck('A_tail',At<F('.023567'))
ck('B_tail',Bt<F('.000000942'))
total=At+Bt+F('1.5e-6')+F(2,10**17)
ck('full_error',total<F('.02357')<F('.024'))
ck('saved_A',str(At)==old['weighted_EA_upper'])
ck('saved_B',str(Bt)==old['weighted_EB_upper'])
ck('saved_total',str(total)==old['sqrt_conductor_error_upper'])
cop=F('.024')+516*F('2e-9')
ck('coprime',cop==F('.024001032') and cop**2<F(841,10**6))
amp=F('.000544')+F('2e-6')+F('4e-9')+cop
ck('amplitude',amp==F('.024547036')<F('.03'))
ck('main_term',F(30030,5760)*F('1.129')*49/(4*R)<F('.000544'))
ck('ghat',F(435635673,13700000000)>F('.03'))
ck('not_old_guard',amp>F('.014'))
ck('conditional_plus_domination',F('19.89')*3*4*R>27000000)
result={'status':'PASS','scope':'Exact rational/polynomial checks and source binding, no analytic values',
        'pins':old['pins'],'checks':checks,'A_tail':str(At),'B_tail':str(Bt),'total':str(total),'amplitude':str(amp)}
out=Path(__file__).with_suffix('.json')
if out.exists():assert json.loads(out.read_text())==result
else:
    with out.open('x',encoding='utf-8',newline='\n') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks),'pins':len(old['pins'])}))
