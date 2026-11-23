"""Exact grid, error and width metadata only. No source coefficient data."""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
OWN=Path(__file__).resolve().parent
paths=[
 'work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md',
 'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md',
 'work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md',
 'work/qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md',
 'work/qrh-campaign/agents/integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md',
 'work/qrh-campaign/agents/audit/REVIEW_EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_2026-11-11.md',
]
pins={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}
assert pins[paths[4]]=='691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025'
assert pins[paths[5]]=='A21A7B16BFF97898E0D6C8F1FFBB3D39C231C1553BE2B9CF77B8770F5819261D'
checks=0
def check(x):
 global checks
 assert x
 checks+=1
eta=Q(1,2**100); budget=Q(1,2**82)
first_tail=1266*Q(5,16)**20/factorial(20)+1266*Q(15,16)**27/factorial(27)
first_other=2532*eta+633*330*Q(1,2**110)
final_tail=1266*Q(7020,4*8192)**20/factorial(20)+1266*Q(5*7028,8*4096)**28/factorial(28)
final_other=844*eta
first_old=first_tail+first_other+1688*eta
final_old=final_tail+final_other+1688*eta
check(first_old/budget==Q(10065943424467492228678097495,32076363635089380005973590016))
check(first_old<budget/3)
check(final_old<Q(4,25)*budget)
check(sum(Q(1,4)**j for j in range(20))<Q(4,3))
powerbits=((2*265800)**19).bit_length();check(powerbits==362)
rows=[]
for b in [100,122]:
 u=Q(1,2**b)
 new_eval=844*u+633*eta
 check(new_eval<1688*eta)
 check(40665+u<2**16 and 27043+u<2**16)
 first_new=first_tail+first_other+new_eval
 final_new=final_tail+final_other+new_eval
 check(first_new<budget)
 check(final_new<Q(4,25)*budget)
 if b==122:
  check(first_old+844*u<budget/3)
  check(final_old+844*u<Q(4,25)*budget)
 for p in [94,100,110,122,137]:
  for n in range(-47,48):
   x=Q(n,2**p)
   scaled=x*2**b
   m=(2*scaled.numerator+scaled.denominator)//(2*scaled.denominator)
   check(abs(Q(m,2**b)-x)<=Q(1,2**(b+1)))
   check((2*m-1)*scaled.denominator<=2*scaled.numerator<(2*m+1)*scaled.denominator)
 rows.append({'b':b,'final_g':100,'character_evaluation_error':str(new_eval),
  'allowance_reserve':str(1688*eta-new_eval),
  'first_alpha_fraction':str(first_new/budget),'final_alpha_fraction':str(final_new/budget),
  'long_live_signed_bits':b+powerbits+37,'long_add_signed_bits':b+powerbits+38,
  'screened_live_signed_bits':b+powerbits+38,'screened_add_signed_bits':b+powerbits+39,
  'final_round_denominator_bits':b-100+powerbits,
  'coefficient_signed_bits':b+17})
out={'scope':'Exact rational allowance and integer-grid checks; no coefficient values',
     'pins':pins,'checks':checks,'selected_b':100,'rounds_per_unique_coefficient_array':20,
     'rows':rows,'old_first_alpha_fraction':str(first_old/budget),
     'old_final_alpha_fraction':str(final_old/budget),
     'optional_b122_added_to_old_first_fraction':str((first_old+844*Q(1,2**122))/budget),
     'optional_b122_added_to_old_final_fraction':str((final_old+844*Q(1,2**122))/budget)}
with (OWN/'residue_coefficient_grid_closure_20261111.json').open('x',encoding='utf-8') as f:
 json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'selected_b':100,'rows':rows},indent=2))
