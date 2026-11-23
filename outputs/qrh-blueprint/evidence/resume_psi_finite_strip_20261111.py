"""Research scalar checks only. No Lean, prime computation, or zero certificate.

Fractions certify endpoint inequalities in the accompanying analytic reduction.
Floating calculations locate the crossing of THIS upper bound, not an optimum.
"""
from fractions import Fraction as F
from pathlib import Path
import json, math

H = 60343058
def exp_lower(x, n=300):
    x = F(x)
    assert x >= 0
    t = s = F(1)
    for k in range(1, n+1):
        t *= x/k
        s += t
    return s
def exp_upper(x, n=300):
    x = F(x)
    assert 0 <= x < n+2
    t = s = F(1)
    for k in range(1, n+1):
        t *= x/k
        s += t
    return s + t*x/(n+1)/(1-x/(n+2))
def eminus(x):
    return 1/exp_lower(F(x))

assert exp_lower(18) > 1+F(H+3, 2)
assert exp_lower(F('3.556')) > 35
assert exp_lower(F('6.503')) > F(2000, 3)
assert exp_lower(F('.7')) > 2
assert exp_upper(F('.69')) < 2
assert (2/F('.69')+F('4.8'))*F('82.6')/F('2.4')*F('1.001') < 301
assert exp_upper(F('1.2')) < F(10, 3)
BP = 9200*(H+22)*(F(5,4)*(H+11))**9 + 20*(H+22)**3*(F(5,4)*(H+11))**2
assert BP/F('.355') < 2**300
assert F(210)/F('1.2') < 180
assert F(44,H)/F('1.2') < F('1e-6')

L = F(35)
delta2 = F('1e-6')/L**3
a = F('.001')/L
assert 2*exp_upper(delta2/2+a) < F('2.001')
C = F(76)/F('.445')+F(76,3)*(2+F('6.503')+F('1.5')*F('3.556'))
low_scaled = L*F('2.001')*C*eminus(F('.445')*L)
assert low_scaled < F('.007')

B = F('4.4')*H/F(10**6)
A = F(H*H, 2*10**6)
Q200 = 1+F(200)**3/B
high_small = 200*F('2.001')/H*(360*Q200+F('2e-6')*Q200**2)*eminus(A/200**3)
# For L>=200, Q<=q*L^3. Each L^j exp(-L/8), j<=7,
# decreases there, so its maximum is its value at 200.
q = F(1,200**3)+1/B
high_large = F('2.001')/H*(360*q*200**4+F('2e-6')*q*q*200**7)*eminus(25)
assert max(high_small, high_large) < F('2e-9')

# sqrt(35)<6 yields L^(5/2)<35^2*6.
vertical_scaled = 301000*35**2*6*(eminus(F('1.5')*35)+F('.01')*eminus(35))
assert vertical_scaled < F('2e-8')
leak_scaled = 4*35*eminus(F('17.5'))
assert leak_scaled < F('4e-6')
shift_scaled = 35*(exp_upper(a+delta2/2)-1)
assert shift_scaled < F('.001001')
cut_scaled = 4*10000*35*exp_upper(a)*eminus(35)
assert cut_scaled < F('1e-9')
invden = 1/(1-2*eminus(F('17.5')))
assert invden < F('1.000001')
budget = (F('.007')+F('2e-9')+F('2e-8')+F('4e-6')+F('.001001'))*F('1.000001')+F('1e-9')
assert budget < F('.0081') < F('.01')

def diagnostic(l):
    d=.001/l**1.5
    aa=.001/l
    cc=76/.445+76/3*(2+math.log(2/(3*d)))
    low=2.001*cc*math.exp(-.445*l)
    qq=1+l**3/float(B)
    high=2.001/H*math.exp(-l/8-float(A)/l**3)*(360*qq+2e-6*qq**2)
    vert=301/d*(math.exp(-1.5*l)+.01*math.exp(-l))
    r=math.exp(-l/2)
    error=low+high+vert
    upper=4e4*math.exp(aa-l)+(math.expm1(d*d/2+aa)+error+2*r)/(1-2*r)
    lower=-math.expm1(-aa)+2e4*math.exp(-l)+error+4*r
    return dict(log_x=l,x=math.exp(l),low=low,high=high,vertical=vert,
                upper=upper,lower=lower,scaled_bound=l*max(upper,lower),target=.01/l)
lo,hi=30.,36.
for _ in range(70):
    mid=(lo+hi)/2
    if diagnostic(mid)['scaled_bound']>.01: lo=mid
    else: hi=mid
result={'status':'conditional paper reduction; finite strip and global provider not validated here',
        'exact_endpoint_scaled_bounds':{k:float(v) for k,v in dict(low=low_scaled,high_small=high_small,
          high_large=high_large,vertical=vertical_scaled,leak=leak_scaled,shift=shift_scaled,cut=cut_scaled,
          conservative_budget=budget).items()},
        'diagnostics':[diagnostic(math.log(1e9)),diagnostic(math.log(1e14)),diagnostic(math.log(1e15)),diagnostic(35)],
        'this_bound_first_crossing_diagnostic':diagnostic(hi)}
out=Path(__file__).with_suffix('.json')
out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,indent=2))
