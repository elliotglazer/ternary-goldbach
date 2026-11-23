"""Synthetic integer controls and template counts; no actual output data."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
A=Path(__file__).resolve().parents[1]
pins={
'moebius/P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md':'F578D50723A09A1580D6ACFBA4F6AEB93371AF81B7929121A9F402E0ED5A38D0',
'independent-feasibility/REVIEW_P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md':'F9E0EDCE65255FD912176E321606CA17E2854E3D23E78EBA36B6A4006858D4CC',
'integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md':'3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227',
'prime-estimates/EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md':'DAA7F4625A1CCF8D9307AF59D1FA0C74416CCF38F9B87BBC8547C0F0D74836F3',
'integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':'9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4',
'integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md':'B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815'}
checks=0
def ck(x):
 global checks
 checks+=1
 assert x,checks
for path,h in pins.items():ck(hashlib.sha256((A/path).read_bytes()).hexdigest().upper()==h)
ck(F(4,3)*2**16+F(1,2**101)<2**17)
ck((531600**19).bit_length()==362)
ck(362+117==479 and (479+7)//8==60)
ck((362+8+7)//8==47 and (117+7)//8==15)
add=lambda n:2*n+1
table=15+14*add(60)+14
school=5*46*15+2*15+1
setup=255*(add(47)+2)+4
ck((table,school,setup)==(1723,3481,24739))
ck(14*(school-table)<=setup<15*(school-table))
ck(2*7*(school-table)<=setup<2*8*(school-table))
products=round_cases=0
for Q in [1,2,3,256,257,2**361+113]:
 T=[0]
 for digit in range(1,256):
  T.append(T[-1]+Q)
  ck(T[-1]==digit*Q)
 ck(T[-1]<2**370)
 for m in list(range(-257,258))+[-(2**117-1),2**117-1]:
  u=abs(m);digits=[(u>>(8*j))&255 for j in range(14,-1,-1)]
  prefix=digits[0];value=T[digits[0]]
  for digit in digits[1:]:
   value=256*value+T[digit];prefix=256*prefix+digit
   ck(value==Q*prefix and prefix<=u and value<2**479)
  ck(prefix==u)
  signed=-value if m<0 else value
  ck(signed==m*Q)
  products+=1
  for r in set([-(Q//2)-1,-(Q//2),-(Q//2)+1,0,(Q-1)//2,Q//2,Q//2+1]):
   I=signed+r
   ok=-Q<=2*(I-signed)<Q
   ck(ok==(m==(2*I+Q)//(2*Q)))
   round_cases+=1
out={'scope':'Synthetic integer controls and conditional macro-event schedule only','status':'PASS','checks':checks,'pins':pins,
 'synthetic_products':products,'synthetic_round_cases':round_cases,
 'macro_events':{'table_product':table,'rectangular_schoolbook':school,'one_table_setup':setup,
                 'strict_scalar_product_crossover':15,'strict_complex_output_crossover':8},
 'capacity_bits':{'Q':362,'unsigned_rounded_coordinate':117,'table_entry':370,'product_prefix':479}}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'status':out['status'],'synthetic_products':products,'round_cases':round_cases}))
