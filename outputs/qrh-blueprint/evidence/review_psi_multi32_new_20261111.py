"""Independent new 32-window audit, with one contiguous sieve and exact logs.

Does not import or execute producer code. Writes only new reviewer artifacts.
No Lean launch, theorem certificate, or extension beyond the recorded pilot.
"""
from pathlib import Path
from fractions import Fraction as Q
from math import isqrt, factorial
import re, hashlib, json, time

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
ROOT=AGENTS.parents[2]
P=AGENTS/'prime-estimates'
INPUT=P/'resume_psi_multi32_20261111.json'
PRIOR=P/'resume_psi_short_gap_20261111.json'
REPORT=P/'RESUME_PSI_MULTI32_2026-11-11.md'
PRODUCER=P/'resume_psi_multi32_20261111.py'
RESOURCES=P/'resume_psi_multi32_20261111.resources.json'
SOURCE=ROOT/'work/ternary-goldbach/TernaryGoldbach/Prelim'
data=json.loads(INPUT.read_bytes()); prior=json.loads(PRIOR.read_bytes())
assert hashlib.sha256(PRIOR.read_bytes()).hexdigest()==data['prior_json_sha256']
t0=time.perf_counter()

# Derive every grid endpoint, including the cap at 5e9. No producer grid reuse.
grid=[10**9]
while grid[-1]<5*10**9:
    a=grid[-1]
    grid.append(min(5*10**9,a+a//4000))
assert len(grid)-1==6439
assert grid[1]==prior['pilot_endpoint']==data['continuation_start']
assert grid[33]==data['continuation_end']==1008283069
assert data['remaining_grid_windows_without_external_counts']==len(grid)-1-33==6406

# One full-width sieve for all 33 windows, not the producer's per-window
# full/odd arrays. Base enumeration trial-divides by every positive candidate.
lo=grid[0]+1;hi=grid[33];limit=isqrt(hi)
base=[]
for n in range(2,limit+1):
    prime=True
    for d in range(2,isqrt(n)+1):
        if n%d==0:
            prime=False;break
    if prime:base.append(n)
assert limit==data['base_limit']==31753 and len(base)==data['base_prime_count']==3415
assert limit*limit<=hi<(limit+1)**2
ps3_text=(SOURCE/'PsiSieve3.lean').read_text(encoding='utf-8')
ps3=[]
for j in range(8):
    match=re.search(r'def PS3b'+str(j)+r'\s*:\s*List ℕ := \[([^\]]*)\]',ps3_text)
    assert match
    ps3.extend(map(int,re.findall(r'\d+',match[1])))
assert ps3==[p for p in base if p<=31622] and len(ps3)==3401
extra=[p for p in base if p>31622]
assert extra==data['base_extra_vs_PS3'] and len(extra)==14
assert hashlib.sha256(('\n'.join(map(str,base))+'\n').encode()).hexdigest()==data['base_prime_list_sha256']
bits=bytearray([1])*(hi-lo+1)
for p in base:
    offset=(-lo)%p
    # lo > every p, so marking this complete progression never removes p.
    assert lo>p and (lo+offset)%p==0 and 0<=offset<p
    for k in range(offset,len(bits),p):
        bits[k]=0
square=31627**2
assert square==1000267129 and grid[1]<square<grid[2]
assert 31627 in base and all(square%p for p in ps3)
assert bits[square-lo]==0

def interval_count(a,b):
    assert grid[0]<=a<=b<=grid[33]
    return bits[a-grid[0]:b-grid[0]].count(1)
def prime_hash(a,b):
    h=hashlib.sha256()
    for offset in range(a-grid[0],b-grid[0]):
        if bits[offset]:h.update((str(lo+offset)+'\n').encode())
    return h.hexdigest()

assert interval_count(grid[0],grid[1])==prior['pilot_count']==12008
assert prime_hash(grid[0],grid[1])==prior['pilot_primes_ascii_sha256']
for row in prior['pilot_subwindows']:
    assert interval_count(row['n'],row['n']+row['width'])==row['count']
assert prime_hash(grid[1],grid[33])==data['new_prime_list_sha256']

# Independent log enclosure via range reduction and the atanh series.
def unit_log(v,N=48):
    z=(v-1)/(v+1)
    assert 0<=z<=Q(1,3)
    partial=2*sum((z**(2*j+1)/Q(2*j+1) for j in range(N)),Q(0))
    rem=2*z**(2*N+1)/((2*N+1)*(1-z*z))
    return partial,partial+rem
l2,u2=unit_log(Q(2))
def exact_log(x):
    k=x.bit_length()-1
    l,u=unit_log(Q(x,2**k))
    return l+k*l2,u+k*u2
D=10**9
def source_checks(x,box):
    lower,upper=map(int,box)
    l,u=exact_log(x)
    assert Q(lower,D)<=l and u<Q(upper,D)
    assert 0<=upper-lower<=100
    # Re-evaluate the source chkLow/chkStep formulas using Horner form.
    def truncated(f):
        s=Q(1,factorial(11))
        for j in range(10,-1,-1):s=s*f+Q(1,factorial(j))
        return s
    a,r=divmod(lower,D);f=Q(r,D)
    assert Q(27182818286,10**10)**a*(truncated(f)+f**12*Q(13,12*factorial(12)))<=x
    a,r=divmod(upper,D);f=Q(r,D)
    assert x<Q(27182818283,10**10)**a*truncated(f)

seed_lo=999967635190289132;seed_hi=999970323068320645
source_main=(SOURCE/'PsiSieveMain.lean').read_text(encoding='utf-8')
assert re.search(r'theorem stg2813.*?InvT 1000000000 '+str(seed_lo)+' '+str(seed_hi),source_main,re.S)
seed_box=[20723265833,20723265841]
source_checks(grid[0],seed_box)
source_checks(grid[1],prior['pilot_log_box'])
L=Q(seed_lo,D)+prior['pilot_count']*Q(seed_box[0],D)
U=Q(seed_hi,D)+prior['pilot_count']*Q(prior['pilot_log_box'][1],D)
assert L==Q(prior['pilot_theta_lower']) and U==Q(prior['pilot_theta_upper'])
assert L>=grid[1]-Q(grid[1],24000) and U<=grid[1]+Q(grid[1],24000)
left_box=prior['pilot_log_box'];new_count=0;subcount=0;mlist=[];ulist=[]
for idx,row in enumerate(data['windows'],start=2):
    a,b=grid[idx-1],grid[idx]
    assert row['grid_window_index']==idx and row['a']==a and row['b']==b and row['width']==b-a
    c=interval_count(a,b)
    assert c==row['count'] and prime_hash(a,b)==row['prime_list_sha256']
    cursor=a
    for sub in row['subwindows']:
        assert sub['n']==cursor and sub['width']==min(32768,b-cursor)
        assert interval_count(cursor,cursor+sub['width'])==sub['count']
        cursor+=sub['width'];subcount+=1
    assert cursor==b and sum(s['count'] for s in row['subwindows'])==c
    source_checks(b,row['log_box'])
    assert row['log_box'][1]-row['log_box'][0]==20
    L+=c*Q(left_box[0],D);U+=c*Q(row['log_box'][1],D)
    assert L==Q(row['theta_lower']) and U==Q(row['theta_upper'])
    ml=L-b+Q(b,24000);mu=b+Q(b,24000)-U
    assert ml==Q(row['lower_margin'])>=0 and mu==Q(row['upper_margin'])>=0
    assert row['checkpoint_pass']
    mlist.append(ml);ulist.append(mu);left_box=row['log_box'];new_count+=c
assert len(data['windows'])==32 and subcount==data['subwindows_total']==256
assert new_count==data['new_primes_total']==387673
assert new_count+prior['pilot_count']==data['cumulative_primes_after_seed']==399681
assert Q(data['final_theta_lower'])==L and Q(data['final_theta_upper'])==U
assert Q(data['final_theta_width'])==U-L
assert Q(data['min_lower_margin'])==min(mlist) and Q(data['min_upper_margin'])==min(ulist)
assert data['all_checkpoints_pass'] and data['grid_windows_total_covered_externally']==33
assert data['integer_positions_new']==grid[33]-grid[1]==8033069
assert data['log_box_denominator']==D and Q(data['log_box_width_limit'])==Q(1,10**7)
chunks=sum((b-a+32767)//32768 for a,b in zip(grid,grid[1:]))
assert chunks==125271 and chunks-264==125007
lower_index=min(range(32),key=lambda j:mlist[j])+2
upper_index=min(range(32),key=lambda j:ulist[j])+2
assert lower_index==14 and grid[lower_index]==1003505688
assert upper_index==31 and grid[upper_index]==1007779118
assert len(INPUT.read_bytes())==46498
assert 31754**2==1008316516>grid[33]
assert 32768+31753<66000
res=json.loads(RESOURCES.read_bytes())
marks=sum(b//p-a//p for a,b in zip(grid[1:33],grid[2:34]) for p in base)
payload=max((b-a)+((b+1)//2-(a+1)//2)+(limit+1)
            for a,b in zip(grid[1:33],grid[2:34]))
assert marks==res['full_sieve_mark_assignments_with_repeats']==20889317
assert payload==res['max_simultaneous_bytearray_payload_bytes']==409765

out={'status':'PASS independent external pilot review only; no kernel-checked continuation',
     'input_sha256':hashlib.sha256(INPUT.read_bytes()).hexdigest(),
     'prior_sha256':hashlib.sha256(PRIOR.read_bytes()).hexdigest(),
     'producer_pins':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in [REPORT,PRODUCER,RESOURCES]},
     'method':'one contiguous sieve, independent trial-division base, source PS3 parse, atanh log boxes and Horner source checks',
     'range_checked':[grid[0],grid[33]],'new_range':[grid[1],grid[33]],
     'new_subcounts_checked':subcount,'prior_subcounts_rechecked':8,
     'new_prime_count':new_count,'new_prime_hash':prime_hash(grid[1],grid[33]),
     'base_limit':limit,'base_count':len(base),'extra_base_primes':extra,
     'old_base_counterexample':square,
     'remaining_grid_windows':len(grid)-1-33,'remaining_grid_aligned_subwindows':chunks-264,
     'remaining_integer_span':5*10**9-grid[33],
     'min_lower_margin':str(min(mlist)),'min_upper_margin':str(min(ulist)),
     'minimum_margin_grid_indices':[lower_index,upper_index],
     'resource_integer_counts_verified':{'marks_with_repeats':marks,'bytearray_payload':payload},
     'final_theta_lower':str(L),'final_theta_upper':str(U),
     'review_elapsed_seconds':time.perf_counter()-t0}
(HERE/'review_psi_multi32_new_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
