"""Exact count/guard metadata only; no function, sign or zero evaluation."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

BASE=Path(__file__).resolve().parent.parent
pins={
 'major-constants/TURING_SPECTRAL_SURPLUS_REDUCTION_2026-11-11.md':'6E7CD152D57679AFBEF754D9A1C0060AAA3F28C6E2DB1F6EFB4BD24A6B15C401',
 'major-constants/turing_spectral_surplus_scalars_20261111.py':'9D834E4AAF2490211CC8635A20FE44BE5076653A1C60C16AFCB934EB9519E1D5',
 'major-constants/turing_spectral_surplus_scalars_20261111.json':'31097AAF676A81004A79D2E564EE3318DEA6ACDBF1C275E9E99AED38CC05073D',
 'major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md':'3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58',
 'zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md':'6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4',
 'integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md':'72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C',
 'zero-sum/CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md':'7AA9BF4D456CE25685D69427966DC7F61D0914DD091A95B74F9C242B95CADB27',
}
checks=0
def need(p):
 global checks
 assert p
 checks+=1
for name,digest in pins.items(): need(hashlib.sha256((BASE/name).read_bytes()).hexdigest().upper()==digest)
saved=json.loads((BASE/'major-constants/turing_spectral_surplus_scalars_20261111.json').read_text())
cmax=2*132900; ct=max(10**8,200*cmax+75*10**6)
labels=4351723951-18477108
need(ct==saved['cT_cap']); need(labels==saved['large_labels'])
rows=[]
for row in saved['rows']:
 h=row['h']; d=F(row['required_measured_D_upper']); b=F(42)+18*F(693,100)
 # Cross-multiplied exponential lower witness, no logarithm evaluation.
 need(6*8**18>(ct+cmax*h)*3**18)
 margin=F(2)-d-2*b/h
 need(margin>0); need(margin==F(row['strict_spectral_reserve']))
 need(F(row['B_upper'])==b)
 steps=F(h*64,5); need(steps.denominator==1)
 need(steps==row['extra_dense_steps']); need(steps*labels==row['extra_large_branch_outputs'])
 rows.append({'h':h,'D_upper':str(d),'surplus':str(margin)})
need(12800*labels==saved['dense_h1000_outputs'])
r=saved['unproved_Rumely_analytic_route']; b=F(18397,10000)+18*F(621,5000)
need(b==F(r['B_upper'])); need(F(2)-F(1,2)-2*b/6==F(r['reserve']))
need(F(r['reserve'])>0); need(6*8**18>(ct+cmax*6)*3**18)
need(F(1717,500)+128==F(65717,500))
# Elementary scalar form of the missing-pair contradiction.
for K in range(12):
 for critical in range(K,K+4):
  for pair_order in range(1,5): need(critical+2*pair_order>=K+2)
out={'status':'PASS_EXACT_CONDITIONAL_GUARDS','checks':checks,'pins':pins,'rows':rows,
     'scope':'Guard implications and metadata only. No measured D, signs, zero counts or evaluator-domain extension.'}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:
 f.write(json.dumps(out,indent=2)+'\n')
print(json.dumps({'status':out['status'],'checks':checks}))
