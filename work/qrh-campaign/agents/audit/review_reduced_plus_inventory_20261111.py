"""Exact metadata replay. Reuses only the previously pinned circuit cost definitions."""
from pathlib import Path
from fractions import Fraction
from hashlib import sha256
import ast
import json

here=Path(__file__).resolve().parent
agents=here.parent
z=agents/'zero-sum'
pins={
 'zero-sum/REDUCED_PLUS_HEIGHT_SPECTRAL_INVENTORY_2026-11-11.md':'35083351B055958DDB61F1E38BEE8D63566552029298EEB2AC879FD5BE25F96B',
 'zero-sum/reduced_plus_height_inventory_20261111.py':'FEDC889D2B043EAA1AEFA6CF4824107949DC46A372384BC9F451B9B05F33AF47',
 'zero-sum/reduced_plus_height_inventory_20261111.json':'E4876ACF3F57D800118D328B56261149BC66B3A15F2272BDD370D88ECD986791',
 'zero-sum/conditional_r132900_pruning_inventory_20261111.py':'074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D',
 'zero-sum/conditional_r132900_pruning_inventory_20261111.json':'E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF',
 'major-constants/PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md':'3F91F39B485607833A5FADD061BEC7602B1DCC02C77B8FB82CA10B6C076FA6A0',
 'zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md':'E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794',
 'independent-feasibility/BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md':'776CD34413ECC389D10CE510913C694C6D6C34E8555FFE0D66702582B3A23898',
 'prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
 'integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md':'861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895',
}
for p,h in pins.items():
    assert sha256((agents/p).read_bytes()).hexdigest().upper()==h,p
saved=json.loads((z/'reduced_plus_height_inventory_20261111.json').read_text())
old=json.loads((z/'conditional_r132900_pruning_inventory_20261111.json').read_text())
source=z/'conditional_r132900_pruning_inventory_20261111.py'
prefix=[]
for node in ast.parse(source.read_text()).body:
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='rows' for t in node.targets):
        break
    prefix.append(node)
else: raise AssertionError('missing exact metadata boundary')
ns={'__file__':str(source),'__name__':'reviewed_circuit_costs_only'}
exec(compile(ast.Module(body=prefix,type_ignores=[]),str(source),'exec'),ns)
keys=ns['KEYS']

# Independent conductor arithmetic and integer height construction.
spf=[0]*265801
for p in range(2,len(spf)):
    if spf[p]:continue
    for n in range(p,len(spf),p):
        if not spf[n]:spf[n]=p
def invariants(n):
    phi=prim=1
    while n>1:
        p=spf[n]; e=0
        while n%p==0:n//=p;e+=1
        phi*=(p-1)*p**(e-1)
        prim*=p-2 if e==1 else (p-1)**2*p**(e-2)
    return phi,prim
def cd(a,b):return (a+b-1)//b
def blank():
    return dict(conductors=0,primitive_labels=0,unit_coefficients=0,conductor_height_nodes=0,
                residue_inputs=0,primitive_outputs=0,max_nodes=0,max_node_conductors=[],
                operations=dict.fromkeys(keys,0))
def put(row,c,phi,prim,J,cost):
    row['conductors']+=1;row['primitive_labels']+=prim;row['unit_coefficients']+=phi
    row['conductor_height_nodes']+=J;row['residue_inputs']+=phi*J;row['primitive_outputs']+=prim*J
    if J>row['max_nodes']:row['max_nodes']=J;row['max_node_conductors']=[c]
    elif J==row['max_nodes']:row['max_node_conductors'].append(c)
    for k,v in zip(keys,cost):row['operations'][k]+=v*J
base=blank();main=blank();groups={k:blank() for k in saved['groups']}
one=dict.fromkeys(keys,0);exceed=dict.fromkeys(('167','320','640'),0)
top=set();heights=[];gap_max=Fraction(0)
for c in list(range(10001,132901,2))+list(range(10004,265801,4)):
    phi,prim=invariants(c)
    axes=ns['axis_data'](c);cost,n=ns['tensor_cost'](axes)
    v=1
    for dim,_ in axes:v*=dim;top.add(dim)
    assert phi==v and prim==n
    qt=2*c if c%2 else c
    un,ud=(1989,100) if c%2==0 and c>60000 else (233,10)
    H=200+max(260,cd(un*3927*1063200,ud*1250*qt))
    J=cd(64*H,5)+1
    an=100000000 if c%2 or c<=125000 else 200*c+75000000
    Jold=cd(64*an,5*c)+1
    assert J<=Jold
    assert cd(27000000 if c%2 else 54000000,c)<=H
    assert max(300,cd(704*1063200,343*qt))<=H
    gap=Fraction(5*(J-1),64)-H
    assert 0<=gap<=Fraction(1,16)
    gap_max=max(gap_max,gap);heights.append(H)
    put(base,c,phi,prim,Jold,cost);put(main,c,phi,prim,J,cost)
    label='odd' if c%2 else 'even_le_60000' if c<=60000 else 'even_gt_60000'
    put(groups[label],c,phi,prim,J,cost)
    for k,v in zip(keys,cost):one[k]+=v
    for d in exceed:exceed[d]+=J+int(d)>Jold
for row in [base,main,*groups.values()]:row['max_node_conductors'].sort()
assert base==saved['baseline'] and main==saved['main'] and groups==saved['groups']
assert one==saved['per_added_height_operations']
assert exceed==saved['auxiliary_conductors_exceeding_old_own_grid']
assert (min(heights),max(heights))==(saved['height_min'],saved['height_max'])

bands=[(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),(10000,8192,3387)]
def verify_seed(J,claim):
    counts=[0]*5
    for j in range(J):
        b=next(k for k,(V,D,N) in enumerate(bands) if 5*j<=64*V)
        counts[b]+=1
    assert counts==[b['height_nodes'] for b in claim['bands']]
    prev=0
    for cnt,(V,D,N),b in zip(counts,bands,claim['bands']):
        assert (b['V'],b['D'],b['N'])==(V,D,N)
        assert (b['first_index'],b['last_index'])==(prev,prev+cnt-1)
        prev+=cnt
    for key,fun in [
        ('P24_coefficient_slots',lambda D,N:24*(D+1)),
        ('P27_shifted_source_slots',lambda D,N:27*D+20),
        ('P27_midpoint_shift_updates',lambda D,N:sum(min(20,k) for k in range(1,27))*D),
        ('global_height_argument_pairs',lambda D,N:(N+1)*D+1)]:
        assert sum(cnt*fun(D,N) for cnt,(_,D,N) in zip(counts,bands))==claim[key]
        assert all(cnt*fun(D,N)==b[key] for cnt,(_,D,N),b in zip(counts,bands,claim['bands']))
    assert claim['rational_argument_union']==(3389-1)*8192+1==27754497
    assert claim['largest_V']==10000
def check_ratio(value,den,claim):
    assert Fraction(claim['exact'])==Fraction(value,den)
    assert claim['lower_ppm']==value*10**6//den
    assert claim['upper_ppm']==cd(value*10**6,den)
verify_seed(base['max_nodes'],saved['baseline_seed_prefix'])
for scenario in saved['scenarios']:
    d=scenario['extra_nodes'];J=main['max_nodes']+d
    assert J==scenario['global_height_nodes']<=base['max_nodes']
    assert Fraction(scenario['last_global_height'])==Fraction(5*(J-1),64)<=10000
    assert Fraction(scenario['nominal_aux_height'])==Fraction(5*d,64)
    assert scenario['last_global_index']==J-1
    for field,mult in [('conductor_height_nodes','conductors'),('residue_inputs','unit_coefficients'),('primitive_outputs','primitive_labels')]:
        value=main[field]+d*main[mult]
        assert value==scenario['total_'+field]
        if field!='conductor_height_nodes':
            check_ratio(value,base[field],scenario['ratios_to_original_main']['residue' if field=='residue_inputs' else 'primitive'])
    for k in keys:
        assert scenario['added_operations'][k]==d*one[k]
        value=main['operations'][k]+d*one[k]
        assert scenario['total_operations'][k]==value
        check_ratio(value,base['operations'][k],scenario['ratios_to_original_main']['operations'][k])
    verify_seed(J,scenario['seed_prefix'])

# Setup depends only on the unchanged axis family, not the height counts.
active=set();kernels=set()
def visit(n):
    if n in active:return
    active.add(n);choice=ns['choices'][n]
    if choice[0]=='split':visit(choice[1]);visit(choice[2])
    elif choice[0]=='bluestein':kernels.add(n)
for n in top:visit(n)
setup=saved['transform_setup']
assert setup==old['large_setup']['mixed_full_and_retained_for_pruning']
assert (len(top),len(active),len(kernels))==(setup['axis_lengths'],setup['active_nodes'],setup['kernel_count'])
assert sum(ns['blue_length'](n) for n in kernels)==setup['kernel_entries']
assert sum(kernels)==setup['chirp_entries']
assert max(map(ns['blue_length'],kernels))==setup['max_padded_length']
assert sum(n for n in active if ns['choices'][n][0]=='split')==setup['CT_full_root_table_entry_upper']
for k,idx in zip(keys,range(5)):
    assert sum(ns['radix2'](ns['blue_length'](n))[idx] for n in kernels)==setup['kernel_forward_operations'][k]
out={'status':'PASS','scope':'All new metadata recomputed; earlier pinned circuit definitions reused, not independently re-proved.',
     'conductor_checks':len(heights),'main':main,'max_grid_overshoot':str(gap_max),
     'auxiliary_exceeds_old':exceed,'scenario_count':len(saved['scenarios']),
     'seed_prefix_count':1+len(saved['scenarios']),'pins':pins,
     'script_sha256':sha256(Path(__file__).read_bytes()).hexdigest().upper()}
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS','conductors':len(heights),'sha256':sha256(Path(__file__).with_suffix('.json').read_bytes()).hexdigest().upper()}))
