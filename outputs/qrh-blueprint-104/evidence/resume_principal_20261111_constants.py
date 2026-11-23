"""Research arithmetic for RESUME_PRINCIPAL_2026-11-11.md.
Fraction assertions certify scalar comparisons only. Density-table decimals are
ordinary floating diagnostics, not certificates or claims of actual zero counts.
"""
from fractions import Fraction as F
from math import factorial, log, exp
T=40_000_000
h=F(87,25)
def bp(t):
    return 9200*(t+22)*(F(5,4)*(t+11))**9+20*(t+22)**3*(F(5,4)*(t+11))**2
assert bp(F(T+10))/F('.355') < (F(100,27))**150
assert bp(F(T))/F('.355') < (F(10,3))**170
assert F(2*T,h)+2 < F(4_000_000_000,150)
R=300*(16+F(428)/(3*h*h))
assert R<9000
assert 2*(F('19.5')+2*F('19.2'))+4*2*F('4.5')*5+4*33 <428
C=14*9000*4_000_000_000
def exp_lower(z,n=250):
    return sum((z**j/factorial(j) for j in range(n)),F(0))
assert exp_lower(F(61)*F(18,25)) > F(C)/F('.007')**2
# e^61 <x0 follows from known e upper; this reduces all-x low norm.
eupper=F('2.7182818286'); x0=49*10**25
assert eupper**61<x0
# High tail of actual etaPlus, using source EA/EB and 4.4-height windows.
u=F('21.2')
assert F(T-200)/(F(22,7)*600000)>u
assert exp_lower(F('.1065')*u*u)>F('.588')*u*u/F('5e-19')
assert F('1.93')*F('4.4')/(F(22,7)*600001)>F('4e-6')
assert 1+1/F('4e-6')<300000
assert 2*170*300000+2*F('2e-6')*300000**2<110_000_000
assert 130*F('5e-19')*110_000_000<F('8e-9')
assert exp_lower(F(1000)) > F('.892')*T/F('1e-100')
assert F('.1598')*(T-200)>1000
assert F('1e-8')*5000/2125<F('3e-8')
assert F('.007')+F('3e-8')+F('5e-12')+F('1e-15')<F('.01')
print('EXACT_SCALAR_PASS: beta<=.64 through4e7 would suffice; that zero-free claim is NOT proved')
print('Gram row bound:',R,'; low squared coefficient:',C)
print('DIAGNOSTIC DENSITY TABLE; corrected KLN equation1.5 positive-height bound')
for t in [2000,100000,1000000,40000000]:
    for s in [.75,.8,.85,.875]:
        n=965*(3*t)**(8*(1-s)/3)*log(t)**(5-2*s)+51.5*log(t)**2
        print('T',t,'sigma',s,'Nplus upper expression',n)
# Number of zeros at a common beta allowed by this sufficient row estimate,
# before tail allocation. This is NOT a necessary condition on actual zeta.
print('DIAGNOSTIC common-beta count budget under row method:')
for b in [.5,.64,.7,.75,.8,.825,.85,.875]:
    cap=.009**2/(14*9000*x0**(2*b-2))
    print(b,cap)
# Stronger ACTUAL-zeta local count from shifted xi mass, paper derivation in note.
for a in [F(9,8),F(15,8)]:
    assert a-F('.26')*(a*a+F('1.74')**2)>0
assert F('2.7')**17>1+F(T+10,2)
assert F('.7')/4+F('1.1')/9+(F('1.1')+1)/3<1
assert (3+F(17,2))/F('.26')<45
assert F(2*T,h)+2<F(1_100_000_000,45)
Rnew=90*(16+F(428)/(3*h*h))
assert Rnew<2600
Cnew=14*2600*1_100_000_000
assert exp_lower(F(122,3))>F(Cnew)/F('.0095')**2
assert F('.0095')+F('3e-8')+F('5e-12')+F('1e-15')<F('.01')
print('SHIFTED_MASS_SCALAR_PASS: windows45; Gramrow<2600; finitebeta<=2/3 through4e7 would suffice')
print('new row rational:',Rnew,'new squared coefficient:',Cnew)
print('UPDATED_DIAGNOSTIC common-beta count budget under improvedrow:')
for b in [.5,2/3,.7,.75,.8,.825,.85,.875]:
    print(b,.009**2/(14*2600*x0**(2*b-2)))
