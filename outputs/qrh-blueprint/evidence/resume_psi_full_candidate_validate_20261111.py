"""Read-only exact validation of the completed candidate dataset; no new sieving.
Checks all prior+new log/centering chains, batch/receipt arithmetic and file hashes.
"""
from pathlib import Path
from fractions import Fraction as F
from math import factorial,isqrt
import json,hashlib
H=Path(__file__).resolve().parent;P=H/'psi_full_candidate_20261111';D=10**9;B=5*10**9
load=lambda p:json.loads(p.read_bytes())
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
meta=load(P/'metadata.json');mhash=sha(P/'metadata.json')
assert mhash=='0d65ec72aa1dc618558dd6abbaa6bf6f7c13873bd2fa6617f38d768c2034d160'
assert meta['script_sha256']==sha(H/'resume_psi_full_candidate_20261111.py')
assert meta['base_json_sha256']==sha(P/'base_primes.json')
assert meta['scale']==D and meta['grid_divisor']==4000 and meta['checkpoint_divisor']==10000 and meta['endpoint']==B
base=load(P/'base_primes.json');assert base['limit']==70710
primes=[n for n in range(2,70711) if all(n%d for d in range(2,isqrt(n)+1))]
assert base['primes']==primes and len(primes)==7004 and 70710**2<=B<70711**2
# Actual fixed hash is stated separately to avoid silently accepting an input mutation.
assert sha(H/'resume_psi_short_gap_20261111.json')=='e8065467be53708445486b2f5ea5cbbe408b3a014cf2d1fa8746ec999485f595'
assert sha(H/'resume_psi_multi32_20261111.json')=='03b835d97be31aeaa9e48d9ae1a3275bd033767be8e07efacae5118820151d5d'
assert sha(H/'resume_psi_stress512_20261111.json')==meta['prior_stress_json_sha256']
assert sha(H/'resume_psi_relaxed_checkpoint_20261111.json')==meta['prior_relaxation_json_sha256']
facts=[factorial(i) for i in range(13)]
def t12(f):return sum(f**i/F(facts[i]) for i in range(12))
def valid(box,x):
 lo,hi=box;q,r=divmod(lo,D);s,u=divmod(hi,D);f=F(r,D);g=F(u,D)
 return hi-lo<=100 and F(27182818286,10**10)**q*(t12(f)+f**12*F(13,12*facts[12]))<=x and x<F(27182818283,10**10)**s*t12(g)
one=load(H/'resume_psi_short_gap_20261111.json');multi=load(H/'resume_psi_multi32_20261111.json');stress=load(H/'resume_psi_stress512_20261111.json')
old=[{'grid_window_index':1,'a':10**9,'b':one['pilot_endpoint'],'count':one['pilot_count'],'subwindows':one['pilot_subwindows'],'log_box':one['pilot_log_box'],
 'theta_lower':one['pilot_theta_lower'],'theta_upper':one['pilot_theta_upper']}]+multi['windows']+stress['windows']
a=10**9;L=999967635190289132;U=999970323068320645;left=[20723265833,20723265841];index=0;totalcounts=0;subcount=0;extrema=[]
assert valid(left,a)
def step(row,oldstyle=False):
 global a,L,U,left,index,totalcounts,subcount
 b=row['b'];c=row['count'];right=row['log_box'];idx=row['grid_window_index'] if oldstyle else row['index']
 assert idx==index+1 and row['a']==a and b==min(B,a+a//4000) and valid(right,b)
 n=a
 for s in row['subwindows']:
  assert s['n']==n and 0<s['width']<=32768 and 0<=s['count']<=s['width'];n+=s['width']
 assert n==b and sum(s['count'] for s in row['subwindows'])==c
 L+=c*left[0];U+=c*right[1]
 if oldstyle:assert F(L,D)==F(row['theta_lower']) and F(U,D)==F(row['theta_upper'])
 else:
  assert row['theta_lower_scaled']==L and row['theta_upper_scaled']==U
  assert row['base_limit']==isqrt(b) and row['base_prime_count_used']==sum(p<=isqrt(b) for p in primes)
  assert row['dual_pointwise_equality'] is True and len(row['classification_sha256'])==64
 ml=L-b*(D-D//10000);mu=b*(D+D//10000)-U
 assert ml>=0 and mu>=0
 if not oldstyle:assert row['lower_margin_scaled']==ml and row['upper_margin_scaled']==mu and row['checkpoint_pass'] is True
 extrema.append({'index':idx,'endpoint':b,'lower_margin_scaled':ml,'upper_margin_scaled':mu})
 a=b;left=right;index=idx;totalcounts+=c;subcount+=len(row['subwindows'])
for row in old:step(row,True)
assert index==538 and a==meta['initial_endpoint'] and L==meta['initial_theta_lower_scaled'] and U==meta['initial_theta_upper_scaled'] and left==meta['initial_log_box']
old_counts=totalcounts;old_sub=subcount;prev=mhash;receipts=[];manifest=[]
for batchno in range(1,94):
 datafile=P/f'batch_{batchno:04d}.json';recfile=P/f'receipt_{batchno:04d}.json';batch=load(datafile);rec=load(recfile)
 assert rec['batch_number']==batchno and rec['previous_receipt_or_metadata_sha256']==prev
 assert rec['data_file']==datafile.name and rec['data_sha256']==sha(datafile)
 assert batch['metadata_sha256']==mhash and batch['scale']==D and batch['batch_number']==batchno
 assert batch['start_index']==rec['start_index']==index and batch['start_endpoint']==rec['start_endpoint']==a
 olda=a;oldi=index;oldc=totalcounts;olds=subcount
 rows=batch['windows'];assert len(rows)==(64 if batchno<93 else 13)
 for row in rows:step(row)
 assert batch['end_index']==rec['end_index']==index and batch['end_endpoint']==rec['end_endpoint']==a
 assert rec['window_count']==index-oldi and rec['positions']==a-olda and rec['prime_count']==totalcounts-oldc and rec['subwindow_count']==subcount-olds
 assert rec['all_checkpoints_pass'] is True
 assert rec['minimum_lower_margin_scaled']==min(r['lower_margin_scaled'] for r in rows)
 assert rec['minimum_upper_margin_scaled']==min(r['upper_margin_scaled'] for r in rows)
 payload=max((r['b']-r['a'])+((r['b']-(r['a']+1 if (r['a']+1)%2 else r['a']+2))//2+1)+70711 for r in rows)
 assert rec['max_bytearray_payload_excluding_slices_and_objects']==payload
 assert rec['wall_seconds']>=0 and rec['process_cpu_seconds']>=0
 prev=sha(recfile);receipts.append(rec)
 for f in [datafile,recfile]:manifest.append({'file':f.name,'sha256':sha(f),'bytes':f.stat().st_size})
complete=load(P/'COMPLETE.json')
assert a==B and index==6439 and len(old)==538
assert complete['status'].startswith('COMPLETE external') and complete['final_global_index']==index and complete['final_endpoint']==a
assert complete['new_windows']==5901 and complete['prior_external_windows']==538 and complete['remaining_uncounted_windows']==0
assert complete['all_grid_windows_counted_externally']==6439 and complete['new_positions']==B-meta['initial_endpoint']
assert complete['batch_count']==93 and complete['metadata_sha256']==mhash and complete['last_receipt_sha256']==prev
assert complete['new_prime_count']==totalcounts-old_counts and complete['prime_count_after_original_seed']==totalcounts
assert complete['scale']==D and complete['final_theta_lower_scaled']==L and complete['final_theta_upper_scaled']==U
assert complete['minimum_new_lower_margin_scaled']==min(r['lower_margin_scaled'] for r in extrema[538:])
assert complete['minimum_new_upper_margin_scaled']==min(r['upper_margin_scaled'] for r in extrema[538:])
assert complete['new_Lean_count_proofs']==0 and complete['spectral_inputs_validated'] is False
assert not list(P.glob('ERROR*')) and not (P/'STOPPED.json').exists() and not (P/'RUNNING.lock').exists() and not list(P.glob('*.tmp'))
for f in [P/'metadata.json',P/'base_primes.json',P/'COMPLETE.json']:manifest.append({'file':f.name,'sha256':sha(f),'bytes':f.stat().st_size})
assert len(manifest)==189 and len(list(P.iterdir()))==189
out={'status':'read-only exact chain/metadata/receipt validation PASS; no independent full re-sieve or Lean proof',
 'dataset_directory':P.name,'complete_sha256':sha(P/'COMPLETE.json'),'script_sha256':sha(H/'resume_psi_full_candidate_20261111.py'),
 'total_windows':index,'total_postseed_positions':B-10**9,'total_primes_after_seed':totalcounts,'new_primes':totalcounts-old_counts,
 'total_subwindows_including_prior':subcount,'new_subwindows':subcount-old_sub,
 'minimum_all_lower_margin':min(extrema,key=lambda x:x['lower_margin_scaled']),
 'minimum_all_upper_margin':min(extrema,key=lambda x:x['upper_margin_scaled']),
 'minimum_new_lower_margin':min(extrema[538:],key=lambda x:x['lower_margin_scaled']),
 'final_theta_lower':str(F(L,D)),'final_theta_upper':str(F(U,D)),'final_theta_width':str(F(U-L,D)),
 'sum_committed_batch_wall_seconds':sum(r['wall_seconds'] for r in receipts),'sum_committed_batch_cpu_seconds':sum(r['process_cpu_seconds'] for r in receipts),
 'sum_full_sieve_mark_assignments':sum(r['full_sieve_mark_assignments_with_repeats'] for r in receipts),
 'maximum_reported_bytearray_payload':max(r['max_bytearray_payload_excluding_slices_and_objects'] for r in receipts),
 'dataset_file_count':len(manifest),'dataset_bytes':sum(x['bytes'] for x in manifest),'manifest':sorted(manifest,key=lambda x:x['file'])}
(H/'resume_psi_full_candidate_validation_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='manifest'},indent=2))
