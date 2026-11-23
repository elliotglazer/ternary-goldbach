"""Exact scalar witnesses for a conditional height/error tradeoff. No analytic evaluation."""
from fractions import Fraction as F
from math import factorial, ceil
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
checks={}
def ck(name,value):
    assert value,name
    checks[name]=True
def exp_lower(z):
    # exp(z) >= [sum_(k=0)^16 (z/64)^k/k!]^64 for z>=0.
    ck('positive_exp_argument_'+str(z),z>=0)
    return sum(((z/64)**k/F(factorial(k)) for k in range(17)),F(0))**64

piu=F('3.1416'); Z=F('177.26'); C=F('.09'); fac=F('129.24'); IB=F('2.1768')
a=F('1.371'); K=F(393400); EB=F('4.6e-16')
ck('EB_Taylor',F('.892')*255 < EB*exp_lower(F('.1598')*255))
ck('growth_constant',11*F('4.4')<=C*455*F('1.2039'))
ck('IA_constant',1+piu/F('8.492')<a)
ck('IA_coefficient',piu*1063200/F('8.492')<K)
rows=[]
bands=[(2,100,'23','1.414','10','1.061e-22'),
       (100,1000,'21.5','10','32','1.133e-19'),
       (1000,10000,'20.5','31.62','100','9.023e-18'),
       (10000,265800,'19.5','100','516','5.781e-16')]
for L,U,u,sl,su,ea in bands:
    u,sl,su,ea=map(F,(u,sl,su,ea))
    ck('sqrt_lower_'+str(L),0<sl and sl*sl<=L)
    ck('sqrt_upper_'+str(L),su*su>=U)
    ck('EA_Taylor_'+str(L),F('.588')*u*u < ea*exp_lower(F('.1065')*u*u))
    g=(2*Z*a+2*C*a*a)*su+(2*Z*K+4*C*a*K)/sl+2*C*K*K/(L*sl)
    e2=fac*(516*EB*(2*Z*IB+2*C*IB*IB)+ea*g)
    ck('scaled_E2_'+str(L),e2<F('1.49e-7'))
    rows.append({'c_lower':L,'c_upper_for_bound':U,'u':str(u),'sqrt_lower':str(sl),
                 'sqrt_upper':str(su),'EA_upper':str(ea),'G_upper':str(g),'scaled_E2_upper':str(e2)})
ck('sqrt_x_lower',F('2.21e13')**2<F('4.9e26'))
ck('E1_scaled',F('7.66e6')/F('2.21e13')<F('3.47e-7'))
ck('coprime_coefficient',F('3.47e-7')+F('1.49e-7')+F('2e-17')+516*F('1e-15')<F('5e-7'))
rho=F('5.75e-7'); p0=F('2.83e-7')
ck('full_rho',F('5e-7')**2+p0*p0<(rho-516*F('1e-15'))**2)
ck('integrated_Z',16*150000*19*rho*rho<F('.006')**2)
j=F('8.79'); ma=F('.640208')*F('13.59756'); v=F('7.78')*F('2.85')
cc=49*(j+ma)/9+9*v/2; old=F(64019155993729,312500000000000000)
ck('sqrt_j',F('2.965')**2>j)
ck('sqrt_B',F('43.762')**2>1915)
joint=F('2.965')*(F('1.902e-6')+F('3e-6')+rho*F('43.762'))+rho*cc
ck('joint_cubic',joint<old)
ck('base_gap_odd',F('19.5')*3*531600>27000000)
ck('base_gap_even',F('19.5')*3*1063200>54000000)
ck('star_floor',455>=300)
ck('star_slope',F('19.5')*3>F(704,343))
def new(c):
    u=F(23) if c<100 else F('21.5') if c<1000 else F('20.5') if c<10000 else F('19.5')
    return ceil(200+max(F(255),u*piu*F(1063200,c if c%2==0 else 2*c)))
def previous(c):
    u=F('19.89') if c%2==0 and c>60000 else F('23.3')
    return ceil(200+max(F(260),u*piu*F(1063200,c if c%2==0 else 2*c)))
examples=[]
for c in [3,4,5,100,1000,10001,60000,100000,125000,132899,265800]:
    ck('example_'+str(c),new(c)<=previous(c))
    examples.append({'c':c,'candidate_height':new(c),'fallback_height':previous(c)})
paths=[
 'work/qrh-campaign/agents/major-constants/PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md',
 'work/qrh-campaign/agents/audit/REVIEW_PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md',
 'work/qrh-campaign/agents/major-constants/PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md',
 'work/qrh-campaign/agents/audit/REVIEW_PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md',
 'work/qrh-campaign/agents/independent-feasibility/BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md',
 'work/qrh-campaign/agents/zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md',
 'work/ternary-goldbach/TernaryGoldbach/MajorArcs/Thm714.lean',
 'work/ternary-goldbach/TernaryGoldbach/MajorArcs/Prop942.lean',
 'work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcChars.lean',
]
pins={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}
data={'scope':'conditional scalar profile; no spectral values or certificates',
      'checks':checks,'bands':rows,'EB_upper':str(EB),'rho':str(rho),
      'joint_upper':str(joint),'joint_reserve':str(old-joint),
      'examples':examples,'input_sha256':pins}
HERE.joinpath('coupled_plus_height_budget_20261111.json').write_text(json.dumps(data,indent=2)+'\n',encoding='utf-8')
print(f'{len(checks)} exact scalar checks passed; {len(examples)} height examples')
