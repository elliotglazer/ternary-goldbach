"""Independent rational geometry/width checks, without coefficient or function values."""
from pathlib import Path
from fractions import Fraction as R
import hashlib,json

BASE=Path(__file__).resolve().parents[1]
PINS={
 'major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md':'AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054',
 'major-constants/residue_difference_ten_guard_20261111.py':'F0A0DC446C54A503D8B6E84A2D9441EF420557EC296D329BB36896B550F884A4',
 'major-constants/residue_difference_ten_guard_20261111.json':'692D89158DF2A16FF35B1BBEB6A7B29F6C96443B842DFFF55127EE99D4176D58',
}
checks=0
def check(value):
 global checks
 assert value
 checks+=1
for p,h in PINS.items():check(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
author=json.loads((BASE/'major-constants/residue_difference_ten_guard_20261111.json').read_text())
for p,h in author['pins'].items():check(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
geom=(R(6,5)**20-1)/(R(6,5)-1)
check(geom==R(author['geometric_sum']['numerator'],author['geometric_sum']['denominator']))
check(geom<256)
partial=R(0)
for degree in range(20):
 partial+=R(6,5)**degree
 check(partial<=geom)
 check(R(1,4)+R(degree,20)<=R(6,5))
 for order in range(degree+1):
  check(256*2**16*2**order<=2**43)
for degree in range(1,20):
 for order in range(1,degree):
  first=256*(R(1,4)+R(order,20))*2**order
  second=256*R(order,20)*2**(order-1)
  check(first+second<512*2**order)
  check((first+second)*2**16<2**43)
  check(order<=18)
 top=256*R(degree,20)*2**(degree-1)
 check(top*2**16<2**43)
check((64+1)*2**16<2**43)
check(256//4==64)
check(132900+18*16384==author['general_factor_max']==427812)
check(427812<2**19 and 19*16384<2**19)

# Build abstract buckets from open-left/closed-right endpoints, independently
# of assigning each numerator first. This is not a selected-conductor scan.
fixtures=ties=0
for grid in (2,4,8,16):
 for conductor in range(2,10*grid+3):
  seen=[];nonempty=0
  for anchor in range(grid+1):
   lo=max(1,((2*anchor-1)*conductor)//(2*grid)+1)
   hi=min(conductor-1,((2*anchor+1)*conductor)//(2*grid))
   values=list(range(lo,hi+1))
   if values:nonempty+=1
   check(len(values)<=(conductor+grid-1)//grid)
   for numerator in values:
    check((2*grid*numerator+conductor-1)//(2*conductor)==anchor)
    q=grid*numerator-anchor*conductor
    check(-conductor<2*q<=conductor)
    if 2*q==conductor:ties+=1
   seen.extend(values)
  check(seen==list(range(1,conductor)))
  if conductor<=10*grid:check(conductor-1<=10*nonempty)
  fixtures+=1
check(ties>0)
for grid in (1024,2048,4096,8192,16384):
 c=10*grid+1
 check(R(1,4)+R(19*grid,2*c)<R(6,5))

vmax=531600
check((vmax**19).bit_length()==362)
widths=[]
for bits in (100,122):
 denominator=2**bits*vmax**19
 stored=bits+406;temporary=bits+407;prescale=bits+379
 check(2**43*denominator<2**(stored-1))
 check(2**44*denominator<2**(temporary-1))
 check(2**16*denominator<2**(prescale-1))
 check(stored-(bits+400)==6 and temporary-(bits+401)==6)
 row={'b':bits,'live_and_Newton_raw_signed_bits':stored,'traversal_raw_signed_bits':temporary,
      'coefficient_prescale_signed_bits':prescale,
      'cancelled_final_divisor_bits':(2**(bits-100)*vmax**19).bit_length()}
 check(row==next(x for x in author['widths'] if x['b']==bits))
 widths.append(row)
check(R(4,3)+1==R(7,3)<R(8,3))
check(633*R(4,3)==844 and 844+633==1477<1688)
check(sum(range(1,20))==190)
check(sum((20-j)*(j.bit_count()-1) for j in range(1,20))==167)
check(sum((20-j)*j.bit_count() for j in range(1,20))==357)
out={'status':'PASS_EXACT_GEOMETRY_AND_WIDTH','checks':checks,'author_pins':PINS,'source_pins':author['pins'],
     'scope':'abstract integer geometry and rational bounds only; optional b100 source closure remains separate',
     'abstract_partition_fixtures':fixtures,'ties_down_witnesses':ties,'widths':widths,
     'geometric_sum':str(geom)}
dest=Path(__file__).with_name('review_ten_guard_difference_final_20261111.json')
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
