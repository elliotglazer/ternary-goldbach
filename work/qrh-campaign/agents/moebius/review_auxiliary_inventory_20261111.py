"""Read-only producer intake; integer/rational schedule checks, no analytic values."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
import ast, json

HERE=Path(__file__).resolve().parent
Z=HERE.parent/'zero-sum'
PINS={
 'AUXILIARY_FIXED_ORDER_SPECTRAL_INVENTORY_2026-11-11.md':'80DB1F3EF97114F332D4A23A96DFE585E234ACA87D01FC50234B95C1B576F186',
 'auxiliary_fixed_order_inventory_20261111.py':'863913C5B5ABEAA7F84E758D5B20AD900E51F8EE784A97B24642690DD76A892E',
 'auxiliary_fixed_order_inventory_20261111.json':'8BEAD899428DE523323FCA7D833ECE6F4C5443213D32D4F32B964B18B218F7F9',
 'conditional_r132900_pruning_inventory_20261111.py':'074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D',
 'conditional_r132900_pruning_inventory_20261111.json':'E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF'}
checks=0
def check(v):
 global checks
 assert v
 checks+=1
for p,h in PINS.items():check(sha256((Z/p).read_bytes()).hexdigest().upper()==h)
d=json.loads((Z/'auxiliary_fixed_order_inventory_20261111.json').read_text())
old=json.loads((Z/'conditional_r132900_pruning_inventory_20261111.json').read_text())
# Recompute schedule aggregation using the already-reviewed fixed circuit definitions.
# This is NOT an independent proof of the circuit algorithm itself.
p=Z/'conditional_r132900_pruning_inventory_20261111.py'
body=[]
for node in ast.parse(p.read_text()).body:
 if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='rows' for t in node.targets):break
 body.append(node)
ns={'__file__':str(p),'__name__':'review_metadata_prefix'}
exec(compile(ast.Module(body=body,type_ignores=[]),str(p),'exec'),ns)
keys=ns['KEYS']; step=dict.fromkeys(keys,0); main=dict.fromkeys(keys,0)
C=vsum=nsum=0; top=0
for c in range(10001,265801):
 if not (c%4==0 or (c%2==1 and c<=132900)):continue
 # Independently form phi and primitive counts from prime-power metadata.
 v=n=1
 for p,e in ns['factors'](c):
  v*=p**(e-1)*(p-1)
  n*=p-2 if e==1 else p**(e-2)*(p-1)**2
 H=F(100000000,c) if c%2 or c<=125000 else F(200)+F(75000000,c)
 scaled=H*F(64,5); last=-(-scaled.numerator//scaled.denominator)
 check(H<=F(5*last,64)<H+F(5,64))
 cost,n1=ns['tensor_cost'](ns['axis_data'](c));check(n==n1)
 C+=1;vsum+=v;nsum+=n;top=max(top,last)
 for k,a in zip(keys,cost):step[k]+=a;main[k]+=(last+1)*a
check((C,vsum,nsum,top)==(125400,7133015232,4333246843,127988))
check(step==d['per_extra_height_operations']);check(main==d['main_operations'])
check(main==old['rows']['large']['same_order'])
check(d['transform_setup_retained_from_parent']==old['large_setup']['mixed_full_and_retained_for_pruning'])
check(d['additional_transform_setup_at_same_precision']==0)
check([r['h'] for r in d['rows']]==[10,20,30,50,200,250])
for row in d['rows']:
 h=row['h'];dj=h*64//5;check(F(64*h,5)==dj==row['extra_nodes_each_conductor'])
 for name,val in [('residue_inputs',vsum),('primitive_outputs',nsum),('conductor_height_nodes',C)]:
  check(row['added_'+name]==dj*val)
 check(row['main_plus_auxiliary_residue_inputs']==old['rows']['large']['coarse_residue_inputs']+dj*vsum)
 check(row['main_plus_auxiliary_primitive_outputs']==old['rows']['large']['coarse_primitive_outputs']+dj*nsum)
 for k in keys:
  check(row['added_operations'][k]==dj*step[k])
  check(row['main_plus_auxiliary_operations'][k]==main[k]+dj*step[k])
  check(F(row['transform_ratio_to_main'][k])==F(dj*step[k],main[k]))
 s=row['hypothetical_seed_schedule'];V=10000+h;N=-(-(V+160)//3);D=8192;U=(N+1)*D+1;new=U-27754497;end=top+dj
 for k,val in {'V':V,'N':N,'D':D,'m':64,'P':27,'global_argument_union':U,'new_arguments':new,'added_global_height_argument_pairs':dj*U,'added_initial_leaves_and_step_certificates':new,'added_height_recurrence_updates':dj*U-new,'added_coarse_seed_coefficient_slots':dj*(27*D+20),'added_midpoint_shift_updates':dj*330*D}.items():check(s[k]==val)
 check(row['last_global_index']==end);check(F(row['last_global_height'])==F(5*end,64))
 flags={'scaled_A_lt_5over4':F(V+32,D)<F(5,4),'P27_shift_ratio_lt_15over16':F(3*(V+27),4*D)<F(15,16),'collapsed_seed_error_lt_eta_over4':F(291*N+433,2**22)<F(1,4),'recurrence_lt_11delta_over16':F(9,16)+F(end,2**20)<F(11,16),'recurrence_lt_delta':F(9,16)+F(end,2**20)<1,'stored_seed_magnitude_lt_2pow16':4*(3*N+5)+1<2**16}
 check(row['domain_checks']==flags)
 if h<=200:
  check(all(flags.values()));check(F(216*(N+2),255*2**128)<F(1,2**116))
  check(N+2<4096 and 9*V+1<100000)
 # Includes possible ceil-grid overshoot, not just exact requested H(c).
 check(F(8,3)**18>(F(128160000)+265800*(F(h)+F(5,64)))/6)
check(2-2*F(121,4)/50==F(79,100))
check(2-F(1,2)-2*F(121,4)/50==F(29,100))
out={'status':'PASS_EXACT_METADATA_ONLY','checks':checks,'pins':PINS,'per_step':step,'main':main,'h50_threshold':'D < 79/100 with b=121/4','h50_surplus_if_D_le_half':'29/100','limits':'Reaggregates reviewed fixed-order circuit definitions; no independent reproof of each circuit. No spectral signs or analytic values. h250 seed domain remains invalid under unchanged allocation.'}
HERE.joinpath('review_auxiliary_inventory_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
