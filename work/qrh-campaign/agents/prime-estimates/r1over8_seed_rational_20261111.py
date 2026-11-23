"""Exact rational supplement for one frozen exp(1/4) times trig seed.

The trig recurrence follows the reviewed lossless_seed_taylor protocol.
Only standard-library exact arithmetic; no numerical exp/trig or Arb imports.
"""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import copy, hashlib, json, sys
HERE=Path(__file__).resolve().parent
SOURCE=HERE.parent/'integration/lossless_modular_word_20261111.json'
SOURCE_SHA='E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910'
EXPR='exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))'
def wire(q):return {'numerator':str(q.numerator),'denominator':str(q.denominator)}
def readq(w):
 assert set(w)=={'numerator','denominator'}
 assert type(w['numerator']) is str and type(w['denominator']) is str
 assert len(w['numerator'])<4096 and len(w['denominator'])<4096
 assert int(w['denominator'])>0
 return Q(int(w['numerator']),int(w['denominator']))
def readd(w):
 assert set(w)=={'mantissa','exponent'} and type(w['exponent']) is int
 assert len(w['mantissa'])<4096 and abs(w['exponent'])<=4096
 m=int(w['mantissa']);assert abs(m).bit_length()<=4096
 return Q(m)*Q(2)**w['exponent']
def target():
 raw=SOURCE.read_bytes();assert hashlib.sha256(raw).hexdigest().upper()==SOURCE_SHA
 p=json.loads(raw)['packet']
 assert p['format']=='lossless-modular-word-r1over8-v1'
 assert type(p['T']) is int and p['T']==1000000 and p['r']=='1/8'
 assert p['seed_expression']==EXPR
 n=p['nodes'][0]
 assert (n['id'],n['kind'],n['op'],n['args'])==('tau','complex','unproved_seed',[])
 result={}
 for part in ('re','im'):
  b=n['value'][part];assert set(b)=={'mid','rad','lo','hi'}
  m,r,l,h=(readd(b[k]) for k in ('mid','rad','lo','hi'))
  assert r>=0 and l==m-r and h==m+r
  result[part]=(l,h)
 return result
def produce():
 x,u=Q(2,1000001),Q(1,4)
 ch={}
 for name,a in (('cos',0),('sin',1)):
  t=[Q(1) if a==0 else x]
  for k in range(6):t.append(t[-1]*x*x/((2*k+a+1)*(2*k+a+2)))
  lo=sum((-1)**k*t[k] for k in range(6));hi=lo+t[6]
  ch[name]={'terms':list(map(wire,t)),'lower':wire(lo),'upper':wire(hi),'ratio':wire(x*x/((a+1)*(a+2)))}
 n=48;t=[Q(1)]
 for k in range(n):t.append(t[-1]*u/(k+1))
 lo=sum(t[:n]);rho=u/(n+1);tail=t[n]/(1-rho)
 exp={'N':n,'terms':list(map(wire,t)),'lower':wire(lo),'upper':wire(lo+tail),
  'tail_ratio':wire(rho),'tail_bound':wire(tail)}
 return {'format':'r1over8-seed-rational-taylor-v1','source_sha256':SOURCE_SHA,
  'source_node':'tau','T':1000000,'r':'1/8','expression':EXPR,'x':wire(x),'u':wire(u),
  'trig_lower_terms':6,'trig_upper_terms':7,'trig':ch,'exp':exp}
def strict_power_lower(q):
 assert q>0
 for j in range(1,4097):
  if Q(1,2**j)<q:return -j
 raise AssertionError('margin too small for bounded diagnostic')
def verify(c):
 assert c['format']=='r1over8-seed-rational-taylor-v1'
 assert c['source_sha256']==SOURCE_SHA and c['source_node']=='tau' and c['expression']==EXPR
 assert type(c['T']) is int and c['T']==1000000 and c['r']=='1/8'
 x,u=readq(c['x']),readq(c['u']);assert x==Q(2,1000001) and u==Q(1,4)
 assert 0<x<1 and 0<u<1
 assert c['trig_lower_terms']==6 and c['trig_upper_terms']==7
 assert set(c['trig'])=={'cos','sin'}
 values=[];intervals={}
 for name,a in (('cos',0),('sin',1)):
  d=c['trig'][name];t=list(map(readq,d['terms']));assert len(t)==7
  assert all(t[k]==x**(2*k+a)/factorial(2*k+a) for k in range(7))
  rho=readq(d['ratio']);assert rho==x*x/((a+1)*(a+2)) and 0<rho<1
  assert all(0<t[k+1]<=rho*t[k]<t[k] for k in range(6))
  lo,hi=readq(d['lower']),readq(d['upper'])
  assert lo==sum((-1)**k*t[k] for k in range(6)) and hi==lo+t[6] and 0<lo<hi
  intervals[name]=(lo,hi);values+=t+[rho,lo,hi]
 d=c['exp'];n=d['N'];assert type(n) is int and n==48
 t=list(map(readq,d['terms']));assert len(t)==n+1
 assert all(t[k]==u**k/factorial(k) for k in range(n+1))
 assert all(t[k+1]*(k+1)==t[k]*u for k in range(n))
 lo,hi=readq(d['lower']),readq(d['upper']);rho=readq(d['tail_ratio']);tail=readq(d['tail_bound'])
 assert rho==u/(n+1) and 0<rho<1
 assert tail*(1-rho)==t[n] and lo==sum(t[:n]) and hi==lo+tail and 0<lo<hi
 # All-index t[n+j] <= t[n]*rho**j is a paper induction, not inferred from finite samples.
 values+=t+[rho,tail,lo,hi]
 cl,ch=intervals['cos'];sl,sh=intervals['sin']
 result={'re':(-hi*ch,-lo*cl),'im':(lo*sl,hi*sh)}
 margins={};power={};dest=target()
 for part in ('re','im'):
  a,b=result[part];l,h=dest[part];assert l<a<b<h
  ms=(a-l,h-b);margins[part]=list(map(wire,ms));power[part]=list(map(strict_power_lower,ms))
  values+=list(ms)+[a,b]
 return {'status':'PASS exact rational containment; paper series proof, not Lean',
  'target_sha256':SOURCE_SHA,'positive_terms_checked':63,
  'seed_enclosure':{k:list(map(wire,v)) for k,v in result.items()},
  'strict_margins':margins,'margin_exceeds_power_of_two':power,
  'exp_tail':wire(tail),'exp_tail_ratio':wire(rho),
  'maximum_integer_bits':max(max(abs(q.numerator).bit_length(),q.denominator.bit_length()) for q in values),
  'no_numerical_oracle':True,'lean_checked':False}
def controls(c):
 out={}
 def test(name,f):
  bad=copy.deepcopy(c);f(bad)
  try:verify(bad);out[name]=False
  except (AssertionError,ValueError,KeyError):out[name]=True
 test('wrong_T',lambda b:b.update(T=1000001))
 test('wrong_r',lambda b:b.update(r='0'))
 test('wrong_x',lambda b:b.update(x=wire(Q(2,1000000))))
 test('wrong_u',lambda b:b.update(u=wire(Q(1,8))))
 test('wrong_expression',lambda b:b.update(expression='-cos(x)+i*sin(x)'))
 test('wrong_source',lambda b:b.update(source_sha256='0'*64))
 test('wrong_node',lambda b:b.update(source_node='s0.t'))
 test('wrong_trig_parity',lambda b:b.update(trig_lower_terms=7))
 test('false_exp_term',lambda b:b['exp']['terms'].__setitem__(12,wire(Q(0))))
 test('zero_exp_tail',lambda b:b['exp'].update(tail_bound=wire(Q(0))))
 test('false_tail_ratio',lambda b:b['exp'].update(tail_ratio=wire(Q(0))))
 test('false_cosine_bound',lambda b:b['trig']['cos'].update(upper=wire(Q(1))))
 assert all(out.values());return out
if __name__=='__main__':
 if len(sys.argv)>1 and sys.argv[1]=='--check':
  d=json.loads(Path(sys.argv[2]).read_text());v=verify(d['certificate'])
  assert v==d['verification'] and controls(d['certificate'])==d['corruption_controls']
 else:
  c=produce();v=verify(c)
  d={'certificate':c,'verification':v,'corruption_controls':controls(c),
   'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
  Path(__file__).with_suffix('.json').write_text(json.dumps(d,indent=2,sort_keys=True)+'\n',encoding='utf8')
 print(json.dumps({k:v[k] for k in ('status','margin_exceeds_power_of_two','maximum_integer_bits')}))
