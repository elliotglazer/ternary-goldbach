"""Independent size/template checks only; no author imports or arithmetic values."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib,json
B=Path(__file__).resolve().parents[1]
pins={
'prime-estimates/B100_HORNER_FIXED_FACTOR_PROOF_REUSE_2026-11-11.md':'973FA8095EA9BC4768B1D50B70AB0218FE730508C46E7BC37F68B5E944381CE0',
'prime-estimates/horner_fixed_factor_reuse_20261111.py':'EF1BDDE692B2D0CA06BD219882EB367B6B79C2900F4109D57F4EBD12DC04CEA1',
'prime-estimates/horner_fixed_factor_reuse_20261111.json':'F6461A2C6648C5BBCDCCE0047D4AE1A6312168315B262536690DD2E5E7799169',
'audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md':'84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C',
'moebius/P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md':'F578D50723A09A1580D6ACFBA4F6AEB93371AF81B7929121A9F402E0ED5A38D0',
'independent-feasibility/REVIEW_P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md':'F9E0EDCE65255FD912176E321606CA17E2854E3D23E78EBA36B6A4006858D4CC',
'integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md':'3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227',
'zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md':'E5622749AB1A5A9D91743586B17DCE8C3E10C87237E2F48168CD47D7064385BF',
'prime-estimates/REVIEW_FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md':'314CE4EEF32B3E5C87D671E6221AA43FC50428F642F0C062A0FA94E392DB59CF',
'integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':'9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4',
'integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md':'B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815',
'audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':'793AD4410778F45B39040F246B361E8877876ABA11083A2C9492288B2492B16D'}
n=0
def ck(x):
 global n
 assert x
 n+=1
for p,h in pins.items():ck(hashlib.sha256((B/p).read_bytes()).hexdigest().upper()==h)
saved=json.loads((B/'prime-estimates/horner_fixed_factor_reuse_20261111.json').read_text())
for row,(a,b) in zip(saved['rows'],[(18,117),(20,115)]):
 ck(a+b==135)
 widths=[]
 for j in range(1,16):
  bits=a+(b-112)+8*(j-1)
  ck(bits==8*j+15)
  widths.append((bits+7)//8)
 ck(widths==row['prefix_product_digits'])
 ck(row['prefix_adder_events']==[2*w+1 for w in widths[1:]])
 ck(row['direct_narrow_outer_rows']==3*(15*5+2)+1==232)
 ck(row['direct_reverse_orientation']==15*(3*5+2)+1==256)
 ck(row['table_growing_prefix']==15+14+14*(9+35)//2==337)
 ck(row['table_setup']==255*(9+2)+4==2809)
 ck((a+8+7)//8==4)
 ck(337-232==105)
u=Q(1,2**100);C=2**16
ck(Q(4,3)*(C+u)<2**17)
ck(Q(C,3)*2**100+Q(1,3)+2<2**115)
ck(sum(Q(1,4**j) for j in range(20))+sum(Q(1,4**j) for j in range(19))<Q(8,3))
ck(633*Q(8,3)==1688)
ck(265800//2<2**18 and 2*265800<2**20)
ck(2*19*2*232==saved['degree19_complex_product_subtotal']['direct']==17632)
ck(2*19*2*337==saved['degree19_complex_product_subtotal']['table']==25612)
ck(25612-17632==7980)
ck(2*2809==5618)
out={'checks':n,'pins':pins,'result':'PASS conditional template and representation scope',
'direct_events':232,'table_events':337,'setup_events':2809,
'no_crossover_difference':'2809+105*H>0 for H>=0',
'documentary_clarification':'Rectangular template is in source section3, not section2.'}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':n,'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
