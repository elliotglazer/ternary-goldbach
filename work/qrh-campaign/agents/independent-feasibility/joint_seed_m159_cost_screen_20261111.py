"""Conditional cost update and bounded exact remainder screen. No function values."""
from pathlib import Path
from math import isqrt
import hashlib,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
P,D,V=28,4096,7000
pins={
'work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md':'E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9',
'work/qrh-blueprint/check_joint_seed_m159_20261111.py':'7F0B7BD1C597629D6DBD687730E767C5CB660286F6B5CBA57599EF24757E84A4',
'work/qrh-blueprint/joint_seed_m159_20261111.json':'EF16593CF667377CD68CA9D3C37343E3364ECA06CABACCC9B8465931E2D83D45',
'work/qrh-campaign/agents/audit/REVIEW_JOINT_SEED_159_CORRECTIONS_2026-11-11.md':'09DEF5ABB358A807936270B07E61FFEE624EF0F04C3E17AC47A1179D944E2E82',
'work/qrh-campaign/agents/zero-sum/JOINT_FINAL_SEED_CONDITIONAL_COST_COMPARISON_2026-11-11.md':'369DD6AB04FC68ACB675BBFB24518E2CD025C0D8416D07A99A5BC747F7E86249',
'work/qrh-campaign/agents/independent-feasibility/review_joint_final_seed_cost_20261111.json':'C77F6F4E1C5A8B63A632ABDC35119A659AAF2BB6E283A8D4148B4295A6A4C598'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
old=json.loads((HERE/'review_joint_final_seed_cost_20261111.json').read_text())
def row(N,m):
 slots=P*(D+1)
 return dict(head_scales=N*(P-1)*(D+1),head_adds=N*slots,
  gamma_scales=m*slots,gamma_adds=m*slots,E_stages=(P+2*m-2)*(D+1),
  source_slots=slots,coarse_anchors=D+1,R_stages=P-1,
  shift_updates=3*D*(20*P-210),normalization_scales=20*(4*D+1),
  normalization_rounds=20*(4*D+1),argument_pairs=(N+1)*D+1)
ck(row(1500,256)==old['rows']['J'])
new=row(1500,159)
for key in ['gamma_scales','gamma_adds']:ck(old['rows']['J'][key]-new[key]==11127452)
ck(old['rows']['J']['E_stages']-new['E_stages']==794818)
differences={k:{s:v[s]-new[s] for s in new} for k,v in old['rows'].items()}
scenarios=[]
for H in [20199,20366,20519,20839]:
 totals={k:H*v for k,v in new.items()}
 totals['fine_state_updates']=H*new['argument_pairs']
 ck(totals['fine_state_updates']==H*6148097)
 scenarios.append(dict(H=H,total=64001+H,totals=totals))

screens=[]
for N in [1400,1450,1500,1550,1600,1660,1720]:
 results=[]
 for m in range(64,257):
  W=isqrt(4*V*V+(4*m+53)**2)//2+1
  S=isqrt(N+2)+1
  ck(4*W*W>4*V*V+(4*m+53)**2)
  ck(S*S>N+2)
  lhs=8*S*W**(2*m)*2**116
  rhs=(4*m-1)*(6*(N+1))**(2*m)
  results.append((lhs<rhs,m,W,S))
 first=next((r for r in results if r[0]),None)
 ck(first is not None)
 _,m,W,S=first
 ck(all(not r[0] for r in results if r[1]<m))
 ck(20*W<17*6*(N+1))
 ck(W<D*(N+1))
 candidate=row(N,m)
 ck(candidate['argument_pairs']<=1721*4096+1)
 screens.append(dict(N=N,m=m,W=W,sqrt_cap=S,
  test_range=[64,256],minimal_in_test_range=True,row=candidate,
  union=1721*4096+1,introduced=0,retired=(1720-N)*D,
  difference_from_accepted={k:candidate[k]-new[k] for k in new},
  additional_gamma_from_64=m-64))
chosen=next(r for r in screens if r['N']==1450)
ck(chosen['m']==184)
ck(chosen['difference_from_accepted']['head_scales']==-5530950)
ck(chosen['difference_from_accepted']['head_adds']==-5735800)
ck(chosen['difference_from_accepted']['gamma_scales']==2867900)
ck(chosen['difference_from_accepted']['E_stages']==204850)
ck(chosen['difference_from_accepted']['argument_pairs']==-204800)
out=dict(scope='Accepted m159 cost only; other pairs are remainder/cost screens, not full error approvals',
 pins=pins,checks=checks,accepted=new,differences= differences,
 scenarios=scenarios,screens=screens,
 shared_setup=dict(union=7049217,log_anchors=960,log_stages=148013397))
dest=HERE/'joint_seed_m159_cost_screen_20261111.json'
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
