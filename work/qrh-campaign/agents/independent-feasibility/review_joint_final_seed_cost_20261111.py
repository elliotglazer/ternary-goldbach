"""Independent integer reconstruction only; imports no author code or evaluator."""
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
A=HERE.parent
pins={
'zero-sum/JOINT_FINAL_SEED_CONDITIONAL_COST_COMPARISON_2026-11-11.md':'369DD6AB04FC68ACB675BBFB24518E2CD025C0D8416D07A99A5BC747F7E86249',
'zero-sum/joint_final_seed_cost_comparison_20261111.py':'D3205492D6BB3268389CF77018883FE933B3DB4F5FE043D3E23B4C6FF809BD51',
'zero-sum/joint_final_seed_cost_comparison_20261111.json':'30EF060C3A13338B6336F208012475A48B5B6B511D92CB58499AE9358D07CECD',
'major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
'major-constants/joint_quarter_mesh_head_tradeoff_20261111.json':'F1686B1C1A3183082D9126F4FE680BE6DB42A88D31F82071B752759EE3DE9BD4',
'audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A',
'independent-feasibility/FINAL_SEED_CONDITIONAL_COST_CHOICE_2026-11-11.md':'DEB728C9991A4B906B49D65651CD8E6C994CF814C0091809A3CB7138A157D1B2',
'independent-feasibility/final_seed_cost_choice_20261111.json':'7E8ABFDC0F2A212B975738DE94D17448F8A6C9EA597D3203A01933A4FB8882E9',
'zero-sum/REVIEW_FINAL_SEED_CONDITIONAL_COST_CHOICE_2026-11-11.md':'168F3FE5497E9923DE193324E470EA5F37337A724525C35589E19BD5328EA5F9'}
checks=0
def ck(v):
    global checks
    assert v
    checks+=1
for p,h in pins.items():
    ck(hashlib.sha256((A/p).read_bytes()).hexdigest().upper()==h)
saved=json.loads((A/'zero-sum/joint_final_seed_cost_comparison_20261111.json').read_text())
params={'B':(8192,2387,64,27),'Q':(4096,2387,64,28),
        'C':(8192,1500,256,27),'J':(4096,1500,256,28)}
rows={}
for label,(D,N,m,P) in params.items():
    endpoint=P if D==4096 else 20
    slots=D*P+endpoint
    row=dict(head_scales=N*(slots-(D+1)),head_adds=N*slots,
             gamma_scales=m*slots,gamma_adds=m*slots,
             E_stages=slots+(2*m-2)*(D+1),source_slots=slots,
             coarse_anchors=D+1,R_stages=P-1,
             shift_updates=D*(3 if D==4096 else 1)*(20*P-210),
             normalization_scales=20*16385 if D==4096 else 0,
             normalization_rounds=20*16385 if D==4096 else 0,
             argument_pairs=D*(N+1)+1)
    for key,value in row.items():ck(value==saved['per_height'][label][key])
    rows[label]=row
prior=1721*4096+1
introduced={'B':2388*8192+1-prior,'Q':2388*4096+1-prior,
            'C':1501*4096,'J':0}
unions={name:prior+introduced[name] for name in params}
anchors={'B':1001,'Q':1002,'C':959,'J':960}
log_points={'B':unions['B'],'Q':unions['Q'],'C':1721*8192+1,'J':prior}
setups={}
for name in params:
    s=dict(union=unions[name],introduced=introduced[name],
           log_stages=21*(log_points[name]-anchors[name]),anchors=anchors[name],
           new_gamma=192 if name in ['C','J'] else 0)
    for k,v in s.items():ck(v==saved['setup'][name][k])
    setups[name]=s
ck(prior-rows['J']['argument_pairs']==901120)
diffs={}
for name in ['B','Q','C']:
    d={k:rows[name][k]-rows['J'][k] for k in rows[name]}
    s={k:setups[name][k]-setups['J'][k] for k in setups[name]}
    for k,v in d.items():ck(v==saved['differences'][name+'J']['per_height'][k])
    for k,v in s.items():ck(v==saved['differences'][name+'J']['setup_difference'][k])
    ck(s['union']==s['introduced'])
    diffs[name+'J']={'per_height':d,'setup':s}
for scenario,H in zip(saved['scenarios'],[20199,20366,20519,20839]):
    ck(scenario['H']==H)
    ck(64001+H in [84200,84367,84520,84840])
    for name,row in rows.items():
        for k,v in row.items():ck(scenario['totals'][name][k]==H*v)
        ck(scenario['totals'][name]['fine_state_updates']==H*row['argument_pairs']-introduced[name])
    for name in ['B','Q','C']:
        # Basis-by-basis coefficient identity, including setup replacement.
        dx=rows[name]['argument_pairs']-rows['J']['argument_pairs']
        di=introduced[name]-introduced['J']
        ck(scenario['totals'][name]['fine_state_updates']-scenario['totals']['J']['fine_state_updates']==H*dx-di)
        ck(scenario['totals'][name]['argument_pairs']-scenario['totals']['J']['argument_pairs']==H*dx)
out=dict(scope='Independent cost algebra only; joint analytic proof reused at its reviewed scope',
         checks=checks,pins=pins,rows=rows,setups=setups,differences=diffs,
         H=[20199,20366,20519,20839],m=256)
dest=HERE/'review_joint_final_seed_cost_20261111.json'
with dest.open('x',encoding='utf8') as f:
    json.dump(out,f,indent=2)
    f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
