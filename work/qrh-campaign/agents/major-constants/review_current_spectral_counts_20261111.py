from pathlib import Path
from fractions import Fraction
from hashlib import sha256
import json
root=Path('work'); a=root/'qrh-campaign/agents'; b=root/'qrh-blueprint'
r=json.loads((b/'compose_current_spectral_counts_20261111.json').read_text())
for name,h in r['pins'].items():assert sha256((a/name).read_bytes()).hexdigest().upper()==h
new=json.loads((a/'zero-sum/conditional_r132900_pruning_inventory_20261111.json').read_text())['rows']['large']
g,a1,n=new['same_order']['general_complex_products'],new['same_order']['complex_add_sub'],new['coarse_residue_inputs']
base=(4890157406463512,11446911736111484,114223068442718)
expected={}
for label,G,A,N,P,mg,ag in [('R150000_whole_axis_P24_four',*base,24,4,2),('R132900_fixed_pruned_P24_four',g,a1,n,24,4,2),('R132900_fixed_pruned_P20_four',g,a1,n,20,4,2),('R132900_fixed_pruned_P20_fixed_three',g,a1,n,20,3,3),('R132900_fixed_pruned_P20_Gauss',g,a1,n,20,3,5)]:
 h=sum(N for _ in range(P-1))
 expected[label]=dict(G=G,A=A,residue_inputs=N,P=P,Horner_stages=h,real_products=mg*G+2*h,real_additions=2*A+ag*G+2*h)
ref=expected['R150000_whole_axis_P24_four'];checks=0
for label,row in expected.items():
 for key,v in row.items():assert r['rows'][label][key]==v;checks+=1
 for k in ['real_products','real_additions']:
  q=Fraction(row[k],ref[k]);s=r['rows'][label][k+'_ratio']
  assert q==Fraction(s['num'],s['den']);checks+=1
# Reuse unchanged exact shared bands, without a new conductor inventory.
counts=[6401,6400,12800,38400,63988];D=[512,1024,2048,4096,8192]
H=sum(counts);Aseed=sum(c*d for c,d in zip(counts,D))
assert H==127989 and H==new['max_height_nodes'] and Aseed==717521408
seed={P:dict(slots=P*Aseed+20*H,shift_stages=(20*P-210)*Aseed) for P in [27,28]}
assert seed[27]['slots']==19375637796 and seed[28]['slots']==20093159204
assert seed[27]['shift_stages']==236782064640 and seed[28]['shift_stages']==251132492800
assert r['runtime_claim'] is False
out=dict(status='PASS_EXACT_COMPOSITION',comparisons=checks,rows=expected,shared_heights=H,old_mesh_intervals=Aseed,shifted_seed_counts=seed,scope='Exact composed counts and pinned-source reuse only; no values/inventory/evaluator execution.')
p=a/'major-constants/review_current_spectral_counts_20261111.json'
with p.open('x',encoding='utf-8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print('PASS',checks,sha256(p.read_bytes()).hexdigest().upper())
