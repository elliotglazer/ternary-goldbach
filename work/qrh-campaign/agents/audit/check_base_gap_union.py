from pathlib import Path
import json,hashlib
N=150000
spf=[0]*(N+1)
for p in range(2,N+1):
 if not spf[p]:
  for n in range(p,N+1,p):
   if not spf[n]:spf[n]=p
phi=[0]*(N+1);phi[1]=1
for n in range(2,N+1):
 p=spf[n];m=n//p
 phi[n]=phi[m]*(p if m%p==0 else p-1)
R=[(50000,8,5),(60000,2,1),(100000,4,1),(120000,1001,192),(125000,11,2)]
sets=[{q for q in range(lo,N+1) if den*q<=num*phi[q]} for lo,num,den in R]
B=set.union(*sets)
Cj=json.loads(Path('work/qrh-campaign/base_gap_classifier.json').read_text())
C=set(Cj['covered_denominators']);U=B|C;rest=set(range(1,N+1))-U
Jp=Path('work/qrh-campaign/agents/major-constants/base_gap_coverage_counts.json')
J=json.loads(Jp.read_text())
def stats(s):
 prime=sum(q>1 and spf[q]==q for q in s);unit=int(1 in s)
 return dict(count=len(s),primes=prime,composites=len(s)-prime-unit,units=unit,min_Q=min(s) if s else None,max_Q=max(s) if s else None)
assert sorted(U)==J['covered_denominators'] and sorted(rest)==J['remaining_denominators']
assert len(J['covered_denominators'])==len(U) and len(J['remaining_denominators'])==len(rest)
for key,s in [('binned',B),('coarse',C),('union',U),('remaining',rest),('added_to_coarse',B-C),('coarse_outside_binned',C-B)]:assert J[key]==stats(s)
for record,s in zip(J['rectangles'],sets):assert record['covered']==stats(s)
assert C<=B and U.isdisjoint(rest) and len(U)+len(rest)==N
assert J['coarse_source_sha256']==hashlib.sha256(Path('work/qrh-campaign/base_gap_classifier.json').read_bytes()).hexdigest()
for key,s in [('union',U),('remaining',rest),('added',B-C)]:print(key,stats(s))
print('PASS: all sets, per-rectangle statistics, disjoint complement and original source hash verified.')
for p in [Path('work/qrh-campaign/agents/major-constants/base_gap_coverage_counts.py'),Jp,Path('work/qrh-campaign/agents/major-constants/BASE_GAP_BINNED.md')]:print(hashlib.sha256(p.read_bytes()).hexdigest(),p)
