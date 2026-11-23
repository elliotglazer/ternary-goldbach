"""Exact scalar checks for a CONDITIONAL low-zeta-data refinement.

Does not compute zeros or certify RH/moments. No Lean invocation.
"""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

def elo(z,n=400):
    z=F(z); assert z>=0
    t=s=F(1)
    for j in range(1,n+1): t*=z/j; s+=t
    return s
def eup(z,n=400):
    z=F(z); assert 0<=z<n+2
    t=s=F(1)
    for j in range(1,n+1): t*=z/j; s+=t
    return s+t*z/F(n+1)/(1-z/F(n+2))
def eneg(z): return 1/elo(z)
def rounded_upper(q):
    scale=10**18
    return str(F((q.numerator*scale+q.denominator-1)//q.denominator,scale))

L0=F('22.33'); L1=F(35); Y=1000; T=10**6; H=60343058
k=F('.002')
assert eup(L0)<5*10**9
assert 31**2<Y<32**2
# delta=k/(L sqrt(L+10)); the following bounds hold on [L0,35].
d2max=k*k/(L0*L0*(L0+10)); d2min=k*k/(L1*L1*(L1+10))
assert 1/d2min<120000**2
assert elo(12)>120000
assert d2max<F('1e-9')
a0=k/L0
# Low critical zeros: exact endpoints, not a factor 2.
endpoint=eup(d2max/2)*(eup(a0/2)+32*eneg(L0/2))
assert endpoint<F('1.002')
assert elo(7)>Y
# Alternative allows .49<=beta<=.51 and a weighted reciprocal moment.
assert eup(d2max/2)*(eup(a0*F('.51'))+eneg(F('.49')*(L0-7)))<F('1.002')
low=24*F('1.002')*L0*eneg(L0/2)
assert low<F('.00761')
# Intermediate heights: both-sign count <=76 per paired 3-window.
wmid=F(76,T)*eneg(d2min*T*T/2)*(1+1/(3*d2min*T))
# exp(b beta)<=exp(.445*b)<1 and the global endpoint factor <2.001.
mid=35*F('2.001')*wmid # dropping x^(-.445) only enlarges it
assert mid<F('1e-12')
# Dominant vertical line ratio integrated directly.
assert (2/F('.69')+F('4.8'))<8
assert eup(F('.69'))<2
assert F('2.51')**2>2*F(22,7)
assert F(8)/F('6.28')*eup(d2max/8+a0/2)<F('1.34')
bracket=240+80*12+F('6.526')*120000
vertical=F('1.34')*bracket*L0*(eneg(F('1.5')*L0)+eneg(L0)/31)
assert vertical<F('.00016')
# Source sandwiches.
shift=L0*(eup(a0+d2max/2)-1)
assert shift<F('.002001')
leak=4*L0*eneg((L0+10)/2)
assert leak<F('.000009')
cut=4*Y*L0*eup(a0)*eneg(L0)
assert cut<F('.000018')
den=1/(1-2*eneg((L0+10)/2))
assert den<F('1.000001')
# Reuse the original high-tail envelope, extended to L>=L0.
# New delta >= .001/L^(3/2), since 4L>=L+10.
assert 4*L0>L0+10
A=F(H*H,2*10**6); B=F('4.4')*H/10**6
Q200=1+200**3/B
high_small=200*F('2.001')/H*(360*Q200+F('2e-6')*Q200**2)*eneg(A/200**3)
q=F(1,200**3)+1/B
high_large=F('2.001')/H*(360*q*200**4+F('2e-6')*q*q*200**7)*eneg(25)
assert high_small<F('2e-9') and high_large<F('2e-9')
budget=(F('.00761')+F('1e-12')+F('.00016')+F('.002001')+F('.000009')+F('2e-9'))*F('1.000001')+F('.000018')
assert budget<F('.00981')<F('.01')

# Separate finite-range contract reaching 1e9. Delta is fixed on [1e9,5e9].
# A Gaussian-weighted low moment <=10.8 is a proposed target, not certified data.
Lc=F('20.72'); Lu=F('22.34'); dc=F(1,50000); K=F('5.5'); ac=K*dc
assert eup(Lc)<10**9 and elo(Lu)>5*10**9
assert 1/dc==50000 and elo(11)>50000
epc=eup(dc*dc/2)*(eup(ac/2)+32*eneg(Lc/2))
assert epc<F('1.0011')
lowc=F('10.8')*F('1.0011')*Lc*eneg(Lc/2)
midc=Lu*F('2.001')*F(76,T)*eneg(dc*dc*T*T/2)*(1+1/(3*dc*dc*T))
vertc=F('1.34')*(240+80*11+F('6.526')/dc)*Lc*(eneg(F('1.5')*Lc)+eneg(Lc)/31)
shiftc=Lu*(eup(ac+dc*dc/2)-1)
leakc=4*Lu*eneg(K*K/2)
cutc=4*Y*Lc*eup(ac)*eneg(Lc)
denc=1/(1-2*eneg(K*K/2))
budgetc=(lowc+midc+vertc+shiftc+leakc+F('2e-9'))*denc+cutc
assert budgetc<F('.01')
out={'status':'conditional scalar implication only; no finite zero assertions certified',
 'main_contract':{'height':T,'finite_RH':True,'both_sign_reciprocal_moment_cap':24,'threshold':5*10**9},
 'alternative_main_contract':{'height':T,'beta_interval':['.49','.51'],'moment':'sum m*exp(35*max(beta-.5,0))/abs(rho)<=24'},
 'main_allocations_rounded_up':{key:rounded_upper(val) for key,val in [('low',low),('intermediate',mid),('vertical',vertical),('shift',shift),('leak',leak),('cut',cut),('total_budget',budget)]},
 'main_diagnostics':{key:float(val) for key,val in [('low',low),('intermediate',mid),('vertical',vertical),('total_budget',budget)]},
 'one_billion_contract':{'height':T,'finite_RH':True,'delta':'1/50000','both_sign_gaussian_reciprocal_moment_cap':'10.8','additional_to_main_contract':True,'budget_diagnostic':float(budgetc)},
 'all_exact_checks':True}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out['main_diagnostics'],indent=2))
print('ONE_BILLION_CONDITIONAL_BUDGET',float(budgetc))
print('ALL_EXACT_SCALAR_CHECKS_PASS; spectral contracts remain unproved')
