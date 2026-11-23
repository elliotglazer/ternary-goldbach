"""Exact schedule metadata only: no roots, characters, L values, or zero tests."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
import ast,json

here=Path(__file__).resolve().parent
parent=here/'conditional_r132900_pruning_inventory_20261111.py'
receipt=parent.with_suffix('.json')
plus=here.parent/'major-constants/PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md'
pins={parent:'074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D',
      receipt:'E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF',
      plus:'3F91F39B485607833A5FADD061BEC7602B1DCC02C77B8FB82CA10B6C076FA6A0'}
for p,h in pins.items(): assert sha256(p.read_bytes()).hexdigest().upper()==h
old=json.loads(receipt.read_text())
tree=ast.parse(parent.read_text());body=[]
for node in tree.body:
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='rows' for t in node.targets):break
    body.append(node)
ns={'__file__':str(parent),'__name__':'pinned_metadata_definitions_only'}
exec(compile(ast.Module(body=body,type_ignores=[]),str(parent),'exec'),ns)
keys=ns['KEYS']
def zeros():return {k:0 for k in keys}
def ceil(x):return (x.numerator+x.denominator-1)//x.denominator
def ratio(a,b):
    return {'exact':str(F(a,b)), 'lower_ppm':a*10**6//b,'upper_ppm':(a*10**6+b-1)//b}
def blank():return {'conductors':0,'primitive_labels':0,'unit_coefficients':0,
                    'conductor_height_nodes':0,'residue_inputs':0,'primitive_outputs':0,
                    'max_nodes':0,'max_node_conductors':[],'operations':zeros()}
def add_row(row,c,v,n,J,cost):
    row['conductors']+=1;row['primitive_labels']+=n;row['unit_coefficients']+=v
    row['conductor_height_nodes']+=J;row['residue_inputs']+=v*J;row['primitive_outputs']+=n*J
    if J>row['max_nodes']:row['max_nodes']=J;row['max_node_conductors']=[c]
    elif J==row['max_nodes']:row['max_node_conductors'].append(c)
    for k,x in zip(keys,cost):row['operations'][k]+=J*x

baseline=blank();main=blank();one=zeros();groups={k:blank() for k in ['odd','even_le_60000','even_gt_60000']}
samples={};subsetchecks=unionchecks=0;maxH=0;minH=10**9
aux_exceeds_old={str(d):0 for d in [167,320,640]}
for c in range(10001,265801):
    if not ((c%2 and c<=132900) or c%4==0):continue
    axes=ns['axis_data'](c);cost,n=ns['tensor_cost'](axes)
    v=1
    for dim,_ in axes:v*=dim
    qt=2*c if c%2 else c
    u=F(1989,100) if c%2==0 and c>60000 else F(233,10)
    H=ceil(200+max(F(260),u*F(3927,1250)*F(1063200,qt)))
    J=(64*H+4)//5+1
    oldJ=ns['samples'](c)
    assert J<=oldJ;subsetchecks+=1
    baseH=ceil(F(27000000 if c%2 else 54000000,c))
    starH=max(300,ceil(F(704*1063200,343*qt)))
    assert baseH<=H and starH<=H;unionchecks+=1
    add_row(baseline,c,v,n,oldJ,cost);add_row(main,c,v,n,J,cost)
    group='odd' if c%2 else ('even_le_60000' if c<=60000 else 'even_gt_60000')
    add_row(groups[group],c,v,n,J,cost)
    for k,x in zip(keys,cost):one[k]+=x
    minH=min(minH,H);maxH=max(maxH,H)
    for d in [167,320,640]:aux_exceeds_old[str(d)]+=int(J+d>oldJ)
    if c in (10001,10004,10007,60000,60004,100000,125000,132899,265800):
        samples[str(c)]={'H_plus':H,'J_main':J,'last_main_height':str(F(5*(J-1),64)),
                         'J_old':oldJ,'H_base':baseH,'H_star300':starH,'u':str(u)}
b=old['rows']['large']
for newkey,oldkey in [('conductors','conductors'),('primitive_labels','primitive_labels'),
 ('unit_coefficients','unit_coefficients'),('conductor_height_nodes','nominal_conductor_height_nodes'),
 ('residue_inputs','coarse_residue_inputs'),('primitive_outputs','coarse_primitive_outputs'),('max_nodes','max_height_nodes')]:
    assert baseline[newkey]==b[oldkey]
assert baseline['operations']==b['same_order']

bands=[(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),(10000,8192,3387)]
def seed_prefix(J):
    out=[];previous=-1
    for V,D,N in bands:
        last=min(J-1,64*V//5)
        count=max(0,last-previous)
        if count:
            out.append({'V':V,'D':D,'N':N,'first_index':previous+1,'last_index':last,
              'height_nodes':count,'P24_coefficient_slots':count*24*(D+1),
              'P27_shifted_source_slots':count*(27*D+20),
              'P27_midpoint_shift_updates':count*330*D,
              'global_height_argument_pairs':count*((N+1)*D+1)})
        previous=last
        if last==J-1:break
    assert sum(x['height_nodes'] for x in out)==J
    return {'bands':out,'P24_coefficient_slots':sum(x['P24_coefficient_slots'] for x in out),
      'P27_shifted_source_slots':sum(x['P27_shifted_source_slots'] for x in out),
      'P27_midpoint_shift_updates':sum(x['P27_midpoint_shift_updates'] for x in out),
      'global_height_argument_pairs':sum(x['global_height_argument_pairs'] for x in out),
      'rational_argument_union':27754497,'largest_V':out[-1]['V'],
      'new_seed_domain_adapter_required':False,
      'caveat':'Alternative slot ledgers, not simultaneously generated; old band parameters retained.'}
scenarios=[]
for d in [0,167,320,640]:
    J=main['max_nodes']+d
    assert J<=baseline['max_nodes']
    ops={k:main['operations'][k]+d*one[k] for k in keys}
    row={'extra_nodes':d,'nominal_aux_height':str(F(5*d,64)),
      'total_conductor_height_nodes':main['conductor_height_nodes']+d*main['conductors'],
      'total_residue_inputs':main['residue_inputs']+d*main['unit_coefficients'],
      'total_primitive_outputs':main['primitive_outputs']+d*main['primitive_labels'],
      'added_operations':{k:d*one[k] for k in keys},'total_operations':ops,
      'global_height_nodes':J,'last_global_index':J-1,'last_global_height':str(F(5*(J-1),64)),
      'seed_prefix':seed_prefix(J),
      'ratios_to_original_main':{'residue':ratio(main['residue_inputs']+d*main['unit_coefficients'],baseline['residue_inputs']),
       'primitive':ratio(main['primitive_outputs']+d*main['primitive_labels'],baseline['primitive_outputs']),
       'operations':{k:ratio(ops[k],baseline['operations'][k]) for k in keys}}}
    scenarios.append(row)
out={'status':'PASS_CONDITIONAL_REDUCED_PLUS_HEIGHT_INVENTORY',
 'pins':{str(p.relative_to(here.parent.parent.parent)):h for p,h in pins.items()},
 'formula':'ceil(200+max(260,u*(3927/1250)*1063200/qt(c))); u=1989/100 for even c>60000,233/10 otherwise',
 'grid':'J=ceil(64*integer_certificate_height/5)+1; indices0..J-1; auxiliary nodes appended after J-1',
 'baseline':baseline,'main':main,'groups':groups,'samples':samples,
 'height_min':minH,'height_max':maxH,'main_subset_checks':subsetchecks,'union_checks':unionchecks,
 'auxiliary_conductors_exceeding_old_own_grid':aux_exceeds_old,
 'per_added_height_operations':one,'scenarios':scenarios,'baseline_seed_prefix':seed_prefix(baseline['max_nodes']),
 'transform_setup':old['large_setup']['mixed_full_and_retained_for_pruning'],
 'additional_setup_at_same_precision':0,
 'excluded':{'small_conductors':old['rows']['small']['conductors'],
             'small_primitive_labels':old['rows']['small']['primitive_labels'],'principal':'all, retains RH1e8 separately'},
 'scope':'Metadata only. Main/aux sign success, Turing closure and actual numerical values are not asserted. Fixed original axis order only.'}
dest=Path(__file__).with_suffix('.json')
if dest.exists():raise SystemExit('Refusing to overwrite receipt')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8',newline='\n')
print(json.dumps({'main':main,'samples':samples,'scenario_summaries':[{
 'extra':r['extra_nodes'],'residue':r['total_residue_inputs'],'primitive':r['total_primitive_outputs'],
 'G':r['total_operations'][keys[0]],'A':r['total_operations'][keys[1]],
 'last_height':r['last_global_height'],'seedP24':r['seed_prefix']['P24_coefficient_slots']} for r in scenarios]},indent=2))
