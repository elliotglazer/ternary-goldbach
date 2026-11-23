"""Symbolic Horner error/width bounds and synthetic rounding witnesses only."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
OWN = Path(__file__).resolve().parent
inputs = {
 'work/qrh-campaign/agents/integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':'9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4',
 'work/qrh-campaign/agents/integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md':'B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815',
 'work/qrh-campaign/agents/audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':'793AD4410778F45B39040F246B361E8877876ABA11083A2C9492288B2492B16D',
 'work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
 'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
 'work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md':'E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9',
 'work/qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md':'579AAEC28BD4C1DB8FB83F3CDB1E4782160D3D35FA8AB2B8DC83BFF956ACBCD1',
}
checks = 0
def check(x):
 global checks
 assert x
 checks += 1
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()
for p,h in inputs.items(): check(sha(ROOT/p) == h)
u=Q(1,2**100); C=2**16; a=Q(1,4)
g20=sum(a**j for j in range(20))
g19=sum(a**j for j in range(19))
check(g20+g19 == Q(8,3)-Q(4,3)*(a**20+a**19))
check(g20+g19 < Q(8,3))
check(633*Q(8,3) == 1688)
err=Q(0); mag=Q(C)
for stage in range(1,20):
 err=a*err+u
 mag=a*mag+u+C
 check(err == u*sum(a**j for j in range(stage)))
 check(mag == C*sum(a**j for j in range(stage+1))+err)
 check(mag < Q(4,3)*(C+u) < 2**17)
 check(a*mag+u < Q(C,3)+Q(4,3)*u < 2**15)
check(40665+u<2**16 and 27043+u<2**16)
# Coefficient/accumulator, floor quotient and conditional increment widths.
check(C*2**100 == 2**116)
check(Q(4,3)*(C+u)*2**100 < 2**117)
quotient_bound=(Q(C,3)+u/3)*2**100+1
check(quotient_bound+1 < 2**115)
check(265800//2 < 2**18 and 2*265800 < 2**20)
check(2**117*2**18 == 2**135)
check(2**115*2**20 == 2**135)
check(2**135+2**20 < 2**136)
check(2*(2*265800) < 2**21)
check(2**115+2**116 < 2**117)
# Synthetic signed Euclidean witnesses; no polynomial or function inputs.
round_cases=0
for v in [1,2,3,16,17,531600]:
 for t in range(-257,258):
  q,r=divmod(t,v)
  m=q+int(2*r>=v)
  check(t==q*v+r and 0<=r<v)
  check((2*m-1)*v <= 2*t < (2*m+1)*v)
  check(abs(Q(m)-Q(t,v)) <= Q(1,2))
  round_cases+=1
early=1266*(Q(5,16)**20/factorial(20)+Q(15,16)**27/factorial(27))
early+=2532*u+633*330*Q(1,2**110)+1688*u
last=1266*(Q(7020,4*8192)**20/factorial(20)+Q(5*7028,8*4096)**28/factorial(28))
last+=(844+1688)*u
check(early < Q(1,3)*Q(1,2**82))
check(last < Q(4,25)*Q(1,2**82))
# Each component's uniform evaluation allowance is no larger than8u/3.
check(Q(7,3) < Q(8,3))
check(19*2 == 38)
out={'scope':'Symbolic rational bounds and synthetic signed witnesses; no actual coefficients or values',
     'checks':checks,'synthetic_rounding_cases':round_cases,'pins':inputs,
     'geometric_coefficient_factor':str(g20),'geometric_product_factor':str(g19),
     'combined_factor':str(g20+g19),'old_character_allowance':1688,
     'signed_widths':{'coefficient':117,'accumulator':118,'displacement_numerator':19,
                      'raw_r_times_accumulator':136,'floor_quotient':116,
                      'rounded_product':116,'q_times_v':136,
                      'reconstruction_temporary':137,'coefficient_sum':118},
     'unsigned_widths':{'denominator':20,'remainder':20,'twice_remainder':21},
     'per_residue_complex':{'product_rounds':19,'exact_additions':19,'extra_final_rounds':0},
     'per_residue_real_witnesses':{'r_times_accumulator':38,'q_times_v':38,
                                 'reconstruction_additions':38,'rounding_decisions':38},
     'conversion_per_unique_array_complex':20,
     'old_alpha_ratios':{'first_four':str(early/Q(1,2**82)),'joint_final':str(last/Q(1,2**82))}}
dest=OWN/'b100_product_only_horner_20261111.json'
with dest.open('x',encoding='utf-8') as f:
 json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':sha(dest)}))
