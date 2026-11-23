"""Finite rational checks only. No L-values, zeros, or spectral scan.

Decimal values below diagnose explicitly stated comparison functions, not K.
"""
from fractions import Fraction as F
from decimal import Decimal, localcontext
from pathlib import Path
import json, hashlib

b, a = F(111,200), F(7,8)
x, y, Q = 49*10**25, 10**25, 300000

def negpow(base, exponent, bits=110):
    assert exponent <= 0
    if exponent == 0: return F(1), F(1)
    n, d = -exponent.numerator, exponent.denominator
    scale=1<<bits; lo,hi=0,scale
    target=scale**d; factor=base**n
    while hi-lo>1:
        mid=(lo+hi)//2
        if mid**d*factor <= target: lo=mid
        else: hi=mid
    return F(lo,scale),F(hi,scale)

xb=negpow(x,b-a); yb=negpow(y,b-a)
def weight(beta):
    xx,yy=negpow(x,beta-a),negpow(y,beta-a)
    return max(xx[0]-xb[1],yy[0]-yb[1]), max(xx[1]-xb[0],yy[1]-yb[0])

ka=weight(a)
assert ka[0]>F(99,100)
# Exact structural profile inequalities for all high conductors.
assert 1200 > F(10**8,100000)
assert F(704,7)*1200000 > 10**8
assert F(10**8,300000)==F(1000,3)

# Corollary 6.1 RHS at sigma=a exceeds 10^220, even replacing Q by 10^5.
tz_log10_lower=F(88)+F(421+127*5,8)
assert tz_log10_lower==220 and Q>10**5
# The associated Stieltjes comparison integral exceeds 0.99*10^220.
tz_integral_lower=F(99,100)*10**220

# Ramaré's printed family bound requires T>=Q; smallest global choice T=Q.
# e<11/4 follows from 1+1+1/2 + (1/6)/(1-1/4) < 11/4.
assert F(5,2)+F(1,6)/(1-F(1,4)) < F(11,4)
assert F(11,4)**12<Q
ramare_additive_lower=32*Q**2*36**2  # log(Q^3)>36
ramare_integral_lower=F(99,100)*ramare_additive_lower
assert ramare_integral_lower>10**15

# A reflection/conjugation-compatible abstract zero multiset at one real character.
c=100003
assert all(c%p for p in range(2,317))
assert c%4==3 and c<=150000
assert F(10**8,c)>4
# Four +/- ordinate pairs at beta=a; four reflected pairs at beta=1-a.
assert 8*ka[0]>6

rows=[]
for beta in [F(3,5),F(7,10),F(3,4),F(4,5),F(17,20),a]:
    lo,hi=weight(beta)
    # If K<=6, the number of occurrences with beta>=this beta is <= floor(6/lo).
    rows.append({'beta':str(beta),'k_lower':str(lo),'k_upper':str(hi),
                 'necessary_count_upper':int(F(6)/lo)})

with localcontext() as ctx:
    ctx.prec=60
    q=Decimal(Q); aa=Decimal(7)/8
    tzlog=Decimal(88)+(Decimal(421)+127*q.log10())*(1-aa)
    ram=20*(Decimal(56)**(1-aa))*q*((q**3).ln()**(5-2*aa))+32*q*q*((q**3).ln()**2)
    # Purely diagnostic optimistic density-hypothesis-shaped comparison.
    # It is NOT an imported or asserted theorem.
    z=Decimal(y); ell=z.ln(); C=Decimal(9)*10**13; lam=2*C.ln()
    span=Decimal(8)/25
    ideal_integral=(C**(Decimal(1)/4))*ell*(((lam-ell)*span).exp()-1)/(lam-ell)
    diagnostic={'TZ_log10_RHS_at_7_8':str(tzlog),
                'Ramare_RHS_at_7_8_T_eq_Q':str(ram),
                'unasserted_unit_constant_DH_y_kernel_integral':str(ideal_integral)}

inputs=['WEIGHTED_EXCESS_CERTIFICATE_2026-11-11.md',
        '../audit/REVIEW_WEIGHTED_EXCESS_CERTIFICATE_2026-11-11.md']
pins={p:hashlib.sha256((Path(__file__).parent/p).read_bytes()).hexdigest().upper() for p in inputs}
out={'scope':'comparison bounds, not actual zero data or a proof of K<=6',
     'input_sha256':pins,'exact_TZ_integral_lower':str(tz_integral_lower),
     'exact_Ramare_integral_lower':str(ramare_integral_lower),
     'weight_rows':rows,'diagnostics_not_certified_transcendental_bounds':diagnostic}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
