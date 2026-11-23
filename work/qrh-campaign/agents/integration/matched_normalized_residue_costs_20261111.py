"""Symbolic widths and proposed proof-event subtotals, never residue values."""
from pathlib import Path
from math import factorial
from fractions import Fraction as Q
import hashlib,json
HERE=Path(__file__).resolve().parent
BASE=HERE.parent
BLUE=BASE.parents[1]/'qrh-blueprint'
checks=0
def ck(x):
 global checks
 checks+=1
 assert x
def nu(n): return (n&-n).bit_length()-1
def digits(w):return (w+7)//8
def mul(m,n):return 5*m*n+2*n+1
def add(n):return 2*n+1
b=[100,100]+[100-j for j in range(2,20)]
rows=[]
for j in range(18,-1,-1):
 prev=b[j+1];out=b[j];align=out-prev
 m=digits(prev+17);q=digits(out+16)
 ck(align==(0 if j==0 else 2 if j==1 else 1))
 rows.append(dict(j=j,input_grid=prev,output_grid=out,align_bits=align,
  state_magnitude_bits=prev+17,quotient_magnitude_bits=out+16,
  state_digits=m,quotient_digits=q,
  complex_product_macro=2*(mul(m,3)+mul(q,3)),
  complex_digit_product_cells=2*3*(m+q)))
ck(sum(b)==1811)
ck(sum(b[:-1])==1730)
ck(sum(r['complex_product_macro'] for r in rows)==16312)
ck(19*4*mul(15,3)==17632)
ck(sum(r['complex_digit_product_cells'] for r in rows)==3156)
ck(19*4*15*3==3420)
ck(sum(Q(2)**(100-b[j])*Q(1,4)**j for j in range(20))==Q(7,4)-Q(1,2**19))
ck(sum(Q(2)**(100-b[j])*Q(1,4)**j for j in range(19))==Q(7,4)-Q(1,2**18))
ck(Q(21,8)<Q(8,3))

normal=[]
for delta in range(15):
 lam=[j*delta+nu(factorial(j)) for j in range(20)]
 gamma=[j-lam[j] for j in range(20)]
 ck(max(gamma)==(4 if delta==0 else 0))
 shifts=[lam[j+1]-lam[j] for j in range(19)]
 ck(shifts==[delta+nu(j+1) for j in range(19)])
 ck(sum(x>0 for x in shifts)==(9 if delta==0 else 19))
 # Width offsets are added to b+bitlength(v'^19); no conductor is sampled.
 order=[dict(j=j,lambda_j=lam[j],state_offset=25+gamma[j],
              shifted_add_offset=27+gamma[j] if j<19 else None,
              shift=shifts[j] if j<19 else None) for j in range(20)]
 ck(max(x['state_offset'] for x in order)==(29 if delta==0 else 25))
 ck(max(x['shifted_add_offset'] for x in order[:-1])==(31 if delta==0 else 27))
 normal.append(dict(delta=delta,orders=order))
small_add=sum((20-j)*(j.bit_count()-1) for j in range(1,20))
small_terms=sum((20-j)*j.bit_count() for j in range(1,20))
ck(small_add==167 and small_terms==357)
for j in range(1,20):ck((j//2**nu(j)).bit_count()==j.bit_count())
for residual_twos in range(19):
 for align in (0,1,2):
  e=min(residual_twos,align)
  ck(Q(2)**align/(2**residual_twos)==Q(2)**(align-e)/(2**(residual_twos-e)))
source_files=[
 BASE/'audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md',
 BASE/'moebius/REVIEW_B100_PRODUCT_ONLY_HORNER_2026-11-11.md',
 BLUE/'DEGREE_DEPENDENT_HORNER_GRID_PROPOSAL_2026-11-11.md',
 BASE/'prime-estimates/REVIEW_DEGREE_DEPENDENT_HORNER_GRID_2026-11-11.md',
 BASE/'independent-feasibility/RESIDUE_POWER_TWO_STATE_NORMALIZATION_2026-11-11.md',
 BASE/'integration/JOINED_RESIDUE_ARITHMETIC_WIDTH_COMPARISON_2026-11-11.md',
 BASE/'audit/REVIEW_JOINED_RESIDUE_ARITHMETIC_WIDTH_COMPARISON_2026-11-11.md',
 BASE/'prime-estimates/B100_HORNER_FIXED_FACTOR_PROOF_REUSE_2026-11-11.md',
 BASE/'zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md',
]
pins=[dict(path=str(p.relative_to(BASE.parents[1])),sha256=hashlib.sha256(p.read_bytes()).hexdigest().upper()) for p in source_files]
result=dict(scope='parameterized widths and unsigned product macro subtotals only; no saving admission',
 checks=checks,horner_degree_rows=rows,normalized_order_offsets=normal,
 product_subtotals=dict(uniform=17632,degree=16312,uniform_digit_cells=3420,degree_digit_cells=3156),
 normalization_small_scale_counts=dict(extra_additions=small_add,shifted_operand_occurrences=small_terms),source_pins=pins)
out=HERE/'matched_normalized_residue_costs_20261111.json'
out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(dict(checks=checks,sha256=hashlib.sha256(out.read_bytes()).hexdigest().upper())))
