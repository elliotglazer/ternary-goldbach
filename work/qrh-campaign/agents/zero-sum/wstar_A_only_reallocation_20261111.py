"""Exact A-only allocation and isolated squarefree-carrier metadata, no values."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
import ast,json

here=Path(__file__).resolve().parent
oldfile=here/'wstar_floor300_metadata_20261111.json'
assert sha256(oldfile.read_bytes()).hexdigest().upper()=='7750B7D1BB25A96D9B4F54A75C4090B9C7ECE591D905DEDC7D244FBA12CCDAD5'
old=json.loads(oldfile.read_text())
q=F(old['Q_A_line_upper']);G=7000000;TA=F(1,125000000)
threshold=(F(1,100000)-TA)**2/G
assert 61**200>10**357 # beta=.5357: Y^(2beta-1)=10^(357/200)<61
assert G*61*q<(F(1,100000)-TA)**2
assert 308**100<10**179*5**100 # 61.6<10^1.79, beta=.5358
assert G*F(308,5)*q>F(1,10**10)
assert F(44722,1000)**2>2000
assert F(1902,10**9)+F(1,100000)+F(512,10**9)*F(44722,1000)<F(2964,1000)*F(1194,10**8)
assert F(2964,1000)**2<F(879,100)

parent=here/'conditional_r132900_pruning_inventory_20261111.py'
assert sha256(parent.read_bytes()).hexdigest().upper()=='074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D'
body=[]
for node in ast.parse(parent.read_text()).body:
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='rows' for t in node.targets):break
    body.append(node)
ns={'__file__':str(parent),'__name__':'metadata_definitions_only'}
exec(compile(ast.Module(body=body,type_ignores=[]),str(parent),'exec'),ns)
keys=ns['KEYS']
def blank():return {'conductors':0,'primitive_labels':0,'sum_primitive_label_grid_nodes':0,
 'sum_primitive_label_integer_heights':0,'max_height':0}
def ceil(x):return (x.numerator+x.denominator-1)//x.denominator
total=blank();large=blank();large['residue_grid_inputs']=0;large['fixed_pruned_operations']={k:0 for k in keys}
dominated=0
for c in range(3,132901,2):
    if any(e!=1 for p,e in ns['factors'](c)):continue
    H=max(300,ceil(F(704*1063200,343*2*c)))
    J=ceil(F(64*H,5))+1
    Hp=ceil(200+max(F(260),F(233,10)*F(3927,1250)*F(1063200,2*c)))
    assert H<=Hp;dominated+=1
    axes=ns['axis_data'](c);cost,n=ns['tensor_cost'](axes)
    v=1
    for d,_ in axes:v*=d
    for row in ([total,large] if c>10000 else [total]):
        row['conductors']+=1;row['primitive_labels']+=n
        row['sum_primitive_label_grid_nodes']+=n*J
        row['sum_primitive_label_integer_heights']+=n*H
        row['max_height']=max(row['max_height'],H)
    if c>10000:
        assert H==300 and J==3841
        large['residue_grid_inputs']+=v*J
        for k,x in zip(keys,cost):large['fixed_pruned_operations'][k]+=J*x
small={k:total[k]-large[k] for k in total if k!='max_height'}
out={'status':'PASS_EXACT_A_ONLY_REALLOCATION','baseline_QA_upper':str(q),
 'required_QA_upper_with_TA':str(threshold),'allowed_baseline_multiplier':str(threshold/q),
 'candidate_beta':'5357/10000','candidate_multiplier_upper':61,
 'candidate_GQA_upper':str(G*61*q),
 'beta_5358_failure_scope':'The chosen count-upper-envelope comparison exceeds1e-10; not a lower bound on actual A or QA.',
 'A_target':'1/10000000000','B_target':2000,'TA_upper':str(TA),
 'squarefree_total':total,'squarefree_large_only':large,'squarefree_small_subtotals':small,
 'plus_height_domination_checks':dominated,
 'scope':'Conditional finite profile only. Isolated grid costs are hypothetical evaluator counts, not a completed weak-strip checker. Existing plus RH union does not shrink.'}
dest=Path(__file__).with_suffix('.json')
if dest.exists():raise SystemExit('Refusing to overwrite receipt')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(out,indent=2))
