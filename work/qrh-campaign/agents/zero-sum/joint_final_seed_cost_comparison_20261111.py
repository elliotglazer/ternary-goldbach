"""Fourth-row cost differences after independent joint mathematical review."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
A=HERE.parent
pins={
 A/'major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
 A/'major-constants/joint_quarter_mesh_head_tradeoff_20261111.json':'F1686B1C1A3183082D9126F4FE680BE6DB42A88D31F82071B752759EE3DE9BD4',
 A/'audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A',
 A/'independent-feasibility/final_seed_cost_choice_20261111.json':'7E8ABFDC0F2A212B975738DE94D17448F8A6C9EA597D3203A01933A4FB8882E9',
 HERE/'REVIEW_FINAL_SEED_CONDITIONAL_COST_CHOICE_2026-11-11.md':'168F3FE5497E9923DE193324E470EA5F37337A724525C35589E19BD5328EA5F9'}
checks=0
def ck(v):
    global checks
    assert v
    checks+=1
for p,h in pins.items():ck(hashlib.sha256(p.read_bytes()).hexdigest().upper()==h)
old=json.loads((A/'independent-feasibility/final_seed_cost_choice_20261111.json').read_text())
joint=json.loads((A/'major-constants/joint_quarter_mesh_head_tradeoff_20261111.json').read_text())
D,N,P,m=4096,1500,28,256
orders=[P]*(D+1);slots=sum(orders)
jrow=dict(head_scales=N*sum(k-1 for k in orders),head_adds=N*slots,
 gamma_scales=m*slots,gamma_adds=m*slots,E_stages=sum(k+2*m-2 for k in orders),
 source_slots=slots,coarse_anchors=D+1,R_stages=P-1,
 shift_updates=3*D*sum(min(20,j+1) for j in range(P-1)),
 normalization_scales=20*(4*D+1),normalization_rounds=20*(4*D+1),argument_pairs=(N+1)*D+1)
mapping={'head_scales':'head_scales','head_adds':'head_additions','gamma_scales':'Bernoulli_terms','gamma_adds':'Bernoulli_additions','E_stages':'E_stages','source_slots':'source_slots','coarse_anchors':'coarse_anchors','R_stages':'shared_R_stages','shift_updates':'translations','normalization_scales':'final_power2_scales','normalization_rounds':'final_rounds'}
for a,b in mapping.items():ck(jrow[a]==joint['per_height']['joint'][b])
prior=1721*4096+1
setup=dict(union=prior,introduced=0,log_stages=21*(prior-960),anchors=960,new_gamma=192)
ck(setup['log_stages']==joint['log_setup']['degree21_stages'])
ck(jrow['argument_pairs']==joint['transition']['retained'])
rows=old['per_height']|{'J':jrow};setups=old['setup']|{'J':setup}
diffs={}
for name in ['B','Q','C']:
    d={k:rows[name][k]-jrow[k] for k in jrow}
    f={k:setups[name][k]-setup[k] for k in setup}
    ck(f['union']==f['introduced'])
    # Record C_name-C_joint, including signed setup and update replacement.
    diffs[name+'J']=dict(per_height=d,setup_difference=f)
scenarios=[]
for H in [20199,20366,20519,20839]:
    totals={name:({k:H*v for k,v in row.items()}|{'fine_state_updates':H*row['argument_pairs']-setups[name]['introduced']}) for name,row in rows.items()}
    jsc=next(s for s in joint['scenarios'] if s['final_heights']==H)
    ck(totals['J']['fine_state_updates']==jsc['argument_work']['joint']['updates'])
    for a,b in mapping.items():ck(totals['J'][a]==jsc['work']['joint'][b])
    scenarios.append(dict(H=H,totals=totals))
out=dict(scope='Conditional common-price fourth-row extension; no measured prices',checks=checks,
 pins={str(p):h for p,h in pins.items()},per_height=rows,setup=setups,differences=diffs,scenarios=scenarios)
with (HERE/'joint_final_seed_cost_comparison_20261111.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'joint':jrow,'setup':setup,'differences':diffs},indent=2))
