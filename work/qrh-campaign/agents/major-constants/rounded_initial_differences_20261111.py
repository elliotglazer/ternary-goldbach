"""Exact binomial/error/width metadata; no coefficients or transforms."""
from pathlib import Path
from fractions import Fraction as R
from math import comb
import json,hashlib
B=Path(__file__).resolve().parents[1]
pins={
'major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md':'AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054',
'independent-feasibility/REVIEW_RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md':'0FC1801726CE19F28E0B512C3B24FA8D88B1531E3360E8566A1A799A8F955711',
'prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC',
'moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234',
'integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':'9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4',
'integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md':'B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815',
'audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':'793AD4410778F45B39040F246B361E8877876ABA11083A2C9492288B2492B16D'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in pins.items():ck(hashlib.sha256((B/p).read_bytes()).hexdigest().upper()==h)
g10=sum(R(6,5)**j for j in range(20));g20=sum(R(3,4)**j for j in range(20))
ck(g10<192);ck(g20<4-R(1,512))
ck(g10*2**16*2**19+1<2**43)
ck(g20*2**16*2**19+1<2**37)
ck((2*265800)**19<2**362)
u=R(1,2**100)
ck(R(4,3)+R(1,4)+1==R(31,12)<R(8,3))
ck(633*R(31,12)==R(6541,4));ck(1688-R(6541,4)==R(211,4))
rows=[];weights=[1]*20
for n in range(260):
 L=n+1
 for j in range(20):
  s=sum(comb(n,k) for k in range(min(n,19-j)+1))
  ck(weights[j]==s)
 S=weights[0];bits=S.bit_length();p=102+bits
 ck(S*R(1,2**p)<u/4)
 ck(103<=p<=197)
 for j in range(20):ck(weights[j]<=S)
 rows.append({'L':L,'S':S,'bitlength':bits,'p':p,
 'old_guard':{'signed_live':p+38,'signed_add_temporary':p+39,'signed_initial_scaled_product':p+400,'signed_initial_residual':p+401,'signed_initial_doubled_residual':p+402},
 'ten_guard':{'signed_live':p+44,'signed_add_temporary':p+45,'signed_initial_scaled_product':p+406,'signed_initial_residual':p+407,'signed_initial_doubled_residual':p+408},
 'initial_complex_rounds':20,'advance_complex_additions':19*(L-1)})
 # Ascending update reads an unchanged upper entry.
 for j in range(19):weights[j]+=weights[j+1]
ck(rows[-1]['S']==32305056352236018054956299912)
ck(rows[-1]['p']==197)
out={'checks':checks,'pins':pins,'scope':'Binomial and width metadata only; no arithmetic values',
'g10':str(g10),'g20':str(g20),'error_factor':'31/12',
'rows':rows,'selected':[rows[L-1] for L in (1,10,20,40,80,130,260)]}
dst=Path(__file__).with_suffix('.json')
with dst.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dst.read_bytes()).hexdigest().upper(),'selected':out['selected']}))
