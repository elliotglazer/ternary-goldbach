"""Saved-data rational audit only; does not import or execute either producer."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json

ROOT=Path(__file__).resolve().parents[3]
inventory=ROOT/'qrh-campaign/agents/zero-sum/auxiliary_fixed_order_inventory_20261111.json'
candidate=ROOT/'qrh-blueprint/turing_research_payoff_20261111.json'
assert hashlib.sha256(inventory.read_bytes()).hexdigest().upper()=='8BEAD899428DE523323FCA7D833ECE6F4C5443213D32D4F32B964B18B218F7F9'
d=json.loads(inventory.read_text()); saved=json.loads(candidate.read_text())
def dec(v): return F(v['numerator'],v['denominator'])
assert set(d['main_operations'])==set(d['per_extra_height_operations'])
assert all(n>0 for n in d['main_operations'].values())
counts=0
for r in d['rows']:
 for k,rate in d['per_extra_height_operations'].items():
  assert 5*r['added_operations'][k]==64*r['h']*rate
for row in saved['comparisons']:
 old,new=row['old_h'],row['new_h']
 values=[]
 for k,base in d['main_operations'].items():
  rate=d['per_extra_height_operations'][k]
  # Clear the common /5 before forming the ratio.
  ratio=F(64*(old-new)*rate,5*base+64*old*rate)
  assert ratio==dec(row['component_saving_fractions'][k])
  values.append(ratio); counts+=1
 assert min(values)==dec(row['minimum']) and max(values)==dec(row['maximum'])
 if (old,new)==(50,0): assert F(39,1000)<min(values)<=max(values)<F(42,1000)
 if (old,new)==(200,50): assert F(106,1000)<min(values)<=max(values)<F(110,1000)
frontier=[]
for row in saved['conditional_width_frontier']:
 b=dec(row['b']); cap=dec(row['conditional_D_cap'])
 good=next(h for h in range(5,1001,5) if cap+2*b/h<2)
 assert good==row['first_multiple_of_5_h']
 assert 2-cap-2*b/good==dec(row['reserve'])
 assert 2-cap-2*b/(good-5)==dec(row['previous_reserve'])
 frontier.append({'b':str(b),'first_strict_width':good})
assert counts==30 and len(frontier)==3
out={'status':'PASS_INDEPENDENT_SAVED_RATIONAL_PAYOFF','scope':'Model arithmetic only',
 'inventory_sha256':hashlib.sha256(inventory.read_bytes()).hexdigest().upper(),
 'candidate_sha256':hashlib.sha256(candidate.read_bytes()).hexdigest().upper(),
 'ratio_equalities':counts,'frontiers':frontier}
dest=Path(__file__).with_suffix('.json')
if dest.exists(): raise SystemExit('Refusing to overwrite review receipt')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8',newline='\n')
print(out['status'])
