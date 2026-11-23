"""Exact Taylor-polynomial and rational checks only; no analytic-function values."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
S=ROOT/'work/ternary-goldbach/TernaryGoldbach'
paths=[S/p for p in ['MajorArcs/Cor933.lean','MajorArcs/Cor713.lean','Explicit/ZeroSumBound.lean','Explicit/ExplicitBound.lean','MinorArcs/BaseGap.lean','MinorArcs/BaseGap2.lean','MinorArcs/Bombieri.lean','MinorArcs/MinorTotal.lean']]
paths += [ROOT/'work/qrh-campaign/agents/zero-sum/AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET_2026-11-11.md',ROOT/'work/qrh-campaign/agents/integration/BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md']
pins=[{'path':str(p.relative_to(ROOT)).replace('\\','/'),'sha256':hashlib.sha256(p.read_bytes()).hexdigest().upper()} for p in paths]
checks={}
def ck(k,v):
 assert v,k
 checks[k]=True
def exp_poly(x,n):
 t=F(1);s=t
 for k in range(1,n+1): t=t*x/k;s+=t
 return s
R=132900;K=8*R;C=2*R;pi_hi=F('3.1416')
ck('conductor_and_modulus_domain',C==265800<300000 and C<516**2)
ck('height_minimum_odd',F(27000000,R)>203)
ck('height_minimum_even',F(54000000,C)>203)
ck('height_below_old_comparison',54000000<100000000)
ck('ratio_odd',F('16.1')*pi_hi*(4*R)<27000000)
ck('ratio_even',F('16.1')*pi_hi*(8*R)<54000000)
ck('admissibility_floor',203>50 and F('16.1')>10)
ck('old_twist_domain',K<1200000)
ck('EA_exponent',F('.1065')*F('16.1')**2>F('27.6'))
ck('exp_EA_Taylor',exp_poly(F('27.6'),120)>F(10**13,11))
ck('EB_exponent',F('.1598')*203>32)
ck('exp_EB_Taylor',exp_poly(F(32),120)>F(10**15,13))
ck('EB_monotone_domain',F('.1598')*203>1)
ck('rhoB_inverse',1<F('2.18')*(1-F('.5406')))
ck('c3_over_H',F('48.4')/F('1.2039')<41)
ck('c3_uniform',F('48.4')/(203*F('1.2039'))<F('.2'))
ck('B_geometric_multiplier',2*F('177.26')*F('2.18')+2*F('.2')*F('2.18')**2<775)
ck('A_geometric_inverse',pi_hi/(F('1.93')*F('4.4'))<F('.371'))
a=F('1.371');b=F('.371')
EA=F('.588')*F('16.1')**2*F(11,10**13)
weighted_A=EA*(F('354.52')*(a*516+b*K)+F(82,27000000)*(a*a*C*516+2*a*b*K*516+b*b*K*K))
weighted_B=F('.892')*203*F(13,10**15)*775*516
ck('weighted_A',weighted_A<F('.023567'))
ck('weighted_B',weighted_B<F('0.000000942'))
ck('low_E1',F(4700000,3160000000000)<F('0.0000015'))
ck('sqrt_y',3160000000000**2<10**25)
ck('origin_term',F('1.92182')*15300/10**25<F(1,10**20))
ck('vertical_term',F('2.74517')*21000000000000000/(6*10**25*3160000000000)<F(1,10**20))
ck('weighted_small_terms',516*F(2,10**20)<F(2,10**17))
full=weighted_A+weighted_B+F('0.0000015')+F(2,10**17)
ck('complete_primitive_bound',full<F('.02357')<F('.024'))
cop=F('.024')+516*F(2,10**9)
ck('coprime_energy_target',cop<F('.029') and cop**2<F(841,10**6))
amplitude=F('.000544')+F(2,10**6)+F(4,10**9)+cop
ck('actual_ghat_consumer',amplitude<F('.03'))
ck('old_guard_not_claimed',amplitude>F('.014'))
ck('ghat_retained_lower',F(435635673,13700000000)>F('.03'))
ck('candidate_plus_dominates_both_parities',F('19.89')*3*(4*R)>27000000)
ck('candidate_plus_other_branch',F('23.3')>F('19.89'))
data={'scope':'Exact rational/Taylor checks, not evaluated zeros or analytic functions','pins':pins,'checks':checks,'count':len(checks),'weighted_EA_upper':str(weighted_A),'weighted_EB_upper':str(weighted_B),'sqrt_conductor_error_upper':str(full),'coprime_energy_norm_upper':str(cop),'amplitude_upper':str(amplitude),'Taylor_degrees':{'EA':120,'EB':120}}
out=Path(__file__).with_suffix('.json')
with out.open('x',encoding='utf-8',newline='\n') as f:json.dump(data,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS_EXACT_BASE_GAP_HEIGHT_BUDGET','checks':len(checks),'source_pins':len(pins)}))
