"""Exact positive-polynomial and rational checks only; no spectral evaluations."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
checks={}
def ck(k,v):
    assert v,k
    checks[k]=True
def lower(z):
    assert z>=0
    return sum(((z/64)**k/F(factorial(k)) for k in range(17)),F(0))**64
Z,C,a,K,IB=map(F,['177.26','.09','1.371','393400','2.1768'])
ck('EB',F('.892')*255<F('4.6e-16')*lower(F('.1598')*255))
ck('count_growth',11*F('4.4')<=C*455*F('1.2039'))
ck('IA_constant',1+F('3.1416')/F('8.492')<a)
ck('IA_slope',F('3.1416')*1063200/F('8.492')<K)
odd=[(2,100,'23','1.414','10','1.061e-22'),(100,1000,'21.5','10','32','1.133e-19'),(1000,10000,'20.5','31.62','100','9.023e-18'),(10000,265800,'19.5','100','516','5.781e-16')]
even=[(4,100,'22.6','2','10','7.16e-22'),(100,1000,'21.1','10','32','6.7e-19'),(1000,10000,'20.1','31.62','100','4.891e-17'),(10000,265800,'19.1','100','516','2.872e-15')]
rows=[]
for typ,bands,cap in [('odd_unchanged',odd,F('1.49e-7')),('four_divisible',even,F('6.46e-7'))]:
 for L,U,u,sl,su,ea in bands:
    u,sl,su,ea=map(F,[u,sl,su,ea]); tag=typ+'_'+str(L)
    ck(tag+'_root',0<sl and sl*sl<=L and su*su>=U)
    ck(tag+'_EA',F('.588')*u*u<ea*lower(F('.1065')*u*u))
    g=(2*Z*a+2*C*a*a)*su+(2*Z*K+4*C*a*K)/sl+2*C*K*K/(L*sl)
    e=F('129.24')*(516*F('4.6e-16')*(2*Z*IB+2*C*IB*IB)+ea*g)
    ck(tag+'_E2',e<cap)
    rows.append(dict(kind=typ,L=L,U=U,u=str(u),sl=str(sl),su=str(su),EA=str(ea),G=str(g),E2=str(e)))
ck('low_term',F('7.66e6')/F('2.21e13')<F('3.47e-7'))
ck('root_x',F('2.21e13')**2<F('4.9e26'))
for kind,e,b in [('odd','1.49e-7','5e-7'),('even','6.46e-7','9.94e-7')]:
 ck(kind+'_ambient',F('3.47e-7')+F(e)+F('2e-17')+516*F('1e-15')<F(b))
energy=F('9.94e-7')**2/2
ck('energy_max',F('5e-7')**2<energy)
rho=F('7.58e-7')
ck('rho',energy+F('2.83e-7')**2<(rho-516*F('1e-15'))**2)
ck('old_rho',rho<F('8.85e-7'))
ck('Z',16*150000*19*F('8.85e-7')**2<F('.006')**2)
ck('base_dominance',F('19.1')*3*1063200>54000000)
ck('star_dominance',F('19.1')*3>F(704,343) and 455>=300)
ck('line_A',7000000*F('2.321e-19')<(F('1.284e-6')-F('8e-9'))**2)
ck('line_B',7000000*F('1.753e-12')<(F('.004')-F('.00048'))**2)
def ceil(x):return -(-x.numerator//x.denominator)
def u(c):return F('23') if c<100 else F('21.5') if c<1000 else F('20.5') if c<10000 else F('19.5')
examples=[]
for c in [4,96,100,996,1000,9996,10000,60000,100000,125000,265800]:
 old=ceil(200+max(F(255),F('3.1416')*u(c)*F(1063200,c)))
 new=ceil(200+max(F(255),F('3.1416')*(u(c)-F('.4'))*F(1063200,c)))
 base=ceil(F(54000000,c))
 ck('height_'+str(c),base<=new<=old)
 examples.append(dict(c=c,coupled=old,new=new,base=base))
paths=[
'work/qrh-campaign/agents/major-constants/COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md',
'work/qrh-campaign/agents/prime-estimates/REVIEW_FINITE_RH_CONSUMER_DEMAND_MATRIX_2026-11-11.md',
'work/qrh-campaign/agents/audit/FINITE_RH_CONSUMER_DEMAND_MATRIX_2026-11-11.md',
'work/qrh-campaign/agents/audit/REVIEW_PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md',
'work/qrh-campaign/agents/moebius/REVIEW_WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md',
'work/qrh-campaign/agents/moebius/REVIEW_MIXED_CONDUCTOR_WSTAR_PROFILE_2026-11-11.md',
'work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md',
'work/ternary-goldbach/TernaryGoldbach/MajorArcs/Thm714.lean',
'work/ternary-goldbach/TernaryGoldbach/MajorArcs/Prop942.lean',
'work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcChars.lean']
pins={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}
out=dict(scope='conditional paper profile, exact rational checks only',checks=checks,bands=rows,even_energy=str(energy),rho=str(rho),examples=examples,pins=pins)
dest=Path(__file__).with_suffix('.json')
assert not dest.exists(),'preserve existing receipt'
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps(dict(checks=len(checks),energy=str(energy),examples=examples)))
