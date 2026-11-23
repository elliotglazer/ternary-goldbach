"""Independent exact full-input check of one conditional 11-step word."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json,copy
HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'integration/LOSSLESS_MODULAR_WORD_R1OVER8_2026-11-11.md':'449D40E3447F91532A8DFB7240833FF16511DAECA96C21C1DAFDE01F9C51D790',
 'integration/lossless_modular_word_20261111.py':'9B6B49FF7EBC546BD4D340F89A954519B420047F0858D8DFF1001E4F708E4720',
 'integration/lossless_modular_word_20261111.json':'E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910',
 'prime-estimates/principal_theta_modular_pilot_20261111.json':'C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF',
}
for p,h in PINS.items():assert hashlib.sha256((AGENTS/p).read_bytes()).hexdigest().upper()==h,p
data=json.loads((AGENTS/'integration/lossless_modular_word_20261111.json').read_text())
SHIFTS=[-1,4,2,-12,-2,6]
def dy(p):return F(int(p['mantissa']))*F(2)**p['exponent']
def real(p):
 m,r,lo,hi=(dy(p[k]) for k in ('mid','rad','lo','hi'))
 assert r>=0 and (lo,hi)==(m-r,m+r)
 return lo,hi
def covers(a,b):return a[0]<=b[0]<=b[1]<=a[1]
def neg(a):return -a[1],-a[0]
def mul(a,b):
 v=[x*y for x in a for y in b];return min(v),max(v)
def reciprocal(z):
 (l,r),(b,t)=z
 assert not(l<=0<=r and b<=0<=t)
 pts={(x,y) for x in (l,r) for y in (b,t)}
 for x in (l,r):
  for y in (F(0),abs(x),-abs(x)):
   if b<=y<=t:pts.add((x,y))
 for y in (b,t):
  for x in (F(0),abs(y),-abs(y)):
   if l<=x<=r:pts.add((x,y))
 out=[(x/(x*x+y*y),-y/(x*x+y*y)) for x,y in pts]
 return tuple((min(v[i] for v in out),max(v[i] for v in out)) for i in (0,1))
def shape():
 out=[dict(id='tau',kind='complex',op='unproved_seed',args=[])]
 def add(k,kind,op,args=(),**kw):out.append(dict(id=k,kind=kind,op=op,args=list(args),**kw))
 prev='tau'
 for i,n in enumerate(SHIFTS):
  p=f's{i}.'
  add(p+'t','complex','translate',[prev],integer=-n)
  add(p+'phase','complex','phase_eighth',exponent=n)
  if i==5:break
  add(p+'next','complex','complex_reciprocal',[p+'t'],sign=-1)
  add(p+'z','complex','rotate_minus_i',[p+'t'])
  for j,a in enumerate(('x','y')):add(p+a,'real','projection',[p+'z'],coordinate=j)
  for a in ('x','y'):add(p+a+a,'real','square',[p+a])
  add(p+'norm2','real','add',[p+'xx',p+'yy'])
  add(p+'norm','real','sqrt_nonnegative',[p+'norm2'])
  add(p+'usum','real','add',[p+'norm',p+'x'])
  add(p+'uhalf','real','scale',[p+'usum'],scale={'mantissa':'1','exponent':-1})
  add(p+'u','real','sqrt_nonnegative',[p+'uhalf'])
  add(p+'den','real','scale',[p+'u'],scale={'mantissa':'1','exponent':1})
  add(p+'v','real','divide',[p+'y',p+'den'])
  add(p+'root','complex','assemble',[p+'u',p+'v'])
  add(p+'A','complex','complex_reciprocal',[p+'root'],sign=1)
  prev=p+'next'
 return out
def verify(packet):
 assert packet['format']=='lossless-modular-word-r1over8-v1'
 assert packet['T']==1000000 and packet['r']=='1/8' and packet['shifts']==SHIFTS
 assert packet['seed_expression']=='exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))'
 assert len(packet['nodes'])==len(shape())==88
 vals={};rows=[];divisions=[];products=[]
 for node,spec in zip(packet['nodes'],shape()):
  assert {k:v for k,v in node.items() if k!='value'}==spec
  k,kind,op=node['id'],node['kind'],node['op']
  assert k not in vals
  v=real(node['value']) if kind=='real' else tuple(real(node['value'][a]) for a in ('re','im'))
  args=[vals[a] for a in node['args']]
  if op=='unproved_seed':pass
  elif op=='translate':
   a=args[0];n=node['integer'];assert covers(v[0],(a[0][0]+n,a[0][1]+n)) and covers(v[1],a[1])
  elif op=='phase_eighth':
   n=node['exponent']%8
   signs=((1,0),(1,1),(0,1),(-1,1),(-1,0),(-1,-1),(0,-1),(1,-1))[n]
   for interval,sgn in zip(v,signs):
    if n%2==0:assert covers(interval,(F(sgn),F(sgn)))
    else:
     lo,hi=interval if sgn>0 else neg(interval)
     assert 0<=lo<=hi and lo*lo<=F(1,2)<=hi*hi
  elif op=='rotate_minus_i':assert covers(v[0],args[0][1]) and covers(v[1],neg(args[0][0]))
  elif op=='projection':assert v==args[0][node['coordinate']]
  elif op=='square':
   lo,hi=args[0];target=(F(0) if lo<=0<=hi else min(lo*lo,hi*hi),max(lo*lo,hi*hi))
   assert covers(v,target) and covers(v,mul(args[0],args[0]));products.append(k)
  elif op=='add':assert covers(v,(args[0][0]+args[1][0],args[0][1]+args[1][1]))
  elif op=='scale':assert covers(v,mul(args[0],(dy(node['scale']),dy(node['scale']))))
  elif op=='sqrt_nonnegative':assert args[0][0]>=0 and v[0]>=0 and v[0]**2<=args[0][0] and v[1]**2>=args[0][1]
  elif op=='divide':
   a,b=args;assert not b[0]<=0<=b[1]
   target=mul(a,tuple(sorted([1/b[0],1/b[1]])))
   assert covers(v,target);divisions.append(k)
  elif op=='assemble':assert v==tuple(args)
  elif op=='complex_reciprocal':
   target=reciprocal(args[0])
   if node['sign']==-1:target=tuple(neg(a) for a in target)
   assert all(covers(a,b) for a,b in zip(v,target))
  else:raise AssertionError(op)
  vals[k]=v;rows.append(k)
 domains=[];prev='tau';nearest=[]
 for i,n in enumerate(SHIFTS):
  p=f's{i}.';t=vals[p+'t']
  tests=[-F(3,5)<t[0][0]<=t[0][1]<F(3,5),t[1][0]>0]
  # Construct a rational approximation with n as a nearest integer.
  a=vals[prev][0];mid=(a[0]+a[1])/2;hat=max(F(n)-F(1,2),min(F(n)+F(1,2),mid))
  assert max(abs(a[0]-hat),abs(a[1]-hat))<F(1,10)
  nearest.append(str(hat))
  if i<5:
   tests += [t[1][1]<F(1,2),vals[p+'next'][1][0]>F(100,61)*t[1][1],vals[p+'x'][0]>0,vals[p+'u'][0]>0,vals[p+'den'][0]>0,vals[p+'root'][0][0]>0]
   prev=p+'next'
  else:tests += [t[1][0]>F(2,5)]
  assert all(tests);domains.extend(tests)
 assert len(domains)==43
 return vals,divisions,products,nearest
vals,divisions,products,nearest=verify(data['packet'])
# Preserve distinct outer-snapshot semantics; check containment, not identity.
source=json.loads((AGENTS/'prime-estimates/principal_theta_modular_pilot_20261111.json').read_text())['points'][1]
assert source['T']==1000000 and source['r']=='1/8' and len(source['steps'])==11
oldchecks=[]
def oldcomplex(label,key,b):
 for i,a in enumerate(('re','im')):assert covers(tuple(dy(x) for x in b['binary_'+a]),vals[key][i])
 oldchecks.append(label)
oldcomplex('tau','tau',source['initial_tau'])
prev='tau'
for i,n in enumerate(SHIFTS):
 p=f's{i}.';step=source['steps'][2*i];assert step['kind']=='T' and step['n']==n
 oldcomplex(p+'T_input',prev,step['input']);oldcomplex(p+'t',p+'t',step['output']);oldcomplex(p+'phase',p+'phase',step['phase8'])
 if i==5:break
 step=source['steps'][2*i+1];assert step['kind']=='S'
 oldcomplex(p+'S_input',p+'t',step['input']);oldcomplex(p+'next',p+'next',step['output'])
 rw=step['root_witness']
 for a in ('z','root','A'):oldcomplex(p+a,p+a,rw[a])
 for a in ('norm','u','v'):
  assert covers(tuple(dy(x) for x in rw['binary_'+a]),vals[p+a]);oldchecks.append(p+a)
 prev=p+'next'
oldcomplex('terminal','s5.t',source['reduced_tau']);assert len(oldchecks)==60
assert len(divisions)==5 and len(products)==10
out={'status':'PASS conditional arithmetic for r=1/8 only','pins':PINS,'nodes':88,'nonseed_gates_or_constants':87,
 'domain_checks':43,'full_box_root_v_divisions':divisions,'independent_product_squares':products,
 'complex_reciprocals':10,'old_outer_snapshot_containments':len(oldchecks),'nearest_integer_witnesses':nearest,
 'unproved_seed':'exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))',
 'scope':'No producer/numerical library import; no theta or derivative evaluation; no actual seed certification.'}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k not in ('pins','nearest_integer_witnesses','independent_product_squares')},indent=2))
