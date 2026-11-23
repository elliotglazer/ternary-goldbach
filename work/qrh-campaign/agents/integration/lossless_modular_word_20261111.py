"""One nontrivial modular word, with a fixed recipe and lossless ball nodes.

Generation: external Arb at the original precision. Replay: standard-library
exact arithmetic and frozen pure helpers, no numerical special-function call.
"""
from pathlib import Path
from fractions import Fraction as Q
import copy
import hashlib
import importlib.util
import json
import sys

sys.dont_write_bytecode=True
HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
SHIFTS=(-1,4,2,-12,-2,6)
PINS={
 'integration/lossless_modular_two_step_20261111.py':'9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6',
 'prime-estimates/principal_theta_modular_pilot_20261111.py':'EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14',
 'prime-estimates/principal_theta_modular_pilot_20261111.json':'C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF',
}


def module(name,path):
 s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m


def check_pins():
 for p,h in PINS.items():assert hashlib.sha256((AGENTS/p).read_bytes()).hexdigest().upper()==h,p


def recipe():
 out=[]
 def add(k,kind,op,args=(),**kw):out.append(dict(id=k,kind=kind,op=op,args=list(args),**kw))
 add('tau','complex','unproved_seed')
 prev='tau'
 for i,n in enumerate(SHIFTS):
  p=f's{i}'
  add(p+'.t','complex','translate',[prev],integer=-n)
  add(p+'.phase','complex','phase_eighth',exponent=n)
  if i==len(SHIFTS)-1:break
  add(p+'.next','complex','complex_reciprocal',[p+'.t'],sign=-1)
  add(p+'.z','complex','rotate_minus_i',[p+'.t'])
  add(p+'.x','real','projection',[p+'.z'],coordinate=0)
  add(p+'.y','real','projection',[p+'.z'],coordinate=1)
  add(p+'.xx','real','square',[p+'.x'])
  add(p+'.yy','real','square',[p+'.y'])
  add(p+'.norm2','real','add',[p+'.xx',p+'.yy'])
  add(p+'.norm','real','sqrt_nonnegative',[p+'.norm2'])
  add(p+'.usum','real','add',[p+'.norm',p+'.x'])
  add(p+'.uhalf','real','scale',[p+'.usum'],scale={'mantissa':'1','exponent':-1})
  add(p+'.u','real','sqrt_nonnegative',[p+'.uhalf'])
  add(p+'.den','real','scale',[p+'.u'],scale={'mantissa':'1','exponent':1})
  add(p+'.v','real','divide',[p+'.y',p+'.den'])
  add(p+'.root','complex','assemble',[p+'.u',p+'.v'])
  add(p+'.A','complex','complex_reciprocal',[p+'.root'],sign=1)
  prev=p+'.next'
 return out


def verify(packet):
 check_pins()
 h=module('word_exact_helpers',HERE/'lossless_modular_two_step_20261111.py')
 h.STATS.clear()
 assert packet['format']=='lossless-modular-word-r1over8-v1'
 assert packet['T']==1000000 and packet['r']=='1/8' and packet['shifts']==list(SHIFTS)
 assert packet['seed_expression']=='exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))'
 expected=recipe();assert len(packet['nodes'])==len(expected)
 values,valid,rows={}, {}, []
 for node,spec in zip(packet['nodes'],expected):
  assert {k:v for k,v in node.items() if k!='value'}==spec
  key,kind,op=node['id'],node['kind'],node['op']
  assert key not in values
  value=h.ball(node['value']) if kind=='real' else tuple(h.ball(node['value'][k]) for k in ('re','im'))
  args=[values[k] for k in node['args']]
  ok,detail=True,None
  if op=='unproved_seed':pass
  elif op=='translate':
   t=Q(node['integer']);a=args[0]
   ok=h.contains(value[0],(a[0][0]+t,a[0][1]+t)) and h.contains(value[1],a[1])
  elif op=='phase_eighth':
   n=node['exponent']%8
   signs=((1,0),(1,1),(0,1),(-1,1),(-1,0),(-1,-1),(0,-1),(1,-1))[n]
   checks=[]
   for coord,s in zip(value,signs):
    if n%2==0:checks.append(h.contains(coord,(Q(s),Q(s))))
    else:
     mag=coord if s>0 else (-coord[1],-coord[0])
     checks.append(0<=mag[0]<=mag[1] and mag[0]**2<=Q(1,2)<=mag[1]**2)
   ok=all(checks)
   detail={'target':'exp(pi*i*n/4), exact eighth-root algebraic identity','coordinate_checks':checks}
  elif op=='rotate_minus_i':
   a=args[0];target=(a[1],(-a[0][1],-a[0][0]))
   ok=all(h.contains(x,y) for x,y in zip(value,target))
  elif op=='projection':ok=value==args[0][node['coordinate']]
  elif op=='square':
   ok=h.contains(value,h.square(args[0]))
   detail={'independent_product_also_contained':h.contains(value,h.product(args[0],args[0]))}
  elif op=='add':ok=h.contains(value,(args[0][0]+args[1][0],args[0][1]+args[1][1]))
  elif op=='scale':
   t=h.read_dyadic(node['scale']);ok=h.contains(value,h.product(args[0],(t,t)))
  elif op=='sqrt_nonnegative':
   ok=args[0][0]>=0 and value[0]>=0 and value[0]**2<=args[0][0] and args[0][1]<=value[1]**2
  elif op=='divide':
   a,b=args
   if b[0]<=0<=b[1]:ok=False
   else:
    qs=[x/y for x in a for y in b]
    ok=h.contains(value,(min(qs),max(qs)))
    detail={'corner_contained':[value[0]<=q<=value[1] for q in qs]}
  elif op=='assemble':ok=value==tuple(args)
  elif op=='complex_reciprocal':
   a=args[0]
   if a[0][0]<=0<=a[0][1] and a[1][0]<=0<=a[1][1]:ok=False
   else:
    target=h.reciprocal_rectangle(a)
    if node['sign']==-1:target=tuple((-x[1],-x[0]) for x in target)
    ok=all(h.contains(x,y) for x,y in zip(value,target))
    detail={'coordinate_contained':[h.contains(x,y) for x,y in zip(value,target)]}
  else:raise ValueError(op)
  values[key]=value
  valid[key]=ok and all(valid[k] for k in node['args'])
  rows.append({'id':key,'op':op,'full_input_set_containment':ok,
               'composes_conditional_on_seed':valid[key],'detail':detail,
               'status':'unproved_seed' if op=='unproved_seed' else ('pass' if ok else 'FAIL')})
 domains=[]
 for i,n in enumerate(SHIFTS):
  p=f's{i}';t=values[p+'.t']
  tests={'translated_real_domain':-Q(3,5)<t[0][0]<=t[0][1]<Q(3,5),
         'translated_imag_positive':t[1][0]>0}
  if i<5:
   nxt=values[p+'.next']
   tests.update(inversion_imag_below_half=t[1][1]<Q(1,2),
                inversion_growth=nxt[1][0]>Q(100,61)*t[1][1],
                root_argument_real_positive=values[p+'.x'][0]>0,
                root_u_positive=values[p+'.u'][0]>0,
                root_divisor_positive=values[p+'.den'][0]>0,
                inverse_root_real_positive=values[p+'.root'][0][0]>0)
  else:tests['terminal_imag_above_two_fifths']=t[1][0]>Q(2,5)
  domains.append({'stage':i,'checks':tests})
 return {'all_arithmetic_gates_pass':all(r['full_input_set_containment'] for r in rows),
         'whole_word_composes_conditional_on_seed':all(valid.values()) and all(all(d['checks'].values()) for d in domains),
         'unproved_seed_ids':['tau'],'results':rows,'domain_checks':domains,
         'failed_gate_ids':[r['id'] for r in rows if not r['full_input_set_containment']],
         'stats':dict(h.STATS)}


def generate():
 check_pins()
 h=module('lossless_word_helpers',HERE/'lossless_modular_two_step_20261111.py')
 m=module('lossless_word_original',AGENTS/'prime-estimates/principal_theta_modular_pilot_20261111.py')
 m.ctx.prec=256
 source=json.loads((AGENTS/'prime-estimates/principal_theta_modular_pilot_20261111.json').read_text())['points'][1]
 assert source['T']==1000000 and source['r']=='1/8' and len(source['steps'])==11
 vals={};matches=[]
 def snap(x):
  assert x.is_finite()
  def exact(a):
   mm,ee=a.man_exp();return h.read_dyadic({'mantissa':str(mm),'exponent':int(ee)})
  mid,rad=exact(x.mid()),exact(x.rad())
  return {'mid':h.dyadic(mid),'rad':h.dyadic(rad),'lo':h.dyadic(mid-rad),'hi':h.dyadic(mid+rad)}
 def compare(label,z,old,real=False):
  if real:assert m.binary(z)==old,label
  else:assert m.binary(z.real)==old['binary_re'] and m.binary(z.imag)==old['binary_im'],label
  matches.append(label)
 eta=m.ar(Q(1,1000001));er=(2*m.ar(Q(1,8))).exp()
 current=m.acb(-er*(2*eta).cos(),er*(2*eta).sin());vals['tau']=current
 compare('tau',current,source['initial_tau'])
 si=0
 for i,n in enumerate(SHIFTS):
  p=f's{i}';old=source['steps'][si]
  assert old['kind']=='T' and old['n']==n
  compare(p+'.T_input',current,old['input'])
  t=current-n;vals[p+'.t']=t
  phase=m.phase8(n);vals[p+'.phase']=phase
  compare(p+'.t',t,old['output']);compare(p+'.phase',phase,old['phase8']);si+=1
  if i==5:break
  old=source['steps'][si];assert old['kind']=='S'
  compare(p+'.S_input',t,old['input'])
  nxt=-1/t;vals[p+'.next']=nxt
  z=-m.I*t;vals[p+'.z']=z
  x,y=z.real,z.imag;vals[p+'.x']=x;vals[p+'.y']=y
  xx,yy=x*x,y*y;vals[p+'.xx']=xx;vals[p+'.yy']=yy
  norm2=xx+yy;vals[p+'.norm2']=norm2
  norm=norm2.sqrt();vals[p+'.norm']=norm
  usum=norm+x;vals[p+'.usum']=usum
  uhalf=usum/2;vals[p+'.uhalf']=uhalf
  u=uhalf.sqrt();vals[p+'.u']=u
  den=2*u;vals[p+'.den']=den
  v=y/den;vals[p+'.v']=v
  root=m.acb(u,v);vals[p+'.root']=root
  A=1/root;vals[p+'.A']=A
  compare(p+'.next',nxt,old['output'])
  rw=old['root_witness']
  for key,zv in [('z',z),('root',root),('A',A)]:compare(p+'.'+key,zv,rw[key])
  for key,zv in [('norm',norm),('u',u),('v',v)]:compare(p+'.'+key,zv,rw['binary_'+key],True)
  current=nxt;si+=1
 assert si==11
 compare('terminal',t,source['reduced_tau'])
 nodes=[]
 for spec in recipe():
  x=vals[spec['id']]
  value=snap(x) if spec['kind']=='real' else {'re':snap(x.real),'im':snap(x.imag)}
  nodes.append(dict(spec,value=value))
 return {'format':'lossless-modular-word-r1over8-v1','T':1000000,'r':'1/8','shifts':list(SHIFTS),
         'seed_expression':'exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))',
         'nodes':nodes,'original_snapshot_matches':matches,
         'scope':'One 11-step word only; seed remains unproved, no theta series or derivative unwind'}


def controls(packet):
 out={}
 def test(label,mutate):
  p=copy.deepcopy(packet);mutate(p)
  try:out[label]=not verify(p)['whole_word_composes_conditional_on_seed']
  except (AssertionError,KeyError,ValueError):out[label]=True
 def find(p,k):return next(n for n in p['nodes'] if n['id']==k)
 test('wrong_seed_parameter',lambda p:p.update(r='0'))
 test('changed_word',lambda p:p['shifts'].__setitem__(1,5))
 test('changed_T_operand',lambda p:find(p,'s1.t').update(args=['tau']))
 test('changed_root_v_operand',lambda p:find(p,'s0.v').update(args=['s0.x','s0.den']))
 test('wrong_phase',lambda p:find(p,'s0.phase').update(exponent=1))
 def zero_v(p):
  d={'mantissa':'0','exponent':0};find(p,'s1.v')['value']={k:dict(d) for k in ('mid','rad','lo','hi')}
 test('false_root_v',zero_v)
 assert all(out.values());return out


if __name__=='__main__':
 if len(sys.argv)>1 and sys.argv[1]=='--check':
  data=json.loads(Path(sys.argv[2]).read_text());r=verify(data['packet'])
  assert r==data['verification']
  assert controls(data['packet'])==data['corruption_controls']
  print(json.dumps({'whole_word_composes_conditional_on_seed':r['whole_word_composes_conditional_on_seed'],
                    'failed_gate_ids':r['failed_gate_ids'],'stats':r['stats']},indent=2))
 else:
  p=generate();r=verify(p)
  out={'pins':PINS,'packet':p,'verification':r,'corruption_controls':controls(p),
       'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
  dest=Path(__file__).with_suffix('.json');dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
  print(json.dumps({'nodes':len(p['nodes']),'matched_snapshots':len(p['original_snapshot_matches']),
                    'whole_word_composes_conditional_on_seed':r['whole_word_composes_conditional_on_seed'],
                    'failed_gate_ids':r['failed_gate_ids'],'stats':r['stats'],
                    'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
