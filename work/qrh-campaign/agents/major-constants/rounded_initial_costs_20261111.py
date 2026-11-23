"""Declared byte-template metadata only. No arithmetic values or occupancy scan."""
from pathlib import Path
from math import factorial
from fractions import Fraction as Q
import hashlib,json
B=Path(__file__).resolve().parents[1]
pins={
'major-constants/ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md':'FB0B0F9AF9C53150E14C1F5FFDE7A39E78DD8A6BFA09FE7769BF234EBB965E46',
'major-constants/rounded_initial_differences_20261111.json':'51A09104F2F5C29FA84B5E39312984E4E0433764ED933A3F7BDA064830FDD6A2',
'moebius/REVIEW_ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md':'B493A9965A8C9CCDBF138CD56FE322AEE7BC4DD75252AF538951D99709E5A40E',
'integration/MATCHED_NORMALIZED_RESIDUE_COST_COMPARISON_2026-11-11.md':'4E01AE12B9224898AF3CF169389B83B0BFFAE2FF0FDB74083B094BEB6735C54C',
'independent-feasibility/RESIDUE_POWER_TWO_STATE_NORMALIZATION_2026-11-11.md':'EFB31BE5B3A556CE88A29B1E566ACB86E026F7C9E3E778F67F5B81453914F004',
'prime-estimates/OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md':'A27CD526DB41C599F43912626827062EDC454F887A722782FF3953BE5BFFCE29',
'independent-feasibility/REVIEW_OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md':'A9D0D867D68FE902E0270A988DCED8E1D2A0B711EF9F4A99A2EEB24ABCA92A0B'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for path,h in pins.items():ck(hashlib.sha256((B/path).read_bytes()).hexdigest().upper()==h)
base=json.loads((B/'major-constants/rounded_initial_differences_20261111.json').read_text())
def byte(w):return (w+7)//8
def add(w):return 2*byte(w)+1
def mul(a,b):
 x,y=sorted([byte(a),byte(b)])
 return 5*x*y+2*x+1
def roundcore(q,d,w,dyadic=False):
 return (0 if dyadic else mul(q,d))+add(w)+add(d+3)+add(d+2)
rows=[]
for row in base['rows']:
 L,p=row['L'],row['p'];d=362
 init=40*roundcore(p+43,d,p+d+45)
 final=2*roundcore(117,d,d+119)
 dyad=2*roundcore(117,p-99,p+19,True)
 ck(final==7580 and final>dyad)
 cutoff=init//(final-dyad)+1
 ck(cutoff*(final-dyad)>init)
 ck((cutoff-1)*(final-dyad)<=init)
 rows.append({'L':L,'p':p,'twenty_complex_init_core':init,
 'exact_final_complex_core':final,'dyadic_final_complex_core':dyad,
 'strict_conversion_core_U_threshold':cutoff,
 'rounded_advance_complex_add_core':38*add(p+45),
 'init_complex_rounds':20,'unit_rounds':'U','all_numerator_advances':L-1})
# Exact normalization adapters on bounded exponent metadata, no actual E_j.
for p in (103,122,141,177,197):
 for delta in range(15):
  for j in range(20):
   f=factorial(j);nu=(f&-f).bit_length()-1
   lam=j*delta+nu;shift=p-100+lam
   ck(shift>=0)
   for twos in (0,1,19,38,190,361):
    a=min(shift,twos)
    ck(Q(2)**shift/Q(2)**twos==Q(2)**(shift-a)/Q(2)**(twos-a))
out={'checks':checks,'pins':pins,
'scope':'Explicit padded unsigned product/add cores only; signed bridges, shifts, normalization, representations, setup and generation are separate priced terms',
'comparison_denominator_bits':362,'rows':rows,
'selected':[rows[L-1] for L in (1,10,20,40,80,130,260)]}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),'selected':out['selected']}))
