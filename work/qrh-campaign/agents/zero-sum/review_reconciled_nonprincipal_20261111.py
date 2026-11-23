"""Forward reconstruction of shared seed lifetimes and frozen schedule join."""
from pathlib import Path
import hashlib,json
from fractions import Fraction as F
from copy import deepcopy
HERE=Path(__file__).resolve().parent;A=HERE.parent;ROOT=A.parents[2]
P=A/'major-constants'
pins={'RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md':'483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716',
'reconciled_nonprincipal_schedule_20261111.py':'2B7EDAEE20811B50A4810E6C690071D2F8AC57E95B852DE2C17619877E85ABFB',
'reconciled_nonprincipal_schedule_20261111.json':'0E83C9AB65725FBD34F0D34FC462E9EC805A040717DA92B1AB262CC7A9345397'}
n=0
def ck(v):
 global n
 assert v
 n+=1
def load(p):return json.loads(p.read_text())
for p,h in pins.items():ck(hashlib.sha256((P/p).read_bytes()).hexdigest().upper()==h)
data=load(P/'reconciled_nonprincipal_schedule_20261111.json')
for p,h in data['input_sha256'].items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
large=load(P/'combined_odd_even_height_inventory_20261111.json')
small=load(A/'prime-estimates/small_family_theta_inventory_final_20261111.json')
reconstructed=[]
for sc in data['scenarios']:
 e=sc['extra_nodes'];tot={};first=0;previous_x=0;previous_d=1
 spec=[(500,512,220,6401,27,20,64),(1000,1024,387,6400,27,20,64),(2000,2048,720,12800,27,20,64),(5000,4096,1720,38400,27,20,64),(7000,4096,1500,20199+e,28,28,159)]
 for band,(V,D,N,H,p,end,m) in zip(sc['large']['seed_bands'],spec):
  orders=[p]*D+[end];K=sum(orders);x=(N+1)*D+1
  ck(D%previous_d==0)
  # Growing nested grids in first four bands; final same-grid shrink.
  intersection=min(previous_x,x) if D==previous_d else previous_x
  introduced=x-intersection
  count=dict(source_coefficients=H*K,head_reciprocal_scales=H*N*sum(k-1 for k in orders),head_accumulator_additions=H*N*K,
   E_contracting_complex_stages=H*sum(k+2*m-2 for k in orders),Bernoulli_weighted_terms=H*m*K,Bernoulli_accumulator_additions=H*m*K,
   source_translation_updates=H*D*(3 if p==28 else 1)*sum(min(20,j+1) for j in range(p-1)),
   P20_fine_anchor_coefficient_deliveries=H*20*((4 if p==28 else 2)*D+1),shared_height_R_recurrence_steps=H*(p-1),
   coarse_anchor_instances=H*(D+1),base_height_argument_pairs=H*x,initial_B_certificates=introduced,
   step_cis_certificates=introduced,step_grid_conversions=introduced,fine_state_complex_updates=(H-1)*x+intersection,
   state_to_EM_grid_conversions=H*x,final_coefficient_power2_scales=H*327700 if p==28 else 0,final_coefficient_rounds=H*327700 if p==28 else 0)
  for k,v in count.items():ck(v==band['counts'][k]);tot[k]=tot.get(k,0)+v
  ck((band['V'],band['D_source'],band['N'],band['heights'],band['P'],band['endpoint_P'],band['m'])==(V,D,N,H,p,end,m))
  ck(band['first_index']==first and band['last_index']==first+H-1)
  first+=H;previous_x=x;previous_d=D
 ck(tot==sc['large']['seed_totals'])
 ck(tot['initial_B_certificates']==7049217)
 ck(tot['fine_state_complex_updates']+7049217==tot['base_height_argument_pairs'])
 ck(first==84200+e and F(sc['large']['last_height'])==F(5*(first-1),64)<7000)
 orig=next(s for s in large['scenarios'] if s['extra_nodes']==e)
 for new,old in [('transform_operations','operations'),('P20_Horner_stages','P20_Horner_stages'),('primitive_outputs','primitive_outputs'),('residue_inputs','residue_inputs'),('conductor_height_nodes','conductor_height_nodes')]:ck(sc['large'][new]==orig[old])
 ck(sc['large']['P20_Horner_stages']==19*sc['large']['residue_inputs'])
 for theta in (64,128):
  expected=deepcopy(next(s for s in small['scenarios'] if s['extra_nodes']==e and s['theta']==theta))
  expected['not_selected_point_EM_comparator']={k:v for k,v in expected['totals'].items() if k.startswith('point_EM_')}
  expected['totals']={k:v for k,v in expected['totals'].items() if not k.startswith('point_EM_')}
  expected['by_conductor_parity']={p:{k:v for k,v in d.items() if not k.startswith('point_EM_')} for p,d in expected['by_conductor_parity'].items()}
  ck(sc['small_alternatives'][str(theta)]==expected)
  for k,v in expected['totals'].items():ck(sum(d[k] for d in expected['by_conductor_parity'].values())==v)
  ck(sc['safe_cardinality_sum']['requested_primitive_outputs']==orig['primitive_outputs']+expected['totals']['primitive_grid_outputs'])
 ck(sc['safe_cardinality_sum']['primitive_labels']==4333246843+18477108==4351723951)
 ck(sc['safe_cardinality_sum']['conductors']==125400+7499==132899)
 reconstructed.append(tot)
setup=data['setup']['large_seed']
ck(setup['distinct_arguments_union']==1721*4096+1==7049217)
ck(setup['final_active_arguments']==1501*4096+1==6148097)
ck(setup['retired_at_final_transition']==220*4096==901120 and setup['introduced_at_final_transition']==0)
start=4096;end=1722*4096;anchors=0
while start<=end:
 length=min(start//128,end-start+1);ck(length>0);start+=length;anchors+=1
ck(anchors==setup['log_anchors']==960)
ck(setup['log_degree21_stages']==21*(7049217-960))
ck(data['setup']['large_transform_unchanged']==large['transform_setup_unchanged'])
ck(len(data['required_unpriced'])==11 and all(r['status'] in ['unpriced_required','partly_counted_unpriced'] for r in data['required_unpriced']))
out=dict(scope='Forward shared-seed reconstruction and exact frozen small/large schedule join',checks=n,author_pins=pins,dependency_pins=data['input_sha256'],seed_totals=reconstructed)
with (HERE/'review_reconciled_nonprincipal_20261111.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':n,'status':'PASS'}))
