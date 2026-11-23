"""Scalar widths/circuits and toy recurrence partitions; no primes or source bitmap."""
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
HERE=Path(__file__).resolve().parent
PINS={
 'work/qrh-campaign/agents/zero-sum/BINARY_SOURCE_WORD_STREAM_ACCEPTANCE_2026-11-11.md':'03BD20DF832348BD00967140D61E60D5A00CE7CA936E22DFAEA4EC1D6B39538F',
 'work/qrh-campaign/agents/zero-sum/binary_source_word_stream_metadata_20261111.json':'6363C29B990DF24D848ED2A2254A4C8E8F70B08C47F820940E522BEA254B58DC',
 'work/qrh-campaign/agents/prime-estimates/REVIEW_BINARY_SOURCE_WORD_STREAM_ACCEPTANCE_2026-11-11.md':'D1A2CF72DB22ADF01F8ABE39A1E4C5958802E0D7E4DF256935086E0B832615C5',
 'work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md':'4B877FC2377CEB81C60CE139331ED5380AB0CB78011DE500D8768B2F837B99EA',
}
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
old=json.loads((ROOT/'work/qrh-campaign/agents/zero-sum/binary_source_word_stream_metadata_20261111.json').read_text())
def add(n):return 5*n
def sub(n):return 6*n+1
def compare(n):return 7*n
def division(n):return n*(16*(n+1)+1)
def product(a,b):
 rows=min(a,b)
 return a*b+rows*add(a+b)
T=2**18;Hmax=(T+2)//3
ck(Hmax==87382 and Hmax<2**17)
rows=[]
for src in old['rows']:
 exponent=src['L_exponent'];J=src['J'];Y=src['Y'];P=src['odd_base_count_upper'];Q=src['chunks']
 g=exponent+1;pbits=Y.bit_length();hb=17
 ck(J+Y<2**g and (Y*Y-1)//2<J)
 ck(J+Y<3*2**(g-2))
 ck(T+Y<2**20)
 raw_product_bits=hb+pbits;raw_sum_bits=max(g,raw_product_bits)+1
 narrow_product=product(hb,pbits)
 # Checked operations: branch; H>=1; Hp; next+Hp; e+p; two endpoint bounds;
 # last=next'-p; then first/last local offsets. Range/packing proof costs separate.
 core=compare(g)+compare(hb)+narrow_product+add(raw_sum_bits)+add(g+1)+2*compare(raw_sum_bits)+sub(g)
 sparse=core+2*sub(g)
 dense=sparse+division(6)
 # Fair fresh-first witness: n=r+q*p, q fits g-2 bits, plus a=max(b,jp),
 # a<=n<a+p. The remaining carry/common header is identical.
 qb=g-2;first_product=product(qb,pbits);first_sum_bits=qb+pbits+1
 fresh_extra=first_product+add(first_sum_bits)+(compare(g)+3*g)+compare(g)+add(g+1)+compare(g+1)
 ck(fresh_extra==first_product+5*first_sum_bits+29*g+12)
 ck(core<sparse<dense<old['full_header_boolean_gate_bound'])
 state_bytes=(g+7)//8
 row=dict(L_exponent=exponent,J=J,Y=Y,odd_prime_count_upper=P,chunks=Q,
  pointer_bits=g,prime_bits=pbits,count_bits=hb,count_max=Hmax,
  Hp_raw_bits=raw_product_bits,raw_successor_sum_bits=raw_sum_bits,
  accepted_successor_bits=g,accepted_Hp_bits=20,
  empty_pair_gates=compare(g),Hp_product_gates=narrow_product,
  active_core_gates=core,active_sparse_header_gates=sparse,active_dense_header_gates=dense,
  dense_phase_step_setup_once_per_p_gates=division(7),
  fresh_first_quotient_bits=qb,fresh_first_product_raw_bits=qb+pbits,
  fresh_first_sum_raw_bits=first_sum_bits,fresh_first_product_gates=first_product,
  matched_fresh_first_extra_gates=fresh_extra,
  matched_fresh_active_sparse_gates=sparse+fresh_extra,
  matched_fresh_active_dense_gates=dense+fresh_extra,
  legacy_header_upper_gates=old['full_header_boolean_gate_bound'],
  state_entry_raw_bytes=state_bytes,state_vector_raw_bytes_upper=P*state_bytes,
  two_vectors_raw_bytes_upper=2*P*state_bytes,
  conservative_input_state_visits_upper=Q*P,conservative_successor_state_nodes_upper=Q*P,
  initial_state_nodes_upper=P,chunk_link_count=Q-1,
  explicit_interchunk_snapshot_bytes_upper=(Q-1)*P*state_bytes,
  fresh_first_q_raw_bytes=(qb+7)//8)
 rows.append(row)

def transition(p,b,e,n,H=None):
 if n>=e:return H is None,n
 if H is None or H<1:return False,n
 successor=n+H*p
 return e<=successor<e+p,successor

partitions=0;transitions=0;mutation_rejections=0
# Complete partitions of small abstract intervals; all odd moduli are formal parameters.
for end in range(1,10):
 for cuts in range(1<<(end-1)):
  boundaries=[0]+[j for j in range(1,end) if cuts&(1<<(j-1))]+[end]
  for p in [3,9,17]:
   jp=(p*p-1)//2;n=jp;emitted=[]
   for b,e in zip(boundaries,boundaries[1:]):
    ck(n>=b and n>=jp and (n-jp)%p==0)
    ck(n==jp or n-p<b)
    if n>=e:
     ok,new=transition(p,b,e,n)
     ck(ok and new==n)
    else:
     H=(e-n+p-1)//p;ok,new=transition(p,b,e,n,H)
     ck(ok)
     local=[n+i*p for i in range(H)]
     expected=[j for j in range(b,e) if j>=jp and (j-jp)%p==0]
     ck(local==expected and local[-1]==new-p)
     emitted.extend(local)
     for wrong in [H-1,H+1]:
      ck(not transition(p,b,e,n,wrong)[0]);mutation_rejections+=1
    n=new
    ck(n>=e and (n==jp or n-p<e))
    transitions+=1
   ck(emitted==[j for j in range(end) if j>=jp and (j-jp)%p==0])
   partitions+=1

examples=[]
for p in [3,9,17,33,65]:
 jp=(p*p-1)//2
 # Explicit p²-at-boundary, equality at next chunk start, and last clipped chunk.
 boundaries=sorted({0,max(0,jp-1),jp,jp+1,jp+p,jp+2*p+1})
 n=jp;events=[]
 for b,e in zip(boundaries,boundaries[1:]):
  H=None if n>=e else (e-n+p-1)//p
  ok,new=transition(p,b,e,n,H);ck(ok)
  ck(new>=e and (new==jp or new-p<e))
  events.append(dict(b=b,e=e,before=n,H=H,after=new));n=new
 examples.append(dict(odd_modulus=p,initial=jp,events=events))
# Local transition checks alone are insufficient without initial-state/list binding.
fake_ok,fake_next=transition(3,0,10,7,1)
ck(fake_ok and fake_next==10 and 7!=(3*3-1)//2)

out=dict(scope='Scalar operation model and abstract recurrence partitions only; no source or prime values.',
 pins=PINS,checks=checks,rows=rows,complete_toy_partitions=partitions,
 toy_transitions=transitions,off_by_one_H_rejections=mutation_rejections,
 boundary_examples=examples,initial_state_binding_counterexample=dict(p=3,b=0,e=10,fake_next=7,H=1,
  local_transition_passes=True,initial_state_fails=True,omitted_progression_index=4),
 pair_counts='P is actual complete odd-base length; A active, G activated gap-empty, I pre-p² empty; A+G+I=QP.',
 differential='Matched first-witness arithmetic saves (A+G)*fresh_extra; state/link/transport differential remains.',
 no_saving_from_legacy_upper_bound=True)
dest=HERE/'source_next_hit_carry_metadata_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'toy_partitions':partitions,'transitions':transitions,
 'costs':[{k:r[k] for k in ['L_exponent','empty_pair_gates','active_sparse_header_gates',
 'active_dense_header_gates','matched_fresh_first_extra_gates']} for r in rows],
 'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
