"""Bounded join audit only; no analytic selector rerun or values."""
from pathlib import Path
from collections import Counter
import hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3];WORK=ROOT/'work';B=WORK/'qrh-blueprint'
pins={'MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md':'654484AF0793EA0D5A2D51A2842E06753F4D8CEC0BF75A96953EF017D9B3173F',
'build_minimal_theta_schedule_20261111.py':'6174F5C37C0C9D54C566427CD9BBA7E7CF4EBE4A897FA0B491AA29FE5057AFBA',
'minimal_theta_nonprincipal_schedule_20261111.json':'96483C8A5E47888AC9208A8B95CA1BD8261CBC9D42AFBCBAEE1A1ABF10AC9265'}
n=0
def ck(v):
 global n
 assert v
 n+=1
def read(p):return json.loads(p.read_text())
for p,h in pins.items():ck(hashlib.sha256((B/p).read_bytes()).hexdigest().upper()==h)
out=read(B/'minimal_theta_nonprincipal_schedule_20261111.json')
for p,h in out['pins'].items():ck(hashlib.sha256((WORK/p).read_bytes()).hexdigest().upper()==h)
base=read(HERE.parent/'major-constants/reconciled_nonprincipal_schedule_20261111.json')
mini=read(HERE.parent/'prime-estimates/small_family_minimal_theta_20261111.json')
for k in ['family_partition','setup','required_unpriced']:ck(out[k]==base[k])
for k in ['selectors','common']:ck(out[k]==mini[k])
cs=sorted(set(range(3,10000,2))|set(range(4,10001,4)))
ck(len(cs)==7499 and cs[-1]==10000)
ck(len(out['scenarios'])==4)
for row in out['scenarios']:
 e=row['extra_nodes'];ck(e in [0,167,320,640])
 old=next(s for s in base['scenarios'] if s['extra_nodes']==e)
 target=next(s for s in mini['scenarios'] if s['extra_nodes']==e)
 ck(row['large']==old['large']);ck(row['safe_cardinality_sum']==old['safe_cardinality_sum'])
 small=row['small_minimal_theta_candidate'];prev=old['small_alternatives']['128']
 for k in ['totals','by_conductor_parity','time_length_conductors']:ck(small[k]==prev[k])
 pairs=small['conductor_theta'];ck(len(pairs)==len(cs))
 for i,(c,t) in enumerate(pairs):ck(c==cs[i] and t==target['choice_in_increasing_active_conductor_order'][i] and 64<=t<=128)
 ck({str(k):v for k,v in sorted(Counter(t for c,t in pairs).items())}==small['histogram']==target['histogram'])
 for k,v in target['bit_ranges_selected_then_128'].items():ck(small['local_fractional_bit_ranges'][k]==v[:2])
 ck('ranges' not in small)
 ck(not any(k.startswith('point_EM_') for k in small['totals']))
 for k,v in small['totals'].items():ck(sum(d[k] for d in small['by_conductor_parity'].values())==v)
 ck(small['totals']['primitive_grid_outputs']+row['large']['primitive_outputs']==row['safe_cardinality_sum']['requested_primitive_outputs'])
 ck(small['totals']['bucket_additions_upper']>0 and 'rounded' in small['bucket_rounding'])
 ck('prefactor' in small['additional_rounding'] and 'omega' in small['additional_rounding'])
ck(len(out['required_unpriced'])==11)
ck('interpolation' in out['downstream_precision'] or 'off-grid' in out['downstream_precision'])
result=dict(scope='Exact schedule-join check; component parameter theorems reused',checks=n,author_pins=pins,dependency_pins=out['pins'])
with (HERE/'review_minimal_theta_schedule_20261111.json').open('x',encoding='utf8') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'checks':n,'status':'PASS'}))
