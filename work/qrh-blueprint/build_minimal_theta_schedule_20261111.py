"""Join reviewed coarse-value schedules, without evaluating functions."""
from pathlib import Path
import json
import hashlib
from copy import deepcopy

root = Path(__file__).resolve().parent.parent
pins = {
 'qrh-campaign/agents/major-constants/reconciled_nonprincipal_schedule_20261111.json': '0E83C9AB65725FBD34F0D34FC462E9EC805A040717DA92B1AB262CC7A9345397',
 'qrh-campaign/agents/zero-sum/REVIEW_RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md': '712090B83A3C31F58C2642B329B8122661F9AB4D675F0665342D69FAD47E562D',
 'qrh-campaign/agents/prime-estimates/small_family_minimal_theta_20261111.json': '25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422',
 'qrh-campaign/agents/prime-estimates/CLARIFICATION_MINIMAL_THETA_BUCKET_ROUNDING_2026-11-11.md': '4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41',
 'qrh-campaign/agents/audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md': '58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B',
}
for path,h in pins.items():
 assert hashlib.sha256((root/path).read_bytes()).hexdigest().upper()==h,path
base=json.loads((root/next(iter(pins))).read_text())
minimal=json.loads((root/'qrh-campaign/agents/prime-estimates/small_family_minimal_theta_20261111.json').read_text())
conductors=[c for c in range(3,10001) if c%2 or c%4==0]
assert len(conductors)==7499
out={
 'scope':'coarse-value arithmetic candidate only; no interpolation, signs or completeness certified',
 'pins':pins,
 'family_partition':deepcopy(base['family_partition']),
 'setup':deepcopy(base['setup']),
 'setup_alias_rule':'Initial B, step-cis and step-grid setup fields alias the same calls in large seed totals; do not add twice.',
 'selectors':deepcopy(minimal['selectors']),
 'common':deepcopy(minimal['common']),
 'scenarios':[],
 'required_unpriced':deepcopy(base['required_unpriced']),
 'other_candidates':'The frozen base retains uniform theta64 and theta128; they are alternatives, not additional work.',
 'downstream_precision':'All precision here is for coarse values. Any off-grid adapter must separately charge tighter time/omega precision and its operations.',
}
for b,m in zip(base['scenarios'],minimal['scenarios'],strict=True):
 assert b['extra_nodes']==m['extra_nodes']
 old=b['small_alternatives']['128']
 choices=m['choice_in_increasing_active_conductor_order']
 assert len(choices)==len(conductors)
 assert all(64<=t<=128 for t in choices)
 for key,value in m['counts_identical_to_theta128'].items():
  assert old['totals'][key]==value,key
 small={
  'totals':deepcopy(old['totals']),
  'by_conductor_parity':deepcopy(old['by_conductor_parity']),
  'time_length_conductors':deepcopy(old['time_length_conductors']),
  'conductor_theta':list(zip(conductors,choices)),
  'histogram':deepcopy(m['histogram']),
  'local_fractional_bit_ranges':{k:v[:2] for k,v in m['bit_ranges_selected_then_128'].items()},
  'bucket_rounding':'Retain hT rounded additions, norm tolerance epsilon(theta)/(32*C*Bpref*n0).',
  'additional_rounding':'Retain all prefactor, coefficient, omega and final Y rounding allocations per the bound clarification and independent review.',
  'cache_rule':'Per-conductor baseline counts retained. Global cache is a replacement option and must use a sufficient tolerance for every consumer.',
 }
 out['scenarios'].append({'extra_nodes':b['extra_nodes'],'large':deepcopy(b['large']),
                          'small_minimal_theta_candidate':small,
                          'safe_cardinality_sum':deepcopy(b['safe_cardinality_sum'])})
assert len(out['scenarios'])==4
path=Path(__file__).with_name('minimal_theta_nonprincipal_schedule_20261111.json')
if path.exists():assert json.loads(path.read_text())==out
else:path.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print('PASS: 5 pins, 4 matched scenarios, 29996 explicit conductor choices, 24 named aggregate equalities.')
