"""Bounded stress test: at most512 further grid windows, stop at first checkpoint failure.
No full-gap run or Lean. Fixed contract theta(a) in a +/-a/24000 is never changed.
"""
from pathlib import Path
from fractions import Fraction as F
from math import isqrt,factorial
from decimal import Decimal,localcontext
import hashlib,json,time,platform,sys
H=Path(__file__).resolve().parent;check_only='--check' in sys.argv
D=10**9;WINDOW_CAP=512;POSITION_CAP=200000000
pp=H/'resume_psi_multi32_20261111.json'
assert hashlib.sha256(pp.read_bytes()).hexdigest().upper()=='03B835D97BE31AEAA9E48D9AE1A3275BD033767BE8E07EFACAE5118820151D5D'
prior=json.loads(pp.read_text());start=prior['continuation_end'];end=start;planned=0
for _ in range(WINDOW_CAP):
 b=end+end//4000
 if b-start>POSITION_CAP:break
 end=b;planned+=1
M=isqrt(end);t0=time.perf_counter();cpu0=time.process_time()
bits=bytearray(b'\x01')*(M+1);bits[:2]=b'\x00\x00'
for p in range(2,isqrt(M)+1):
 if bits[p]:
  s=p*p;bits[s:M+1:p]=b'\x00'*((M-s)//p+1)
base=[n for n,v in enumerate(bits) if v]
base2=[n for n in range(2,M+1) if all(n%d for d in range(2,isqrt(n)+1))]
assert base==base2 and M*M<=end<(M+1)**2 and start>base[-1]
base_time=time.perf_counter()-t0
fact=[factorial(i) for i in range(13)]
def T12(f):return sum(f**i/fact[i] for i in range(12))
def chklo(num,x):
 a,r=divmod(num,D);f=F(r,D)
 return F(27182818286,10**10)**a*(T12(f)+f**12*F(13,12*fact[12]))<=x
def chkhi(num,x):
 a,r=divmod(num,D)
 return x<F(27182818283,10**10)**a*T12(F(r,D))
def logbox(x):
 with localcontext() as ctx:
  ctx.prec=60;hint=int(Decimal(x).ln()*D)
 lo,hi=hint-10,hint+10
 assert chklo(lo,x) and chkhi(hi,x) and hi-lo<=100
 return lo,hi
# Replay all prior rational updates from the original source seed. No prior counts re-sieved.
p1=H/'resume_psi_short_gap_20261111.json'
assert hashlib.sha256(p1.read_bytes()).hexdigest().upper()=='E8065467BE53708445486B2F5EA5CBBE408B3A014CF2D1FA8746EC999485F595'
first=json.loads(p1.read_text());ll=20723265833
assert chklo(ll,10**9) and chkhi(20723265841,10**9)
L=F(999967635190289132,D)+first['pilot_count']*F(ll,D)
U=F(999970323068320645,D)+first['pilot_count']*F(first['pilot_log_box'][1],D)
assert L==F(first['pilot_theta_lower']) and U==F(first['pilot_theta_upper'])
a=first['pilot_endpoint'];leftlog=tuple(first['pilot_log_box'])
assert chklo(leftlog[0],a) and chkhi(leftlog[1],a)
for row in prior['windows']:
 assert row['a']==a and row['b']==a+a//4000
 rightlog=tuple(row['log_box']);b=row['b'];c=row['count']
 assert chklo(rightlog[0],b) and chkhi(rightlog[1],b)
 L+=c*F(leftlog[0],D);U+=c*F(rightlog[1],D)
 assert L==F(row['theta_lower']) and U==F(row['theta_upper'])
 a=b;leftlog=rightlog
assert a==start and L==F(prior['final_theta_lower']) and U==F(prior['final_theta_upper'])
rows=[];allhash=hashlib.sha256();total=0;minlow=None;minhigh=None;maxarrays=0;marks=0;countsec=0;logsec=0
first_mask_issue=None;stop='window_cap';failure=None
for idx in range(1,planned+1):
 b=a+a//4000;W=b-a
 if b-start>POSITION_CAP:stop='position_cap';break
 cstart=time.perf_counter();full=bytearray(b'\x01')*W
 for p in base:
  s=((a+1+p-1)//p)*p
  if s<=b:
   cnt=(b-s)//p+1;full[s-a-1:W:p]=b'\x00'*cnt;marks+=cnt
 firstodd=a+1 if (a+1)%2 else a+2;oddN=(b-firstodd)//2+1
 odd=bytearray(b'\x01')*oddN
 for p in base2[1:]:
  s=(firstodd//p)*p
  if s<firstodd:s+=p
  if s%2==0:s+=p
  if s<=b:
   j=(s-firstodd)//2;odd[j:oddN:p]=b'\x00'*((oddN-1-j)//p+1)
 assert all(full[i]==(odd[(a+1+i-firstodd)//2] if (a+1+i)%2 else 0) for i in range(W))
 maxarrays=max(maxarrays,len(full)+len(odd)+len(bits));c=full.count(1);assert c==odd.count(1)
 ph=hashlib.sha256();sub=[]
 for i,v in enumerate(full):
  if v:
   line=(str(a+1+i)+'\n').encode();ph.update(line);allhash.update(line)
 for off in range(0,W,32768):
  w=min(32768,W-off);sub.append({'n':a+off,'width':w,'count':full[off:off+w].count(1)})
 assert sum(x['count'] for x in sub)==c
 countsec+=time.perf_counter()-cstart;lstart=time.perf_counter();rightlog=logbox(b);logsec+=time.perf_counter()-lstart
 L+=c*F(leftlog[0],D);U+=c*F(rightlog[1],D)
 ml=L-(b-F(b,24000));mu=b+F(b,24000)-U;passed=ml>=0 and mu>=0
 minlow=ml if minlow is None else min(minlow,ml);minhigh=mu if minhigh is None else min(minhigh,mu)
 cap=isqrt(b)
 if cap+32768>66000 and first_mask_issue is None:
  first_mask_issue={'grid_window_index':33+idx,'endpoint':b,'sqrt_floor_cap':cap,'cap_plus32768':cap+32768}
 row={'grid_window_index':33+idx,'a':a,'b':b,'width':W,'count':c,'subwindows':sub,'log_box':list(rightlog),
 'theta_lower':str(L),'theta_upper':str(U),'lower_margin':str(ml),'upper_margin':str(mu),'checkpoint_pass':passed,
 'prime_list_sha256':ph.hexdigest(),'sqrt_floor_cap':cap}
 rows.append(row);total+=c;a=b;leftlog=rightlog
 if not passed:
  stop='first_checkpoint_failure'
  failure={'grid_window_index':33+idx,'endpoint':b,'lower_margin':str(ml),'upper_margin':str(mu),
   'enclosure_width':str(U-L),'enclosure_midpoint_minus_endpoint':str((L+U)/2-b),
   'theta_minus_endpoint_interval':[str(L-b),str(U-b)],'allowed_radius':str(F(b,24000)),
   'actual_violation_forced_by_enclosure':U<b-F(b,24000) or L>b+F(b,24000),
   'classification':'certificate_enclosure_failed; true bound violation only if forced flag is true'}
  print(json.dumps({'event':'early_stop','window':33+idx,'endpoint':b,'lower_margin':str(ml),'upper_margin':str(mu)},indent=2),flush=True)
  break
 if idx%16==0:
  print(json.dumps({'event':'progress','new_windows':idx,'endpoint':b,'positions':b-start,'seconds':time.perf_counter()-t0}),flush=True)
else:
 if planned<WINDOW_CAP:stop='position_cap'
assert len(rows)<=WINDOW_CAP and a-start<=POSITION_CAP
out={'status':'external bounded centering stress test; no Lean or full-gap run',
 'prior_multi32_sha256':hashlib.sha256(pp.read_bytes()).hexdigest(),'fixed_checkpoint_divisor':24000,
 'window_cap':WINDOW_CAP,'position_cap':POSITION_CAP,'planned_windows':planned,'planned_endpoint':end,
 'continuation_start':start,'continuation_end':a,'windows_new_computed':len(rows),
 'new_windows_passing':sum(r['checkpoint_pass'] for r in rows),'stop_reason':stop,'first_failure':failure,
 'grid_windows_total_counted_externally':33+len(rows),'remaining_grid_windows_without_external_counts':6439-33-len(rows),
 'new_positions':a-start,'total_positions_after_original_seed':a-10**9,'new_prime_count':total,
 'cumulative_primes_after_seed':prior['cumulative_primes_after_seed']+total,
 'static_sieve_base_limit':M,'static_sieve_base_prime_count':len(base),
 'actual_endpoint_sqrt_floor':isqrt(a),'static_base_requires_longer_than66000_pattern':M+32768>66000,
 'first_actual_endpoint_pattern_condition_failure':first_mask_issue,
 'subwindows_total':sum(len(r['subwindows']) for r in rows),'min_lower_margin':str(minlow),'min_upper_margin':str(minhigh),
 'final_theta_lower':str(L),'final_theta_upper':str(U),'final_theta_width':str(U-L),
 'new_prime_list_sha256':allhash.hexdigest(),'windows':rows}
stem='resume_psi_stress512_20261111'
if check_only:assert out==json.loads((H/(stem+'.json')).read_text())
else:(H/(stem+'.json')).write_text(json.dumps(out,indent=2)+'\n')
resource={'status':'external Python measurements only, no Lean timing extrapolation','python':platform.python_version(),
 'wall_seconds':time.perf_counter()-t0,'process_cpu_seconds':time.process_time()-cpu0,
 'base_construction_seconds':base_time,'dual_sieve_comparison_hash_seconds':countsec,'new_log_check_seconds':logsec,
 'full_sieve_mark_assignments_with_repeats':marks,'max_simultaneous_bytearray_payload_bytes':maxarrays,
 'memory_metric_note':'payload only; excludes lists, ints, temporary slices, allocator overhead and process RSS'}
if not check_only:(H/(stem+'.resources.json')).write_text(json.dumps(resource,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='windows'},indent=2));print(json.dumps(resource,indent=2))
