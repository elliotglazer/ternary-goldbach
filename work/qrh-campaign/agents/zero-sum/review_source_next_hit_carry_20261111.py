"""Independent scalar and abstract-progression review; no author code execution."""
from pathlib import Path
from math import isqrt
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
A=HERE.parent/'prime-estimates'
note=A/'SOURCE_NEXT_HIT_CARRY_2026-11-11.md'
script=A/'source_next_hit_carry_metadata_20261111.py'
receipt=A/'source_next_hit_carry_metadata_20261111.json'
expected_script='348781327FEBDC120869A79A18EFE10E882BD43B1B6004CC01EEE3620B6136B3'
expected_receipt='43127729EB0CB7E9722A909587D2A136209D20D77F45AF2CEB449C1EDB47FDC0'
expected_note='4A44E6866C2FCC40A5D0B78F342C5F1B7E49BA77F3749C0E172CB3FF6488062B'
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
ck(sha(script)==expected_script);ck(sha(receipt)==expected_receipt);ck(sha(note)==expected_note)
old=json.loads(receipt.read_text())
for name,h in old['pins'].items():ck(sha(ROOT/name)==h)

def a(n):return sum(5 for _ in range(n))
def c(n):return sum(7 for _ in range(n))
def s(n):return a(n)+n+1
def m(i,j):return i*j+sum(a(i+j) for _ in range(min(i,j)))
def div(n):return sum(c(n+1)+s(n+1)+3*(n+1) for _ in range(n))
costs=[]
for row in old['rows']:
 l=row['L_exponent'];J=2**l+2**19;Y=isqrt(2*J-1);g=J.bit_length();f=Y.bit_length()
 H=(2**18+2)//3;raw=(H.bit_length()+f);w=max(raw,g)+1
 ck(H==87382 and H.bit_length()==17)
 ck(J+Y<2**g and J+Y<3*2**(g-2))
 core=c(g)+c(17)+m(17,f)+a(w)+a(g+1)+2*c(w)+s(g)
 sparse=core+2*s(g);dense=sparse+div(6)
 fresh=m(g-2,f)+a(g+f-1)+(c(g)+3*g)+c(g)+a(g+1)+c(g+1)
 pairs=((J//2**18)*((Y-1)//2))
 expected=dict(pointer_bits=g,prime_bits=f,count_bits=17,count_max=H,
  Hp_raw_bits=raw,raw_successor_sum_bits=w,accepted_successor_bits=g,
  empty_pair_gates=c(g),Hp_product_gates=m(17,f),active_core_gates=core,
  active_sparse_header_gates=sparse,active_dense_header_gates=dense,
  dense_phase_step_setup_once_per_p_gates=div(7),
  fresh_first_quotient_bits=g-2,fresh_first_product_raw_bits=g-2+f,
  fresh_first_sum_raw_bits=g+f-1,fresh_first_product_gates=m(g-2,f),
  matched_fresh_first_extra_gates=fresh,
  matched_fresh_active_sparse_gates=sparse+fresh,
  matched_fresh_active_dense_gates=dense+fresh,
  state_entry_raw_bytes=(g+7)//8,
  state_vector_raw_bytes_upper=((Y-1)//2)*((g+7)//8),
  two_vectors_raw_bytes_upper=2*((Y-1)//2)*((g+7)//8),
  conservative_input_state_visits_upper=pairs,
  conservative_successor_state_nodes_upper=pairs,
  explicit_interchunk_snapshot_bytes_upper=(J//2**18-1)*((Y-1)//2)*((g+7)//8))
 for key,val in expected.items():ck(row[key]==val)
 costs.append(dict(L_exponent=l,empty=c(g),sparse=sparse,dense=dense,fresh_extra=fresh))

transitions=mutations=gap_empty=pre_empty=active=boundary=0
for p in (3,9,17,33,65):
 jp=(p*p-1)//2
 for width in (1,2,7,16,31):
  end=jp+2*p+3; n=jp; all_hits=[]; n_fresh_checks=0
  bounds=list(range(0,end,width))+[end]
  for b,e in zip(bounds,bounds[1:]):
   ref=jp+max(0,(b-jp+p-1)//p)*p
   ck(n==ref)
   if n>=e:
    nxt=n;H=0
    if jp>=e:pre_empty+=1
    else:gap_empty+=1
    ck(not [j for j in range(b,e) if j>=jp and (j-jp)%p==0])
   else:
    active+=1;H=(e-1-n)//p+1;nxt=n+H*p
    ck(e<=nxt<e+p)
    hitlist=[n+k*p for k in range(H)]
    ck(hitlist==[j for j in range(b,e) if j>=jp and (j-jp)%p==0])
    all_hits+=hitlist
    ck(H<=(e-b+p-1)//p and nxt-n<(e-b)+p)
    for wrong in (H-1,H+1):
     ck(not(wrong>=1 and e<=n+wrong*p<e+p));mutations+=1
   if n==e:boundary+=1;ck(H==0 and nxt==n)
   ck(nxt==jp+max(0,(e-jp+p-1)//p)*p)
   ck(nxt>=e and (nxt==jp or nxt-p<e))
   n=nxt;transitions+=1
  ck(all_hits==list(range(jp,end,p)))
  active_or_gap=sum(1 for e in bounds[1:] if jp<e)
  # The full-width formula is valid only on exactly equal chunks.
  J=((end+width-1)//width)*width;Q=J//width
  ck(sum(1 for e in range(width,J+1,width) if jp<e)==Q-jp//width)

# Before activation an empty successor need not be below e+p.
ck((33*33-1)//2>=32+33)
# A local check alone omits the initial hit4.
ck(10<=7+3<13 and 7!=4)
# A narrow fresh-first comparison without high-bit binding can wrap.
g=8;p=13;jp=(p*p-1)//2;r=(p-1)//2;b=100;e=110;q=27
raw=r+q*p;packed=raw%(2**g)
ck(q<2**(g-2) and b<=packed<b+p and packed<e)
ck(raw!=packed and raw>=2**g)
ck(jp+((b-jp+p-1)//p)*p==e)

result=dict(status='PASS_INDEPENDENT_CARRY_SCALAR_AND_PROTOCOL_CHECKS',
 scope='Exact scalar and abstract integer progressions only; no primes, source sieve, author execution or builds',
 author_pins=dict(note=sha(note),script=sha(script),receipt=sha(receipt)),
 checks=checks,transition_cases=transitions,wrong_count_rejections=mutations,
 active=active,gap_empty=gap_empty,preactivation_empty=pre_empty,
 endpoint_equality_cases=boundary,costs=costs,
 required_qualifications=['Raw-to-packed exact equality precedes narrow fresh comparisons and remains separately charged',
 'Counts of actual prime/chunk cases are uncomputed',
 'Complete immutable vector linkage and ordinary proof compiler remain required'])
dest=HERE/'review_source_next_hit_carry_20261111.json'
with dest.open('x',encoding='utf8',newline='\n') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps(result,indent=2))
