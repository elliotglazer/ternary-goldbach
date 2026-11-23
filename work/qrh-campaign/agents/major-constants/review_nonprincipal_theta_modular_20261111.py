"""Exact phase/reindexing diagnostics only; no theta or spectral evaluation."""
from fractions import Fraction as F
from pathlib import Path
import json

checks=0
# Compare each original T^n summand with the proposed transformed one.
# Exponents are in units of pi*i. Their difference must be an even integer.
alphas=[F(-1,2),F(0),F(1,5),F(2,7),F(1,2),F(8,3)]
for alpha in alphas:
    for n in range(-4,5):
        for k in range(-5,6):
            original=n*(k+alpha)**2
            changed=-n*alpha*(alpha-1)+2*(k+alpha)*n*(alpha-F(1,2))
            assert original-changed==n*k*(k+1)
            assert (original-changed).denominator==1
            assert (original-changed).numerator%2==0
            checks+=1

# Characteristic integer shifts: alpha+p reindexes k to k+p; the
# residual beta+q phase is 2*pi*i*alpha*q modulo 2*pi*i*Z.
for alpha in alphas:
    for beta in [F(0),F(1,3),F(-3,7)]:
        for p in [-2,0,3]:
            for q in [-3,0,2]:
                for k in [-2,1,4]:
                    kp=k+p
                    assert k+alpha+p==kp+alpha
                    phase=(k+alpha+p)*q-alpha*q
                    assert phase.denominator==1
                    checks+=1

# Signed-to-positive parity contraction, at the level of every n term.
# Use formal fourth roots via integer exponents, with chi(-1)=(-1)^a.
for a in [0,1]:
    for n in range(1,30):
        assert (-n)**a*((-1)**a)==n**a
        checks+=1

# Even-lattice vector T phase; show an odd lattice counterexample too.
for M in range(2,25,2):
    for r in range(M):
        for k in range(-3,4):
            n=r+M*k
            phase=F(n*n-r*r,M)
            assert phase.denominator==1 and phase.numerator%2==0
            checks+=1
assert F(3**2-0**2,3)==3  # M=3 cannot use this T diagonal rule unchanged.

# S derivative cancellation: alpha*H0 + (tau'*H1-alpha*H0)=tau'*H1.
for alpha in alphas:
    for tauprime in [F(-3,7),F(2),F(5,11)]:
        for h0,h1 in [(F(1,2),F(-2,3)),(F(5),F(7,13))]:
            assert alpha*h0+(tauprime*h1-alpha*h0)==tauprime*h1
            checks+=1

out={'status':'PASS','checks':checks,
     'scope':'Exact summand phases, index changes and scalar algebra only. No S-integral, modular algorithm, theta value or spectral data checked numerically.'}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
