"""Independent metadata replay using only the reviewer's pinned circuit code."""
from pathlib import Path
from fractions import Fraction as F
import ast,hashlib,json

HERE=Path(__file__).resolve().parent
A=HERE.parent;P=A/'major-constants'
prior=HERE/'review_coupled_plus_cost_20261111.py'
assert hashlib.sha256(prior.read_bytes()).hexdigest().upper()=='9AA5978290D0B42541C4E1160BF002D712A5457D0CC362153D2E85E6DFC6E8F9'
# Reuse our independent arithmetic sieve/circuit, but no prior full conductor loop.
tree=ast.parse(prior.read_text());prefix=[]
for node in tree.body:
 if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='tot' for t in node.targets):break
 prefix.append(node)
ns={'__file__':str(prior),'__name__':'independent_reviewer_definitions'}
exec(compile(ast.Module(body=prefix,type_ignores=[]),str(prior),'exec'),ns)
for node in tree.body:
 if isinstance(node,ast.FunctionDef) and node.name in ('ledger','rat'):
  exec(compile(ast.Module(body=[node],type_ignores=[]),str(prior),'exec'),ns)
eq=ns['eq'];keys=ns['keys'];blank=ns['blank'];ceiling=ns['ceiling'];ledger=ns['ledger'];rat=ns['rat']
rec=P/'combined_odd_even_height_inventory_20261111.json'
author=json.loads(rec.read_text());h4=ns['author'];old=ns['old'];oldseed=ns['oldseed']
pins={str(prior):hashlib.sha256(prior.read_bytes()).hexdigest().upper()}
for p,h in author['input_sha256'].items():
 eq(hashlib.sha256(Path(p).read_bytes()).hexdigest().upper(),h);pins[p]=h
report=P/'COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md'
eq(hashlib.sha256(report.read_bytes()).hexdigest().upper(),'6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C')
tot=[blank(),blank(),blank()];one=ns['Z'];examples={}
exceeds={str(d):dict(H4_main=0,current_main=0) for d in (0,167,320,640)}
for c in range(10001,265801):
 if not(c%4==0 or c%2 and c<=132900):continue
 ax=ns['axes'](c);v=ns['phi'][c];cost=ns['tensor'](ax)
 num=ns['prod']((p-2) if e==1 else (p-1)**2*p**(e-2) for p,e in ns['fac'](c))
 qt=c if c%2==0 else 2*c
 uc=1989 if c%2==0 and c>60000 else 2330
 hc=200+ceiling(max(260*125000*qt,uc*3927*1063200),125000*qt)
 hf=200+ceiling(max(255*2500*qt,39*3927*1063200),2500*qt)
 up=192 if c%2 else 191;floor=240 if c%2 else 255
 hp=200+ceiling(max(floor*12500*qt,up*3927*1063200),12500*qt)
 hb=ceiling(27000000 if c%2 else 54000000,c)
 hs=max(300,ceiling(704*1063200,343*qt))
 eq(max(hp,hb,hs),hp);eq(hp<=hf<=hc,True)
 js=[ceiling(64*h,5)+1 for h in (hc,hf,hp)]
 one=ns['add'](one,cost)
 for b,J in zip(tot,js):
  for k,x in [('conductors',1),('primitive_labels',num),('unit_coefficients',v),('conductor_height_nodes',J),('residue_inputs',J*v),('primitive_outputs',J*num)]:b[k]+=x
  if J>b['max_nodes']:b['max_nodes']=J;b['max_node_conductors']=[c]
  elif J==b['max_nodes']:b['max_node_conductors'].append(c)
  for k,x in zip(keys,cost):b['operations'][k]+=J*x
 for d in (0,167,320,640):
  exceeds[str(d)]['H4_main']+=js[2]+d>js[1]
  exceeds[str(d)]['current_main']+=js[2]+d>js[0]
 if str(c) in author['examples']:examples[str(c)]=dict(combined_height=hp,H4_height=hf,current_height=hc,combined_nodes=js[2])
for b,k in zip(tot,('current_Tplus_main','H4_main','combined_main')):eq(b,author[k])
eq(tot[0],old['main']);eq(tot[1],h4['candidate_main']);eq(examples,author['examples']);eq(exceeds,author['aux_exceeds_comparison_main'])
eq(ns['obj'](one),author['per_extra_node_operations'])
scenarios=[]
for s in author['scenarios']:
 d=s['extra_nodes'];J=tot[2]['max_nodes']+d
 refs=[next(x for x in source['scenarios'] if x['extra_nodes']==d) for source in (old,h4,oldseed)]
 eq(ledger(tot[0]['max_nodes']+d)['totals'],refs[2]['totals'])
 eq(ledger(tot[1]['max_nodes']+d),refs[1]['selected_P27'])
 eq(ledger(J),s['selected_P27']);eq(J,s['global_nodes']);eq(str(F(5*(J-1),64)),s['last_height']);eq(str(F(5*d,64)),s['aux_height'])
 eq(J<=tot[1]['max_nodes'] and J<128000,True)
 for k,vkey in [('conductor_height_nodes','conductors'),('residue_inputs','unit_coefficients'),('primitive_outputs','primitive_labels')]:eq(tot[2][k]+d*tot[2][vkey],s[k])
 for k in keys:
  v=tot[2]['operations'][k]+d*ns['obj'](one)[k];eq(v,s['operations'][k])
  eq(rat(v,refs[0]['total_operations'][k]),s['operation_ratios_to_current'][k])
  eq(rat(v,refs[1]['operations'][k]),s['operation_ratios_to_H4'][k])
 for k,v in s['selected_P27']['totals'].items():
  eq(rat(v,refs[2]['totals'][k]),s['P27_ratios_to_current'][k])
  eq(rat(v,refs[1]['selected_P27']['totals'][k]),s['P27_ratios_to_H4'][k])
 H=19*s['residue_inputs'];eq(H,s['P20_Horner_stages'])
 g=s['operations'][keys[0]];a=s['operations'][keys[1]]
 for method,m,b in [('four',4,2),('fixed_three',3,3),('gauss_three',3,5)]:
  eq(dict(products=m*g+2*H,additions=2*a+b*g+2*H),s['transform_plus_Horner_real_counts'][method])
 scenarios.append(dict(extra_nodes=d,global_nodes=J,totals=ledger(J)['totals'],operations=s['operations']))
for key in ('transform_setup_unchanged','seed_setup_unchanged','excluded'):eq(author[key],h4[key])
eq(author['V7000_retune_counted'],False)
for p in (report,rec,P/'combined_odd_even_height_inventory_20261111.py'):
 pins[str(p)]=hashlib.sha256(p.read_bytes()).hexdigest().upper()
out=dict(status='PASS_INDEPENDENT_COMBINED_HEIGHT_METADATA',checks=ns['checks'],pins=pins,
 reused_reviewer_scope='Pinned independent circuit definitions and P27 ledger only; no author code execution',
 totals=tot,per_extra_node=ns['obj'](one),exceeds=exceeds,scenarios=scenarios,
 unchanged_setup=author['seed_setup_unchanged'],scope='Old V10000/N3387 retained; no values, builds or runtime inference')
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=out['checks'],main=tot[2],exceeds=exceeds)))
