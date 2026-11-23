"""One-window external pilot and exact short-gap design; no Lean or full-gap sieve."""
from fractions import Fraction as F
from pathlib import Path
from math import isqrt,factorial
from decimal import Decimal,localcontext
import re,json,hashlib,time
H=Path(__file__).resolve().parent;root=H.parents[2]
A=10**9;B=5*10**9;P=A+A//4000;D=10**9
assert F('2.7')**23>B and F('2.72')**20<A
assert isqrt(B)==70710 and 70711**2>B
up=F(1,4000)+(F(1,24000)+F(17,360000))*(1+F(1,4000))
assert F('1.387')/80000+F(2,10**7)+F(2687878031513,10**18)<F(1,12000)
assert up<F(1,2300) and F(1,4000)+F(1,24000)<F(1,2300)
a=A;windows=0;chunks=0
while a<B:
 b=min(B,a+a//4000);windows+=1;chunks+=(b-a+32767)//32768;a=b
# Base-prime list from an elementary independent trial-division loop.
t0=time.monotonic();base=[]
for n in range(2,70711):
 prime=True
 for p in base:
  if p*p>n:break
  if n%p==0:prime=False;break
 if prime:base.append(n)
source=(root/'ternary-goldbach/TernaryGoldbach/Prelim/PsiSieve3.lean').read_text(encoding='utf-8')
blocks=re.findall(r'def PS3b\d+ : List ℕ := \[([^\]]*)\]',source)
ps3=[int(v.strip()) for block in blocks for v in block.split(',')]
assert ps3==[p for p in base if p<=31622]
assert all(any(n%p==0 for p in [2,3,5]) for n in range(31623,31627))
assert P<31627**2
# Sieve only (A,P]; save smallest factor witnesses for all rejected entries.
W=P-A;factor=[0]*W
for p in ps3:
 start=((A+1+p-1)//p)*p
 for n in range(start,P+1,p):
  i=n-A-1
  if factor[i]==0:factor[i]=p
survivors=[A+1+i for i,f in enumerate(factor) if not f]
assert all(f==0 or (A+1+i)%f==0 for i,f in enumerate(factor))
# Independent trial-division of every survivor, using exact integer roots.
for n in survivors:
 assert all(n%p for p in base if p<=isqrt(n))
counts=[]
for off in range(0,W,32768):
 w=min(32768,W-off);c=sum(f==0 for f in factor[off:off+w])
 counts.append({'n':A+off,'width':w,'count':c})
assert sum(r['count'] for r in counts)==len(survivors)
# Actual rational Small.chkLow/chkStep formulas; Decimal log is only a search hint.
def T12(f):return sum(f**i/F(factorial(i)) for i in range(12))
def chklo(num,x):
 a,r=divmod(num,D);f=F(r,D)
 return F(27182818286,10**10)**a*(T12(f)+f**12*F(13,12*factorial(12)))<=x
def chkhi(num,x):
 a,r=divmod(num,D)
 return x<F(27182818283,10**10)**a*T12(F(r,D))
with localcontext() as ctx:
 ctx.prec=60;hint=int(Decimal(P).ln()*D)
lo=hint-10;hi=hint+10
assert chklo(lo,P) and chkhi(hi,P) and hi-lo<=100
assert chklo(20723265833,A) and chkhi(20723265841,A)
qlo=999967635190289132;qhi=999970323068320645;c=len(survivors)
L=F(qlo,D)+c*F(20723265833,D);U=F(qhi,D)+c*F(hi,D)
assert L>=P-F(P,24000) and U<=P+F(P,24000)
out={'status':'external one-window pilot only; no Lean proof or full-gap counts',
 'range':[A,B],'grid_divisor':4000,'grid_windows':windows,'grid_checkpoints':windows+1,
 'grid_aligned_32768_chunks':chunks,'unbroken_32768_chunks':(B-A+32767)//32768,
 'full_span_bits':B-A,'full_span_bytes':(B-A)//8,'base_limit':70710,
 'mask_list_bytes_131072_bits_each':len(base)*131072//8,
 'upper_mask_visits_at_32768_chunks':chunks*len(base),
 'base_prime_count_external':len(base),'existing_PS3_prime_count':len(ps3),
 'prime_upper_relative_bound':str(up),'conservative_E_relative_bound':str(F(1,2300)),
 'pilot_endpoint':P,'pilot_count':c,'pilot_subwindows':counts,
 'pilot_log_box_denominator':D,'pilot_log_box':[lo,hi],
 'pilot_theta_lower':str(L),'pilot_theta_upper':str(U),
 'pilot_theta_lower_decimal':str(float(L)),'pilot_theta_upper_decimal':str(float(U)),
 'pilot_checkpoint_lower_margin':str(L-(P-F(P,24000))),
 'pilot_checkpoint_upper_margin':str(P+F(P,24000)-U),
 'pilot_primes_ascii_sha256':hashlib.sha256(('\n'.join(map(str,survivors))+'\n').encode()).hexdigest(),
 'remaining_grid_windows_without_external_counts':windows-1}
print(json.dumps(out,indent=2));(H/'resume_psi_short_gap_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
