"""Exact rational witnesses only: no spectral or analytic function evaluation."""
from fractions import Fraction as F
from math import factorial,ceil
from pathlib import Path
from hashlib import sha256
import json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
checks={}
def ck(name,test):
    assert test,name
    checks[name]=True
def P(z):
    assert z>=0
    return sum(((z/64)**k/F(factorial(k)) for k in range(17)),F(0))**64
Z,C,IB,fac=F('177.26'),F('.1'),F('2.1768'),F('129.24')
a,K=F('1.371'),F(196700)
EB=F('4.727e-15')
ck('sqrt_odd_conductor',132900<365**2)
ck('growth_at_440',11*F('4.4')<=C*440*F('1.2039'))
ck('IA_constant',1+F('3.1416')/F('8.492')<a)
ck('IA_odd_slope',F('3.1416')*531600/F('8.492')<K)
ck('EB_witness',F('.892')*240<EB*P(F('.1598')*240))
bands=[(3,100,'21','1.732','10','1.039e-18'),
       (100,1000,'20','10','32','7.422e-17'),
       (1000,10000,'19.5','31.62','100','5.781e-16'),
       (10000,132900,'19.2','100','365','1.93e-15')]
rows=[]
for L,U,u,sl,su,ea in bands:
    u,sl,su,ea=map(F,(u,sl,su,ea))
    ck('lower_root_'+str(L),0<sl and sl*sl<=L)
    ck('upper_root_'+str(L),su*su>=U)
    ck('u_ge10_'+str(L),u>=10)
    ck('EA_witness_'+str(L),F('.588')*u*u<ea*P(F('.1065')*u*u))
    g=(2*Z*a+2*C*a*a)*su+(2*Z*K+4*C*a*K)/sl+2*C*K*K/(L*sl)
    e2=fac*(365*EB*(2*Z*IB+2*C*IB*IB)+ea*g)
    ck('scaled_E2_'+str(L),e2<F('3.93e-7'))
    rows.append({'lower':L,'upper_for_bound':U,'u':str(u),'sl':str(sl),'su':str(su),
      'EA':str(ea),'G':str(g),'scaled_E2':str(e2)})
ck('coefficient',F('3.47e-7')+F('3.93e-7')+F('2e-17')+516*F('1e-15')<F('7.41e-7'))
ck('target_coefficient',F('7.41e-7')<F('8.385e-7'))
ck('energy_cap',F('8.385e-7')**2<F('7.03135e-13'))
ck('full_orthogonal_radius',F('7.03135e-13')+F('2.83e-7')**2<(F('8.85e-7')-516*F('1e-15'))**2)
ck('base_dominance',F('19.2')*3*531600>27000000)
ck('star_dominance',F('19.2')*3>F(704,343) and 440>300)
examples=[]
for c in [3,5,99,101,999,1001,9999,10001,60001,100001,132899]:
    u=F(21) if c<100 else F(20) if c<1000 else F('19.5') if c<10000 else F('19.2')
    uc=F(23) if c<100 else F('21.5') if c<1000 else F('20.5') if c<10000 else F('19.5')
    raw=200+max(F(240),u*F('3.1416')*F(531600,c))
    h=ceil(raw);hc=ceil(200+max(F(255),uc*F('3.1416')*F(531600,c)))
    hb=ceil(F(27000000,c));hs=ceil(max(F(300),F(704*531600,343*c)))
    ck('height_example_'+str(c),max(hb,hs)<=h<=hc)
    examples.append({'c':c,'candidate':h,'coupled_fallback':hc,'base':hb,'star':hs})
paths=[
 'work/qrh-campaign/agents/major-constants/COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md',
 'work/qrh-campaign/agents/zero-sum/REVIEW_COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md',
 'work/qrh-blueprint/SHARED_RH_STAR_BUDGET_2026-11-11.md',
 'work/ternary-goldbach/TernaryGoldbach/MajorArcs/Thm714.lean',
 'work/ternary-goldbach/TernaryGoldbach/MajorArcs/Prop942.lean',
 'work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcChars.lean',
]
data={'scope':'odd-only conditional height theorem; rational scalar witnesses, no spectrum',
      'checks':checks,'EB':str(EB),'bands':rows,'examples':examples,
      'input_sha256':{p:sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}}
dest=Path(__file__).with_suffix('.json')
if dest.exists():raise SystemExit('Refusing overwrite')
dest.write_text(json.dumps(data,indent=2)+'\n',encoding='utf-8')
print(f'{len(checks)} checks passed')
print(json.dumps(examples,indent=2))
