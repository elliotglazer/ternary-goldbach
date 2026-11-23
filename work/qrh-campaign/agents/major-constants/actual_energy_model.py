"""Explicit energy arithmetic and exact finite factor certificates. Not a Lean proof."""
import math,json
from fractions import Fraction as F
from pathlib import Path
X=4.9e26; Q=150000;L=math.log(2*X)

def factor(n):
    result=[];p=2
    while p*p<=n:
        e=0
        while n%p==0:n//=p;e+=1
        if e:result.append((p,e))
        p+=1
    if n>1:result.append((n,1))
    return result

def phi_from_factors(fs):
    r=1
    for p,e in fs:r*=p**(e-1)*(p-1)
    return r
certs=[]
for c in range(149901,150000,2):
    fs=factor(c); assert math.prod(p**e for p,e in fs)==c
    certs.append({'c':c,'factors':fs,'squarefree':all(e==1 for p,e in fs),'phi':phi_from_factors(fs)})
phi_min=min(t['phi'] for t in certs if t['squarefree'])
assert phi_min==73728
rows=[]
for D in [100000,140000,149000,149900,149990,149999]:
    vals=[]
    for c in range(D if D%2 else D+1,150000,2):
        fs=factor(c)
        if all(e==1 for p,e in fs):vals.append((phi_from_factors(fs),c))
    p,c=min(vals)
    coefficient=F(2,p*p)*F(1200000,D)*F('1.2534')**2*F('2.8')
    rows.append({'D':D,'min_phi':p,'attained_at':c,'A_bound_coefficient_of_log_2x_exact':str(coefficient),
                 'A_bound_at_x0':float(coefficient)*L,
                 'max_log_2x_for_A_9e_7':float(F('9e-7')/coefficient)})
# Rational safety checks for the proposed energy envelope coefficient.
assert F('2.719') < F('1.649')**2
assert F('1.6595')**2 < F('2.8')
assert F('0.0023')**2 *3*F('3.14')*200**3 >368
result={'warning':'Analytic derivation awaits Lean formalization. Integer factorizations exact by Python arithmetic; primality checks/factor certificates not kernel-checked. Floating values not interval-certified.',
 'x':X,'log_2x':L,'energy_bound_2_8_log_2x':2.8*L,
 'compact_main_leading_coefficient':2*math.log(2)*(1+1.5*.640205998),
 'pointwise_h_error_from_fourier_energy':math.sqrt(368/(3*math.pi*200**3)),
 'safe_pointwise_h_error':.0023,'top_conductor_contributions':rows,
 'factor_certificate_149900_to_150000':certs}
print(json.dumps(result,indent=2))
