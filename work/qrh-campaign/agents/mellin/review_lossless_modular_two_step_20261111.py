"""Independent standard-library replay of the frozen 17-node conditional graph."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json
import copy

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'integration/LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md':'2AC88432744B5D99FC821A16E2A0AD2B3AC9AB5483956F1A0B8DB2FAD8CD4230',
 'integration/lossless_modular_two_step_20261111.py':'9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6',
 'integration/lossless_modular_two_step_20261111.json':'31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE',
 'prime-estimates/principal_theta_modular_pilot_20261111.py':'EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14',
 'prime-estimates/principal_theta_modular_pilot_20261111.json':'C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF',
 'mellin/modular_endpoint_export_diagnosis_20261111.json':'6CEA85CA705494E5DD20751722FF620CB6F7AF72EE898EE8C3D680F77DE4011F',
}
for name,expected in PINS.items():
 assert hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper()==expected,name
data=json.loads((AGENTS/'integration/lossless_modular_two_step_20261111.json').read_text())
nodes=data['packet']['nodes']
shape=[
 ('tau','complex','unproved_seed',[]),
 ('translated','complex','translate',['tau']),
 ('S_output','complex','complex_reciprocal',['translated']),
 ('root_argument','complex','rotate_minus_i',['translated']),
 ('root_x','real','projection',['root_argument']),
 ('root_y','real','projection',['root_argument']),
 ('root_x_square','real','square',['root_x']),
 ('root_y_square','real','square',['root_y']),
 ('root_norm_square','real','add',['root_x_square','root_y_square']),
 ('root_norm','real','sqrt_nonnegative',['root_norm_square']),
 ('root_u_sum','real','add',['root_norm','root_x']),
 ('root_u_half','real','scale',['root_u_sum']),
 ('root_u','real','sqrt_nonnegative',['root_u_half']),
 ('root_v_denominator','real','scale',['root_u']),
 ('root_v','real','divide',['root_y','root_v_denominator']),
 ('root','complex','assemble',['root_u','root_v']),
 ('A','complex','complex_reciprocal',['root']),
]
def dy(d):
 assert set(d)=={'mantissa','exponent'}
 m,e=int(d['mantissa']),d['exponent']
 assert type(e) is int and abs(e)<=4096 and abs(m).bit_length()<=4096
 return F(m)*F(2)**e
def real(d):
 m,r,l,h=(dy(d[k]) for k in ['mid','rad','lo','hi'])
 assert r>=0 and (l,h)==(m-r,m+r)
 return l,h
def covers(a,b):return a[0]<=b[0] and b[1]<=a[1]
def interval_product(a,b):
 p=[x*y for x in a for y in b];return min(p),max(p)
def flip(a):return -a[1],-a[0]
def reciprocal(box):
 # A deliberately overinclusive common candidate set for both coordinates.
 (l,r),(b,t)=box
 assert l<=r and b<=t and not(l<=0<=r and b<=0<=t)
 pts={(x,y) for x in [l,r] for y in [b,t]}
 for x in [l,r]:
  for y in [F(0),abs(x),-abs(x)]:
   if b<=y<=t:pts.add((x,y))
 for y in [b,t]:
  for x in [F(0),abs(y),-abs(y)]:
   if l<=x<=r:pts.add((x,y))
 assert all(x*x+y*y>0 for x,y in pts)
 vals=[(x/(x*x+y*y),-y/(x*x+y*y)) for x,y in pts]
 return tuple((min(v[i] for v in vals),max(v[i] for v in vals)) for i in [0,1])

def check(ns):
 assert len(ns)==len(shape)
 vals={};out=[]
 for nd,expected in zip(ns,shape):
  key,kind,op,args=expected
  assert (nd['id'],nd['kind'],nd['op'],nd['args'])==expected
  assert key not in vals and all(a in vals for a in args)
  v=real(nd['value']) if kind=='real' else tuple(real(nd['value'][p]) for p in ['re','im'])
  a=[vals[x] for x in args]
  if op=='unproved_seed':ok=True
  elif op=='translate':
   assert nd['integer']==1
   ok=covers(v[0],(a[0][0][0]+1,a[0][0][1]+1)) and covers(v[1],a[0][1])
  elif op=='rotate_minus_i':ok=covers(v[0],a[0][1]) and covers(v[1],flip(a[0][0]))
  elif op=='projection':
   coord=0 if key=='root_x' else 1;assert nd['coordinate']==coord
   ok=v==a[0][coord]
  elif op=='square':
   l,h=a[0];rng=(F(0) if l<=0<=h else min(l*l,h*h),max(l*l,h*h))
   ok=covers(v,rng)
   assert covers(v,interval_product(a[0],a[0]))
  elif op=='add':ok=covers(v,(a[0][0]+a[1][0],a[0][1]+a[1][1]))
  elif op=='sqrt_nonnegative':ok=a[0][0]>=0 and v[0]>=0 and v[0]**2<=a[0][0] and v[1]**2>=a[0][1]
  elif op=='scale':
   c=F(1,2) if key=='root_u_half' else F(2);assert dy(nd['scale'])==c
   ok=covers(v,(c*a[0][0],c*a[0][1]))
  elif op=='divide':
   assert not a[1][0]<=0<=a[1][1]
   rs=sorted([1/a[1][0],1/a[1][1]])
   ok=covers(v,interval_product(a[0],rs))
  elif op=='assemble':ok=v==tuple(a)
  elif op=='complex_reciprocal':
   sign=-1 if key=='S_output' else 1;assert nd['sign']==sign
   target=reciprocal(a[0]);target=tuple(flip(q) for q in target) if sign<0 else target
   ok=all(covers(x,y) for x,y in zip(v,target))
  else:raise AssertionError(op)
  assert ok,key
  vals[key]=v;out.append({'id':key,'status':'unproved seed' if op=='unproved_seed' else 'PASS'})
 domains=[vals['translated'][1][0]>0,vals['root_x'][0]>0,vals['root_norm'][0]>=0,
          vals['root_u'][0]>0,vals['root_v_denominator'][0]>0,vals['root'][0][0]>0]
 assert all(domains)
 return vals,out
vals,gates=check(nodes)

# Independent reciprocal cases with extrema in the interiors of edges.
assert reciprocal(((F(-2),F(2)),(F(1),F(2))))==((F(-1,2),F(1,2)),(F(-1),F(-1,5)))
assert reciprocal(((F(1),F(2)),(F(-2),F(2))))==((F(1,5),F(1)),(F(-1,2),F(1,2)))
try:reciprocal(((F(-1),F(1)),(F(-1),F(1))))
except AssertionError:pass
else:raise AssertionError('pole allowed')

# Exact prior diagnosis identifies the seed and the first translation.
old=json.loads((AGENTS/'mellin/modular_endpoint_export_diagnosis_20261111.json').read_text())
for part,i in [('re',0),('im',1)]:
 for label,key in [('input','tau'),('output','translated')]:
  a=old['lossless_proposed_payload'][part][label]
  assert vals[key][i]==(dy(a['lo']),dy(a['hi']))

# The nine older rounded snapshot hulls enclose the exact new internal balls.
source=json.loads((AGENTS/'prime-estimates/principal_theta_modular_pilot_20261111.json').read_text())['points'][0]
rw=source['steps'][1]['root_witness']
old_boxes={'tau':source['steps'][0]['input'],'translated':source['steps'][0]['output'],
           'S_output':source['steps'][1]['output'],'root_argument':rw['z'],'root':rw['root'],'A':rw['A']}
for key,bx in old_boxes.items():
 for i,part in enumerate(['re','im']):assert covers(tuple(dy(e) for e in bx['binary_'+part]),vals[key][i])
for key,short in [('root_norm','norm'),('root_u','u'),('root_v','v')]:
 assert covers(tuple(dy(e) for e in rw['binary_'+short]),vals[key])

result={'status':'PASS conditional arithmetic only','pins_checked':len(PINS),
        'gates':gates,'arithmetic_gate_count':16,'domain_checks_passed':6,
        'independent_product_square_checks':2,'reciprocal_noncorner_regressions':2,
        'reciprocal_pole_rejected':True,'old_snapshot_hulls_checked':9,
        'seed_and_translation_match_prior_lossless_diagnosis':True,
        'scope':'No producer import, Arb import, generation, analytic seed validation or later graph replay.'}
p=HERE/'review_lossless_modular_two_step_20261111.json'
p.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if k!='gates'},indent=2))
