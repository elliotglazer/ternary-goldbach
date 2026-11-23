"""Conditional integer-only inventory. Reuses pinned fixed circuits and P27 ledger."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
import ast,json

HERE=Path(__file__).resolve().parent
ZS=HERE.parent/'zero-sum'
inputs={
 ZS/'conditional_r132900_pruning_inventory_20261111.py':'074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D',
 ZS/'reduced_plus_height_inventory_20261111.json':'E4876ACF3F57D800118D328B56261149BC66B3A15F2272BDD370D88ECD986791',
 ZS/'reduced_prefix_selected_p27_20261111.py':'5399F8E2498E14F5CCD8516F1967F87A0DAEC969F46C6909BA4E24242BD6A23B',
 ZS/'reduced_prefix_selected_p27_20261111.json':'B8227C3C7A9F46947BB765C8D1B9A70359A3CBE4C7B96CC0A962B7E27560A38A',
 HERE/'COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md':'6767F9E14E5B6D7264D972085EA9C70359C87544403D37DAE315CBEF2510FC54',
}
for p,h in inputs.items():assert sha256(p.read_bytes()).hexdigest().upper()==h
source=ZS/'conditional_r132900_pruning_inventory_20261111.py'
tree=ast.parse(source.read_text());body=[]
for node in tree.body:
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='rows' for t in node.targets):break
    body.append(node)
ns={'__file__':str(source),'__name__':'pinned_metadata_definitions_only'}
exec(compile(ast.Module(body=body,type_ignores=[]),str(source),'exec'),ns)
keys=ns['KEYS']
old=json.loads((ZS/'reduced_plus_height_inventory_20261111.json').read_text())
oldseed=json.loads((ZS/'reduced_prefix_selected_p27_20261111.json').read_text())
ledgernode=next(n for n in ast.parse((ZS/'reduced_prefix_selected_p27_20261111.py').read_text()).body if isinstance(n,ast.FunctionDef) and n.name=='ledger')
lns={}
exec(compile(ast.Module(body=[ledgernode],type_ignores=[]),'pinned_P27_ledger','exec'),lns)
ledger=lns['ledger']
def ceil(x):return (x.numerator+x.denominator-1)//x.denominator
def blank():return dict(conductors=0,primitive_labels=0,unit_coefficients=0,conductor_height_nodes=0,
 residue_inputs=0,primitive_outputs=0,max_nodes=0,max_node_conductors=[],operations={k:0 for k in keys})
def add(out,c,v,n,J,cost):
    for k,x in [('conductors',1),('primitive_labels',n),('unit_coefficients',v),('conductor_height_nodes',J),('residue_inputs',J*v),('primitive_outputs',J*n)]:out[k]+=x
    if J>out['max_nodes']:out['max_nodes']=J;out['max_node_conductors']=[c]
    elif J==out['max_nodes']:out['max_node_conductors'].append(c)
    for k,x in zip(keys,cost):out['operations'][k]+=J*x
def ratio(a,b):return {'exact':str(F(a,b)),'lower_ppm':a*10**6//b,'upper_ppm':(a*10**6+b-1)//b}
baseline=blank();main=blank();one={k:0 for k in keys};exceeds={str(d):0 for d in [0,167,320,640]};examples={}
for c in range(10001,265801):
    if not((c%2 and c<=132900) or c%4==0):continue
    axes=ns['axis_data'](c);cost,n=ns['tensor_cost'](axes);v=1
    for dim,_ in axes:v*=dim
    qt=2*c if c%2 else c
    uold=F('19.89') if c%2==0 and c>60000 else F('23.3')
    Hold=ceil(200+max(F(260),uold*F('3.1416')*F(1063200,qt)))
    Hnew=ceil(200+max(F(255),F('19.5')*F('3.1416')*F(1063200,qt)))
    Jold=ceil(F(64*Hold,5))+1;Jnew=ceil(F(64*Hnew,5))+1
    assert Jnew<=Jold
    assert ceil(F(27000000 if c%2 else 54000000,c))<=Hnew
    assert ceil(max(F(300),F(704*1063200,343*qt)))<=Hnew
    add(baseline,c,v,n,Jold,cost);add(main,c,v,n,Jnew,cost)
    for k,x in zip(keys,cost):one[k]+=x
    for d in [0,167,320,640]:exceeds[str(d)]+=int(Jnew+d>Jold)
    if c in [10001,10004,60000,60004,100000,132899,265800]:examples[str(c)]={'Hnew':Hnew,'Hold':Hold,'Jnew':Jnew,'Jold':Jold}
assert baseline==old['main']
assert one==old['per_added_height_operations']
bands=[(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),(10000,8192,3387)]
def seed(J):
    rows=[];prev=-1
    for V,D,N in bands:
        last=min(J-1,64*V//5);H=max(0,last-prev)
        if H:rows.append({'V':V,'D':D,'N':N,'first_index':prev+1,'last_index':last,'height_nodes':H})
        prev=last
        if last==J-1:break
    assert sum(r['height_nodes'] for r in rows)==J
    return {'bands':rows,'global_height_argument_pairs':sum(r['height_nodes']*((r['N']+1)*r['D']+1) for r in rows),
      'P27_shifted_source_slots':sum(r['height_nodes']*(27*r['D']+20) for r in rows),
      'P27_midpoint_shift_updates':sum(r['height_nodes']*330*r['D'] for r in rows)}
scenarios=[]
for d in [0,167,320,640]:
    oldrow=next(s for s in old['scenarios'] if s['extra_nodes']==d)
    oldp=next(s for s in oldseed['scenarios'] if s['extra_nodes']==d)
    assert ledger(seed(baseline['max_nodes']+d))['totals']==oldp['totals']
    J=main['max_nodes']+d;assert J<128000 and J<=baseline['max_nodes']
    ops={k:main['operations'][k]+d*one[k] for k in keys}
    r={'extra_nodes':d,'aux_height':str(F(5*d,64)),
       'conductor_height_nodes':main['conductor_height_nodes']+d*main['conductors'],
       'residue_inputs':main['residue_inputs']+d*main['unit_coefficients'],
       'primitive_outputs':main['primitive_outputs']+d*main['primitive_labels'],
       'operations':ops,'global_nodes':J,'last_height':str(F(5*(J-1),64)),
       'selected_P27':ledger(seed(J)),
       'ratios_to_same_aux_fallback':{k:ratio(x,oldrow['total_operations'][k]) for k,x in ops.items()},
       'ratios_to_fallback_main':{k:ratio(x,baseline['operations'][k]) for k,x in ops.items()}}
    r['P27_ratios_to_same_aux_fallback']={k:ratio(x,oldp['totals'][k]) for k,x in r['selected_P27']['totals'].items()}
    H=19*r['residue_inputs'];H0=19*oldrow['total_residue_inputs']
    r['P20_Horner_stages']=H
    r['P20_Horner_ratio_to_same_aux_fallback']=ratio(H,H0)
    r['transform_plus_Horner_real_counts']={}
    G=ops[keys[0]];A=ops[keys[1]]
    G0=oldrow['total_operations'][keys[0]];A0=oldrow['total_operations'][keys[1]]
    for name,products,adds in [('four',4,2),('fixed_three',3,3),('gauss_three',3,5)]:
        rp=products*G+2*H;ra=2*A+adds*G+2*H
        r['transform_plus_Horner_real_counts'][name]={'products':rp,'additions':ra,
          'product_ratio':ratio(rp,products*G0+2*H0),'addition_ratio':ratio(ra,2*A0+adds*G0+2*H0)}
    scenarios.append(r)
out={'scope':'conditional large-branch integer metadata; no spectral or arithmetic values',
     'input_sha256':{str(p):h for p,h in inputs.items()},'fallback_main':baseline,'candidate_main':main,
     'per_added_node_operations':one,'scenarios':scenarios,'examples':examples,
     'aux_conductors_exceeding_own_fallback_main':exceeds,
     'transform_setup_unchanged':old['transform_setup'],'seed_setup_unchanged':oldseed['unchanged_setup'],
     'excluded':old['excluded'],'new_setup_at_same_precision':0}
dest=Path(__file__).with_suffix('.json')
if dest.exists():raise SystemExit('Refusing overwrite')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'candidate_main':main,'scenarios':[{'d':r['extra_nodes'],'G':r['operations'][keys[0]],'A':r['operations'][keys[1]],'inputs':r['residue_inputs'],'outputs':r['primitive_outputs'],'global_nodes':r['global_nodes'],'last_height':r['last_height'],'ratio':r['ratios_to_same_aux_fallback'][keys[0]]} for r in scenarios]},indent=2))
