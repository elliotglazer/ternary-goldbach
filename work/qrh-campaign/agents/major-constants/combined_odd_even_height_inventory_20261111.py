"""Integer-only combined profile inventory, retaining old seed bands and circuits."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
import ast,json
HERE=Path(__file__).resolve().parent
prior=HERE/'coupled_plus_height_inventory_20261111.py'
prior_data=prior.with_suffix('.json')
pins={prior:'3ED2792A965169994B716B12DDE43034E58FC8FDD9D1B8E28AE065D3C39FFF11',
 prior_data:'676388307D0353800DB72B85ED9252C83E3BA4F62F3D54F63A5C3B43A7DB4267',
 HERE/'ODD_PLUS_SHARED_RH_HEIGHT_2026-11-11.md':'C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D',
 HERE.parent/'moebius/EVEN_GAUSS_PLUS_HEIGHT_PROFILE_2026-11-11.md':'D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B'}
for p,h in pins.items():assert sha256(p.read_bytes()).hexdigest().upper()==h
h4data=json.loads(prior_data.read_text())
tree=ast.parse(prior.read_text());body=[]
for n in tree.body:
    if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='baseline' for t in n.targets):break
    body.append(n)
ns={'__file__':str(prior),'__name__':'pinned_metadata_prefix_only'}
exec(compile(ast.Module(body=body,type_ignores=[]),str(prior),'exec'),ns)
blank,add,ceil,ratio,keys,ledger=(ns[k] for k in ('blank','add','ceil','ratio','keys','ledger'))
old=ns['old'];oldseed=ns['oldseed'];circuit=ns['ns']
ns['bands']=[(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),(10000,8192,3387)]
seednode=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='seed')
exec(compile(ast.Module(body=[seednode],type_ignores=[]),str(prior),'exec'),ns)
seed=ns['seed']
current=blank();h4=blank();main=blank();one={k:0 for k in keys};examples={}
exceeds={str(d):{'H4_main':0,'current_main':0} for d in [0,167,320,640]}
for c in range(10001,265801):
    if not((c%2 and c<=132900) or c%4==0):continue
    axes=circuit['axis_data'](c);cost,n=circuit['tensor_cost'](axes);v=1
    for dim,_ in axes:v*=dim
    qt=2*c if c%2 else c;D=F(1063200,qt)
    uc=F('19.89') if c%2==0 and c>60000 else F('23.3')
    hc=ceil(200+max(F(260),uc*F('3.1416')*D))
    hfour=ceil(200+max(F(255),F('19.5')*F('3.1416')*D))
    u=F('19.2') if c%2 else F('19.1');floor=240 if c%2 else 255
    hp=ceil(200+max(F(floor),u*F('3.1416')*D))
    hb=ceil(F(27000000 if c%2 else 54000000,c))
    hs=ceil(max(F(300),F(704,343)*D))
    hn=max(hp,hb,hs)
    assert hn==hp and hn<=hfour<=hc
    jc,j4,jn=(ceil(F(64*h,5))+1 for h in (hc,hfour,hn))
    add(current,c,v,n,jc,cost);add(h4,c,v,n,j4,cost);add(main,c,v,n,jn,cost)
    for k,x in zip(keys,cost):one[k]+=x
    for d in [0,167,320,640]:
        exceeds[str(d)]['H4_main']+=int(jn+d>j4)
        exceeds[str(d)]['current_main']+=int(jn+d>jc)
    if c in [10001,10004,60000,60004,100000,132899,265800]:
        examples[str(c)]={'combined_height':hn,'H4_height':hfour,'current_height':hc,'combined_nodes':jn}
assert current==old['main']
assert h4==h4data['candidate_main']
assert one==old['per_added_height_operations']==h4data['per_added_node_operations']
scenarios=[]
for d in [0,167,320,640]:
    ref=next(s for s in old['scenarios'] if s['extra_nodes']==d)
    four=next(s for s in h4data['scenarios'] if s['extra_nodes']==d)
    pcurrent=next(s for s in oldseed['scenarios'] if s['extra_nodes']==d)
    assert ledger(seed(h4['max_nodes']+d))['totals']==four['selected_P27']['totals']
    assert ledger(seed(current['max_nodes']+d))['totals']==pcurrent['totals']
    J=main['max_nodes']+d;assert J<=h4['max_nodes'] and J<128000
    ops={k:main['operations'][k]+d*one[k] for k in keys}
    residue=main['residue_inputs']+d*main['unit_coefficients'];H=19*residue
    r={'extra_nodes':d,'aux_height':str(F(5*d,64)),
       'conductor_height_nodes':main['conductor_height_nodes']+d*main['conductors'],
       'residue_inputs':residue,'primitive_outputs':main['primitive_outputs']+d*main['primitive_labels'],
       'operations':ops,'P20_Horner_stages':H,'global_nodes':J,'last_height':str(F(5*(J-1),64)),
       'selected_P27':ledger(seed(J))}
    for name,ro,po in [('H4',four['operations'],four['selected_P27']['totals']),('current',ref['total_operations'],pcurrent['totals'])]:
        r['operation_ratios_to_'+name]={k:ratio(x,ro[k]) for k,x in ops.items()}
        r['P27_ratios_to_'+name]={k:ratio(x,po[k]) for k,x in r['selected_P27']['totals'].items()}
    G,A=ops[keys[0]],ops[keys[1]]
    r['transform_plus_Horner_real_counts']={name:{'products':p*G+2*H,'additions':2*A+a*G+2*H}
       for name,p,a in [('four',4,2),('fixed_three',3,3),('gauss_three',3,5)]}
    scenarios.append(r)
out={'scope':'conditional combined odd/even profile; unchanged bands and circuits; no values or spectral claim',
 'input_sha256':{str(p):h for p,h in pins.items()},'current_Tplus_main':current,'H4_main':h4,
 'combined_main':main,'scenarios':scenarios,'examples':examples,'aux_exceeds_comparison_main':exceeds,
 'per_extra_node_operations':one,'transform_setup_unchanged':h4data['transform_setup_unchanged'],
 'seed_setup_unchanged':h4data['seed_setup_unchanged'],'excluded':h4data['excluded'],'V7000_retune_counted':False}
dest=Path(__file__).with_suffix('.json')
if dest.exists():raise SystemExit('Refusing overwrite')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'main':main,'examples':examples,'scenarios':[{'d':s['extra_nodes'],'G':s['operations'][keys[0]],'A':s['operations'][keys[1]],'inputs':s['residue_inputs'],'outputs':s['primitive_outputs'],'J':s['global_nodes'],'last':s['last_height'],'ratio_H4':s['operation_ratios_to_H4'][keys[0]],'ratio_Tplus':s['operation_ratios_to_current'][keys[0]]} for s in scenarios]},indent=2))
