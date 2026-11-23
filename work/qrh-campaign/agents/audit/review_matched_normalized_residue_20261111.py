"""Independent exact stage, normalization and cancellation metadata only."""
from pathlib import Path
from fractions import Fraction as Q
from math import gcd
from collections import Counter
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
WORK=ROOT/'work'
OWN=Path(__file__).resolve().parent
AUTHOR=OWN.parent/'integration'
PINS={
 'MATCHED_NORMALIZED_RESIDUE_COST_COMPARISON_2026-11-11.md':'4E01AE12B9224898AF3CF169389B83B0BFFAE2FF0FDB74083B094BEB6735C54C',
 'matched_normalized_residue_costs_20261111.py':'5BBE732A601C353D8F4A90807238206FC077EAE7473DC349D9BE37BB14FB068D',
 'matched_normalized_residue_costs_20261111.json':'69441DBF361A7301AC96357471F0C93C8AC3CC92294C401BCAAD784FBF3C6CCA'}
checks=0
def ck(p):
 global checks
 assert p
 checks+=1
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def val2(n):
 assert n>0
 e=0
 while n%2==0:n//=2;e+=1
 return e
def factval(j):return sum(j//2**k for k in range(1,6))
def bits_to_bytes(n):return (n+7)//8
for p,h in PINS.items():ck(sha(AUTHOR/p)==h)
data=json.loads((AUTHOR/'matched_normalized_residue_costs_20261111.json').read_text())
for row in data['source_pins']:ck(sha(WORK/row['path'])==row['sha256'])
grids={j:(100 if j<2 else 100-j) for j in range(20)}
hist=Counter();macro=0;cells=0
for row in data['horner_degree_rows']:
 j=row['j']; p=grids[j+1];g=grids[j]
 m=bits_to_bytes(p+17);q=bits_to_bytes(g+16)
 ck((row['input_grid'],row['output_grid'],row['align_bits'])==(p,g,g-p))
 ck(row['state_magnitude_bits']==p+17 and row['quotient_magnitude_bits']==g+16)
 ck(row['state_digits']==m and row['quotient_digits']==q)
 subtotal=2*((15*m+7)+(15*q+7))
 ck(row['complex_product_macro']==subtotal)
 ck(row['complex_digit_product_cells']==6*(m+q))
 macro+=subtotal;cells+=6*(m+q);hist[(m,q)]+=1
ck(hist=={(13,13):7,(14,14):8,(15,15):4})
ck(data['product_subtotals']=={'uniform':17632,'degree':macro,'uniform_digit_cells':3420,'degree_digit_cells':cells})
ck(macro==16312 and 17632-macro==1320)
ck(sum(grids.values())==1811 and sum(grids[j] for j in range(19))==1730)
ck(sum(grids[j]>grids[j+1] for j in range(19))==18)
weights=[Q(2)**(100-grids[j])*Q(1,4)**j for j in range(20)]
ck(sum(weights)==Q(7,4)-Q(1,2**19))
ck(sum(weights[:-1])==Q(7,4)-Q(1,2**18))
ck(Q(3,4)*(sum(weights)+sum(weights[:-1]))<Q(21,8)<Q(8,3))
for delta_row in data['normalized_order_offsets']:
 delta=delta_row['delta']; gamma=[];nonzero=0
 for row in delta_row['orders']:
  j=row['j'];lam=j*delta+factval(j)
  ck(factval(j)==j-j.bit_count())
  ck(row['lambda_j']==lam)
  ck(row['state_offset']==25+j-lam)
  gamma.append(j-lam)
  if j<19:
   shift=delta+val2(j+1)
   ck(row['shift']==shift and row['shifted_add_offset']==27+j-lam)
   # Higher bound after shifting equals twice the lower bound.
   next_lam=(j+1)*delta+factval(j+1)
   ck(j+1-next_lam+shift==j-lam+1)
   nonzero+=shift>0
  else:ck(row['shift'] is None and row['shifted_add_offset'] is None)
 ck(max(gamma)==(4 if delta==0 else 0))
 ck(nonzero==(9 if delta==0 else 19))
 for i in range(1,20):
  for j in range(1,i):
   ck(Q(1,4)+Q(3*j,40)<2)
 ck(3<4)  # shifted higher plus lower fits two guard bits
ck(sum((20-j)*(j.bit_count()-1) for j in range(1,20))==167)
ck(sum((20-j)*j.bit_count() for j in range(1,20))==357)
for j in range(1,20):ck((j//2**val2(j)).bit_count()==j.bit_count())
# Bounded exact geometry fixtures, not a selected-family scan or output data.
fixtures=0;exceptional=0
for c in [3,12,20,28,32,48,64,72,80]:
 s=val2(c);w=c//2**s
 for f in range(1,6):
  fine=2**f;v=2*c
  for a in range(1,c):
   if gcd(a,c)!=1:continue
   k=(2*fine*a+c-1)//(2*c);r=fine*a-k*c
   t=min(f,s if k%2 else s+1)
   p=min(s+1,val2(abs(r))) if r else s+1
   ck(p==t+int(s==f and k%2==1))
   ck(v%2**t==0 and r%2**t==0 and fine%2**t==0)
   ck(Q(r,v)==Q(r//2**p,v//2**p))
   rp=r//2**p;vp=v//2**p
   for align in [0,1,2]:
    e=min(align,val2(vp))
    ck(Q(rp*2**align,vp)==Q(rp*2**(align-e),vp//2**e))
   ck(v//2**t==2**(s+1-t)*w)
   if p==t+1:
    exceptional+=1
    ck((v//2**t)%2==0 and (r//2**t)%2==0)
    for j in range(20):ck(j+(19-j)==19)
   fixtures+=1
ck(exceptional>0)
result={'scope':'Matched conditional metadata only; no arithmetic implementation or cost winner',
 'checks':checks,'geometry_fixtures':fixtures,'exceptional_output_fixtures':exceptional,
 'author_pins':PINS,'source_pins':data['source_pins'],'byte_stage_histogram':[
 {'input_digits':m,'witness_digits':q,'stages':n} for (m,q),n in sorted(hist.items())],
 'product_subtotals':data['product_subtotals']}
dest=OWN/'review_matched_normalized_residue_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':sha(dest)}))
