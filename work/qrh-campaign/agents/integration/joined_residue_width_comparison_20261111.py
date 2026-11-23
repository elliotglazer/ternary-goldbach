"""Exact widths/counts and source pins only; no coefficient or function values."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib, json

HERE=Path(__file__).resolve().parent
BASE=HERE.parent
SOURCES=[
 'integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md',
 'audit/REVIEW_EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_2026-11-11.md',
 'prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md',
 'moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md',
 'major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md',
 'independent-feasibility/REVIEW_RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md',
 'integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md',
 'integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md',
 'audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md',
 'zero-sum/RESIDUE_FINITE_DIFFERENCE_WIDTH_BREAK_EVEN_2026-11-11.md',
 'zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md',
 'prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md',
]
checks=0
def ck(x):
 global checks
 checks+=1
 assert x

b=100; v=531600
rows=[]
for i in range(1,20):
 ell=(v**i).bit_length()
 prev=(v**(i-1)).bit_length()
 small_add=sum(j.bit_count()-1 for j in range(1,i+1))
 shifted=sum(j.bit_count() for j in range(1,i+1))
 row=dict(degree=i,general_products=i,direct_additions=i,
          binary_additions=small_add,shifted_operands=shifted,
          power_bits=ell,prescale_signed_bits=b+ell+17,
          general_operand_20F_bits=b+prev+i-1+19,
          general_operand_10F_bits=b+prev+i-1+25,
          init_result_20F_bits=b+ell+i+19,
          init_result_10F_bits=b+ell+i+25)
 rows.append(row)
 ck(row['init_result_20F_bits']<=500)
 ck(row['init_result_10F_bits']<=506)
 ck(row['prescale_signed_bits']<=479)
ck(sum(r['general_products'] for r in rows)==190)
ck(sum(r['direct_additions']+r['binary_additions'] for r in rows)==357)
ck(sum(r['shifted_operands'] for r in rows)==357)
ck(sum(r['binary_additions'] for r in rows)==167)
ck((v**19).bit_length()==362)
ck(132900+18*16384<2**19)
ck(19*16384<2**19)
ck(Q(4,3)+1==Q(7,3))
ck(633*Q(7,3)==1477)
ck(633*Q(8,3)==1688)
ck(Q(4,3)+Q(4,3)==Q(8,3))
ck(sum(Q(1,4)**j for j in range(19))<Q(4,3))
ck(sum(Q(6,5)**j for j in range(20))<256)
for L in range(1,261):
 ck(357+19*(L-1)==19*L+338)
 ck((570+19*(L-1))-(357+19*(L-1))==213)
 ck(380-190==190)
table=dict(product_direct_macro=5*46*15+2*15+1,
 product_table_macro=15+14*(2*60+1)+14,
 setup_macro=255*((2*47+1)+2)+4)
ck(table==dict(product_direct_macro=3481,product_table_macro=1723,setup_macro=24739))
ck(14*(3481-1723)<=24739<15*(3481-1723))
pins=[]
for rel in SOURCES:
 raw=(BASE/rel).read_bytes()
 pins.append(dict(path=rel,sha256=hashlib.sha256(raw).hexdigest().upper(),lines=len(raw.splitlines())))
result=dict(scope='exact symbolic metadata only; no price or saving admission',checks=checks,
 degree_rows=rows,table_subtotal=table,source_pins=pins,
 capacities=dict(coefficient_signed=117,grid_horner_state_signed=118,
 grid_horner_product_signed=136,denominator_bits=362,final_numerator_signed=480,
 quotient_signed=118,full_20F_live_signed=500,full_20F_add_signed=501,
 full_10F_live_signed=506,full_10F_add_signed=507))
out=HERE/'joined_residue_width_comparison_20261111.json'
out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(dict(checks=checks,sha256=hashlib.sha256(out.read_bytes()).hexdigest().upper())))
