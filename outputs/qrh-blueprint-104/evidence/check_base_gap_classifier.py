"""Independent reconstruction of exact classifier acceptance. Writes no peer files."""
from fractions import Fraction as F
from pathlib import Path
from math import isqrt
import json,hashlib
P=Path('work/qrh-campaign/base_gap_classifier.json')
J=json.loads(P.read_text())
N=150000; S=10**9
# Totients by least-prime recurrence, independently of the subtraction sieve.
spf=[0]*(N+1)
for p in range(2,N+1):
 if spf[p]==0:
  for n in range(p,N+1,p):
   if spf[n]==0: spf[n]=p
phi=[0]*(N+1);phi[1]=1
for n in range(2,N+1):
 p=spf[n]; m=n//p
 phi[n]=phi[m]*(p if m%p==0 else p-1)
# Independently implemented directed logarithm enclosure.
def log_u(n):
 k=0;r=F(n)
 while r>=2:r/=2;k+=1
 def series(r):
  z=(r-1)/(r+1);z2=z*z;term=z;tot=F(0)
  for j in range(24):tot+=2*term/(2*j+1);term*=z2
  return tot+2*term/(49*(1-z2))
 u=series(r)+k*series(F(2))
 return F((u.numerator*S+u.denominator-1)//u.denominator,S)
logs={q:log_u(2*q) for q in range(1000,N+1,1000)}
roots={n:F(isqrt(S*S//(2*n))+1,S) for n in range(1,N+1)}
assert all(2*n*u*u>=1 for n,u in roots.items())
covered=[];min_margin=None
for q in range(4,N+1):
 L=logs[1000*((q+999)//1000)];ph=phi[q]
 c=(F('.68')*L+F('.8764'))*roots[ph]+F('2.526')*roots[q]+(F('3.25')*L+F('7.82'))/ph+(F('13.66')*L+F('37.55'))/q+F('.000428')
 U=F('1.254')*c+F('.000709002')
 if U<=F('.04712'):
  covered.append(q);m=F('.04712')-U
  min_margin=m if min_margin is None else min(min_margin,m)
assert covered==J['covered_denominators']
old=[q for q in range(100000,N+1) if 20*q<=21*phi[q]]
assert len(covered)==49034 and len(old)==8268 and set(old)<=set(covered)
assert min(covered)==60859 and len(covered)-len(old)==40766
assert sum(spf[q]==q for q in covered)==J['covered_prime_count']==7717
# The common monotonicity domain for all classified candidates.
assert F('2.7182818286')**2<8
print('PASS: exact full acceptance list reproduced with independent totient and log implementations.')
print('accepted',len(covered),'old',len(old),'new',len(covered)-len(old),'minimum',min(covered),'primes',sum(spf[q]==q for q in covered))
print('minimum acceptance margin',min_margin)
for p in [Path('work/qrh-campaign/base_gap_classifier.py'),P]:print(hashlib.sha256(p.read_bytes()).hexdigest(),p)
