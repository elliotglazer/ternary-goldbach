"""Bounded continuation: next 32 theta grid windows, externally checked only.
Two independent prime-base constructions and full/odd segmented representations.
No Lean launch, no full5e9 run, no edits to the frozen one-window artifacts.
"""
from pathlib import Path
from fractions import Fraction as F
from math import isqrt,factorial
from decimal import Decimal,localcontext
import hashlib,json,time,platform,sys
H=Path(__file__).resolve().parent
check_only='--check' in sys.argv
prior_path=H/'resume_psi_short_gap_20261111.json'
assert hashlib.sha256(prior_path.read_bytes()).hexdigest().upper()=='E8065467BE53708445486B2F5EA5CBBE408B3A014CF2D1FA8746EC999485F595'
prior=json.loads(prior_path.read_text());A=10**9;D=10**9;start=prior['pilot_endpoint']
end=start
for _ in range(32):end+=end//4000
M=isqrt(end)
t0=time.perf_counter();cpu0=time.process_time()
# Construction1: Eratosthenes through exact square-root endpoint.
base_bits=bytearray(b'\x01')*(M+1);base_bits[0:2]=b'\x00\x00'
for p in range(2,isqrt(M)+1):
 if base_bits[p]:
  s=p*p;base_bits[s:M+1:p]=b'\x00'*((M-s)//p+1)
base=[i for i,v in enumerate(base_bits) if v]
# Construction2: exhaustive small integer trial division using all d, not base1.
base2=[n for n in range(2,M+1) if all(n%d for d in range(2,isqrt(n)+1))]
assert base==base2 and M*M<=end<(M+1)*(M+1)
assert start>base[-1]
base_time=time.perf_counter()-t0
fact=[factorial(i) for i in range(13)]
def T12(f):return sum((f**i)/fact[i] for i in range(12))
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
assert chklo(20723265833,A) and chkhi(20723265841,A)
leftlog=tuple(prior['pilot_log_box'])
assert chklo(leftlog[0],start) and chkhi(leftlog[1],start)
L=F(999967635190289132,D)+prior['pilot_count']*F(20723265833,D)
U=F(999970323068320645,D)+prior['pilot_count']*F(leftlog[1],D)
assert L==F(prior['pilot_theta_lower']) and U==F(prior['pilot_theta_upper'])
a=start;rows=[];allhash=hashlib.sha256();total=0;minlow=None;minhigh=None;maxarrays=0;countsec=0;logsec=0;marks=0
for idx in range(1,33):
 b=a+a//4000;W=b-a;cstart=time.perf_counter()
 # Every position corresponds to n=a+1+i. Mark all multiples of all base primes.
 full=bytearray(b'\x01')*W
 for p in base:
  s=((a+1+p-1)//p)*p
  if s<=b:
   cnt=(b-s)//p+1;full[s-a-1:W:p]=b'\x00'*cnt;marks+=cnt
 # Independently index only odd integers. Use separate integer formula for first multiple.
 firstodd=a+1 if (a+1)%2 else a+2;oddN=(b-firstodd)//2+1
 odd=bytearray(b'\x01')*oddN
 for p in base2[1:]:
  s=(firstodd//p)*p
  if s<firstodd:s+=p
  if s%2==0:s+=p
  if s<=b:
   j=(s-firstodd)//2;odd[j:oddN:p]=b'\x00'*((oddN-1-j)//p+1)
 maxarrays=max(maxarrays,len(full)+len(odd)+len(base_bits))
 # Pointwise equality, including all composite/even endpoints, not merely equal totals.
 assert all(full[i]==(odd[(a+1+i-firstodd)//2] if (a+1+i)%2 else 0) for i in range(W))
 c=full.count(1);assert c==odd.count(1)
 primes=[a+1+i for i,v in enumerate(full) if v]
 ph=hashlib.sha256();sub=[]
 for n in primes:
  line=(str(n)+'\n').encode();ph.update(line);allhash.update(line)
 for off in range(0,W,32768):
  w=min(32768,W-off);sub.append({'n':a+off,'width':w,'count':full[off:off+w].count(1)})
 assert sum(v['count'] for v in sub)==c
 countsec+=time.perf_counter()-cstart
 lstart=time.perf_counter();rightlog=logbox(b);logsec+=time.perf_counter()-lstart
 L+=c*F(leftlog[0],D);U+=c*F(rightlog[1],D)
 ml=L-(b-F(b,24000));mu=(b+F(b,24000))-U
 minlow=ml if minlow is None else min(minlow,ml);minhigh=mu if minhigh is None else min(minhigh,mu)
 rows.append({'grid_window_index':idx+1,'a':a,'b':b,'width':W,'count':c,'subwindows':sub,
 'log_box':list(rightlog),'theta_lower':str(L),'theta_upper':str(U),
 'lower_margin':str(ml),'upper_margin':str(mu),'checkpoint_pass':ml>=0 and mu>=0,
 'prime_list_sha256':ph.hexdigest()})
 total+=c;a=b;leftlog=rightlog
assert a==end
out={'status':'external bounded32-window continuation; no Lean proof or full-gap run',
 'prior_json_sha256':hashlib.sha256(prior_path.read_bytes()).hexdigest(),
 'prior_window_count':prior['pilot_count'],'continuation_start':start,'continuation_end':end,
 'windows_new':32,'grid_windows_total_covered_externally':33,'remaining_grid_windows_without_external_counts':6439-33,
 'base_limit':M,'base_prime_count':len(base),'base_prime_list_sha256':hashlib.sha256(('\n'.join(map(str,base))+'\n').encode()).hexdigest(),
 'base_extra_vs_PS3':[p for p in base if p>31622],
 'integer_positions_new':end-start,'new_primes_total':total,'cumulative_primes_after_seed':total+prior['pilot_count'],
 'subwindows_total':sum(len(r['subwindows']) for r in rows),
 'all_checkpoints_pass':all(r['checkpoint_pass'] for r in rows),
 'min_lower_margin':str(minlow),'min_upper_margin':str(minhigh),
 'final_theta_lower':str(L),'final_theta_upper':str(U),'final_theta_width':str(U-L),
 'log_box_denominator':D,'log_box_width_limit':'1/10000000',
 'new_prime_list_sha256':allhash.hexdigest(),'windows':rows}
if check_only:
 assert out==json.loads((H/'resume_psi_multi32_20261111.json').read_text())
else:
 (H/'resume_psi_multi32_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
resource={'status':'external Python resource measurements only; not Lean estimates',
 'python':platform.python_version(),'wall_seconds':time.perf_counter()-t0,'process_cpu_seconds':time.process_time()-cpu0,
 'base_construction_seconds':base_time,'dual_sieve_and_pointwise_comparison_seconds':countsec,'log_check_seconds':logsec,
 'full_sieve_mark_assignments_with_repeats':marks,'max_simultaneous_bytearray_payload_bytes':maxarrays,
 'memory_metric_note':'payload count excludes Python lists, ints, temporary slices, allocator overhead and process RSS'}
if not check_only:
 (H/'resume_psi_multi32_20261111.resources.json').write_text(json.dumps(resource,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='windows'},indent=2));print(json.dumps(resource,indent=2))
