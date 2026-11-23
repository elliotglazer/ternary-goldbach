"""Exact saved-data checks only; no evaluator import or new function values."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'zero-sum/high_slab_em_candidate_20261111_01.json':'CF90E96C7531F57E455ABCE70D8D71FB06596E9E1490FADDBAFA6DE64FCB0B09',
 'independent-feasibility/high_slab_independent_replay_20261111_01.json':'407D74A56EEEA8DE3483B3D8E31ED4FFA4A5895ACB262A8632F7EF74BD003C2E',
 'independent-feasibility/review_high_principal_slab_prepared_20261111.py':'757C1D30A2D030CF46863DDF1D43D4F1169ACD67E802CB41181BC0C6B7A1A620'}
def need(p,why):
 if not p:raise ValueError(why)
def xy(p):return tuple(map(Q,p))
def margin(b,r):
 for axis in ('re','im'):need(Q(b[axis][0])<=Q(b[axis][1]),'ordered box')
 return {'1':Q(b['re'][0]),'-1':-Q(b['re'][1]),'i':-Q(b['im'][1]),'-i':Q(b['im'][0])}[r]
def main():
 data={}
 for p,h in PINS.items():
  bs=(AGENTS/p).read_bytes();need(hashlib.sha256(bs).hexdigest().upper()==h,'pin')
  if p.endswith('.json'):data[p]=json.loads(bs)
 a=data['zero-sum/high_slab_em_candidate_20261111_01.json']
 b=data['independent-feasibility/high_slab_independent_replay_20261111_01.json']
 need(b['status']=='PASS_ALL_13_MODELS_ALL_CONSUMED_PANELS_WINDING_ZERO' and 'failure' not in b,'completed run')
 need((b['N'],b['M'],b['K'],b['precision_bits'])==(300001,36,26,160),'alternate parameters')
 expected={f'{side}_{i}':(Q(5+2*i,8),Q(1000000)-offset) for side,offset in [('top',Q(0)),('bottom',Q(1,8))] for i in range(6)}
 expected['left']=(Q(629,1250),Q(1000000)-Q(1,16))
 need(set(b['models'])==set(expected),'thirteen fresh models')
 for name,model in b['models'].items():
  need(xy(model['center'])==expected[name] and len(model['coefficients_zetaF'])==26,'model contract')
  need(Q(model['outer_radius'])==Q(3,4),'outer radius')
  need(Q(model['target_radius'])==(Q(1,16) if name=='left' else Q(1,8)),'target radius')
  for key in ('outer_bound','EM_error_zetaF','Taylor_error_zetaF'):
   lo,hi=map(Q,model[key]);need(0<=lo<=hi,'ordered nonnegative error')
  for box in model['coefficients_zetaF']:
   for axis in ('re','im'):need(Q(box[axis][0])<=Q(box[axis][1]),'ordered coefficient box')
 ps=a['accepted_panels'];checks=b['panel_checks']
 need(len(ps)==len(checks)==14 and len(a['attempts'])==14 and not a['pending_panels'],'complete14')
 margins=[];lengths={s:Q(0) for s in ('bottom','right','top','left')}
 for i,(p,r) in enumerate(zip(ps,checks)):
  need(r['index']==i and r['rotation']==p['rotation'],'same consumed rotation')
  u,v=xy(p['start']),xy(p['end']);need(v==xy(ps[(i+1)%14]['start']),'closed exact input joins')
  side=p['side'];axis=0 if side in ('bottom','top') else 1
  lengths[side]+=abs(v[axis]-u[axis]);need(p['depth']==0,'no refinements')
  if side=='right':need(r['side']=='right' and r['rotation']=='1' and Q(r['strict_margin_lower'])==Q(1,4),'analytic right')
  else:
   need(r['model']==p['model'] and r['start']==p['start'] and r['end']==p['end'],'same whole panel domain')
   need(margin(r['image_zeta'],p['rotation'])==Q(r['strict_margin_lower']),'exact independent margin')
   c=expected[p['model']];h=Q(1,16) if p['model']=='left' else Q(1,8)
   for x,y in (u,v):need(x>=Q(629,1250) and (x-c[0])**2+(y-c[1])**2<=h*h,'EM side/domain disk')
  margins.append(Q(r['strict_margin_lower']))
 need(lengths=={'bottom':Q(1871,1250),'right':Q(1,8),'top':Q(1871,1250),'left':Q(1,8)},'full side lengths')
 need(min(margins)>Q(3,20),'every independent selected-coordinate margin >3/20')
 rotations={'1':(1,0),'-1':(-1,0),'i':(0,1),'-i':(0,-1)}
 vs=list(map(xy,a['polygon']['vertices']));need(len(vs)==15 and vs[0]==vs[-1],'shared polygon')
 crosses=[]
 for i,p in enumerate(ps):
  u,v=vs[i],vs[i+1];r=rotations[p['rotation']]
  need(all(r[0]*z[0]-r[1]*z[1]>0 for z in (u,v)),'vertex memberships')
  det=u[0]*v[1]-u[1]*v[0];dot=u[0]*v[0]+u[1]*v[1]
  need(det!=0 or dot>0,'image edge avoids origin')
  crosses.append(1 if u[1]<=0<v[1] and det>0 else -1 if v[1]<=0<u[1] and det<0 else 0)
 need(crosses==a['polygon']['crossings']==b['polygon']['crossings'] and sum(crosses)==0,'winding zero')
 endpoints=b['endpoint_boxes'];need(len(endpoints)==14 and sum(map(len,endpoints.values()))==26,'all incident numerical endpoints')
 for p in ps:
  if p['side']=='right':continue
  for ep in ('start','end'):
   key=';'.join(p[ep]);records=[v for v in endpoints[key] if v['model']==p['model']]
   need(len(records)==1 and margin(records[0]['value'],p['rotation'])>0,'every actual numerical endpoint')
 out={'status':'PASS_EXACT_SAVED_ALL13_MODELS_ALL14_PANELS','pins':PINS,'new_function_values':0,
      'coefficient_boxes':338,'panels':14,'incident_endpoint_boxes':26,'unique_endpoint_coordinates':14,
      'minimum_independent_margin':str(min(margins)),'margin_lower':'3/20','crossings':crosses,'winding':0,
      'scope':'Stored scientific fields and full domain checks; actual analytic evaluation supplied by separately reviewed complete independent run',
      'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
 path=Path(__file__).with_suffix('.json');need(not path.exists(),'new receipt only')
 path.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8');print(json.dumps(out))
if __name__=='__main__':main()
