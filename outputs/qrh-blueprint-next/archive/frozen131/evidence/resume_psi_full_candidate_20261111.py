"""Resumable external candidate generation for all remaining short-gap windows.
No Lean proof. Atomic64-window data/receipt commits, stop on any discrepancy.
"""
from pathlib import Path
from fractions import Fraction as F
from decimal import Decimal,localcontext
from math import isqrt,factorial
from bisect import bisect_right
import argparse,hashlib,json,os,platform,sys,time,traceback
H=Path(__file__).resolve().parent;OUT=H/'psi_full_candidate_20261111';OUT.mkdir(exist_ok=True)
D=10**9;B=5*10**9;BATCH=64;BASEMAX=70710
args=argparse.ArgumentParser();args.add_argument('--max-batches',type=int,default=0);opt=args.parse_args()
def digest_bytes(b):return hashlib.sha256(b).hexdigest()
def raw(obj):return (json.dumps(obj,indent=2)+'\n').encode()
def read(path):return json.loads(path.read_bytes())
def put(path,obj):
 data=raw(obj)
 if path.exists():
  assert path.read_bytes()==data,('existing artifact differs',str(path))
 else:
  tmp=path.with_name(path.name+'.tmp');tmp.write_bytes(data);os.replace(tmp,path)
 return digest_bytes(data)
def pin(path,expected):
 data=path.read_bytes();assert digest_bytes(data).upper()==expected;return json.loads(data)
stress=pin(H/'resume_psi_stress512_20261111.json','EADD08660ECD980AEEDBC12F87EB495BC2432F56C6C4A8DC626C4C699B67E593')
relax=pin(H/'resume_psi_relaxed_checkpoint_20261111.json','BAB7CB9CC59412DA30C6FF9869AE6FCFB02C5E45B70D9ADB1D686858A2EBA928')
assert relax['all_existing_endpoints_pass_alternative'] and relax['computed_endpoints_after_seed']==538
assert stress['continuation_end']==1143945143 and stress['grid_windows_total_counted_externally']==538
initial_a=stress['continuation_end'];initial_L=F(stress['final_theta_lower'])*D;initial_U=F(stress['final_theta_upper'])*D
assert initial_L.denominator==initial_U.denominator==1
initial_L=int(initial_L);initial_U=int(initial_U);initial_log=stress['windows'][-1]['log_box']
assert initial_L>=initial_a*(D-D//10000) and initial_U<=initial_a*(D+D//10000)
lock=OUT/'RUNNING.lock';fd=os.open(lock,os.O_CREAT|os.O_EXCL|os.O_WRONLY)
os.write(fd,raw({'pid':os.getpid(),'script':str(Path(__file__).resolve())}));os.close(fd)
try:
 t0=time.perf_counter();cpu0=time.process_time()
 bits=bytearray(b'\x01')*(BASEMAX+1);bits[:2]=b'\x00\x00'
 for p in range(2,isqrt(BASEMAX)+1):
  if bits[p]:
   s=p*p;bits[s:BASEMAX+1:p]=b'\x00'*((BASEMAX-s)//p+1)
 base=[i for i,v in enumerate(bits) if v]
 base2=[n for n in range(2,BASEMAX+1) if all(n%d for d in range(2,isqrt(n)+1))]
 assert base==base2 and len(base)==7004 and BASEMAX**2<=B<(BASEMAX+1)**2
 base_sha=put(OUT/'base_primes.json',{'status':'external complete base enumeration; not Lean-validated','limit':BASEMAX,'primes':base,'independent_constructions':'Eratosthenes and exhaustive integer trial division'})
 meta={'status':'external candidate certificates only; no Lean or finite-zeta proof','format_version':1,
 'script_sha256':digest_bytes(Path(__file__).read_bytes()),'base_json_sha256':base_sha,'initial_endpoint':initial_a,
 'initial_global_index':538,'initial_theta_lower_scaled':initial_L,'initial_theta_upper_scaled':initial_U,
 'initial_log_box':initial_log,'scale':D,'log_box_width_limit_scaled':100,
 'grid_divisor':4000,'checkpoint_divisor':10000,'endpoint':B,'remaining_windows_expected':5901,'batch_windows':BATCH,
 'prior_stress_json_sha256':digest_bytes((H/'resume_psi_stress512_20261111.json').read_bytes()),
 'prior_relaxation_json_sha256':digest_bytes((H/'resume_psi_relaxed_checkpoint_20261111.json').read_bytes()),
 'classification_hash_format':'SHA256 of W bytes; byte i is1 iff n=a+1+i survives complete sieve, otherwise0; n in(a,b]',
 'proof_status':'all new counts/logs external; no new Lean count proofs'}
 meta_sha=put(OUT/'metadata.json',meta)
 facts=[factorial(i) for i in range(13)]
 def t12(f):return sum(f**i/F(facts[i]) for i in range(12))
 def valid(box,x):
  lo,hi=box;q,r=divmod(lo,D);f=F(r,D);s,u=divmod(hi,D);g=F(u,D)
  return hi-lo<=100 and F(27182818286,10**10)**q*(t12(f)+f**12*F(13,12*facts[12]))<=x and x<F(27182818283,10**10)**s*t12(g)
 def logbox(x):
  with localcontext() as ctx:
   ctx.prec=60;hint=int(Decimal(x).ln()*D)
  box=[hint-10,hint+10];assert valid(box,x),('log failure',x,box);return box
 assert valid(initial_log,initial_a)
 def advance(rows,state,require_pass=True):
  a,L,U,left,index=state
  for row in rows:
   b=row['b'];c=row['count'];right=row['log_box']
   assert row['index']==index+1 and row['a']==a and b==min(B,a+a//4000)
   assert valid(right,b)
   n=a
   for sub in row['subwindows']:
    assert sub['n']==n and 0<sub['width']<=32768 and 0<=sub['count']<=sub['width'];n+=sub['width']
   assert n==b and sum(v['count'] for v in row['subwindows'])==c
   L+=c*left[0];U+=c*right[1]
   assert L==row['theta_lower_scaled'] and U==row['theta_upper_scaled']
   ml=L-b*(D-D//10000);mu=b*(D+D//10000)-U
   assert ml==row['lower_margin_scaled'] and mu==row['upper_margin_scaled']
   assert row['checkpoint_pass']==(ml>=0 and mu>=0)
   if require_pass:assert row['checkpoint_pass']
   a=b;left=right;index+=1
  return a,L,U,left,index
 state=(initial_a,initial_L,initial_U,initial_log,538);prev=meta_sha;batchno=0;prior_new_primes=0;global_min_lo=None;global_min_hi=None
 # A receipt is the transaction commit. Revalidate every committed arithmetic chain.
 receipts=sorted(OUT.glob('receipt_*.json'))
 for receipt_path in receipts:
  batchno+=1;assert receipt_path.name==f'receipt_{batchno:04d}.json'
  receipt=read(receipt_path);assert receipt['previous_receipt_or_metadata_sha256']==prev
  data_path=OUT/receipt['data_file'];data_bytes=data_path.read_bytes();assert digest_bytes(data_bytes)==receipt['data_sha256']
  batch=json.loads(data_bytes);assert batch['batch_number']==batchno and batch['start_index']==state[4] and batch['start_endpoint']==state[0]
  state=advance(batch['windows'],state)
  assert receipt['end_index']==state[4] and receipt['end_endpoint']==state[0]
  prior_new_primes+=sum(r['count'] for r in batch['windows'])
  for r in batch['windows']:
   global_min_lo=r['lower_margin_scaled'] if global_min_lo is None else min(global_min_lo,r['lower_margin_scaled'])
   global_min_hi=r['upper_margin_scaled'] if global_min_hi is None else min(global_min_hi,r['upper_margin_scaled'])
  prev=digest_bytes(receipt_path.read_bytes())
 print(json.dumps({'event':'started_or_resumed','pid':os.getpid(),'committed_batches':batchno,'index':state[4],'endpoint':state[0],'remaining_windows':6439-state[4]}),flush=True)
 if (OUT/'STOPPED.json').exists():raise RuntimeError('STOPPED.json exists: review failure before any continuation')
 done_this_run=0;new_primes=prior_new_primes;failure=None
 while state[0]<B and (not opt.max_batches or done_this_run<opt.max_batches):
  start_state=state;a,L,U,left,index=state;rows=[];bt=time.perf_counter();bcpu=time.process_time();marks=0;maxpayload=0
  for _ in range(BATCH):
   if a>=B:break
   b=min(B,a+a//4000);W=b-a;limit=isqrt(b);nb=bisect_right(base,limit)
   full=bytearray(b'\x01')*W
   for p in base[:nb]:
    s=((a+1+p-1)//p)*p
    if s<=b:
     cnt=(b-s)//p+1;full[s-a-1:W:p]=b'\x00'*cnt;marks+=cnt
   firstodd=a+1 if (a+1)%2 else a+2;oddN=(b-firstodd)//2+1;odd=bytearray(b'\x01')*oddN
   for p in base2[1:nb]:
    s=(firstodd//p)*p
    if s<firstodd:s+=p
    if s%2==0:s+=p
    if s<=b:
     j=(s-firstodd)//2;odd[j:oddN:p]=b'\x00'*((oddN-1-j)//p+1)
   parity_offset=firstodd-(a+1)
   assert full[parity_offset::2]==odd,('dual odd mismatch',a,b)
   assert full[1-parity_offset::2].count(1)==0,('dual even mismatch',a,b)
   c=full.count(1);assert c==odd.count(1)
   sub=[]
   for off in range(0,W,32768):
    w=min(32768,W-off);sub.append({'n':a+off,'width':w,'count':full[off:off+w].count(1)})
   assert sum(s['count'] for s in sub)==c
   right=logbox(b);L+=c*left[0];U+=c*right[1];ml=L-b*(D-D//10000);mu=b*(D+D//10000)-U
   row={'index':index+1,'a':a,'b':b,'count':c,'subwindows':sub,'log_box':right,'theta_lower_scaled':L,'theta_upper_scaled':U,
    'lower_margin_scaled':ml,'upper_margin_scaled':mu,'checkpoint_pass':ml>=0 and mu>=0,
    'classification_sha256':digest_bytes(full),'base_limit':limit,'base_prime_count_used':nb,'dual_pointwise_equality':True}
   rows.append(row);maxpayload=max(maxpayload,len(full)+len(odd)+len(bits));new_primes+=c
   a=b;left=right;index+=1
   global_min_lo=ml if global_min_lo is None else min(global_min_lo,ml);global_min_hi=mu if global_min_hi is None else min(global_min_hi,mu)
   if not row['checkpoint_pass']:
    failure={'status':'failed relaxed checkpoint; no further counting','index':index,'endpoint':a,'lower_margin_scaled':ml,'upper_margin_scaled':mu,'scale':D};break
  next_state=(a,L,U,left,index);assert advance(rows,start_state,require_pass=not bool(failure))==next_state
  batchno+=1
  batch={'status':'external candidate batch; not Lean-validated','batch_number':batchno,'metadata_sha256':meta_sha,
   'start_index':start_state[4],'start_endpoint':start_state[0],'end_index':index,'end_endpoint':a,'scale':D,'windows':rows}
  filename=f'batch_{batchno:04d}.json';data_sha=put(OUT/filename,batch)
  receipt={'status':'external batch arithmetic and dual-representation checks complete' if not failure else 'failed checkpoint candidate batch',
   'batch_number':batchno,'previous_receipt_or_metadata_sha256':prev,'data_file':filename,'data_sha256':data_sha,
   'start_index':start_state[4],'end_index':index,'start_endpoint':start_state[0],'end_endpoint':a,
   'window_count':len(rows),'positions':a-start_state[0],'prime_count':sum(r['count'] for r in rows),
   'subwindow_count':sum(len(r['subwindows']) for r in rows),'all_checkpoints_pass':all(r['checkpoint_pass'] for r in rows),
   'minimum_lower_margin_scaled':min(r['lower_margin_scaled'] for r in rows),'minimum_upper_margin_scaled':min(r['upper_margin_scaled'] for r in rows),
   'wall_seconds':time.perf_counter()-bt,'process_cpu_seconds':time.process_time()-bcpu,
   'full_sieve_mark_assignments_with_repeats':marks,'max_bytearray_payload_excluding_slices_and_objects':maxpayload,
   'python':platform.python_version(),'resource_scope':'external Python only; no Lean timing prediction'}
  prev=put(OUT/f'receipt_{batchno:04d}.json',receipt);state=next_state;done_this_run+=1
  print(json.dumps({'event':'batch_committed','batch':batchno,'index':index,'endpoint':a,'remaining':6439-index,'seconds':receipt['wall_seconds'],'all_pass':not bool(failure)}),flush=True)
  if failure:put(OUT/'STOPPED.json',{**failure,'receipt_sha256':prev});break
 if state[0]==B and not failure:
  assert state[4]==6439 and state[4]-538==5901
  summary={'status':'COMPLETE external candidate dataset; no Lean or finite-zeta proof','final_endpoint':B,'final_global_index':6439,
   'new_windows':5901,'prior_external_windows':538,'all_grid_windows_counted_externally':6439,'remaining_uncounted_windows':0,
   'new_positions':B-initial_a,'new_prime_count':new_primes,'prime_count_after_original_seed':stress['cumulative_primes_after_seed']+new_primes,
   'batch_count':batchno,'metadata_sha256':meta_sha,'last_receipt_sha256':prev,'final_theta_lower_scaled':state[1],
   'final_theta_upper_scaled':state[2],'scale':D,'minimum_new_lower_margin_scaled':global_min_lo,'minimum_new_upper_margin_scaled':global_min_hi,
   'new_Lean_count_proofs':0,'spectral_inputs_validated':False}
  put(OUT/'COMPLETE.json',summary);print(json.dumps({'event':'complete','batch_count':batchno,'new_windows':5901,'endpoint':B,'new_primes':new_primes}),flush=True)
 else:print(json.dumps({'event':'stopped_or_batch_limit','index':state[4],'endpoint':state[0],'failure':failure}),flush=True)
 print(json.dumps({'event':'process_exit','pid':os.getpid(),'wall_seconds_this_process':time.perf_counter()-t0,'cpu_seconds_this_process':time.process_time()-cpu0}),flush=True)
except KeyboardInterrupt:
 print(json.dumps({'event':'interrupted','message':'committed receipts preserved; uncommitted current batch may be recomputed'}),flush=True);raise
except Exception:
 trace=traceback.format_exc();print(trace,flush=True)
 (OUT/f'ERROR_{os.getpid()}.txt').write_text(trace)
 raise
finally:
 if lock.exists() and read(lock).get('pid')==os.getpid():lock.unlink()
