"""Integer bounds and toy progression/merge tests; no prime testing or source sieve."""
from pathlib import Path
from math import isqrt
import hashlib,json

ROOT=Path(__file__).resolve().parents[4]
OUT=Path(__file__).with_suffix('.json')
checks=0
def check(v):
    global checks
    assert v
    checks+=1

pins={}
for rel in [
 'work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md',
 'work/qrh-campaign/agents/prime-estimates/EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md',
 'work/formal-goldbach-bench/mm0/src/verifier.c',
 'work/formal-goldbach-bench/mm0/src/verifier_types.c',
 'work/formal-goldbach-bench/mm0/src/types.c',
 'work/mm0-efficient/soundness.md',
 'work/mm0-efficient/toolchain.md']:
    p=ROOT/rel
    pins[rel]=hashlib.sha256(p.read_bytes()).hexdigest().upper()

rows=[]
for exponent in (32,34,36):
    J=(1<<exponent)+(1<<19); T=1<<18; W=T//64
    Y=isqrt(2*J-1); pbar=(Y-1)//2; chunks=J//T
    zbar=J*(Y.bit_length()-1)//2+pbar
    leaves=pbar+1; depth=(leaves-1).bit_length()
    e0=zbar+1
    levels=[min(e0,chunks*((leaves+(1<<l)-1)//(1<<l))*W)
            for l in range(depth+1)]
    check(levels[-1]==J//64)
    check(all(a>=b for a,b in zip(levels,levels[1:])))
    rows.append(dict(L_exponent=exponent,J=J,Y=Y,odd_base_count_upper=pbar,
       chunks=chunks,pair_headers_upper=chunks*pbar,hit_visits_upper=zbar,
       leaf_records_upper=e0,merge_depth_upper=depth,
       level_records_upper=levels,merge_input_records_upper=sum(levels[:-1]),
       merge_output_records_upper=sum(levels[1:]),
       final_word_records=J//64,
       raw_final_bitmap_bytes=J//8))

def first_count(p,b,w):
    start=(p*p-1)//2; r=(p-1)//2; end=b+w
    a=max(b,start)
    if a>=end:return None,0
    j=r+((a-r+p-1)//p)*p
    if j>=end:return None,0
    return j,1+(end-1-j)//p

def grouped(hits,b,word):
    result={}
    for j in hits:
        u,t=divmod(j-b,word)
        result[u]=result.get(u,0)|(1<<t)
    return sorted(result.items())

def merge(left,right):
    i=j=0; out=[]; consumed=[]
    while i<len(left) or j<len(right):
        if j==len(right) or (i<len(left) and left[i][0]<right[j][0]):
            out.append(left[i]);consumed.append(('L',i));i+=1
        elif i==len(left) or right[j][0]<left[i][0]:
            out.append(right[j]);consumed.append(('R',j));j+=1
        else:
            out.append((left[i][0],left[i][1]|right[j][1]))
            consumed.extend([('L',i),('R',j)]);i+=1;j+=1
    check(sorted(x for side,x in consumed if side=='L')==list(range(len(left))))
    check(sorted(x for side,x in consumed if side=='R')==list(range(len(right))))
    return out

# Odd moduli are abstract progression parameters, not asserted primes.
toy_count=0
for p in (3,9,17,33):
  for b in (0,1,4,17,63,128,544):
    for w in (1,7,8,9,31,32):
      j,h=first_count(p,b,w)
      expected=[x for x in range(b,b+w)
                if x>=(p*p-1)//2 and (x-(p-1)//2)%p==0]
      hits=[] if h==0 else [j+k*p for k in range(h)]
      check(hits==expected)
      records=grouped(hits,b,8)
      check(len(records)<=h and len(records)<=(w+7)//8)
      if h:
        check(hits[-1]<b+w<=hits[-1]+p)
        if p<8:
          check([u for u,_ in records]==list(range(records[0][0],records[-1][0]+1)))
          dense=[]
          for u in range(records[0][0],records[-1][0]+1):
            # Only toy masks on eight bits are constructed.
            mask=sum(1<<t for t in range(8)
                     if (b+8*u+t-(p-1)//2)%p==0 and hits[0]<=b+8*u+t<=hits[-1])
            dense.append((u,mask))
          check(dense==records)
      toy_count+=1

synthetic_lists=[[],[(0,1)],[(0,2),(2,8)],[(1,3),(2,4),(5,7)],[(5,2)]]
for l in synthetic_lists:
  for r in synthetic_lists:
    merged=merge(l,r); d={}
    for u,m in l+r:d[u]=d.get(u,0)|m
    check(merged==sorted(d.items()))

# Bounds for a proposed ordinary Boolean circuit library, not measured opcodes.
def add(n):return 5*n
def sub(n):return 6*n+1
def cmp(n):return 7*n
def mul(n):return 11*n*n
def div(n):return n*(16*(n+1)+1)
pattern_entries=sum(range(3,64,2))
check(pattern_entries==1023)
check(all((r*r-1)+p-1<1023 for r,p in enumerate(range(3,64,2),1)))
check((64-3)//3>=1)
result=dict(scope='integer bounds plus toy abstract progressions, no prime/source sieve',
 checks=checks,toy_progression_cases=toy_count,synthetic_merge_cases=25,
 word_bits=64,chunk_bits=1<<18,words_per_chunk=4096,
 local_word_index_bits=12,local_stream_length_bits=13,record_raw_bytes=10,
 dense_cache_entries=pattern_entries,dense_cache_raw_bytes=pattern_entries*8,
 prefix_cache_entries=65,prefix_cache_raw_bytes=65*8,
 full_header_boolean_gate_bound=4*div(64)+4*mul(64)+24*add(64)+24*cmp(64),
 boolean_gate_bounds_64=dict(add=add(64),subtract=sub(64),compare=cmp(64),
       multiply=mul(64),division=div(64),word_or=64),
 sparse_hit_boolean_gate_bound=add(64)+cmp(12)+cmp(64)+64,
 merge_record_boolean_gate_bound=cmp(12)+64,
 rows=rows,pins=pins)
OUT.write_text(json.dumps(result,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(dict(checks=checks,toy_progression_cases=toy_count,rows=rows),indent=2))
