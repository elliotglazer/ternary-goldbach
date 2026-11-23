"""Exact scalar checks for the conductor-3 finite-rectangle route.
No zero-free rectangle or analytic lemma is proved by this script.
"""
from fractions import Fraction as F
from math import factorial, exp, log
import json
from pathlib import Path
T=14_000_000
x0=49*10**25
h=F('3.48')
def elo(z,n=300):
    return sum((z**j/factorial(j) for j in range(n)),F(0))
def bp(t):
    return 1400*3**9*4*(t+22)*(F(5,4)*(t+11))**10
# Elementary translated mass <=2+.5log(1+|t|/2).
for a in [F(9,8),F(15,8)]:
    assert a-F('.26')*(a*a+F('1.74')**2)>0
assert F('2.7')**16>1+F(T+10,2)
assert (2+F(16,2))/F('.26')<39
assert 39*(F(2*T)/h+2)<320_000_000
row=78*(16+F(428)/(3*h*h))
assert row<2200
# Existing right-half-plane Euler absolute sum <1.
assert F('.7')/4+F('1.1')/9+(F('1.1')+1)/3<1
# Cluster m=6 at +15, reflected beta=.875,.125 fails even crude mass.
assert F('2.7')**3>F('8.5')
assert 6*(F(8,9)+F(8,15))>2+F(3,2)
# Finite beta<=16/25: all-x spectral low norm, with actual U supremum.
assert F('2.7182818286')**61<x0
low_coeff=F('1.2534')**2*2200*320_000_000
assert elo(F(61)*F(18,25))>low_coeff/F('.00031')**2
# Source Dirichlet BP and kappa=11, not zeta BPz2.
assert bp(F(T))/F('.355')<F(10,3)**180
assert bp(F(0))/F('.355')<F(10,3)**50
# log(10/3)>1; hence c3g<4e-6.
assert F(11)*F('4.4')/T<F('4e-6')
u=F('22.2')
assert F(T-200)/(F(22,7)*200000)>u
assert elo(F('.1065')*u*u)>F('.588')*u*u/F('5e-21')
assert F('1.93')*F('4.4')/(F(22,7)*200001)>F('1.3e-5')
assert 1+1/F('1.3e-5')<100000
assert 2*180*100000+2*F('4e-6')*100000**2<37_000_000
assert elo(F(1000))>F('.892')*T/F('1e-100')
assert F('.1598')*(T-200)>1000
assert 130*(F('5e-21')+F('1e-100'))*37_000_000<F('3e-11')
assert 2125**8<x0
assert 633**2>400000
assert F('1.2534')*633*F('3e-11')/2125<F('1.2e-11')
# Vertical and possible zero-at-zero remainders (no odd-parity shortcut needed).
assert elo(F(20))>512*3**9*4/F('.355')
assert 2/F('.69')+F('4.8')<8
vertical=105394*8*(57*2*10**6+F('2.6')*2*10**12)
assert (vertical*F(1,10**39)+50*39000/F(x0))*633*F('1.2534')<F('1e-14')
# Exact induction bound, primitive-to-coprime removal, and final block cap.
weight=F(64,81)
assert weight==F(3,4)*F(32,27)/F(9,8)
primitive_norm=F('.00031')+F('1.2e-11')+F('1e-14')
block=F('1.01')*weight*primitive_norm**2+101*weight*400000*F('1.2534')**2*F('1e-30')
assert block<F('8e-8')
result={'status':'scalar comparisons only; finite zero-free rectangle UNPROVED','T':T,'beta_cap':'16/25','window_count':39,'total_count_cap':320000000,'gram_row_exact':str(row),'gram_row_upper':2200,'induction_weight':'64/81','block_cap':'8e-8','block_upper_exact':str(block),'block_upper_diagnostic':float(block),'density_budget_exact':str(F('.00031')**2/(F('1.2534')**2*2200))}
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
print('DIAGNOSTIC common-beta all-sign count caps, not actual zero counts:')
for b in [.5,.625,.64,.65,.7,.75,.8,.825,.85,.875]:
    print(b,float(F('.00031')**2/(F('1.2534')**2*2200))*x0**(2-2*b))
# Source-only Jensen fallback: same Gram lemma, no Dirichlet mass identity.
assert bp(F(T+10))/F('.355')<F(100,27)**156
assert 156*(F(2*T)/h+2)<1_300_000_000
assert 312*(16+F(428)/(3*h*h))<8800
assert elo(F(61)*F(4,5))>F('1.2534')**2*8800*1_300_000_000/F('.00031')**2
print('SOURCE_JENSEN_FALLBACK_PASS: finite beta<=3/5 through14m suffices for the same 8e-8 block cap.')
assert elo(F(61)*F(18,25))>2200*320_000_000/F('.00025')**2
assert 300000*F(3,2)*F('.000251')**2<F('.029')
print('C3_UPPER_J_BLOCK_PASS: same finite rectangle gives N[c=3]<.029 by crude exact weights.')
