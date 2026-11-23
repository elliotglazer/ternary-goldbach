"""Exact geometry, geometric-series and width checks; no coefficient/function values."""
from pathlib import Path
from fractions import Fraction as Q
from collections import Counter
import hashlib,json
BASE=Path(__file__).resolve().parents[1]
PINS={
 'integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md':'691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025',
 'prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC',
 'moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234',
 'integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':'9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4'}
checks=0
def ck(p):
 global checks
 assert p
 checks+=1
for p,h in PINS.items(): ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
S=sum(Q(6,5)**j for j in range(20))
ck(S<256); ck(Q(1,4)+Q(19,20)==Q(6,5))
for i in range(20): ck(sum(Q(6,5)**j for j in range(i+1))<=S)
for i in range(1,20):
 for j in range(1,i):
  raw=Q(1,4)+Q(j,20)+Q(j,40)
  ck(raw<2); ck(512*2**j<=256*2**19)
 ck(Q(i,40)<1); ck(256*2**(i-1)<256*2**19)
ck(256*Q(1,4)+1<256)
v=2*265800
ck((v**19).bit_length()==362)
ck(256*2**16*2**19==2**43)
ck(132900+18*16384==427812); ck(427812<2**19)
ck(19*16384<2**19)
widths=[]
for b in (100,122):
 D=2**b*v**19
 ck(2**43*D<2**(b+405)); ck(2**44*D<2**(b+406))
 widths.append({'b':b,'live_and_Newton_raw_signed_bits':b+406,'traversal_raw_signed_bits':b+407,
                'coefficient_prescale_signed_bits':b+379,
                'cancelled_final_divisor_bits':(2**(b-100)*v**19).bit_length()})
# Small abstract partition fixtures only, not selected-family occupancy scans.
fixtures=0
for F in (2,4,8,16):
 for c in range(2,10*F+1):
  buckets=Counter()
  for a in range(1,c):
   k=(2*F*a+c-1)//(2*c)
   ck((2*k-1)*c<2*F*a<=(2*k+1)*c)
   buckets[k]+=1
  ck(sum(buckets.values())==c-1)
  ck(max(buckets.values())<=(c+F-1)//F<=10)
  ck(c-1<=10*len(buckets)); fixtures+=1
for F in (1024,2048,4096,8192,16384):
 c=10*F+1
 ck(Q(F,2*c)<Q(1,20))
 ck(Q(1,4)+19*Q(F,2*c)<Q(6,5))
ck(Q(4,3)+1<Q(8,3)); ck(844+633==1477<1688)
out={'scope':'new c>10F polynomial-only domain; no occupancy or price adoption',
     'checks':checks,'pins':PINS,'geometric_sum':{'numerator':S.numerator,'denominator':S.denominator},
     'partition_fixtures':fixtures,'state_exponent_above_Q':43,'advance_exponent_above_Q':44,
     'widths':widths,'general_factor_max':427812}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f: json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),'widths':widths}))
