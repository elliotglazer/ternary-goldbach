"""Independent bounded review of the short-gap pilot; no Lean or full-gap sieve."""
from pathlib import Path
from fractions import Fraction as Q
from math import isqrt
import hashlib,json,re
HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parent/'prime-estimates'
SRC=HERE.parents[2]/'ternary-goldbach/TernaryGoldbach/Prelim'
report=json.loads((AUTHOR/'resume_psi_short_gap_20261111.json').read_text())
A=10**9;P=1000250000;B=5*10**9;S=10**9
# Independent Eratosthenes list, unlike the author's incremental trial division.
M=isqrt(B);flags=bytearray(b'\x01')*(M+1);flags[0:2]=b'\x00\x00'
for d in range(2,isqrt(M)+1):
 if flags[d]:flags[d*d::d]=b'\x00'*((M-d*d)//d+1)
primes=[n for n in range(M+1) if flags[n]]
assert len(primes)==7004
# Odd-only segmented sieve. Index i represents A+1+2i.
first=A+1;size=(P-first)//2+1;alive=bytearray(b'\x01')*size
for d in primes:
 if d==2:continue
 if d*d>P:break
 start=max(d*d,((first+d-1)//d)*d)
 if start%2==0:start+=d
 if start>P:continue
 idx=(start-first)//2
 alive[idx::d]=b'\x00'*((size-1-idx)//d+1)
survivors=[first+2*i for i,v in enumerate(alive) if v]
assert len(survivors)==12008
sub=[]
for lo in range(A,P,32768):
 hi=min(P,lo+32768)
 sub.append({'n':lo,'width':hi-lo,'count':sum(lo<p<=hi for p in survivors)})
assert sub==report['pilot_subwindows']
sha=hashlib.sha256(('\n'.join(map(str,survivors))+'\n').encode('ascii')).hexdigest()
assert sha==report['pilot_primes_ascii_sha256']
# Confirm the literal source base and the least-factor extension.
source=(SRC/'PsiSieve3.lean').read_text(encoding='utf-8')
blocks=re.findall(r'def PS3b\d+ : List ℕ := \[([^\]]*)\]',source)
ps3=[int(x) for block in blocks for x in block.split(',')]
assert ps3==[p for p in primes if p<=31622] and len(ps3)==3401
witnesses={31623:3,31624:2,31625:5,31626:2}
assert all(n%d==0 and 1<d<n for n,d in witnesses.items())
assert P<31627**2 and P>31623**2
assert all(row['n']+row['width']<31627**2 for row in sub)
# Independently implement source rational exponent check through a recurrence.
def T12(f):
 term=Q(1);total=term
 for k in range(1,12):term=term*f/k;total+=term
 return total,term*f/12

def check_box(x,lower,upper):
 a,rem=divmod(lower,S);f=Q(rem,S);poly,term12=T12(f)
 exp_hi=Q(27182818286,10**10)**a*(poly+term12*Q(13,12))
 a,rem=divmod(upper,S);poly,_=T12(Q(rem,S))
 exp_lo=Q(27182818283,10**10)**a*poly
 assert exp_hi<=x<exp_lo
 return [str(x-exp_hi),str(exp_lo-x)]
logA=(20723265833,20723265841);logP=(20723515795,20723515815)
check_box(A,*logA);check_box(P,*logP)
assert Q(logP[1]-logP[0],S)==Q(1,50000000)<Q(1,10**7)
seedlo=Q(999967635190289132,S);seedhi=Q(999970323068320645,S)
assert seedlo>=A-Q(A,24000) and seedhi<=A+Q(A,24000)
L=seedlo+len(survivors)*Q(logA[0],S)
U=seedhi+len(survivors)*Q(logP[1],S)
assert str(L)==report['pilot_theta_lower'] and str(U)==report['pilot_theta_upper']
assert L>=P-Q(P,24000) and U<=P+Q(P,24000)
# Independent grid arithmetic only, no further prime counts.
grid=[A];chunks=0
while grid[-1]<B:
 lo=grid[-1];hi=min(B,lo+lo//4000)
 assert lo<hi and 4000*(hi-lo)<=lo
 chunks+=(hi-lo+32767)//32768;grid.append(hi)
assert len(grid)-1==6439 and chunks==125271 and grid[-1]==B
assert 70710**2<=B<70711**2 and 32768+70710<131072
pp=Q(17,360000);lowerrel=Q(1,4000)+Q(1,24000)
upperrel=Q(1,4000)+(Q(1,24000)+pp)*(1+Q(1,4000))
assert upperrel==Q(15251,45000000)
assert max(lowerrel,upperrel)<Q(1,2300)
assert Q('1.4262')/31622<pp and 31622**2<A
assert Q('2.7')**23>B and Q('2.72')**20<A
width=seedhi-seedlo
uncertainty=width/A+Q('1.387')/80000+Q(2,10**7)
assert uncertainty<Q(1,12000)
assert 2**32<=B<2**33
hashes={name:hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest() for name in ['RESUME_PSI_SHORT_GAP_2026-11-11.md','resume_psi_short_gap_20261111.py','resume_psi_short_gap_20261111.json']}
out={'status':'Independent external bounded pilot and source-contract review. No new Lean counts or full-gap data.','input_sha256':hashes,'independent_prime_method':'Eratosthenes base plus odd-only segmented sieve','pilot_count':len(survivors),'pilot_prime_sha256':sha,'subwindows':sub,'PS3_count':len(ps3),'base_count_through70710':len(primes),'pilot_height_limit':31627**2,'composite_extension_witnesses':witnesses,'theta_lower':str(L),'theta_upper':str(U),'lower_margin':str(L-P+Q(P,24000)),'upper_margin':str(P+Q(P,24000)-U),'grid_windows':len(grid)-1,'grid_chunks':chunks,'checkpoint_condition_not_proved_for_remaining':6438,'upper_relative_error':str(upperrel),'uncertainty_relative':str(uncertainty)}
(HERE/'resume_psi_short_gap_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
