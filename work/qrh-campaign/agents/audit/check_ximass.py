from fractions import Fraction as F
from math import factorial
from pathlib import Path
import re, json, hashlib
root=Path(__file__).resolve().parents[1]
p=root/'prime-estimates'/'XiMass.lean'
s=p.read_text(encoding='utf-8')
body=s.split('private def logTable',1)[1].split(':= [',1)[1].split(']',1)[0]
pairs=[tuple(map(int,m)) for m in re.findall(r'\((\d+),\s*(\d+)\)',body)]
assert len(pairs)==len(dict(pairs))==303
primes=[]
for n in range(2,2001):
    if all(n%p for p in primes if p*p<=n): primes.append(n)
assert [p for p,c in pairs]==primes
data=(root/'prime-estimates'/'XiMassLogData.txt').read_text()
assert pairs==[tuple(map(int,m)) for m in re.findall(r'\((\d+),\s*(\d+)\)',data)]
D=1000000
for p,c in pairs:
    a,r=divmod(c,D); f=F(r,D)
    t=sum((f**i/factorial(i) for i in range(12)),F())
    assert F(27182818286,10**10)**a*(t+f**12*F(13,12*factorial(12)))<=p
terms={}
for p,c in pairs:
    n=p
    while n<=2000:
        assert n not in terms
        terms[n]=F(c,D*n*n)
        n*=p
assert len(terms)==333
S=sum(terms.values(),F()); assert S>=F(56945,100000)
H=sum((F(1,n) for n in range(1,1001)),F()); assert H>=F(748547086,100000000)
a,r=divmod(6908755,D); f=F(r,D)
assert 1001<F(27182818283,10**10)**a*sum((f**i/factorial(i) for i in range(12)),F())
gamma=F(748547086,100000000)-F(6908755,D)
assert gamma>F(576715,D)
W=F(3,2)-F(11447,10000)/2-F(576715,D)/2-F(56945,100000)
assert W<F(7,100)
print(json.dumps(dict(sha256=hashlib.sha256((root/'prime-estimates'/'XiMass.lean').read_bytes()).hexdigest().upper(), table_entries=len(pairs), prime_power_terms=len(terms), finite_sum=float(S), finite_sum_margin=float(S-F(56945,100000)), harmonic_margin=float(H-F(748547086,100000000)), gamma_lower=str(gamma), xi_upper=str(W), target_margin=str(F(7,100)-W)),indent=2))

