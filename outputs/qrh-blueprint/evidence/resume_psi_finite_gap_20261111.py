"""Finite psi-gap certificate DESIGN arithmetic; no prime counts are computed."""
from fractions import Fraction as F
from math import isqrt,log
from pathlib import Path
import json,hashlib
A=10**9;B=1600000000000000;D_seed=10**9;D_log=10**7
qlo=999967635190289132;qhi=999970323068320645
assert abs(F(qlo,D_seed)-A)<F(A,24000)
assert abs(F(qhi,D_seed)-A)<F(A,24000)
assert F('2.7182818286')**35<B
assert F('2.7')**36>B
assert 31622**2<A
assert F('1.4262',)/31622<F(17,360000)
up=F(1,6000)+(F(1,24000)+F(17,360000))*(1+F(1,6000))
low=F(1,6000)+F(1,24000)
assert up<F(1,3600) and low<F(1,3600)
a=A;n=0;mx=0;gridhash=hashlib.sha256();checkrows={}
while a<B:
 b=min(B,a+a//6000)
 assert 0<b-a<=F(a,6000)
 gridhash.update((str(a)+'\n').encode());n+=1;mx=max(mx,b-a)
 for bound in [10**10,10**11,10**12,10**13,10**14,10**15,B]:
  if a<bound<=b:checkrows[str(bound)]=n
 a=b
gridhash.update((str(B)+'\n').encode())
roots={str(k):0 for k in [2,3,4,5,50]}
for ks in roots:
 k=int(ks);lo=0;hi=B+1
 while hi-lo>1:
  md=(lo+hi)//2
  if md**k<=B:lo=md
  else:hi=md
 roots[ks]=lo
assert 2**50<=B<2**51
# A ceiling check for proposed boxes; their actual checker successes remain uncomputed.
width_ratio=F('1.387')/120000+F(2,D_log)
seed_ratio=F(qhi-qlo,D_seed*A)
assert width_ratio==F(1411,120000000)
assert seed_ratio+width_ratio<F(1,12000)
assert F('2.72')**20<A
out={'status':'design checks only; no checkpoint counts or E proof',
 'seed_denominator':D_seed,'log_width_denominator':D_log,
 'log_boxes_certified':False,'missing_new_window_counts':n,
 'range':[A,B],'windows':n,'checkpoints_including_both_endpoints':n+1,
 'grid_sha256_ascii_lines':gridhash.hexdigest(),'first_window':A//6000,'max_window':mx,
 'windows_to_decades':checkrows,'base_sieve_limit':isqrt(B),'root_floors':roots,
 'existing_32768_blocks_ceiling':(B-A+32767)//32768,
 'bit_positions_B_minus_A':B-A,'one_bit_full_span_bytes':(B-A)//8,
 'theta_checkpoint_relative_allowance':str(F(1,24000)),
 'psi_upper_relative_bound':str(up),'psi_lower_relative_bound':str(low),
 'target_conservative_relative_bound':str(F(1,3600)),
 'seed_theta_width':str(F(qhi-qlo,D_seed)),
 'max_total_count_log_width_bound_relative':str(width_ratio),
 'seed_plus_log_width_relative_bound':str(seed_ratio+width_ratio),
 'permitted_full_checkpoint_relative_width':str(F(1,12000)),
 'PNT_diagnostic_only_prime_count_at_B':B/log(B),
 'PNT_diagnostic_only_base_primes':isqrt(B)/log(isqrt(B))}
print(json.dumps(out,indent=2))
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
