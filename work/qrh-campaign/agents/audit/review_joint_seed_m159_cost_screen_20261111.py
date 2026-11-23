"""Independent count algebra and bounded integer screen; no analytic values."""
from pathlib import Path
import json,hashlib

ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-campaign/agents/independent-feasibility'
pins={
 'JOINT_SEED_M159_COST_AND_NM_SCREEN_2026-11-11.md':'463E5617A73FC661D2F7229026F1F6A584298C7190767D3D58E5AAEAC9A3640F',
 'joint_seed_m159_cost_screen_20261111.py':'D91EC28FD860780C95412B13F8C4167E0EB364B8490D6A9FD71D0567D6185F93',
 'joint_seed_m159_cost_screen_20261111.json':'DDF48DE42BBB771591E25ABA23327A8B283DDE84DABD8F609ABB348E5A291BB2',
}
checks=0
def ck(x):
 global checks
 checks+=1
 assert x,checks
for p,h in pins.items():ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
data=json.loads((BASE/'joint_seed_m159_cost_screen_20261111.json').read_text())
for p,h in data['pins'].items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)

def row(N,m,D=4096,P=28,quarter=True):
 orders=[(D,P),(1,P if quarter else 20)]
 slots=sum(n*p for n,p in orders)
 return dict(head_scales=N*sum(n*(p-1) for n,p in orders),head_adds=N*slots,
 gamma_scales=m*slots,gamma_adds=m*slots,E_stages=sum(n*(p+2*m-2) for n,p in orders),source_slots=slots,coarse_anchors=D+1,R_stages=P-1,
 shift_updates=(3 if quarter else 1)*D*sum(P-k-1 for k in range(20)),normalization_scales=20*(4*D+1) if quarter else 0,normalization_rounds=20*(4*D+1) if quarter else 0,argument_pairs=(N+1)*D+1)
selected=row(1500,159)
ck(selected==data['accepted'])
rows={'B':row(2387,64,8192,27,False),'Q':row(2387,64),'C':row(1500,256,8192,27,False),'J':row(1500,256)}
for name,r in rows.items():
 ck({k:r[k]-selected[k] for k in selected}==data['differences'][name])
for scenario,H in zip(data['scenarios'],[20199,20366,20519,20839]):
 ck(scenario==dict(H=H,total=64001+H,totals=dict({k:H*v for k,v in selected.items()},fine_state_updates=H*selected['argument_pairs'])))

# Compare symbolic price coefficients, including the introduced-state sign.
unions={'B':19562497,'Q':9781249,'C':13197313,'selected':7049217}
initial={'B':12513280,'Q':2732032,'C':6148096,'selected':0}
logstages={'B':410791416,'Q':205385187,'C':296046954,'selected':148013397}
anchors={'B':1001,'Q':1002,'C':959,'selected':960}
expected_setup={'B':[12513280,262778019,41],'Q':[2732032,57371790,42],'C':[6148096,148033557,-1]}
for name in ['B','Q','C']:
 u=unions[name]-unions['selected'];l=logstages[name]-logstages['selected'];z=anchors[name]-anchors['selected']
 ck([u,l,z]==expected_setup[name]);ck(u==initial[name]-initial['selected'])
 for H in [20199,20366,20519,20839]:
  ck((H*rows[name]['argument_pairs']-initial[name])-H*selected['argument_pairs']==H*data['differences'][name]['argument_pairs']-u)
ck(data['shared_setup']==dict(union=7049217,log_anchors=960,log_stages=148013397))

# Small binary searches derive the least *strict* integer upper roots; no
# floating-point sqrt or producer isqrt routine is used.
def strict_root(n,multiplier=1):
 low,high=0,1
 while multiplier*high*high<=n:high*=2
 while high-low>1:
  mid=(low+high)//2
  if multiplier*mid*mid>n:high=mid
  else:low=mid
 ck(multiplier*(high-1)**2<=n<multiplier*high**2)
 return high

screen_rows=[]
for N,stored in zip([1400,1450,1500,1550,1600,1660,1720],data['screens']):
 S=strict_root(N+2);tests=[]
 for m in range(64,257):
  W=strict_root(4*7000**2+(4*m+53)**2,4)
  passed=8*S*W**(2*m)*2**116 < (4*m-1)*(6*(N+1))**(2*m)
  tests.append((m,W,passed))
 m,W,_=next(t for t in tests if t[2])
 ck(all(not p for old,_,p in tests if old<m))
 ck(20*W<17*6*(N+1) and W<4096*(N+1))
 candidate=row(N,m)
 diff={k:candidate[k]-selected[k] for k in selected}
 expected=dict(N=N,m=m,W=W,sqrt_cap=S,test_range=[64,256],minimal_in_test_range=True,row=candidate,union=1721*4096+1,introduced=0,retired=(1720-N)*4096,difference_from_accepted=diff,additional_gamma_from_64=m-64)
 ck(stored==expected)
 ck(candidate['argument_pairs']+expected['retired']==expected['union'])
 screen_rows.append(expected)
chosen=next(r for r in screen_rows if r['N']==1450)
ck(chosen['m']==184 and chosen['W']==7012 and chosen['sqrt_cap']==39)
diff=chosen['difference_from_accepted']
for k,v in {'head_scales':-5530950,'head_adds':-5735800,'gamma_scales':2867900,'gamma_adds':2867900,'E_stages':204850,'argument_pairs':-204800}.items():ck(diff[k]==v)
for k in set(selected)-{'head_scales','head_adds','gamma_scales','gamma_adds','E_stages','argument_pairs'}:ck(diff[k]==0)
ck(184-159==25)
out=dict(status='PASS cost algebra and bounded screen only; N1450/m184 not a full error approval',checks=checks,packet_pins=pins,input_pins=data['pins'],accepted=selected,differences=data['differences'],setup_differences=expected_setup,screens=screen_rows)
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(f'PASS {checks} exact count/symbolic-price/strict-root screen checks.')
