"""Exact auxiliary-grid metadata only. No character/root/function evaluations."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
import ast,json

here=Path(__file__).resolve().parent
parent=here/'conditional_r132900_pruning_inventory_20261111.py'
receipt=parent.with_suffix('.json')
assert sha256(parent.read_bytes()).hexdigest().upper()=='074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D'
assert sha256(receipt.read_bytes()).hexdigest().upper()=='E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF'
old=json.loads(receipt.read_text())
# Reuse only the pinned metadata definitions preceding the old row loop.
# Do not execute its old inventory or any output statement.
tree=ast.parse(parent.read_text())
body=[]
for node in tree.body:
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='rows' for t in node.targets):break
    body.append(node)
ns={'__file__':str(parent),'__name__':'pinned_metadata_definitions_only'}
exec(compile(ast.Module(body=body,type_ignores=[]),str(parent),'exec'),ns)
keys=ns['KEYS']
one={k:0 for k in keys}; weighted={k:0 for k in keys}
C=labels=units=SJ=R=Q=0; maxJ=0
for c in range(10001,265801):
    if not ((c%2 and c<=132900) or c%4==0):continue
    axes=ns['axis_data'](c)
    cost,n=ns['tensor_cost'](axes)
    v=1
    for dim,_ in axes:v*=dim
    J=ns['samples'](c)
    C+=1;labels+=n;units+=v;SJ+=J;R+=v*J;Q+=n*J;maxJ=max(maxJ,J)
    for k,val in zip(keys,cost):one[k]+=val;weighted[k]+=J*val
base=old['rows']['large']
assert (C,labels,units,SJ,R,Q,maxJ)==tuple(base[k] for k in ['conductors','primitive_labels','unit_coefficients','nominal_conductor_height_nodes','coarse_residue_inputs','coarse_primitive_outputs','max_height_nodes'])
assert weighted==base['same_order']
rows=[]
old_union=27754497;D=8192;last=maxJ-1
for h in [10,20,30,50,200,250]:
    dj=64*h//5
    assert F(64*h,5)==dj
    V=10000+h;N=(V+160+2)//3
    union=(N+1)*D+1;new_args=union-old_union
    Jend=last+dj
    delta={k:dj*one[k] for k in keys}
    row={'h':h,'extra_nodes_each_conductor':dj,
         'added_residue_inputs':dj*units,'added_primitive_outputs':dj*labels,
         'added_conductor_height_nodes':dj*C,
         'added_operations':delta,
         'main_plus_auxiliary_operations':{k:weighted[k]+delta[k] for k in keys},
         'main_plus_auxiliary_residue_inputs':R+dj*units,
         'main_plus_auxiliary_primitive_outputs':Q+dj*labels,
         'last_global_index':Jend,'last_global_height':str(F(5*Jend,64)),
         'hypothetical_seed_schedule':{'V':V,'N':N,'D':D,'m':64,'P':27,
           'global_argument_union':union,'new_arguments':new_args,
           'added_global_height_argument_pairs':dj*union,
           'added_initial_leaves_and_step_certificates':new_args,
           'added_height_recurrence_updates':dj*union-new_args,
           'added_coarse_seed_coefficient_slots':dj*(27*D+20),
           'added_midpoint_shift_updates':dj*330*D,
           'new_domain_adapter_required':True},
         'domain_checks':{'scaled_A_lt_5over4':F(V+32,D)<F(5,4),
           'P27_shift_ratio_lt_15over16':F(3*(V+27),4*D)<F(15,16),
           'collapsed_seed_error_lt_eta_over4':F(291*N+433,2**22)<F(1,4),
           'recurrence_lt_11delta_over16':F(9,16)+F(Jend,2**20)<F(11,16),
           'recurrence_lt_delta':F(9,16)+F(Jend,2**20)<1,
           'stored_seed_magnitude_lt_2pow16':4*(3*N+5)+1<2**16},
         'transform_ratio_to_main':{k:str(F(delta[k],weighted[k])) for k in keys}}
    if h<=200:
        assert all(row['domain_checks'].values())
        row['seed_status']='CONDITIONAL_DOMAIN_EXTENSION; no values or interpolation guards'
    else:
        assert not row['domain_checks']['scaled_A_lt_5over4']
        assert not row['domain_checks']['P27_shift_ratio_lt_15over16']
        row['seed_status']='NOT_COVERED_BY_UNCHANGED_SCALED_SEED_PROOF; seed counts hypothetical only'
    rows.append(row)
out={'status':'PASS_EXACT_AUXILIARY_INVENTORY','parent_script_sha256':sha256(parent.read_bytes()).hexdigest().upper(),
     'parent_receipt_sha256':sha256(receipt.read_bytes()).hexdigest().upper(),
     'scope':'R132900 c>10000 only; all required primitive channels; same original axis order; no values or sufficient h claim',
     'large_conductors':C,'primitive_labels':labels,'per_extra_height_residue_inputs':units,
     'per_extra_height_primitive_outputs':labels,'per_extra_height_operations':one,
     'main_operations':weighted,'rows':rows,
     'transform_setup_retained_from_parent':old['large_setup']['mixed_full_and_retained_for_pruning'],
     'additional_transform_setup_at_same_precision':0,
     'setup_caveat':'Root/chirp/kernel values must actually be certified at needed precision; any new precision creates a separately charged cache tier.',
     'excluded_branches':{'small_conductors':old['rows']['small']['conductors'],
                          'small_primitive_labels':old['rows']['small']['primitive_labels'],
                          'principal':'excluded entirely'},
     'seed_schedule':'Keep old main seed schedule; at first added global height introduce all new rational arguments, then use the indicated single upper-band N at every added global height. This overcomputes some slots but is exact and shared across conductors.'}
here.joinpath('auxiliary_fixed_order_inventory_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'status':out['status'],'per_height':one,'rows':[{'h':r['h'],'residue':r['added_residue_inputs'],'primitive':r['added_primitive_outputs'],'ops':r['added_operations']} for r in rows]},indent=2))
