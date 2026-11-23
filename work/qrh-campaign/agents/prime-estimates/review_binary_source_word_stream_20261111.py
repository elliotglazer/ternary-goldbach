"""Independent scalar and abstract-stream checks. No prime table or source sieve."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
HERE=Path(__file__).resolve().parent
AUTHOR='work/qrh-campaign/agents/zero-sum/'
PINS={AUTHOR+'BINARY_SOURCE_WORD_STREAM_ACCEPTANCE_2026-11-11.md':'03BD20DF832348BD00967140D61E60D5A00CE7CA936E22DFAEA4EC1D6B39538F',
AUTHOR+'binary_source_word_stream_metadata_20261111.py':'71CF1D455B503C7F55B769E98E3B744A991D5A1A0271BC74E571C25D96D43733',
AUTHOR+'binary_source_word_stream_metadata_20261111.json':'6363C29B990DF24D848ED2A2254A4C8E8F70B08C47F820940E522BEA254B58DC'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
saved=json.loads((ROOT/(AUTHOR+'binary_source_word_stream_metadata_20261111.json')).read_text())
for p,h in saved['pins'].items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def root2(n):
 lo,hi=0,1<<((n.bit_length()+1)//2)
 while hi-lo>1:
  m=(hi+lo)//2
  if m*m<=n:lo=m
  else:hi=m
 return hi if hi*hi==n else lo
rows=[]
for old in saved['rows']:
 L=2**old['L_exponent'];J=L+524288;U=2*J-1;Y=root2(U)
 ck(Y*Y<=U<(Y+1)**2)
 P=(Y-1)//2;Q=J//262144;N=J//64
 Z=int(J*F(Y.bit_length()-1,2)+P)
 leaf=Z+1;groups=P+1;levels=[]
 while True:
  levels.append(min(leaf,Q*groups*4096))
  if groups==1:break
  groups=(groups+1)//2
 row=dict(L_exponent=old['L_exponent'],J=J,Y=Y,odd_base_count_upper=P,
  chunks=Q,pair_headers_upper=Q*P,hit_visits_upper=Z,leaf_records_upper=leaf,
  merge_depth_upper=len(levels)-1,level_records_upper=levels,
  merge_input_records_upper=sum(levels[:-1]),merge_output_records_upper=sum(levels[1:]),
  final_word_records=N,raw_final_bitmap_bytes=8*N)
 for k,v in row.items():ck(v==old[k])
 ck(J%262144==0 and levels[-1]==N)
 # Every selected word has a p=3 hit: first word contains4; any later word
 # has64 consecutive positions, so the next residue1 mod3 is within2 positions.
 ck(4<64 and 2<64)
 rows.append(row)

cache=0
for p in range(3,64,2):
 r=(p-1)//2
 ck(cache==r*r-1)
 cache+=p
ck(cache==saved['dense_cache_entries']==1023)
ck(8*cache==saved['dense_cache_raw_bytes'] and 65*8==saved['prefix_cache_raw_bytes'])
ck(saved['full_header_boolean_gate_bound']==4*64*(16*65+1)+4*11*64**2+24*5*64+24*7*64)
for n,v in {'add':320,'subtract':385,'compare':448,'multiply':45056,'division':66624,'word_or':64}.items():
 ck(v==saved['boolean_gate_bounds_64'][n])
ck(saved['sparse_hit_boolean_gate_bound']==320+84+448+64==916)
ck(saved['merge_record_boolean_gate_bound']==84+64==148)
ck(6+64*5==326 and 916+326==1242)
ck(2**12==4096 and (4096).bit_length()==13)

# Abstract odd moduli, not primality assertions. Alternate direct-divisibility oracle.
progressions=0
for word in [2,4,8,16]:
 for p in [3,9,17,33,65]:
  jp=(p*p-1)//2
  for b in sorted({0,max(0,jp-1),jp,jp+1,word-1,word,2*word+1}):
   for w in sorted({1,word-1,word,word+1,2*word-1}):
    expected=[j for j in range(b,b+w) if (2*j+1)%(p)==0 and 2*j+1>=p*p]
    first=jp+max(0,(b-jp+p-1)//p)*p
    count=max(0,(b+w-1-first)//p+1)
    hits=[first+i*p for i in range(count)]
    ck(hits==expected)
    grouped={}
    for j in hits:
     u,t=divmod(j-b,word)
     grouped[u]=grouped.get(u,0)|(1<<t)
    ck(all(0<=u<(w+word-1)//word and 0<m<1<<word for u,m in grouped.items()))
    ck(len(grouped)<=count)
    if hits:
     ck(first>=max(b,jp) and first<max(b,jp)+p)
     ck(hits[-1]<b+w<=hits[-1]+p)
     if p>=word:ck(len(grouped)==count)
     else:
      ck(sorted(grouped)==list(range(min(grouped),max(grouped)+1)))
      for u,m in grouped.items():
       dense=sum(1<<t for t in range(word) if (b+word*u+t-(p-1)//2)%p==0
         and first<=b+word*u+t<=hits[-1])
       ck(m==dense)
    else:ck(first>=b+w)
    progressions+=1

def merging(left,right):
 if not left:return list(right),0, len(right),0
 if not right:return list(left),len(left),0,0
 a,b=left[0],right[0]
 if a[0]<b[0]:
  rest,l,r,o=merging(left[1:],right);return [a]+rest,l+1,r,o
 if b[0]<a[0]:
  rest,l,r,o=merging(left,right[1:]);return [b]+rest,l,r+1,o
 rest,l,r,o=merging(left[1:],right[1:])
 return [(a[0],a[1]|b[1])]+rest,l+1,r+1,o+1
lists=[[(j,(1<<(j%3)) if mode==0 else 3) for j in [0,1,3,5] if mask&(1<<[0,1,3,5].index(j))]
       for mode in [0,1] for mask in range(16)]
merges=0
for a in lists:
 for b in lists:
  out,l,r,o=merging(a,b)
  ck(l==len(a) and r==len(b) and o<=min(l,r))
  ck(len(out)<=min(6,l+r) and all(out[i][0]<out[i+1][0] for i in range(len(out)-1)))
  expected={j:dict(a).get(j,0)|dict(b).get(j,0) for j in range(6)}
  ck(dict(out)=={j:m for j,m in expected.items() if m})
  merges+=1
result=dict(verdict='PASS_CONDITIONAL_MATH_AND_OPERATION_MODEL',checks=checks,
 pins=PINS,source_pins=saved['pins'],rows=rows,abstract_progression_cases=progressions,
 synthetic_merge_cases=merges,empty_merge_administration='charged separately as O(QP), not in record sums',
 scope='No author script imports/runs, prime tests, source sieve, actual word table or build.')
dest=HERE/'review_binary_source_word_stream_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'progressions':progressions,'merges':merges,
 'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
